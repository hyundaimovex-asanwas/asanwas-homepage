
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ����_������ȣ
 * ���α׷�ID 	: portal_sub09
 * J  S  P		: portal_sub09.jsp
 * �� �� ��		: 
 * �������		: Ʈ���޴� ������ �� ������ȣ ����
 * [ �������� ][������] ����
 * [2011-10-17][�ɵ���]
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
		data3 		= manager3.list(sr3);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
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
		data4 		= manager4.list(sr4);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		data_all4 	= manager4.alllist(sr4);	//�ش� ������ ��ü �Խù� ���� ī��Ʈ�ؿ���
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
		data_ap		= manager_ap.list(sr_ap);		//ȭ�鿡 ǥ�õ� ����Ʈ �ҷ�����.
		manager_ap.close();
	
	//�̰��� ��//////////////////////////////////////////////////////////////////////
	
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Security/common/include/head.jsp"/>
		<link href="<%=dirPath%>/Security/common/include/common.css" rel="stylesheet" type="text/css">
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

<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/><%//����%>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	


					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="300" align="center" valign="top">
								<table width="300" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="210"><b>����������</b></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my210s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="300" height="2"></td>
									</tr>
			                        <% //��������
			                           if(data3 == null || data3.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="3">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
									</tr>			                        
			                        <%
			                           }
			                           else {
			                              len3 = data3.size();
			                              if (len3>= view_cnt){
			                                 len3 = view_cnt;
			                              }
			                              bean3 = null;
			                              int tocnt = data3.size();
			                              for(int h=0; h<len3; h++) {
			                                 bean3 = (BaseDataClass)data3.get(h);
			                        %>			                        									
									<tr height="19">
										<td align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>');">
											<%=StringUtil.cut(StringUtil.strReplace(bean3.get("brd_subject"), "<br>", "") ,17)%></a></td>
										<td align="center"> <%=bean3.get("brd_cdate")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="310" align="center" valign="top">
								<table width="310" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="15">&nbsp;</td>
										<td width="220" colspan=2><b>������ ������</b></td>
										<td width="65" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my710_list.jsp?idx=398"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="4"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="300" height="2"></td>
									</tr>
			                        <% //����������
			                           if(data4 == null || data4.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
									</tr>			                        
			                        <%
			                        	}else {
			                              len4 = data4.size();
			                              bean4 = null;
											for(int h=0; h<len4; h++) {
			                                 	bean4 = (BaseDataClass)data4.get(h);
			                        %>			                        									
									<tr height=19>
										<td valign=middle>
											<% if(Integer.parseInt(bean4.get("brd_viewcnt"))>0){ %>
												<img src="http://static.naver.com/pwe/note/ico_note_off.gif" border="0">
											<%}else{%>
										  		<img src="http://static.naver.com/pwe/note/ico_note_on.gif" border="0">
										  	<%}%>
										</td>
										<td width=110 align=center><%=bean4.get("brd_creator")%>(<%=bean4.get("brd_creator_name")%>)</td>
										<td width=120><a href="javascript:view_send4('<%=bean4.get("brd_no")%>','<%=bean4.get("ref")%>','<%=bean4.get("ref_step")%>');">
								       	<%=StringUtil.cut(StringUtil.strReplace(bean4.get("brd_contents"), "<br>", "") ,10)%></a></td>
										<td align="center"><%=StringUtil.substrToStart(bean4.get("brd_cdate"),"[")%></td>
									</tr>
								   <%
			                           		}
			                       		}
								   %>									
								</table>
							</td>
							<td width="8">&nbsp; </td>
							<td width="241" valign=top>
								<table width="210" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="65"><b>��������</b></td><!-- ����-->
										<td width="70"><b> ����</b></td><!-- �����-->
										<td width="70" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my400i.jsp?idx=591"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="4"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="210" height="2"></td>
									</tr>
			                        <% //��������
			                           if(data_ap == null || data_ap.size() < 1 ) {
			                        %>
									<tr>
										<td height="60" align="center" valign="middle" colspan="4">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
									</tr>			                        
			                        <%
			                        	}else {
			                              len_ap = data_ap.size();
			                              bean_ap = null;
											for(int h=0; h<len_ap; h++) {
			                                 	bean_ap = (BaseDataClass)data_ap.get(h);
			                        %>			                        									
									<tr height=19>
										<td align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td align=center onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("doc_gu_nm")%></td>
										<td align=center onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("i_empnm")%></td>
										<td align="center" onclick="view_send_ap(<%=bean_ap.get("ap_m_sid")%>)" style="cursor:hand;"><%=bean_ap.get("i_date")%></td>
									</tr>
								   <%
			                           		}
			                       		}
								   %>									
								</table>							
							</td>							
						</tr>
						<tr height=30>
							<td colspan=5><br><br>��<font color=blue>�� [��������] �⺻���� ��û�� ����� �Բ� �ڰ汹,���ϳ�SW���� �˾� �����ּ���.<br>
							���� �⺻��ȯ ���� �ʿ��� �޴���  �߰� ���ѿ�û�� <b>Ȩ>��������>�����ý��۰���>�޴�����>���� ��û</b>���� ���ּ���.</font></td>
						</tr>

						<tr height=30>
							<td colspan=5>����<b>Download link ��</b>������<a href="../file/Component.exe">ERP ����� ���� �ʼ� ������Ʈ ��ġ</a>����<a href="../file/jwBrowser428.zip">ERP ����� ���� JW��Ƽ������</a></td>
						</tr>
						<tr>
							<td height="30" colspan="5" align=left><jsp:include page="/Common/un/updatenote09.jsp" /></td>
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