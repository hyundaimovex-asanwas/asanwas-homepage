
<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 08��
* ��� ���� : �α��� üũ
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%
	String memberlevel = (String)session.getAttribute("memberlevel");
	if(!memberlevel.equals("2")){
		out.println("<script language=javascript>");
		out.println("	alert('�������� �̿밡���մϴ�.');");
		out.println("	history.go(-2);");
		out.println("	</script>");
		//response.sendRedirect("/index.jsp");
		return;
	}
%>
