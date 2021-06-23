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
						<td height="54"><img src="<%=imageServer%>/eng_img/guide/play4_title_01.gif"></td>
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
				  <td height="36"><img src="<%=imageServer%>/eng_img/guide/play04_img01.gif"></td>
				</tr>
				<tr>
				  <td>                  <table width="399" cellpadding="0" cellspacing="1" border="0" class="tabline" style="margin-top:10px;margin-bottom:60px;">
                    <tr align="center"> 
                      <td width="17%" height="26" class="bg_white">Massage</td>
                      <td width="17%" class="bg_white"> Hour</td>
                      <td width="17%" class="bg_white">Fee</td>
                    </tr>
                    <tr align="center"> 
                      <td rowspan="3" class="bg_white">Foot massage</td>
                      <td height="26" class="bg_white"> 20 </td>
                      <td class="bg_white"> $ 24 </td>
                    </tr>
                    <tr align="center">
                      <td height="26" class="bg_white">30</td>
                      <td class="bg_white">$ 29 </td>
                    </tr>
                    <tr align="center">
                      <td height="26" class="bg_white">40</td>
                      <td class="bg_white">$ 34</td>
                    </tr>
                    <tr align="center">
                      <td rowspan="2" class="bg_white">Full massage</td>
                      <td height="26" class="bg_white">40</td>
                      <td class="bg_white">$ 39</td>
                    </tr>
                    <tr align="center"> 
                      <td height="26" class="bg_white"> 60 </td>
                      <td class="bg_white">$ 49 </td>
                    </tr>
                  </table>
</td>
				</tr>
				<tr>
				  <td height="68"><p><img src="<%=imageServer%>/eng_img/guide/play04_img02.gif"></p>
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
