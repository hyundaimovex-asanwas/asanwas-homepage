<%@ page language="java" contentType="text/html; charset=EUC-KR"%>
<%/****************************************** �� �� �� : Mr.K JM* �ۼ����� : 2005. 10. 25* ��༳�� :*** �����ð�  : ������ : ��������*******************************************/%>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "31";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>
<%@ page import="com.hmm.asan.asanway.support.PollBean" %><%	PollBean sb = new PollBean();	int result = sb.Update(request, response);	String idx = (String)request.getAttribute("idx");%><% if(result > 0 ) { %>	<html>	<body>		<script language=javascript>			alert('�����Ǿ����ϴ�.');			location.replace('poll_read.jsp?idx=<%=idx %>');		</script>	</body>	</html><% } else {	%>	<html>	<body>		<script language=javascript>			alert('���������� �������� �ʾҽ��ϴ�.');			history.go(-1);		</script>	</body>	</html><% } %>