<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>


<%
	String rname = request.getParameter("rname");	//예약자명
	String rmail = request.getParameter("rmail");	//이메일
	String rpass = request.getParameter("rpass");	//비밀번호

	String goods_sid = "59";//request.getParameter("goods_sid");			//관광상품

	String member = request.getParameter("member");				//인원명
	String total_price = request.getParameter("total_price");		//총가격

	String saup_nm = "";						//관광지명
	String goods_nm = "";					//관광상품명

	//금강산관광이면
	saup_nm = "예약판매";

	//2박3일
	if(goods_sid.equals("59")) {
		goods_nm = "예약2박";
	//1박2일
	} else if(goods_sid.equals("58")) {
		goods_nm = "예약1박";
	//당일
	} else if(goods_sid.equals("57")) {
		goods_nm = "예약개성";
	}
  
%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>금강산|개성 예약판매　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>

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
		<!--컨텐츠 시작-->
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
																				<td>예약자 이름 :&nbsp;&nbsp;&nbsp;<span class="res06"><%=rname%></span></td>
																			</tr>
																			<tr>
																				<td>예약자 메일 :&nbsp;&nbsp;&nbsp;<span class="res06"><%=rmail%></span></td>
																			</tr>
																			<tr>
																				<td>※ 예약자 메일과 비밀번호로 예약정보를 확인하실 수 있습니다.</td>
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
																				<td>예약인원 :&nbsp;&nbsp;&nbsp;<span class="res06"><%=member%></span> 명</td>
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
																							<td height="25" class="res08" bgcolor="#666666" align="center">예상 관광요금 : <%=total_price%> 원</td>
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
		<!--컨텐츠 끝-->
		</td>
	</tr>
	<tr>
		<td height="8" bgcolor="3F667D"></td>
	</tr>
</table>



</form>
</body>
</html>
