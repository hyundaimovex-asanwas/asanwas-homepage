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


<%@ page import="com.hmm.asan.asanway.cyber.GalleryBean" %>

<%
	GalleryBean bean = new GalleryBean();
	int result = bean.Insert(request, response);

	String category = (String)request.getAttribute("category");
	String menuidx = "";
	if(category.equals("gallery")){
		menuidx = "17";
	}else{
		menuidx = "22";
	}
%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('��ϵǾ����ϴ�.');
			location.replace('/asanway/cyber/cyber_gallery_list.jsp?category=<%= category %>');
//			location.href = "/asanway/cyber/cyber_news_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>