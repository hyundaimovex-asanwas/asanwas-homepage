<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>

<%
	String goods_sid = request.getParameter("goods_sid");					//������ǰ �ڵ�
	String saup_sid = request.getParameter("saup_sid");					//������ �ڵ�
	String start_ymd = request.getParameter("start_ymd");				//�������
	String weekend_yn = request.getParameter("weekend_yn");			//�ָ�����
	String sel_room_sid = request.getParameter("sel_room_sid");		//���õ� ��ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//���õ� ȣ�ڸ�
	String pinfo = request.getParameter("pinfo");								//�����Ѱ��� ����



	//���������� ������� bean ����
	Reservation_bean param = new Reservation_bean();

	param.setRstdt(start_ymd);						//�������
	param.setRscod(goods_sid);						//��ǰSID

%>
<html>
<head></head>
<body><body>
  <jsp:forward page="reservatio_step6.jsp">
   <jsp:param name="saup_sid" value="1"/>
   <jsp:param name="goods_sid" value="28"/>
   <jsp:param name="start_ymd" value="20080820"/>
   <jsp:param name="arrive_ymd" value="20080822"/>
   <jsp:param name="upjang_nm" value="�ݰ���ȣ�� ����"/>
   <jsp:param name="room_nm" value="�𷰽���,�Ϲݽ�,"/>
   <jsp:param name="member" value="���� 2��, ��� 3��"/>
   <jsp:param name="total_price" value="280000"/>
  </jsp:forward>
</html>

