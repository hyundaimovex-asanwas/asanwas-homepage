<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �ε���_��������
 * ���α׷�ID 	: index_sales
 * J  S  P		: index_sales.jsp
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2006-09-14
 * �������		: Ʈ���޴� ������ �� �������� ����ȭ��
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-08-19][�ɵ���] ���ο� �ʱ�ȭ��. �޼��� ����, ������ ����
 * [2010-09-07][�ɵ���] �̰��� ǥ�� 
 * [2011-08-01][�ɵ���] ��Ű���� �������� ����.
 * [2013-10-21][�ɵ���] 13 �籸��-���� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="sales.common.HDUtil" %>
<%@ page import="sales.common.HDConstant" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>


<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<%// local ServerScript
	// ����ƻ� ����, �븮��/���¾�ü ����
	// Value = ERP, Value=Tour
	// ERP�� ��� = 
	
try {
	
	
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="<%=dirPath %>/Sales/common/include/menu_click.js"></script>
		<script language="javascript" src="<%=dirPath%>/Sales/common/include/menu.js"></script>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
<script language="javascript">
	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	}
	 
	function fnInit() {
	}

	/* �������� */
	function view_send(brd_no){

		var f = document.form1;
		f.action="<%=dirPath%>/Sales/my/my210_read.jsp?idx=404";
		f.brd_no.value = brd_no;
		f.method = "POST";
		f.target="";
		
		f.submit();
	} 
	/* ���� ������ */
   function view_send4(brd_no,ref,ref_step){
		var readURL ="<%=dirPath%>/Sales/my/my710_read_pop.jsp?pageFrom=710&idx=400&brd_no="+brd_no+"&ref="+ref+"&ref_step="+ref_step;
	   	window.open(readURL,"memoRead_from","width=480,height=450,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize");
   }
	
	/* ������ ���� */
	function view_send_ap(ap_m_sid){
		var f = document.form1;
		f.action="<%=dirPath%>/Sales/my/my400s.jsp?idx=591";
		f.ap_m_sid.value = ap_m_sid;
		f.method = "POST";
		f.target="";
		
		f.submit();
	}
	
	
</script>


<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
</head>

<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/><%//����%>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	


					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="300" align="center" valign="top">
							
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="310" align="center" valign="top">
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="241" valign=top>
								
							</td>							
						</tr>
					

						<tr>
							<td height="30" colspan="5" align=left><jsp:include page="/Common/un/updatenote10.jsp" /></td>
						</tr>
					</table>
						<input type="hidden" name="brd_no" value="">
						<input type="hidden" name="actId" value="">
						<input type="hidden" name="process_flag" value="">
						<input type="hidden" name="ap_m_sid" value="">
						
					</form>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>