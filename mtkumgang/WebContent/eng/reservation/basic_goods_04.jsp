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
<script language="JavaScript" src="<%=imageServer%>/eng_img/inc/java.js"></script>
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
.style1 {color: #FFFFFF}
-->
</style>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/eng/include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="/eng/include/reservation/tour_reservation_left.jsp" %>
			<!--  left menu flash -->
			</td>
			<td><table width="710" cellpadding="0" cellspacing="0" border="0">
     <tr>
       <td class="lpad_20"><!--/ TITLE & LINEMAP -->
           <table width="690" cellpadding="0" cellspacing="0">
             <tr>
               <td height="54"><img src="<%=imageServer%>/eng_img/apply/tit_app24.gif"></td>
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
               <td><img src="<%=imageServer%>/eng_img/apply/top_txt_app24.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="8"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/eng_img/apply/img_basic04.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="29"><img src="<%=imageServer%>/eng_img/apply/txt_order01.gif" /></td>
               <td width="293" >Every day</td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/eng_img/apply/txt_order02.gif" /></td>
               <td ><strong>One-day</strong></td>
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
                     <td width="73" height="202" valign="top"><img src="<%=imageServer%>/eng_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:19px;">Have you ever imagined a trip to My. Kumgang for just a day? Mt. Kumgang one day package will help you to tour Mt. Kumgang in a day. Climb Kuryongyeon and experience the great scenery of Mt. Kumgang in the morning. Enjoy the foods grown from the soil and water of North Korea and return home with the memory of the beautiful sights of Samilpo Lake. You will realize you have gained another unforgettable memory.Bring home some of the specialties that Mt. Kumgang offer. Tell your family, friends and neighbors about memories and experiences that you had in Mt. Kumgang.</td>
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
               <td height="40"><img src="<%=imageServer%>/eng_img/apply/txt_order04.gif" /></td>
             <td ><span class="txt_orange b">120,000 won ~ 170,000 won </span><br>
               ※ Lunch and dinner are not included</td>
           </tr>
             <tr>
               <td class="line_dg" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="20" colspan="2">&nbsp;</td>
             </tr>
             <tr>
               <td colspan="2"  align="right"><a href="price/price_list.jsp"><img src="<%=imageServer%>/eng_img/btn/btn_detailprice.gif" border="0" class="btn" /></a></td>
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
                 <td height="25" valign="top"><img src="<%=imageServer%>/eng_img/apply/stit_app0302.gif" name="01"></td>
               </tr>
               <tr>
                 <td><img src="<%=imageServer%>/eng_img/apply/tab_date01_on.gif"><img src="<%=imageServer%>/eng_img/apply/tab_date003.gif"></td>
               </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / 표1 -->
                     <div id="dateview1" style="display:show;">
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" class="bg_white" height="26">Timeline</td>
                           <td width="50%" class="bg_white">Timeline</td>
                           <td width="30%" class="bg_white">Remarks</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">06:00</td>
                           <td class="bg_white lpad_20">Arrive at gathering point (Hwajinpo Asan Rest Area) </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:00</td>
                           <td class="bg_white lpad_20">Ticketing and departure from gathering point </td>
                           <td class="bg_white lpad_20">Receive tour pass</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:20</td>
                           <td class="bg_white lpad_20">Arrive at South Korean CIQ / departure procedure </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:15</td>
                           <td class="bg_white lpad_20">Arrive at North Korean CIQ / entry procedure</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="37">09:00 
                             ~ 13:30</td>
                           <td class="bg_white lpad_20">Kuryongyeon or Manmulsang course tour, lunch and free time</td>
                           <td class="bg_white lpad_20">Choose one</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00 
                             ~ 16:00</td>
                           <td class="bg_white lpad_20">*Hot Spring Spa/ *Samilpo Lake tour (if time allows)</td>
                           <td class="bg_white lpad_20">Hot Spring Spa for free</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00</td>
                           <td class="bg_white lpad_20">Depart from Onjeonggak</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:25</td>
                           <td class="bg_white lpad_20">Arrive at North Korean CIQ / departure procedure</td>
                           <td class="bg_white lpad_20">Cross the Military<br>
                             Demarcation Line</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:55</td>
                           <td class="bg_white lpad_20">Depart from North Korean CIQ</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:10</td>
                           <td class="bg_white lpad_20">Arrive at South Korean CIQ / entry procedure</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                 </td>
               </tr>
               <tr>
                 <td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ CIQ: Customs, Immigration, Quarantine <br>
                   ※ The schedule above is subject to change according to the circumstances at the destination point.<br>
                   ※ Optional tour (Charged): Acrobatic Show, Hot Spring Spa, North Korean Folk Music Show, Samilpo Lake Tour<br>
                   <span class="style1">.....</span>(Afternoon) </td>
               </tr>
             </table>
           <!-- 일정보기 / -->
         </td>
       </tr>
       <tr>
         <td colspan="2" height="12"></td>
       </tr>
       <tr>
         <td colspan="2"><img src="<%=imageServer%>/eng_img/apply/img_tip_order2.gif"></td>
       </tr>
     </table>
			  <!--------  center area /-------->   </td>
		</tr>
</table></td></tr>
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