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
	String dirName = "";
	int maxFileSize = 0;

	if(category==""){
		out.println("<script language=javascript>");
		out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("pdsdoc")){
	 		dirName		= WEBConstants.PDSDOCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSDOCUPLOADMAX;

		}else if(category.equals("pdslaw")){
			dirName		= WEBConstants.PDSLAWUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSLAWUPLOADMAX;

		}else if(category.equals("pdsetc")){
			dirName		= WEBConstants.PDSETCUPLOADDIR ;
	 		maxFileSize	= WEBConstants.PDSETCUPLOADMAX;

		} else {
			out.println("<script language=javascript>");
			out.println("	alert('�߸��� ��η� �����ϼ̽��ϴ�.\n\n�ٽ� �õ��� �ֽʽÿ�.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}

	PdsBean bean = new PdsBean(dirName,maxFileSize,category);
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