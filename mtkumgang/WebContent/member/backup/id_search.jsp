<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: ID ã��.
			action page : member_action.jsp, cmd = IS 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<script language="javascript">
<!--
	function checkForm1()
	{
		var form = document.form1;
		if( form.name.value=="" )
		{
			alert("�̸���  �Է��� �ֽʽÿ�.");
			form.name.focus();
			return false;
		}

		if( form.regno1.value=="" || form.regno2.value==""){
			alert("�ֹι�ȣ��  �Է��� �ֽʽÿ�.");
			form.regno1.focus();
			return false;
		}
	}

//-->
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">

<!----- //CONTENTS END----->
				
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="20"><tr><td></td></tr></table>

				<table border="0" cellpadding="0" cellspacing="0" width="644" id="tarea">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- ���̵� ã��-->
					<table border="0" cellpadding="0" cellspacing="0" width="510">
					<tr>
						<td style="padding-left:10"><img src="/img/member/img_search_0101.gif"></td>
					</tr>
					<tr><td height="5"></td></tr>
					</table>

					<form name=form1 method=post action=member_action.jsp onSubmit="return checkForm1();">
						<input type=hidden name=cmd value="IS">
					<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
					<tr>
						<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
					</tr>
					<tr>
						<td align="center">
						<table border="0" cellpadding="0" cellspacing="0">
						<tr height="26">
							<td width="78" align="right" style="padding-right:15"><img src="/img/member/img_join_0202.gif"></td>
							<td width="190"><INPUT TYPE="text" NAME="name" style="width:175; height:18;" class="gray_input"  tabindex=1></td>
						</tr>
						<tr height="26">
							<td align="right" style="padding-right:15"><img src="/img/member/img_join_0203.gif"></td>
							<td>
								<INPUT TYPE="text" NAME="regno1" maxlength=6 style="width:80; height:18;" class="gray_input"  onKeyup="movenext(this.form.regno1,this.form.regno2,6)" tabindex=2> -
								<INPUT TYPE="text" NAME="regno2" maxlength=7 style="width:80; height:18;" class="gray_input" onkeypress="if (13 == event.keyCode) onSubmit='return checkForm1();'" tabindex=3>
							</td>
						</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
					</tr>
					</table>

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="510">
					<tr><td height="15"></td></tr>
					<tr>
						<td align="center"><input type=image src="/img/common/btn_submit.gif" border=0></a>&nbsp;
						<a href="javascript:document.form1.reset();"><img src="/img/common/btn_rewrite.gif" border=0 tabindex=4></a></td>
					</tr>
					</table>
					</form>
					<!-- //Button-->
					<!-- //���̵� ã��-->



					<!----- //CONTENTS END----->

</body>
</html>
