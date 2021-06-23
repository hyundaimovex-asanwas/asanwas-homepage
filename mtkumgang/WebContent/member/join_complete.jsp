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
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
	//이전 단계에서 진행된 페이지(가입입력 폼) 인지 점검 step 3.
	String sRefUrl = "";
	if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	if ( sRefUrl.indexOf("member_action.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");
	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	//로그인 하기 ( cookie 부여한다.)
	LoginBean lb = new LoginBean();
	int result = lb.Login(request, response);
%>
<%
  String McNum= "0";
  String sub= "0";
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">

function popType1(){
   Q_navi03();
   location.replace("/index.jsp");
}

</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/member/tour_member_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu07.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mem/tit_mem01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">회원가입</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mem/img_top_mem03.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem3.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:33 0 30 7px;"><img src="<%=imageServer%>/tour_img/bu/bu_dblue_arw.gif" hspace="3" vspace="3" align="texttop"><strong><span class="txt_sky"><%=name%></span> 회원님</strong>께서는 금강산관광      홈페이지에서 제공하는 다양하고 유익한 정보와 컨텐츠를 자유롭게 이용하실 수 있습니다.<br>&nbsp;&nbsp;아름다운 금강산 관광에 필요한 정보와 지식으로 더욱 알차고 편리한 금강산 여행을 준비하세요.</td>
						</tr>
						</table>

						<!-- / 아이디 ,비번 확인  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="115"><col width="565" class="lpad_10">
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_registok1.gif"><!-- 아이디 --></td>
							<td><strong><span class="txt_sky"><%=id%></span></td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26"><img src="<%=imageServer%>/tour_img/mem/txt_registok2.gif"><!-- 비밀번호 --></td>
							<td><%=pwd%></td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						</table>
						<!-- 아이디 ,비번 확인 / -->

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td colspan="3" style="padding:24 0 21 13px;" class="fs11 lh14">회원님의 ID와 비밀번호는 철저하고 신중하게 관리하시기를 바라며 금강산관광      홈페이지(mtKumGang)에 지속적인 애정과<br>사랑을 부탁 드립니다.<br>회원님의 개인정보를 변경하시려면 <a href="#"><strong class="fs11">마이페이지>개인정보수정 메뉴</strong></a>를 이용하시기 바랍니다.</td>
						</tr>
						<tr><td height="1" colspan="3" class="line_dg"></td></tr>
						<tr><td height="59" colspan="3"></td></tr>
						<tr valign="top">
							<td><a href="/index.jsp" onfocus="this.blur();"><img src="<%=imageServer%>/tour_img/mem/img_s_mem31.jpg"></a></td>
							<td><a href="javascript:popType1()" onfocus="this.blur();"><img src="<%=imageServer%>/tour_img/mem/img_s_mem32.jpg"></a></td>
							<td><a href="/start/packup01.jsp" onfocus="this.blur();"><img src="<%=imageServer%>/tour_img/mem/img_s_mem33.jpg"></a></td>
						</table>
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>