<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.DateUtils"%>

<%
//��������� ����~:)
	//����������---------------------------------------------
	String rname = request.getParameter("rname");	//�����ڸ�
	String rtel  = request.getParameter("rtel");	//�̸���
	String rmob  = request.getParameter("rmob");	//�ڵ���
	String rmail = request.getParameter("rmail");	//��ȭ��ȣ
	String rpass = request.getParameter("rpass");	//��й�ȣ
	//����������---------------------------------------------

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
		document.resv.action = "res_step3.jsp";
		document.resv.submit();
	}
</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="rname" value="<%=rname%>">
	<input type="hidden" name="rtel" value="<%=rtel%>">
	<input type="hidden" name="rmob" value="<%=rmob%>">
	<input type="hidden" name="rmail" value="<%=rmail%>">
	<input type="hidden" name="rpass" value="<%=rpass%>">

	<input type="hidden" name="goods_sid" value="">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="today_ymd" value="<%=today_ymd%>">
</form>

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
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>	
					<td style="padding:20 0 10 16"><img src="<%=imageServer%>/reservation/img/title_step2.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="720" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="716" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_02.gif"></td>
										</tr>
										<tr>
											<td height="35"></td>
										</tr>
										<tr>
											<td align="center" valign="top">
												<table cellpadding="0" cellspacing="0"border=0>
													<tr>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con1.jpg"></td>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con3.jpg"></td>
														<td></td>
														<td><img src="<%=imageServer%>/tour_img/reservation/reservatio_step1_con2.jpg"></td>
														<td></td>
													</tr>
													<tr>
														<td></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('59')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_1.gif" border="0"></a></td>
														<td width="15"></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('58')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_2.gif" border="0"></a></td>
														<td width="15"></td>
														<td align="center" style="padding:7 0 0 0"><a href="javascript:reservation('57')" onFocus="this.blur()"><img src="<%=imageServer%>/reservation/img/reservatio_step1_bt_3.gif" border="0"></a></td>
														<td></td>
													</tr>
												</table>
										  </td>
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
</body>
</html>
