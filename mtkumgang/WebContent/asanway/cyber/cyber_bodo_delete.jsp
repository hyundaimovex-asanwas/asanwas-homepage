<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( mrkczar@gmail.com )
* �ۼ����� : 2005. 10. 13
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
	int result = bean.DeleteUpdate(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.replace('/asanway/cyber/cyber_bodo_list.jsp');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>