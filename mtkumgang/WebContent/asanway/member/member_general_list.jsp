<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 28일
* 요약 설명 : 회원 목록
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
	MemberBean bean = new MemberBean();
	bean.List(request, response);

	String totalMember = (String)request.getAttribute("totalMember");
	String todayMember = (String)request.getAttribute("todayMember");
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

	String mtype = request.getParameter("mtype");
	if(mtype == null) mtype = "";

	String menutitle = "";
	String tdcolspan = "";

	if(mtype.equals("1")){
		menutitle = "14세미만회원 ";
		tdcolspan = "13";
	}else if(mtype.equals("2")){
		menutitle = "임직원 ";
		tdcolspan = "11";
	}else{
		menutitle = "일반회원";
		tdcolspan = "13";
	}
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("member_main.jsp?flag=1");
	}
%>
<script language="javascript">
	   <!--
	   		function doUpdateLevel(idx, level) {
				uframe.location.href = "member_action.jsp?cmd=UL&idx=" + idx + "&level="+level;
	   		}
	   //-->
   </script>
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
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
			   	    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%=menutitle%></b></td>
                    </tr>
                    <%if(mtype.equals("")){%>
	                    <tr>
	                      <td height="20" class="large">
						    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
	                          <tr>
	                            <td height="35" bgcolor="F5F5E9" style="padding:0 0 0 20;"><img src="../img/bottom_02.gif" width="2" height="2"  hspace="5" align="absmiddle">전체
	                              일반회원 : <b><%=totalMember%>명</b> <img src="../img/bottom_02.gif" width="2" height="2"  hspace="5" align="absmiddle">금일
	                              가입회원 : <b><%=todayMember%>명</b></td>
	                          </tr>
	                        </table>
	                      </td>
	                    </tr>
	                    <tr>
	                      <td height="20" ></td>
	                    </tr>
                    <% } %>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                           <form name="search" method="get" action="member_general_list.jsp">
                              	<input type=hidden name=mtype value="<%=mtype%>">
	                          <tr>
	                            <td>
	                             	<table width="100%"  border="0" cellpadding="0" cellspacing="0">
	                                <tr>
	                                  <td height="40" align="right"  style="padding-right:15;">
		                                <select name="searchkey"  style="width:80px;height:20px" >
	                                      <option value="id" <% if( searchkey.equals("id") ) { %>selected<% } %>>아이디</option>
	                                      <option value="name" <% if( searchkey.equals("name") ) { %>selected<% } %>>이름</option>
	                                      <option value="email" <% if( searchkey.equals("email") ) { %>selected<% } %>>Email</option>
	                                    </select>
	                                     <input type="text" name="searchvalue" style="width:240px;height:20px" value='<%= searchvalue %>'>
										 <a href="javascript:search.submit()"><img src="../img/bt_04.gif" border="0" align="absmiddle"></a>
	                                  </td>
	                                </tr>
	                              </table>
	                            </td>
	                          </tr>
	                       </form>
                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                          <td height="1" bgcolor="D3D2C3" colspan=<%=tdcolspan%>></td>
                          </tr>
                          <tr>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
                            <td bgcolor="C4C3BA"  width="1"></td>
                            <td></td>
							<%if(!mtype.equals("2")){%>
	                            <td bgcolor="C4C3BA"  width="1"></td>
	                            <td></td>
							<%}%>
                          </tr>

                          <tr>
                            <td height="24" align="center">ID</td>
                            <td></td>
                            <td width="70" height="24" align="center">이름</td>
                            <td></td>
                            <td align="center">이메일</td>
                            <td></td>
                            <td width="100" align="center">핸드폰</td>
                            <td></td>
                            <td width="100" align="center">전화번호</td>
                            <td></td>
                            <td width="100" align="center">등록일</td>
							<%if(!mtype.equals("2")){%>
	                            <td></td>
	                            <td width="100" align="center">회원구분</td>
							<%}%>
                          </tr>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=<%=tdcolspan%>></td>
                          </tr>

						<% if ( list.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=<%=tdcolspan%>>등록된 회원이 없습니다.</td>
                          </tr>
	                    <% } else {
								int num = count - (int)helper.getPagesize()*(currentP-1);

								for(int i = 0; i < list.size(); i++) {
									HashMap hm = (HashMap)list.get(i);
	                    %>
	                          <tr>
	                            <td height="24" align="center"><%=hm.get("ID")%></td>
	                            <td></td>
	                            <td width="70" height="24" align="center"><a href="member_general_read.jsp?mtype=<%=mtype%>&idx=<%= hm.get("IDX") %>"><%=Utility.ko((String)hm.get("NAME"))%></a></td>
	                            <td></td>
	                            <td align="center"><%=hm.get("EMAIL")%></td>
	                            <td></td>
	                            <td width="100" align="center"><%=(hm.get("MOBILE") == null) ? "" : hm.get("MOBILE")%></td>
	                            <td></td>
	                            <td width="100" align="center"><%=hm.get("TEL")%></td>
	                            <td></td>
	                            <td width="100" align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
								<%if(mtype.equals("1")){%>
		                            <td></td>
		                            <td width="100" align="center">
		                            	<select name="level" style="width:80px;height:20px" onChange="doUpdateLevel(<%= hm.get("IDX") %>, this.value)">
		                                	<option value="0" <% if( hm.get("LEVEL").equals("0") ) { %>selected <% } %> value="0">정회원</option>
		                                	<option value="1" <% if( hm.get("LEVEL").equals("1") ) { %>selected <% } %> value="1">임시회원</option>
	                                	</select>
		                            </td>
		                        <%} else if (mtype.equals("")){%>
									<td></td>
		                            <td width="100" align="center">
		                            	<select name="level" style="width:80px;height:20px" onChange="doUpdateLevel(<%= hm.get("IDX") %>, this.value)">
		                                	<option value="0" <% if( hm.get("LEVEL").equals("0") ) { %>selected <% } %> value="0">정회원</option>
		                                	<option value="1" <% if( hm.get("LEVEL").equals("1") ) { %>selected <% } %> value="1">임시회원</option>
		                                	<option value="2" <% if( hm.get("LEVEL").equals("2") ) { %>selected <% } %> value="2">임직원</option>
	                                	</select>
		                            </td>
								<%}%>
	                          </tr>
	                          <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=<%=tdcolspan%>></td>
	                          </tr>
						<%
								}
							}
						%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=<%=tdcolspan%>></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td height="50" align="center">
                      	<!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/member/member_general_list.jsp?mtype=<%=mtype%>&page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border=0></a>
								<% } else { %>
									<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
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
										<a href="/asanway/member/member_general_list.jsp?mtype=<%=mtype%>&page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/member/member_general_list.jsp?mtype=<%=mtype%>&page=<%=helper.getAftergroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8" border=0></a>
									<% } else { %>
										<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
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
                    <!--
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="member_general_write.jsp?mtype=<%=mtype%>"><img src="../img/bt_24.gif" width="59" height="20" border="0"></a></td>
                    </tr>
                    -->
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
