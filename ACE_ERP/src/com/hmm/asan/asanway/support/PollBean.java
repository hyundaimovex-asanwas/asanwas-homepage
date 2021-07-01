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
 * 고객지원
 */
public class PollBean {

    private String dirName = WEBConstants.POLL_UPLOADDIR;
    private int maxFileSize = WEBConstants.POLL_UPLOADMAX;


    /**
     * 리스트
     * List(request, response, category);
     * @author : Mr.K JM
     * @ 2005. 10. 21
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

            String totalQuery = ("select count(*) count from asan.poll where isdel = '0' ");
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


            String listQuery = "select idx, title, startdate, enddate, regtime, status from asan.poll where isdel = '0' ";
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
     * @2005. 11. 03
     */
    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT COUNT(IDX) count FROM asan.poll");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;
        System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();
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

            bean.put("reguser", session.getAttribute("adminidx"));
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("regip", request.getRemoteHost());

            String startdate = multi.getParameter("startdate");
            if( startdate.length() > 8) {
                startdate = startdate.substring(0,4) + startdate.substring(5,7) + startdate.substring(8, 10);
            }
            String enddate = multi.getParameter("enddate");
            if( enddate.length() > 8) {
                enddate = enddate.substring(0,4) + enddate.substring(5,7) + enddate.substring(8, 10);
            }

            bean.put("startdate", startdate);
            bean.put("enddate", enddate);

            // 불필요한 내용 삭제
            bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            bean.remove("item1");
            bean.remove("item2");
            bean.remove("item3");
            bean.remove("item4");

            // Insert
            System.out.println(bean);
            result =  mdao.insertQuery("asan.poll", bean);
            //System.out.println("insert result = " + result);


            /*Enumeration files = multi.getFileNames();
            while(files.hasMoreElements()) {
                String name = (String)files.nextElement();
            }*/

        	for(int i=1 ; i < 5 ; i++){
        	    String name = "file" + i;              // fileform name
                String filename = multi.getOriginalFileName(name);    // filename
                String sysfilename = multi.getFilesystemName(name);   // sysfilename
                //String ContentType = (multi.getContentType(name));    // file contenttype
                String item = multi.getParameter("item"+i);

                File f = multi.getFile(name);

                HashMap fileBean = new HashMap();
                fileBean.put("item", item);
                fileBean.put("pollidx", maxNo+ "");

                if( f != null ) {
                    fileBean.put("img", filename);
                    fileBean.put("sysimg", sysfilename);
                }

                if( !item.trim().equals("") && item != null) {
                    System.out.println(fileBean);
                    mdao.insertQuery("asan.pollitem", fileBean);
                }
            }
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
        ArrayList readbean = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        String category = request.getParameter("category");
        try {
            /**
             * 현재 게시물 내용 보기
             */
            readbean = mdao.selectQuery("select a.idx, b.idx itemidx, a.title, a.startdate, a.enddate, a.status, a.regtime, b.item, b.img, b.sysimg, b.hit " +
                    " from asan.poll a, asan.pollitem b where a.idx = b.pollidx and a.idx = '"+idx+"'");
            request.setAttribute("readitem", readbean);

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
            System.out.println("idx = " + idx);

            Enumeration params = multi.getParameterNames();

            HashMap bean = new HashMap(5, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = multi.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());
            bean.put("regtime", multi.getParameter("regday") + " " + Utility.getCurrentTime3());

            String startdate = multi.getParameter("startdate");
            if( startdate.length() > 8) {
                startdate = startdate.substring(0,4) + startdate.substring(5,7) + startdate.substring(8, 10);
            }
            String enddate = multi.getParameter("enddate");
            if( enddate.length() > 8) {
                enddate = enddate.substring(0,4) + enddate.substring(5,7) + enddate.substring(8, 10);
            }

             bean.put("startdate", startdate);
            bean.put("enddate", enddate);

            bean.remove("regday");
            bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("fileidxlist");
            bean.remove("fileidxdelfg");
            bean.remove("fileidxcheck");
            bean.remove("item1");
            bean.remove("item2");
            bean.remove("item3");
            bean.remove("item4");

            System.out.println(bean);
            result = mdao.updateQuery("asan.poll", bean, " where idx = "+idx);
            System.out.println("result = " + result);


            /**
             * 이미지 파일 삭제, 내용 (item) 수정
             */
            String fileidxlist[] = multi.getParameterValues("fileidxlist");
            String filedelfg[] = multi.getParameterValues("fileidxdelfg");

            for(int i = 0; fileidxlist != null && i < fileidxlist.length; i++) {

                if(filedelfg[i].equals("1") ) {
                    mdao.updateQuery("update asan.pollitem set img = '', sysimg = '' where idx =  " + fileidxlist[i] );
                }
            }

            int k = 0;
            for(int i=1; i < 5 ; i++){
                String name = "file" + i;              // fileform name
                String filename = (multi.getOriginalFileName(name));    // filename
                String sysfilename = (multi.getFilesystemName(name));   // sysfilename
                //String ContentType = (multi.getContentType(name));    // file contenttype
                String item = multi.getParameter("item"+i);
                File f = multi.getFile(name);

                HashMap fileBean = new HashMap();
                fileBean.put("item", item);
                fileBean.put("pollidx", idx);

                if( f != null ) {
                    fileBean.put("img", filename);
                    fileBean.put("sysimg", sysfilename);
                }


                if( fileidxlist[k] != null && !fileidxlist[k].equals("") ) {
                    mdao.updateQuery("asan.pollitem", fileBean, "where idx = " + fileidxlist[k] );
                } else {
                    mdao.insertQuery("asan.pollitem", fileBean);
                }
                k++;


                System.out.println(fileBean);



            }

            System.out.println("zzz");
            request.setAttribute("idx", idx);


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

            result = dao.updateQuery("update asan.poll set isdel = '1', " +
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


    public int UpdateStatus(HttpServletRequest request, HttpServletResponse response){
        String idx = request.getParameter("idx");
        String status = request.getParameter("status");

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {
            HttpSession session = request.getSession();
            String adminidx = (String)session.getAttribute("adminidx");

            result = dao.updateQuery("update asan.notice set status = '"+status+"', " +
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