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

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "31";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.support.PollBean" %>

<%
	PollBean bean  = new PollBean();
	int result = bean.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('등록되었습니다.');			
			location.replace('poll_list.jsp');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 등록되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>