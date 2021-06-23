
<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 08일
* 요약 설명 : 로그인 체크
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String memberlevel = (String)session.getAttribute("memberlevel");
	if(!memberlevel.equals("2")){
		out.println("<script language=javascript>");
		out.println("	alert('임직원만 이용가능합니다.');");
		out.println("	history.go(-2);");
		out.println("	</script>");
		//response.sendRedirect("/index.jsp");
		return;
	}
%>
