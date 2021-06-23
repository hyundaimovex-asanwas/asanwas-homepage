<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM
* 작성날자 : 2005. 10. 25
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%@ include file="/asanway/common/head.jsp" %><%@ page import="com.hmm.asan.asanway.admin.AuthBean" %><%	String menuidx = "30";	AuthBean auth = new AuthBean();	if (!auth.AuthCheck(request, response, menuidx)){		response.sendRedirect("support_main.jsp?flag=1");	}%>
<%@ page import="com.hmm.asan.asanway.support.EventBean" %>

<%
	EventBean sb = new EventBean();
	int result = sb.DeleteUpdate(request, response);
	
	String category = (String)request.getAttribute("category");
%>

<% if(result > 0 ) { %>
<% if( category.equals("openevent1") || category.equals("openevent2") ) { %>
		<script language=javascript>

			alert('삭제되었습니다.');

			location.replace('event_list1.jsp?category=<%=category %>');

		</script>
<% } else { %>

		<script language=javascript>
			alert('삭제되었습니다.');
			location.replace('event_list.jsp?category=<%=category %>');
		</script><%} %>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 삭제되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>