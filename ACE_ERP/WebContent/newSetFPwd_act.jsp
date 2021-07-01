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
<%@ page import="common.sys.HdasanFPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%
	//String pwd_step	= HDUtil.nullCheckStr(request.getParameter("pwd_step")); //비밀번호 재설정_스텝
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //로그인이 튕기기전 URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//페이지 이동간 세션ID get
	String empid		 	= HDUtil.nullCheckStr(request.getParameter("SEmpId")); //사번
	String aed			 	= HDUtil.nullCheckStr(request.getParameter("txt_aed")); //아이디
	String pwd1			= HDUtil.nullCheckStr(request.getParameter("txt_pwd1")); //로그인이 튕기기전 URL
	String pwd2			= HDUtil.nullCheckStr(request.getParameter("txt_pwd2")); //로그인이 튕기기전 URL
	String login_msg		= "필요한 값이 정상적으로 입력되지 않았습니다.";
	

	//if(url == null || url.trim().equals("")) {
	//	url = "/portal.jsp";
	//}

	String query = HDUtil.nullCheckStr(request.getParameter("query"));
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	HdasanFPwd hl = new HdasanFPwd();
	int result = hl.SetFPwd(request, response); //패스워드 설정
%>

<% if(result == 537 ) { //-- 정상인 경우 %>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="empid" type="hidden" value="<%=empid%>" />
		</form>
		<script language=javascript>
			alert("계정이 정상등록 되었습니다.");
			document.movForm.action="/services/newIndeX.jsp";
			document.movForm.submit();		</script>
<% } else if(result == 0) { // 등록된 ID가 아닌경우
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("계정등록에 오류가 발생하였습니다.");
			document.movForm.action="/services/newFPwd1.jsp";
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
			alert("계정등록에 오류가 발생하였습니다.");
			document.movForm.action="/services/newFPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>