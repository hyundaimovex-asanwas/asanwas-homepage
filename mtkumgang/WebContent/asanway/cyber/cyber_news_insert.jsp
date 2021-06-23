<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : Mr.K JM ( mrkczar@gmail.com )
* 작성날자 : 2005. 10. 11
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
	String menuidx = "13";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>


<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%
	NewsBean nb = new NewsBean();
	int result = nb.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('등록되었습니다.');
			location.replace('/asanway/cyber/cyber_news_list.jsp');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 등록되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>