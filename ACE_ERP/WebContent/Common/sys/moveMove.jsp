<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ERP page move
 * ���α׷�ID 	: moveMove
 * J  S  P		: moveMove.jsp
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2011-06-14
 * �������		: �������� �̵�ó��
 * [ �������� ][������] ����
 * 
 *****************************************************************************/
%>
<%
	String tUrl = request.getParameter("tUrl"); //���� ������
	String tQry = request.getParameter("tQry"); //get �Ķ���� (�޴��ε��� ����..)
	String ssID = session.getId();	//������ �̵��� ����ID get

	if(tUrl == null || tUrl.trim().equals("")) {
		tUrl = "/newIndeX.jsp";
	}
	if(tQry == null || tQry.trim().equals("")) {
		tQry = "";
	}
	tQry = tQry.replaceAll("/", "&");
%>
	<form name="movForm" id="movForm" method="post">
		<input name="ssID" type="hidden" value="<%=ssID%>" />
	</form>
	<script language=javascript>
		document.movForm.action="<%=tUrl%>?<%=tQry%>";
		document.movForm.submit();
	</script>
