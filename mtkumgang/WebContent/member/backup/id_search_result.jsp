<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: ID /비밀번호 찾기 결과 page 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%
	String cmd = request.getParameter("cmd");
	String result = request.getParameter("result");
	if ( result == null || result.trim().equals("") ) result ="0";	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String sRePage = "";

	if ( result.equals("0") && ( cmd.equals("IS") || cmd.equals("PS") ) )
	{
		// return page url
		if ( cmd.equals("IS") ) 
			sRePage = "/member/id_search.jsp";
		else
			sRePage = "/member/pwd_search.jsp";

		//error show
		cmd = "SE";
	}

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
			

				<table border="0" cellpadding="0" cellspacing="0" width="644" id="tarea">
				<tr>
					<td align="center">

					<!----- CONTENTS START----->
					<!-- 아이디 찾기-->
					<%if (cmd.equals("IS")){%>
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"><img src="/img/member/img_search_0103.gif"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10"><b class="red"><%=name%></b> 님의 아이디는 <b class="red"><%=id%></b> 입니다.</td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //아이디 찾기-->
						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/login.jsp"><img src="/img/common/btn_submit.gif"></a>&nbsp;
							<!--<a href="#"><img src="/img/common/btn_rewrite.gif"></a></td>-->
						</tr>
						</table>
						<!-- //Button-->

					<%}else if(cmd.equals("PS")){%>
						<table border="0" cellpadding="0" cellspacing="0" width="644" height="50"><tr><td></td></tr></table>

						<!-- 비밀번호 찾기-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"><img src="/img/member/img_search_0104.gif"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10">회원님의 비밀번호를 회원가입시 입력하신 이메일 주소로 발송했습니다. </td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //비밀번호 찾기-->

						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/login.jsp"><img src="/img/common/btn_submit.gif"></a>&nbsp;
							<!--<a href="#"><img src="/img/common/btn_rewrite.gif"></a></td>-->
						</tr>
						</table>
						<!-- //Button-->
					<%}else if(cmd.equals("SE")){%>
					<table border="0" cellpadding="0" cellspacing="0" width="644" height="50"><tr><td></td></tr></table>

						<!-- 에러출력 -->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr>
							<td style="padding-left:10"></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="510" height="130" background="/img/common/box_510_bg.gif">
						<tr>
							<td height="10" valign="top"><img src="/img/common/box_510_top.gif"></td>
						</tr>
						<tr>
							<td align="center">

							<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="padding-left:10">
										<b>"입력하신 정보와 일치하는 회원정보가 없습니다"</b>
										<br><br>가입/탈퇴 여부를 다시 한번 확인하여 주시기 바랍니다.
										<br>로그인과 관련하여 계속 문제가 발생하는 경우 홈페이지 관리자에게 문의하여 주십시오.
										<br>webamster@hdasan.com
										<br>아직 금강산관광 홈페이지의 회원이 아니시라면 지금 회원가입을 하셔서 편리한 서비르를 제공받으세요.
										<br>
								</td>
							</tr>
							</table>

							</td>
						</tr>
						<tr>
							<td height="10" valign="bottom"><img src="/img/common/box_510_bottom.gif"></td>
						</tr>
						</table>
						<!-- //에러출력 -->

						<!-- Button-->
						<table border="0" cellpadding="0" cellspacing="0" width="510">
						<tr><td height="15"></td></tr>
						<tr>
							<td align="center"><a href="/member/join_name.jsp">회원가입하기</a>&nbsp;
							<a href="<%=sRePage%>"> 다시입력하기 </a></td>
						</tr>
						</table>
						<!-- //Button-->
					<%}%>
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
