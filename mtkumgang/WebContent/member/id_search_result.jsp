<%--
  - 작성자: 김종섭
  - 작성 일자: 2006.06.01
 - 최종 수정자 : 이소연
  - 최종 수정일 : 2006.08
  - 저작권 표시: IMJ Korea
  - 설명: ID /비밀번호 찾기 결과 page 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%
	String cmd = request.getParameter("cmd");
	String result = request.getParameter("result");
	if ( result == null || result.trim().equals("") ) result ="0";	
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String semail = request.getParameter("semail");
	
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
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/login/tour_login_top.jsp" %>
		<!-------- top area / -------->

<%if (cmd.equals("IS")){%>
		<!-------- / center area - 아이디 찾기 -------->
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu09.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/login/tit_login.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">로그인</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="50"></td></tr>
				<tr>
					<td valign="top">
						<!-- / 로그인 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="cb11">
						<tr valign="top">
							<td width="180"><img src="<%=imageServer%>/tour_img/login/txt_login.gif" style="margin:35 0 0 27px;"></td>
							<td width="6"><img src="<%=imageServer%>/tour_img/login/vline.gif"></td>
							<td width="484" style="padding:35 0 18 0px;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login41.gif"></td></tr>
								<tr>
									<td style="padding:16 0 7 0px;"><strong class="txt_dblue"><%=name%></strong><img src="<%=imageServer%>/tour_img/login/txt_login421.gif" align="absmiddle"> <strong class="txt_dblue"><%=id%></strong><img src="<%=imageServer%>/tour_img/login/txt_login422.gif" align="absmiddle" hspace="5"></td>
								</tr>
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login43.gif"></td></tr>
								<tr><td style="padding:49 0 15 0px;"><a href="login.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_logindo.gif"></a><!-- 로그인하기 --></td></tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- 로그인 / -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>		
		<!--------  center Area - 아이디찾기 /-------->
<%}else if(cmd.equals("PS")){%>


		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu09.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/login/tit_login.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">로그인</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="50"></td></tr>
				<tr>
					<td valign="top">
						<!-- / 로그인 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="cb11">
						<tr valign="top">
							<td width="180"><img src="<%=imageServer%>/tour_img/login/txt_login.gif" style="margin:35 0 0 27px;"></td>
							<td width="6"><img src="<%=imageServer%>/tour_img/login/vline.gif"></td>
							<td width="484" style="padding:35 0 18 0px;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login61.gif"></td></tr>
								<tr>
									<td style="padding:16 0 7 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login621.gif" align="absmiddle"> 
									<strong class="txt_dblue"><%=semail%></strong>
									<img src="<%=imageServer%>/tour_img/login/txt_login622.gif" align="absmiddle" hspace="5"></td>
								</tr>
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login63.gif"></td></tr>
								<tr><td style="padding:33 0 15 0px;"><a href="login.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_logindo.gif"></a><!-- 로그인하기 --></td></tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- 로그인 / -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>

<%}else if(cmd.equals("SE")){%>


		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu09.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/login/tit_login.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">로그인</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="50"></td></tr>
				<tr>
					<td valign="top">
						<!-- / 로그인 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="cb11">
						<tr valign="top">
							<td width="180"><img src="<%=imageServer%>/tour_img/login/txt_login.gif" style="margin:35 0 0 27px;"></td>
							<td width="6"><img src="<%=imageServer%>/tour_img/login/vline.gif"></td>
							<td width="484" style="padding:35 0 12 0px;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/tour_img/login/txt_login71.gif"></td></tr>
								<tr><td style="padding:16 0 13 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login72.gif"></td></tr>
								<tr><td><a href="mailto:webmaster@hdasan.com"><img src="<%=imageServer%>/tour_img/login/txt_login73.gif"></a></td></tr>
								</table>
							</td>
						</tr>
						<tr valign="top">
							<td colspan="2" class="bg_sky"></td>
							<td height="100" class="bg_sky">
								<table width="482" cellpadding="0" cellspacing="0" border="0" style="margin:18 0 0 2px">
								<tr valign="top">
									<td width="191" height="30"><img src="<%=imageServer%>/tour_img/login/txt_login74.gif"></td>
								</tr>
								<tr>
								 <td>
									<a href="../member/join_agreement.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_userregis2.gif" class="btn"></a><!-- 회원가입하기 -->
									<a href="<%=sRePage%>"><img src="<%=imageServer%>/tour_img/btn/btn_reinsert.gif"></a><!-- 다시입력하기 -->
								 </td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
						<!-- 로그인 / -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>	
		
		
		
<%}%>
 

	
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