<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �� �� �� : �����
* �ۼ����� : 2005. 10. 14
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
	String menuidx = "18";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<%@ page import="com.hmm.asan.asanway.cyber.HeroBean" %>

<%
	HeroBean hb = new HeroBean();
	int result = hb.DeleteUpdate(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.replace('/asanway/cyber/cyber_hero_list.jsp');
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>