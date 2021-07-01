<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.StringUtil" %>
<%@ page import="sales.common.HDUtil" %>

<%
	String jumin = request.getParameter("ju");
	String name = request.getParameter("nm");
	
	StringUtil.printMsg("주민번호" , jumin, this);
	StringUtil.printMsg("성명" , name, this);
	StringUtil.printMsg("서버명" , request.getServerName(), this);
	
	String path = request.getContextPath();
	String basePath =  request.getServerName();



	String resultCode = HDUtil.nullCheckStr(request.getParameter("resultCode"));
	String no = request.getParameter("no");
	StringUtil.printMsg("결과코드" , jumin, this);
	
	StringUtil.printMsg("URL", "http://com.hdasan.com/cNameCheckSYS.asp?Jumin="+jumin+"&Name="+name+"&returnURL="+basePath+path+"/Sales/common/include/confirm.jsp", this);
	
	String codeMsg = "";
	
 if (!resultCode.equals("")) {
		if (resultCode.equals("1")) {
			codeMsg = "본인맞음";
		} else if (resultCode.equals("2")) {
			codeMsg = "본인아님 (성명 불일치)";
		} else if (resultCode.equals("3")) {
			codeMsg = "자료없음";
		} else if (resultCode.equals("4")) {
			codeMsg = "시스템 장애";
		} else if (resultCode.equals("5")) {
			codeMsg = "주민번호 오류";
		} else if (resultCode.equals("6")) {
			codeMsg = "성인인증시 만 19세 이하인 경우 실명인증 거치지 않고 바로 리턴 코드 출력됩니다";
		} else if (resultCode.equals("9")) {
			codeMsg = "SEND 된 데이타가 이상한 경우 ";
		} else if (resultCode.equals("10")) {
			codeMsg = "사이트 코드 오류";
		} else if (resultCode.equals("11")) {
			codeMsg = "정지된 사이트";
		} else if (resultCode.equals("12")) {
			codeMsg = "해당사이트 비밀번호 오류";
		} else if (resultCode.equals("13")) {
			codeMsg = "사이트 인증 시스템 장애(개발자에게 연락주세요!)";
		} else if (resultCode.equals("15")) {
			codeMsg = "Decoding오류";
		} else if (resultCode.equals("16")) {
			codeMsg = "Decoding 시템장애 ";
		} else if (resultCode.equals("21")) {
			codeMsg = "암호화 데이타 이상";
		} else if (resultCode.equals("24")) {
			codeMsg = "암호화 연산중 에러";
		} else if (resultCode.equals("31")) {
			codeMsg = "연결장애";
		} else if (resultCode.equals("32") || resultCode.equals("34") || resultCode.equals("35")) {
			codeMsg = "재시도 부탁드림";
		} else if (resultCode.equals("50")) {
			codeMsg = "정보도용 차단 요청 주민번호";
		}
	}
%>
<html>
	<head >
		<title>실명인증</title>
		
		<script language="javaScript">
			function fnConfirm() {
    			var url = "http://com.hdasan.com/cNameCheckSYS2.asp?Jumin=<%=jumin%>&Name=<%=name%>&returnURL=<%=basePath%><%=path%>/Sales/common/include/confirm2.jsp?no=<%=no%>";
    			location.href=url;
    	 	}
    	 	
    	 	function fnClose() {
    	 	
//    	 		opener.lc_regi_yn.Text = "Y";
//    	 		window.opener.lc_regi_yn.Index = 2;
    	 		
    	 		window.opener.fnTest('<%=no%>',"Y");
//    	 		window.opener.excelDs.namevalue(1.rowposition, "COL04") = "Y";
//    	 		opener.lc_regi_yn.ValueOfIndex("detail", lc_regi_yn.Index) = "Y";

				
    	 		window.close();
    	 	}
		</script>
	</head>
<%
	if (resultCode.equals("")) {
%>	
	<body onLoad="javascript:fnConfirm();" >
<%	
	} else if (resultCode.equals("1")) {
%>
	
	<body onLoad="javascript:fnClose();">
<%
	} else {
%>
	<table>
				<tr>
					<td>결과코드 : <%=resultCode%> : <%=codeMsg%></td>
				</tr>
		</table>
<%
	}
%>
		
	</body>
</html>
 