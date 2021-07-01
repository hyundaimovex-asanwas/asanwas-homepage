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
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My210Manager" %>
<%@ page import="sales.menu.my.My020Manager" %>
<%@ page import="sales.common.HDCookieManager" %>
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
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="test.css" rel="stylesheet" type="text/css">
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
	
</script>


<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td >



					<form name="form1" >
					<table width="867" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="427" align="center">
								
								 <input type="hidden" name="brd_no" value="">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
										<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/notice.gif" width="61" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my210s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //��������
			                           if(data3 == null || data3.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
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
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send('<%=bean3.get("brd_no")%>');"><%=bean3.get("brd_subject")%></a></td>
										<td align="center"> <%=bean3.get("brd_cdate")%> </td>
									</tr>
								   <%
			                           }
			                       }
								   %>									
								</table>
								
							</td>
							<td width="8">&nbsp; </td>
							<td width="420" align="center" valign="top">
								<table width="400" border="0" cellspacing="0" cellpadding="1">
									<tr>
									<td width="5">&nbsp;</td>
										<td width="310"><img src="<%=dirPath%>/Sales/images/mail.gif" height="14"></td>
										<td width="85" align="right" valign="bottom"><a href="<%=dirPath%>/Sales/my/my010s.jsp"><img src="<%=dirPath%>/Sales/images/more.gif" border="0"></a></td>
									</tr>
									<tr>
										<td colspan="3"><img src="<%=dirPath%>/Sales/images/grey_line.gif" width="400" height="2"></td>
									</tr>
			                        <% //����������
//			                           if(data6 == null || data6.size() < 1 ) {
			                        %>
									<tr>
										<td height="114" align="center" valign="middle" colspan="3">�ش� �ڷᰡ �������� �ʽ��ϴ�.</td>
									</tr>			                        
			                        <%
			                        /*   }
			                           else {
			                              len6 = data6.size();
			                              if (len6>= view_cnt){
			                                 len6 = view_cnt;
			                              }
			                              bean6 = null;
			                              int tocnt = data6.size();
			                              for(int h=0; h<len6; h++) {
			                                 bean6 = (BaseDataClass)data6.get(h);*/
			                        %>			                        									
									<tr>
										<td height="19" align="center" valign="middle"><img src="<%=dirPath%>/Sales/images/dot.gif"></td>
										<td><a href="javascript:view_send4"><%//=bean6.get("brd_subject")%></a></td>
										<td align="center"> <%//=bean6.get("send_date")%> </td>
									</tr>
								   <%
			                       //    }
			                       //}
								   %>									
								</table>
							</td>
						</tr>
						<tr height=30>
							<td colspan=3><br><br>��<font color=blue>�� �⺻���� ��û�� ����� �Բ� �ڰ汹,�ɵ������� �˾� �����ּ���.<br>
							���� �ʿ��� �޴� �߰����ѿ�û�� <b>Ȩ>��������>�����ý��۰���>�޴�����>���� ��û</b>���� ���ּ���.</font></td>
						</tr>

						<tr height=30>
							<td>����<b>Download link ��</b>������<a href="../file/Component.exe">ERP ����� ���� �ʼ� ������Ʈ ��ġ</a></td>
							<td></td>
							<td>����<a href="../file/jwBrowser428.zip">ERP ����� ���� JW��Ƽ������</a></td>
						</tr>
						<tr>
							<td height="20" colspan="3">����<img src="<%=dirPath%>/Sales/images/upnote.gif"></td>
						</tr>
						<tr>
							<td height="30" colspan="3" align=right><jsp:include page="/Sales/common/include/updatenote.jsp" /></td>
						</tr>
					</table>
					
						<input type="hidden" name="actId" value="">
						<input type="hidden" name="process_flag" value="">
						
					</form>




           
			</td>
		</tr>
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

<%
	} catch (Exception e) {
		e.printStackTrace(); 
	}
%>