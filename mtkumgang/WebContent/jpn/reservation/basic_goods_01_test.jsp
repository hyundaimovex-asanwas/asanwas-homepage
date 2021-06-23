<%@ page language="java" contentType="text/html; charset=utf-8"%> 
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
/*  High-peak season/ Peak season/ Low season/ 占쏙옙占싱억옙 占쏙옙占쏙옙占쏙옙 */
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
        <%@ include file="/jpn/include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="/jpn/include/reservation/tour_reservation_left.jsp" %>
			<!--  left menu flash -->
			</td>
			<td><table width="710" cellpadding="0" cellspacing="0" border="0">
     <tr>
       <td class="lpad_20"><!--/ TITLE & LINEMAP -->
           <table width="690" cellpadding="0" cellspacing="0">
             <tr>
               <td height="54"><img src="<%=imageServer%>/jpn_img/apply/tit_app21.gif"></td>
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
               <td><img src="<%=imageServer%>/jpn_img/apply/top_txt_app21.gif" style="margin-top:12px;"></td>
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
               <td width="97" height="29"><img src="<%=imageServer%>/jpn_img/apply/txt_order01.gif" /></td>
               <td width="293" ><span class="style1">占쏙옙占�</span></td>
             </tr>
             <tr>
               <td height="1" colspan="3" class="line_g2 style1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/jpn_img/apply/txt_order02.gif" /></td>
               <td ><span class="style1"><strong>3占�占쏙옙</strong></span></td>
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
                     <td width="69" height="118" valign="top" class="style1"><img src="<%=imageServer%>/jpn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF" class="style1"></td>
                     <td width="319" valign="top" class="style1" style="padding-left:27px;"><p>占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占�山占쏙옙占쏙옙占쏙옙占쏙옙?占쏙옙占쏙옙?占쏙옙占쏙옙???3占�占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙煎�/p>
                       <p>占쏙옙??占쏙옙万物占쌈ｏ옙三占쏙옙占쏙옙占쏙옙占쏙옙占�占쏙옙?可占�占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙찾占�可占쏙옙?占쏙옙??味?占쏙옙?占쏙옙?占쏙옙?占쏙옙占쏙옙??占쏙옙?占쏙옙占쏙옙占쏙옙?占쏙옙占쏙옙占쏙옙占쏙。???富占쏙옙??占�??占쏙옙家?占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙占쌤∽옙3占�占쌍∽옙占쏙옙?山占쏙옙占쏙옙占쏙옙煎�</p></td>
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
               <td height="40"><img src="<%=imageServer%>/jpn_img/apply/txt_order04.gif" /></td>
               <td ><span class="txt_orange b style1 style1">?290,000?占�</span><span class="txt_orange b  style1">~</span><span class="txt_orange b style1 style1"> ?580,000?占�/span><span class="style1"><br>
  占쏙옙 占쏙옙占쏙옙占쏙옙?占쏙옙占�占쏙옙</span></td>
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
         <td colspan="2"><!-- / 占쏙옙d占쏙옙占쏙옙 -->
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
                           <td width="20%" height="26" class="bg_white style1">??</td>
                           <td width="50%" class="bg_white style1">??占쏙옙占쏙옙</td>
                           <td width="30%" class="bg_white style1">?占�</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00 </td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙占�占�占쏙옙占쏙옙占쏙옙山占쏙옙占쏙옙占� </td>
                           <td class="bg_white lpad_20 style1">?占�占쏙옙? </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:30 </td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙占�占�/td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:10</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�?占쏙옙占�</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:20 </td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�/td>
                           <td class="bg_white lpad_20 style1"> 占쏙옙??占쏙옙占쏙옙界?</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:35</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�?占쏙옙占�</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:00</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�/td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙占쏙옙?占쏙옙占쏙옙?占�</td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:00 ~</td>
                           <td class="bg_white lpad_20 style1">?占쏙옙占쏙옙占쏙옙??(占쏙옙?山?占쏙옙占쏙옙?占쏙옙占쏙옙占쏙옙?/?占�</td>
                           <td class="bg_white lpad_20 style1">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표1 / -->
                     <!-- / 표2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">??</td>
                           <td class="bg_white style1">??占쏙옙占쏙옙</td>
                           <td class="bg_white style1">?占�</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style1">占쏙옙占쏙옙</td>
                           <td width="30%" class="bg_white lpad_20 style1">占쏙옙占쏙옙占쏙옙 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 08:20~14:30 </td>
                           <td class="bg_white lpad_20 style1">占쏙옙??占쏙옙占쏙옙?占쏙옙?占쏙옙占쏙옙占쏙옙占쏙옙</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00~16:00 </td>
                           <td class="bg_white lpad_20 style1">三占쏙옙占쏙옙占쏙옙占쏙옙?占쏙옙?占쏙옙(占쏙옙?)占쏙옙?占쏙옙占�物 </td>
                           <td class="bg_white lpad_20 style1">??占쏙옙?占쏙옙</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30 </td>
                           <td class="bg_white lpad_20 style1">?占쏙옙?占쏙옙占쏙옙占쏙옙</td>
                           <td class="bg_white lpad_20 style1">占쏙옙占쏙옙?? </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">18:00 </td>
                           <td class="bg_white lpad_20 style1">?占쏙옙占쏙옙占쏙옙??(?占쏙옙占�物) </td>
                           <td class="bg_white lpad_20 style1">?占쏙옙</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">(21:00)</td>
                           <td class="bg_white lpad_20 style1">?占쏙옙歌占쏙옙?(占쏙옙?山??) </td>
                           <td class="bg_white lpad_20 style1">??占쏙옙?占쏙옙(占쏙옙?130名) </td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표2 / -->
                     <!-- / 표3 -->
                     <div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">??</td>
                           <td class="bg_white style1">??占쏙옙占쏙옙</td>
                           <td class="bg_white style1">?占�</td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:30</td>
                           <td width="50%" class="bg_white lpad_20 style1">占쏙옙占쏙옙</td>
                           <td width="30%" class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:00</td>
                           <td class="bg_white lpad_20 style1">万物占쏙옙占쏙옙三占쏙옙占쏙옙/占쏙옙占�占쏙옙占쏙옙?占쏙옙?占쏙옙</td>
                           <td class="bg_white lpad_20 style1">??占쏙옙?占쏙옙 </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">11:30</td>
                           <td class="bg_white lpad_20 style1">占쏙옙占쏙옙占쏙옙?物</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:00</td>
                           <td class="bg_white lpad_20 style1">占쏙옙??占쏙옙?</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:15</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�?占쏙옙占�</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:45</td>
                           <td class="bg_white lpad_20 style1">占쏙옙���掠긱�������鸚������������얇�����멥�����ｃ�����담������役룔�����ｃ�����담�鸚���������㎯��얇�. 鸚�����餓ｈ〃�녈��밤����阿��曆��х���訝��役�役룬�����얇��ｃ�誤���①��㎫��㏝�鶯�� �ょ�獰�����,����������ㅳ�������歷�갬��객������鵝��訝�����������譯��黎�������릇���也녔�獰��永���������������� 占�</td>
                           <td class="bg_white lpad_20 style1">占쏙옙??占쏙옙占쏙옙界? </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">14:00</td>
                           <td class="bg_white lpad_20 style1">占쏙옙?占쏙옙部占쏙옙占쏙옙占쏙옙占쏙옙?占�?占쏙옙占�</td>
                           <td class="bg_white lpad_20 style1"></td>
                         </tr>
                       </table>
                     </div>
                   <!-- 표3 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="txt_orange2 fs11 lpad_10"><span class="style1">占쏙옙 占쌩억옙占쏙옙占쏙옙占쏙옙占�占쏙옙占�占쏙옙可?占쏙옙占�占쏙옙<a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print01.jsp','','scrollbars=yes,width=702,height=600')"></a></span></td>
               </tr>
             </table>
           <!-- 占쏙옙d占쏙옙占쏙옙 / -->
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
        <%@ include file="/jpn/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>