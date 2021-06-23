<%--
  - 작성자: 이소연
  - 일자: 2006.10.26
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기 >예약취소
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="kr.co.imjk.util.*"%>
    
<%

    String serDate = ParamUtil.getReqParameter(request.getParameter("serDate"));
    String today = new String();
    String stday = new String();
    Calendar cal = Calendar.getInstance();
    
	//8자리 날짜 값 불러오기
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());	

    String year = String.valueOf(cal.get(Calendar.YEAR));
    String month = String.valueOf(cal.get(Calendar.MONTH) + 1);
    String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
    
    String reg_date = new String();
    String reg_hr = new String();
    String reg_min = new String();
    String reg_time = new String();

	reg_date = year+month+day;			// 요기!!!
    
    reg_hr =  String.valueOf(cal.get(Calendar.HOUR_OF_DAY ));
    reg_min =  String.valueOf(cal.get(Calendar.MINUTE ));
    reg_time = reg_hr+reg_min;
	
	


%>
테스트<br><br>
<%=firstday%>
일자 : <%=reg_date%><br><br>
시각 : <%=reg_time%>