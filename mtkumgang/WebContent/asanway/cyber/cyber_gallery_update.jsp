<%@ page language="java" contentType="text/html; charset=EUC-KR"%>

<%
/****************************************
*
* �� �� �� : Mr.K JM ( czar.pe.kr@gmail.com )
* �ۼ����� : 2005. 10. 11
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
	int result = bean.Update(request, response);

	String idx = (String)request.getAttribute("idx");
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
	<html>
	<body>
		<script language=javascript>
			alert('�����Ǿ����ϴ�.');
			location.replace("/asanway/cyber/cyber_gallery_list.jsp?category=<%= category %>");
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