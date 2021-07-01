package com.hmm.asan.asanway.company;


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
 * admin ceo Message 관리
 */
public class ConstructionBean {


    /**
     * construction 건설사업 리스트
     * @author : ikara
     * @2005. 10. 12
     */

    public void List(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("***** Cyber News List *****");

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        String bunru1 = request.getParameter("bunru1");
        String bunru2 = request.getParameter("bunru2");

        String whereQuery = "";
        if( bunru1 != null ){
            whereQuery += " and  bunru1 = '" + bunru1 + "'";
        }
        if( bunru2 != null ){
            whereQuery += " and  bunru2 = '" + bunru2 + "'";
        }

        PagingHelper helper = new PagingHelper(10, 10);

        try{
            String totalQuery = ("select count(*) as count from asan.construction where 1=1 ");
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


            String listQuery = "select idx,  bunru1, bunru2, title, img_title, s_company, s_scale, sdate, edate, view_yn, reg_date from asan.construction where 1=1 ";
            listQuery += whereQuery;
            listQuery += " order by idx desc";

            list = mdao.selectQuery(listQuery, page, (int)helper.getPagesize());

            request.setAttribute("list", list);
            request.setAttribute("helper", helper);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }



    /**
     * construction 건설사업 등록
     * @author : ikara
     * @2005. 10. 12
     */

    public int Insert(HttpServletRequest request, HttpServletResponse response) {

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String regid	= "";
		//String regname	= "";
        //String reguser = "";
		//String regip = "";

        HttpSession session = request.getSession();


		regid = (String)session.getAttribute("adminid");
		//regname = (String)session.getAttribute("adminname");
		//reguser = (String)session.getAttribute("adminidx");
		//regip = request.getRemoteHost();
		
		String totalQuery = ("SELECT NVL(MAX(SEQ) + 1, 1) as count FROM FROM asan.construction");
        String num = String.valueOf(mdao.getRowCount(totalQuery));
       
        System.out.println(num);

        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap();
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            //bean.put("regtime", request.getParameter("regday") + " " + Utility.getCurrentTime3());
            bean.put("reg_date", request.getParameter("regday") + " " + Utility.getCurrentTime3());
			bean.put("reg_id", regid);
			bean.put("idx", num);
			//bean.put("regname", regname);
			//bean.put("reguser", reguser);
			//bean.put("regip", regip);

			bean.remove("regday");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

           result = mdao.insertQuery("asan.construction", bean);

        }catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            try {
                PrintWriter out = response.getWriter();
                response.setContentType("text/plain");
                out.println("<script>alert('작업도중 오류가 발생했습니다.잠시후에 다시 시도해 주십시오.');history.back();</script>");
                out.close();
            } catch (Exception e1) {}
        }
        return result;
    }

    /**
     * construction 건설사업 read
     * @author : ikara
     * @2005. 10. 12
     */

    public void Read(HttpServletRequest request, HttpServletResponse response){

        MultiDAO mdao = new MultiDAO();
        ArrayList beans = null;

        ArrayList prevBean = null;
        ArrayList nextBean = null;

        //      해당 글의 id 또는 코드 번호
        String idx = request.getParameter("idx");
        //String bunru1 = request.getParameter("bunru1");
        //String bunru2 = request.getParameter("bunru2");
        if(idx == null) idx ="";
        //if(bunru1 == null) bunru1 ="1";
        //if(bunru2 == null) bunru2 ="1";

        try {
            /**
             * 현재 게시물 내용 보기
             */
            //beans = mdao.selectQuery("select idx,  bunru1, bunru2, title, img_title, s_company, s_scale, sdate, edate, view_yn, reg_date from asan.construction where bunru1= "+bunru1+" and bunru2= "+bunru2+" and idx = '" + idx + "'");
            beans = mdao.selectQuery("select idx,  bunru1, bunru2, title, img_title, s_company, s_scale, sdate, edate, view_yn, reg_date from asan.construction where idx = '" + idx + "'");
            HashMap hm = (HashMap)beans.get(0);
            request.setAttribute("read", hm);


            /**
            *
            * 이전글
            */
 /*          prevBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.construction A, " +
                   " (select idx from asan.construction where category = '" + category + "' and isdel = 0 and regtime >'"+ Utility.getDb2Time(hm.get("REGTIME").toString(), 1) +"' order by regtime ASC fetch first 1 rows only) B" +
                   " WHERE A.idx= B.idx");
           if(prevBean != null && prevBean.size() > 0) {
               HashMap h1 = (HashMap)prevBean.get(0);
               request.setAttribute("preview", h1);
           }
*/
           /**
            *
            * 다음글
            */
/*           nextBean = mdao.selectQuery("select A.idx, title, regtime, hit from asan.construction A, " +
                   " (select idx from asan.construction where category = '" + category + "' and isdel = 0 and regtime < '"+ Utility.getDb2Time(hm.get("REGTIME").toString(),0) +"' order by regtime DESC fetch first 1 rows only) B" +
                   " WHERE A.idx = B.idx");
           if(nextBean != null && nextBean.size() > 0) {
               HashMap h2 = (HashMap)nextBean.get(0);
               request.setAttribute("nextview", h2);
           }*/

        }catch(Exception e){
            //e.printStackTrace();
            //System.out.println(e.getMessage());
            try {

    			PrintWriter out = response.getWriter();
    			out.println("<script>alert('"+Utility.en("원하시는 글이 없습니다.")+"');window.location.replace(\""+
    					request.getRequestURI()+"?\");</script>");
    			out.close();
    		} catch(Exception e1){}
        }

    }

    /**
     * construction 건설사업 수정
     * @author : ikara
     * @2005. 10. 12
     */

    public int Update(HttpServletRequest request, HttpServletResponse response) {

        int result = 0;

        String idx = request.getParameter("idx");
        if(idx == null){
            idx = "";
        }

/*        String lastuser = "";
		String lastip = "";*/
        String modifyid = "";

        HttpSession session = request.getSession();

/*        lastuser = (String)session.getAttribute("adminidx");
      	lastip = request.getRemoteHost();*/
        modifyid = (String)session.getAttribute("adminid");

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

            //bean.put("regtime", request.getParameter("regday") + " " + Utility.getCurrentTime3());
        	//bean.put("lastuser", lastuser);
			bean.put("modify_id", modifyid);
			bean.put("modify_date", new Timestamp(System.currentTimeMillis()) );

			bean.remove("regday");
			bean.remove("idx");
            bean.remove("y");
            bean.remove("x");
            bean.remove("cmd");

            result = mdao.updateQuery("asan.construction", bean, " where idx = "+idx);

            request.setAttribute("idx", idx);

        }catch (Exception e) {
            try {
                PrintWriter out = response.getWriter();
                String url = request.getRequestURI()+"?";
                out.println("<script language='javascript'>location.href('"+url+"');</script>");
                out.close();
            } catch(Exception e1){}
        }

        return result;

    }



    /**
     * construction 건설사업 삭제 type 1
     * @author : ikara
     * @2005. 10. 12
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
            /*String lastuser = (String)session.getAttribute("adminidx");
            String lastip = request.getRemoteHost();*/
            
            result = dao.deleteQuery("delete from asan.construction where idx = " + idx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }
}