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
<%@ page import="common.sys.HdasanFPwd" %>
<%@ page import="sales.common.HDUtil" %>
<%
	//String pwd_step	= HDUtil.nullCheckStr(request.getParameter("pwd_step")); //��й�ȣ �缳��_����
	String url 				= HDUtil.nullCheckStr(request.getParameter("url")); //�α����� ƨ����� URL
	String ssID 			= HDUtil.nullCheckStr(session.getId());	//������ �̵��� ����ID get
	String empid		 	= HDUtil.nullCheckStr(request.getParameter("SEmpId")); //���
	String aed			 	= HDUtil.nullCheckStr(request.getParameter("txt_aed")); //���̵�
	String pwd1			= HDUtil.nullCheckStr(request.getParameter("txt_pwd1")); //�α����� ƨ����� URL
	String pwd2			= HDUtil.nullCheckStr(request.getParameter("txt_pwd2")); //�α����� ƨ����� URL
	String login_msg		= "�ʿ��� ���� ���������� �Էµ��� �ʾҽ��ϴ�.";
	

	//if(url == null || url.trim().equals("")) {
	//	url = "/portal.jsp";
	//}

	String query = HDUtil.nullCheckStr(request.getParameter("query"));
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	HdasanFPwd hl = new HdasanFPwd();
	int result = hl.SetFPwd(request, response); //�н����� ����
%>

<% if(result == 537 ) { //-- ������ ��� %>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="empid" type="hidden" value="<%=empid%>" />
		</form>
		<script language=javascript>
			alert("������ ������ �Ǿ����ϴ�.");
			document.movForm.action="/services/newIndeX.jsp";
			document.movForm.submit();		</script>
<% } else if(result == 0) { // ��ϵ� ID�� �ƴѰ��
	request.getSession().setAttribute( "loginMSG", login_msg);
%>
		<form name="movForm" id="movForm" method="post">
			<input name="ssID" type="hidden" value="<%=ssID%>" />
			<input name="result_cd" type="hidden" value="<%=result%>" />
		</form>
		<script language="javascript">
			alert("������Ͽ� ������ �߻��Ͽ����ϴ�.");
			document.movForm.action="/services/newFPwd1.jsp";
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
			alert("������Ͽ� ������ �߻��Ͽ����ϴ�.");
			document.movForm.action="/services/newFPwd1.jsp";
			document.movForm.submit();
		</script>
<% } %>