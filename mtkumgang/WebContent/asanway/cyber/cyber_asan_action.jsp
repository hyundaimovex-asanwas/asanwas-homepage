<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 25일
* 요약 설명 : 아산인-수다 /자료실
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.cyber.AsanBean" %>

<%
	String category = request.getParameter("category");
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;
	String menuidx = "";

	if(category=="" || cmd ==""){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("asantalk")){
	 		dirName		= WEBConstants.ASANPDSUPLOADDIR ;
	 		maxFileSize	= WEBConstants.ASANPDSUPLOADMAX;
	 		menuidx = "18";

		}else if(category.equals("asanpds")){
			dirName		= WEBConstants.ASANPDSUPLOADDIR ;
	 		maxFileSize	= WEBConstants.ASANPDSUPLOADMAX;
	 		menuidx = "18";

	 	}else if(category.equals("asannotice")){
			dirName		= WEBConstants.ASANNOTICEUPLOADDIR ;
	 		maxFileSize	= WEBConstants.ASANNOTICEUPLOADMAX;
	 		menuidx = "18";

		}else if(category.equals("weeklytrend")){
			dirName		= WEBConstants.WEEKLYTRENDUPLOADDIR ;
	 		maxFileSize	= WEBConstants.WEEKLYTRENDUPLOADMAX;
	 		menuidx = "20";

	 	}else if(category.equals("echo")){
			dirName		= WEBConstants.ECHOUPLOADDIR ;
	 		maxFileSize	= WEBConstants.ECHOUPLOADMAX;
	 		menuidx = "20";

		} else {
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다.다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	AsanBean bean = new AsanBean(dirName,maxFileSize,category);
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('등록되었습니다.');
				location.replace('/asanway/cyber/cyber_asan_list.jsp?category=<%=category%>');
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
					location.href="/asanway/cyber/cyber_asan_read.jsp?category=<%=category%>&idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/cyber/cyber_asan_list.jsp?category=<%=category%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>