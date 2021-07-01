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
import com.hmm.asan.common.util.WEBConstants;

import com.oreilly.servlet.MultipartRequest;

/**
 * 관리
 */
public class BodoBean {

    private String dirName = WEBConstants.BODOUPLOADDIR;
    private int maxFileSize = WEBConstants.BODOUPLOADMAX;


    /**
     * 리스트
     * @author : Mr.K JM
     * @2005. 10. 10
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {

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

            /*          conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/

            String totalQuery = ("select count(*) count from asan.notice where category = 'report' and isdel = '0' ");
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

            String listQuery = "select idx, title, regtime, hit, status from asan.notice where category = 'report' and isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            String inidx = "";
            for(int i = 0; i < list.size(); i++) {
                HashMap hm = (HashMap)list.get(i);
                inidx += hm.get("IDX");
                if(i < list.size()-1) {
                    inidx += ", ";
                }
            }

            ArrayList filelist = mdao.selectQuery("select idx, boardname, boardidx, file, sysfile, regtime from asan.fileinfo where boardname ='notice' and boardidx in("+inidx+") order by idx desc");
            request.setAttribute("filelist", filelist);

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }




    /**
     * 추가
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("News Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        //String totalQuery = ("SELECT COUNT(*) count FROM asan.notice");
        String totalQuery = ("SELECT MAX(IDX) count FROM asan.notice");
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
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            bean.remove("regday");
            bean.remove("filesize");
            bean.remove("filesizeK");
            bean.remove("filecount");
            bean.remove("file");
            bean.remove("files");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.notice", bean);
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
                        if( name.equals("imgfile") ) {
                            fileBean.put("imgfile", filename);
                            fileBean.put("sysimgfile", sysfilename);

                            //System.out.println("AAAAAAA"+fileBean);
                            mdao.updateQuery("asan.notice", fileBean, " where idx = " + maxNo);
                        } else {
                            fileBean.put("file", filename);
                            fileBean.put("sysfile", sysfilename);

                            fileBean.put("boardname", "notice");
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
                response.setContentType("text/plain");
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다. ")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }

    /**
     * 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 12
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;
        ArrayList filebean = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        String category = "report";

        if(idx == null) idx ="";

        try {
            /**
             * 현재 글 내용
             */
            beans = mdao.selectQuery("select idx, title, summary, content, hit, regtime, imgfile, sysimgfile from asan.notice where category= 'report' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

            /**
             * 글에 등록된 파일 내용 가져오기
             */
            filebean = mdao.selectQuery("select idx, boardname, boardidx, file, sysfile, regtime from asan.fileinfo where boardname = 'notice' and boardidx = '" + idx + "'");
            request.setAttribute("fileread", filebean);


            /**
            *
            * 이전글
            */
           prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A, " +
                   " (select idx from asan.notice where category = '" + category + "' and isdel = 0 and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }

           /**
            *
            * 다음글
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.notice A, " +
                   " (select idx from asan.notice where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
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
     * 수정
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Update(HttpServletRequest request, HttpServletResponse response) {
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

                //System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgfiledel = multi.getParameter("imgfiledel");

            if( imgfiledel != null) {
                bean.put("imgfile", "");
                bean.put("sysimgfile", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());

            bean.remove("regday");
            bean.remove("imgfiledel");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("fileidxlist");
            bean.remove("fileidxdelfg");
            bean.remove("fileidxcheck");

            result = mdao.updateQuery("asan.notice", bean, " where idx = "+idx);
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
                        if( name.equals("imgfile") ) {
                            fileBean.put("imgfile", filename);
                            fileBean.put("sysimgfile", sysfilename);

                            //System.out.println("AAAAAAA"+fileBean);
                            mdao.updateQuery("asan.notice", fileBean, " where idx = " + idx);
                        } else {
                            fileBean.put("file", filename);
                            fileBean.put("sysfile", sysfilename);

                            fileBean.put("boardname", "notice");
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
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB가 이상입니다. ")+"');history.back();</script>");
                out.close();
            } catch(Exception e1){}
        }

        return result;

    }

    /**
     * 삭제
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
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