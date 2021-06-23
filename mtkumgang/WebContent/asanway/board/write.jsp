<%
/****************************************
*
* ??¨ù¨¬?? : ¡¾??¨ú©ö¢ç
* ??¨ù¨¬©ø??? : 2005©ø? 5¢¯? 10??
* ¢¯?¨ú? ¨ù©ø¢¬? : Notice - ??¡¤?
**
* ¨ù??¢´¨ö?¡Æ?  : ¨ù??¢´?? : ¨ù??¢´©ø?¢¯?
*
*
******************************************/
%>
<%@ page import="com.idteck.eng.newsroom.notice.NoticeBean" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.idteck.eng.admin.member.AuthBean" %>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>

<%
	NoticeBean nb = new NoticeBean();
	nb.getUserInfo(request, response);

	//¢¯?¢¥? ©ø????? ©ø?, ¢¯?, ???? ??¨ù¨¬, default select ?¡×??
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy");

	String Year = sdf.format(d);

	sdf = new SimpleDateFormat("MM");
	String Month = sdf.format(d);

	sdf = new SimpleDateFormat("dd");
	String Day = sdf.format(d);

	String day = Year +"©ø? "+ Month +"¢¯? "+ Day+"??";
%>
<jsp:useBean id="userinfo" class="java.util.HashMap" scope="request" />

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="euc-kr" %>

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

<script language="javascript">
<!--
	function goAdd()
	{

	<% if(insert == null || insert.equals("false")){ %>
		return false;
	<% } %>

	var form = document.notice;

		if(document.notice.title.value=="")
		{
			alert("??¢¬??? ??¡¤???¨ù¨ù¢¯?.");
			document.notice.title.focus();
			return false;
		}

alert(form.content.value());
		if(document.notice.content.value=="")
		{
			alert("©ø?¢¯??? ??¡¤???¨ù¨ù¢¯?.");
			document.notice.content.focus();
			return false;
		}

		return true;

//		document.notice.action = "/admin/newsroom/notice/notice_add.jsp";
//		document.notice.submit();
	}

	function goClear()
	{
		var tmp_obj = eval("document.notice.filename")
		var tmp_obj1 = eval("document.notice.filename")
		tmp_obj.outerHTML = tmp_obj1.outerHTML;

		//	 document.form.file1.outerHTML = document.form.file1.outerHTML;

	}


	//-->
</script>

<body leftmargin="0" topmargin="0">
	<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>

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
						<td><img src="/admin/common/img/bl_ti.gif" align="absmiddle"><font class="ti">Notice ??¡¤?</font></td>
					</tr>
				</table>
				</td>
				<td width="15"></td>
			</tr>
		</table>
		<!--//title-->

		<Table width="710" border="0" cellspacing="0" cellpadding="0">
			<tr><Td height="15"></Td></tr>
		</table>

		<!--table-->
		<Table width="710" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15"></td>
				<td>

	<form name="notice" method="post" action="/admin/newsroom/notice/notice_add.jsp" enctype="multipart/form-data" onSubmit="return goAdd()">
	<input type="hidden" name="category" value="Notice">
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
								<td width="436"></td>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">??¢¬?&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
								<INPUT TYPE="text" CLASS="input" SIZE="47" name="title">
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">??¨ù¨¬??&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
									<font class="small"><%= userinfo.get("name")%><input type="hidden" name="regname" value="<%= userinfo.get("name") %>"></font>
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" height="26" align="right" valign="top" style="padding-top:6px;"><font class="board_top">??¨ù¨¬??&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td>
									<font class="small"><%= day %></font>
								</td>
							</tr>
							<tr>
								<Td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top">©ø???&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:8px;padding-bottom:8px;">

									<select style="width:90px; height:20px;" name="display">
										<option value="1" >YES</option>
										<option value="0" >NO</option>
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
								<input name="link" type="text" size="47" class="input"></td>
							</tr>
							<tr>
								<td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top">¢¥?¢¯?¡¤???&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:8px;padding-bottom:8px;">
								<input name="filename" type="file" size="47">&nbsp;<a href="#" onClick="goClear();"><img src="/admin/common/img/btn_del.gif" align="absmiddle" border="0"></a>
								</td>
							</tr>

							<tr>
								<td width="117"><img src="/admin/common/img/table_box_line.gif"></Td>
								<td width="7"></td>
								<td height="1" background="/admin/common/img/left_dot.gif"></td>
							</tr>
							<tr>
								<td class="board_bg" align="right" valign="top" style="padding-top:6px;"><font class="board_top"> ©ø?¢¯?&nbsp;&nbsp;</font></td>
								<td width="7"></td>
								<td style="padding-top:6px; padding-bottom:6px">
								<font color="red">?¡¿??¨¬? ?©£??¨ö? ?¡¿??¨¬? ??¡¾?(¡Æ¢®¡¤?)¢¥? "520px" ¨¬¢¬¢¥? ??¨ú¨¡¨ú©¬ ??¢¥?¢¥?</font>
									<FCK:editor id="content" basePath="/FCKeditor/"
										width="585"
										height="300"
										toolbarSet="idteck"
										customConfigurationsPath="/admin/common/js/fckconfig.js"
										imageBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
										linkBrowserURL="/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector" >
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

				<!--©ö?¨¡¡Æ-->
				<Table width="710" border="0" cellspacing="0" cellpadding="0">
					<tr><Td height="5" colspan="2"></Td></tr>
					<tr>
						<td align="right">
						<% if(insert != null && insert.equals("true")){ %>
							<input type="image" src="/admin/common/img/btn_regist.gif" border="0">
						<% } %>
						</td>
						<td width="10"></td>
					</tr>
				</table>
				<!--//©ö?¨¡¡Æ-->
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
<Table width="755" border="0" cellpadding="0" cellspacing="0">
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
