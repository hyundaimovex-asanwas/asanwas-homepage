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


<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>

<%
	GalleryBean bean = new GalleryBean();
	int result = bean.DeleteUpdate(request, response);

	String category = (String)request.getAttribute("category");
	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			window.opener.location.replace('/asanway/cyber/cyber_gallery_list.jsp?category=<%= category %>');
			window.close(this);
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>