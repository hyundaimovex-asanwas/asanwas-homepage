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
   ArrayList data3 = new ArrayList(); //��������
   ArrayList data4 = new ArrayList(); //������
   ArrayList data5 = new ArrayList(); //�븮������
   ArrayList data6 = new ArrayList(); //����������
   SmartRequest sr3 = new SmartRequest(request);
   int view_cnt = 6;                  //������ �Խù� ����
   
   String where_sql3     = "";
   String brd_gu = "";
   String out_login_id = "nkp0908";

   int len3 = 0;
   int len4 = 0;
   int len5 = 0;
   int len6 = 0;
   BaseDataClass bean3;
   BaseDataClass bean4;
   BaseDataClass bean5;
   BaseDataClass bean6;

   My020Manager manager4 = new My020Manager();
   My210Manager manager3 = new My210Manager();
   brd_gu = "01";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data3 = manager3.list(sr3);
   
   brd_gu = "02";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data4 = manager3.mainlist(sr3);

   brd_gu = "03";
   sr3.setObject("brd_gu",(Object)brd_gu);
   data5 = manager3.mainlist(sr3);
   
   sr3.setObject("out_login_id",(Object)out_login_id);
   data6 = manager4.list(sr3);
   
   manager3.close();	
   manager4.close();
   
   // ���θ���� ���ο� 
   
   String servletPath = "/servlet/sales.common.my.BaseServlet";
   
   
  	My120I m120 = new My120I();
 	
  	ArrayList data1 = m120.main_select(request, response);
  	
	BaseDataClass param = (BaseDataClass)request.getAttribute("PARAM");
   %>







<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
		<link href="test.css" rel="stylesheet" type="text/css">
		<link href="<%=dirPath%>/Sales/common/include/common.css" rel="stylesheet" type="text/css">
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
<script language="javascript">
	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	};
		 
	function fnInit() {
	};

		
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
					<table width="867" border=0 cellspacing="0" cellpadding="0" bordercolor=blue>
						<tr>
							<td width="427" align="center">	</td>
							<td width="8">&nbsp; </td>
							<td width="420" align="center" valign="top"></td>
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
							<td height="30" colspan="3" align=right><jsp:include page="/Sales/common/include/updatenote04.jsp" /></td>
						</tr>
					</table>
           
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