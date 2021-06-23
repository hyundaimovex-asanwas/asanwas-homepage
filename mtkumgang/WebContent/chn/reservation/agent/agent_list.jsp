<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%
String pageNum = "1";
String subNum = "1";
String McNum = "2";
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
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
/* function autoblur(){
if(event.srcElement.tagName == "A") document.body.focus();
}
document.onfocusin = autoblur;
*/
/*  High-peak season/ Peak season/ Low season/ 레이어 페이지 */
function nation_01()
{
	document.all("nat_01").style.display="";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="none";
	document.all("nat_04").style.display="none";
}

function nation_02()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="";
	document.all("nat_03").style.display="none";
	document.all("nat_04").style.display="none";
}

function nation_03()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="";	
	document.all("nat_04").style.display="none";
}

function nation_04()
{
	document.all("nat_01").style.display="none";
	document.all("nat_02").style.display="none";
	document.all("nat_03").style.display="none";	
	document.all("nat_04").style.display="";
}


/*
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);*/
//-->
</script>

</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="/chn/include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_app04.gif"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/chn_img/apply/top_txt_app04.gif"></td></tr>
				<tr><td height="25"></td></tr>
				<tr valign="top">
					<td><!--  agency map flash -->
						 <table width="285" cellpadding="0" cellspacing="0" border="0">
						   <tr>
						     <!--<td width="1" class="line_g3"></td>-->
							  <td width="284" style="padding:0 0 37 0px;">
							    <table width="284" cellpadding="0" cellspacing="0" border="0">
							      <tr><td><img src="<%=imageServer%>/chn_img/apply/img_rig_app04.jpg"></td></tr>
							      </table>							  </td>
						  </tr>
						    </table></td>
					</tr>
				<tr>
					<td valign="top"><div><div style='display:' id='nat_01'><table width="690" cellpadding="0" cellspacing="0" border="0"><tr><Td colspan="2">
					<a href="javascript:nation_01();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_01on.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01on.gif'"></a>
					<a href="javascript:nation_02();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_02.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02.gif'"></a>
					<a href="javascript:nation_03();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_03.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03.gif'"></a>
					<a href="javascript:nation_04();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_04.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04.gif'"></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140"><col width="250"><col width="110"><col width="110"><col width="70">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/chn_img/apply/txt_agent01.gif"><!-- 대리점명 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent02.gif"><!-- 주소 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent03.gif"><!-- 전화번호 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent04.gif"><!-- 팩스번호 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
          				
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">STAR TOUR</td>
							<td align="left" class="tpad_3 lpad_10">Rm 301,Build9.No2558 Yanan(w)Rd.shanghai,china</td>
							<td>(021)62958836-62959023</td>
							<td>(021)62959183-62997915</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">CYTS</td>
							<td align="left" class="tpad_3 lpad_10">17/FCYTS Plaza,No.5,Dongzhimen South
Avenue,Dongcheng District,Beijing,China 100007</td>
							<td>(010)5815-8318</td>
							<td>(010)5815-8307</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">SHANGHAI TEA METROPOL INTERNATIONAL</td>
							<td align="left" class="tpad_3 lpad_10">Rm316,YongTeng Bldg.No.1065,WuZhong Rd.,Shanghai,201103 China</td>
							<td>(021)5150-3620</td>
							<td>(021)5150-3624</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
<!--
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">한국인회</td>
							<td align="left" class="tpad_3 lpad_10">上海市 ?行? ?中路 1100? 炫???大厦 616室 </td>
							<td>(021)6209-5175</td>
							<td>(021)6208-1743 </td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>
-->
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">SUJI TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6246-1234</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">SA TOURS</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6535-2611</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

                        <tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">COMMONWEALTH TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6538-8533</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">CHAN BROTHERS TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6212-9679</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">DYNASTY TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6533-4455</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">UNIVERSAL TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6535-5577</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">HONG THAI TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10"></td>
							<td>6533-1788</td>
							<td></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">KOREA TOURISM ORGANIZATION</td>
							<td align="left" class="tpad_3 lpad_10">24 Raffles Place #20-01 Clifford Centre Singapore 048621</td>
							<td>65-6533-0441</td>
							<td>65-6534-3427</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

				       <tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">UTC</td>
							<td align="left" class="tpad_3 lpad_10">101 Upper Cross Street #B1-66 People’s Park Centre Singapore 058357</td>
							<td>6533-3922</td>
							<td>6536-7010</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">SINO-AMERICA TOURS</td>
							<td align="left" class="tpad_3 lpad_10">1 Park Road #04-62 People’s Complex Singapore 059108</td>
							<td>6535-2611</td>
							<td>6533-2973</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">CHAN BROTHERS</td>
							<td align="left" class="tpad_3 lpad_10">150 South Bridge Road #06-08 Fook Hai Building Singapore 058727</td>
							<td>6212-9952</td>
							<td>6533-9016</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">HONG THAI TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10">1 Park Road, #02-121 People’s Park Complex, Singapore 059108</td>
							<td>(65)6533-9633</td>
							<td>(65)6534-1633</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

          				<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->					</td>
				</tr>
				</table></div>
				<div style='display:none;' id='nat_02'><table width="690" cellpadding="0" cellspacing="0" border="0"><tr><Td colspan="2">
					<a href="javascript:nation_01();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_01.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01.gif'"></a>
					<a href="javascript:nation_02();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_02on.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02on.gif'"></a>
					<a href="javascript:nation_03();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_03.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03.gif'"></a>
					<a href="javascript:nation_04();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_04.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04.gif'"></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140"><col width="250"><col width="110"><col width="110"><col width="70">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/chn_img/apply/txt_agent01.gif"><!-- 대리점명 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent02.gif"><!-- 주소 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent03.gif"><!-- 전화번호 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent04.gif"><!-- 팩스번호 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
          				
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">ZUJI TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10">1 Scotts Road #20-03 Shaw Centre Singapore 228208</td>
							<td>(65)6720-1223</td>
							<td>(65)6226-0382</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">DYNASTY TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10">135 new Bridge Road Level 4 Dynasty Travel Hub Singapore 059395</td>
							<td>(65)6536-2128</td>
							<td>(65)6536-2108</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">COMMONWEALTH TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10">46/47 Mosque Street, Singapore 059525</td>
							<td>(65)6532-0532</td>
							<td>(65)6532-0235</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">ALAN TRAVEL</td>
							<td align="left" class="tpad_3 lpad_10">Rm703, Jindo B/D, #37, Dowha-dong, Mapo-Gu, Seoul, Korea</td>
							<td>(82)02-715-3241</td>
							<td>(82)02-715-3542</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

          				<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->					</td>
				</tr>
				</table></div>

				<div style='display:none;' id='nat_03'><table width="690" cellpadding="0" cellspacing="0" border="0"><tr><Td colspan="2">
					<a href="javascript:nation_01();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_01.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01.gif'"></a>
					<a href="javascript:nation_02();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_02.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02.gif'"></a>
					<a href="javascript:nation_03();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_03on.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03on.gif'"></a>
					<a href="javascript:nation_04();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_04.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04.gif'"></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140"><col width="250"><col width="110"><col width="110"><col width="70">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/chn_img/apply/txt_agent01.gif"><!-- 대리점명 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent02.gif"><!-- 주소 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent03.gif"><!-- 전화번호 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent04.gif"><!-- 팩스번호 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
          				
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">SUN MOON TOURS</td>
							<td align="left" class="tpad_3 lpad_10">Room402,4th FL., 153 Peninsula Plaza, Rajdamri Rd., Lumfini, Patumwan, Bangkok 10330, Thailand</td>
							<td>(662)2543320-8, 2547191-6</td>
							<td>(662)2543866, 2547195</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">DKC</td>
							<td align="left" class="tpad_3 lpad_10">731 PM Tower 22nd Asoke-Dindaeng Bangkok 10400</td>
							<td>(662)640-2246</td>
							<td>(662)640-2245</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

          				<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->					</td>
				</tr>
				</table></div>
				<div style='display:none;' id='nat_04'><table width="690" cellpadding="0" cellspacing="0" border="0"><tr><Td colspan="2">
					<a href="javascript:nation_01();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_01.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_01.gif'"></a>
					<a href="javascript:nation_02();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_02.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_02.gif'"></a>
					<a href="javascript:nation_03();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_03.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_03.gif'"></a>
					<a href="javascript:nation_04();"><img src="<%=imageServer%>/chn_img/apply/tab_nation_04on.gif" onMouseOver="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04on.gif'" onMouseOut="this.src='<%=imageServer%>/chn_img/apply/tab_nation_04on.gif'"></a>
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="140"><col width="250"><col width="110"><col width="110"><col width="70">
						<tr><td height="2" colspan="5" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/chn_img/apply/txt_agent01.gif"><!-- 대리점명 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent02.gif"><!-- 주소 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent03.gif"><!-- 전화번호 --></td>
							<td><img src="<%=imageServer%>/chn_img/apply/txt_agent04.gif"><!-- 팩스번호 --></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
          				
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr align="center">
							<td align="left" class="tpad_3 lpad_10">CP HOLIDAYS</td>
							<td align="left" class="tpad_3 lpad_10">Suite 795-6 Level 7 Manning Building 451 Pitt Street Sydney NSW 2000 Australia</td>
							<td>(02)9281-1399</td>
							<td>(02)9281-1870</td>
						</tr>
						<tr><td height="1" colspan="4" class="line_g2"></td></tr>

          				<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->					</td>
				</tr>
				</table></div></div>
				<!--  content / -->			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
</table></td></tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="/chn/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>