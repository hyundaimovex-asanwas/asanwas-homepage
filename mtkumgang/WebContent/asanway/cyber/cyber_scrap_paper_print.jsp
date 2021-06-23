<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>
<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 11월 16일
* 요약 설명 : 스크랩 마스터  (신문)
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>


<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.cyber.ScrapBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String menutitle = "신문기사  스크랩";
	String downfolder = "scrappaper";
	String category = "scrappaper";
%>

<%
	ScrapBean bean = new ScrapBean(category);
	bean.List(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />
<jsp:useBean id="filelist" class="java.util.ArrayList" scope="request" />

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

	String pubdate = request.getParameter("pubdate");
	if(pubdate == null) {
		pubdate = Utility.getCurrentDate();
	}

	String predate = Utility.getYesterday(pubdate);
	String nextdate = Utility.getTomorrow(pubdate);

	String section1 = request.getParameter("section1");
	if(section1 == null) section1 = "";

	String section2 = request.getParameter("section2");
	if(section2 == null) section2 = "";

	//구분 값
	HashMap section1hm = new HashMap();
		section1hm.put("1","사업관련기사");
		section1hm.put("2","한반도관련기사");
		section1hm.put("3","기타기사");

	HashMap section2hm = new HashMap();
		section2hm.put("1","가판");
		section2hm.put("2","종합판");
		section2hm.put("3","석간");
%>

<%@ include file="/common/logincheck.jsp" %>
<%@ include file="/common/staffcheck.jsp" %>



					<table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!-- 탭아래 여백-->

					<!-----컨텐츠 ----->
					<!-----컨텐츠 ----->
				  <!--종합판 / 석간 / 가판  카테고리 선택 (section2)-->
				  <%if (section2 != null &&  !section2.equals("")){%>
					  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>일일 뉴스 스크랩(<%=pubdate%>_<%=section2hm.get(section2.toString())%>)<b>
								 </td>
							  </tr>
							</table>
							<%for (int k=1; k < 4 ; k++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=k%>. <%=section1hm.get(Integer.toString(k))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION2").toString().equals(section2.toString()) && hm.get("SECTION1").toString().equals(Integer.toString(k))){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--여백-->
						  <%}%>

				  <!--사업 / 한반도 / 기타 기사   카테고리 선택 (section1) -->
				  <%}else if (section1 != null &&  !section1.equals("")) { %>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>일일 뉴스 스크랩(<%=pubdate%>_<%=section1hm.get(section1)%>)<b>
								 </td>
							  </tr>
							</table>
							<%for (int l=1; l < 4 ; l++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=l%>. <%=section2hm.get(Integer.toString(l))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION2").toString().equals(Integer.toString(l)) && hm.get("SECTION1").toString().equals(section1)){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--여백-->
						  <%}%>

				  <!-----전체목록---->
				  <%}else{ %>
						 <%for (int k=1; k < 4 ; k++){ %>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>[<%=pubdate%>]&nbsp;&nbsp; <%=section2hm.get(Integer.toString(k))%><b>
								 </td>
							  </tr>
							</table>
							<%for (int l=1; l < 4 ; l++){ %>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
								  <tr>
									<td bgcolor="DEDDCF" style="padding: 7 5 3 5;">
									  <table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
										  <td style="left-padding: 10 0 0 0;"><%=l%>. <%=section1hm.get(Integer.toString(l))%></td>
										</tr>
									  </table></td>
								  </tr>
								</table>
								 <table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
								  <td height="1" bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								  <td bgcolor="D3D2C3"></td>
								</tr>
								<% if ( list.size() == 0 ) { %>
								<% } else {
											int num = count - (int)helper.getPagesize()*(currentP-1);
									    	for ( int i = 0 ; i < list.size(); i++) {
									    	    HashMap hm = (HashMap)list.get(i);
									    	    if(hm.get("SECTION1").toString().equals(Integer.toString(l)) && hm.get("SECTION2").toString().equals(Integer.toString(k))){
								%>
									<tr>
									  <td height="25"></td>
										<td style="padding:8 5 3 5;" valign="top"  width="5">
										  <img src="/img/common/bl02.gif" align="absmiddle">
										</td>
										<td style="padding:8 10 3 0;">
											<a href="#" onclick="window.open('/scrap/pop_paper.jsp?idx=<%= hm.get("IDX") %>','','width=950,height=760,scrollbars=yes')"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
										</td>
									</tr>
									<tr>
									  <td height="1" bgcolor="D3D2C3" colspan=3></td>
									</tr>
								<% }	} }%>
							  </table>
							  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--여백-->
						  <%}%>
						<table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--여백-->
					  <%}%>
				  <%}%>

				  <table border="0" cellpadding="0" cellspacing="0" height="10"><tr><td></td></tr></table><!--여백-->


<script javascript>
	print();
</script>

