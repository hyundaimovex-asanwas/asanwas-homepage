<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "30";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.comment.CommentBean" %>

<%
	response.setHeader("Content-Disposition", "attachment;filename=event_comment_list.xls;");
	out.clearBuffer();

	CommentBean comment = new CommentBean();
	comment.CommentList(request, response, "event");

%>

<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request" />


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body leftmargin="0" topmargin="0">

<table width="840" border="1" cellspacing="0" cellpadding="0">
	<tr bgcolor="ccccff">
			<td width="70" align="center"><font class="board_top">번호</font></td>
			<td width="140" align="center"><font class="board_top">이름</font></td>
			<td width="340" align="center"><font class="board_top">내용</font></td>
			<td width="170" align="center"><font class="board_top">작성시간</font></td>
			<td width="120" align="center"><font class="board_top">작성자 IP</font></td>
	 </tr>

	<%
		if(commentlist.size() == 0) {
	%>
	<tr>
		<td height="28" colspan="7" align="center">등록된 데이터가 없습니다.</td>
	</tr>
	<% } else {
			int num = commentlist.size();
			for(int i = 0; i < commentlist.size(); i++) {
				HashMap hm = (HashMap)commentlist.get(i);

	%>
	<tr>
		<td height="28" align="center" style="font-size:10;"><%= num%></font></td>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("REGNAME"))%></td>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("COMMENT"))%></td>
		<td height="28" align="center" style="font-size:10;">'<%= Utility.ko((String)hm.get("REGTIME"))%></td>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("REGIP"))%></td>
	</tr>
	<% 		num--;
			}
	 	}
	 %>
</table>

<!--//body-->

</body>
</html>
