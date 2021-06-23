<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
int quiz1 = ParamUtil.getIntParameter(request.getParameter("quiz1"));
int quiz2 = ParamUtil.getIntParameter(request.getParameter("quiz2"));
int quiz3 = ParamUtil.getIntParameter(request.getParameter("quiz3"));
int quiz4 = ParamUtil.getIntParameter(request.getParameter("quiz4"));
int quiz5 = ParamUtil.getIntParameter(request.getParameter("quiz5"));

/*out.print("quiz1="+quiz1+"<br>");
out.print("quiz2="+quiz2+"<br>");
out.print("quiz3="+quiz3+"<br>");
out.print("quiz4="+quiz4+"<br>");
out.print("quiz5="+quiz5+"<br>");*/

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
-->
</style>
<script language="javascript">
<!--
function evt6(cnt){
	var f = document.frm;
	f.quiz6.value = cnt;
	//o를 클릭하면
	//1) o가 색이 변한다.
	//2) x가 흰색으로 변한다.
	//x를 클릭하면
	//1) x가 색이 변한다.
	//2) o가 흰색으로 변한다.
	if (cnt=="1") {
		document.IMG_O.src="<%=imageServer%>/quiz_img/quiz_o_on.gif";
		document.IMG_X.src="<%=imageServer%>/quiz_img/quiz_x.gif";
	} else if (cnt=="0") {
		document.IMG_O.src="<%=imageServer%>/quiz_img/quiz_o.gif";
		document.IMG_X.src="<%=imageServer%>/quiz_img/quiz_x_on.gif";
	}
}

function goevt6(){
	var f = document.frm;
	if(f.quiz6.value == ""){
		alert("퀴즈를 풀어주세요.");
		return;
	}
	f.action = "070711_event_8.jsp";
	f.submit();
}
-->
</script>
</head>
<body>
<table cellpadding="0" cellspacing="0">
	<tr>
		<td background="<%=imageServer%>/quiz_img/bg.gif" width="700" height="650">
			<table width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td height="166"></td>
				</tr>
				<tr>
					<td height="428" valign="top">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="79"></td>
								<!--퀴즈문제 시작-->
								<td valign="top"><img src="<%=imageServer%>/quiz_img/quiz_6.gif" width="538" height="169"></td>
								
								<!--퀴즈문제 끝-->
							</tr>
							<tr>
								<td width="79"></td>
								<td>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td width="75"></td>
											<!--퀴즈문제 o 선택했을때-->
											<td><a href="javascript:evt6('1');"><img name=IMG_O src="<%=imageServer%>/quiz_img/quiz_o.gif" border="0"></a></td>
											<!---->
											<td width="78"></td>
											<!--퀴즈문제 x 선택했을때-->
											<td><a href="javascript:evt6('0');"><img name=IMG_X src="<%=imageServer%>/quiz_img/quiz_x.gif" border="0"></a></td>
											<!---->
											<td width="91"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
				 </td>
				</tr>
				<tr>
					<td height="56" valign="top">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td width="62"></td>
								<td width="431">&nbsp;</td>
								<td><a href="javascript:goevt6();"><img src="<%=imageServer%>/quiz_img/event_bt_next.gif" width="133" height="45" border="0"></a></td>
								<td width="74"></td>
							</tr>
						</table>
					</td>
				</tr>
		 </table>
		</td>
	</tr>
</table>
<form name="frm" method="post">
<input type="hidden" name="quiz1" value="<%=quiz1%>">
<input type="hidden" name="quiz2" value="<%=quiz2%>">
<input type="hidden" name="quiz3" value="<%=quiz3%>">
<input type="hidden" name="quiz4" value="<%=quiz4%>">
<input type="hidden" name="quiz5" value="<%=quiz5%>">
<input type="hidden" name="quiz6">
</form>
</body>
</html>
