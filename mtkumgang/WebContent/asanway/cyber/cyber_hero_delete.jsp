<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005. 10. 14
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
	String menuidx = "18";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<%@ page import="com.hmm.asan.asanway.cyber.HeroBean" %>

<%
	HeroBean hb = new HeroBean();
	int result = hb.DeleteUpdate(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('삭제되었습니다.');
			location.replace('/asanway/cyber/cyber_hero_list.jsp');
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 삭제되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>