<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 09일
* 요약 설명 : 엑셀 backup 회원 목록
**
* 수정시간  : 수정인 : 수정내용
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

	//직업
	HashMap jobhm = new HashMap();
		jobhm.put("1","공무원");
		jobhm.put("2","회사원");
		jobhm.put("3","학생");
		jobhm.put("4","자영업");
		jobhm.put("5","전문직");
		jobhm.put("6","기타");

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
				<td width="70" align="center"><font class="board_top">번호</font></td>
				<td width="120" align="center"><font class="board_top">ID</font></td>
				<td width="120" align="center"><font class="board_top">비밀번호</font></td>
				<td width="120" align="center"><font class="board_top">이름</font></td>
				<td width="120" align="center"><font class="board_top">주민등록번호</font></td>
				<td width="120" align="center"><font class="board_top">성별</font></td>
				<td width="120" align="center"><font class="board_top">생일</font></td>
				<td width="200" align="center"><font class="board_top">주소</font></td>
				<td width="120" align="center"><font class="board_top">전화번호</font></td>
				<td width="120" align="center"><font class="board_top">핸드폰번호 </font></td>
				<td width="120" align="center"><font class="board_top">직업</font></td>
				<td width="120" align="center"><font class="board_top">회사</font></td>
				<td width="120" align="center"><font class="board_top">Email</font></td>
				<td width="120" align="center"><font class="board_top">북한관광경험</font></td>
				<td width="120" align="center"><font class="board_top">뉴스레터 수신</font></td>
				<td width="120" align="center"><font class="board_top">회원구분</font></td>
				<td width="120" align="center"><font class="board_top">가입일 </font></td>
		 </tr>
		<%
			if(excellist.size() == 0) {
		%>
			<tr>
				<td height="28" colspan="17" align="center">등록된 데이터가 없습니다.</td>
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
				<td height="28" align="center" style="font-size:10;"><% if(hm.get("GENDER").equals("F")){%>여<%}else{%>남<%}%></td>
				<td height="28" align="center" style="font-size:10;">
					<%= hm.get("BIRTHDAY").toString().substring(0, 4)%>-<%=  hm.get("BIRTHDAY").toString().substring(4, 6)%>-<%=  hm.get("BIRTHDAY").toString().substring(6, 8)%>
					(<%if(hm.get("BIRTHGBN").equals("S")){%>음력 <%}else{%>양력<%}%>)
				</td>
				<td height="28" align="center" style="font-size:10;">
					(<% if(hm.get("ADDRGBN").equals("H")){%>자택<%}else{%>회사<%}%>)
					[<%=hm.get("ZIP").toString().substring(0,3)%>-<%=hm.get("ZIP").toString().substring(3,6)%>]
					<%=Utility.ko((String)hm.get("ADDR1"))%> <%=Utility.ko((String)hm.get("ADDR2"))%>
				</td>
				<td height="28" align="center" style="font-size:10;">(<% if(hm.get("TELGBN").equals("H")){%>자택<%}else{%>회사<%}%>)<%= (hm.get("TEL") == null) ? "" : hm.get("TEL")%></td>
				<td height="28" align="center" style="font-size:10;"><%= (hm.get("MOBILE") == null) ? "" : hm.get("MOBILE")%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("JOB") == null) ? "" : jobhm.get((String)hm.get("JOB"))%></td>
				<td height="28" align="center" style="font-size:10;"><%=(hm.get("COMPANY") == null) ? "" : Utility.ko((String)hm.get("COMPANY"))%></td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("EMAIL")%></td>
				<td height="28" align="center" style="font-size:10;"><% if(ISTRAVEL.equals("0")){%> 가보지 않았음 <%}else{%> 가본적 있음 <%}%></td>
				<td height="28" align="center" style="font-size:10;"><% if(ISLETTER.equals("1")){%> 수신함  <%}else{%> 수신하지 않음  <%}%></td>
				<td height="28" align="center" style="font-size:10;"><% if(hm.get("LEVEL").equals("2")){%> 임직원  <%}else if(hm.get("LEVEL").equals("1")){%> 임시회원   <%}else{%> 정회원 <%}%> </td>
				<td height="28" align="center" style="font-size:10;"><%= hm.get("REGTIME")%>&nbsp;</td>
			</tr>
		<%
				}
		 	}
		 %>
	</table>
</body>
</html>


