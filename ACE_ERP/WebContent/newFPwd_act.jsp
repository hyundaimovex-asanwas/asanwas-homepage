<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ERP new Passward ��������
 * ���α׷�ID 	: newFPwd
 * J  S  P		: newFPwd_act.jsp
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-09-19
 * �������		: �н����� ��������
 * [ �������� ][������] ����
 * [2011-09-19][�ڰ汹] 
 * [2013-03-18][�ڰ汹] ������������(�ֹε�Ϲ�ȣ ���) ==>����Ȯ�μ���(������� ���)
 *****************************************************************************/
%>
<%@ page import="common.sys.HdasanFPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<%
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //�α����� ƨ����� URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//������ �̵��� ����ID get
	String empid 				= HDUtil.nullCheckStr(request.getParameter("txt_empid")); //���
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

	HdasanFPwd hl = new HdasanFPwd();
	int result = hl.FPwd(request, response); //�α� ó��


	if(result == 537 ) { //-- ������ ��� %>
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
<% } else if(result == 0) { // ��ϵ� ID�� �ƴѰ��
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("ȸ�������� ����Ȯ�մϴ�.001");
			document.movForm.action="<%=dirPath%>/newFPwd1.jsp";
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
			alert("ȸ�������� ����Ȯ�մϴ�.002");
			document.movForm.action="<%=dirPath%>/newFPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>