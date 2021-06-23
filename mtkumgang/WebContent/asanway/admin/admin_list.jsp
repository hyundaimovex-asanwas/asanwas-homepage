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

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	AuthBean ab = new AuthBean();
	ab.List(request, response);
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

<html>
<head>
<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("admin_main.jsp?flag=1");
	}
%>
<script language="javascript">
	   <!--
	   		function openwin(idx) {
				if(idx){
					window.open("/asanway/admin/pop_modify.jsp?idx="+idx,"admin"," width=700, height=500, top=200, left=300, scrollbars=no");
				}
				else{
					window.open("/asanway/admin/pop_write.jsp","admin"," width=700, height=500, top=200, left=300, scrollbars=no");
				}
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
                <td valign="top" bgcolor="FCFCF6">
               	 	<jsp:include page="/asanway/common/admin_leftmenu.jsp" flush="true" />
				</td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" align="right"><a href="javascript:openwin();"><img src="../img/bt_22.gif" width="68" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td>
                       <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="3" bgcolor="D3D2C3" colspan=14></td>
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

						<form name=frm method=post>
                          <tr>
                            <td height="24" align="center" width=60>아이디</td>
                            <td></td>
                            <td align="center" width=60>이름</td>
                            <td></td>
                            <td align="center" width=130>이메일</td>
                            <td></td>
                         	<td align="center">운영권한</td>
                            <td></td>
                            <td align="center" width=60>등록일</td>
                          </tr>

                          <tr>
                            <td height="1" bgcolor="D3D2C3"  colspan=9></td>
                          </tr>

						<% if ( list.size() == 0 ) { %>
							<tr>
                            	<td height="25" align="center"  colspan=9>등록된 운영자가 없습니다.</td>
                          	</tr>
                        <% } else {
									int num = count - (int)helper.getPagesize()*(currentP-1);

									for(int i = 0; i < list.size(); i++) {
										HashMap hm = (HashMap)list.get(i);

		                %>
	                           <tr>
	                            <td height="25" align="center"><a href="javascript:openwin(<%=hm.get("IDX")%>);"><%=hm.get("ID")%></a></td>
	                            <td></td>
	                            <td style="padding-left:5;"><a href="javascript:openwin(<%=hm.get("IDX")%>)"><%=Utility.ko((String)hm.get("NAME"))%></a></td>
	                            <td></td>
	                            <td align="center"><%=hm.get("EMAIL")%></td>
	                            <td></td>
	                            <td align=center>
		                        	<%//권한 리스트
		                        		ab.AuthList(request, response,(String)hm.get("IDX"));
		                        		ArrayList authlist = (ArrayList) request.getAttribute("authlist");

		                        		for(int j = 0; j < authlist.size(); j++) {
			                            	HashMap hmauth = (HashMap)authlist.get(j);
			                         		out.print(Utility.ko((String)hmauth.get("NAME")));
			                         		if(j != authlist.size()-1){out.print(",");}
										}
									%>
								</td>
	                            <td></td>
	                            <td align="center"><%=hm.get("REGTIME").toString().substring(0, 10)%></td>
	                          </tr>

	                          <tr>
	                            <td height="1" bgcolor="D3D2C3"  colspan=9></td>
	                          </tr>
 						<%
								}
							}
						%>
						</form>

                        </table>
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="javascript:openwin();"><img src="../img/bt_22.gif" width="68" height="20" border="0"></a></td>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td><b>*관리자 정책*</b></td>
                          </tr>
                          <tr>
                            <td height="5"></td>
                          </tr>
                          <tr>
                            <td height="20">1. 운영관리자와 슈퍼관리자로 구분</td>
                          </tr>
                          <tr>
                            <td height="20">2. 슈퍼관리자는 초기 setting</td>
                          </tr>
                          <tr>
                            <td height="20">3. 운영관리자가 등록한 모든 콘텐트는 ‘등록대기’ 상태로 등록되며 슈퍼관리자만이
                              ‘등록됨’ 상태로 수정 할 수 있다.</td>
                          </tr>
                          <tr>
                            <td height="20">4. 관리자가 등록한 모든 콘텐트는 관리자 실명으로 기재된다.(WEBSITE에서는
                              ‘관리자’로 등록된다.) </td>
                          </tr>
                          <tr>
                            <td height="20">5. 운영공지게시판을 이용하여 관리자 간의 의견을 주고 받을 수 있도록 한다.</td>
                          </tr>
                          <tr>
                            <td height="20">6. 등록대기란 DB에는 모든 정보가 입력되어 있으나 website에 표현되지 않는
                              상태를 말한다.</td>
                          </tr>
                          <tr>
                            <td height="20">7. 등록됨 이란 등록대기 상태의 콘텐트가 website에 표현된 상태를 말한다.
                            </td>
                          </tr>
                        </table></td>
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
</body>
</html>
