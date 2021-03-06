<%@ page language="java" contentType="text/html; charset=euc-kr"%>

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
	String menutitle = "스크랩마스터 - 신문기사  스크랩";
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
	if(pubdate == null || pubdate.equals("")) {
		pubdate = Utility.getCurrentDate();
	}

	String pubyear = pubdate.substring(0,4);
	String pubmonth = pubdate.substring(5,7);
	String pubday = pubdate.substring(8,10);

	String predate = Utility.getYesterday(pubdate);
	String nextdate = Utility.getTomorrow(pubdate);

	String section1 = request.getParameter("section1");
	if(section1 == null) section1 = "";

	String section2 = request.getParameter("section2");
	if(section2 == null) section2 = "";

	String searchkey = request.getParameter("searchkey");
	if(searchkey == null) searchkey = "";

	String searchvalue= request.getParameter("searchvalue");
	if(searchvalue == null) searchvalue = "";


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
<script language="javascript">
	function movepage(val){
		var form = document.search;
		form.pubdate.value = val;
		form.submit();
	}

	function movepage2(val1,val2){
		var form = document.search;
		var date = form.pubyear.value + "-" + form.pubmonth.value + "-" + form.pubday.value;
		form.pubdate.value = date;
		form.section1.value = val2;
		form.section2.value = val1;
		form.submit();
	}

	function movepage3(){
		var form = document.search;
		var val = form.pubyear.value + "-" + form.pubmonth.value + "-" + form.pubday.value;
		form.pubdate.value = val;
		form.submit();
	}
</script>
<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "20";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script language="javascript" src="/js/common.js"></script>
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
          <td valign="top" bgcolor="FCFCF6">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%=menutitle%></b></td>
                    </tr>
                    <tr>
                     <td align=right>
                      		<table  border="0" cellpadding="0" cellspacing="0">
                              <form name="search" method="post" action="cyber_scrap_paper_list.jsp">
			                          	<input type=hidden name=category value="<%=category%>">
			                          	<input type=hidden name=pubdate value="<%=pubdate%>">
			                          	<input type=hidden name=section1 value="<%=section1%>">
			                          	<input type=hidden name=section2 value="<%=section2%>">
		                              <tr>
		                              	<!--
		                                <td style="padding:10 0 0 0;" width="20"><a href="javascript:movepage('<%=predate%>')"><img src="/img/scrap/s_left.gif" border="0"></a></td>
		                                <td style="padding:10 0 0 0;"><input type=text name=pubdate size=10  style="width:100px;height:20px" value="<%=pubdate%>"></td>
		                                <td width="20" align="right" style="padding:10 0 0 0;"><a href="javascript:movepage('<%=nextdate%>')"><img src="/img/scrap/s_right.gif" border="0"></a></td>
		                                -->
		                                <td>
		                                	<select name="pubyear" onchange="ChangeOptionDays('search', 'pub')" style="width:65px; height:19px;" >
												 <option value="">선택</option>
												<% for(int i = 2000; i <= 2020; i++) { %>
												<option value="<%=i%>" <%if(i == Integer.parseInt(pubyear)){%> selected <%}%>><%=i%></option>
												<% } %>
											</select> 년

											<select name="pubmonth" onchange="ChangeOptionDays('search', 'pub')" style="width:55px; height:19px;">
												 <option value="">선택</option>
												 <% for(int i = 1; i <= 12; i++) { %>
												 	<% String tmp = i + ""; %>
												 	<% if(i < 10) tmp = "0" + tmp ;%>
													<option value="<%=tmp%>" <%if(tmp.equals(pubmonth)){%> selected <%}%>><%=tmp%></option>
												 <% } %>
											</select> 월

											<select name="pubday" style="width:55px; height:19px;">
												 <option value="">선택</option>
												 	<% int DaysInMonth = 31;
									  					if(pubmonth.equals("4") || pubmonth.equals("6")|| pubmonth.equals("9") || pubmonth.equals("11"))
									  						DaysInMonth = 30;
									  					if(pubmonth.equals("2") &&  Integer.parseInt(pubyear) % 4 == 0)
									  						DaysInMonth = 29;
									  					if(pubmonth.equals("2") &&  Integer.parseInt(pubyear) % 4 != 0)
									  						DaysInMonth = 28;
								  					%>
													 <% for(int i = 1; i <= DaysInMonth; i++) { %>
													 	<% String tmp = i + ""; %>
													 	<% if(i < 10) tmp = "0" + tmp ;%>
														<option value="<%=tmp%>" <%if(tmp.equals(pubday)){%> selected <%}%>><%=tmp%></option>
													 <% } %>
											</select> 일

											<!--<a href="javascript:movepage3();"><img src="/img/scrap/bt_04.gif" border="0"></a>-->
		                                </td>
		                              	<td width=10></td>
		                              	<td style="padding:10 0 0 0;">
		                              		<a href="javascript:movepage2('','');"><%if(section2.equals("")){%><strong>전체</strong><%}else{%>전체<%}%></a> /
		                              		<a href="javascript:movepage2('1','');"><%if(section2.equals("1")){%><strong>가판</strong><%}else{%>가판<%}%></a> /
		                              		<a href="javascript:movepage2('2','');"><%if(section2.equals("2")){%><strong>종합판</strong><%}else{%>종합판<%}%></a> /
		                              		<a href="javascript:movepage2('3','');"><%if(section2.equals("3")){%><strong>석간</strong><%}else{%>석간<%}%></a>

		                              		<!--
		                              		<select name="section2"  style="width:80px;height:20px" onChange=document.search.submit();>
		                              			  <option value="" <% if(section2.equals("") ) { %>selected<% } %>>전체</option>
			                                      <option value="1" <% if( section2.equals("1") ) { %>selected<% } %>>가판</option>
			                                      <option value="2" <% if( section2.equals("2") ) { %>selected<% } %>>종합판 </option>
			                                      <option value="3" <% if( section2.equals("3") ) { %>selected<% } %>>석간</option>
			                                </select>
			                                -->
		                              	</td>
		                              </tr>
		                              </form>
                            </table>
                      </td>
                    </tr>
                    <tr>
                      <td>
                      	<!--탭-->
					   <table cellpadding="0" cellspacing="0" width="100%" background="img/tab_bg.gif">
							<tr>
								<td width="10"></td>
								<td width="67"><a href="javascript:movepage2('','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image001','','/img/scrap/s_tab01_on.gif',1)"><img src="/img/scrap/s_tab01<%= section1.equals("") ? "_on" : "" %>.gif" border="0" name="Image001" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="javascript:movepage2('','1');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image002','','/img/scrap/s_tab02_on.gif',2)"><img src="/img/scrap/s_tab02<%= section1.equals("1") ? "_on" : "" %>.gif" border="0" name="Image002" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="javascript:movepage2('','2');"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image003','','/img/scrap/s_tab03_on.gif',3)"><img src="/img/scrap/s_tab03<%= section1.equals("2") ? "_on" : "" %>.gif" border="0" name="Image003" ></a></td>
								<td width="2"></td>
								<td width="67"><a href="javascript:movepage2('','3');"  onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image004','','/img/scrap/s_tab04_on.gif',4)"><img src="/img/scrap/s_tab04<%= section1.equals("3") ? "_on" : "" %>.gif" border="0" name="Image004" ></a></td>
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
                       <!-----컨텐츠 ----->
				  <!--종합판 / 석간 / 가판  카테고리 선택 (section2)-->
				  		<%if (section2 != null &&  !section2.equals("")){%>
					  		<table width="100%" border="0" cellspacing="0" cellpadding="0">
							  <tr>
								<td style="padding: 7 5 3 5;">
									<b>[<%=pubdate%>]&nbsp;&nbsp; <%=section2hm.get(section2.toString())%><b>
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
											<a href="cyber_scrap_paper_read.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
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
									<b>[<%=pubdate%>]&nbsp;&nbsp; <%=section1hm.get(section1)%><b>
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
											<a href="cyber_scrap_paper_read.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
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
											<a href="cyber_scrap_paper_read.jsp?idx=<%= hm.get("IDX") %>"><%= Utility.ko((String)hm.get("CONTENT")) %></a>
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
					</td>
				  </tr>
				  <tr>
                      <td align="right"   style="padding-top:5;">
                      	<a href="#"  onclick="window.open('cyber_scrap_paper_print.jsp?category=<%=category%>&pubdate=<%=pubdate%>&section1=<%=section1%>&section2=<%=section2%>','','width=950,height=760,scrollbars=yes')"><img src="/img/scrap/btn_print.gif" align="absmiddle" border=0></a>
                      	<a href="cyber_scrap_paper_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0" align="absmiddle"></a>
                      </td>
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
