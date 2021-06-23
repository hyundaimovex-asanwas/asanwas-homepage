<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<% 
  String McNum = "2";
  String sub = "2";
  String pageNum = "2";
  String subNum = "1";
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
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

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
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
               <td height="54"><img src="<%=imageServer%>/eng_img/apply/tit_app21.gif"></td>
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
               <td><img src="<%=imageServer%>/eng_img/apply/top_txt_app21.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="30"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/tour_img/apply/img_basic01.jpg" width="269" height="308"></td>
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
               <td ><strong>2 nights 3 days </strong></td>
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
                     <td valign="top" style="padding-left:19px;">You have probably been looking forward to Mt. Kumgang tour. If you’d like to fully enjoy it with a enough amount of time, we strongly recommend you to choose the 2 night 3 day package.From Kuryongyeon to Manmulsang, and from Samilpo  to Haekumgang! You will be able to tour every course and also experience the specialty foods and amusements only available at Mt. Kumgang without being pressed for time. If you choose this package, you will be accompanied by experienced tour guides from your arrival to departure to ensure your utmost comfort and enjoyment.</td>
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
               <td ><span class="txt_orange b">※ Approximately 290,000 won ~ 580,000 won </span><br>
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
                      <td colspan="2"><%if(dateview.equals("1")){%><img src="<%=imageServer%>/eng_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/eng_img/apply/tab_date01.gif" border="0" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/eng_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/eng_img/apply/tab_date02.gif" border="0" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/eng_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/eng_img/apply/tab_date03.gif" border="0" ></a><%}%><img src="<%=imageServer%>/eng_img/apply/tab_date00.gif"></td>
                    </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / 표1 -->
                     <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" class="bg_white" height="26">Timeline</td>
                           <td width="50%" class="bg_white">Schedule Description</td>
                           <td width="30%" class="bg_white">Remarks </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">12:00 </td>
                           <td class="bg_white lpad_20">Arrive at gathering point (Hwajinpo Asan Rest Area)</td>
                           <td class="bg_white lpad_20">Receive tour pass</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">12:10 </td>
                           <td class="bg_white lpad_20">Depart from gathering point </td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:10 </td>
                           <td class="bg_white lpad_20">Arrive at South Korean CIQ / departure formalities</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:15 </td>
                           <td class="bg_white lpad_20">Depart from South Korean CIQ</td>
                           <td class="bg_white lpad_20"> Cross the Military  Demarcation Line </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00 </td>
                           <td class="bg_white lpad_20">Depart from North Korean CIQ</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30</td>
                           <td class="bg_white lpad_20">Hotel Check-in. </td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="35">18:00 ~</td>
                           <td class="bg_white lpad_20">Dinner and free time<br>
                             (Mt. Kumgang Special Zone tour/  *Hot Spring Spa)</td>
                           <td class="bg_white lpad_20">Optional</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                     <!-- / 표2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" class="bg_white lpad_20" height="26"><span class="bg_white">Timeline</span></td>
                           <td width="50%" class="bg_white lpad_20"><span class="bg_white">Schedule Description</span></td>
                           <td width="30%" class="bg_white lpad_20"><span class="bg_white">Remarks</span></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">06:30</td>
                           <td class="bg_white lpad_20">Breakfast</td>
                           <td class="bg_white lpad_20">At accommodations </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 08:20~14:30 </td>
                           <td class="bg_white lpad_20">Kuryongyeon tour and lunch </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00~16:00 </td>
                           <td class="bg_white lpad_20">*Samilpo Lake tour, *Hot Spring Spa or Shopping</td>
                           <td class="bg_white lpad_20">Optional / Free time</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30 </td>
                           <td class="bg_white lpad_20">*Acrobatic Show (Cultural Center)</td>
                           <td class="bg_white lpad_20">Optional </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">18:00 </td>
                           <td class="bg_white lpad_20">Dinner and free time (*Hot Spring Spa or shopping)</td>
                           <td class="bg_white lpad_20">Dinner is not included</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">21:00</td>
                           <td class="bg_white lpad_20">*North Korean Folk Music Show (Hotel Kumgangsan) </td>
                           <td class="bg_white lpad_20">Optional </td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표2 / -->
                     <!-- / 표3 -->
                     <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" class="bg_white lpad_20" height="26"><span class="bg_white">Timeline</span></td>
                           <td width="50%" class="bg_white lpad_20"><span class="bg_white">Schedule Description</span></td>
                           <td width="30%" class="bg_white lpad_20"><span class="bg_white">Remarks</span></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">06:30</td>
                           <td class="bg_white lpad_20">Breakfast</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:00</td>
                           <td class="bg_white lpad_20">Manmulsang or Samilpo Lake / Haekumgang Seashore tour</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">11:30</td>
                           <td class="bg_white lpad_20">Lunch and shopping</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00</td>
                           <td class="bg_white lpad_20">Depart from Onjeonggak</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:15</td>
                           <td class="bg_white lpad_20">Arrive at North Korean CIQ / departure procedure</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:45</td>
                           <td class="bg_white lpad_20">Depart from North Korean CIQ</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00</td>
                           <td class="bg_white lpad_20">Arrive at South Korean CIQ/ entry procedure</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표3 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10">※ CIQ: Customs, Immigration, Quarantine<br>
                   ※ The schedule above is subject to change according to the circumstances at the destination point. <br>
                   ※ * Optional tour (Charged): Acrobatic Show, Hot Spring Spa, North Korean Folk Music Show, Samilpo Lake Tour  (Afternoon) <a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print01.jsp','','scrollbars=yes,width=702,height=600')"></a></td>
               </tr>
             </table>
           <!-- 일정보기 / -->
         </td>
       </tr>
       <tr>
         <td colspan="2" height="12"></td>
       </tr>
       <tr>
         <td colspan="2"><img src="<%=imageServer%>/eng_img/apply/img_tip_order.gif"></td>
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