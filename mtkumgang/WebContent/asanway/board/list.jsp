<%
/****************************************
*
* �� �� �� : ������
* �ۼ����� : 2005�� 10�� 10��
* ��༳�� :
*
*
* �����ð�  : ������ : ��������
*
******************************************/
%>
<%@ page language="java" contentType="text/html; charset=euc-kr" %>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.NewsBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	NewsBean nb = new NewsBean();
	nb.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
	//����¡ �ϱ� ���� ���� �����Ѵ�.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getPagesize());
%>

<script>
<!--
	function goDisplayUpdate()
	{
//		document.product.action="/admin/product/product/product_display_update.jsp";
		document.noticelist.submit();
	}
-->
</script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>

<%= list.size() %>

<body leftmargin="0" topmargin="0">
		<!--table-->
		<Table width="740" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15"></td>
				<td>
				<!--����-->
				<Table width="710" border="0" cellspacing="0" cellpadding="0" class="board_bg">
					<tr>
						<td>JDBC SAMPLE
				</table>
				<!--//����-->
				<Table width="710" border="0" cellspacing="0" cellpadding="0">
					<%
						if(list.size() == 0) {
					%>
					<tr>
						<td height="28" colspan="13" align="center">��ϵ� �����Ͱ� �����ϴ�.
					<% } else {
							int num = count - (int)helper.getPagesize()*(currentP-1);
							for(int i = 0; i < list.size(); i++) {
								HashMap hm = (HashMap)list.get(i);
					%>
					<tr>
						<td height="28" bgcolor="#34ddaf"><%= hm.get("IBMREQD") %>
 					<%
							}
					 	}
					 %>
				</table>
			</table>
</body>
</html>
