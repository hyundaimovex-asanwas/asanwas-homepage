<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM
* �ۼ����� : 2005. 10. 25
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.support.EventBean" %>

<%
	EventBean sb = new EventBean();
	int result = sb.Update(request, response);
	
	String idx = (String)request.getAttribute("idx");
	String category = (String)request.getAttribute("category");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.replace('event_read.jsp?category=<%= category %>&idx=<%=idx %>');			
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