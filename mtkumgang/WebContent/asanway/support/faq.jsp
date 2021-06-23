<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 11월 4일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%
	String category = request.getParameter("category");
	if(category == null) category = "faq";
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.FaqBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	FaqBean bean = new FaqBean();
	bean.List(request, response, category);
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
	int endP = (int)(currentG*helper.getGroupsize());
%>

<%
	// 검색
	String section = request.getParameter("section");
	if(section == null) section = "";

	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";

	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>


<html>
<head>
<script language="javascript" src="/js/common.js"></script>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "28";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>

   <script language="javascript">
	   <!--
	   		function doUpdateStatus(idx, status) {
				uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=press";
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
					<jsp:include page="left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>FAQ  리스트</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

                            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                            <form name="search" method="get" action="list.jsp">
                            <input type="hidden" name="category" value="<%= category %>">
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
                      	<!--탭-->
					    <table cellpadding="0" cellspacing="0" width="100%" background="img/tab_bg.gif">
							<tr>
								<td width="10"></td>
								<td width="67"><a href="/asanway/support/faq.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image001','','/img/cyberpr/tab_data01_on.gif',1)"><img src="/img/cyberpr/tab_data01<%= section.equals("") ? "_on" : "" %>.gif" border="0" name="Image001" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="/asanway/support/faq.jsp?section=1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image002','','/img/cyberpr/tab_data02_on.gif',2)"><img src="/img/cyberpr/tab_data02<%= section.equals("1") ? "_on" : "" %>.gif" border="0" name="Image002" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="/asanway/support/faq.jsp?section=2" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image003','','/img/cyberpr/tab_data03_on.gif',3)"><img src="/img/cyberpr/tab_data03<%= section.equals("2") ? "_on" : "" %>.gif" border="0" name="Image003" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="/asanway/support/faq.jsp?section=3" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image004','','/img/cyberpr/tab_data04_on.gif',4)"><img src="/img/cyberpr/tab_data04<%= section.equals("3") ? "_on" : "" %>.gif" border="0" name="Image004" ></a></td>
                              	<td width="2"></td>
								<td width="67"><a href="/asanway/support/faq.jsp?section=4" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image005','','/img/cyberpr/tab_data05_on.gif',5)"><img src="/img/cyberpr/tab_data05<%= section.equals("4") ? "_on" : "" %>.gif" border="0" name="Image005" ></a></td>
                                <td width="2"></td>
								<td width="67"><a href="/asanway/support/faq.jsp?section=5" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image006','','/img/cyberpr/tab_data06_on.gif',6)"><img src="/img/cyberpr/tab_data06<%= section.equals("5") ? "_on" : "" %>.gif" border="0" name="Image006" ></a></td>
                                <td width="2"></td>
							    <td width="67"><a href="/asanway/support/faq.jsp?section=6" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image007','','/img/cyberpr/tab_data07_on.gif',7)"><img src="/img/cyberpr/tab_data07<%= section.equals("6") ? "_on" : "" %>.gif" border="0" name="Image007" ></a></td>
                               <td >&nbsp; </td>
							</tr>
						</table>
						<!--탭-->
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>

                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=9></td>
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
                            <td width="60" height="24" align="center"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td align="center"><font color="433C2C">제목</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">등록일</font></td>
                            <td></td>
                            <td width="100" align="center">조회</td>
                            <td></td>
                            <td width="120" align="center"><font color="433C2C">등록</font></td>
                          </tr>
                         <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=9></td>
                          </tr>

					<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan="9">등록된 글이 없습니다.
                          </tr>
                    <% } else {
						int num = count - (int)helper.getPagesize()*(currentP-1);

						for(int i = 0; i < list.size(); i++) {
							HashMap hm = (HashMap)list.get(i);
                    %>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;"><a href="faq_read.jsp?category=<%= category %>&idx=<%= hm.get("IDX") %>"><%= (hm.get("TITLE") == null) ? "" : Utility.getStringcut( 25, Utility.ko((String)hm.get("TITLE")) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                            <td></td>
                            <td align="center"><%= hm.get("HIT") %></td>
                            <td></td>
                            <td align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
                              </select> </td>
                          </tr>
                          <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=9></td>
                          </tr>

					<% } } %>

                          <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=9></td>
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
									<a href="faq.jsp?category=<%= category %>&page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8">
								<% } %>
								</td>
								<td>
									<%
									  for(int i = startP; i <= endP; i++){
										if(i > totalP) break;
											if(i == currentP){
									%>
										<b><font color="#CE261D"><%= i %></font></b>&nbsp;
										<%  } else { %>
										<a href="faq.jsp?category=<%= category %>&page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="faq.jsp?category=<%= category %>&page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8"></a>
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
                      <td align="right"   style="padding-top:5;"><a href="faq_write.jsp?category=<%= category %>"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
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
