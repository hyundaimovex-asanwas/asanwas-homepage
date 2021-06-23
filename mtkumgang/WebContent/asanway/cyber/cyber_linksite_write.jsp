<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 12일
* 요약 설명 : 관련사이트 - 등록
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hmm.asan.asanway.cyber.LinkSiteBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	LinkSiteBean bean = new LinkSiteBean();
	bean.List(request, response);
	bean.CateList(request, response);
%>

<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="helper" class="com.hmm.asan.common.util.PagingHelper" scope="request" />
<jsp:useBean id="catelist" class="java.util.ArrayList" scope="request" />

<%
	//페이징 하기 위한 값을 셋팅한다.
	int currentP = helper.getCurpage();
	int count = helper.getTotalcount();
	int totalP = helper.getTotalpage();

	int currentG = (int)((currentP-1)/helper.getGroupsize()) + 1;

	int startP = (int)((currentG-1)*helper.getGroupsize()) + 1;
	int endP = (int)(currentG*helper.getGroupsize());

	String cateidx = request.getParameter("cateidx");
	if(cateidx==null){cateidx = "";}
%>

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	String menuidx = "25";
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>
<script language="javascript">
<!--
	function goInsert(cmd){
		if(cmd == "I"){
		   var form = document.form1;
			if( form.cateidx.selectedIndex== 0){
				alert("카테고리를 선택하세요.");
				form.cateidx.focus();
				return false;
			}

			if( form.sitename.value=="" ){
				alert("사이트명을   입력하세요.");
				form.sitename.focus();
				return false;
			}

			if( form.siteurl.value=="" ){
				alert("사이트주소를    입력하세요.");
				form.siteurl.focus();
				return false;
			}

		}
		else {
			var form = document.form2;
			if( form.name.value=="" ){
				alert("카테고리명을  입력하세요.");
				form.name.focus();
				return false;
			}
		}
		return true;
	}

	function doDel(idx,cmd){
		var idx = idx;
		if(cmd == "D"){
			if (confirm("삭제하시겠습니까?")) {
				uframe.location.href="/asanway/cyber/cyber_linksite_action.jsp?cateidx=<%=cateidx%>&cmd=" + cmd + "&idx="+idx;
			}
		}
		else{
			if (confirm("카테고리에 등록된 모든 웹사이트가 삭제됩니다. 삭제하시겠습니까?")) {
				uframe.location.href="/asanway/cyber/cyber_linksite_action.jsp?cmd=" + cmd + "&idx="+idx;
			}
		}
	}

	function openwin(idx,cmd) {
		window.open("/asanway/cyber/cyber_linksite_modify.jsp?cateidx=<%=cateidx%>&cmd=" + cmd + "&idx="+idx,"admin"," width=400, height=300, top=200, left=300, scrollbars=no");
   	}

   	function goCateList() {
		document.form1.action = "cyber_linksite_write.jsp";
		document.form1.submit();
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
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" >
			<table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
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

                <!--contents start -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b>자료실 - 관련사이트 등록</b></td>
                    </tr>
                    <tr>
                      <td>
						<br>
                      	<!-- 관련사이트 시작-->
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><b>관련 웹사이트 관리</b></td>
						</tr>
						<tr><td height="10"></td></tr>
						</table>
						<form name="form1" method="post" action="cyber_linksite_action.jsp" onSubmit="return goInsert('I')">
							<input type="hidden" name="cmd" value="I">
						<table width="100%" border="0" cellspacing="1" cellpadding="10" bgcolor="#D3D2C3">
							<tr bgcolor="#FCFCF6">
								<td colspan="3">
									<% if ( catelist.size() == 0 ) {%>
										<select name="cateidx" ><option value=''>카테고리 선택</option></select>
									<%}else{ %>
										<select name="cateidx" onchange="javascript:goCateList();">
											<option value=''>카테고리 선택</option>
											<%
													for ( int i = 0 ; i < catelist.size(); i++) {
						    	    				HashMap hm1 = (HashMap)catelist.get(i);
											 %>
													<option value=<%=hm1.get("IDX")%><%if(hm1.get("IDX").equals(cateidx)){%> selected <%}%>><%=Utility.ko((String)hm1.get("NAME"))%></option>
											<%	}%>
										</select>
									<%}%>
								</td>
							</tr>
							<tr bgcolor="#FCFCF6" valign="top">
								<td width="50%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<% if ( list.size() == 0 ) { %>
										<tr height="25" colspan=2>
											<td align=center>등록된 관련 사이트가 없습니다.</td>
										</tr>
									<%}else{
											for ( int i = 0 ; i < list.size(); i++) {
					    	    			HashMap hm2 = (HashMap)list.get(i);
									%>
										<tr height="25">
											<td width=120><%=Utility.ko((String)hm2.get("CATEGORYNAME"))%></td>
											<td>
												 <%=Utility.ko((String)hm2.get("SITENAME"))%> &nbsp;&nbsp;
												<a href="javascript:openwin(<%=hm2.get("IDX")%>,'U')"><img src="/img/common/btn_edit2.gif" border="0" align="absmiddle"></a>
												<a href="javascript:doDel(<%=hm2.get("IDX")%>,'D')"><img src="/img/common/btn_delete4.gif" border="0" align="absmiddle"></a>
											</td>
										</tr>
									<%}}%>
									<tr>
				                      <td height="1" bgcolor="D3D2C3" colspan=2></td>
				                    </tr>
									<tr height="25">
										<td colspan=2>
										<!-- --------------------------- 페이지 ----------------------- -->
										<Table border="0" cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td>
												<%if(helper.getBeforegroup() > 0){%>
													<a href="/asanway/cyber/cyber_linksite_list.jsp?page=<%=helper.getBeforegroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
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
														<a href="/asanway/cyber/cyber_linksite_list.jsp?page=<%= i %>"><%= i %></a>&nbsp;
														<%  }
													  } %>
													<% if(totalP  == 0) { %>1<% } %>
												</td>
												<td>
													<%if(helper.getAftergroup() > 0){%>
														<a href="/asanway/cyber/cyber_linksite_list.jsp.jsp?page=<%=helper.getAftergroup()%>"><img src="../img/bt_05.gif" width="36" height="11" hspace="8"></a>
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
				                      <td height="1" bgcolor="D3D2C3" colspan=2></td>
				                    </tr>
									</table>
								</td>
								<td width="50%" valign=top>
									<table width="300" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><b>관련 웹사이트 등록</b></td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr>
										<td>웹사이트 명</td>
									</tr>
									<tr>
										<td><input type="text" name="sitename" style="width:300px;height:20px" ></td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr>
										<td>웹사이트 주소</td>
									</tr>
									<tr>
										<td><input type="text" name="siteurl" style="width:300px;height:20px" ></td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr>
										<td align="right"><input type=image src="../img/bt_07.gif" border="0"></td>
									</tr>
									</table>
								</td>
							</tr>
						</table>
						</form>
						<br><br>

						<form name="form2" method="post" action="cyber_linksite_action.jsp" onSubmit="return goInsert('CI')">
							<input type="hidden" name="cmd" value="CI">
							<input type="hidden" name="cateidx" value="<%=cateidx%>">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><b>카테고리 관리</b></td>
						</tr>
						<tr><td height="10"></td></tr>
						</table>

						<table width="100%" border="0" cellspacing="1" cellpadding="10" bgcolor="#D3D2C3">
							<tr bgcolor="#FCFCF6" valign="top">
								<td width="50%">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<% if ( catelist.size() == 0 ) { %>
										<tr height="25">
											<td align=center>등록된 카테고리가 없습니다.</td>
										</tr>
									<%}else{
											for ( int i = 0 ; i < catelist.size(); i++) {
					    	    			HashMap hm3 = (HashMap)catelist.get(i);
									%>
										<tr height="25">
											<td>
												 <%=Utility.ko((String)hm3.get("NAME"))%> &nbsp;&nbsp;
												<a href="javascript:openwin(<%=hm3.get("IDX")%>,'CU')"><img src="/img/common/btn_edit2.gif" border="0" align="absmiddle"></a>
												<a href="javascript:doDel(<%=hm3.get("IDX")%>,'CD')"><img src="/img/common/btn_delete4.gif" border="0" align="absmiddle"></a>
											</td>
										</tr>
									<%}}%>

									</table>
								</td>
								<td width="50%" valign=top>
									<table width="300" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><b>카테코리 등록</b></td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr>
										<td>카테코리명</td>
									</tr>
									<tr>
										<td><input type="text" name="name" style="width:300px;height:20px" ></td>
									</tr>
									<tr><td height="5"></td></tr>
									<tr>
										<td align="right"><input type=image src="../img/bt_07.gif" border="0"></td>
									</tr>
									</table>
								</td>
							</tr>
						</table>
						</form>
						<!-- //관련사이트 끝-->

                      </td>
                    </tr>
                    </form>
                    <tr>
					  <td align="right"   style="padding-top:5;">
					   <a href="cyber_linksite_list.jsp"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
					  </td>
					 </tr>

                  </table>
                   <!--contents end -->

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
    <td height="30"  bgcolor="D4D4B2">
      	<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
     </td>
  </tr>
</table>

<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
