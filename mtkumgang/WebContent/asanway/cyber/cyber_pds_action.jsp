<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 21일
* 요약 설명 : 자료실 게시물 등록(문서, 관련법률, 기타 자료실 공통)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>
<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.cyber.PdsBean" %>

<%
	String category = request.getParameter("category");
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;
	String menuidx = "";

	if(category=="" || cmd ==""){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.\n\n다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
	 		dirName		= WEBConstants.PDSDOCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSDOCUPLOADMAX;
	 		menuidx = "23";

		}else if(category.equals("pdslaw")){
			dirName		= WEBConstants.PDSLAWUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSLAWUPLOADMAX;
	 		menuidx = "24";

		}else if(category.equals("pdsetc")){
			dirName		= WEBConstants.PDSETCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSETCUPLOADMAX;
	 		menuidx = "26";

		} else {
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다.\n\n다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	PdsBean bean = new PdsBean(dirName,maxFileSize,category);
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
				location.replace('/asanway/cyber/cyber_pds_list.jsp?category=<%=category%>');
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
					location.href="/asanway/cyber/cyber_pds_read.jsp?category=<%=category%>&idx=<%=request.getAttribute("idx")%>";
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
					location.href="/asanway/cyber/cyber_pds_list.jsp?category=<%=category%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 삭제되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>
<% } %>