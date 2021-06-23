<%@ page language="java" contentType="text/html; charset=euc-kr"%>

<%
/****************************************
*
* 작성인 : 김미의
* 작성날자 : 2005년 10월 25일
* 요약 설명 : 아산인-수다 /자료실
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.hmm.asan.asanway.cyber.AsanBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ page import="com.hmm.asan.comment.CommentBean" %>
<%@ page import="java.util.HashMap" %>

<%
	String menutitle = "";
	String downfolder = "";
	String tdcolspan = "";
	String menuidx = "";
	String category = request.getParameter("category");

	if(category=="" ){
		out.println("<script language=javascript>");
		out.println("	alert('잘못된 경로로 접근하셨습니다.  다시 시도해 주십시오.');");
		out.println("	history.go(-1);");
		out.println("	</script>");
	}else {
		if(category.equals("asantalk")){
			menutitle = "미래를 열어가는 현대아산人 - 아산인들의 수다 ";
			downfolder = "asantalk";
			tdcolspan = "9";
			menuidx = "18";
		}else if(category.equals("asanpds")){
			menutitle = "미래를 열어가는 현대아산人 - 아산인 자료실";
			downfolder = "asanpds";
			tdcolspan = "11";
			menuidx = "18";

		}else if(category.equals("asannotice")){
			menutitle = "미래를 열어가는 현대아산人 - 공지/회람";
			downfolder = "asannotice";
			tdcolspan = "11";
			menuidx = "18";

		}else if(category.equals("weeklytrend")){
			menutitle = "사이버 홍보실 - 주간동향";
			downfolder = "weeklytrend";
			tdcolspan = "11";
			menuidx = "20";

		}else if(category.equals("echo")){
			menutitle = "사이버 홍보실 - 금강산 메아리";
			downfolder = "echo";
			tdcolspan = "11";
			menuidx = "20";

		}else{
			out.println("<script language=javascript>");
			out.println("	alert('잘못된 경로로 접근하셨습니다. 다시 시도해 주십시오.');");
			out.println("	history.go(-1);");
			out.println("	</script>");
		}
	}
%>

<%
	AsanBean bean = new AsanBean(category);
	bean.Read(request, response);

	CommentBean comment = new CommentBean();
	comment.CommentList(request, response, "press");
%>

<jsp:useBean id="read" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fileread" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="commentlist" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="viewmemlist" class="java.util.ArrayList" scope="request" />

<jsp:useBean id="preview" class="java.util.HashMap" scope="request" />
<jsp:useBean id="nextview" class="java.util.HashMap" scope="request" />

<html>
<head>
<%@ include file="/asanway/common/head.jsp" %>
<%@ page import="com.hmm.asan.asanway.admin.AuthBean" %>
<%
	AuthBean auth = new AuthBean();
	if (!auth.AuthCheck(request, response, menuidx)){
		response.sendRedirect("cyber_main.jsp?flag=1");
	}
%>

<script language="javascript">

<!--
	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			location.href="/asanway/cyber/cyber_asan_action.jsp?category=<%=category%>&cmd=D&idx="+idx;
		}
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
            </table>
          </td>
          <td valign="top" bgcolor="FCFCF6">
          	<table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding: 15 0 0 20;">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="40" class="large"><img src="../img/bt_03.gif" width="10" height="14" align="absmiddle">&nbsp;&nbsp;<b><%=menutitle%></b></td>
                    </tr>
                    <tr>
                      <td>
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-style:solid; border-color:#DEDDCF; border-width:1;">
                          <tr>
                            <td>
                              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr bgcolor="F2F1E2">
                                  <td width="100" height="30" align="center" bgcolor="DEDDCF">제목</td>
                                  <td bgcolor="F2F1E2" style="padding-left:5;" width=540><%= Utility.ko( (String)read.get("TITLE") )%></td>
                                </tr>
                                <tr>
                                  <td height="1" bgcolor="D3D2C3"  colspan=2></td>
                                </tr>
                                <tr>
                                  <td  height="30" align="center" colspan=2 >

                                  	<table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  		<tr>
		                                  <td height="30" align="center" bgcolor="DEDDCF" width=100>등록일</td>
		                                  <td bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("REGTIME").toString().substring(0, 10) %></td>

										  <%if(!category.equals("asantalk")) { %>
			                                  <td width="80" align="center" bgcolor="DEDDCF">첨부파일</td>
			                                  <td bgcolor="F2F1E2" td width="100" style="padding-left:5;">
			                                  	<table>
				                                  	<tr>
				                                  	   <td>
					    	                              <% if( fileread.size() == 0 ) { %>
					    	                              		없음.
					    	                              <% } else {
					    	                                  	for(int i = 0; i < fileread.size() ; i++) {
					    	                                  	    HashMap hm = (HashMap)fileread.get(i);
					    								  %>
					    									<a href="/asanway/common/download.jsp?dir=<%=downfolder%>&filename=<%= Utility.ko((String)hm.get("FILE")) %>&sysfilename=<%= hm.get("SYSFILE") %>"><img src="../img/icon_file.gif" border="0"></a>
					    	                              <% } }  %>
													  </td>
													</tr>
				                                  </table>
			                                  </td>
		                                  <%}%>

		                                  <td width="80" align="center" bgcolor="DEDDCF">조회 </td>
		                                  <td width="100" bgcolor="F2F1E2" style="padding-left:5;"><%= read.get("HIT") %></td>
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
                      <td height="5"></td>
                    </tr>
                    <tr>
                      <td valign="top" style="padding:10 10 10 10;"><%= Utility.ko( (String)read.get("CONTENT") ) %></td>
                    </tr>
                    <tr>
	                    <td colspan="2" height="1" bgcolor="DBDACB"></td>
	                </tr>
	                <tr>
                      <td height="5"></td>
                    </tr>

                    <%if(category.equals("asannotice")) { %>
                    <tr>
                      <td >[<b>미회람자 리스트</b>]</td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
					<tr>
                      <td align=center>
                  			<table border="0" cellpadding="0" cellspacing="0" width="624" background="/img/common/box_624_1_bg.gif">
								<tr>
									<td><img src="/img/common/box_624_1_top.gif"></td>
								</tr>
								<tr>
									<td style="line-height:20px;padding-left:13">
										<% if( viewmemlist.size() == 0 ) {  %>
												&nbsp;&nbsp;미회람자가 없습니다.
										<% } else { %>
										<%
												int i = 0;
												int num = 11;
												int k = 0;

												for( i = 0; i < viewmemlist.size()  ; i++ ) {
													HashMap hm = (HashMap) viewmemlist.get(i);
										%>

												<% if((i != 0 )&& (i % (num) == 0)) { %>
													<br>
												<% } %>
													<%=Utility.ko((String)hm.get("NAME") )%>

												<% if((i !=( viewmemlist.size()-1)) && (( i+1) != num)) {%>
														&nbsp;&nbsp;
												<%	} %>
											<%	}%>
										<%	}%>
									</td>
								<tr>
									<td><img src="/img/common/box_624_1_bottom.gif"></td>
								</tr>
							</table>
                      </td>
                    </tr>
                    <tr>
                      <td height="5"></td>
                    </tr>
					<tr>
	                    <td colspan="2" height="1" bgcolor="DBDACB"></td>
	                </tr>
	                <tr>
                      <td height="5"></td>
                    </tr>
					<%}%>

					<%if(category.equals("asantalk") || category.equals("asanpds") || category.equals("asannotice")) { %>
                    <tr>
                      <td align=center>
                    	<!-- 덧글-->
                       <table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td style="padding-left:13"><a href="#"><img src="/img/common/btn_open.gif" align="absmiddle" border=0></a>
							<a href="#"><img src="/img/common/btn_close.gif" align="absmiddle" border=0></a>
							<img src="/img/common/ico_new.gif" align="absmiddle" border=0></td>
						</tr>
						<tr><td height="5"></td></tr>
						</table>

						<table border="0" cellpadding="0" cellspacing="0" width="624" background="/img/common/box_624_1_bg.gif">
						<tr>
							<td><img src="/img/common/box_624_1_top.gif"></td>
						</tr>
						<tr>
							<td align="center">
								<!-- 덧글메세지-->

								<table border="0" cellpadding="0" cellspacing="0" width="604">
								<col width="70" style="padding-left:5;"></col>
								<col width="434"></col>
								<col width="90" align="center" style="font-size:11px"></col>

								<% if( commentlist.size() == 0 ) {%>
								<tr height="30">
									<td style="color:#333333; padding-top:3"></td>
									<td class="bbs">등록된 덧글이 없습니다.</td>
									<td class="bbs" style="font-size:11px"></td>
								</tr>
								<tr><td colspan="3" height="1" background="/img/common/bg_dot_01.gif"></td></tr>
								<% } else {
								    	for(int i = 0; i < commentlist.size(); i++) {
								    	    HashMap hm = (HashMap)commentlist.get(i);
								%>
								<tr height="30">
									<td style="color:#333333; padding-top:3"><%= Utility.ko( (String)hm.get("REGNAME") ) %></td>
									<td class="bbs"><%= Utility.ko( (String)hm.get("COMMENT") ) %> <a href="javascript:doCommentDel('<%= hm.get("IDX") %>','<%= read.get("IDX") %>')"><img src="/img/common/btn_delete2.gif" align="absmiddle" border=0 ></a>
									</td>
									<td class="bbs" style="font-size:11px"><%= hm.get("REGTIME").toString().substring(0, 16) %></td>
								</tr>
								<tr><td colspan="3" height="1" background="/img/common/bg_dot_01.gif"></td></tr>
								<%
								    	}
									}
								%>
								<tr><td colspan="3" height="5" ></td></tr>
								<tr height="33">
									<td colspan="3">
									<form name="comment" method="post" action="comment_action.jsp" onSumbit="return CommentAdd()">
									<input type="hidden" name="cmd" value="add">
									<input type="hidden" name="boardname" value="press">
									<input type="hidden" name="boardidx" value="<%= read.get("IDX") %>">
									<INPUT TYPE="text" NAME="comment" class="serach_input" maxlength="200" style="width:540 ; height:17"> <input type="image" src="/img/common/btn_write_add.gif" align="absmiddle" onSubmit="return CommentAdd">
									</form>
									</td>
								</tr>
								</table>
								<!-- //덧글메세지-->

								<script language="javascript">
								<!--
									function CommentAdd()
									{
										var form = document.comment;

										if( 	form.comment.value == null ) {
											alert("덧글 내용이 없습니다.");
											form.comment.focus();

											return false;
										}

										return true;

									}

									function doCommentDel(idx, boardidx)
									{
										if (confirm("삭제하시겠습니까?")) {
											cframe.location.href="comment_action.jsp?cmd=del&commentidx="+idx+"&boardidx="+boardidx;
										}
									}

								//-->
								</script>

							</td>
						</tr>
						<tr>
							<td><img src="/img/common/box_624_1_bottom.gif"></td>
						</tr>
						</table>

					  </td>
					</tr>
					<!-- //덧글-->
					<tr>
                      <td height="5"></td>
                    </tr>
                    <% } %>

                    <tr>
                      <td >
                      <!-- 이전글 다음글-->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
						<% if( preview.size() != 0 ) { %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
                          <tr>
                            <td width="100" height="30" align="center" bgcolor="F2F1E2">이전글</td>
                            <td style="padding-left:5;"><a href="cyber_asan_read.jsp?category=<%=category%>&idx=<%= preview.get("IDX") %>"><%= Utility.ko( (String)preview.get("TITLE") )%></a></td>
                          </tr>
						<% } %>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% if( nextview.size() != 0 )  {%>
                          <tr>
                            <td width="100"  height="30" align="center" bgcolor="F2F1E2">다음글</td>
                            <td style="padding-left:5;"><a href="cyber_asan_read.jsp?category=<%=category%>&idx=<%= nextview.get("IDX") %>"><%= Utility.ko( (String)nextview.get("TITLE") ) %></a></td>
                          </tr>
                          <tr>
                            <td colspan="2" height="1" bgcolor="DBDACB"></td>
                          </tr>
						<% } %>
                        </table>
                        <!--  이전글 다음글-->
                      </td>
                    </tr>
                    <tr>
                      <td align="right"   style="padding-top:5;">
                      <a href="cyber_asan_modify.jsp?category=<%=category%>&idx=<%= read.get("IDX") %>"><img src="../img/bt_08.gif" width="40" height="20" border="0"></a>
                      <a href="javascript:doDel('<%= read.get("IDX")  %>')"><img src="../img/bt_09.gif" width="40" height="20" hspace="3" border="0"></a>
                      <a href="cyber_asan_list.jsp?category=<%=category%>"><img src="../img/bt_10.gif" width="40" height="20" border="0"></a>
                    </tr>
                    <tr>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </td>
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
<iframe id='cframe' name='cframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>


