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
/*  High-peak season/ Peak season/ Low season/ ̾  */
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
.style1 {font-family: SimHei}
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
               <td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_app21.gif"></td>
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
               <td><img src="<%=imageServer%>/chn_img/apply/top_txt_app21.gif" style="margin-top:12px;"></td>
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
               <td width="97" height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order01.gif" /></td>
               <td width="293" >每天</td>
             </tr>
             <tr>
               <td height="1" colspan="3" class="line_g2 style1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order02.gif" /></td>
               <td ><span class="style1"><strong>3天2宿</strong></span></td>
             </tr>
             <tr>
               <td height="1" colspan="3" class="line_g2 style1"></td>
             </tr>
             <tr>
               <td height="7" colspan="2"><span class="style1"></span></td>
             </tr>
             <tr>
               <td colspan="2"><table width="390" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td width="69" height="118" valign="top" class="style1"><img src="<%=imageServer%>/chn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF" class="style1"></td>
                     <td width="319" valign="top" class="style1" style="padding-left:27px;"><p>盼望已久的金刚山旅游。如果您要享受满游，推荐给您3天2宿的旅游行程。</p>
                       <p>九龙渊到万物相，三日浦到海金刚！您可以观游所有旅游景点，还可以品尝各种风味饮食并欣赏各种演出，您将不会感到他乡的陌生感。经验丰富的领队始终带领大家观游最具代表性的“3天2宿”金刚山旅游行程。 </p></td>
                   </tr>
               </table></td>
             </tr>
             <tr>
               <td height="7" colspan="2"><span class="style1"></span></td>
             </tr>
             <tr>
               <td height="1" colspan="3" class="line_g2 style1"></td>
             </tr
       >
             <tr>
               <td height="40"><img src="<%=imageServer%>/chn_img/apply/txt_order04.gif" /></td>
               <td ><span class="txt_orange b style1 style1">约290,000韩元 ~ 约580,000韩元</span><span class="txt_orange b style1 style1"></span><span class="style1"><br>
   ※午餐和晚餐要另付 </span></td>
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
         <td colspan="2"><!-- /  -->
             <table width="690" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td height="25" valign="top"><img src="<%=imageServer%>/chn_img/apply/stit_app0302.gif" name="01"></td>
               </tr>
                    <tr> 
                      <td colspan="2"><%if(dateview.equals("1")){%><img src="<%=imageServer%>/chn_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/chn_img/apply/tab_date01.gif" border="0" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/chn_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/chn_img/apply/tab_date02.gif" border="0" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/chn_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/chn_img/apply/tab_date03.gif" border="0" ></a><%}%><img src="<%=imageServer%>/chn_img/apply/tab_date00.gif"></td>
                    </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / ǥ1 -->
                     <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" height="26" class="bg_white style1">时间</td>
                           <td width="50%" class="bg_white style1">详细日程</td>
                           <td width="30%" class="bg_white style1">备注 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00 </td>
                           <td class="bg_white lpad_20 style1">到达集合场所(花津浦峨山休息所)</td>
                           <td class="bg_white lpad_20 style1">领取观光证 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:30 </td>
                           <td class="bg_white lpad_20 style1">出发集合场所 </td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:10</td>
                           <td class="bg_white lpad_20 style1">到达南部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:20 </td>
                           <td class="bg_white lpad_20 style1">出发南部入出境事务所</td>
                           <td class="bg_white lpad_20 style1"> 通过军事分界线 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:35</td>
                           <td class="bg_white lpad_20 style1">到达北部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00</td>
                           <td class="bg_white lpad_20 style1">出发北部入出境事务所</td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30</td>
                           <td class="bg_white lpad_20 style1">到达宿舍办理登记手续 </td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:00 ~</td>
                           <td class="bg_white lpad_20 style1">晚餐及自由时间(金刚山观光特区旅游服务/温泉)</td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ1 / -->
                     <!-- / ǥ2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">时间</td>
                           <td class="bg_white style1">详细日程</td>
                           <td class="bg_white style1">备注</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style1">早餐</td>
                           <td width="30%" class="bg_white lpad_20 style1">各宿舍 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 08:20~14:30 </td>
                           <td class="bg_white lpad_20 style1">九龙渊旅游线路观光及午餐 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00~16:00 </td>
                           <td class="bg_white lpad_20 style1">三日浦旅游线路观光(付费)或温泉及购物 </td>
                           <td class="bg_white lpad_20 style1">选择性观光</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30 </td>
                           <td class="bg_white lpad_20 style1">观看杂技演出 </td>
                           <td class="bg_white lpad_20 style1">文化会馆</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">18:00 </td>
                           <td class="bg_white lpad_20 style1">晚餐及自由时间 (温泉及购物) </td>
                           <td class="bg_white lpad_20 style1">购食 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">(21:00)</td>
                           <td class="bg_white lpad_20 style1">观看歌舞剧(金刚山宾馆) </td>
                           <td class="bg_white lpad_20 style1">选择性观光 (定员130名) </td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ2 / -->
                     <!-- / ǥ3 -->
                     <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">时间</td>
                           <td class="bg_white style1">详细日程</td>
                           <td class="bg_white style1">备注</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style1">早餐 </td>
                           <td width="30%" class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:00</td>
                           <td class="bg_white lpad_20 style1">万物相或三日浦/海金刚旅游线路观光 </td>
                           <td class="bg_white lpad_20 style1">选择性观光 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">11:30</td>
                           <td class="bg_white lpad_20 style1">午餐及购物 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00</td>
                           <td class="bg_white lpad_20 style1">出发温井阁 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:15</td>
                           <td class="bg_white lpad_20 style1">到达北部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:45</td>
                           <td class="bg_white lpad_20 style1">出发北部入出境事务所 </td>
                           <td class="bg_white lpad_20 style1">通过军事分界线 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00</td>
                           <td class="bg_white lpad_20 style1">到达南部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ3 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10"><span class="style1">※ 以上日程根据当地情况，可会有所变化。 </span></td>
               </tr>
             </table>
           <!--  / -->
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