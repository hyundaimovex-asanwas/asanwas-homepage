<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 10일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.NewsletterBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%

	String category = request.getParameter("category");
	if(category == null) category = "user";

	NewsletterBean nb = new NewsletterBean();
	nb.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />

<%
	//페이징 하기 위한 값을 셋팅한다.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getPagesize());
%>

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
	   		function doUpdateStatus(idx, status) {
				uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=letter";
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
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>뉴스레터</b></td>
                    </tr>
                    <tr> 
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr> 
                            <td>
                            
                            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                            <form name="search" method="get" action="cyber_newsletter_list.jsp">
                                <tr>
                                  <td height="40" align="right"  style="padding-right:15;">

	                                <select name="searchkey"  style="width:80px;height:20px">
                                      <option value="title" <% if( searchkey.equals("title") ) { %>selected<% } %> >제목</option>
                                      <option value="content" <% if( searchkey.equals("content") ) { %>selected<% } %>>내용</option>
                                    </select>

                                     <input type="text" name="searchvalue" style="width:240px;height:20px" value='<%= searchvalue %>'>
									 <a href="javascript:search.submit()"><img src="../img/bt_04.gif" border="0" align="absmiddle"></a>
                                  </td>
                                </tr>
                            </form>
                              </table>
                                                          
                            </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td height="5"></td>
                    </tr>
                    <tr> 
                      <td>
                      <a href="cyber_newsletter_list.jsp?category=user">일반유저</a> / <a href="cyber_newsletter_list.jsp?category=admin">관계자</a>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr> 
                            <td height="3" bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                          </tr>
                          <tr> 
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                          </tr>
                          <tr> 
                            <td height="24" align="center" width="60"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td align="center"><font color="433C2C">제목</font></td>
                            <td></td>
                            <td width="120" align="center">발송일(성공/실패)</td>
                            <td></td>
                            <td width="80" align="center"><font color="433C2C">등록일</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">등록</font></td>
                          </tr>

					<%
						if( list.size() == 0 ) {
					%>           
                          <tr> 
                            <td height="1" bgcolor="D3D2C3" colspan="9">
                          </tr>                          
                          <tr> 
                            <td height="25" align="center" colspan="9" align="center">등록된 게시물이 없습니다.
                          </tr>               
					<%
						} else {
							int num = count - (int)helper.getPagesize()*(currentP-1);
						    for(int i = 0 ; i < list.size(); i++) { 
						        HashMap hm = (HashMap)list.get(i); 
					%>
                          <tr> 
                            <td height="1" bgcolor="D3D2C3" colspan="9">
                          </tr>                          
                          <tr> 
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;"><a href="cyber_newsletter_read.jsp?idx=<%= hm.get("IDX") %>&category=<%= hm.get("CATEGORY") %>"><%= Utility.ko((String)hm.get("TITLE")) %></a></td>
                            <td></td>
                            <td align="center"><%= ( hm.get("SENDDAY") == null ) ? "미발송"  : hm.get("SENDDAY") %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                            <td></td>
                            <td align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
                              </select>
							</td>
                          </tr>					
					<%
							}
						}
					%>
                          <tr> 
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr> 
                      <td height="50" align="center">
                      
					<!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/cyber/cyber_newsletter_list.jsp?page=<%=helper.getBeforegroup()%>&category=<%= category %>"><img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8">
								<% } %>
								</td>
							<!--
								<td width="60" align="left">
								<%if(helper.getBefore() > 0){%>
									<a href="/admin/newsroom/notice/notice_list.jsp?p=<%=helper.getBefore()%>"><img src="/admin/common/img/btn_pre.gif" border="0"></a>
								<% } else { %>
									<img src="/admin/common/img/btn_pre.gif" border="0">
								<% } %>
								</td>
							-->
								<td>
									<%
									  for(int i = startP; i <= endP; i++){
										if(i > totalP) break;
											if(i == currentP){
									%>
										<b><font color="#CE261D"><%= i %></font></b>&nbsp;
										<%  } else { %>
										<a href="/asanway/cyber/cyber_newsletter_list.jsp?page=<%= i %>&category=<%= category %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
							<!--
								<td width="64" align="right">
									<% if(helper.getAfter() > 0){%>
										<a href="/admin/newsroom/notice/notice_list.jsp?p=<%=helper.getAfter()%>"><img src="/admin/common/img/btn_next.gif" border="0"></a>
									<% } else { %>
										<img src="/admin/common/img/btn_next.gif" border="0">
									<% } %>
								</td>
							 -->
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/cyber/cyber_newsletter_list.jsp?page=<%=helper.getAftergroup()%>&category=<%= category %>"><img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8"></a>
									<% } else { %>
										<img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8">
									<% } %>
								</td>
							</tr>
						</table>
					<!-- --------------------------- 페이지 ----------------------- -->                      
                      
                      </td>
                    </tr>
                    <tr> 
                      <td height="1" bgcolor="D3D2C3"></td>
                    </tr>
                    <tr> 
                      <td align="right"   style="padding-top:5;"><a href="cyber_newsletter_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
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
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
