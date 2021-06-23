<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 22일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>
<%
	String category = request.getParameter("category");
	if(category == null) category = "openevent1";

	String t = "";
	if( category.equals("openevent1") ) t = "오픈이벤트1";
	if( category.equals("openevent2") ) t = "오픈이벤트2";
	if( category.equals("openevent3") ) t = "오픈이벤트3";
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.support.EventBean1" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>


<%
	EventBean1 bean = new EventBean1();
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
	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";
	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";
%>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yyyyMMdd");
	String ymd = myformat.format(yymmdd);	// 20051101
%>

<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "30";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("support_main.jsp?flag=1");
	}
%>

   <script language="javascript">
	   <!--
	   		function doUpdateStatus(idx, status) {
				uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=event";
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
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%= t %> 리스트</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

                            <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                            <form name="search" method="get" action="event_list1.jsp">
                            <input type="hidden" name="category" value="<%= category %>">
                                <tr>
                                  <td height="40" align="left"  style="padding-right:15;">&nbsp;&nbsp;<a href="/asanway/support/event_excel2.jsp?category=<%=category%>"><img src=/asanway/img/bt_30.gif border=0 align=absmiddle></a></td>
                                  <td height="40" align="right"  style="padding-right:15;">

							<% if( category.equals("openevent1") ) { %>
	                                <select name="searchkey"  style="width:80px;height:20px">
                                      <option value="title" <% if( searchkey.equals("title") ) { %>selected<% } %> >제목</option>
                                      <option value="content" <% if( searchkey.equals("content") ) { %>selected<% } %>>내용</option>
                                    </select>
                             <% } else {  %>
	                                <select name="searchkey"  style="width:80px;height:20px">
                                      <option value="name" <% if( searchkey.equals("name") ) { %>selected<% } %> >응모자</option>
                                    </select>
                             <% } %>

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



                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="3" bgcolor="D3D2C3" colspan=11"></td>
                          </tr>
                          <tr>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                          </tr>
                          <% if( category.equals("openevent1") ){ %>
                          <tr>
                            <td width="50" height="24" align="center"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td align="center"><font color="433C2C">제목</font></td>
                            <td></td>
                            <td width="70" align="center"><font color="433C2C">추천수</font></td>
                            <td></td>
                            <td width="70" align="center"><font color="433C2C">작성자</font></td>
                            <td></td>
                            <td width="70" align="center"><font color="433C2C">ID</font></td>
                            <td></td>
                            <td width="70" align="center"><font color="433C2C">작성일</font></td>
                           </tr>
                          <% } else if( category.equals("openevent2") ) { %>
                          <tr>
                            <td width="50" height="24" align="center"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td align="center" width="170"><font color="433C2C">정답1</font></td>
                            <td></td>
                            <td width="170" align="center"><font color="433C2C">정답2</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">작성자</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">ID</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">작성일</font></td>
                           </tr>
                          <% } else if( category.equals("openevent3") ) { %>
                          <tr>
                            <td width="50" height="24" align="center"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">당첨자명</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">ID</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">당첨일</font></td>
                           </tr>
                           <% } %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" colspan="11"></td>
                          </tr>

					<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan="11">등록된 글이 없습니다.
                          </tr>
                    <% } else {

						int num = count - (int)helper.getPagesize()*(currentP-1);

						for(int i = 0; i < list.size(); i++) {
							HashMap hm = (HashMap)list.get(i);
                    %>
                          <% if( category.equals("openevent1") ){ %>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;"><a href="event_read1.jsp?category=<%= category %>&idx=<%= hm.get("IDX") %>"><%= (hm.get("TITLE") == null) ? "" : Utility.getStringcut( 22, Utility.ko((String)hm.get("TITLE")) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
                            <td></td>
                            <td align="center"><%= hm.get("HIT") %></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= Utility.ko( (String)hm.get("NAME")) %></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= hm.get("ID") %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
							</tr>
						  <% } else if( category.equals("openevent2") ) { %>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td style="padding-left:5;" align="center"><%= Utility.ko( (String)hm.get("TITLE")) %></td>
                            <td></td>
                            <td style="padding-left:5;" align="center"><%= Utility.ko( (String)hm.get("CONTENT")) %></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= Utility.ko( (String)hm.get("NAME")) %></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= hm.get("ID") %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
							</tr>
						  <% } else if( category.equals("openevent3") ) { %>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= Utility.ko( (String)hm.get("NAME")) %></a></td>
                            <td></td>
                            <td align="center"><a href="#" onClick='javascript:window.open("/asanway/member/member_general_read_popup.jsp?idx=<%= hm.get("MIDX") %>","aa","width=640, height=700,scrollbars=yes");'><%= hm.get("ID") %></a></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
						  </tr>
                          <% } %>
							<tr>
                            <td height="1" bgcolor="D3D2C3" colspan="11"></td>
                          </tr>
					<% } } %>

                          <tr>
                            <td height="2" bgcolor="D3D2C3" colspan="11"></td>
                          </tr>

                        </table>

                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">

                      <!-- -------------------- 페이징 -----------------------
                      <table border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="right"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></td>
                            <td><b>1</b> . <a href="#">2 </a>. <a href="#">3 </a>.
                              <a href="#">4 </a>. <a href="#">5 </a>. <a href="#">6
                              </a>. <a href="#">7 </a>. <a href="#">8 </a>. <a href="#">9</a>
                              . <a href="#">10</a></td>
                            <td><img src="../img/bt_06.gif" width="36" height="11" hspace="8"></td>
                          </tr>
                        </table>
                      <!-- -------------------- 페이징 ----------------------->


					<!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="event_list1.jsp?category=<%= category %>&page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8"></a>
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
										<a href="event_list1.jsp?category=<%= category %>&page=<%= i %>"><%= i %></a>&nbsp;
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
										<a href="event_list1.jsp?category=<%= category %>&page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8"></a>
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
