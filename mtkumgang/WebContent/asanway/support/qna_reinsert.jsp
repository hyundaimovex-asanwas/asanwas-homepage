<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM 
* �ۼ����� : 2005. 10. 21
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
	String menuidx = "29";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>

<%@ page import="com.hmm.asan.asanway.support.QnaBean" %>

<%
	QnaBean bean  = new QnaBean();
	int result = bean.Insert(request, response);
	
	String category = (String)request.getAttribute("category");
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('��ϵǾ����ϴ�.');			
			location.replace('qna_list.jsp?category=<%= category %>');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>