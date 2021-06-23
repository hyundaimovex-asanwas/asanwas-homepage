<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김종문
* 작성날자 : 2005년 10월 13일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.PressBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	PressBean bean = new PressBean();
	bean.List(request, response);
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
	String section = request.getParameter("section");
	if(section == null) section= "";

%>


<html>
<head>

<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "15";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
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
					<jsp:include page="/asanway/cyber/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>언론기사</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

								<table width="100%"  border="0" cellpadding="0" cellspacing="0">
								<form name="search" method="get" action="cyber_press_list.jsp">
                                <tr>
                                  <td height="40" align="right"  style="padding-right:15;">

	                                <select name="section"  style="width:80px;height:20px" >
                                      <option value="" <% if( section.equals("") ) { %>selected<% } %>>전체</option>
                                      <option value="1" <% if( section.equals("1") ) { %>selected<% } %>>일간지</option>
                                      <option value="2" <% if( section.equals("2") ) { %>selected<% } %>>주간지</option>
                                      <option value="3" <% if( section.equals("3") ) { %>selected<% } %>>인터넷</option>
									  <option value="4" <% if( section.equals("4") ) { %>selected<% } %>>동영상</option>
                                    </select>

	                                <select name="searchkey"  style="width:80px;height:20px" >
                                      <option value="title" <% if( searchkey.equals("title") ) { %>selected<% } %>>제목</option>
                                      <option value="journal" <% if( searchkey.equals("journal") ) { %>selected<% } %>>언론사</option>
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
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
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
                            <td width="50" height="24" align="center"><font color="433C2C">번호</font></td>
                            <td></td>
                            <td align="center" width=70>구분</td>
                            <td></td>
                            <td align="center" width="100">언론사</td>
                            <td></td>
                            <td align="center"><font color="433C2C">제목</font></td>
                            <td></td>
                            <td width="80" align="center"><font color="433C2C">등록일</font></td>
                            <td></td>
                            <td width="100" align="center"><font color="433C2C">등록</font></td>
                          </tr>

						<% if ( list.size() == 0 )  { %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="25" align="center" colspan=11>등록된 언론기사가 없습니다.
                          </tr>
						<% } else {
							int num = count - (int)helper.getPagesize()*(currentP-1);
							String t_section = "";
									for( int i = 0; i < list.size(); i++) {
									    HashMap hm = (HashMap)list.get(i);

										if(hm.get("SECTION") == null){
											t_section = "기타";
										} else {
										    t_section = hm.get("SECTION").toString();

											if(t_section.equals("1")){
											    t_section = "일간지";
											} else												 if(t_section.equals("2")){
												     t_section = "주간지";
											} else												 if(t_section.equals("3")){
												     t_section = "인터넷";
											} else												 if(t_section.equals("4")){
												     t_section = "동영상";
											} else {
											    t_section = "기타";
											}
										}
						%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td height="1" bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="25" align="center"><%= num-- %></td>
                            <td></td>
                            <td align="center"><%= t_section %></td>
                            <td align="center"></td>
                            <td align="center"><%= Utility.getStringcut(6, Utility.ko( (String)hm.get("JOURNAL") ) ) %></td>
                            <td align="center"></td>
                            <td  style="padding-left:5;"><a href="cyber_press_read.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.getStringcut( 20, Utility.ko((String)hm.get("TITLE"))) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
                            <td></td>
                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                            <td></td>
                            <td align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                <option <% if( hm.get("STATUS").equals("0") ) { %>selected<% } %> value="0">등록대기</option>
                                <option <% if( hm.get("STATUS").equals("1") ) { %>selected<% } %> value="1">등록됨</option>
                              </select> </td>
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
                            <td height="2" bgcolor="D3D2C3"></td>
                            <td height="2" bgcolor="D3D2C3"></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="50" align="center">
                      <!--
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
					-->


					<!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/cyber/cyber_press_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
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
										<a href="/asanway/cyber/cyber_press_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
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
										<a href="/asanway/cyber/cyber_press_list.jsp.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" width="36" height="11" hspace="8"></a>
									<% } else { %>
										<img src="../img/bt_06.gif" width="36" height="11" hspace="8">
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
                      <td align="right"   style="padding-top:5;"><a href="cyber_press_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
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
