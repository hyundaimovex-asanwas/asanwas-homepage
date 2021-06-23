<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 12월 08일
* 요약 설명 : 관계자 회원  상세보기
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.member.HrMemberBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="java.util.HashMap" %>

<%
	HrMemberBean bean = new HrMemberBean();
	bean.Read(request, response);
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="scholarship" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="career" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="contact" class="java.util.ArrayList" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ include file="/asanway/common/country_list.jsp" %>
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
	function doDel(idx){
		if (confirm("삭제 하시겠습니까?")) {
			location.href="/asanway/member/member_hr_action.jsp?cmd=D&idx="+idx ;
		}
	}

	//-->
</script>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3"><jsp:include page="/asanway/common/topbutton.jsp" flush="true" /></td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
				<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td valign="top" bgcolor="FCFCF6"> <jsp:include page="/asanway/common/member_leftmenu.jsp" flush="true" /></td>
	                <td width="2"></td>
	              </tr>
	            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6">

          	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr  style="padding: 15 0 0 20;">
              	<td>
              		<!-- 사진과 관계자 인물 정보 표기 -->
              		<!----- Title----->
					<table border="0" cellpadding="0" cellspacing="0" width="100%" bgcolor="#234790">
					<tr>
						<td><img src="../img/pop_tit_04.gif"></td>
						<td align="right"><img src="/img/common/pop_logo.gif"></td>
					</tr>
					</table><br>
					<!----- Title----->
              		<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor=D3D2C3>
              			<tr bgcolor=ffffff>
              				<td width=210 valign=top align=center height=250 >
              					<%if(read.get("IMG") == null || read.get("IMG").toString().equals("") || read.get("IMG").toString().equals("null") ){ } else {%>
              						<img src="/asanway/common/download.jsp?filename=<%= Utility.ko((String)read.get("IMG"))%>&dir=hrdb&sysfilename=<%= Utility.ko((String)read.get("SYSIMG"))%>" border="0" width="200" height="250">
              					<%}%>
              				</td>
              				<td align=center valign=top><br>
								<table width="98%" border="0" cellspacing="1" cellpadding="0" bgcolor=D3D2C3>
			              			<tr height=30>
			              				<td align=center width=100 bgcolor=DEDDCF>성 명</td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("LNAME")) %> <%=(read.get("LNAME")==null)?"":Utility.ko((String)read.get("FNAME")) %> <%=(read.get("MNAME")==null)?"":Utility.ko((String) read.get("MNAME"))%></td>
			              			</tr>
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>직 장 </td>
			              				<td bgcolor=FFFFFF> &nbsp;<%=(read.get("COMPANY")==null)?"":Utility.ko((String)read.get("COMPANY"))%></td>
			              				<td align=center bgcolor=DEDDCF>직 위 </td>
			              				<td bgcolor=FFFFFF> &nbsp;<%=(read.get("POSITION")==null)?"":Utility.ko((String)read.get("POSITION"))%></td>
			              			</tr >
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>출입처</td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("ASSIGNMENT")==null)?"":Utility.ko((String)read.get("ASSIGNMENT"))%></td>
			              			</tr>
			              			<tr height=30>
			              				<td align=center bgcolor=DEDDCF>생년월일 </td>
			              				<td colspan=3 bgcolor=FFFFFF> &nbsp;<%=(read.get("BIRTHDAY")==null)?"":Utility.ko((String)read.get("BIRTHDAY"))%></td>
			              			</tr>
			              		</table>
              				</td>
              			</tr>
              		</table>
              	</td>
              </tr>

              <tr  style="padding: 15 0 0 20;">
              	<td>
              		<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25 bgcolor=DEDDCF>
              				<td width = 100 align=center> 국 적 </td>
              				<td>&nbsp;<%=(read.get("COUNTRY")==null)?"":countryList.get(read.get("COUNTRY"))%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center> 직 군  </td>
              				<td>&nbsp;<%=(read.get("JOBGROUP")==null)?"":jobgroup.get(read.get("JOBGROUP"))%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> 직장주소 </td>
              				<td>&nbsp;[<%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(0,3)%> - <%=(read.get("CZIP")==null)?"":read.get("CZIP").toString().substring(3,6)%>] <%=(read.get("CADDR1")==null)?"":Utility.ko(read.get("CADDR1").toString() + " " + read.get("CADDR2").toString() )%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                        <tr height=25>
              				<td width = 100 align=center> 직장전화 </td>
              				<td>&nbsp;<%=(read.get("TEL1")==null)?"":read.get("TEL1")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<!--
                         <tr height=25>
              				<td width = 100 align=center> 자택주소 </td>
              				<td>&nbsp;[<%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(0,3)%> - <%=(read.get("HZIP")==null)?"":read.get("HZIP").toString().substring(3,6)%>] <%=(read.get("HADDR1")==null)?"":Utility.ko(read.get("HADDR1").toString() + " " + read.get("HADDR2").toString() )%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						-->
                         <tr height=25>
              				<td width = 100 align=center> 자택전화 </td>
              				<td>&nbsp;<%=(read.get("TEL2")==null)?"":read.get("TEL2")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> Email </td>
              				<td>&nbsp;<%=(read.get("EMAIL")==null)?"":read.get("EMAIL")%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> 휴대폰  </td>
              				<td>&nbsp;<%=(read.get("MOBILE")==null)?"":read.get("MOBILE")%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

					<!-- 학력 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3> 학 력 </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> 입학년도  </td>
              				<td width = 100 align=center> 졸업년도  </td>
              				<td width = 400 align=center> 출신학교 및 전공  </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
						<% if ( scholarship.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=3>등록된 학력정보가  없습니다.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < scholarship.size(); i++) {
									HashMap hm = (HashMap)scholarship.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%>  </td>
	              				<td width = 100 align=center> <%=hm.get("EDATE")%>   </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")== null)?"":Utility.ko(hm.get("CONTENT").toString())%>   </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              		</table>
              		<br>

              		<!--신상 정보 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2>신상 정보  </td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> 출생지  </td>
              				<td>&nbsp;<%=(read.get("BIRTHPLACE")==null)?"":Utility.ko(read.get("BIRTHPLACE").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                        <tr height=25>
              				<td width = 100 align=center> 취미  </td>
              				<td>&nbsp;<%=(read.get("HOBBY")==null)?"":Utility.ko(read.get("HOBBY").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> 흡연/주량  </td>
              				<td>&nbsp;<%=(read.get("SMOKING")==null)?"":Utility.ko(read.get("SMOKING").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width = 100 align=center> 종교  </td>
              				<td>&nbsp;<%=(read.get("RELIGION")==null)?"":Utility.ko(read.get("RELIGION").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> 혈액형  </td>
              				<td>&nbsp;<%=(read.get("RLOODTYPE")==null)?"":Utility.ko(read.get("BLOODTYPE").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> 가족관계   </td>
              				<td>&nbsp;<%=(read.get("FAMILY")==null)?"":Utility.ko(read.get("FAMILY").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

              			<tr height=25>
              				<td width = 100 align=center> 기타  </td>
              				<td>&nbsp;<%=(read.get("ETC")==null)?"":Utility.ko(read.get("ETC").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

              		<!-- 주요경력 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2> 주요경력 </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr height=25>
              				<td width = 200 align=center> 기 간  </td>
              				<td width = 400 align=center> 주요경력  </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<% if ( career.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2>등록된 주요경력 정보가  없습니다.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < career.size(); i++) {
									HashMap hm = (HashMap)career.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%> - <%=hm.get("EDATE")%>   </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%>   </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              		</table>
					<br>
              		<!-- 접촉사항  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=3> 접촉사항 </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=3></td>
                         </tr>
                         <tr height=25>
              				<td width = 100 align=center> 일자  </td>
              				<td width = 500 align=center> 접촉내용   </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
						<% if ( contact.size() == 0 ) { %>
                          <tr>
                            <td height="25" align="center" colspan=2>등록된 접촉 정보가  없습니다.</td>
                          </tr>
                      	 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
	                    <% } else {
								for(int i = 0; i < contact.size(); i++) {
									HashMap hm = (HashMap)contact.get(i);
	                    %>
	                         <tr height=25>
	              				<td width = 100 align=center> <%=hm.get("SDATE")%>  </td>
	              				<td width = 400 align=center> <%=(hm.get("CONTENT")==null)?"":Utility.ko(hm.get("CONTENT").toString())%> </td>
	              			</tr>
	              			 <tr>
	                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
	                         </tr>
						<%
								}
							}
						%>

              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              		</table>
					<br>

					<!--특이사항  -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td width = 100 align=center colspan=2>특기사항   </td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>

                         <tr height=25>
              				<td width=10>&nbsp;</td>
              				<td><%=(read.get("MEMO")==null)?"":Utility.ko(read.get("MEMO").toString())%></td>
              			</tr>
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
					</table>
					<br>

					<table width="100%" border="0" cellspacing="0" cellpadding="0">
              			 <tr>
                            <td height="2" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
              			<tr height=25  bgcolor=DEDDCF>
              				<td  colspan=2 > &nbsp; Update  :  <%=(read.get("LASTTIME")==null)?"":read.get("LASTTIME").toString().substring(0, 10) %></td>
              			</tr>
              			 <tr>
                            <td height="1" bgcolor="D3D2C3" colspan=2></td>
                         </tr>
                         <tr>
                            <td height="10" colspan=2></td>
                         </tr>
                          <tr>
                            <td height="30" colspan=2 align=right>
                            	<a href="#"  onclick="window.open('member_hr_print.jsp?idx=<%=read.get("IDX")%>','','width=700,height=600,scrollbars=yes')"><img src="/img/scrap/btn_print.gif" align="absmiddle" border=0></a>
								<a href="member_hr_modify.jsp?idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0" align="absmiddle"></a>
                      			<a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0" align="absmiddle"></a>
                      			<a href="member_hr_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0" align="absmiddle"></a>
                            </td>
                         </tr>
					</table>
					<br>
					<br><br>
              	</td>
              </tr>
			</table>

           </td>
        </tr>
      </table
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