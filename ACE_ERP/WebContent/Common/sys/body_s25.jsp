<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>

<%
	String dirPath = request.getContextPath();
 
    SmartRequest sr = new SmartRequest(request);	

	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");    
    
    
	//������� �̵���, ������, �ɵ���, �豹ȯ, �迵��, ��õȣ, ���Ѽ�, �ֱ���, ���缮, �̹��, ������, �����
	if(!gusrid.equals("6060002") && !gusrid.equals("6070001") && !gusrid.equals("6050006") && !gusrid.equals("2180016") && !gusrid.equals("2180017") && !gusrid.equals("1990071") && !gusrid.equals("2180004") && !gusrid.equals("2180013") && !gusrid.equals("1990041") && !gusrid.equals("2050040") && !gusrid.equals("2050022") && !gusrid.equals("2030032")){
	//���� �Բ� ���� ȭ������ 
	
%>

		<script language="javascript">
		
		alert("���� ������ �����ϴ�.\n\n����ƻ� �����ڿ��� ���ǹٶ��ϴ�.");
		
		top.location.href="<%=dirPath%>/newIndeX.jsp";
		
		</script>

<%
		return;

	}
	//�α��� üũ �� ///////////////////////////////////////////////////////////////////////////////////////
%>
	
<iframe name="por" width="0" height="0" frameborder="0" scrolling="no"></iframe>

<body class="jui" onload="xtable_1_submit()">

<!--||| HEADER START |||-->
	<table width="100%" border='0'>
	  <TR>
		<td width="158px" style="padding-bottom:-1px"><img src="../../images/Common/logo.gif" /></td>
		<td style="padding-left:2px;padding-bottom:1px" id="msgTxt"><font size=2 color='blue'> &nbsp;</font></td>
		<td width="200px" style="padding-bottom:0px; color:#111111;">&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color='blue'>������ : <%=gusrnm%>(<%=gusrid%>)��</font></td>
	  </TR>
	</table>