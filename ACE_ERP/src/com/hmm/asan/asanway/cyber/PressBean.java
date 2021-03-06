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
public class PressBean {

    private String dirName = WEBConstants.PRESSUPLOADDIR;
    private int maxFileSize = WEBConstants.PRESSUPLOADMAX;


    /**
     * 리스트
     * @author : Mr.K JM
     * @2005. 10. 10
     */
    public void List(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("***** press List *****");

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
            whereQuery += " and " + searchkey + " like '%" + searchvalue + "%'";
        }

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/

            String totalQuery = ("select count(*) count from asan.press where category = 'press' and isdel = '0' ");
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


            String listQuery = "select idx, journal, section,  title, regtime, status from asan.press where category = 'press' and isdel = '0' ";
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
     * 추가
     * @author : Mr.K JM
     * @2005. 10. 11
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("press Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT COUNT(*) count FROM asan.press");
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

                System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.press", bean);
            System.out.println("insert result = " + result);

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

                        System.out.println(fileBean);

                        mdao.updateQuery("asan.press", fileBean, " where idx = " + maxNo);
                    }
                }
            }

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            try {
                PrintWriter out = response.getWriter();
                response.setContentType("text/plain");
                int fileSize = maxFileSize/(1024*1024);
                out.println(e.getMessage());
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }

    /**
     * 글 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 12
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        String category = "press";

        if(idx == null) idx ="";

        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, section, journal, title, summary, content, link, MOVIELINK, imgs,regtime from asan.press where category= 'press' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

            /**
            *
            * 이전글
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
            * 다음글
            */
           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.press A, " +
                   " (select idx from asan.press where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
                   " WHERE A.idx = B.idx");
           if(nextBean != null && nextBean.size() > 0) {
               HashMap h2 = (HashMap)nextBean.get(0);
               request.setAttribute("nextview", h2);
           }

        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 내용 수정
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

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgfiledel = multi.getParameter("imgfiledel");

            if( imgfiledel != null) {
                bean.put("imgs", "");
                bean.put("sysimgs", "");
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

            result = mdao.updateQuery("asan.press", bean, " where idx = "+idx);
            System.out.println("result = " + result);


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

                        System.out.println(fileBean);

                        mdao.updateQuery("asan.press", fileBean, " where idx = " + idx);
                    }
                }
            }

            request.setAttribute("idx", idx);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
            try {
                PrintWriter out = response.getWriter();
                int fileSize = maxFileSize/(1024*1024);
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch(Exception e1){}
        }

        return result;

    }

    /**
     * Update 로 isdel = 1 삭제
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