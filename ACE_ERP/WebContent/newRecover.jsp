<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: 비밀번호재설정_frameset
 * 프로그램ID 	: newRecover
 * J  S  P		: newRecover.jsp
 * 작 성 자		: 심동현
 * 작 성 일		: 2011-09-07
 * 기능정의		: 비밀번호재설정_frameset
 * [ 수정일자 ][수정자] 내용
 *****************************************************************************/
%>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<HTML>
<HEAD>
<TITLE>비밀번호 찾기</TITLE>
<FRAMESET ROWS="100%,*" BORDER="0">
	<FRAME SRC="<%=dirPath%>/newPwd1.jsp" NAME=main BORDER=0 MARGINWIDTH=0 LEFTMARGIN=0 MARGINHEIGHT=0 TOPMARGIN=0 SCROLLING="auto">
	<FRAME SRC="about:blank" NAME="hidden" BORDER=0 MARGINWIDTH=0 LEFTMARGIN=0 MARGINHEIGHT=0 TOPMARGIN=0 SCROLLING="no" noresize>
</FRAMESET>
<NOFRAMES>
<BODY>
<P>이 페이지를 보려면, 프레임을 볼 수 있는 브라우저가 필요합니다.</P>
</BODY>
</NOFRAMES>
</FRAMESET>
</HTML>