<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* �ۼ��� : �����
* �ۼ����� : 2005�� 12�� 06��
* ��� ���� : ������ ȸ��  ���� �ٿ�ε�
**
* �����ð�  : ������ : ��������
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	response.setHeader("Content-Disposition", "attachment;filename=list.xls;");
	out.clearBuffer();

	HrMemberBean bean = new HrMemberBean();
	bean.ExcelList(request, response);

	String totalMember = (String)request.getAttribute("totalMember");
%>

<jsp:useBean id="excellist" class="java.util.ArrayList" scope="request" />

<%@ include file="/asanway/common/head.jsp" %>
<%@ include file="/asanway/common/country_list.jsp" %>
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
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="120" align="center"><font class="board_top">�̸� </font></td>
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="120" align="center"><font class="board_top">�����</font></td>
				<td width="120" align="center"><font class="board_top">����</font></td>
				<td width="120" align="center"><font class="board_top">�����ּ� </font></td>
				<td width="200" align="center"><font class="board_top">�����ּ�</font></td>
				<td width="120" align="center"><font class="board_top">�Ϲ���ȭ1</font></td>
				<td width="120" align="center"><font class="board_top">�Ϲ���ȭ2 </font></td>
				<td width="120" align="center"><font class="board_top">�޴���ȭ</font></td>
				<td width="120" align="center"><font class="board_top">Email</font></td>
				<td width="120" align="center"><font class="board_top">�������</font></td>
				<td width="120" align="center"><font class="board_top">�����</font></td>

				<td width="120" align="center"><font class="board_top">���</font></td>
				<td width="120" align="center"><font class="board_top">��/�ַ� </font></td>
				<td width="120" align="center"><font class="board_top">����  </font></td>
				<td width="120" align="center"><font class="board_top">������</font></td>
				<td width="120" align="center"><font class="board_top">���� ���� </font></td>
				<td width="120" align="center"><font class="board_top">��Ÿ</font></td>
				<td width="120" align="center"><font class="board_top">Ư����� </font></td>

				<td width="120" align="center"><font class="board_top">���г⵵ </font></td>
				<td width="120" align="center"><font class="board_top">�����⵵ </font></td>
				<td width="120" align="center"><font class="board_top">����б� �� ���� </font></td>

				<td width="120" align="center"><font class="board_top">�ֿ��� �Ⱓ  </font></td>
				<td width="120" align="center"><font class="board_top">�ֿ���  </font></td>

				<td width="120" align="center"><font class="board_top">�� �� </font></td>
				<td width="120" align="center"><font class="board_top">���˳���  </font></td>

				<td width="120" align="center"><font class="board_top">�����   </font></td>
				<td width="120" align="center"><font class="board_top">���� ������    </font></td>
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

		%>
			<tr>
				<td height="28" align="center" style="font-size:10;"><%= num++%></font></td>
				<td height="28" align="center" style="font-size:10;"><%=countryList.get(hm.get("COUNTRY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("LNAME") == null) ? "" :Utility.ko((String)hm.get("LNAME"))%><%= (hm.get("FNAME") == null) ? "" :Utility.ko((String)hm.get("FNAME"))%><%= (hm.get("MNAME") == null) ? "" :Utility.ko((String)hm.get("MNAME"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= jobgroup.get(hm.get("JOBGROUP"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("COMPANY") == null) ? "" :Utility.ko((String)hm.get("COMPANY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("POSITION") == null) ? "" :Utility.ko((String)hm.get("POSITION"))%></td>
				<td height="28" align="center" style="font-size:10;">
					[<%= (hm.get("CZIP") == null) ? "" : hm.get("CZIP").toString().substring(0,3)%>-<%= (hm.get("CZIP") == null) ? "" : hm.get("CZIP").toString().substring(3,6)%>]
					<%=(hm.get("CADDR1") == null) ? "" :Utility.ko((String)hm.get("CADDR1"))%> <%=(hm.get("CADDR2") == null) ? "" :Utility.ko((String)hm.get("CADDR2"))%>
				</td>
				<td height="28" align="center" style="font-size:10;">
					[<%= (hm.get("HZIP") == null) ? "" : hm.get("HZIP").toString().substring(0,3)%>-<%= (hm.get("HZIP") == null) ? "" : hm.get("HZIP").toString().substring(3,6)%>]
					<%=(hm.get("HADDR1") == null) ? "" :Utility.ko((String)hm.get("HADDR1"))%> <%=(hm.get("HADDR2") == null) ? "" :Utility.ko((String)hm.get("HADDR2"))%>
				</td>
				<td height="28" align="center" style="font-size:10;">(<% if(hm.get("TELGBN1").equals("h")){%>����<%}else{%>ȸ��<%}%>)<%= (hm.get("TEL1") == null) ? "" : hm.get("TEL1")%></td>
				<td height="28" align="center" style="font-size:10;">(<% if(hm.get("TELGBN2").equals("h")){%>����<%}else{%>ȸ��<%}%>)<%= (hm.get("TEL2") == null) ? "" : hm.get("TEL2")%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("MOBILE") == null) ? "" : hm.get("MOBILE")%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("EMAIL") == null) ? "" : hm.get("EMAIL")%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("BIRTHDAY") == null) ? "" : Utility.ko((String)hm.get("BIRTHDAY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("BIRTHPLACE") == null) ? "" : Utility.ko((String)hm.get("BIRTHPLACE"))%></td>

				<td height="28" align="center" style="font-size:10;"><%=(hm.get("HOBBY") == null) ? "" : Utility.ko((String)hm.get("HOBBY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("SMOKING") == null) ? "" : Utility.ko((String)hm.get("SMOKING"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("RELIGION") == null) ? "" : Utility.ko((String)hm.get("RELIGION"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("BLOODTYPE") == null) ? "" : Utility.ko((String)hm.get("BLOODTYPE"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("FAMILY") == null) ? "" : Utility.ko((String)hm.get("FAMILY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("ETC") == null) ? "" : Utility.ko((String)hm.get("ETC"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("MEMO") == null) ? "" : Utility.ko((String)hm.get("MEMO"))%></td>

				<td height="28" align="center" style="font-size:10;"><%=(hm.get("SDATE1") == null ||hm.get("SDATE1").toString().equals("0") ) ? "" : Utility.ko((String)hm.get("SDATE1"))%>&nbsp;</td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("EDATE1") == null ||hm.get("EDATE1").toString().equals("0") ) ? "" :  Utility.ko((String)hm.get("EDATE1"))%>&nbsp;</td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("CONTENT1") == null ||hm.get("CONTENT1").toString().equals("0") ) ? "" : Utility.ko((String)hm.get("CONTENT1"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("SDATE2") == null ||hm.get("SDATE2").toString().equals("0") ) ? "" : Utility.ko((String)hm.get("SDATE2"))%>&nbsp;-&nbsp;<%=(hm.get("EDATE2") == null ||hm.get("EDATE2").toString().equals("0") ) ? "" :  Utility.ko((String)hm.get("EDATE2"))%>&nbsp;</td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("CONTENT2") == null ||hm.get("CONTENT2").toString().equals("0") ) ? "" : Utility.ko((String)hm.get("CONTENT2"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("SDATE3") == null ||hm.get("SDATE3").toString().equals("0") ) ? "" :  Utility.ko((String)hm.get("SDATE3"))%>&nbsp;</td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("CONTENT3") == null ||hm.get("CONTENT3").toString().equals("0") ) ? "" :  Utility.ko((String)hm.get("CONTENT3"))%></td>

				<td height="28" align="center" style="font-size:10;"><%= hm.get("REGTIME")%>&nbsp;</td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("LASTTIME")%>&nbsp;</td>
			</tr>
		<%
				}
		 	}
		 %>
	</table>
</body>
</html>


