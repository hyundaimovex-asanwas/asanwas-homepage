<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>


<%
	String rname = request.getParameter("rname");	//�����ڸ�
	String rmail = request.getParameter("rmail");	//�̸���
	String rpass = request.getParameter("rpass");	//��й�ȣ

	String goods_sid = "59";//request.getParameter("goods_sid");			//������ǰ

	String member = request.getParameter("member");				//�ο���
	String total_price = request.getParameter("total_price");		//�Ѱ���

	String saup_nm = "";						//��������
	String goods_nm = "";					//������ǰ��

	//�ݰ�������̸�
	saup_nm = "�����Ǹ�";

	//2��3��
	if(goods_sid.equals("59")) {
		goods_nm = "����2��";
	//1��2��
	} else if(goods_sid.equals("58")) {
		goods_nm = "����1��";
	//����
	} else if(goods_sid.equals("57")) {
		goods_nm = "���ళ��";
	}
  
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
<script type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>

<script language="javascript">
	
function prevStep() {
	document.resv.action = "theone_srch2.jsp";
	document.resv.submit();
}


</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="rmail" value="<%=rmail%>">
	<input type="hidden" name="rpass" value="<%=rpass%>">


<table cellpadding="0" cellspacing="0" height="470">
  <tr>
    <td height="54"><img src="<%=imageServer%>/reservation/img/theone_l_title_1.gif" /></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--������ ����-->
			<table cellpadding="0" cellspacing="0" width="730">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/reservation/img/theone_m_title_6.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="710" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="706" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_02.gif"></td>	
										</tr>
										<tr>
											<td height="5"></td>
										</tr>
										<tr>
											<td valign="top" style="padding:5 0 0 10">
												<table cellpadding="0" cellspacing="0">
													<tr>
														<td bgcolor="B8C7D0" width="686" height="201" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="684" height="199" bgcolor="F8F8F8">
																<tr>
																	<td align="center" valign="middle" class="res07">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td>������ �̸� :&nbsp;&nbsp;&nbsp;<span class="res06"><%=rname%></span></td>
																			</tr>
																			<tr>
																				<td>������ ���� :&nbsp;&nbsp;&nbsp;<span class="res06"><%=rmail%></span></td>
																			</tr>
																			<tr>
																				<td>�� ������ ���ϰ� ��й�ȣ�� ���������� Ȯ���Ͻ� �� �ֽ��ϴ�.</td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>
																			<tr>
																				<td height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>

																			<tr>
																				<td>�����ο� :&nbsp;&nbsp;&nbsp;<span class="res06"><%=member%></span> ��</td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>
																			<tr>
																				<td height="1" bgcolor="#CCCCCC"></td>
																			</tr>
																			<tr>
																				<td height="10"></td>
																			</tr>
																			<tr>
																				<td>
																					<table cellpadding="0" cellspacing="0" width="360">
																						<tr>
																							<td height="25" class="res08" bgcolor="#666666" align="center">���� ������� : <%=total_price%> ��</td>
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
											</td>
										</tr>
										<tr>
											<td height="10" align=center><div id="btn"><a href="javascript:prevStep();"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_ok.gif" border="0"></a></div></td>
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
