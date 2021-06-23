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
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/eng/include/guide/tour_guide_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/eng/include/guide/tour_guide_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/eng_img/guide/play1_title_01.gif"></td>
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
				  <td height="36"><img src="<%=imageServer%>/eng_img/guide/play01_img01.jpg" width="690" height="487"></td>
				</tr>
				<tr>
				  <td>                  <table width="690" cellpadding="0" cellspacing="1" border="0" class="tabline" style="margin-top:10px;margin-bottom:60px;">
                    <tr align="center"> 
                      <td height="26" colspan="2" class="bg_white">Public Bath </td>
                      <td colspan="2" class="bg_white">Family Bath</td>
                      <td colspan="2" class="bg_white">Doctor Fish</td>
                    </tr>
                    <tr align="center"> 
                      <td width="17%" height="26" class="bg_white">Adult</td>
                      <td width="17%" class="bg_white">Children</td>
                      <td width="18%" class="bg_white">8 persons</td>
                      <td width="18%" class="bg_white">15 persons</td>
                      <td width="15%" class="bg_white">Adult</td>
                      <td width="15%" class="bg_white">Children</td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white">$12 for one session </td>
                      <td class="bg_white">$10 for one session </td>
                      <td rowspan="2" class="bg_white">Basic $30 with additional $10 per person </td>
                      <td rowspan="2" class="bg_white">Basic $80 with additional $10 per person</td>
                      <td class="bg_white" rowspan="2"> $10 for 30 min</td>
                      <td class="bg_white" rowspan="2"> $8 for 30 min</td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white">$20 for two sessions</td>
                      <td class="bg_white">$16 for one session</td>
                    </tr>
                  </table>
</td>
				</tr>
				<tr>
				  <td height="68"><p><img src="<%=imageServer%>/eng_img/guide/play01_img02.jpg" width="690" height="555"></p>
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
        <%@ include file="/eng/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
</body>
</html>
