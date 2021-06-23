<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/jpn/include/guide/tour_guide_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/guide/tour_guide_left.jsp" %>
            <!--  left menu flash -->
				</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/jpn_img/guide/routeguide1_title_01.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="36"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="264">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_1.gif"></td></tr>
								<tr><td height="12"></td></tr>
								<tr><td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_2.gif"></td></tr>
								<tr><td height="20"></td></tr>
								<tr><td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_3.gif"></td></tr>
								<tr><td height="10"></td></tr>
								<tr><td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_4.gif"></td></tr>
								</table>
							</td>
							<td width="426"><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_5.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="68"></td></tr>
				<tr>
					<td valign="top">
						<!-- / detail table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="232"><col width="458">
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_6.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_7.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_8.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_9.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_10.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_11.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_12.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_13.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_14.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_15.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_16.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_17.gif" style="margin-top:11px;"></td>
						</tr>
						<tr valign="top" class="bpad_25">
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_18.jpg"></td>
							<td><img src="<%=imageServer%>/jpn_img/guide/routeguide1_con_19.gif" style="margin-top:11px;"></td>
						</tr>
						</table>
						<!-- detail table / -->
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="/jpn/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
</body>
</html>
