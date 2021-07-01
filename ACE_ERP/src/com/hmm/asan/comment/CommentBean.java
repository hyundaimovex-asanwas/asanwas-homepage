package com.hmm.asan.comment;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hmm.asan.common.dao.MultiDAO;


/**
 * 게시판 Comment
 */
public class CommentBean {

    /**
     * 글에 해당하는 Comment List 가져오기
     */
	//	CommentList
	public void CommentList(HttpServletRequest request, HttpServletResponse response, String boardname){
		//System.out.println("***** Comment List *****");

		MultiDAO mdao = new MultiDAO();

		//boardname = request.getParameter("boardname");
		if(boardname == null && boardname == "") boardname = "";

		String boardidx = request.getParameter("idx");
		if (boardidx == null && boardidx == "") boardidx = "0";
		//System.out.println(boardidx + "=====" +boardname);
		try {
			ArrayList list = null;

			list = mdao.selectQuery("select idx, regid, regname, comment, regtime, reguser, regip from asan.comment where isdel = 0 and boardname = '" + boardname + "' and boardidx = '"+ boardidx +"' order by regtime");	// order by commentidx desc

			request.setAttribute("commentlist", list);

		}catch(Exception e){
			e.printStackTrace();
            System.out.println(e.getMessage());
		}
	}	// End ForumCommentList

	/**
	 * 해당 Comment 삭제 - 관리자용
	 */
	// CommentDel
	public int CommentDel(HttpServletRequest request, HttpServletResponse response){
        //System.out.println("***** Comment Del *****");

        // 삭제할 Comment 의 idx를 가지고 온다.
        String commentidx = request.getParameter("commentidx");
        if(commentidx == null){
            commentidx = "";
        }

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {

        result = dao.updateQuery("update asan.comment set isdel = '1' where idx = " + commentidx);

        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
	}	// End ForumCommentList

	/**
	 * 해당 Comment 삭제 - 사용자용
	 * 해당글의 idx와 regid 필요하다.
	 */
	// CommentDel
	public int CommentUserDel(HttpServletRequest request, HttpServletResponse response){
        //System.out.println("***** Comment Front Del *****");

        // 삭제할 Comment 의 idx를 가지고 온다.
        String commentidx = request.getParameter("commentidx");
        if(commentidx == null){
            commentidx = "";
        }

        String boardidx = request.getParameter("boardidx");
        if(boardidx == null){
            boardidx = "";
        }

        String regid = request.getParameter("regid");
        if(regid == null) regid = "";

        MultiDAO dao = new MultiDAO();
        int result = 0;

        try {

        	ArrayList al = dao.selectQuery("select regid, reguser from asan.comment where isdel = '0' and idx = " + commentidx);
        	HashMap hm = (HashMap)al.get(0);

        	if(hm.get("REGID").equals(regid)) {
        		// 입력받은 regid 와 commentidx로 검색한 결과가 같은경우 update한다.
        		// result = 1 결과는 1을 리턴. 정상.
        		result = dao.updateQuery("update asan.comment set isdel = '1' where idx = " + commentidx);
                System.out.println("result = "+ result);
        	} else {
        		// 패스워드가 같지 않은경우
        		result = 0;
        	}

        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
	}	// End ForumCommentList


	/**
	 * 해당 글에 대해서 Comment 추가
	 */
	//CommentAdd
	public int CommentAdd(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Comment - ADD");
		MultiDAO dao = new MultiDAO();
        int result = 0;
        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap(5);

            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.trim().equals(""))
                	bean.put(name, value);
            } // end while

            HttpSession session = request.getSession();
            //bean.put("regid", session.getAttribute("id"));
            //bean.put("regname", session.getAttribute("name"));

            bean.put("regid", session.getAttribute("memberid"));
            bean.put("regname", session.getAttribute("membername"));
            bean.put("reguser", session.getAttribute("memberidx"));;

            bean.put("regip", request.getRemoteHost());
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));

            bean.remove("cmd");
            bean.remove("x");
            bean.remove("y");

            result = dao.insertQuery("asan.comment", bean);

        } catch (Exception e) {
            e.printStackTrace();
        } // end try catch

        return result;
	}	// end CommentAdd


	/**
	 * 해당 글에 대해서 Comment 추가 - 관리자
	 * 2005.10.25 add by ikara
	 */
	//CommentAdd
	public int CommentAddAdmin(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("Comment - ADD-Admin");
		MultiDAO dao = new MultiDAO();
        int result = 0;
        try {
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap(5);

            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.trim().equals(""))
                	bean.put(name, value);
            } // end while

            HttpSession session = request.getSession();
            bean.put("regid", session.getAttribute("adminid"));
            bean.put("regname", session.getAttribute("adminname"));

            bean.put("regip", request.getRemoteHost());
            bean.put("regtime", new Timestamp(System.currentTimeMillis()));

            bean.remove("cmd");
            bean.remove("x");
            bean.remove("y");

            result = dao.insertQuery("asan.comment", bean);

        } catch (Exception e) {
            e.printStackTrace();
        } // end try catch

        return result;
	}	// end CommentAdd


    /**
     *  Comment 수정
     */
    //CommentAdd
    public int CommentUpdate(HttpServletRequest request, HttpServletResponse response) {
        MultiDAO dao = new MultiDAO();
        int result = 0;
        try {
            String idx = request.getParameter("idx");
            Enumeration params = request.getParameterNames();

            HashMap bean = new HashMap(5);

            while (params.hasMoreElements()) {
                String name = (String)params.nextElement();
                String value = request.getParameter(name);

                if(value != null && !value.trim().equals(""))
                    bean.put(name, value);
            } // end while

            HttpSession session = request.getSession();
            //bean.put("regid", session.getAttribute("id"));
            //bean.put("regname", session.getAttribute("name"));
            //bean.put("reguser", session.getAttribute("id"));

            bean.remove("cmd");
            bean.remove("x");
            bean.remove("y");
            bean.remove("idx");
System.out.println(bean);
            result = dao.updateQuery("asan.comment", bean, " where idx = "+ idx);

        } catch (Exception e) {
            e.printStackTrace();
        } // end try catch

        return result;
    }   // end CommentAdd
}
