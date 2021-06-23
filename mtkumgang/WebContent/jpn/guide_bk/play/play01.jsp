<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
        <%@ include file="/jpn/include/guide/tour_guide_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/jpn/include/guide/tour_guide_left_utf8.jsp" %>
																		<script language="JavaScript" type="text/JavaScript">
																show_04();
												</script>
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
						<td height="54"><img src="<%=imageServer%>/jpn_img/guide/play1_title_01.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>
				  <td height="36"><img src="<%=imageServer%>/jpn_img/guide/play01_img01.jpg" width="690" height="487"></td>
				</tr>
				<tr>
				  <td>                  <table width="690" cellpadding="0" cellspacing="1" border="0" class="tabline" style="margin-top:10px;margin-bottom:60px;">
                    <tr align="center"> 
                      <td height="26" colspan="2" class="bg_white">銭湯 </td>
                      <td colspan="2" class="bg_white">家族風呂</td>
                      <td colspan="2" class="bg_white">ドクタフィッシ</td>
                    </tr>
                    <tr align="center"> 
                      <td width="17%" height="26" class="bg_white">大人</td>
                      <td width="17%" class="bg_white">児童</td>
                      <td width="18%" class="bg_white">8人室</td>
                      <td width="18%" class="bg_white">15人室</td>
                      <td width="15%" class="bg_white">子供</td>
                      <td width="15%" class="bg_white">児童</td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white">＄12/１回券 </td>
                      <td class="bg_white">＄10/１回券 </td>
                      <td rowspan="2" class="bg_white">基本料＄30に
一人当たり＄10 </td>
                      <td rowspan="2" class="bg_white">基本料＄80に
一人当たり＄10</td>
                      <td class="bg_white" rowspan="2"> ＄10/30分 </td>
                      <td class="bg_white" rowspan="2"> ＄8/30分 </td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white">＄20/2回券 </td>
                      <td class="bg_white">＄16/2回券 </td>
                    </tr>
                  </table>
</td>
				</tr>
				<tr>
				  <td height="68"><p><img src="<%=imageServer%>/jpn_img/guide/play01_img02.jpg" width="690" height="555"></p>
				    <p>&nbsp;</p></td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / detail table  -->
						<!-- detail table / --></td>
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
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
</body>
</html>
