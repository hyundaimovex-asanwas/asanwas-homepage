<%--
  - 작성자: 심동현
  - 일자: 2009.02.12
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
　- 	사전예약>예약조회.
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.util.*"%>

<%
String chk_confirm = request.getParameter("chk_confirm");	  // 1 : 회원예약, 2:비회원예약, 3: 관광객 개인로긴


if(chk_confirm.equals("2")){
	//request parameters
	String rmail = request.getParameter("rmail");	//전화번호
	String rpass = request.getParameter("rpass");	//비밀번호



	if (rmail.equals("") || rpass.equals("")){  // 비회원예약임에도 정보가 없는경우
	%>
	    <script language="javascript">
	       alert("예약시 예약시 등록한 정보로 인증해 주십시요.");
	       document.location.href="res_srch1.jsp";
	    </script>
	<%   
	}


	//변수선언
	int cnt = 0;
	
	ReservationInfo dao = new ReservationInfo();
	Reservation_bean[] recordview = dao.getRevUser(rmail, rpass);
	
	int totalCount = recordview.length;
	
	
	   if (totalCount > 0){
	   %>
	       <form name="myform" method="post" action="res_srch2.jsp">
	         <input type="hidden" name="rmail" value="<%=rmail%>">
	         <input type="hidden" name="rpass" value="<%=rpass%>">
	       </form>    
	    <%
	       out.println("<script language='javascript'>document.myform.submit();</script>");
	   
	   }else{
	   
	       out.println("<script language='javascript'>alert('등록된 예약 정보가 없습니다.');history.back();</script>");
	   
	   }

}else if(chk_confirm.equals("3")){
	//request parameters
	String cust_nm 	= request.getParameter("cust_nm");		//전화번호
	String manage_no= request.getParameter("manage_no");	//비밀번호

	if (cust_nm.equals("") || manage_no.equals("")){  //빈 폼인 경우
	%>
	    <script language="javascript">
	       alert("성명 또는 주민번호를 입력하지 않았습니다.");
	       document.location.href="res_srch1.jsp";
	    </script>
	<%   
	}

	//변수선언
	int cnt = 0;
	
	ReservationInfo dao = new ReservationInfo();
	Reservation_bean bean[] = dao.getRevCust(cust_nm, manage_no);

	int	rsv_sid	   = bean[0].getRsv_sid();
	
	
	   if (rsv_sid > 0){
	   %>
	       <form name="myform1" method="post" action="res_print2.jsp">
	         <input type="hidden" name="rsv_sid" value="<%=rsv_sid%>">
	       </form>    
	    <%
	       out.println("<script language='javascript'>document.myform1.submit();</script>");
	   
	   }else{
	   
	       out.println("<script language='javascript'>alert('등록된 예약 정보가 없습니다.');history.back();</script>");
	   
	   }

}

%>