<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 10월 20일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
* 2005/11/12 : 김미의 : 답변형 게시판으로 수정
******************************************/
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.admin.NoticeBean" %>

<%
	String category = "adminbbs";
	String cmd = request.getParameter("cmd");
	String dirName = WEBConstants.ADMINNOTICEUPLOADDIR;
	int maxFileSize = WEBConstants.ADMINNOTICEUPLOADMAX;

	NoticeBean bean = new NoticeBean(dirName,maxFileSize,category);
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.replace('/asanway/admin/admin_notice.jsp');
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
					location.href="/asanway/admin/admin_notice_read.jsp?idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/admin/admin_notice.jsp";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>