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
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>

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
        <%@ include file="/jpn/include/reservation/tour_reservation_top_utf8.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="/jpn/include/reservation/tour_reservation_left_utf8.jsp" %>
			<!--  left menu flash -->
			</td>
			<td><table width="710" cellpadding="0" cellspacing="0" border="0">
     <tr>
       <td class="lpad_20"><!--/ TITLE & LINEMAP -->
           <table width="690" cellpadding="0" cellspacing="0">
             <tr>
               <td height="54"><img src="<%=imageServer%>/jpn_img/apply/tit_app211.gif"></td>
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
               <td><img src="<%=imageServer%>/jpn_img/apply/top_txt_app211.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="30"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/jpn_img/apply/img_basic01_1.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="50"><img src="<%=imageServer%>/jpn_img/apply/txt_order01.gif" /></td>
               <td width="293" >毎日(人員制限があるため金剛山観光代理店を通じて予約,オンライン予約不可)
</td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/jpn_img/apply/txt_order02.gif" /></td>
               <td ><strong>二泊三日</strong></td>
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
                     <td width="73" height="215" valign="top"><img src="<%=imageServer%>/jpn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:19px;">金剛山は内金剛と外金剛で分けられますが内陸へ向かってる西側を内金剛,海へ向かってる東側を外金剛とよんでいます. 外金剛の代表コースである九龍淵,萬物相,三日浦/海金剛をまわって見ると男性的で雄壮な 自然美を感じ,内金剛はいくつに分かれる渓谷の水の流れが作り上げたたくさんの滝と池をはじめ温和な女性美を経験することができます. また内金剛のピョフン寺, 三佛巖 , 妙吉祥 など多くの文化遺跡が皆様を歴史の世界へ招待する事になるでしょう.
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
               <td height="40"><img src="<%=imageServer%>/jpn_img/apply/txt_order04.gif" /></td>
               <td ><span class="txt_orange b">※ 280,000 ~ 520,000WON  </span><br>
                 ※ 昼夕食は別途　毎食</td>
             </tr>
             <tr>
               <td class="line_dg" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="20" colspan="2">&nbsp;</td>
             </tr>
             <tr>
               <td colspan="2"  align="right"><a href="price/price_list.jsp"><img src="<%=imageServer%>/jpn_img/btn/btn_detailprice.gif" border="0" class="btn" /></a></td>
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
                 <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_app0302.gif" name="01"></td>
               </tr>
                    <tr> 
                      <td colspan="2"><%if(dateview.equals("1")){%><img src="<%=imageServer%>/jpn_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/jpn_img/apply/tab_date01.gif" border="0" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/jpn_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/jpn_img/apply/tab_date02.gif" border="0" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/jpn_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/jpn_img/apply/tab_date03.gif" border="0" ></a><%}%><img src="<%=imageServer%>/jpn_img/apply/tab_date00.gif"></td>
                    </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / 표1 -->
                     <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td width="20%" class="bg_white" height="26">時間</td>
                           <td width="50%" class="bg_white">詳細日程
</td>
                           <td width="30%" class="bg_white">備考 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00 </td>
                           <td class="bg_white lpad_20">集結地花津浦・牙山 (ファジンポ　アサン）休憩所へ到着</td>
                           <td class="bg_white lpad_20">観光カード受領</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:30 </td>
                           <td class="bg_white lpad_20">集結地出発</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:10</td>
                           <td class="bg_white lpad_20">南側出入事務所到着/手続き</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:20 </td>
                           <td class="bg_white lpad_20">南側出入事務所出発</td>
                           <td class="bg_white lpad_20">軍事分界線通過</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:35 </td>
                           <td class="bg_white lpad_20">北側出入事務所到着/手続き </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00</td>
                           <td class="bg_white lpad_20">北側出入事務所出発
</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30</td>
                           <td class="bg_white lpad_20">功藝公演観覧
</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">18:00</td>
                           <td class="bg_white lpad_20">宿へ到着/ チェックイン </td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="35">   18:20</td>
                           <td class="bg_white lpad_20">夕食及び自由時間(温泉/金剛山観光特別区域ツアー)
</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                     <!-- / 표2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td class="bg_white" height="26">時間</td>
                           <td class="bg_white">詳細日程 </td>
                           <td class="bg_white">備考 </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20">朝食</td>
                           <td width="30%" class="bg_white lpad_20">各自宿所</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="35"> 08:00~13:30</td>
                           <td class="bg_white lpad_20">内金剛観光 – ピョフン寺, 萬瀑洞 妙吉祥 , 普德庵 </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:30~14:30 </td>
                           <td class="bg_white lpad_20">昼食 (ピョフン寺近辺)
</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="35">14:30~16:00</td>
                           <td class="bg_white lpad_20">内金剛観光 – ペクファ岩ブド, 三佛巖 , ウルソ, ジャンアンサト徒歩観光
</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00~18:00</td>
                           <td class="bg_white lpad_20">オンジョンカクへ移動</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">18:00~</td>
                           <td class="bg_white lpad_20">夕食及び自由時間 (温泉及びショッピング)
</td>
                           <td class="bg_white lpad_20">毎食
</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">(21:00~22:00)</td>
                           <td class="bg_white lpad_20">歌舞劇観覧 (金剛山ホテル)
</td>
                           <td class="bg_white lpad_20">選択観光 (定員130名)
</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표2 / -->
                     <!-- / 표3 -->
                     <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td class="bg_white" height="26">時間</td>
                           <td class="bg_white">詳細日程 </td>
                           <td class="bg_white">備考 </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20">朝食
</td>
                           <td width="30%" class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:00</td>
                           <td class="bg_white lpad_20">九龍淵,萬物相または三日浦/海金剛コース観光</td>
                           <td class="bg_white lpad_20">選択観光
</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">11:30</td>
                           <td class="bg_white lpad_20">昼食及びショッピング
</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00</td>
                           <td class="bg_white lpad_20">オンジョンカク出発</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:15</td>
                           <td class="bg_white lpad_20">北側出入事務所到着 / 手続き</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="35">13:45</td>
                           <td class="bg_white lpad_20">北側出入事務所出発</td>
                           <td class="bg_white lpad_20">軍事分界線通過</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00</td>
                           <td class="bg_white lpad_20">南側出入事務所到着及び手続き</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표3 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 上記日程は現地事情により変更される事もあります.
<a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print01.jsp','','scrollbars=yes,width=702,height=600')"></a></td>
               </tr>
             </table>
           <!-- 일정보기 / -->
         </td>
       </tr>
       <tr>
         <td colspan="2" height="12"></td>
       </tr>
       <tr>
         <td colspan="2"><img src="<%=imageServer%>/jpn_img/apply/img_tip_order.gif"></td>
       </tr>
     </table>
			  <!--------  center area /-------->   </td>
		</tr>
		</table></td></tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="/jpn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>