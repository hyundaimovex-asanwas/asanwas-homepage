<%
/****************************************
*
* 작성인 : 김종문
* 작성날자 : 2005년 5월 11일
* 요약 설명 : Notice - 수정
**
* 수정시간  : 수정인 : 수정내용
*
*
******************************************/
%>

<%@ page import="com.idteck.eng.newsroom.notice.NoticeBean" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.idteck.eng.admin.member.AuthBean" %>

<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
	NoticeBean nb = new NoticeBean();
	nb.NoticeRead(request, response);
%>
<jsp:useBean id="noticeread" class="java.util.HashMap" scope="request" />
<jsp:useBean id="fileread" class="java.util.ArrayList" scope="request" />

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="euc-kr" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ include file="/admin/common/include/head.jsp" %>
<%
	menuidx = "25";
	AuthBean ab = new AuthBean();
	ab.AuthValue(request, response, menuidx);
%>
<jsp:useBean id="auth" class="java.util.HashMap" scope="request" />
<%
	String select = null;
	String insert = null;
	String delete = null;
	String update = null;

	if(auth != null) {
		 select = (String)auth.get("auth_select");
		 insert = (String)auth.get("auth_insert");
		 delete = (String)auth.get("auth_delete");
		 update = (String)auth.get("auth_update");
	} else {
		response.sendRedirect("/admin/home.jsp");
	}

	if(select == null || select.equals("false")){
		response.sendRedirect("/admin/newsroom/auth_error.jsp");
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<style type="text/css">
	<!--
	A:link  {color:#696969; text-decoration:none}
	A:visited  {color:#696969; text-decoration:none}
	A:hover  {color:#000000; text-decoration:underline}

	td {color:#696969; font-family:굴림; font-size:9pt; line-height=16px;}
	-->
	</style>
</head>
<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>
<script language="javascript">
<!--
	function goUpdate()
	{
	<% if(update == null && update.equals("false")){ %>
		return false;
	<% } %>
		if(document.notice.title.value=="")
		{
			alert("제목을 입력하세요.");
			document.notice.title.focus();
			return false;
		}
		if(document.notice.content.value=="")
		{
			alert("내용을 입력하세요.");
			document.notice.content.focus();
			return false;
		}

		return true;

//		document.notice.action = "/admin/newsroom/notice/notice_update.jsp";
//		document.notice.submit();
	}

	function goClear()
	{
		//obj = eval("document.notice.filename")
		//obj1 = eval("document.notice.filename")
		//obj.outerHTML = obj1.outerHTML;
		document.notice.filename.outerHTML = document.notice.filename.outerHTML;

		//	 document.form.file1.outerHTML = document.form.file1.outerHTML;

	}
		function makeDelList(idx) {
			var form = document.notice;

			var data_obj = form.fileidxlist[idx];
			var datadel_obj = form.fileidxdelfg[idx];
			var img_obj = form.fileidxcheck[idx];

			//product 가 1개일때는 배열이 아님
			if(data_obj == null) {
				data_obj = form.fileidxlist;
				datadel_obj = form.fileidxdelfg;
				img_obj = form.fileidxcheck;
			}

			/*if(img_obj.src.indexOf("del2.gif") > 0) {
				img_obj.src = "/admin/common/img/btn_cancel.gif";
				datadel_obj.value = "1";
			} else {
				img_obj.src = "/admin/common/img/btn_del2.gif";
				datadel_obj.value = "0";
			}*/

			if(img_obj.checked) {
				datadel_obj.value = "1";
			} else {
				datadel_obj.value = "0";
			}
		}

	function doDel(idx)
	{
		var idx = idx;

		if (confirm("삭제하시겠습니까?")) {
			// 확인 버튼을 눌렀을 때 실행해야 할 프로그램
			location.href="/admin/newsroom/notice/notice_del.jsp?idx="+idx;
		} else {
			// 취소 버튼을 눌렀을 때 실행해야 할 프로그램
		}
	}

	//-->
</script>
<body leftmargin="0" topmargin="0">

<!--GNB-->
<Table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10"></td>
		<td><%@ include file="/admin/common/include/gnb.jsp" %></td>
	</tr>
</table>
<!--//GNB-->

<!--body-->
<Table width="905" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10"></td>
		<td valign="top"><jsp:include page="/admin/newsroom/include/left.jsp" flush="true" /></td>
		<td width="1"></td>

		<td valign="top">
		<!--location-->
		<Table width="740" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height=35 align="right" class="location_bg"><a href="#" class="location">Home</a> > <a href="/admin/newsroom/notice/notice_list.jsp" class="location">Newsroom</a> > <font class="location"><b>Notice</b></font></td>
				<td width="13" class="location_bg"></td>
			</tr>
		</table>
		<!--//location-->

		<!--title-->
		<Table width="740" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15"></td>
				<td>
				<Table width="710" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="22"></td>
					</tr>
					<tr>
						<td><img src="/admin/common/img/bl_ti.gif" align="absmiddle"><font class="ti">Notice 수정</font></td>
					</tr>
				</table>
				</td>
				<td width="15"></td>
			</tr>
		</table>
		<!--//title-->

		<Table width="740" border="0" cellspacing="0" cellpadding="0">
			<tr><Td height="15"></Td></tr>
		</table>

		<!--table-->
		<Table width="740" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15"></td>
				<td>

	<form name="notice" method="post" action="/admin/newsroom/notice/notice_update.jsp" onSubmit="return goUpdate()" enctype="multipart/form-data" >
	<input type="hidden" name="idx" value="<%= noticeread.get("idx") %>">
				<!--table-->
				<Table width="710" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="1" class="left_line"></td>
					</tr>
					<tr>
						<td height="12"></td>
					</tr>
					<tr>
						<td width="710">
						<Table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_top.gif"></Td>
								<td width="7"></td>
								<td width="586"></td>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">제목&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
								<INPUT TYPE="text" CLASS="input" SIZE="47" name="title" value="<%= noticeread.get("title") %>">
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">작성자&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
									<font class="small"><%= noticeread.get("regname") %><input type="hidden" name="regname" value="<%= noticeread.get("regname") %>"></font>
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">작성일&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
									<font class="small"><%= noticeread.get("regtime").toString().substring(0, 10) %></font>
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top">노출&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:8px;padding-bottom:8px;">

									<select style="width:90px; height:20px;" name="display">
										<option value="1" <% if(noticeread.get("display").equals("true")) { %>selected <% } %>>YES</option>
										<option value="0" <% if(noticeread.get("display").equals("false")) { %>selected <% } %>>NO</option>
									</select>

								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top">Link&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:8px;padding-bottom:8px;">
								<input name="link" type="text" size="47" class="input" value="<%= noticeread.get("link") %>"></td>
							</tr>
							<tr>
								<td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top">다운로드&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:8px;padding-bottom:8px;">
									<% if (fileread.size() != 0) {
												for(int i = 0; i < fileread.size(); i++) {
												HashMap hm = (HashMap)fileread.get(i);
									%><table>
											<tr>
												<td width="70%"><%= hm.get("filename") %>
													<input type="hidden" name="fileidxlist" value="<%=hm.get("idx")%>">
													<input type="hidden" name="fileidxdelfg" value="0">
												</td>
												<td width="50" align="right">
													<input type="checkbox" name="fileidxcheck" onClick="makeDelList(<%=i%>)">삭제
												</td>
											</tr>
											</table>
									<% } } %>
								<input name="filename" class=input type="file" size="47">&nbsp;<a href="#" onClick="goClear()"><img src="/admin/common/img/btn_del.gif" align="absmiddle" border="0"></a></td>
							</tr>
							<tr>
								<td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top"> 내용&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:6px; padding-bottom:6px">
								<font color="red">테이블 삽입시 테이블 크기(가로)는 "520px" 보다 작아야 합니다.</font>
							<FCK:editor id="content" basePath="/FCKeditor/"
								toolbarSet="idteck"
								height="300"
								customConfigurationsPath="/admin/common/js/fckconfig.js"
								imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
								linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector">
								<%= noticeread.get("content") %>
							</FCK:editor>
								</td>
							</tr>

							<tr>
								<Td><img src="/admin/common/img/table_box_bot.gif"></Td>
								<td width="7"></td>
								<td></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="12"></td>
					</tr>
					<tr>
						<td height="1" class="left_line"></td>
					</tr>
				</table>
				<!--//table-->

				<!--버튼-->
				<Table width="710" border="0" cellspacing="0" cellpadding="0">
					<tr><Td height="5" colspan="2"></Td></tr>
					<tr>
						<td align="right">
							<a href="/admin/newsroom/notice/notice_list.jsp"><img src="/admin/common/img/btn_list.gif" border="0"></a>
						<% if(delete != null && delete.equals("true")){ %>
							<a href="javascript:doDel('<%= noticeread.get("idx") %>')"><img src="/admin/common/img/btn_del2.gif" border="0"></a>
						<% } %>
						<% if(update != null && update.equals("true")){ %>
							<input type="image" src="/admin/common/img/btn_apply.gif" border="0">
						<% } %>
						</td>
						<td width="10"></td>
					</tr>
				</table>
				<!--//버튼-->
	</form>

				</td>
				<td width="15"></td>
			</tr>
		</table>
		<!--//table-->

		</td>
	</tr>
</table>
<!--//body-->

<!--footer-->
<Table width="905" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="50"></td>
	</tr>
	<tr>
		<td width="10"></td>
		<td><jsp:include page="/admin/common/include/footer.jsp" flush="true" /></td>
	</tr>
</table>
<!--//footer-->

</body>
</html>
