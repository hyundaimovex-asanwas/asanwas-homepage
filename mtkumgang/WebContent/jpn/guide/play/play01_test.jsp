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
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<style type="text/css">
<!--
.style1 {font-family: SIMHEI}
-->
</style>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/guide/tour_guide_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/guide/tour_guide_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/chn_img/guide/play1_title_01.gif"></td>
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
				  <td height="36"><img src="<%=imageServer%>/chn_img/guide/play01_img01.jpg" width="690" height="360"></td>
				</tr>
				<tr>
				  <td>                  <table width="690" cellpadding="0" cellspacing="1" border="0" class="tabline" style="margin-top:10px;margin-bottom:60px;">
                    <tr align="center"> 
                      <td height="26" colspan="2" class="bg_white"><p class="style1">大?池</p></td>
                      <td colspan="2" class="bg_white"><p class="style1">家庭池</p></td>
                      <td colspan="2" class="bg_white"><p class="style1">治病?</p></td>
                    </tr>
                    <tr align="center"> 
                      <td width="17%" height="26" class="bg_white"><p class="style1">成年人</p></td>
                      <td width="17%" class="bg_white"><p class="style1">?童</p></td>
                      <td width="18%" class="bg_white"><p class="style1">8人?</p></td>
                      <td width="18%" class="bg_white"><p class="style1">15人?</p></td>
                      <td width="15%" class="bg_white"><p class="style1">成年人</p></td>
                      <td width="15%" class="bg_white"><p class="style1">?童</p></td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white"><p>$12/1次</p></td>
                      <td class="bg_white"><p class="style1">$10/1次</p></td>
                      <td rowspan="2" class="bg_white"><p class="style1">基本?$30，<br>
                      每人多加$10</p></td>
                      <td rowspan="2" class="bg_white"><p class="style1">基本?$80，<br>
                      每人多加$10&#13;</p></td>
                      <td class="bg_white" rowspan="2"><p class="style1">$10/30分?</p></td>
                      <td class="bg_white" rowspan="2"><p class="style1">$8/30分?</p></td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white"><p class="style1">$20/2次</p></td>
                      <td class="bg_white"><p class="style1">$16/2次</p></td>
                    </tr>
                  </table>
</td>
				</tr>
				<tr>
				  <td height="68"><p><img src="<%=imageServer%>/chn_img/guide/play01_img02.jpg" width="690" height="557"></p>
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
        <%@ include file="/chn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
</body>
</html>
