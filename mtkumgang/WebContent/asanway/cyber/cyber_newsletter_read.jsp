<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 27일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.NewsletterBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String category = request.getParameter("category");

	NewsletterBean nb = new NewsletterBean();
	nb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />


<%
	// 검색
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>


<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "16";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="/asanway/cyber/cyber_newsletter_delete.jsp?idx="+idx;
		} else {
			// 취소 버튼을 눌렀을 때 실행해야 할 프로그램
		}
	}

	function sendMail(){
		if (confirm("메일을 발송하시겠습니까 ?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="cyber_newsletter_sendmail.jsp?idx=<%= read.get("IDX") %>&category=<%= category %>";
		}
	}
//-->

</script>

</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
		<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>뉴스레터(웹진) 내용 보기 & 발송</b></td>
                    </tr>
                    <tr>
                      <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">구분</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("CATEGORY").equals("user") ? "일반회원" : "관계자"  %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("TITLE") ) %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                              </table>
                              </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td height="2"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=newsletter&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" style="width:580px;"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="DBDACB"></td>
                    </tr>
                    <tr >
                      <td align="right" style="padding-top:5;">
	                    <a href="cyber_newsletter_modify.jsp?idx=<%= read.get("IDX") %>&category=<%= category %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
	                    <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
						<a href="#" onClick="window.open('cyber_newsletter_popup.jsp?idx=<%= read.get("IDX") %>', 'View', 'width=630, height=670, scrollbars=yes, menubar=no, resizable=no'); return false"><img src="../img/bt_14.gif" width="58" height="20" border="0"></a>
	                    <a href="javascript:sendMail();"><img src="../img/bt_15.gif" width="40" height="20" hspace="3" border="0"></a>
	                    <a href="cyber_newsletter_list.jsp?category=<%= category %>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                      </td>
                    </tr>
                    <tr>
                      <td  height="15"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
</body>
</html>
