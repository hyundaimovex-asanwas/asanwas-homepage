<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM
* �ۼ����� : 2005. 10. 14
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%@ page import="com.hmm.asan.etc.AddFunction" %>

<%
	AddFunction bean = new AddFunction();
	int result = bean.UpdateStatus(request, response);

	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
		</script>
	</body>
	</html>
<% } %>