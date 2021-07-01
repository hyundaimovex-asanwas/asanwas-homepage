package com.hmm.asan.asanway.eng;

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
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;


/**
 * ������ ���� News ����
 */
public class NewsBean {

    private String dirName;
    private int maxFileSize;

    private String category;

    /**
     * @param category
     */
    public NewsBean(String category) {
        this.category = category;
    }


    /**
     * @param dirName
     * @param maxFileSize
     * @param category
     */
    public NewsBean(String dirName, int maxFileSize,String category) {
        this.dirName = dirName;
        this.maxFileSize = maxFileSize;
        this.category = category;
    }

    /**
     * ����Ʈ
     * @author : ikara
     * @2005. 11.17
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** EngNews List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String searchkey = request.getParameter("searchkey");
        String searchvalue = request.getParameter("searchvalue");

        String whereQuery = "";
        if( searchkey != null ){
            whereQuery = " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{
            String totalQuery = ("select count(*) count from asan.notice where category = '"  + category + "' and isdel = '0' ");
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


            String listQuery = "select idx, title, regtime, hit, status from asan.notice where category = '"  + category + "' and isdel = '0' ";
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
     * ���� �߰�
     * @author : ikara
     * @2005. 11.17
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("engNews Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.notice");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }
        int maxNo = Integer.parseInt(count)+1;

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                  if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            // ���ʿ��� ���� ����
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

            // Insert
            result =  mdao.insertQuery("asan.notice", bean);
            if(result > 0 ) {
                Enumeration files = multi.getFileNames();

                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);
                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);

                        mdao.updateQuery("asan.notice", fileBean, " where idx = " + maxNo);
                    }
                }
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * �� ���� ����
     * @author : ikara
     * @2005. 11.17
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("engNews read");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * ���� �Խù� ���� ����
             */
            beans = mdao.selectQuery("select idx, title, summary, content, hit, regtime, imgfile, sysimgfile from asan.notice where  category = '"  + category + "' and isdel = '0' and idx = " + idx );
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);


            /**
            *
            * ������
            */
           prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A, " +
                   " (select idx from asan.notice where category = '" + category + "' and isdel = '0' and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }

           /**
            *
            * ������
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A, " +
                   " (select idx from asan.notice where category = '" + category + "' and isdel = '0' and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
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
     * ���� ����
     * @author : ikara
     * @2005. 11 .17
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("engNews update");
        int result = 0;

        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
            //dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgfiledel = multi.getParameter("imgfiledel");

            if( imgfiledel != null) {
                bean.put("imgfile", "");
                bean.put("sysimgfile", "");
            }

            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("regday");
            bean.remove("imgfiledel");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

            result = mdao.updateQuery("asan.notice", bean, " where idx = "+idx);

            if( result > 0 ) {
                Enumeration files = multi.getFileNames();
                while(files.hasMoreElements()) {
                    String name = (String)files.nextElement();              // fileform name
                    String filename = (multi.getOriginalFileName(name));    // filename
                    String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                    //String ContentType = (multi.getContentType(name));    // file contenttype

                    File f = multi.getFile(name);

                    if( f != null ) {
                        HashMap fileBean = new HashMap();

                        fileBean.put(name , filename);
                        fileBean.put("sys"+name, sysfilename);
                        mdao.updateQuery("asan.notice", fileBean, " where idx = " + idx);
                    }
                }
            }
            request.setAttribute("idx", idx);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;

    }

    /**
     * Update �� isdel = 1 ����
     * @author : ikara
     * @2005. 11. 17
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("engNews Delete");

        String idx = request.getParameter("idx");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.notice set isdel = '1', " +
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