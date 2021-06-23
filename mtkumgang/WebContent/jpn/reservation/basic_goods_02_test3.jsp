<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.net.*"%>
<%!
//DNS
public static final String ROOT_DNS= "test1.hdasan.com";
//public static final String ROOT_DNS= "test1.hdasan.com";
%>
<%
//�̹��� ���� 'ġ
String imageServer = "http://test1.hdasan.com/asanway/img/";
String rootServer = "http://test1.hdasan.com/";

//���� URL FULL ���
String qryStr = request.getQueryString();
qryStr = (qryStr!=null && !qryStr.equals(""))?"?"+qryStr:"";
String requestUri = request.getRequestURI();
String nowUri = requestUri+qryStr; 
nowUri = java.net.URLEncoder.encode(nowUri);
%>

<div id="TourRia"></div> 
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
/*  High-peak season/ Peak season/ Low season/ ���̾� ������ */
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
.style3 {
	font-family: SimHei;
	font-weight: bold;
}
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
               <td height="54"><img src="<%=imageServer%>/jpn_img/apply/tit_app22.gif"></td>
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
               <td><img src="<%=imageServer%>/jpn_img/apply/top_txt_app22.gif" style="margin-top:12px;"></td>
             </tr>
         </table></td>
       </tr>
       <tr>
         <td colspan="2" height="30"></td>
       </tr>
       <tr valign="top">
         <td width="300"><table width="287" cellpadding="0" cellspacing="0" border="0">
             <tr>
               <td valign="top" height="308"><img src="<%=imageServer%>/jpn_img/apply/img_basic02.jpg" width="269" height="308"></td>
             </tr>
         </table></td>
         <td width="390"><table width="390" border="0" cellspacing="0" cellpadding="0">
             <tr>
               <td class="line_dg" colspan="3" height="2"></td>
             </tr>
             <tr>
               <td width="97" height="29"><img src="<%=imageServer%>/jpn_img/apply/txt_order01.gif" /></td>
               <td width="293" ><span class="style2">���</span></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td height="29"><img src="<%=imageServer%>/jpn_img/apply/txt_order02.gif" /></td>
               <td ><span class="style3">2�1��</span></td>
             </tr>
             <tr>
               <td class="line_g2" colspan="3" height="1"></td>
             </tr>
             <tr>
               <td width="97" height="33"><img src="<%=imageServer%>/jpn_img/apply/txt_order05.gif" /></td>
               <td width="293" ><span class="style2">11:00 (��ݻ��������?�?��)</span></td>
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
                     <td width="69" height="138" valign="top"><img src="<%=imageServer%>/jpn_img/apply/txt_order03.gif" /></td>
                     <td width="1" bgcolor="#AFAFAF"></td>
                     <td valign="top" style="padding-left:27px;"><p class="style2">??�ʣ����涣��������?���������??������������?����?ߣ?������?��?�����(8��)��?��???�?��?��<br>
                       数日間の休暇をもらうことは難しく、金銭的にも余裕がなく、だからといって金剛山の風景を
見逃すわけにはいかない，， 
金剛山一泊二日（8時出発）商品は、そのような皆様の悩みを全て解決してくれるでしょう
北側についてすぐ金剛山へ登り、功藝公演か温泉かどちらかを選ぶ悩みをしてみたり
金剛山の夜景を楽しんで忙しかった一日を終えて
その次の日は萬物相と三日浦/海金剛のどちらかで悩む事となるでしょう
��<br>
                       ��ݻ��������?�?�� </p>                       </td>
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
               <td ><span class="txt_orange b style2">200,000?� ~ 350,000?�</span><br>
                 �� ������?���?��</td>
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
         <td colspan="2"><!-- / ��d���� -->
             <table width="690" cellpadding="0" cellspacing="0" border="0">
               <tr>
                 <td height="25" valign="top"><img src="<%=imageServer%>/jpn_img/apply/stit_app0302.gif" name="01"></td>
               </tr>
               <tr>
                 <td><%if(dateview.equals("1")){%><img src="<%=imageServer%>/jpn_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/jpn_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/jpn_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/jpn_img/apply/tab_date02.gif" ></a><%}%><img src="<%=imageServer%>/jpn_img/apply/tab_date000.gif"></td>
               </tr>
               <tr>
                 <td height="20"></td>
               </tr>
               <tr>
                 <td><!-- / ǥ1 -->
                     <div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">??</td>
                           <td class="bg_white style1">??����</td>
                           <td class="bg_white style1">?� </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">06:00 </td>
                           <td class="bg_white lpad_20 style1">��?���?�(������ߣ�����) </td>
                           <td width="30%" class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:00 </td>
                           <td class="bg_white lpad_20 style2">???��?���?�</td>
                           <td class="bg_white lpad_20 style2">?�?��? </td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">07:20 </td>
                           <td class="bg_white lpad_20 style2">��?��ݻ��������?�??���?</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:15 </td>
                           <td class="bg_white lpad_20 style2">��?��ݻ��������?�??���?</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">09:40 </td>
                           <td class="bg_white lpad_20 style2">��??������??�������� </td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">12:30 </td>
                           <td class="bg_white lpad_20 style2">������?ڪ </td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">13:30</td>
                           <td class="bg_white lpad_20 style2">߲����������?(��?)��?�</td>
                           <td class="bg_white lpad_20 style2">??</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:30 </td>
                           <td class="bg_white lpad_20 style2">?��?������</td>
                           <td class="bg_white lpad_20 style2">??</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26"> 18:00</td>
                           <td class="bg_white lpad_20 style2">?������??</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ1 / -->
                     <!-- / ǥ2 -->
                     <div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
                       <table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
                         <tr align="center">
                           <td height="26" class="bg_white style1">??</td>
                           <td class="bg_white style1">??����</td>
                           <td class="bg_white style1">?� </td>
                         </tr>
                         <tr>
                           <td width="20%" height="26" align="center" class="bg_white">07:00 </td>
                           <td class="bg_white lpad_20 style1">����</td>
                           <td width="30%" class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">08:20 </td>
                           <td class="bg_white lpad_20 style2">زڪ����߲����/���?����?��?��</td>
                           <td class="bg_white lpad_20"></td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">12:30 </td>
                           <td class="bg_white lpad_20 style2">��������??(?�/?ڪ) </td>
                           <td class="bg_white lpad_20 style2">??</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">15:55 </td>
                           <td class="bg_white lpad_20 style2">��??��?</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">16:10 </td>
                           <td class="bg_white lpad_20 style2">��?��ݻ��������?�??���?</td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                         <tr>
                           <td class="bg_white" align="center" height="26">17:10</td>
                           <td class="bg_white lpad_20 style2">��?��ݻ��������?�??���? </td>
                           <td class="bg_white lpad_20">&nbsp;</td>
                         </tr>
                       </table>
                     </div>
                   <!-- ǥ2 / -->
                 </td>
               </tr>
               <tr>
                 <td height="35" valign="bottom" class="style2">�� �߾��������?���?��ʦ?���?��<a href="#" onClick="MM_openBrWindow('schedule/popup_plan_print01.jsp','','scrollbars=yes,width=702,height=600')"></a></td>
               </tr>
             </table>
           <!-- ��d���� / -->
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

		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>