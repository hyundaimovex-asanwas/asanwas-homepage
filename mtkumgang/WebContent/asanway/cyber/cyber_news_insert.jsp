<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( mrkczar@gmail.com )
* �ۼ����� : 2005. 10. 11
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "13";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>


<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>

<%
	NewsBean nb = new NewsBean();
	int result = nb.Insert(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('��ϵǾ����ϴ�.');
			location.replace('/asanway/cyber/cyber_news_list.jsp');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>