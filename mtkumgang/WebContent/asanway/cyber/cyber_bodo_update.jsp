<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( czar.pe.kr@gmail.com )
* �ۼ����� : 2005. 10. 11
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@include file="/asanway/common/head.jsp"%>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "14";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.cyber.BodoBean" %>

<%
	BodoBean bean = new BodoBean();
	int result = bean.Update(request, response);
	
	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.replace('/asanway/cyber/cyber_bodo_read.jsp?idx=<%= idx %>');
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
	</body>
	</html>		
<% } %>		