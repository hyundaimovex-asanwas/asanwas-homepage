<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ERP new Passward ������
 * ���α׷�ID 	: newPwd
 * J  S  P		: newPwd_act.jsp
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-09-02
 * �������		: �н����� ������
 * [ �������� ][������] ����
 * [2011-09-02][�ڰ汹] 
 *****************************************************************************/
%>
<%@ page import="common.sys.HdasanPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<%
	String pwd_step	 	= HDUtil.nullCheckStr(request.getParameter("pwd_step")); //��й�ȣ �缳��_����
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //�α����� ƨ����� URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//������ �̵��� ����ID get
	String aed	 			= HDUtil.nullCheckStr(request.getParameter("txt_aed")); //���̵�
	String login_msg		= "�ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�.";
	String ssn	 			= HDUtil.nullCheckStr(request.getParameter("txt_jminno")); //�ֹι�ȣ

	//if(url == null || url.trim().equals("")) {
	//	url = "/portal.jsp";
	//}

	String query = HDUtil.nullCheckStr(request.getParameter("query"));
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	HdasanPwd hl = new HdasanPwd();
	int result = hl.Pwd(request, response); //�α� ó��


	if(result == 537 ) { //-- ������ ��� %>
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
<% } else if(result == 0) { // ��ϵ� ID�� �ƴѰ��
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("ȸ�������� ����Ȯ�մϴ�.");
			document.movForm.action="<%=dirPath%>/newPwd1.jsp";
			document.movForm.submit();
		</script>
<% } else { //��й�ȣ�� Ʋ�����
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("ȸ�������� ����Ȯ�մϴ�.");
			document.movForm.action="<%=dirPath%>/newPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>