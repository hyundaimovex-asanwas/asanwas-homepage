<%--
  - �ۼ���: �ɵ���
  - ����: 2009.02.12
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
��- 	��������>������ȸ.
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.util.*"%>

<%
String chk_confirm = request.getParameter("chk_confirm");	  // 1 : ȸ������, 2:��ȸ������, 3: ������ ���ηα�


if(chk_confirm.equals("2")){
	//request parameters
	String rmail = request.getParameter("rmail");	//��ȭ��ȣ
	String rpass = request.getParameter("rpass");	//��й�ȣ



	if (rmail.equals("") || rpass.equals("")){  // ��ȸ�������ӿ��� ������ ���°��
	%>
	    <script language="javascript">
	       alert("����� ����� ����� ������ ������ �ֽʽÿ�.");
	       document.location.href="theone_srch1.jsp";
	    </script>
	<%   
	}


	//��������
	int cnt = 0;
	
	ReservationInfo dao = new ReservationInfo();
	Reservation_bean[] recordview = dao.getRevUser(rmail, rpass);
	
	int totalCount = recordview.length;
	
	
	   if (totalCount > 0){
	   %>
	       <form name="myform" method="post" action="theone_srch2.jsp">
	         <input type="hidden" name="rmail" value="<%=rmail%>">
	         <input type="hidden" name="rpass" value="<%=rpass%>">
	       </form>    
	    <%
	       out.println("<script language='javascript'>document.myform.submit();</script>");
	   
	   }else{
	   
	       out.println("<script language='javascript'>alert('��ϵ� ���� ������ �����ϴ�.');history.back();</script>");
	   
	   }

}else if(chk_confirm.equals("3")){
	//request parameters
	String depart_date 	= request.getParameter("depart_date");		//�����
	String cust_nm 	= request.getParameter("cust_nm");		//����
	String manage_no= request.getParameter("manage_no");	//�ֹι�ȣ

	if (depart_date.equals("") || cust_nm.equals("") || manage_no.equals("")){  //�� ���� ���
	%>
	    <script language="javascript">
	       alert("����� �Ǵ� ���� �Ǵ� �ֹι�ȣ�� �Է����� �ʾҽ��ϴ�.");
	       document.location.href="theone_srch1.jsp";
	    </script>
	<%   
	}

	//��������
	int cnt = 0;
	
	ReservationInfo dao = new ReservationInfo();
	Reservation_bean bean[] = dao.getRevCust(depart_date, cust_nm, manage_no);

	int	rsv_sid	   = bean[0].getRsv_sid();
	
	
	   if (rsv_sid > 0){
	   %>
	       <form name="myform1" method="post" action="theone_print2.jsp">
	         <input type="hidden" name="rsv_sid" value="<%=rsv_sid%>">
	       </form>    
	    <%
	       out.println("<script language='javascript'>document.myform1.submit();</script>");
	   
	   }else{
	   
	       out.println("<script language='javascript'>alert('��ϵ� ���� ������ �����ϴ�.');history.back();</script>");
	   
	   }

}

%>