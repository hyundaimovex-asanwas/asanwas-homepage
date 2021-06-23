<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%@ page import="com.hmm.asan.asanway.cyber.HeroBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%
	HeroBean hb = new HeroBean();
	hb.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="preview" class="java.util.HashMap" scope="request" />
<jsp:useBean id="nextview" class="java.util.HashMap" scope="request" />


<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 12일
* 요약 설명 : ceo 메시지 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%
	String category = "beststaff";
%>
<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "18";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script language="javascript">
<!--
	function goDel(idx){
		var idx = idx;
		if (confirm("삭제하시겠습니까?")) {
				location.href="/asanway/cyber/cyber_hero_delete.jsp?idx="+idx;
		}
	}

//-->
</script>
</head>

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
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>임직원 경조사  내용보기</b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td colspan="3" bgcolor="F2F1E2" style="padding-left:5;"><%= Utility.ko( (String)read.get("TITLE") ) %></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <tr>
                                  <td height="30" align="center" bgcolor="DEDDCF">등록일
                                  </td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0, 10) %></td>
                                  <td width="80" align="center" bgcolor="DEDDCF">조회
                                  </td>
                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT")%></td>
                                </tr>
                                 <tr>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                  <td height="1" bgcolor="D3D2C3"></td>
                                </tr>
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">본문요약</td>
                                  <td colspan="3" bgcolor="F2F1E2" style="padding-left:5;padding-top:10;padding-bottom:5;"><%= (read.get("SUMMARY") == null) ? "" : Utility.nl2br(Utility.ko( (String)read.get("SUMMARY")) )  %></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr>
                      <td >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <% if( preview.size() != 0 ) { %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
                          <tr>
                            <td width="100" height="30" align="center" bgcolor="F2F1E2">이전글</td>
                            <td style="padding-left:5;"><a href="cyber_hero_read.jsp?idx=<%= preview.get("IDX") %>"><%= Utility.ko( (String)preview.get("TITLE") )%></a></td>
                          </tr>
						<% } %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% if( nextview.size() != 0 )  {%>
                          <tr>
                            <td width="100"  height="30" align="center" bgcolor="F2F1E2">다음글</td>
                            <td style="padding-left:5;"><a href="cyber_hero_read.jsp?idx=<%= nextview.get("IDX") %>"><%= Utility.ko( (String)nextview.get("TITLE") ) %></a></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% } %>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_hero_modify.jsp?page=<%=request.getParameter("page")%>&idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:goDel(<%=read.get("IDX")%>)"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="cyber_hero_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                      </td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
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
