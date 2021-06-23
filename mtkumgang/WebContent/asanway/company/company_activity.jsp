<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/*****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 14일
* 요약 설명 : ceo 메시지 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.asanway.company.ActivityBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	ActivityBean ab = new ActivityBean();
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


	//read
	String title = "";
	String content = "";
	String img1= "";
	String img2 = "";
	String img3 = "";
	String category = "ceotrend";

	String idx = request.getParameter("idx");
	if(list.size() > 0 ){
		 if(idx == null ){
	           	HashMap read1 = (HashMap)list.get(0);
				 title = Utility.ko( (String)read1.get("TITLE") );
				 content = Utility.nl2br(Utility.ko( (String)read1.get("CONTENT") ));
				 img1= (String)read1.get("SYSIMG1") ;
				 img2 =  (String)read1.get("SYSIMG2") ;
				 img3 =  (String)read1.get("SYSIMG3") ;
				 idx	= (String)read1.get("IDX") ;
	     }
	     else{
	     		ab.Read(request, response);
	     		HashMap read = (HashMap)request.getAttribute("read");

	 			 title = Utility.ko( (String)read.get("TITLE") );
				 content = Utility.nl2br(Utility.ko( (String)read.get("CONTENT") ));
				 img1= (String)read.get("SYSIMG1") ;
				 img2 =  (String)read.get("SYSIMG2") ;
				 img3 =  (String)read.get("SYSIMG3") ;
	     }
     }
%>

<html>
<head>
<%@include file="/asanway/common/head.jsp"%>

<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "12";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("company_main.jsp?flag=1");
	}
%>

<script language=javascript>
	function showhideimg(stat){
		if (stat == 1){
			document.all.photo01.style.display = "block";
			document.all.photo02.style.display = "none";
			document.all.photo03.style.display = "none";

			var html;
			html = <%if(img1 == null){%> " 1 /" <%}else{%>"<a href='#'onclick='showhideimg(1);' ><b>1</b></a> / ";<%}%>
			html = html + <%if(img2 == null ){%> " 2 /" <%}else{%>"<a href='#'onclick='showhideimg(2);' >2</a> / "; <%}%> ;
			html = html + <%if(img3 == null ){%> " 3 /" <%}else{%>"<a href='#'onclick='showhideimg(3);' >3</a> / ";<%}%>;

			document.all.numlist.innerHTML = html;
		} else if (stat == 2){
			document.all.photo01.style.display = "none";
			document.all.photo02.style.display = "block";
			document.all.photo03.style.display = "none";

			var html;
			html = <%if(img1 == null ){%> " 1 /"<%}else{%>  "<a href='#'onclick='showhideimg(1);' >1</a> / ";<%}%>
			html = html + <%if(img2 == null ){%> " 2 /" <%}else{%> "<a href='#'onclick='showhideimg(2);' ><b>2</b></a> / ";<%}%> ;
			html = html + <%if(img3 == null ){%>  " 3 /"<%}else{%> "<a href='#'onclick='showhideimg(3);' >3</a> / ";<%}%>;

			document.all.numlist.innerHTML = html;
		} else if (stat == 3){
			document.all.photo01.style.display = "none";
			document.all.photo02.style.display = "none";
			document.all.photo03.style.display = "block";

			var html;
			html = <%if(img1 == null ){%>  " 1 /"  <%}else{%>"<a href='#'onclick='showhideimg(1);' >1</a> / ";<%}%>
			html = html + <%if(img2== null ){%>" 2 /" <%}else{%> "<a href='#'onclick='showhideimg(2);' >2</a> / ";<%}%> ;
			html = html + <%if(img3 == null ){%> " 3 /" <%}else{%> "<a href='#'onclick='showhideimg(3);' ><b>3</b></a> / ";<%}%>;

			document.all.numlist.innerHTML = html;
		}
   }

   function goDel(idx){
		var idx = idx;
		if (confirm("삭제하시겠습니까?")) {
				location.href="/asanway/company/company_activity_delete.jsp?idx="+idx;
		}
	}

</script>
   <script language="javascript">
	   <!--
	   		function doUpdateStatus(idx, status) {
				uframe.location.href = "status_update.jsp?idx=" + idx + "&status="+status+"&tablename=ceotrend";
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
                <td valign="top" bgcolor="FCFCF6"><jsp:include page="/asanway/common/company_leftmenu.jsp" flush="true" /></td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td width="674" valign="top" bgcolor="FCFCF6"> <table width="674" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="674" valign="top" style="padding: 15 0 0 20;"> <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>CEO
                        동정</b></td>
                    </tr>
					<!--content view start -->
                    <% if ( list.size() == 0 ) { %>
					<% }else{%>
                    <tr>
                      <td>
                      	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td style="padding: 10 10 10 10;">
                               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                  <td bgcolor="DEDDCF" style="padding: 7 5 7 5;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="80" align="center" >제목</td>
                                        <td width="1" bgcolor="BAB9A9"></td>
                                        <td style="padding-left:10;"><b><%= title%></b></td>
                                      </tr>
                                    </table></td>
                                </tr>
                                <tr>
                                  <td height="10"></td>
                                </tr>
                                <tr>
                                  <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="180" ><table border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                                            <tr>
                                              <td>
                                              		<div id="photo01" style="display: ;" >
                                              			<% if(img1 == null || img1.equals("null")){ %>
	                                              			<img src="/img/common/photo_non_209_163.gif">
	                                              		<%} else { %>
	                                              			<img src="/common/download.jsp?dir=ceotrend&sysfilename=<%=img1%>" width="204" height="163">
	                                              		<%}%>
													</div>
													<div id="photo02" style="display: none;" >
														<img src="/common/download.jsp?dir=ceotrend&sysfilename=<%=img2%>" width="204" height="163">
													</div>
													<div id="photo03" style="display: none;" >
														<img src="/common/download.jsp?dir=ceotrend&sysfilename=<%=img3%>" width="204" height="163">
													</div>
                                              </td>
                                            </tr>
                                          </table></td>
                                        <td width="10"></td>
                                        <td align="right" valign="bottom"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                              <td height="20" align="right" >
                                               <table border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td><img src="../img/page_01.gif" width="35" height="5"></td>
                                                    <td style="padding-left:5;">
                                                    <div id="numlist">
                                                    	<%if(img1 == null || img1.equals("")){%> 1 / <%}else{%><a href="#" onclick="showhideimg(1);" ><b>1</b></a> /<%}%>
                                                    	<%if(img2 == null || img2.equals("")){%> 2 / <%}else{%><a href="#" onclick="showhideimg(2);" >2</a> / <%}%>
                                                    	<%if(img3 == null || img3.equals("")){%> 3 / <%}else{%><a href="#" onclick="showhideimg(3);" >3</a> / <%}%>
                                                    </div>
                                                    </td>
                                                  </tr>
                                                </table>
                                               </td>
                                            </tr>
                                            <tr>
                                              <td height="1" bgcolor="DEDDCF"></td>
                                            </tr>
                                            <tr>
                                              <td width="365" height="120" style="padding:5 5 5 5;" valign=top><%= content %></td>
                                            </tr>
                                            <tr>
                                              <td height="1" bgcolor="DEDDCF"></td>
                                            </tr>
                                            <tr>
                                              <td width="365" height="23" style="padding:5 5 5 5;" align=right>
                                              	<a href="company_activity_modify.jsp?page=<%=currentP%>&idx=<%= idx %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                     							<a href="javascript:goDel(<%=idx%>)"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                                              </td>
                                            </tr>
                                            <tr>
                                              <td height="1" bgcolor="DEDDCF"></td>
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
                        </table>
                       </td>
                    </tr>
					<%}%>
					<!--content view start -->

                    <tr>
                      <td height="15"></td>
                    </tr>
                    <tr>
                      <td valign="top" ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="1" bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td width="100" bgcolor="D3D2C3"></td>
                            <td bgcolor="D3D2C3"></td>
                            <td width="120" bgcolor="D3D2C3"></td>
                          </tr>

                          <!--list loop start -->
                          	<% if ( list.size() == 0 ) { %>
	                          <tr>
	                            <td height="25" align="center" colspan="9">등록된 글이 없습니다.
	                          </tr>
		                    <% } else {
									int num = count - (int)helper.getPagesize()*(currentP-1);

									for(int i = 0; i < list.size(); i++) {
										HashMap hm = (HashMap)list.get(i);

										String b="";
										if(idx.equals(hm.get("IDX").toString())){
											b = "<b>";
										} else {
											b = "";
										}
		                    %>
		                          <tr>
		                            <td height="6" bgcolor="F5F5E9"></td>
		                            <td bgcolor="C4C3BA" width="1"></td>
		                            <td></td>
		                            <td bgcolor="C4C3BA"  width="1"></td>
		                            <td></td>
		                            <td bgcolor="C4C3BA"  width="1"></td>
		                            <td></td>
		                          </tr>
		                          <tr>
		                            <td width="60" height="25" align="center" bgcolor="F5F5E9">제목
		                            </td>
		                            <td></td>
		                            <td style="padding-left:5;"><a href="company_activity.jsp?page=<%=currentP%>&idx=<%= hm.get("IDX") %>"><%=b%><%= (hm.get("TITLE") == null) ? "" : Utility.getStringcut( 28, Utility.ko((String)hm.get("TITLE")) ) %></a><% if( Utility.NewDay((String)hm.get("REGTIME")) ) {%> <img src="/asanway/img/bt_19.gif"><% } %></td>
		                            <td></td>
		                            <td align="center"><%= hm.get("REGTIME").toString().substring(0, 10) %></td>
		                            <td></td>
		                            <td align="center">
                            	<select name="status" style="width:80px;height:20px" onChange="doUpdateStatus(<%= hm.get("IDX") %>, this.value)">
                                	<option value="0" <% if( hm.get("STATUS").equals("0") ) { %>selected <% } %> value="0">등록대기</option>
                                	<option value="1" <% if( hm.get("STATUS").equals("1") ) { %>selected <% } %> value="1">등록됨</option>
                              </select>
		                            </td>
		                          </tr>
		                          <tr>
		                            <td height="1" bgcolor="D3D2C3"></td>
		                            <td bgcolor="D3D2C3"></td>
		                            <td bgcolor="D3D2C3"></td>
		                            <td bgcolor="D3D2C3"></td>
		                            <td width="100" bgcolor="D3D2C3"></td>
		                            <td bgcolor="D3D2C3"></td>
		                            <td width="120" bgcolor="D3D2C3"></td>
		                          </tr>
                           <%
									}
								}
							%>

                         <!--list loop end -->


                        </table></td>
                    </tr>
                    <tr>
                      <td height="50" align="center"   style="padding-top:5;">
                        <!-- --------------------------- 페이지 ----------------------- -->
						<Table border="0" cellspacing="0" cellpadding="0" align="center">
							<tr>
								<td>
								<%if(helper.getBeforegroup() > 0){%>
									<a href="/asanway/company/company_activity.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
								<% } else { %>
									<img src="../img/bt_05.gif" width="36" height="11" hspace="8">
								<% } %>
								</td>
							<!--
								<td width="60" align="left">
								<%if(helper.getBefore() > 0){%>
									<a href="/asanway/company/company_activity.jsp?p=<%=helper.getBefore()%>"><img src="/admin/common/img/btn_pre.gif" border="0"></a>
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
										<a href="/asanway/company/company_activity.jsp?page=<%= i %>"><%= i %></a>&nbsp;
										<%  }
									  } %>
									<% if(totalP  == 0) { %>1<% } %>
								</td>
							<!--
								<td width="64" align="right">
									<% if(helper.getAfter() > 0){%>
										<a href="/asanway/company/company_activity.jsp?p=<%=helper.getAfter()%>"><img src="/admin/common/img/btn_next.gif" border="0"></a>
									<% } else { %>
										<img src="/admin/common/img/btn_next.gif" border="0">
									<% } %>
								</td>
							 -->
								<td>
									<%if(helper.getAftergroup() > 0){%>
										<a href="/asanway/company/company_activity.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
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
                    <tr>
                      <td align="right"   style="padding-top:5;"><a href="company_activity_write.jsp"><img src="../img/bt_07.gif" width="40" height="20" border="0"></a></td>
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
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
