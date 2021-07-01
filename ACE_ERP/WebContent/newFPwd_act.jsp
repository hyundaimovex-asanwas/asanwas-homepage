<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	: ERP new Passward 최초지정
 * 프로그램ID 	: newFPwd
 * J  S  P		: newFPwd_act.jsp
 * 작 성 자		: 박경국
 * 작 성 일		: 2011-09-19
 * 기능정의		: 패스워드 최초지정
 * [ 수정일자 ][수정자] 내용
 * [2011-09-19][박경국] 
 * [2013-03-18][박경국] 본인인증서비스(주민등록번호 기반) ==>본인확인서비스(생년월일 기반)
 *****************************************************************************/
%>
<%@ page import="common.sys.HdasanFPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>
<%
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //로그인이 튕기기전 URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//페이지 이동간 세션ID get
	String empid 				= HDUtil.nullCheckStr(request.getParameter("txt_empid")); //사번
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

	HdasanFPwd hl = new HdasanFPwd();
	int result = hl.FPwd(request, response); //로긴 처리


	if(result == 537 ) { //-- 정상인 경우 %>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="ssn" type="hidden" value="<%=ssn%>" />
			<input name="empid" type="hidden" value="<%=empid%>" />
		</form>
		<script language=javascript>
		<%if(url != null && !url.trim().equals("")) { %>
			document.movForm.action="<%=url%>?<%=query%>";
			document.movForm.submit();
		<% } else { %>
			var f = document.movForm;
				f.action="https://www.mtkumgang.com/popup/safe_hs_cert2.jsp";
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
			alert("회원정보가 부정확합니다.001");
			document.movForm.action="<%=dirPath%>/newFPwd1.jsp";
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
			alert("회원정보가 부정확합니다.002");
			document.movForm.action="<%=dirPath%>/newFPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>