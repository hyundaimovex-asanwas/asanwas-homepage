<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
<%
String pageNum = "1";
String subNum = "1";
String McNum = "2";
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

<style type="text/css">
<!--
.style2 {font-family: SimHei}
-->
</style>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/reservation/tour_reservation_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="/chn/include/reservation/tour_reservation_left_utf8.jsp" %>
			<!--  left menu flash -->
			</td>
			<td><table width="710" cellpadding="0" cellspacing="0" border="0">
     <tr>
       <td class="lpad_20"><!--/ TITLE & LINEMAP -->
           <table width="690" cellpadding="0" cellspacing="0">
             <tr>
               <td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_app24.gif"></td>
             </tr>
           </table>
         <!-- TITLE & LINEMAP/ -->
       </td>
     </tr>
     <tr>
       <td height="1" class="line_g"></td>
     </tr>
   </table>
			  <table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
       <tr>
         <td colspan="2" height="22"></td>
       </tr>
       <tr>
         <td colspan="2"><table width="690" cellpadding="0" cellspacing="0" border="0">
             <tr valign="top">
               <td><img src="<%=imageServer%>/chn_img/apply/top_txt_app24.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="8"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/chn_img/apply/img_basic04.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order01.gif" /></td>
               <td width="293" ><span class="style2">每天</span></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order02.gif" /></td>
               <td ><span class="style2"><strong>?天</strong></span></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="7" colspan="2"></td>
             </tr>
             <tr>
               <td colspan="2"><table width="390" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td width="69" height="171" valign="top"><img src="<%=imageServer%>/chn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:27px;"><p class="style2">?有?有想象?，金?山一日游？ ?是短?的一天??，但?可以充分感受到金?山的情趣。</p>
                       <p class="style2">早晨攀登九??，可以吸引金?山的??。在北部的泥土中生?的食物??包?子后，??三日浦?雅景色，?是又一??忘的回?。<br>
                         旅行中??的北部土特?金?山?念品，?是金?山游?的?傲。</p></td>
                   </tr>
               </table></td>
             </tr>
             <tr>
               <td height="7" colspan="2"></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr
       >
           <tr>
               <td height="40"><img src="<%=imageServer%>/chn_img/apply/txt_order04.gif" /></td>
             <td ><span class="txt_orange b style2">120,000?元 ~ 170,000?元</span><span class="style2"><br>
               ※ 午餐和?餐要?付</span></td>
           </tr>
             <tr>
               <td class="line_dg" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="20" colspan="2">&nbsp;</td>
             </tr>
             <tr>
               <td colspan="2"  align="right"><a href="price/price_list.jsp"><img src="<%=imageServer%>/chn_img/btn/btn_detailprice.gif" border="0" class="btn" /></a></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="14"></td>
       </tr>
       <tr>
         <td colspan="2"><!-- / 일정보기 -->
             <table width="690" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td height="25" valign="top"><img src="<%=imageServer%>/chn_img/apply/stit_app0302.gif" name="01"></td>
               </tr>
               <tr>
                 <td><img src="<%=imageServer%>/chn_img/apply/tab_date01_on.gif"><img src="<%=imageServer%>/chn_img/apply/tab_date003.gif"></td>
               </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / 표1 -->
                     <div id="dateview1" style="display:show;">
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style2">??</td>
                           <td class="bg_white style2">??日程</td>
                           <td class="bg_white style2">?注</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:00</td>
                           <td width="50%" class="bg_white lpad_20 style2">到?集合?所(花津浦峨山休息所)</td>
                           <td width="30%" class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:00</td>
                           <td class="bg_white lpad_20 style2">???出?集合?所</td>
                           <td class="bg_white lpad_20 style2">?取?光?</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:20</td>
                           <td class="bg_white lpad_20 style2">到?南部入出境事?所??理手?</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:15</td>
                           <td class="bg_white lpad_20 style2">到?北部入出境事?所??理手?</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">09:00 
                             ~ 13:30</td>
                           <td class="bg_white lpad_20 style2">九??、万物相旅游?路?光，午餐及自由??</td>
                           <td class="bg_white lpad_20 style2">??</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00 
                             ~ 16:00</td>
                           <td class="bg_white lpad_20 style2">?泉或三日浦(三日浦?付，根据情?可?有所?化)</td>
                           <td class="bg_white lpad_20 style2">?泉免?</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00</td>
                           <td class="bg_white lpad_20 style2">出??井?</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:25</td>
                           <td class="bg_white lpad_20 style2">到?北部入出境事?所??理手? </td>
                           <td class="bg_white lpad_20 style2">通??事分界?</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:55</td>
                           <td class="bg_white lpad_20 style2">出?北部入出境事?所</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:10</td>
                           <td class="bg_white lpad_20 style2">到?南部入出境事?所??理手?</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                 </td>
               </tr>
               <tr>
                 <td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10 style2">※ 以上日程根据?地情?，可?有所?化。</td>
               </tr>
             </table>
           <!-- 일정보기 / -->
         </td>
       </tr>
       <tr>
         <td colspan="2" height="12"></td>
       </tr>
       <tr>
         <td colspan="2"><img src="<%=imageServer%>/chn_img/apply/img_tip_order2.gif"></td>
       </tr>
     </table>
			  <!--------  center area /-------->   </td>
		</tr>
</table></td></tr>
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