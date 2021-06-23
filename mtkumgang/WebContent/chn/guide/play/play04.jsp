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
						<td height="54"><img src="<%=imageServer%>/chn_img/guide/play4_title_01.gif"></td>
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
				  <td height="36"><img src="<%=imageServer%>/chn_img/guide/play04_img01.gif"></td>
				</tr>
				<tr>
				  <td>                  <table width="399" cellpadding="0" cellspacing="1" border="0" class="tabline" style="margin-top:10px;margin-bottom:60px;">
                    <tr align="center"> 
                      <td width="17%" height="26" class="bg_white"><p class="style1">按摩</p></td>
                      <td width="17%" class="bg_white"><p class="style1">时间</p></td>
                      <td width="17%" class="bg_white"><p class="style1">费用</p></td>
                    </tr>
                    <tr align="center"> 
                      <td rowspan="3" class="bg_white"><p class="style1">脚底按摩</p></td>
                      <td height="26" class="bg_white"> 20分钟 <span class="style1"></span>&#13;</td>
                      <td class="bg_white"> $ 24 </td>
                    </tr>
                    <tr align="center">
                      <td height="26" class="bg_white">30分钟 <span class="style1"></span></td>
                      <td class="bg_white">$ 29 </td>
                    </tr>
                    <tr align="center">
                      <td height="26" class="bg_white">40分钟 <span class="style1"></span></td>
                      <td class="bg_white">$ 34</td>
                    </tr>
                    <tr align="center">
                      <td rowspan="2" class="bg_white"><p class="style1">全身按摩</p></td>
                      <td height="26" class="bg_white">40分钟 <span class="style1"></span></td>
                      <td class="bg_white">$ 39</td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white"> 60分钟 <span class="style1"></span> </td>
                      <td class="bg_white">$ 49 </td>
                    </tr>
                  </table>
</td>
				</tr>
				<tr>
				  <td height="68"><p><img src="<%=imageServer%>/chn_img/guide/play04_img02.gif"></p>
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
