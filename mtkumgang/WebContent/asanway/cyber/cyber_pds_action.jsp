<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 10�� 21��
* ��� ���� : �ڷ�� �Խù� ���(����, ���ù���, ��Ÿ �ڷ�� ����)
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>
<%@ page import ="com.hmm.asan.common.util.WEBConstants"%>
<%@ page import="com.hmm.asan.asanway.cyber.PdsBean" %>

<%
	String category = request.getParameter("category");
	String cmd = request.getParameter("cmd");
	String dirName = "";
	int maxFileSize = 0;
	String menuidx = "";

	if(category=="" || cmd ==""){
		out.println("<script language=javascript>");
		out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
	 		dirName		= WEBConstants.PDSDOCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSDOCUPLOADMAX;
	 		menuidx = "23";

		}else if(category.equals("pdslaw")){
			dirName		= WEBConstants.PDSLAWUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSLAWUPLOADMAX;
	 		menuidx = "24";

		}else if(category.equals("pdsetc")){
			dirName		= WEBConstants.PDSETCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSETCUPLOADMAX;
	 		menuidx = "26";

		} else {
			out.println("<script language=javascript>");
			out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	PdsBean bean = new PdsBean(dirName,maxFileSize,category);
%>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<%
	if(cmd.equals("I") ) {
		int result = bean.Insert(request, response);
%>

	<% if(result > 0 ) { %>
			<script language=javascript>
				alert('��ϵǾ����ϴ�.');
				location.replace('/asanway/cyber/cyber_pds_list.jsp?category=<%=category%>');
			</script>
	<% } else {	%>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-1);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {
			int result = bean.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.href="/asanway/cyber/cyber_pds_read.jsp?category=<%=category%>&idx=<%=request.getAttribute("idx")%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("D") ) {
			int result = bean.DeleteUpdate(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�..');
					location.href="/asanway/cyber/cyber_pds_list.jsp?category=<%=category%>";
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>
<% } %>