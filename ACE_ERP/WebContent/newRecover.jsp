<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ��й�ȣ�缳��_frameset
 * ���α׷�ID 	: newRecover
 * J  S  P		: newRecover.jsp
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2011-09-07
 * �������		: ��й�ȣ�缳��_frameset
 * [ �������� ][������] ����
 *****************************************************************************/
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>
<HTML>
<HEAD>
<TITLE>��й�ȣ ã��</TITLE>
<FRAMESET ROWS="100%,*" BORDER="0">
	<FRAME SRC="<%=dirPath%>/newPwd1.jsp" NAME=main BORDER=0 MARGINWIDTH=0 LEFTMARGIN=0 MARGINHEIGHT=0 TOPMARGIN=0 SCROLLING="auto">
	<FRAME SRC="about:blank" NAME="hidden" BORDER=0 MARGINWIDTH=0 LEFTMARGIN=0 MARGINHEIGHT=0 TOPMARGIN=0 SCROLLING="no" noresize>
</FRAMESET>
<NOFRAMES>
<BODY>
<P>�� �������� ������, �������� �� �� �ִ� �������� �ʿ��մϴ�.</P>
</BODY>
</NOFRAMES>
</FRAMESET>
</HTML>