<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
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

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
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
               <td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_app23.gif"></td>
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
               <td><img src="<%=imageServer%>/chn_img/apply/top_txt_app23.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="30"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/chn_img/apply/img_basic03.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order01.gif" /></td>
               <td width="293" >每天</td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order02.gif" /></td>
               <td ><strong>2天1宿</strong></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td width="97" height="33"><img src="<%=imageServer%>/chn_img/apply/txt_order05.gif" /></td>
               <td width="293" >11:00 (南部入出境事务所为准) </td>
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
                     <td width="69" height="141" valign="top"><img src="<%=imageServer%>/chn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:27px;">2天1宿是最佳游行日程，您是否对凌晨整装出发有一些负担？ <br>
                       是否心想要拖延出发时间？反映大家恳切的心愿，我们将提供2天1宿(11点出发)的旅游行程。有一句古言，观游金刚山也要填包肚子。刚好要进午餐的时刻到达金刚山，因此首先可以享受金刚山的美味佳食。第二天，您可以选择九龙渊旅游路线和万物相旅游路线中的一个路线，尽情享受美景。挑选哪一个旅游路线，您都会十二分得满足。 </td>
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
               <td ><span class="txt_orange b"></span>200,000韩元 ~ 350,000韩元<br>
                 ※午餐和晚餐要另付</td>
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
                 <td><%if(dateview.equals("1")){%><img src="<%=imageServer%>/chn_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/chn_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/chn_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/chn_img/apply/tab_date02.gif" ></a><%}%><img src="<%=imageServer%>/chn_img/apply/tab_date000.gif"></td>
               </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / 표1 -->
                     <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" height="26" class="bg_white style2">时间</td>
                           <td width="50%" class="bg_white style2">详细日程</td>
                           <td width="30%" class="bg_white style2">备注</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">09:30 </td>
                           <td class="bg_white lpad_20 style2">到达集合场所(花津浦峨山休息所) </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">10:10 </td>
                           <td class="bg_white lpad_20 style2">发证并出发集合场所</td>
                           <td class="bg_white lpad_20 style2">领取观光证 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">10:30 </td>
                           <td class="bg_white lpad_20 style2">到达南部入出境事务所并办理手续</td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">11:25 </td>
                           <td class="bg_white lpad_20 style2">到达北部入出境事务所并办理手续</td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">12:30 </td>
                           <td class="bg_white lpad_20 style2">午餐及购物</td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00</td>
                           <td class="bg_white lpad_20 style2">三日浦旅游路线观光</td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 16:30</td>
                           <td class="bg_white lpad_20 style2">观看杂技演出</td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 18:00~</td>
                           <td class="bg_white lpad_20 style2">晚餐及自由时间</td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                     <!-- / 표2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td class="bg_white" height="26">时间</td>
                           <td class="bg_white">详细日程</td>
                           <td class="bg_white">备注</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">07:00 </td>
                           <td width="50%" class="bg_white lpad_20">早餐 </td>
                           <td width="30%" class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:00~12:30 </td>
                           <td class="bg_white lpad_20 style2">九龙渊、万物相旅游线路观光</td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00~15:00 </td>
                           <td class="bg_white lpad_20 style2">午餐及购物 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:55 </td>
                           <td class="bg_white lpad_20 style2">出发温井阁 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:10 </td>
                           <td class="bg_white lpad_20 style2">到达北部入出境事务所并办理手续</td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:10</td>
                           <td class="bg_white lpad_20 style2">到达南部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표2 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10"><span class="style2">※ 以上日程根据当地情况，可会有所变化。<a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print01.jsp','','scrollbars=yes,width=702,height=600')"></a></span></td>
               </tr>
             </table>
           <!-- 일정보기 / -->
         </td>
       </tr>
       <tr>
         <td colspan="2" height="12"></td>
       </tr>
       <tr>
         <td colspan="2"><img src="<%=imageServer%>/chn_img/apply/img_tip_order.gif"></td>
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