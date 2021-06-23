<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작 성 인 : 김미의
* 작성날자 : 2005년 11월 17일
* 요약설명 :
*
*
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.eng.NewsletterBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	NewsletterBean nb = new NewsletterBean();
	nb.NewsletterMemberList(request, response);

	String totalcount = request.getAttribute("totalcount").toString();
	String todaycount = request.getAttribute("todaycount").toString();
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
	String menuidx = "33";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("eng_main.jsp?flag=1");
	}
%>

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
					<jsp:include page="/asanway/common/eng_leftmenu.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>수신자리스트</b></td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>

							<form name="search" method="get" action="cyber_newsletter1_list.jsp">
                              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td height="35" style="padding-left:10;">
                                  	<img src="../img/bt_13.gif" width="4" height="4" hspace="4" align="absmiddle">전체 수신회원 :<%= totalcount %>명&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
	                                  <img src="../img/bt_13.gif" width="4" height="4" hspace="4" align="absmiddle">&nbsp;금일 수신회원 : <%= todaycount %>명 </td>
                                </tr>
								<tr><td bgcolor="D3D2C3"></td></tr>
                                <tr>
                                  <td height="30" align="right"  style="padding-right:15;">
                                    <select name="searchkey"  style="width:80px;height:20px" >
                                      <option value="name" selected>이름</option>
                                      <option value="email">이메일</option>
                                    </select>
                                    <input type="text" name="searchvalue" style="width:240px;height:20px" >
                                    <input type="image" src="../img/bt_04.gif" border="0" align="absmiddle">
                                  </td>
                                </tr>
                              </table>
							</form>

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
                            <td height="3" bgcolor="D3D2C3" ></td>
                            <td bgcolor="D3D2C3" width="1"></td>
                            <td bgcolor="D3D2C3" ></td>
                            <td bgcolor="D3D2C3" width="1"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3" width="1"></td>
                            <td bgcolor="D3D2C3"></td>
                          </tr>
                          <tr>
                            <td height="6" ></td>
                            <td bgcolor="C4C3BA" width="1" height="6"></td>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1" height="6"></td>
                            <td height="6"></td>
                            <td bgcolor="C4C3BA" width="1" height="6"></td>
                            <td height="6"></td>
                          </tr>
                          <tr>
                            <td height="24" align="center" width="100"><font color="433C2C">번호</font></td>
                            <td width="1"></td>
                            <td align="center" width="130"><font color="433C2C">이름</font></td>
                            <td width="1"></td>
                            <td align="center"><font color="433C2C">이메일</font></td>
                            <td width="1"></td>
                            <td width="100" align="center"><font color="433C2C">등록일</font></td>
                          </tr>

                          <%
                          		if( list.size() == 0 ) {
                          %>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                          </tr>
                          <tr>
                            <td height="28" align="center" colspan="7">등록된 뉴스레터 수신자가  없습니다. </td>
                          </tr>
                          <%
                          		} else {
        							int num = count - (int)helper.getPagesize()*(currentP-1);
                          		    for(int i = 0; i < list.size(); i++) {
                          		        HashMap hm = (HashMap)list.get(i);
							%>
                          <tr>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                            <td height="1" bgcolor="D3D2C3" width="1"></td>
                            <td height="1" bgcolor="D3D2C3" ></td>
                          </tr>
                          <tr>
                            <td height="28" align="center" ><%= num-- %></td>
                            <td width="1" height="28"></td>
                            <td height="28" align="center"><%= Utility.ko( (String)hm.get("NAME") ) %></td>
                            <td width="1" height="28"></td>
                            <td  height="28" align="center"><%= Utility.ko( (String)hm.get("EMAIL") ) %></td>
                            <td width="1" height="28"></td>
                            <td height="28" align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
                          </tr>
							<%
                          		    }
                          		}
                          %>
                          <tr>
                            <td height="2" bgcolor="D3D2C3" colspan="7" ></td>
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
									<a href="/asanway/eng/cyber_newslettermem_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" border=0 width="36" height="11" hspace="8"></a>
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
										<a href="/asanway/eng/cyber_newslettermem_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/eng/cyber_newslettermem_list.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_06.gif" border=0 width="36" height="11" hspace="8"></a>
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
                      <td align="right"   style="padding-top:5;">&nbsp;</td>
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
</body>
</html>
