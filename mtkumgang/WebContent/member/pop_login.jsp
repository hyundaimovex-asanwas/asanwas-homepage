<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.12
  - ���� ������ : �̼ҿ�
  - ���� ������ : 2006.07.11
  - ���۱� ǥ��: IMJ Korea
  - ����: �˾� �α���
			action page : login_ok.jsp 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%
	String sErrStr = request.getParameter("sErrStr");
	if(sErrStr == null || sErrStr.trim().equals("")) {
		sErrStr = "1";
	}

	//��Ű������ ������
	String sDomain = ROOT_DNS;
%>


<script language="javascript">
<!--
	function checkForm(){

		var form = document.form;

		if( form.id.value=="" ){
			alert("���̵� �Է� �ϼ���");
			form.id.focus();
			return;
		}

		if( form.pwd.value=="" ){
			alert("��й�ȣ�� �Է� �ϼ���");
			form.pwd.focus();
			return;
		}

		form.submit();
	}

	function openr_herf(url)
	{
		if (opener)
		{
			opener.parent.location.href= url;
			this.close();
		}
	}
  
         function setFocus()
        {
            document.form.id.focus();
        }
//-->
</script>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
</head>

<body class="popmargin" onLoad="setFocus()">

<!-- �˾������� : 350 * 280 -->
<table cellspacing="0" cellpadding="0" border="0" width="320">
<tr>
	<td>
			<!-- / Ÿ��Ʋ -->
			<table cellspacing="0" cellpadding="0" border="0" width="320" height="65" class="bg_dblue">
			<tr valign="top">
				<td width="296" class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/login/pop_tit_login.gif"></td>
				<td width="124" class="tpad_20"><img src="<%=imageServer%>/tour_img/mem/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- Ÿ��Ʋ / -->
<form name=form method=post action=login_ok.jsp onSubmit="return checkForm();">
<input type=hidden name=popuplogin value="1">			
<input type=hidden name=domain value="<%=sDomain%>">
			<table cellspacing="0" cellpadding="0" border="0" width="320">
			<tr><td height="40"></td></tr>
			<tr>
              <td align="center">
              	<table cellspacing="0" cellpadding="0" border="0">
              	<tr>
              		<td width="45"><img src="<%=imageServer%>/tour_img/login/txt_id.gif"></td>
              		<td width="162"><input type="text" name="id" style="width:153px;" tabindex="1" onkeypress="if (13 == event.keyCode) checkForm();"></td>
              		<td width="46" rowspan="2">
              		<a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_pop_login.gif"></a>
              		</td>
              	</tr>
              	<tr style="padding-top:6px">
              		<td><img src="<%=imageServer%>/tour_img/login/txt_pwd.gif"></td>
              		<td><input type="password" name="pwd" style="width:153px;" tabindex="2" onkeypress="if (13 == event.keyCode) checkForm();"></td>
              	</tr>
              	</table>
              </td>
			</tr>
			<tr><td height="24"></td></tr>
			<tr>
				<td height="67" valign="top" align="center">
				<a href="javascript:openr_herf('id_search.jsp')"><img src="<%=imageServer%>/tour_img/btn/btn_idsch2.gif" hspace="4"></a><!-- ���̵�ã�� -->
				<a href="javascript:openr_herf('pwd_search.jsp')"><img src="<%=imageServer%>/tour_img/btn/btn_pwdsch2.gif" hspace="4"></a><!-- ��й�ȣã�� -->
				<a href="javascript:openr_herf('join_agreement.jsp')"><img src="<%=imageServer%>/tour_img/btn/btn_uregist.gif" hspace="4"></a><!-- ȸ�������ϱ� --></td>
			</tr>
			</table>
</form>
			<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dblue"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>
