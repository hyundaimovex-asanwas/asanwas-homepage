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
			<!--  left menu flash -->			</td>
			<td><table width="710" cellpadding="0" cellspacing="0" border="0">
     <tr>
       <td class="lpad_20"><!--/ TITLE & LINEMAP -->
           <table width="690" cellpadding="0" cellspacing="0">
             <tr>
               <td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_app211.gif"></td>
             </tr>
           </table>
         <!-- TITLE & LINEMAP/ -->       </td>
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
               <td><img src="<%=imageServer%>/chn_img/apply/top_txt_app211.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="30"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/chn_img/apply/img_basic01_1.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="50"><img src="<%=imageServer%>/chn_img/apply/txt_order01.gif" /></td>
               <td width="293" >每天(有人员限制，要通过金刚山观光代理处预约，不提供网上预约服务) </td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/chn_img/apply/txt_order02.gif" /></td>
               <td ><span class="style2"><strong>3天2宿</strong></span></td>
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
                     <td width="69" height="215" valign="top"><img src="<%=imageServer%>/chn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:27px;"><p class="style2">金刚山一般分为内金刚和外金刚，面向内陆的西侧称为内金刚，而面向大海的东侧称为外金刚。 </p>
                       <p class="style2">观游九龙渊、万物相、三日浦/海金刚等外金刚代表性的旅游路线，感受雄壮的男性自然美。内金刚溪谷中的众多水源形成各种瀑布，以此可以感受到温和的女性美。 另外，内金刚的表训寺、三佛岩、妙吉祥等众多文化遗迹，将让您迷入历史之中。 </p>
                       </td>
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
               <td ><p class="style2"><span class="txt_orange b "></span>280,000 ~ 520,000韩元 <br>
   ※午餐和晚餐要另付 </p>                 </td>
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
                           <td height="26" class="bg_white style1 style2">时间 </td>
                           <td class="bg_white style1 style2">详细日程 </td>
                           <td class="bg_white style1 style2">备注 </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white ">13:00 </td>
                           <td width="50%" class="bg_white lpad_20 style2">到达集合场所(花津浦峨山休息所) </td>
                           <td width="30%" class="bg_white lpad_20 style2">领取观光证</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">13:30 </td>
                           <td class="bg_white lpad_20 style2">出发集合场所 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">14:10</td>
                           <td class="bg_white lpad_20 style2">到达南部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">15:20 </td>
                           <td class="bg_white lpad_20 style2">出发南部入出境事务所 </td>
                           <td class="bg_white lpad_20 style2"> 领取观光证</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">15:35 </td>
                           <td class="bg_white lpad_20 style2">到达北部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">16:00</td>
                           <td class="bg_white lpad_20 style2">出发北部入出境事务所 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">16:30</td>
                           <td class="bg_white lpad_20 style2">观看杂技演出 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">18:00</td>
                           <td class="bg_white lpad_20 style2">到达宿舍办理登记手续 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">   18:20</td>
                           <td class="bg_white lpad_20 style2">晚餐及自由时间(温泉/金刚山观光特区旅游服务) </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ1 / -->
                     <!-- / ǥ2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1 style2">时间 </td>
                           <td class="bg_white style1 style2">详细日程 </td>
                           <td class="bg_white style1 style2">备注 </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white ">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style2">早餐</td>
                           <td width="30%" class="bg_white lpad_20 style2">各宿舍 </td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white "> 08:00~13:30</td>
                           <td class="bg_white lpad_20 style2">内金刚观光 - 表训寺、万瀑洞、妙吉祥、普德庵 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">13:30~14:30 </td>
                           <td class="bg_white lpad_20 style2"> 午餐 (表训寺附近) </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">14:30~16:00</td>
                           <td class="bg_white lpad_20 style2">内金刚观光 – 白华庵浮图、三佛岩、鸣渊、长安寺址 – 步行 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">16:00~18:00</td>
                           <td class="bg_white lpad_20 style2">移到温井阁 </td>
                           <td class="bg_white lpad_20 style2">&nbsp;</td>
                         </tr>
                         <tr>
                           <td height="27" align="center" class="bg_white ">18:00~</td>
                           <td class="bg_white lpad_20 style2">晚餐及自由时间 (温泉及购物) </td>
                           <td class="bg_white lpad_20 style2">购食</td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">(21:00~22:00)</td>
                           <td class="bg_white lpad_20 style2">观看歌舞剧 (金刚山宾馆) </td>
                           <td class="bg_white lpad_20 style2">选择性观光 (定员130名)</td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ2 / -->
                     <!-- / ǥ3 -->
                     <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1 style2">时间 </td>
                           <td class="bg_white style1 style2">详细日程 </td>
                           <td class="bg_white style1 style2">备注 </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white ">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style2">早餐</td>
                           <td width="30%" class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">08:00</td>
                           <td class="bg_white lpad_20 style2">九龙苑、万物相或三日浦/海金刚旅游线路观光 </td>
                           <td class="bg_white lpad_20 style2">选择性观光 </td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">11:30</td>
                           <td class="bg_white lpad_20 style2">午餐及购物 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">13:00</td>
                           <td class="bg_white lpad_20 style2">出发温井阁 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">13:15</td>
                           <td class="bg_white lpad_20 style2">到达北部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">13:45</td>
                           <td class="bg_white lpad_20 style2">到达北部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2">通过军事分界线 </td>
                         </tr>
                         <tr>
                           <td height="26" align="center" class="bg_white ">14:00</td>
                           <td class="bg_white lpad_20 style2">到达南部入出境事务所并办理手续 </td>
                           <td class="bg_white lpad_20 style2"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ3 / -->                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10 style2"> ※ 以上日程根据当地情况，可会有所变化。 </td>
               </tr>
             </table>
           <!--  / -->         </td>
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
		<!-- footer /-->	</td>
</tr>
</table>
</body>
</html>