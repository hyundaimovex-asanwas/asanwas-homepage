<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//관광상품 코드
	String saup_sid = request.getParameter("saup_sid");					//관광지 코드
	String start_ymd = request.getParameter("start_ymd");				//출발일자
	String weekend_yn = request.getParameter("weekend_yn");			//주말여부
	String sel_room_sid = request.getParameter("sel_room_sid");		//선택된 방ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//선택된 호텔명
	String pinfo = request.getParameter("pinfo");								//예약한고객의 정보



	//예약정보를 담기위한 bean 생성
	Reservation_bean param = new Reservation_bean();

	param.setRstdt(start_ymd);						//출발일자
	param.setRscod(goods_sid);						//상품SID

%>
<html>
<head></head>
<body><body>
  <jsp:forward page="reservatio_step6.jsp">
   <jsp:param name="saup_sid" value="1"/>
   <jsp:param name="goods_sid" value="28"/>
   <jsp:param name="start_ymd" value="20080820"/>
   <jsp:param name="arrive_ymd" value="20080822"/>
   <jsp:param name="upjang_nm" value="금강산호텔 별관"/>
   <jsp:param name="room_nm" value="디럭스실,일반실,"/>
   <jsp:param name="member" value="성인 2명, 어린이 3명"/>
   <jsp:param name="total_price" value="280000"/>
  </jsp:forward>
</html>

