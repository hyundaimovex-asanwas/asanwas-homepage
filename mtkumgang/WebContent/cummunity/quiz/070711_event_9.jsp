<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
int totcnt = ParamUtil.getIntParameter(request.getParameter("totcnt"));
String imgurl = request.getParameter("imgurl");
%>
<html>

<head>
<title>금강산 광관 퀴즈풀기 이벤트</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {
	color: #990000;
	font-weight: bold;
	font-size: 14px;
}
.style2 {color: #000000}
-->
</style></head>
<body>
<table cellpadding="0" cellspacing="0">
	<tr>
		<td width="700" height="650" valign="top" background="<%=imageServer%>/quiz_img/bg.gif">
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td height="149"></td>
				</tr>
				<tr>
					<td height="445" valign="top">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="60"></td>
								<!--퀴즈문제 결과시작-->
								<!-- 5-7개 맞춤 -->
								<td width="569" height="364" align="center" valign="top" background="<%=imageServer%>/quiz_img/<%=imgurl%>"><!--5~7개 맞춘문구-->
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td width="50" height="280"></td>
											<td></td>
											<td width="50"></td>
										</tr>
										<tr>
											<td></td>
											<td height="24"><span class="style1"><span class="style2"><%=totcnt%>개</span> 맞추셨습니다. </span></td><!-- 홍길동이 맞춘개수-->
											<td></td>
										</tr>
									</table>
								</td>
								
								<!-- 3-5개 맞춤 
								<td width="569" height="364" align="center" valign="top" background="<%=imageServer%>/quiz_img/quiz_fin_2.gif">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td width="50" height="280"></td>
											<td></td>
											<td width="50"></td>
										</tr>
										<tr>
											<td></td>
											<td height="24"><span class="style1"><span class="style2">4개</span> 맞추셨습니다. </span></td>
											<td></td>
										</tr>
									</table>
								</td>
								-->
								<!-- 0-3개 맞춤 
								<td width="569" height="364" align="center" valign="top" background="<%=imageServer%>/quiz_img/quiz_fin_3.gif">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td width="50" height="280"></td>
											<td></td>
											<td width="50"></td>
										</tr>
										<tr>
											<td></td>
											<td height="24"><span class="style1"><span class="style2">2개</span> 맞추셨습니다. </span></td><strong></strong>
											<td></td>
										</tr>
									</table>
								</td>
								-->
								
								<td width="71"></td>
								<!--퀴즈문제 결과끝-->
							</tr>
						</table>
				 </td>
				</tr>
				<tr>
					<td height="56" valign="top">
						<table width="100%" cellpadding="0" cellspacing="0">
							<tr>
								<td width="62"></td>
								<td align="right"><a href="javascript:self.close();"><img src="<%=imageServer%>/quiz_img/event_bt_ok.gif" width="133" height="45" border="0"></a></td>
								<td width="74"></td>
							</tr>
					 </table>
					</td>
				</tr>
		 </table>
	 </td>
	</tr>
</table>
</body>
</html>
