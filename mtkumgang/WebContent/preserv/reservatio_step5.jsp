<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>

<%
	String goods_sid = request.getParameter("goods_sid");					//������ǰ �ڵ�
	String saup_sid = request.getParameter("saup_sid");					//������ �ڵ�
	String start_ymd = request.getParameter("start_ymd");				//�������
	String weekend_yn = request.getParameter("weekend_yn");			//�ָ�����
	String sel_room_sid = request.getParameter("sel_room_sid");		//���õ� ��ID
	String sel_upjang_nm = request.getParameter("sel_upjang_nm");	//���õ� ȣ�ڸ�
	String sel_upjang_sid = request.getParameter("sel_upjang_sid");	//���õ� ȣ��ID
	String pinfo = request.getParameter("pinfo");								//�����Ѱ��� ����
	String room_nm = request.getParameter("room_nm");					//���
	String foreigner_yn = request.getParameter("foreigner_yn");			//�ܱ��ο���
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>�ݰ��� ����</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
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

	//�����ܰ�ΰ���
	function nextStep() {
		document.resv.action = "reservatio_proc.jsp";
		document.resv.submit();
	}
	
	function prevStep() {

	}
</script>
</head>
<body>
<form name="resv" method="post">
	<input type="hidden" name="goods_sid" value="<%=goods_sid%>">
	<input type="hidden" name="saup_sid" value="<%=saup_sid%>">
	<input type="hidden" name="start_ymd" value="<%=start_ymd%>">
	<input type="hidden" name="weekend_yn" value="<%=weekend_yn%>">
	<input type="hidden" name="sel_upjang_nm" value="<%=sel_upjang_nm%>">
	<input type="hidden" name="room_nm" value="<%=room_nm%>">
	<input type="hidden" name="sel_upjang_sid" value="<%=sel_upjang_sid%>">
	<input type="hidden" name="sel_room_sid" value="<%=sel_room_sid%>">
	<input type="hidden" name="pinfo" value="<%=pinfo%>">
	<input type="hidden" name="foreigner_yn" value="<%=foreigner_yn%>">
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
					<td style="padding:31 0 19 27"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_01.gif"></td>
				</tr>
				<tr>
					<td align="center">
						<table cellpadding="0" cellspacing="0" width="750" height="295" bgcolor="E3E3E3">
							<tr>
								<td align="center">
									<table cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="746" height="291">
										<tr>
											<td height="30" valign="bottom" style="padding:0 0 0 10"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_02.gif"></td>	
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
																	<td><div style="overflow-y:scroll; width:724; height:199; padding:10px; scrollbar-highlight-color: #CCCCCC; scrollbar-shadow-color: #CCCCCC; scrollbar-arrow-color: #CCCCCC; scrollbar-face-color: #FFFFFF; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #FFFFFF;">
																		<table cellpadding="0" cellspacing="0">
																			<tr>
																				<td style="padding:0 0 5 0"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_con1.gif"></td>
																			</tr>
																			<tr>
																				<td width="682" height="80" align="center" valign="middle" bgcolor="#B8C7D0"><iframe name="agreement" src=" agreement_1.jsp" frameborder="0" width="680" height="78" scrolling="yes" style="overflow-x:hidden; overflow-y:auto"></iframe></td>
																			</tr>
																			<tr>
																				<td style="padding:20 0 5 0;"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_con2.gif"></td>
																			</tr>
																			<tr>
																				<td width="682" height="80" align="center" valign="middle" bgcolor="#B8C7D0"><iframe name="agreement" src=" agreement_2.jsp" frameborder="0" width="680" height="78" scrolling="yes" style="overflow-x:hidden; overflow-y:auto"></iframe></td>
																			</tr>
																		</table>
																	</div></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td height="10"><div id="btn"><a href="javascript:prevStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_cancle.gif" border="0"></a> <a href="javascript:nextStep()" onFocus="this.blur()"><img src="<%=imageServer%>/tour_img/reservation/reservatio_step5_ok.gif" border="0"></a></div></td>
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
