<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>

<%
//��������� ����~:)




	//���糯¥ ��������
	DateUtils date = new DateUtils();
	String today_ymd = date.getSysDate(1);

	//�������� ���� - �ݰ����� ��쿡�� �ش� �������� ������ ������ ���� ������ 1�� ���õǾ� �ִ�.
	String saup_sid = request.getParameter("saup_sid")==null?"1":request.getParameter("saup_sid");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ݰ���|���� �����Ǹš�����������������������������������������������������������������������������������</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
-->
</style>

<script language="javascript">
	//���� ������ �����ϱ� ���� ȭ������ ��ũ�Ѵ�.
	function reservation(str) {
		/*
			str : ���������� �������ִ� ����
			value case 
				28: 2�� 3��
				27: 1�� 2��
				30: ����

				57	1111900	���ళ��	
				58	1111901	����1��	
				59	1111902	����2��	
		*/
		document.resv.goods_sid.value = str;
		document.resv.action = "reservatio_step4.jsp";
		document.resv.submit();
	}



	//�����ܰ�� ����
	function prevStep() {
		document.resv.action = "res_login.jsp";
		document.resv.submit();
	}

	//�����ܰ�� ����
	function nextStep() {
		if(!document.resv.rname.value){
			alert("������ �̸��� �Է����ּ���.");
			document.resv.rname.focus();
			return;
		}
		if(!document.resv.rmail.value){
			alert("�̸����� �Է����ּ���.");
			document.resv.rmail.focus();
			return;
		}
		if(!document.resv.rmob.value&&!document.resv.rtel.value){
			alert("�ڵ����̳� ��ȭ��ȣ �� 1���� �� �Է����ּ���.");
			document.resv.rmob.focus();
			return;
		}
		if(!document.resv.rpass.value){
			alert("��й�ȣ�� �Է����ּ���. ������ȸ�� �ʿ��մϴ�.");
			document.resv.rpass.focus();
			return;
		}


		document.resv.action = "res_step2.jsp";
		document.resv.submit();
	}
</script>
</head>
<body>
<form name="resv" method="post">

<table cellpadding="0" cellspacing="0" width="720" height="470">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/tit_res01.gif" width="70" height="21" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--������ ����-->
			<table cellpadding="0" cellspacing="0" width="720">
				<tr>	
					<td style="padding:20 0 10 16"><!-- ���������� --><img src="<%=imageServer%>/reservation/img/title_step1.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="690" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="690" height="291">
										<tr>
											<td>





<!-- / ���������� -->
<table cellspacing="0" cellpadding="0" border=0 width="510" style="margin-top:30px;" align=center>
  <tr height="26">
	<td colspan="2"></td>
  </tr>
  <tr><td height="2" colspan="2" class="line_dg"></td></tr>
  <tr height="26">
	<td width="102"><img src="<%=imageServer%>/reservation/img/txt_s1_1.gif"><!-- �������̸� --></td>
	<td width=100% align=left>&nbsp;&nbsp;&nbsp;<input name="rname" type="text" maxlength=10 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
  </tr>
  <tr><td height="1" colspan="2" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="<%=imageServer%>/reservation/img/txt_s1_2.gif"><!-- �̸��� --></td>
	<td width=100% align=left>&nbsp;&nbsp;&nbsp;<input name="rmail" type="text" maxlength=50 style="width:200px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
  </tr>
  <tr><td height="1" colspan="2" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="<%=imageServer%>/reservation/img/txt_s1_3.gif"><!-- �ڵ�����ȣ --></td>
	<td width=100% align=left>&nbsp;&nbsp;&nbsp;<input name="rmob" type="text" maxlength=13 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>
  </tr>
  <tr><td height="1" colspan="2" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="<%=imageServer%>/reservation/img/txt_s1_4.gif"><!-- ��ȭ��ȣ --></td>
	<td width=100% align=left>&nbsp;&nbsp;&nbsp;<input name="rtel" type="text" maxlength=13 style="width:120px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>  </tr>
  <tr><td height="1" colspan="2" class="tabline"></td></tr>
  <tr height="26">
	<td><img src="<%=imageServer%>/reservation/img/txt_s1_5.gif"><!-- ��й�ȣ--></td>
	<td width=100% align=left>&nbsp;&nbsp;&nbsp;<input name="rpass" type="password" maxlength=10 style="width:100px; height:18px; border:1px #ABABAB solid; color:#666666; font-size:11px; font-face:����;"></td>  </tr>
  <tr><td height="2" colspan="2" class="line_dg"></td></tr>
  <tr height="26">
	<td valign="top" height="26" colspan="2"></td>
  </tr>
</table>
<!-- ���������� / -->












											</td>
										</tr>
										<tr>
											<td height="10" align=center><div id="btn"><a href="javascript:prevStep()"><img src="<%=imageServer%>/tour_img/reservation/step_prev.gif" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="javascript:nextStep()"><img src="<%=imageServer%>/tour_img/reservation/step_next.gif" border="0"></a></div></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<!--������ ��-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>
</form>

</body>
</html>