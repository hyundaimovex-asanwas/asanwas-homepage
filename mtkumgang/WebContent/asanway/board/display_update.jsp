<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 5�� 11��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>

<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="com.idteck.eng.newsroom.notice.NoticeBean" %>

<%
	NoticeBean nb = new NoticeBean();
	int result = nb.NoticeDisplayUpdate(request, response);
%>

<% if(result > 0 ) { %>
		<script language=javascript>
			//alert('�����Ǿ����ϴ�.');
			location.href="/admin/newsroom/notice/notice_list.jsp";
		</script>
<% } else {	%>
		<script language=javascript>
			alert('���������� �������� �ʾҽ��ϴ�.');
			history.go(-1);
		</script>
<% } %>