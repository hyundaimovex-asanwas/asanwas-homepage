<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.12
  - 저작권 표시: IMJ Korea
  - 설명: 회원가입 완료
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ include file="/common/header.jsp" %>
<%
	//이전 단계에서 진행된 페이지(가입입력 폼) 인지 점검 step 3.
	String sRefUrl = "";
	if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = request.getParameter("name");
	String id = request.getParameter("id");

	//로그인 하기 ( cookie 부여한다.)
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);
%>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">

<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr valign="top">
	<td width="206">
		
	</td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr valign="top">
			<td bgcolor="#E4E0C2" height="29">

			</td>
		</tr>
		<tr><td height="20"></td></tr>
		<tr valign="top">
			<td>
			

				<table border="0" cellpadding="0" cellspacing="0" width="644">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- 단계-->
					<table border="0" cellpadding="0" cellspacing="0" width="">
					<tr align="center">
						<td width="83"><img src="/img/member/img_step01.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step02.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step03.gif"></td>
						<td width="72"><img src="/img/member/img_step_arrow.gif"></td>
						<td width="83"><img src="/img/member/img_step04_on.gif"></td>
					</tr>
					</table>
					<!-- //단계-->
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>



					<table border="0" cellpadding="0" cellspacing="0" width="624" height="140" background="/img/common/box_624_3_bg.gif">
					<tr>
						<td height="10" valign="top"><img src="/img/common/box_624_3_top.gif"></td>
					</tr>
					<tr>
						<td style="padding-left:30">

						<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td height="30" valign="top"><img src="/img/member/img_join_0401.gif"></td>
						</tr>
		
							<tr>
								<td style="padding-left:10"><b class="red"><%=name%></b> 님의 회원가입을 진심으로 감사 드립니다.<br>
								현대아산에서 제공하는 다양한 서비스를 제공 받으실 수 있습니다.<br><br>
								회원님의 아이디는 <b class="red"><%=id%></b> 입니다</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="10" valign="bottom"><img src="/img/common/box_624_3_bottom.gif"></td>
					</tr>
					</table>
					<!-- //약관-->

					<!-- Button-->
					<table border="0" cellpadding="0" cellspacing="0" width="624"> 
					<tr><td height="15" colspan=3></td></tr>
					<tr>
						<td align="center" width=120><a href="/index.jsp">메인방문</a></td>
						<td align="center" width=120><a href="/index.jsp">사이버 투어</a></td>
						<td align="center" width=120><a href="/index.jsp">이용가이드</a></td>
					</tr>
					</table>
					<!-- //Button-->

					<!----- //CONTENTS END----->

					</td>
				</tr>
				</table>

			</td>
		</tr>
		<tr><td height="50"></td></tr>
		<tr><td height="10" bgcolor="#F1F1DB"></td></tr> <!--//하단 10픽셀라인//-->
		</table>
	</td>
</tr>
</table>

</body>
</html>
