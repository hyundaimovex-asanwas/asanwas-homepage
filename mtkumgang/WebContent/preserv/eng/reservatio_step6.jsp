<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>


<%
	String saup_sid = request.getParameter("saup_sid");			//������
	String goods_sid = request.getParameter("goods_sid");			//������ǰ

	String start_ymd = request.getParameter("start_ymd");		//�������
	String arrive_ymd = request.getParameter("arrive_ymd");	//��������
	
	String upjang_nm = request.getParameter("upjang_nm");		//������ ���Ҹ�
	String room_info = request.getParameter("room_nm");			//���
	String[] room_nm = room_info.split(",");

	String member = request.getParameter("member");				//�ο���
	String total_price = request.getParameter("total_price");		//�Ѱ���

	String saup_nm = "";						//��������
	String goods_nm = "";					//������ǰ��
	//�ݰ�������̸�
	if(saup_sid.equals("1")) {
		saup_nm = "�ݰ���";
	} else if(saup_sid.equals("2")) {
		saup_nm = "����";
	}

	//2��3��
	if(goods_sid.equals("28")) {
		goods_nm = "2�� 3��";
	//1��2��
	} else if(goods_sid.equals("27")) {
		goods_nm = "1�� 2��";
	//����
	} else if(goods_sid.equals("30") || goods_sid.equals("35")) {
		goods_nm = "����";
	}
  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ݰ��� ����</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script src="<%=imageServer%>/tour_common/prototype.js"/>
<style type="text/css">
<!--
body {
	margin-left: 10px;
	margin-top: 10px;
	margin-right: 10px;
	margin-bottom: 10px;
}
#btn {
	position:absolute;
	left:590;
	top:432;
	width:167;
	height:27;
	z-index:1;
}
-->
</style>

<script language="javascript">
	//����Ȯ�� ������ ��������
	function resv_ok() {
		opener.location.href = "#";
		self.close();
	}
</script>
</head>
<body>
<table cellpadding="0" cellspacing="0" height="470">
	<tr>
		<td width="770" height="65" bgcolor="3F667D">
			<table cellpadding="0" cellspacing="0" height="47" width="100%">
				<tr>
					<td style="padding-left:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle1.gif"></td>
					<td align="right" valign="bottom" style="padding-right:15px;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_toptitle2.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding:0 0 5 0">
		<!--������ ����-->
			<table cellpadding="0" cellspacing="0" width="770">
				<tr>	
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
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
														<td bgcolor="B8C7D0" width="726" height="201" valign="middle" align="center">
															<table cellpadding="0" cellspacing="0" width="724" height="199" bgcolor="F8F8F8">
																<tr>
																	<td align="center" valign="middle" class="res07">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td>�����ǰ : <span class="res06"><%=saup_nm%> ���� <%=goods_nm%></span><br>
																					  �������� : <span class="res06"><%=start_ymd.substring(0,4)%>�� <%=Integer.parseInt(start_ymd.substring(4,6))%>�� <%=Integer.parseInt(start_ymd.substring(6,8))%>��~<%=arrive_ymd.substring(0,4)%>�� <%=Integer.parseInt(arrive_ymd.substring(4,6))%>�� <%=Integer.parseInt(arrive_ymd.substring(6,8))%>�� </span><br>
																					  ���� �� ���� : <span class="res06">
<%
																				out.println(upjang_nm);
																				for(int i=0 ; i<room_nm.length ; i++) {
																					out.println(room_nm[i]);
																				}
%>
																					  </span><br>
																					  �ο����� :  <span class="res06"><%=member%></span></td>
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
											<td height="10"><div id="btn" align="right"><a href="javascript:resv_ok()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step6_ok.gif" border="0"></a></div></td>
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
