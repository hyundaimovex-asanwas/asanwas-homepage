<%--
  - �ۼ���: ������
  - �ۼ� ����: 2006.06.01
  - ���� ������ : �̼ҿ�
  - ���� ������ : 2006.08
  - ���۱� ǥ��: IMJ Korea
  - ����: ID ã��.
			action page : member_action.jsp, cmd = IS 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
  String McNum = "0";
  String sub = "0";
  
%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
<script language="javascript">
<!--
	function checkForm2(){

		var form = document.form2; 
		if( form.name.value=="" ){
			alert("�̸���  �Է� �ϼ���");
			form.name.focus();
			return;
		}

		if( form.regno1.value=="" || form.regno2.value==""){
			alert("�ֹι�ȣ��  �Է� �ϼ���");
			form.regno1.focus();
			return;
		}

		if( form.id.value=="" ){
			alert("���̵�  �Է� �ϼ���");
			form.id.focus();
			return;
		}

		//�̸��� Ȯ��
		if( form.semail.value==""  ){
			alert("�̸��� �ּҸ�  �Է� �ϼ���");
			form.semail.focus();
			return;
		}
		else if(!CheckEmail(form.semail.value)){
			alert("�ùٸ� �̸��� �ּҰ� �ƴմϴ�. �ٽ� �Է� �ϼ���");
			form.semail.focus();
			return;
		}
		form.submit();
	}
function movenext(args,next,len){
    if (args.value.length==len){
       next.focus();
       return;
    }
}
//-->
</script>


</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/login/tour_login_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu09.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/login/tit_login.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">�α���</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<form name=form2 method=post action=member_action.jsp >
	<input type=hidden name=cmd value="PS">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="50"></td></tr>
				<tr>
					<td valign="top">
						<!-- / �α��� -->
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="cb11">
						<tr valign="top">
							<td width="180"><img src="<%=imageServer%>/tour_img/login/txt_login.gif" style="margin:35 0 0 27px;"></td>
							<td width="6"><img src="<%=imageServer%>/tour_img/login/vline.gif"></td>
							<td width="484" style="padding:35 0 18 0px;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login51.gif"></td></tr>
								<tr><td style="padding:15 0 0 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login52.gif"></td></tr>
								</table>
							</td>
						</tr>
						<tr valign="top">
							<td colspan="2" class="bg_sky"></td>
							<td height="143" class="bg_sky">
								<table width="482" cellpadding="0" cellspacing="0" border="0" style="margin:18 0 0 2px">
								<tr>
									<td width="63"><img src="<%=imageServer%>/tour_img/login/txt07.gif"><!-- �̸� --></td>
									<td width="419"><input type="text" name="name" style="width:121px;" class="input09" tabindex="1"></td>
								</tr>
								<tr><td colspan="2" height="5"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/login/txt08.gif"><!-- �ֹι�ȣ --></td>
									<td class="txt_dsky">
									<input type="text" name="regno1" style="width:121px;" class="input09" maxlength="6"   onkeyup=movenext(this.form.regno1,this.form.regno2,6)     tabindex="2"> - 
									<input type="password" name="regno2" style="width:121px;" class="input09" maxlength="7" tabindex="3"></td>
								</tr>
								<tr><td colspan="2" height="5"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/login/txt09.gif"><!-- ���̵� --></td>
									<td class="txt_dsky"><input type="text" name="id" style="width:121px;" class="input09" tabindex="4"></td>
								</tr>
								<tr><td colspan="2" height="5"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/login/txt10.gif"><!-- �̸����ּ� --></td>
									<td class="txt_dsky">
									<input type="text" name="semail" style="width:256px;" class="input09" tabindex="5" onkeypress="if (13 == event.keyCode) checkForm2();">
									<a href="javascript:checkForm2();"><img src="<%=imageServer%>/tour_img/btn/btn_confirm.gif" align="absmiddle" hspace="10"></a><!-- Ȯ�� --></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- �α��� / -->
					</td>
				</tr>
				</table>
</form>				
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>