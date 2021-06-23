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
 * �Խ��� Comment
 */
public class CommentBean {

    /**
     * �ۿ� �ش��ϴ� Comment List ��������
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
	 * �ش� Comment ���� - �����ڿ�
	 */
	// CommentDel
	public int CommentDel(HttpServletRequest request, HttpServletResponse response){
        //System.out.println("***** Comment Del *****");

        // ������ Comment �� idx�� ������ �´�.
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
	 * �ش� Comment ���� - ����ڿ�
	 * �ش���� idx�� regid �ʿ��ϴ�.
	 */
	// CommentDel
	public int CommentUserDel(HttpServletRequest request, HttpServletResponse response){
        //System.out.println("***** Comment Front Del *****");

        // ������ Comment �� idx�� ������ �´�.
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
        		// �Է¹��� regid �� commentidx�� �˻��� ����� ������� update�Ѵ�.
        		// result = 1 ����� 1�� ����. ����.
        		result = dao.updateQuery("update asan.comment set isdel = '1' where idx = " + commentidx);
                System.out.println("result = "+ result);
        	} else {
        		// �н����尡 ���� �������
        		result = 0;
        	}

        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return result;
	}	// End ForumCommentList


	/**
	 * �ش� �ۿ� ���ؼ� Comment �߰�
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
	 * �ش� �ۿ� ���ؼ� Comment �߰� - ������
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
     *  Comment ����
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
