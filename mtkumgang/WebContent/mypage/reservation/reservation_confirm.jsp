<%--
  - �ۼ���: �̼ҿ�
  - ����: 2006.07.03
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - ����������>���ǿ��ຸ��
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
  String McNum = "0";
  String sub = "0";
  String pageNum = "2";
%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">
<!--
 function checkForm(val){
 
 	var form = document.myform;
        if(val == "2"){
         	if( form.r_mail.value=="" ){
         		alert("����� ����� �̸����� �Է��� �ֽʽÿ�.");
         		form.r_mail.focus();
         		return;
         	}
         
         	if( form.r_pass.value=="" ){
         		alert("����� ����� ��й�ȣ�� �Է��� �ֽʽÿ�.");
         		form.r_pass.focus();
         		return;
         	}
        }else{
        
        }
        form.chk_confirm.value = val;
 	form.submit();
 }
 
 function popLogin() {
    var winOpts="width=370,height=320,scrollbars=no";
    var url = "/member/pop_login.jsp";
    window.open(url,"LoginCheck",winOpts);
 }
//-->
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
			<!--  left menu flash -->
			</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reserconfirm.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���� ��������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="55"></td></tr>
				<tr>
					<td>
					<%
					  if(session_id.equals("")){
					%>
					        <!-- ��α��� & ȸ������ START-->
						<table width="690" height="65" class="bg_dblue" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="21"></td>
							<td width="474"><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm01.gif"></td>
							<td>
							<a href="javascript:popLogin();"><img src="<%=imageServer%>/tour_img/mypage/btn_login.gif"></a><!-- �α��� -->
							</td>
						</tr>
						</table>
						<!-- ��α��� & ȸ������ END-->
                                         <%
                                         }else{
                                         %>
						<!-- �α��� & ȸ������ START-->
						<table width="690" height="65" class="bg_dblue" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="21"></td>
							<td width="489"><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm012.gif"></td>
							<td><a href="javascript:checkForm('1');"><img src="<%=imageServer%>/tour_img/mypage/btn_confirm2.gif"></a><!-- Ȯ�� --></td>
						</tr>
						</table>
						<!-- �α��� & ȸ������ END-->
					<%
                                        }
					%>
					</td>
				</tr>
				<tr><td height="29"></td></tr>
				<tr>
					<td><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm02.gif" style="margin:0 0 6 19px;"></td>
				</tr>
				<tr>
					<td><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm03.gif" style="margin:0 7 0 19px;" align="absmiddle"><span class="b txt_orange">KUMGANG@KUMGANG.COM</span><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm04.gif" style="margin:0 0 0 6px;" align="absmiddle"></td>
				</tr>
				<tr><td height="23"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="219"><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm05.gif" style="margin:0 0 0 17px;"></td>
							<td>
<form name=myform method='post' action=reservation_ok.jsp>
<input type="hidden" name="chk_confirm">
									<table height="44" cellpadding="0" cellspacing="0" border="0">
									<tr valign="top">
										<td width="50" height="25"><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm06.gif" vspace="5"><!-- �̸��� --></td>
										<td width="227"><input type="text" name="r_mail" style="width:215px;" class="input09" tabindex="1"></td>
										<td rowspan="2"><a href="javascript:checkForm('2');"><img src="<%=imageServer%>/tour_img/mypage/btn_confirm.gif" tabindex="3"></a><!-- Ȯ�� --></td>
									</tr>
									<tr valign="top">
										<td><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm07.gif" vspace="4"><!-- ��й�ȣ --></td>
										<td><input type="password" name="r_pass" style="width:215px;" class="input09"  tabindex="2"></td>
									</tr>
									</table>
</form>									
							</td>
						</tr>
						<tr><td colspan="2" height="30"></td></tr>
						<tr><td colspan="2" height="1" class="bg_dblue"></td></tr>
						</table>
					</td>
				</tr>
				</table>
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>