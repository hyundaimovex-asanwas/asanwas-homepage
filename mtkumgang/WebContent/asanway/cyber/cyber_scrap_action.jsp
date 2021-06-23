<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 15일
* 요약 설명 : 스크랩 마스터 공통 (신문, 잡지, 방송, 인터넷)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>

<%
	String category = request.getParameter("category");
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;

	if(category=="" || cmd ==""){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("magazine")){
	 		dirName		= WEBConstants.SCRAPUPLOADDIR ;
	 		maxFileSize	= WEBConstants.SCRAPUPLOADMAX;

		}else if(category.equals("broadcast")){
			dirName		= WEBConstants.SCRAPUPLOADDIR ;
	 		maxFileSize	= WEBConstants.SCRAPUPLOADMAX;

		}else if(category.equals("internet")){
			dirName		= WEBConstants.SCRAPUPLOADDIR ;
	 		maxFileSize	= WEBConstants.SCRAPUPLOADMAX;


		} else {
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	ScrapBean bean = new ScrapBean(dirName,maxFileSize,category);
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.replace('/asanway/cyber/cyber_scrap_list.jsp?category=<%=category%>');
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
					location.href="/asanway/cyber/cyber_scrap_read.jsp?category=<%=category%>&idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/cyber/cyber_scrap_list.jsp?category=<%=category%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>