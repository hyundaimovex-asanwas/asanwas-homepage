package com.hmm.asan.www.support;


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
public class EventJoinBean {

/**
 * 이벤트1 참여자 리스트
 * @author : Mr.K JM
 * void
 * @param request
 * @param response
 * @param category
 */
    public void List(HttpServletRequest request, HttpServletResponse response, String category) {

        MultiDAO mdao = new MultiDAO();
        ArrayList list = null;

        PagingHelper helper = new PagingHelper(7, 10);
        try{
            String totalQuery = ("select count(*) count from asan.event where category = '"+category+"' and isdel = '0' ");
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


            String listQuery = "select a.idx, a.title, a.regtime, a.hit, b.name " +
                    "   from asan.event a, asan.member b " +
                    "   where a.reguser = b.idx and a.category = '"+category+"' and a.isdel = '0' ";
            listQuery += " order by a.idx desc";
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

        MultiDAO mdao = new MultiDAO();

        int result = 0;

        String totalQuery = ("SELECT COUNT(IDX) count FROM asan.event");
        String count = String.valueOf(mdao.getRowCount(totalQuery));

        if(count.equals("null")){
            count = "1";
        }

        int maxNo = Integer.parseInt(count)+1;
        //System.out.println(" No : " + maxNo);
        try {
            HttpSession session = request.getSession();


            String category = request.getParameter("category");

            Enumeration params = request.getParameterNames();
            HashMap bean = new HashMap(10, 5);
            while (params.hasMoreElements()) {

                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                System.out.println(name + " ==> " + value);
                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            bean.put("reguser", session.getAttribute("memberidx"));
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));
            bean.put("regip", request.getRemoteHost());

            // 불필요한 내용 삭제
            bean.remove("y");
            bean.remove("x");


            ArrayList aaa = mdao.selectQuery("select * from asan.event where isdel = 0 and category = 'openevent2' AND date(regtime) = current date and reguser = '"+session.getAttribute("memberidx")+"' ");
            if( aaa.size() == 0 ) {
                // 입력된 값이 없으면
                System.out.println(bean);
                result =  mdao.insertQuery("asan.event", bean);
                System.out.println("insert result = " + result);
            } else {
                result = -1;
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
            beans = mdao.selectQuery("select a.idx, a.title, a.content, a.regtime, a.hit, b.name " +
                    "   from asan.event a, asan.member b " +
                    "   where a.reguser = b.idx and a.isdel = '0' and a.idx = '"+idx+"'");
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

            String idx = request.getParameter("idx");
            String category = request.getParameter("category");

            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap(5, 5);
            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                System.out.println(name +" = " + value );

                if(value != null && !value.equals(""))
                    bean.put(name, value);
            }

            String imgdel = request.getParameter("imgdel");

            if( imgdel != null) {
                bean.put("img", "");
                bean.put("sysimg", "");
            }

            bean.put("lastuser", session.getAttribute("adminidx"));
            bean.put("lasttime", new Timestamp(System.currentTimeMillis()));
            bean.put("lastip", request.getRemoteHost());


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


     /**
     * 이벤트3 당첨자 체크
     * @author : ikara
     * @date 2005.11.18
     */

    public int Event3Result(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO mdao = new MultiDAO();
        int result = 0;				//꽝 ,  1:당첨, -1:로그인 정보 없음, check값 없음

        try{
            HttpSession session = request.getSession();
			String memberidx = (String)session.getAttribute("memberidx");
			String winvalue  = request.getParameter("check");	//0:꽝, 1:당첨

			  //1. 로그인 체크
			 if(memberidx == null || memberidx.trim().equals("") || memberidx.equals("null")){
			       return result = -1;					//로그인 하지 않음
		     }

			  //2. 당첨 결과값 체크
			 if(winvalue == null || winvalue.trim().equals("") || winvalue.equals("null")){
			       return result = -2;					//check값 없음
		     }

            //3. 1일 5명 제한 체크
			String query = "SELECT COUNT(*) FROM asan.event WHERE  category = 'openevent3' AND date(regtime) = current date ";
			result = mdao.getRowCount(query);
			if(result >= 5){
			    return result = -3;
			}

            //4. 당첨중복 확인
			query = "SELECT COUNT(*) FROM asan.event WHERE  category = 'openevent3' AND reguser = " + memberidx  ;
			int result2 = mdao.getRowCount(query);
			if(result2> 0){
			    return result = -4;
			}

			//5.당첨일 경우 당첨자 정보 DB저장
			if(winvalue.equals("1")){
    			int result3 = mdao.insertQuery("INSERT INTO  asan.event (category, reguser) VALUES ('openevent3', " + memberidx + ")");
    			if(result3 == 0){	//DB저장 실패
    			    return result;
    			}
			}

            //6.당첨 결과 값 리턴
			result = Integer.parseInt(winvalue);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        }
        return result;
    }

}