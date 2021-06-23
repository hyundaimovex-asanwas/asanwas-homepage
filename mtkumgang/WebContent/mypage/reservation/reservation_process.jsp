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
   	String reg_date = m_today.format(date.getTime());	
   
    String reg_hr = new String();
    String reg_min = new String();
    String reg_time = new String();
    reg_hr =  String.valueOf(cal.get(Calendar.HOUR_OF_DAY ));
    reg_min =  String.valueOf(cal.get(Calendar.MINUTE ));
    reg_time = reg_hr+reg_min;
    
    String pDepart_date	= request.getParameter("pDepart_date");
    pDepart_date = StringUtil.strReplace(pDepart_date,"-","");
    String pAccept_sid	= request.getParameter("pAccept_sid");
    String pRsv_sid		= request.getParameter("pRsv_sid");
    String pU_ip		       = request.getParameter("pU_ip");
    
    //DAO
    ReservationInfo dao = new ReservationInfo();
    //DTO
    Reservation_bean bean = new Reservation_bean();
    bean.setRstdt(pDepart_date); //출발일
    bean.setAccept_sid(Integer.parseInt(pAccept_sid)); //신청서SID
    bean.setRsv_sid(Integer.parseInt(pRsv_sid)); //예약SID
    bean.setCust_ip(pU_ip);//접속아이피
    bean.setRegdate(reg_date); //신청일
    bean.setRegtime(reg_time); //신청시각

    int result = 0;
    result = dao.getRevCancle(bean);
    
if(result < 1){

%>
    <script language="JavaScript">
	<!--
	 alert('성공적으로 등록 되었습니다.\n취소요청이후\n현대아산의 담당자가 확인처리하여 예약 취소가 완료 됩니다.');
	 parent.location.reload();
	//-->
	</script>
<%
}else{
%>
	<script language="JavaScript">
	<!--
	alert('처리에 실패하였습니다. 잠시후 다시 사용하여 주십시요.');
	parent.location.reload();
	//-->
	</script>
<%
}		
%>
