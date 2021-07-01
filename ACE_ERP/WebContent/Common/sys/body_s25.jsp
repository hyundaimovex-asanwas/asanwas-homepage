<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.org.common.request.SmartRequest"%>

<%
	String dirPath = request.getContextPath();
 
    SmartRequest sr = new SmartRequest(request);	

	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");    
    
    
	//순서대로 이동훈, 정영식, 심동현, 배국환, 김영현, 백천호, 김한수, 최규훈, 강재석, 이백우, 권현택, 정상원
	if(!gusrid.equals("6060002") && !gusrid.equals("6070001") && !gusrid.equals("6050006") && !gusrid.equals("2180016") && !gusrid.equals("2180017") && !gusrid.equals("1990071") && !gusrid.equals("2180004") && !gusrid.equals("2180013") && !gusrid.equals("1990041") && !gusrid.equals("2050040") && !gusrid.equals("2050022") && !gusrid.equals("2030032")){
	//경고와 함께 메인 화면으로 
	
%>

		<script language="javascript">
		
		alert("접근 권한이 없습니다.\n\n현대아산 관리자에게 문의바랍니다.");
		
		top.location.href="<%=dirPath%>/newIndeX.jsp";
		
		</script>

<%
		return;

	}
	//로그인 체크 끝 ///////////////////////////////////////////////////////////////////////////////////////
%>
	
<iframe name="por" width="0" height="0" frameborder="0" scrolling="no"></iframe>

<body class="jui" onload="xtable_1_submit()">

<!--||| HEADER START |||-->
	<table width="100%" border='0'>
	  <TR>
		<td width="158px" style="padding-bottom:-1px"><img src="../../images/Common/logo.gif" /></td>
		<td style="padding-left:2px;padding-bottom:1px" id="msgTxt"><font size=2 color='blue'> &nbsp;</font></td>
		<td width="200px" style="padding-bottom:0px; color:#111111;">&nbsp;&nbsp;&nbsp;&nbsp;<font size=2 color='blue'>접속자 : <%=gusrnm%>(<%=gusrid%>)님</font></td>
	  </TR>
	</table>