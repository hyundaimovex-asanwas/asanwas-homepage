<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: ERP new Passward 재지정
 * 프로그램ID 	: newPwd
 * J  S  P		: newPwd_act.jsp
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-09-02
 * 기능정의		: 패스워드 재지정
 * [ 수정일자 ][수정자] 내용
 * [2011-09-02][박경국] 
 *****************************************************************************/
%>
<%@ page import="common.sys.HdasanPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<%
	String pwd_step	 	= HDUtil.nullCheckStr(request.getParameter("pwd_step")); //비밀번호 재설정_스텝
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //로그인이 튕기기전 URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//페이지 이동간 세션ID get
	String aed	 			= HDUtil.nullCheckStr(request.getParameter("txt_aed")); //아이디
	String login_msg		= "필요한 값이 정상적으로 입력되지 않았습니다.";
	String ssn	 			= HDUtil.nullCheckStr(request.getParameter("txt_jminno")); //주민번호

	//if(url == null || url.trim().equals("")) {
	//	url = "/portal.jsp";
	//}

	String query = HDUtil.nullCheckStr(request.getParameter("query"));
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	HdasanPwd hl = new HdasanPwd();
	int result = hl.Pwd(request, response); //로긴 처리


	if(result == 537 ) { //-- 정상인 경우 %>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="ssn" type="hidden" value="<%=ssn%>" />
			<input name="aed" type="hidden" value="<%=aed%>" />
		</form>
		<script language=javascript>
		<%if(url != null && !url.trim().equals("")) { %>
			document.movForm.action="<%=url%>?<%=query%>";
			document.movForm.submit();
		<% } else { %>
			var f = document.movForm;
				f.action="https://www.mtkumgang.com/popup/safe_hs_cert2_pwd.jsp";
//				https://www.mtkumgang.com/popup/safe_hs_cert2.jsp
				f.method = "POST";
				
				f.target="";
				
				f.submit();
			
		<% } %>
		</script>
<% } else if(result == 0) { // 등록된 ID가 아닌경우
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("회원정보가 부정확합니다.");
			document.movForm.action="<%=dirPath%>/newPwd1.jsp";
			document.movForm.submit();
		</script>
<% } else { //비밀번호가 틀린경우
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("회원정보가 부정확합니다.");
			document.movForm.action="<%=dirPath%>/newPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>