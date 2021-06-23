<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 5월 11일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="com.idteck.eng.newsroom.notice.NoticeBean" %>

<%
	NoticeBean nb = new NoticeBean();
	int result = nb.NoticeDisplayUpdate(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('수정되었습니다.');
			location.href="/admin/newsroom/notice/notice_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('정상적으로 수정되지 않았습니다.');
			history.go(-1);
		</script>
<% } %>