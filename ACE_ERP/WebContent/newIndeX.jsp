<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: �α��� ��Ż
 * ���α׷�ID 	: newIndeX
 * J  S  P		: newIndeX.jsp
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2010-09-08
 * �������		: Ʈ���޴� ������ erp ������Ż
 * [ �������� ][������] ����
 * [2011-06-01][�ɵ���] UI�� 1024*768 �ּ� ����. �׽�Ʈ�غ� ��~
 * �� ���������� ���̹����� ������ �����۲��� ����Ǿ� �ֽ��ϴ� - �غ���
 * [2011-08-08][�ɵ���] ������ ����, ��ũ��Ʈ ����ȭ 
 * [2011-10-26][�ɵ���] �α��� ��ư Ŭ������ �� �� ���ǰ� �޾ƿ���� ����
 * [2012-01-27][�ɵ���] ������Ʈ ��ġ+������ ��� ������ ������  ��ũ �߰�
 * [2013-11-11][�ɵ���] test-erp�� �ø��� ��.. ����Ʈip üũ�� �� ���ٸ���, String.contains �� �ذ�!
 * [2014-01-17][�ɵ���] ������ ���̾ƿ� ����
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
	String remoteAddr = (String)request.getRemoteAddr();	// local �׽�Ʈ��
	//String remoteAddr = (String)request.getHeader("Proxy-Client-IP");	// ������
	//String remoteAddr = (String)request.getHeader("X-Forwarded-For");	// ������
	//request.getHeader("WL-Proxy-Client-IP")
	
	//String remoteAddr = (String)request.getRemoteAddr().substring(0,9);
	if(remoteAddr.contains("203.242.40.26") || 
			remoteAddr.contains("203.242.40.27") || 
			remoteAddr.contains("10.61.108.") || 
			remoteAddr.contains("10.61.107.") || 
			remoteAddr.contains("10.61.106.") || 
			remoteAddr.contains("10.31.102.") || 
			remoteAddr.contains("172.22.2.") || 
			remoteAddr.contains("172.23.2.") ){
			remotePosition = false;	//���������(6,7,8��), �����, ��, ����� �繫��
	}
			remotePosition = false;	//�Ǹ�Ȯ�� �� ����¡
//=remoteAddr<br>
//=remotePosition <br>
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<title>������ �ݰ���!!!</title>
		<link rel="shortcut icon" href="<%=dirPath%>/Common/img/iconlogo.jpg" />
		<link href="<%=dirPath%>/Common/css30/intro.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="<%=dirPath%>/Common/js/intro.js"></script>
	</head>

<BODY border="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">

<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">

  <tr>
  	<td width="2000" height="900" style="background:url(<%=dirPath%>/Common/img/bg_login.jpg);">
		<form method="POST" action="<%=dirPath%>/arivels" name="form" onSubmit="return form_submit();">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="login_attempt" type="hidden" value="<%=login_attempt%>" />
			<input name="remotePosition" type="hidden" value="<%=remotePosition%>" />
			
		<table cellspacing="0" border = '0' align=center>
			<tr>
				<td><label for="txt_id">���̵�</label></td>
				<td><label for="txt_pass">��й�ȣ</label></td>
			</tr>
			<tr>
				<td><input type="text" class="inputtext" name="txt_id" id="txt_id" tabindex="1" value="" /></td>
				<td><input type="password" class="inputtext" name="txt_pass" id="txt_pass" tabindex="2" value="" /></td>
				<td><label class="uiButton uiButtonConfirm" for="u752837_5"><input value="�α���" tabindex="4" type="submit" id="u752837_5" /></label></td>
			</tr>
			
			<tr>
				<td>
					<input type="checkbox" class="inputcheckbox" value="1" id="saveID" name="saveID" checked="1" />
					<input type="hidden" name="default_persistent" value="1" />
					���̵� ����</td>
				<td>���� IP : <%=remoteAddr%></td>
			</tr>
			 
			<tr>
			  	<td>
			  	
			  	<a href="newAX3.jsp" target="_blank">������Ʈ �ν��� ��ũ(���� 3)</a><br/>
			  	<a href="newAX5.jsp" target="_blank">������Ʈ �ν��� ��ũ(���� 5)</a><br/><br/><br/><br/><br/>
			  	
			  	</td>
			  	<td></td>
			  	<td>�� �� �ý����� ȸ���� ������ ���ø����̼��Դϴ�.<br/>
				�� �ҹ����� �α� �õ� �� ��뿡 ���ؼ��� ���� ���� �ǰ�<br/>
				����<b>ó��</b>�� ���� �� �ֽ��ϴ�.<br/>
				�� �α��� �� Ȱ�� �� ���� ����� ����/�����˴ϴ�.<br/><br/>
				�� It will be punished for illegal login to this system.<br/>
				�� It is saved for login information in another system.<br/>
			
			  	</td>
			</tr>
		</table>
		</form> 
  	</td>
  </tr>

</table>

</BODY>
</HTML>
