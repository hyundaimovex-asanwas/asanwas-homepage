package com.hmm.asan.asanway.support;

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
 * Event
 */
public class EventBean {

    private String dirName = WEBConstants.EVNET_UPLOADDIR;
    private int maxFileSize = WEBConstants.EVENT_UPLOADMAX;


    /**
     * 리스트
     * List(request, response, category);
     * @author : Mr.K JM
     * @ 2005. 10. 21
     */
    public void List(HttpServletRequest request, HttpServletResponse response, String category) {

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

            /*	        conn = UtilDB.getConnection("jdbc/asan");
             pstmt = conn.prepareStatement("SELECT * FROM SYSIBM.SYSVIEWS");
             rs   = pstmt.executeQuery();*/

            String totalQuery = ("select count(*) count from asan.event where category = '"+category+"' and isdel = '0' ");
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


            String listQuery = "select idx, title, startdate, enddate, regtime, progress, hit, status from asan.event where category = '"+category+"' and isdel = '0' ";
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
     * @2005. 10. 21
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("News Insert");

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        //String totalQuery = ("SELECT COUNT(*) count FROM asan.notice");
        String totalQuery = ("SELECT COUNT(IDX) count FROM asan.event");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());


            String category = multi.getParameter("category");

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);

            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            bean.remove("startyear");
            bean.remove("startmonth");
            bean.remove("startday");
            bean.remove("endyear");
            bean.remove("endmonth");
            bean.remove("endday");

            // Insert
            result =  mdao.insertQuery("asan.event", bean);
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

                        mdao.updateQuery("asan.event", fileBean, " where idx = " + maxNo);
                    }
                }
            }

            request.setAttribute("category", category);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * 글 내용 보기
     * @author : Mr.K JM
     * @2005. 10. 21
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        String category = request.getParameter("category");
        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, title, startdate, enddate, img, sysimg, content, regtime from asan.event where category= '"+category+"' and isdel = 0 and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
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

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            String category = multi.getParameter("category");

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(5, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgdel = multi.getParameter("imgdel");

            if( imgdel != null) {
                bean.put("img", "");
                bean.put("sysimg", "");
            }

            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());


            bean.remove("regday");
            bean.remove("imgdel");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("startyear");
            bean.remove("startmonth");
            bean.remove("startday");
            bean.remove("endyear");
            bean.remove("endmonth");
            bean.remove("endday");


            result = mdao.updateQuery("asan.event", bean, " where idx = "+idx);
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

                        mdao.updateQuery("asan.event", fileBean, " where idx = " + idx);
                    }
                }
            }

            request.setAttribute("idx", idx);
            request.setAttribute("category", category);

        }catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
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
        String category = request.getParameter("category");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.event set isdel = '1', " +
                            " lastuser='"+ adminidx +"', " +
                            " lasttime = CURRENT TIMESTAMP , " +
                            " lastip = '" + (String)request.getRemoteHost() + "' "+
                            " where idx = " + idx);

            request.setAttribute("category", category);
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }


}