<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
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



<%@ page import="com.hmm.asan.asanway.support.EventBean1" %>

<%
	String category = request.getParameter("category");
	if(category == null) category = "openevent1";

	String fname= "";
	String title = "";
	if( category.equals("openevent1") ){
		 fname = "open_event1_list.xls";
		 title = "오픈이벤트1";
	}

	if( category.equals("openevent2") ){
		 fname = "open_event2_list.xls";
		 title = "오픈이벤트2";
	}

	if( category.equals("openevent3") ){
		fname = "open_event3_list.xls";
		title = "오픈이벤트3";
	}

	response.setHeader("Content-Disposition", "attachment;filename=" + fname + ";");
	out.clearBuffer();

	EventBean1 event = new EventBean1();
	event.List(request, response, category);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<body leftmargin="0" topmargin="0">

<table width="840" border="1" cellspacing="0" cellpadding="0">
	<tr bgcolor="ffffff">
			<td align="center" colspan=8 height=30><font class="board_top"><%=title%></font></td>
	 </tr>
	<tr bgcolor="ccccff">
			<td width="70" align="center"><font class="board_top">번호</font></td>
			<td width="120" align="center"><font class="board_top">이름</font></td>
			<td width="120" align="center"><font class="board_top">ID</font></td>
			<td width="120" align="center"><font class="board_top">전화번호</font></td>
			<td width="100" align="center"><font class="board_top">우편번호</font></td>
			<td width="200" align="center"><font class="board_top">주소</font></td>
			<td width="120" align="center"><font class="board_top">Email</font></td>
		<%if( category.equals("openevent2") ) { %>
			<td width="120" align="center"><font class="board_top">정답1</font></td>
			<td width="120" align="center"><font class="board_top">정답2</font></td>
		<%}%>
			<td width="120" align="center"><font class="board_top">참여일</font></td>
	 </tr>

	<%
		if(list.size() == 0) {
	%>
	<tr>
		<td height="28" colspan="8" align="center">이벤트 참여자가 없습니다. </td>
	</tr>
	<% } else {
			int num = list.size();
			for(int i = 0; i < list.size(); i++) {
				HashMap hm = (HashMap)list.get(i);

	%>
	<tr>
		<td height="28" align="center" style="font-size:10;"><%= num%></font></td>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("NAME"))%></td>
		<td height="28" align="center" style="font-size:10;"><%= hm.get("ID")%></td>
		<td height="28" align="center" style="font-size:10;"><%= hm.get("TEL")%></td>
		<td height="28" align="center" style="font-size:10;"><%= hm.get("ZIP")%></td>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("ADDR1"))%> <%= Utility.ko((String)hm.get("ADDR2"))%></td>
		<td height="28" align="center" style="font-size:10;"><%= hm.get("EMAIL")%></td>
		<%if( category.equals("openevent2") ) { %>
			<td width="120" align="center"><font class="board_top"><%= Utility.ko((String)hm.get("TITLE"))%></font></td>
			<td width="120" align="center"><font class="board_top"><%= Utility.ko((String)hm.get("CONTENT"))%></font></td>
		<%}%>
		<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("REGTIME"))%>&nbsp;</td>
	</tr>
	<% 		num--;
			}
	 	}
	 %>
</table>

<!--//body-->

</body>
</html>
