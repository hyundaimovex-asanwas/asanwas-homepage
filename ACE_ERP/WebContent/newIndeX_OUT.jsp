<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �α��� ��Ż
 * ���α׷�ID 	: newIndeX_OUT
 * J  S  P		: newIndeX_OUT.jsp
 * �� �� ��		: �̵���
 * �� �� ��		: 2018-04-12
 * �������		: ����Ͽ��� �α׾ƿ� �ϰ� ������ ���
 * [ �������� ][������] ����
 *****************************************************************************/
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<%@ page import="sales.common.HDUtil" %>
<%
	String login_attempt1 	= (String)session.getAttribute("login_attempt");
	if (login_attempt1==null || login_attempt1==""){
		login_attempt1 ="1";
	}
	int login_attempt       = Integer.parseInt(login_attempt1);
	String ssID 			= session.getId();	//������ �̵��� ����ID get
	
	boolean remotePosition = true;	//�ܺ�����?

	String remoteAddr = (String)request.getHeader("Proxy-Client-IP");	// ������

		remotePosition = false;	//�Ǹ�Ȯ�� �� ����¡



				/* 2018.4.4 mobile ������ ���� �Ǵ� �� ó���̶� �����ְ��� */ 
				String userAgent = request.getHeader("User-Agent");
				String results;
				//System.out.println( "userAgent :::::: " + userAgent +"::" );				
			
				boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
				

					
%>
				
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>ȯ���մϴ�(M)</title>
		<link href="<%=dirPath%>/Common/css30/intro.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="<%=dirPath%>/Common/js/intro.js"></script>
	</head>

<BODY border="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100">
  <tr>
  	<td>  
  	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">
  <tr>
  	<td width="100%" style="vertical-align:bottom; padding-bottom:3px"><img src="<%=dirPath%>/Common/img/ci_text.gif" width="100%"   /></td>
  </tr>

  <tr>
  	<td width="100%"style="border-bottom:1 solid #187DFF"><img src="<%=dirPath%>/Common/img/nintro.gif" alt="Mobile" width="100%" /></td>
  </tr>

  <tr>
  	<td style="background:url(<%=dirPath%>/Common/img/nintro_bak2.gif);border-bottom:3 solid #187DFF"><!-- 187DFF -->
		<form method="POST" action="<%=dirPath%>/arivels" name="form" onSubmit="return form_submit();">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="login_attempt" type="hidden" value="<%=login_attempt%>" />
			<input name="remotePosition" type="hidden" value="<%=remotePosition%>" />
		<table cellspacing="0" border="0" width = "100%">
			<tr>
				<td class="html7magic_m" width = "30%" height="30">&nbsp;</td>
				<td class="html7magic_m" width = "50%" height="30">&nbsp;</td>
				<td class="html7magic_m" width = "20%" height="30">&nbsp;</td>
			</tr>
			<tr>
				<td class="html7magic_m" height="100"><label for="txt_id"><font size = "7">ID</font></label></td>
				<td><input type="text" class="inputtext_m" name="txt_id" id="txt_id" tabindex="1" value="" style="font-size:20;" /></td>		
				<td></td>				
			</tr>
			<tr>
				<td class="html7magic_m" height="100"><label for="txt_pass"><font size = "7">��й�ȣ</font></label></td>
				<td><input type="password" class="inputtext_m" name="txt_pass" id="txt_pass" tabindex="2" value="" style="font-size:20;"/></td>
				<td><input type="submit"   class="inputbutton_m" value="�� �� ��" tabindex="4" style="position:relative;width:95%;height:100%;font-size:50;font-family:����;"></td>
			</tr>
			<tr>
				<td class="html7magic_m" height="100">
					<input type="checkbox" value="1" id="saveID" name="saveID" checked="1" style="position:relative;top:0px;left:4px;width:30px;height:30px" />&nbsp;
					<input type="hidden" name="default_persistent" value="1" />&nbsp;
					<label id="label_persistent" for="saveID"><font size = "6">���̵�����</font></label>
				</td>
				<td class="html7magic_m"><div style="color:#ffffff"><font size = "5">����IP : <%=remoteAddr%></div></font></td>
				<td></td>	
			</tr>
		</table>
		</form> 
  	</td>
  </tr>

</table>

</BODY>

</html>			
					

