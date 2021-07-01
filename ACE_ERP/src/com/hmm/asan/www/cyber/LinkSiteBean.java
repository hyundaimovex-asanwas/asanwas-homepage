package com.hmm.asan.www.cyber;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;
import com.hmm.asan.common.util.PagingHelper;
import com.hmm.asan.common.util.Utility;


/**
 * 관리자  - 관련사이트 관리
 */
public class LinkSiteBean {

    /**
     * 관련 사이트 리스트
     * @author : ikara
     * @2005. 10. 26
     */
    public void List(HttpServletRequest request, HttpServletResponse response, String cateidx) {
        System.out.println("***** LinkSite List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        try{
            String query = "SELECT idx, sitename, siteurl  FROM asan.linksite WHERE cateidx = " + cateidx + " AND isdel = '0' ORDER BY idx ASC" ;

            list = mdao.selectQuery(query);
            request.setAttribute("list", list);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Admin User List2 *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String cateidx = request.getParameter("cateidx");

        String whereQuery = "";
        if( cateidx == null || cateidx.equals("")){}
       else{
            whereQuery = " AND cateidx = " + cateidx;
        }

        PagingHelper helper = new PagingHelper(5, 10);

        try{
            String totalQuery = "SELECT COUNT(*) count FROM asan.linksite WHERE isdel = '0'";
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

            String listQuery = " SELECT A.idx, A.sitename, A.siteurl, B.name categoryname  FROM asan.linksite A, asan.lscategory B " +
									" WHERE  A.isdel = '0' AND A.cateidx = B.idx" ;
            listQuery += whereQuery;
            listQuery += " order by idx ASC";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    /**
     *  관련 사이트 등록
     * @author : ikara
     * @2005. 10. 26
     */

    public int Insert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** LinkSite insert *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        HttpSession session = request.getSession();

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

			bean.put("reguser", session.getAttribute("adminidx"));
			bean.put("regip", request.getRemoteHost());

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

           result = mdao.insertQuery("asan.linksite", bean);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * Read
     * @author : ikara
     * @2005. 10. 26
     */
    public void Read(HttpServletRequest request, HttpServletResponse response){
        System.out.println("linksite Read");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        String idx = request.getParameter("idx");
        if(idx == null) idx ="";
        try {
            /**
             *
             * 글정보
             */
            beans = mdao.selectQuery("select idx, sitename,siteurl  from asan.linksite where isdel = '0' and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }


    /**
     * 관련 사이트 수정
     * @author : ikara
     * @2005. 10. 26
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** LinkSite update *****");

        int result = 0;
        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        HttpSession session = request.getSession();
        MultiDAO mdao = new MultiDAO();

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

        	bean.put("lastuser", session.getAttribute("adminidx"));
			bean.put("lastip", request.getRemoteHost());
			bean.put("lasttime", new Timestamp(System.currentTimeMillis()) );

			bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("cateidx");

            result = mdao.updateQuery("asan.linksite", bean, " where idx = "+idx);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }



    /**
     * 관련 사이트 삭제
     * @author : ikara
     * @2005. 10. 26
     */
    public int DeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** LinkSite Delete *****");

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

            result = dao.updateQuery("update asan.linksite set isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp where idx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }


    /**
     * 카테고리 리스트
     * @author : ikara
     * @2005. 10. 26
     */
    public void CateList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** LinkSite CateList *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        try{
            String listQuery = "select idx, name from asan.lscategory where  isdel = '0' ";
            listQuery += " order by idx ASC";

            list = mdao.selectQuery(listQuery);

            request.setAttribute("catelist", list);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     *  카테고리  등록
     * @author : ikara
     * @2005. 10. 26
     */

    public int CateInsert(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** LinkSite insert *****");
        MultiDAO mdao = new MultiDAO();

        int result = 0;
        HttpSession session = request.getSession();

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

			bean.put("reguser", session.getAttribute("adminidx"));
			bean.put("regip", request.getRemoteHost());

            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("cateidx");

           result = mdao.insertQuery("asan.lscategory", bean);
           request.setAttribute("cateidx", request.getParameter("cateidx"));

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

    /**
     * 카테고리  read
     * @author : ikara
     * @2005. 10. 26
     */

    public void CateRead(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Category Read *****");
        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        //      해당 글의 id 또는 코드 번호
        String idx = request.getParameter("idx");
        if(idx == null) idx ="";

        try {
            /**
             * 현재 게시물 내용 보기
             */
            beans = mdao.selectQuery("select name from asan.lscategory where  isdel = '0' and idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);

        }catch(Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }


    /**
     *카테고리  수정
     * @author : ikara
     * @2005. 10. 26
     */

    public int CateUpdate(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Category update *****");

        int result = 0;
        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

        HttpSession session = request.getSession();
        MultiDAO mdao = new MultiDAO();

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

        	bean.put("lastuser", session.getAttribute("adminidx"));
			bean.put("lastip", request.getRemoteHost());
			bean.put("lasttime", new Timestamp(System.currentTimeMillis()) );

			bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");
            bean.remove("cateidx");

            result = mdao.updateQuery("asan.lscategory", bean, " where idx = "+idx);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }


    /**
     * 카테고리 삭제
     * @author : ikara
     * @2005. 10. 26
     */
    public int CateDeleteUpdate(HttpServletRequest request, HttpServletResponse response){
        System.out.println("***** Category Delete *****");

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

            result = dao.updateQuery("update asan.lscategory set isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp where idx = " + idx);

            //관련사이트 모두 삭제
            if(result > 0 ){
                dao.updateQuery("update asan.linksite set isdel = '1', lastuser='"+ lastuser +"', lastip = '"+ lastip +"', lasttime=current timestamp where cateidx = " + idx);
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}