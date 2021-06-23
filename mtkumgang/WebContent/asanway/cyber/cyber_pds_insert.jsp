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
	String dirName = "";
	int maxFileSize = 0;

	if(category==""){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.\n\n다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
	 		dirName		= WEBConstants.PDSDOCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSDOCUPLOADMAX;

		}else if(category.equals("pdslaw")){
			dirName		= WEBConstants.PDSLAWUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSLAWUPLOADMAX;

		}else if(category.equals("pdsetc")){
			dirName		= WEBConstants.PDSETCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSETCUPLOADMAX;

		} else {
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다.\n\n다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	PdsBean bean = new PdsBean(dirName,maxFileSize,category);
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