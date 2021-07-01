<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: ERP page move
 * 프로그램ID 	: moveMove
 * J  S  P		: moveMove.jsp
 * 작 성 자		: 심동현
 * 작 성 일		: 2011-06-14
 * 기능정의		: 페이지간 이동처리
 * [ 수정일자 ][수정자] 내용
 * 
 *****************************************************************************/
%>
<%
	String tUrl = request.getParameter("tUrl"); //목적 페이지
	String tQry = request.getParameter("tQry"); //get 파라미터 (메뉴인덱스 정도..)
	String ssID = session.getId();	//페이지 이동간 세션ID get

	if(tUrl == null || tUrl.trim().equals("")) {
		tUrl = "/newIndeX.jsp";
	}
	if(tQry == null || tQry.trim().equals("")) {
		tQry = "";
	}
	tQry = tQry.replaceAll("/", "&");
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=ssID%>" />
	</form>
	<script language=javascript>
		document.movForm.action="<%=tUrl%>?<%=tQry%>";
		document.movForm.submit();
	</script>
