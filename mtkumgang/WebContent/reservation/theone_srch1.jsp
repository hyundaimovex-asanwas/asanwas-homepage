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






%>
<html>
<head>
<title>����ƻ� �¶��� ���ࡡ����������������������������������������������������������������������������������������������������������</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>

<script language="javascript">
<!--
 function checkForm(val){
 
 	var form = document.myform;
 	var form1 = document.myform1;
        if(val == "2"){
         	if( form.rmail.value=="" ){
         		alert("����� ����� �̸����� �Է��� �ֽʽÿ�.");
         		form.rmail.focus();
         		return;
         	}
         
         	if( form.rpass.value=="" ){
         		alert("����� ����� ��й�ȣ�� �Է��� �ֽʽÿ�.");
         		form.rpass.focus();
         		return;
         	}
	        form.chk_confirm.value = val;
		 	form.submit();

        }else if(val == "3"){ //������ ���ηα���
         	if( form1.depart_date.value=="" ){
         		alert("������ڸ� �Է����ּ���");
         		form1.depart_date.focus();
         		return;
         	}

         	if( form1.cust_nm.value=="" ){
         		alert("�̸��� �Է����ּ���");
         		form1.cust_nm.focus();
         		return;
         	}
         
         	if( form1.manage_no.value=="" ){
         		alert("�ֹι�ȣ�� �Է����ּ���.");
         		form1.manage_no.focus();
         		return;
         	}
	        form1.chk_confirm.value = val;
		 	form1.submit();
        
        }
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

<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
  <tr>
    <td height="16">&nbsp;</td>
  </tr>
  <tr>
    <td>

				<!-- / content  -->
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
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
							<td width="219" align=center><img src="<%=imageServer%>/reservation/img/title_srch1_1.gif" border=0></td>
							<td style="padding-top:16px">
<form name=myform method='post' action=theone_srchOK.jsp>
<input type="hidden" name="chk_confirm">
									<table height="44" cellpadding="0" cellspacing="0" border="0">
									<tr valign="top">
										<td width="70" height="25"><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm06.gif" vspace="5"><!-- �̸��� --></td>
										<td width="227"><input type="text" name="rmail" style="width:215px;" class="input09" tabindex="1"></td>
										<td rowspan="2"><a href="javascript:checkForm('2');"><img src="<%=imageServer%>/tour_img/mypage/btn_confirm.gif" tabindex="3"></a><!-- Ȯ�� --></td>
									</tr>
									<tr valign="top">
										<td><img src="<%=imageServer%>/tour_img/mypage/txt_reserconfirm07.gif" vspace="4"><!-- ��й�ȣ --></td>
										<td><input type="password" name="rpass" style="width:215px;" class="input09"  tabindex="2"></td>
									</tr>
									</table>
</form>									
							</td>
						</tr>
						<tr>
							<td colspan=2>������������ ������ <b>������ ��ȸ</b> �� <b>��ݰ���</b>�� �����մϴ�.</td>
						</tr>


						<tr><td colspan="2" height="30"></td></tr>
						<tr><td colspan="2" height="1" class="bg_dblue"></td></tr>
						<tr><td colspan="2" height="30"></td></tr>

						<tr>
							<td width="219" align=center><img src="<%=imageServer%>/reservation/img/title_srch1_2.gif" border=0></td>
							<td style="padding-top:16px">
<form name=myform1 method='post' action=theone_srchOK.jsp>
<input type="hidden" name="chk_confirm">
									<table height="44" cellpadding="0" cellspacing="0" border="0">
									<tr valign="top">
										<td width="70" height="25"><img src="<%=imageServer%>/reservation/img/txt_00.gif" vspace="4"><!-- ������� --></td>
										<td width="227"><input type="text" name="depart_date" style="width:215px;" class="input09" tabindex="4" maxlength=8></td>
										<td rowspan="3" valign=middle><a href="javascript:checkForm('3');"><img src="<%=imageServer%>/tour_img/mypage/btn_confirm.gif" tabindex="7"></a><!-- Ȯ�� --></td>
									</tr>
									<tr valign="top">
										<td height="25"><img src="<%=imageServer%>/reservation/img/txt_01.gif" vspace="4"><!-- ���� --></td>
										<td><input type="text" name="cust_nm" style="width:215px;" class="input09" tabindex="5"></td>
									</tr>
									<tr valign="top">
										<td><img src="<%=imageServer%>/reservation/img/txt_02.gif" vspace="4"><!-- �ֹι�ȣ --></td>
										<td><input type="password" name="manage_no" style="width:215px;" class="input09"  tabindex="6"></td>
									</tr>
									</table>
</form>									
							</td>
						</tr>
						<tr>
							<td colspan=2>������������ ������ <b>�����Ȳ�� Ȯ��</b>�� �� �ֽ��ϴ�.<br>
							������������&nbsp;������ڴ� <b>20090501</b> �� ���� �Է����ּ���~</TD>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				<!--  content / -->

	</td>
  </tr>

</table>


</body>
</html>