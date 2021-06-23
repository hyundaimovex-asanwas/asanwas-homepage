package com.hmm.asan.asanway.cyber;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.AsanFileRenamePolicy;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;

import com.oreilly.servlet.MultipartRequest;


/**
 * ������  -�ڷ�� ����
 */
public class PdsBean {

    private String dirName;
    private int maxFileSize;

    private String category;

    /**
     * @param category
     */
    public PdsBean(String category) {
        this.category = category;
    }


    /**
     * @param dirName
     * @param maxFileSize
     * @param category
     */
    public PdsBean(String dirName, int maxFileSize,String category) {
        this.dirName = dirName;
        this.maxFileSize = maxFileSize;
        this.category = category;
    }

    /**
     * ����Ʈ
     * @author : ikara
     * @2005. 10. 20
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Pds List");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");
        String section = request.getParameter("section");

        String whereQuery = "";
        if( section != null && !section.equals("")){
            whereQuery = " and section = '" + section + "'";
        }

        if( searchkey != null ){
            whereQuery  += " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            String totalQuery = ("select count(*) count from asan.press where category = '"  + category + "' and isdel = '0' ");
            totalQuery += whereQuery;
            int num = mdao.getRowCount(totalQuery);

            helper.setTotalcount(num);

            String selectPage = request.getParameter("page");
            int page = 0;
            if(selectPage == null || selectPage.equals("")) {
                page = 1;
            }else{
                page = Integer.parseInt(selectPage);
            }

            helper.setCurpage(page);
            helper.setPageNav();

            ArrayList filelist = null;
            String fileQuery = "select idx, boardidx, file, sysfile from asan.fileinfo where boardname = 'press' AND category='" + category +  "'" ;
            filelist = mdao.selectQuery(fileQuery);
            request.setAttribute("filelist", filelist);

            String listQuery = "select idx, section, title, regtime, hit, status from asan.press where category = '"  + category + "' and isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * ���
     * @author : ikara
     * @2005. 10. 20
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Pds  Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.press");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);
            //System.out.println("dirname = " + dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            //�����
            String regtime = multi.getParameter("regday") + " " + Utility.getCurrentTime3();

            Enumeration params = multi.getParameterNames();
            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                //System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", regtime);
            bean.put("regip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("regday");
            bean.remove("filesize");
            bean.remove("filesizeK");
            bean.remove("filecount");
            bean.remove("file");
            bean.remove("files");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.press", bean);
            //System.out.println("insert result = " + result);


            if(result > 0 ) {
                Enumeration files = multi.getFileNames();

                while (files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    //System.out.println("name = " + name);
                    //System.out.println("filename = " + filename);

                    File f = multi.getFile(name);

                    if( f != null ) {

                        HashMap fileBean = new HashMap();
                        if( name.equals("imgs") ) {
                            fileBean.put("imgs", filename);
                            fileBean.put("sysimgs", sysfilename);

                            //System.out.println("AAAAAAA"+fileBean);
                            mdao.updateQuery("asan.press", fileBean, " where idx = " + maxNo);
                        } else {
                            fileBean.put("file", filename);
                            fileBean.put("sysfile", sysfilename);

                            fileBean.put("boardname", "press");
                            fileBean.put("category", category  );
                            fileBean.put("boardidx", maxNo+ "");

                            // System.out.println("BBBBBBBB"+fileBean);
                            mdao.insertQuery("asan.fileinfo", fileBean);
                        }
                    }
                }
            }
        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("���� ũ�Ⱑ ")+fileSize+Utility.en("MB�� �Ѿ����ϴ�.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }

    /**
     * Read
     * @author : ikara
     * @2005. 10. 20
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Pds Read");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList filebean = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             *
             * ������
             */
            beans = mdao.selectQuery("select idx, section, title, summary, content, hit, regtime, imgs, sysimgs from asan.press where category = '" + category + "' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);
             /**
             *
             *÷������ ����
             */
            filebean = mdao.selectQuery("select idx, boardname, boardidx, file, sysfile, regtime from asan.fileinfo where boardname = 'press' and category = '" + category + "' and boardidx = '" + idx + "'");
            request.setAttribute("fileread", filebean);

            /**
            *
            * ������
            */
           prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.press A, " +
                   " (select idx from asan.press where category = '" + category + "' and isdel = 0 and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }

           /**
            *
            * ������
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.press A, " +
                   " (select idx from asan.press where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
                   " WHERE A.idx = B.idx");
           if(nextBean != null && nextBean.size() > 0) {
               HashMap h2 = (HashMap)nextBean.get(0);
               request.setAttribute("nextview", h2);
           }

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     *
     * ����
     * @author : ikara
     * @2005. 10. 20
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("Pds Update");

        int result = 0;
        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            String regtime = multi.getParameter("regday") + " " + Utility.getCurrentTime3();	//�����

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                //System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgsdel = multi.getParameter("imgsdel");

            if( imgsdel != null) {
                bean.put("imgs", "");
                bean.put("sysimgs", "");
            }

            bean.put("regtime", regtime);
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("cmd");
            bean.remove("regday");
            bean.remove("imgsdel");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("fileidxlist");
            bean.remove("fileidxdelfg");
            bean.remove("fileidxcheck");

            result = mdao.updateQuery("asan.press", bean, " where idx = "+idx);
            //System.out.println("result = " + result);

            String fileidxlist[] = multi.getParameterValues("fileidxlist");
            String filedelfg[] = multi.getParameterValues("fileidxdelfg");

            for(int i = 0; fileidxlist != null && i < fileidxlist.length; i++) {
                //System.out.println(fileidxlist[i] + " = del : " + filedelfg[i]);
                if(filedelfg[i].equals("1") ) {
                    mdao.deleteQuery("delete from asan.fileinfo where idx =  " + fileidxlist[i] );
                }
            }

            if(result > 0 ) {
                Enumeration files = multi.getFileNames();

                while (files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    //System.out.println(name + " = " + filename);

                    File f = multi.getFile(name);

                    if( f != null ) {

                        HashMap fileBean = new HashMap();
                        if( name.equals("imgs") ) {
                            fileBean.put("imgs", filename);
                            fileBean.put("sysimgs", sysfilename);

                            //System.out.println("AAAAAAA"+fileBean);
                            mdao.updateQuery("asan.press", fileBean, " where idx = " + idx);
                        } else {
                            fileBean.put("file", filename);
                            fileBean.put("sysfile", sysfilename);

                            fileBean.put("boardname", "press");
                            fileBean.put("category", category);
                            fileBean.put("boardidx", idx+ "");

                            //System.out.println("BBBBBBBB"+fileBean);
                            mdao.insertQuery("asan.fileinfo", fileBean);
                        }
                    }
                }
            }
            //System.out.println("idx = "+ idx);
            request.setAttribute("idx", idx);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("���� ũ�Ⱑ ")+fileSize+Utility.en("MB�� �Ѿ����ϴ�.")+"');history.back();</script>");
                out.close();
            } catch(Exception e1){}
        }

        return result;

    }

    /**
     * ����
     * @author : ikara
     * @2005. 10. 20
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("Pds DeleteUpdate");

        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.press set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}