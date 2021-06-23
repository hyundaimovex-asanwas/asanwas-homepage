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
.style1 {font-family: SimHei}
-->
</style>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/preview/tour_preview_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/preview/tour_preview_left_utf8.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/chn_img/preview/img_preview02.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="3">&nbsp;</td>
              </tr>
              <tr> 
                <td height="19" colspan="3"><img src="<%=imageServer%>/chn_img/preview/img_top_preview02.gif"></td>
              </tr>
              <tr> 
                <td height="41">&nbsp;</td>
              </tr>
              <tr> 
                <td width="213"><img src="<%=imageServer%>/chn_img/preview/img_history01.jpg"></td>
                <td width="21"></td>
                <td width="456"><img src="<%=imageServer%>/chn_img/preview/img_history01.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/chn_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/chn_img/preview/img_history02.gif"></td>
              </tr>
              <tr> 
                <td height="20"></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/chn_img/preview/img_history02.jpg"></td>
                <td></td>
                <td><img src="<%=imageServer%>/chn_img/preview/img_history03.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td style="padding: 50  0  10 0 "><img src="<%=imageServer%>/chn_img/preview/txt_history00.gif"></td>
              </tr>
            </table>
            <table width="690" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="80" rowspan="3"  style="padding-top:38"><img src="<%=imageServer%>/chn_img/preview/2006.gif"></td>
                <td width="16" rowspan="3"></td>
                <td width="32" valign="bottom" style="padding-top:38"><strong>07.17</strong></td>
                <td width="43" rowspan="3"></td>
                <td style="padding-top:38"><span class="style1">花津浦峨山休息所外金????? </span></td>
              </tr>
              
              <tr> 
                <td align="left"><strong>05.27</strong></td>
                <td align="left"><span class="style1">踏勘?金??光路? </span></td>
              </tr>
              <tr> 
                <td align="left"><strong>04.28 </strong></td>
                <td align="left"><span class="style1">第24?MBC?作童?? </span></td>
              </tr>
              <tr> 
                <td height="31" colspan="5">&nbsp;</td>
              </tr>
              <tr> 
                <td rowspan="7" valign="top"><img src="<%=imageServer%>/chn_img/preview/2005.gif"></td>
                <td rowspan="7">&nbsp;</td>
                <td valign="top"><strong>10.04</strong></td>
                <td rowspan="7">&nbsp;</td>
                <td><span class="style1">第86?蔚山全?????火采火 </span></td>
              </tr>
              
              <tr> 
                <td valign="top"><strong>09.01</strong></td>
                <td><span class="style1">玉流?、海???、?井????? </span></td>
              </tr>
              
              <tr> 
                <td><strong>08.31</strong></td>
                <td><span class="style1">?散家族?面所?工 </span></td>
              </tr>
              <tr> 
                <td valign="top"><strong>07.17</strong></td>
                <td><span class="style1">玄?恩董事?面?金正日?防委?? </span></td>
              </tr>
              
              <tr> 
                <td valign="top"><strong>06.08</strong></td>
                <td><span class="style1">??‘金?山?光人次突破100万名’?念音?? </span></td>
              </tr>
              
              <tr> 
                <td valign="top"><strong>04.01</strong></td>
                <td><span class="style1">南北新婚夫妻植?活? </span></td>
              </tr>
              
              <tr> 
                <td><strong>02</strong></td>
                <td><span class="style1">拍??影‘?大家族’ </span></td>
              </tr>
              <tr> 
                <td height="31" colspan="5">&nbsp; </td>
              </tr>
              <tr> 
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/chn_img/preview/2004.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>11.20 </strong></td>
                <td rowspan="4">&nbsp;</td>
                <td><span class="style1">神溪寺大雄殿落成 </span></td>
              </tr>
              <tr> 
                <td><strong>11.19</strong></td>
                <td><span class="style1">金?山高?夫球??工 </span></td>
              </tr>
              <tr> 
                <td><strong>09.07</strong></td>
                <td><span class="style1">忠北全?????火采火 </span></td>
              </tr>
              <tr> 
                <td><strong>07.02</strong></td>
                <td><span class="style1">金?山???? </span></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/chn_img/preview/2003.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>09</strong></td>
                <td>&nbsp;</td>
                <td valign="top"><span class="style1">金?山公路?光?通<br>
                </span></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/chn_img/preview/2002.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>04~?在</strong> </td>
                <td>&nbsp;</td>
                <td valign="top"><span class="style1">第4??第14?南北?散家族相逢活?</span></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td><img src="<%=imageServer%>/chn_img/preview/2001.gif"></td>
                <td>&nbsp;</td>
                <td valign="top"><strong>08.14</strong></td>
                <td>&nbsp;</td>
                <td valign="top"><span class="style1">??汽?展 </span></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td rowspan="4" valign="top"><img src="<%=imageServer%>/chn_img/preview/2000.gif"></td>
                <td rowspan="4">&nbsp;</td>
                <td><strong>09.30</strong></td>
                <td rowspan="4">&nbsp;</td>
                <td><span class="style1">金正日?防委????金?山 </span></td>
              </tr>
              <tr> 
                <td><strong>06.15</strong></td>
                <td><span class="style1">南北首??? </span></td>
              </tr>
              <tr> 
                <td><strong>05.24</strong></td>
                <td><span class="style1">高城港??竣工 </span></td>
              </tr>
              <tr> 
                <td><strong>05.08</strong></td>
                <td><span class="style1">全??美大? </span></td>
              </tr>
              <tr> 
                <td height="31"></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td rowspan="3" valign="top"><img src="<%=imageServer%>/chn_img/preview/1998.gif"></td>
                <td rowspan="3">&nbsp;</td>
                <td valign="top"><strong>11.18 </strong></td>
                <td rowspan="3">&nbsp;</td>
                <td><span class="style1">?代集?金??船首港</span></td>
              </tr>
              <tr> 
                <td valign="top"><strong>10.30</strong></td>
                <td><span class="style1">?周永名?董事?面?金正日?防委?? </span></td>
              </tr>
              <tr> 
                <td valign="top"><strong>06.16</strong></td>
                <td><span class="style1">?周永名?董事???牛群??北部 </span></td>
              </tr>
              <tr> 
                <td height="31">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><span class="style1"></span></td>
              </tr>
              <tr> 
                <td rowspan="2" valign="top"><img src="<%=imageServer%>/chn_img/preview/1989.gif"></td>
                <td rowspan="2">&nbsp;</td>
                <td valign="top"><strong>01.31</strong></td>
                <td rowspan="2">&nbsp;</td>
                <td><span class="style1">??金?山?光??意向?(平壤) </span></td>
              </tr>
              <tr> 
                <td valign="top"><strong>01.24</strong></td>
                <td><span class="style1">?周永名?董事?首次??北部/??金?山??及西伯利?共同??意向? </span></td>
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