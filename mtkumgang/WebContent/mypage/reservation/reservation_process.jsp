<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.10.26
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ�� >�������
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
        
	//8�ڸ� ��¥ �� �ҷ�����
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
    bean.setRstdt(pDepart_date); //�����
    bean.setAccept_sid(Integer.parseInt(pAccept_sid)); //��û��SID
    bean.setRsv_sid(Integer.parseInt(pRsv_sid)); //����SID
    bean.setCust_ip(pU_ip);//���Ӿ�����
    bean.setRegdate(reg_date); //��û��
    bean.setRegtime(reg_time); //��û�ð�

    int result = 0;
    result = dao.getRevCancle(bean);
    
if(result < 1){

%>
    <script language="JavaScript">
	<!--
	 alert('���������� ��� �Ǿ����ϴ�.\n��ҿ�û����\n����ƻ��� ����ڰ� Ȯ��ó���Ͽ� ���� ��Ұ� �Ϸ� �˴ϴ�.');
	 parent.location.reload();
	//-->
	</script>
<%
}else{
%>
	<script language="JavaScript">
	<!--
	alert('ó���� �����Ͽ����ϴ�. ����� �ٽ� ����Ͽ� �ֽʽÿ�.');
	parent.location.reload();
	//-->
	</script>
<%
}		
%>
