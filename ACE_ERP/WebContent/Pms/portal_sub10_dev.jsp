
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
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My400Manager" %>
<%@ page import="sales.menu.my.My120I" %>
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
	//�������� �θ���
	SmartRequest sr3 = new SmartRequest(request);
	
		String key 			= HDUtil.nullCheckStr(request.getParameter("search_key"));
		String values 		= HDUtil.nullCheckStr(request.getParameter("search_value"));
		String requestedPage = HDUtil.nullCheckStr(request.getParameter("requestedPage"));
		String pageSize  	= "10";  	//1�������� ǥ�õ� ����
		String where_sql3     = "";
		int	view_cnt=6;
	
		//������ �����.
		if (values !=  null && !values.equals("")){	
	    	where_sql3=" AND " + key + " like '%" + values + "%'";
		}
	   	where_sql3 = "";	// �ӽ� �⺻�� ����
	   
		ArrayList data3 = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len3 = 0;
		String brd_gu = "01";	//���� ����~!
		BaseDataClass bean3;
	
		ArrayList data_all = new ArrayList();	//�Խù� ��ü ī��Ʈ�� �޾ƿ� �� ����.     
		
	
		sr3.setObject("where_sql",(Object)where_sql3);	//������ ����
		sr3.setObject("brd_gu",(Object)brd_gu);			//���� ���� ����
		sr3.setObject("requestedPage",(Object)requestedPage);			//��û������ ����
		sr3.setObject("pageSize",(Object)pageSize);			//������ ������ ����
	
		My210Manager manager3 = new My210Manager();
		//data3 		= manager3.list(sr3);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager3.close();
	//�������� �� //////////////////////////////////////////////////////////////////


	//������ ���� //////////////////////////////////////////////////////////////////
	SmartRequest sr4= new SmartRequest(request);

		String v_login_name ="";
		String v_login_id = "";
		v_login_id = (String)session.getAttribute("vusrid"); 
		v_login_name = (String)session.getAttribute("vusrnm");
	
		key 		 = sr4.getString("search_key");
		values 		 = sr4.getString("search_value");
		// �ᱹ �ѱ��� �޾ƿ��鼭 ������ ���� �����Դϴ�. ��_��;; ��..
		// ��Ƽ��Ʈ�� ������ �ȴ�!
		requestedPage = sr4.getString("requestedPage");
		pageSize  	 = "6";  	//1�������� ǥ�õ� ����
		String where_sql4    = "";
	

	   
		ArrayList data4 = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len4 = 0;
		brd_gu = "01";	//���� ����~!
		BaseDataClass bean4;
	
		
		ArrayList data_all4 = new ArrayList();	//�Խù� ��ü ī��Ʈ�� �޾ƿ� �� ����.     
		
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
		sr4.setObject("where_sql",(Object)where_sql3);	//������ ����
		sr4.setObject("brd_gu",(Object)brd_gu);			//���� ���� ����
		sr4.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
		sr4.setObject("pageSize",(Object)pageSize);			//������ ������ ����
		sr4.setObject("search_key",(Object)key);			//������ ������ ����
		sr4.setObject("v_login_id",(Object)v_login_id);		//�α� ���̵� ���� 
		sr4.setObject("v_login_name",(Object)v_login_name);		//�α� �̸� ���� 
		
		My710Manager manager4 = new My710Manager();
		//data4 		= manager4.list(sr4);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		//data_all4 	= manager4.alllist(sr4);	//�ش� ������ ��ü �Խù� ���� ī��Ʈ�ؿ���
		manager4.close();
	
	//������ ��//////////////////////////////////////////////////////////////////////


	//�̰��� ���� //////////////////////////////////////////////////////////////////
	SmartRequest sr_ap= new SmartRequest(request);	

		requestedPage = "1";
		pageSize  	 = "6";  	//1�������� ǥ�õ� ����
//		String where_sql4    = "";
	   
		ArrayList data_ap = new ArrayList();	//�Խù� ����Ʈ�� �޾ƿ� �� ����.
		int len_ap = 0;
		BaseDataClass bean_ap;
	
		//�̺κ��� ����� �Ŵ������Ͽ��� sr.getObject()�� �о�� �� �ִ�.
//		sr4.setObject("where_sql",(Object)where_sql3);	//������ ����
//		sr4.setObject("brd_gu",(Object)brd_gu);			//���� ���� ����
		sr_ap.setObject("requestedPage",(Object)requestedPage);	//��û������ ����
		sr_ap.setObject("pageSize",(Object)pageSize);			//������ ������ ����
//		sr4.setObject("search_key",(Object)key);			//������ ������ ����
		sr_ap.setObject("v_login_id",(Object)v_login_id);		//�α� ���̵� ���� 
		
		My400Manager manager_ap = new My400Manager();
		//data_ap		= manager_ap.list(sr_ap);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager_ap.close();
	
	//�̰��� ��//////////////////////////////////////////////////////////////////////
	
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