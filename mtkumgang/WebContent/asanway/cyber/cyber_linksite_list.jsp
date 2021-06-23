<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 26일
* 요약 설명 : 관련사이트  - 리스트
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hmm.asan.asanway.cyber.LinkSiteBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	LinkSiteBean bean = new LinkSiteBean();
	bean.CateList(request, response);
%>

<jsp:useBean id="catelist" class="java.util.ArrayList" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "25";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top"><table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/cyber/left.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>자료실 - 관련사이트</b></td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                     <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td align=center>
                        <!--list start -->
                        <% if ( catelist.size() == 0 ) { %>
							등록된 관련 사이트가 없습니다.
						<% } else {
								for(int i = 0; i < catelist.size(); i++) {
									HashMap hm = (HashMap)catelist.get(i);
		                %>
		                        <table border="0" cellpadding="0" cellspacing="0" width="624"><tr><td height="10"></td></tr></table>
								<table border="0" cellpadding="0" cellspacing="0" width="624">
								<col width="200"></col>
								<col width="4"></col>
								<col width="420"></col>
								<tr valign="top">
									<td><img src="/img/common/box_200_top.gif"></td>
									<td><img src="/img/common/trans.gif" width="4"></td>
									<td><img src="/img/common/box_420_top.gif"></td>
								</tr>
								<tr>
									<td background="/img/common/box_200_bg.gif" align="center">
										<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td align="center"><b><%=Utility.ko((String)hm.get("NAME"))%></b></td>
										</tr>
										</table>
									</td>
									<td></td>
									<td background="/img/common/box_420_bg.gif" style="padding-left:25">
										<table border="0" cellpadding="0" cellspacing="0" width="350">
										<col width="10"></col>
										<col width="340"></col>
										<%
											bean.List(request, response,(String)hm.get("IDX"));
			                        		ArrayList list = (ArrayList) request.getAttribute("list");

			                        		for(int j = 0; j < list.size(); j++) {
				                            		HashMap hmlist = (HashMap)list.get(j);
				                        %>
											<tr height="18">
												<td><img src="/img/common/bl02.gif"></td>
												<td><a href="<%=hmlist.get("SITEURL")%>" target=_blank><%=Utility.ko((String)hmlist.get("SITENAME"))%></a></td>
											</tr>
										<% } %>
										</table>
									</td>
								</tr>
								<tr valign="top">
									<td><img src="/img/common/box_200_bottom.gif"></td>
									<td><img src="/img/common/trans.gif" width="4"></td>
									<td><img src="/img/common/box_420_bottom.gif"></td>
								</tr>
								</table>
						<%
								}
							}
						%>
					    <!--list end -->

                      </td>
                    </tr>
                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="/asanway/cyber/cyber_linksite_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table></td>
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
    <td height="30"  bgcolor="D4D4B2"><jsp:include page="/asanway/common/copyright.jsp" flush="true" /></td>
  </tr>
</table>
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
