<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005�� 10�� 11��
* ��༳�� :�α��� ó��
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="com.hmm.asan.asanway.admin.LoginBean" %>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	String url = request.getParameter("url");

	if(url == null || url.trim().equals("")) {
		url = "/asanway/admin/admin_main.jsp";
	}

	String query = request.getParameter("query");
	if(query == null || query.trim().equals("")) {
		query = "";
	}
	query = query.replaceAll("/", "&");

	LoginBean lb = new LoginBean();

	int result = lb.Login(request, response);
%>

<% if(result == 1 ) { %>
<!-- ������ ��� -->
		<script language=javascript>
			<%if(url != null && !url.trim().equals("")) { %>
				location.href="<%=url%>?<%=query%>";
			<% } else { %>
				location.href="/asanway/main.jsp";
			<% } %>

		</script>

<% } else if(result == 0) { %>
<!-- ��ϵ� ID�� �ƴѰ�� -->
		<script language=javascript>
			alert('��ϵ� ID��  �ƴմϴ�.');
			history.go(-1);
		</script>

<% } else { %>
<!-- ��й�ȣ�� Ʋ�����  -->
		<script language=javascript>
			alert('��й�ȣ�� Ȯ���ϼ���!');
			history.go(-1);
		</script>

<% } %>