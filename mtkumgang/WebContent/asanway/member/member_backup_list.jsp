<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 11�� 09��
* ��� ���� : ���� backup ȸ�� ���
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	response.setHeader("Content-Disposition", "attachment;filename=member_total_list.xls;");
	out.clearBuffer();

	MemberBean bean = new MemberBean();
	bean.ExcelList(request, response);

	//����
	HashMap jobhm = new HashMap();
		jobhm.put("1","������");
		jobhm.put("2","ȸ���");
		jobhm.put("3","�л�");
		jobhm.put("4","�ڿ���");
		jobhm.put("5","������");
		jobhm.put("6","��Ÿ");

%>

<jsp:useBean id="excellist" class="java.util.ArrayList" scope="request" />

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</head>
<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
		<table width="840" border="1" cellspacing="0" cellpadding="0">
		<tr bgcolor="ccccff">
				<td width="70" align="center"><font class="board_top">��ȣ</font></td>
				<td width="120" align="center"><font class="board_top">ID</font></td>
				<td width="120" align="center"><font class="board_top">��й�ȣ</font></td>
				<td width="120" align="center"><font class="board_top">�̸�</font></td>
				<td width="120" align="center"><font class="board_top">�ֹε�Ϲ�ȣ</font></td>
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="200" align="center"><font class="board_top">�ּ�</font></td>
				<td width="120" align="center"><font class="board_top">��ȭ��ȣ</font></td>
				<td width="120" align="center"><font class="board_top">�ڵ�����ȣ </font></td>
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="120" align="center"><font class="board_top">ȸ��</font></td>
				<td width="120" align="center"><font class="board_top">Email</font></td>
				<td width="120" align="center"><font class="board_top">���Ѱ�������</font></td>
				<td width="120" align="center"><font class="board_top">�������� ����</font></td>
				<td width="120" align="center"><font class="board_top">ȸ������</font></td>
				<td width="120" align="center"><font class="board_top">������ </font></td>
		 </tr>
		<%
			if(excellist.size() == 0) {
		%>
			<tr>
				<td height="28" colspan="17" align="center">��ϵ� �����Ͱ� �����ϴ�.</td>
			</tr>
		<% } else {
				//int num = excellist.size() + 1;
				int num = 1;
				for(int i = 0; i < excellist.size(); i++) {
					HashMap hm = (HashMap)excellist.get(i);
					String ISTRAVEL = "";
					if (hm.get("ISTRAVEL") == null){
						ISTRAVEL = "";
					}else{
						ISTRAVEL = hm.get("ISTRAVEL").toString();
					}

					String ISLETTER = "";
					if (hm.get("ISLETTER") == null || hm.get("ISLETTER") ==""){
						ISLETTER = "0";
					}else{
						ISLETTER = hm.get("ISLETTER").toString();
					}

		%>
			<tr>
				<td height="28" align="center" style="font-size:10;"><%= num++%></font></td>
				<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("ID"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("PWD"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= Utility.ko((String)hm.get("NAME"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("REGNO").toString().substring(0, 6) %> - <%= hm.get("REGNO").toString().substring(6, 13) %></td>
				<td height="28" align="center" style="font-size:10;"><% if(hm.get("GENDER").equals("F")){%>��<%}else{%>��<%}%></td>
				<td height="28" align="center" style="font-size:10;">
					<%= hm.get("BIRTHDAY").toString().substring(0, 4)%>-<%=  hm.get("BIRTHDAY").toString().substring(4, 6)%>-<%=  hm.get("BIRTHDAY").toString().substring(6, 8)%>
					(<%if(hm.get("BIRTHGBN").equals("S")){%>���� <%}else{%>���<%}%>)
				</td>
				<td height="28" align="center" style="font-size:10;">
					(<% if(hm.get("ADDRGBN").equals("H")){%>����<%}else{%>ȸ��<%}%>)
					[<%=hm.get("ZIP").toString().substring(0,3)%>-<%=hm.get("ZIP").toString().substring(3,6)%>]
					<%=Utility.ko((String)hm.get("ADDR1"))%> <%=Utility.ko((String)hm.get("ADDR2"))%>
				</td>
				<td height="28" align="center" style="font-size:10;">(<% if(hm.get("TELGBN").equals("H")){%>����<%}else{%>ȸ��<%}%>)<%= (hm.get("TEL") == null) ? "" : hm.get("TEL")%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("MOBILE") == null) ? "" : hm.get("MOBILE")%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("JOB") == null) ? "" : jobhm.get((String)hm.get("JOB"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("COMPANY") == null) ? "" : Utility.ko((String)hm.get("COMPANY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("EMAIL")%></td>
				<td height="28" align="center" style="font-size:10;"><% if(ISTRAVEL.equals("0")){%> ������ �ʾ��� <%}else{%> ������ ���� <%}%></td>
				<td height="28" align="center" style="font-size:10;"><% if(ISLETTER.equals("1")){%> ������  <%}else{%> �������� ����  <%}%></td>
				<td height="28" align="center" style="font-size:10;"><% if(hm.get("LEVEL").equals("2")){%> ������  <%}else if(hm.get("LEVEL").equals("1")){%> �ӽ�ȸ��   <%}else{%> ��ȸ�� <%}%> </td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("REGTIME")%>&nbsp;</td>
			</tr>
		<%
				}
		 	}
		 %>
	</table>
</body>
</html>


