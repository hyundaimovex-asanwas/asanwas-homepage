<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 17일
* 요약 설명 : EngNotice - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.eng.NewsBean" %>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "32";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("eng_main.jsp?flag=1");
	}
%>


<%
	String category = "engnews";
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;

 	dirName		= WEBConstants.ENGNEWSUPLOADDIR ;
 	maxFileSize	= WEBConstants.ENGNEWSUPLOADMAX ;

	NewsBean bean = new NewsBean(dirName,maxFileSize,category);
%>
<%
if(cmd.equals("I") ) {
	int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.href="/asanway/eng/cyber_news_list.jsp";
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-1);
			</script>
	<% } %>

<% } else if( cmd.equals("U") ) {
			int result = bean.Update(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.href="/asanway/eng/cyber_news_read.jsp?idx=<%=request.getAttribute("idx") %>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } else if( cmd.equals("D") ) {
			int result = bean.DeleteUpdate(request, response);
%>

		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('삭제되었습니다..');
					location.href="/asanway/eng/cyber_news_list.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>

<% } %>