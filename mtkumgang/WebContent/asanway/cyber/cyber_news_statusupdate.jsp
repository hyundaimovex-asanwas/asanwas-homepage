<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( czar.pe.kr@gmail.com )
* �ۼ����� : 2005. 10. 14
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%

	NewsBean bean = new NewsBean();
	int result = bean.UpdateStatus(request, response);
	
	String idx = (String)request.getAttribute("idx");
%>

<% if(result > 0 ) { %>
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			//location.replace('/asanway/cyber/cyber_news_list.jsp?idx=<%= idx %>');
		</script>
	</body>
	</html>
<% } else {	%>
	<html>
	<body>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			//history.go(-1);
		</script>
	</body>
	</html>		
<% } %>		