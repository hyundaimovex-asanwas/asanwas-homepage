<%--
  - 작성자: 김종섭 
  - 작성 일자: 2006.06.01
  - 최종 수정자 : 김종섭
  - 최종 수정일 : 2006.06.05
  - 저작권 표시: IMJ Korea
  - 설명: 로그인 아이디 / 비번 입력폼.
			action page : login_ok.jsp 
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%
	String url = request.getParameter("url");
	if(url == null || url.trim().equals("")) {
		url = "/index.jsp";
	}

	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) { 
		query = "";
	}

	String sErrStr = request.getParameter("sErrStr");
	if(sErrStr == null || sErrStr.trim().equals("")) {
		sErrStr = "1";
	}
 
	//쿠키생성시 도메인
	String sDomain = ROOT_DNS;
%>

<%
  String McNum = "0";
  String sub = "0";
  
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
<!--
	function checkForm(){

		var form = document.form;

		if( form.id.value=="" ){
			alert("아이디를 입력 하세요");
			form.id.focus();
			return;
		}

		if( form.pwd.value=="" ){
			alert("비밀번호를 입력 하세요");
			form.pwd.focus();
			return;
		}

		//return true;
		form.submit();
	}
  
  
    function popupLoginWin()
	{
		var url= "/member/pop_login.jsp";
       var window_left = (screen.width-640)/2;
       var window_top = (screen.height-480)/2;
       window.open(url,"PopLogin",'scrollbars=yes,width=640,height=400,status=yes,top=' + window_top + ',left=' + window_left + '');	
    } 
         function setFocus()
        {
            document.form.id.focus();
        }

//-->
</script>


</head>
 
<body onload="setFocus()">
 

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                     <%@ include file="../include/login/tour_login_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->

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
<form name="form" method="post" action="https://www.mtkumgang.com/member/login_ok.jsp">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="50"></td></tr>
				<tr>
					<td valign="top">
						<!-- / 로그인 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="cb11">
						<tr valign="top">
							<td width="180"><img src="<%=imageServer%>/tour_img/login/txt_login.gif" style="margin:35 0 0 27px;"></td>
							<td width="6"><img src="<%=imageServer%>/tour_img/login/vline.gif"></td>				
							<td width="484" style="padding:35 0 26 0px;">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">

                                <%
                                
                                if (sErrStr == "1" || sErrStr.equals("1")){
                                %>
								  <tr><td><img src="<%=imageServer%>/tour_img/login/txt_login111.gif"></td></tr>
								  <tr><td style="padding:18 0 19 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login112.gif"></td></tr>
                                <%
                                }else if(sErrStr == "2" || sErrStr.equals("2")) {
                                %>
								  <tr><td><img src="<%=imageServer%>/tour_img/login/txt_login121.gif"></td></tr>
								  <tr><td style="padding:18 0 19 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login122.gif"></td></tr>
                                <%
                                }else if(sErrStr == "3" || sErrStr.equals("3")) {
                                %>
								  <tr><td><img src="<%=imageServer%>/tour_img/login/txt_login131.gif"></td></tr>
								  <tr><td style="padding:18 0 19 0px;"><img src="<%=imageServer%>/tour_img/login/txt_login132.gif"></td></tr>
                                <%
                                }
                                %>

      				            <input type="hidden" name="url" value="<%=url%>">
      				            <input type="hidden" name="query" value="<%=query%>">
					            <input type=hidden name=domain value="<%=sDomain%>">
								<tr>
									<td><img src="<%=imageServer%>/tour_img/login/txt01.gif" style="margin-left:3px;">
									<input type="text" name="id" style="width:121px;margin:0 29 0 6px;" class="input09" tabindex="1">
									<img src="<%=imageServer%>/tour_img/login/txt02.gif">
									<input type="password" name="pwd" style="width:121px;margin:0 7 0 6px;" class="input09" tabindex="2" onkeypress="if (13 == event.keyCode) checkForm();">
									<a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_login.gif" align="absmiddle"></a><!-- 로그인 --></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr valign="top">
							<td colspan="2" class="bg_sky"></td>
							<td height="89" class="bg_sky">
								<table width="482" cellpadding="0" cellspacing="0" border="0" style="margin:14 0 0 2px">
								<tr valign="top">
									<td width="191" height="22"><img src="<%=imageServer%>/tour_img/login/txt03.gif"></td>
									<td><img src="<%=imageServer%>/tour_img/login/txt04.gif"></td>
								</tr>
								<tr>
									<td class="lpad_5"><a href="id_search.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_idsch.gif" class="btn"></a><!-- 아이디찾기 -->
									<a href="pwd_search.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_pwdsch.gif"></a><!-- 비밀번호찾기 --></td>
									<td class="lpad_5">

<a href="javascript:goWarning();"><img src="<%=imageServer%>/tour_img/btn/btn_userregis.gif"></a><!-- 회원가입하기 -->									
									<!--<a href="join_agreement.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_userregis.gif"></a><!-- 회원가입하기 --></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
</form>
						<!-- 로그인 / -->
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

<script language="javascript">
function goWarning(){
	
		alert("시스템 점검으로 회원가입할 수 없습니다");
		return ;
	

}
</script>

</body>
</html>