<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM
* �ۼ����� : 2005. 10. 11
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ include file="/asanway/common/head.jsp" %><%@ page import="com.hmm.asan.asanway.admin.AuthBean" %><%	String menuidx = "27";	AuthBean auth = new AuthBean();	if (!auth.AuthCheck(request, response, menuidx)){		response.sendRedirect("support_main.jsp?flag=1");	}%>
<%@ page import="com.hmm.asan.asanway.support.SupportBean" %>

<%
	SupportBean sb = new SupportBean();
	int result = sb.Update(request, response);
	
	String idx = (String)request.getAttribute("idx");
	String category = (String)request.getAttribute("category");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
//			location.href="/asanway/cyber/cyber_news_read.jsp?idx=<%= idx %>";
			location.replace('read.jsp?category=<%= category %>&idx=<%=idx %>');			
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