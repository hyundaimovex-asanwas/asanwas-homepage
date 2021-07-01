package com.hmm.asan.asanway.company;

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
 * 관리자 사회공헌뉴스 관리
 */
public class NewsBean {

    private String dirName = WEBConstants.CEOTRENDUPLOADDIR;
    private int maxFileSize = WEBConstants.CEOTRENDUPLOADMAX;


    /**
     * 관리자 사회공헌뉴스 리스트
     * @author : 위즈그룹 이두희
     * @2009. 04. 07
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

        System.out.println(whereQuery);

        PagingHelper helper = new PagingHelper(10, 10);
        try{

            String totalQuery = ("select count(*) count from asan.ceotrend where category = 'news' and isdel = '0' ");
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

            System.out.println(totalQuery);

            String listQuery = "select idx, title, content, sysimg1, sysimg2, sysimg3, regtime, hit, status from asan.ceotrend where category = 'news' and isdel = '0' ";
            listQuery += whereQuery;
            listQuery += " order by regtime desc";
            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }

    }


    /**
     * 관리자 사회공헌뉴스 등록
     * @author : 위즈그룹 이두희
     * @2009. 04. 07
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Ceo 동정 insert *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT MAX(IDX) count FROM asan.ceotrend");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }
        System.out.println(count);
        int maxNo = Integer.parseInt(count)+1;
        System.out.println(" No : " + maxNo);
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

            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regid", session.getAttribute("adminid") );
            bean.put("regname", session.getAttribute("adminname") );

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");

            // Insert
            result =  mdao.insertQuery("asan.ceotrend", bean);
            System.out.println("insert result = " + result);

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

                        System.out.println(filename);

                        mdao.updateQuery("asan.ceotrend", fileBean, " where idx = " + maxNo);
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
                out.println("<script>alert('"+("파일 크기가 ")+fileSize+Utility.en("MB를 넘었습니다.")+"');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }


    /**
     * 관리자 사회공헌뉴스 read
     * @author : 위즈그룹 이두희
     * @2009. 04. 07
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select idx, title, content, img1,sysimg1, img2, sysimg2, img3, sysimg3, regtime, hit, status from asan.ceotrend where category= 'news' and isdel = '0' and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    /**
     * 관리자 사회공헌뉴스 수정
     * @author : 위즈그룹 이두희
     * @2009. 04. 07
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {
        int result = 0;

        MultiDAO mdao = new MultiDAO();

        try {
            HttpSession session = request.getSession();
           // dirName = session.getServletContext().getRealPath(dirName);

            MultipartRequest multi = new MultipartRequest(request, dirName, maxFileSize, "EUC-KR", new AsanFileRenamePolicy());

            String idx = multi.getParameter("idx");
            String page = multi.getParameter("page");

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

           //기존 파일  삭제
            String imgdel1 = multi.getParameter("imgdel1");
            String imgdel2 = multi.getParameter("imgdel2");
            String imgdel3 = multi.getParameter("imgdel3");

            if( imgdel1 != null) {
                bean.put("img1", "");
                bean.put("sysimg1", "");
            }

            if( imgdel2 != null) {
                bean.put("img2", "");
                bean.put("sysimg2", "");
            }

            if( imgdel3 != null) {
                bean.put("img3", "");
                bean.put("sysimg3", "");
            }

            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());

            bean.remove("regday");
            bean.remove("imgdel1");
            bean.remove("imgdel2");
            bean.remove("imgdel3");
            bean.remove("idx");
            bean.remove("page");
            bean.remove("y");
            bean.remove("x");

            result = mdao.updateQuery("asan.ceotrend", bean, " where idx = "+idx);
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

                        mdao.updateQuery("asan.ceotrend", fileBean, " where idx = " + idx);
                    }
                }
            }

            request.setAttribute("idx", idx);
            request.setAttribute("page", page);

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
     * 관리자 사회공헌뉴스 삭제 - Update 로 isdel = 1 삭제
     * @author : 위즈그룹 이두희
     * @2009. 04. 07
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        //
        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();

            result = dao.updateQuery("update asan.ceotrend set isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp where idx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}


