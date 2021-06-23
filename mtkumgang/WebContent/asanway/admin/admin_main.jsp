<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 18일
* 요약 설명 : 운영자 리스트
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String flag = request.getParameter("flag");
	String msg = "";
	if (flag != null  &&  flag.equals("1") ){
		msg = "권한이 없습니다.";
	}
%>
<html>
<head>
<%@include file="/asanway/common/head.jsp"%>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
            <table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
               	 	<jsp:include page="/asanway/common/admin_leftmenu.jsp" flush="true" />
				</td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td width="674" valign="top" bgcolor="FCFCF6" >
          	<font color=ffffff>.</font><br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=msg%>
           </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2"><jsp:include page="/asanway/common/copyright.jsp" flush="true" /></td>
  </tr>
</table>
</body>
</html>
