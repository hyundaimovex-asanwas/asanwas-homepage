<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 09일
* 요약 설명 : 회원 통계
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>


<%@ page import="com.hmm.asan.asanway.member.MemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	MemberBean bean = new MemberBean();
	bean.Stat(request, response);

%>

<jsp:useBean id="arealist" class="java.util.HashMap" scope="request" />
<jsp:useBean id="travellist" class="java.util.HashMap" scope="request" />
<jsp:useBean id="genderlist" class="java.util.HashMap" scope="request" />

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
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
            <table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>회원통계</b></td>
                    </tr>

                    <tr>
                      <td height="20" ><img src="../img/bt_13.gif" hspace="4" align="absmiddle"><b>지역별 회원 분포 </b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td height="40" valign="top" style="padding:10 10 10 10;">
                                  	<table width="100%" border="0" cellspacing="0" cellpadding="0">

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">서울</td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT1").toString().substring(0,arealist.get("PERCENT1").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT1") %>%</b>
                                          (<%= arealist.get("CNT1") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">경기도</td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT2").toString().substring(0,arealist.get("PERCENT2").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT2") %>%</b>
                                          (<%= arealist.get("CNT2") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">강원도 </td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT3").toString().substring(0,arealist.get("PERCENT3").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT3") %>%</b>
                                          (<%= arealist.get("CNT3") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">충청도 </td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT4").toString().substring(0,arealist.get("PERCENT4").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT4") %>%</b>
                                          (<%= arealist.get("CNT4") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">경상도 </td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT5").toString().substring(0,arealist.get("PERCENT5").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT5") %>%</b>
                                          (<%= arealist.get("CNT5") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">전라도 </td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT6").toString().substring(0,arealist.get("PERCENT6").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT6") %>%</b>
                                          (<%= arealist.get("CNT6") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">제주도 </td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((arealist.get("PERCENT7").toString().substring(0,arealist.get("PERCENT7").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= arealist.get("PERCENT7") %>%</b>
                                          (<%= arealist.get("CNT7") %>명)</td>
                                      </tr>


                                    </table>
                                   <td>
                                </tr>
                              </table>
                             </td>
                          </tr>
                        </table>
                       </td>
                    </tr>


                    <tr>
                      <td height="20"></td>
                    </tr>


                    <tr>
                      <td height="20"><img src="../img/bt_13.gif" hspace="4" align="absmiddle"><b>북한 관광 경험</b></td>
                    </tr>
                    <tr>
                      <td height="25" align="center">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td height="40" valign="top" style="padding:10 10 10 10;">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="120" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">가보지 않았음</td>
                                        <td><img src="../img/m_n_bar03.gif" width="<%=5*Integer.parseInt((travellist.get("PERCENT1").toString().substring(0,travellist.get("PERCENT2").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= travellist.get("PERCENT1") %>%</b>
                                          (<%= travellist.get("CNT1") %>명)</td>
                                      </tr>
									  <tr>
                                        <td  height="20"><img src="../img/bottom_03.gif" width="2" height="2" hspace="4" align="absmiddle">가본적 있음</td>
                                        <td><img src="../img/m_n_bar02.gif" width="<%=5*Integer.parseInt((travellist.get("PERCENT2").toString().substring(0,travellist.get("PERCENT2").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= travellist.get("PERCENT2") %>%</b>
                                          (<%= travellist.get("CNT2") %>명)</td>
                                      </tr>
                                    </table>
                                   </td>
                                </tr>
                              </table>
							</td>
                          </tr>
                        </table>
                      </td>
                    </tr>


                    <tr>
                      <td height="20"></td>
                    </tr>


                    <tr>
                      <td height="20"><img src="../img/bt_13.gif" hspace="4" align="absmiddle"><b>성별 회원 분포</b></td>
                    </tr>
                    <tr>
                      <td height="25"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td height="40" valign="top" style="padding:10 10 10 10;"><table width="100%" border="0" cellspacing="0" cellpadding="0">

                                      <tr>
                                        <td width="60" height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">남성</td>
                                         <td><img src="../img/m_n_bar04.gif" width="<%=5*Integer.parseInt((genderlist.get("PERCENT1").toString().substring(0,genderlist.get("PERCENT1").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= genderlist.get("PERCENT1") %>%</b>
                                          (<%= genderlist.get("CNT1") %>명)</td>
                                      </tr>

                                      <tr>
                                        <td height="20"><img src="../img/bottom_02.gif" width="2" height="2" hspace="4" align="absmiddle">여성</td>
                                        <td><img src="../img/m_n_bar04.gif" width="<%=5*Integer.parseInt((genderlist.get("PERCENT2").toString().substring(0,genderlist.get("PERCENT2").toString().indexOf("."))))%>" height="14" hspace="3" align="absmiddle">&nbsp;<b><%= genderlist.get("PERCENT2") %>%</b>
                                          (<%= genderlist.get("CNT2") %>명)</td>
                                      </tr>

                                    </table>
                                  </td>
                                </tr>
                              </table>
                             </td>
                          </tr>
                        </table>
                      </td>
                    </tr>


                    <tr>
                      <td height="20"></td>
                    </tr>

                    <tr>
                      <td height="20"><img src="../img/bt_13.gif" hspace="4" align="absmiddle"><b>전체 회원 </b> :  <%=arealist.get("TOTALCOUNT")%>  명</td>
                    </tr>

                    <tr>
                      <td height="20"></td>
                    </tr>

                  </table>
                 </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
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
