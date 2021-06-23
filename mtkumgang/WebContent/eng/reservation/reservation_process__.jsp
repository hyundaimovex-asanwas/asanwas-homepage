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

</head>

<body>
<table cellpadding="0" cellspacing="0" width="100%">
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
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/eng_img/apply/tit_res01.gif"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
      <tr>
        <td height="11"></td>
      </tr>
      <tr>
        <td><img src="<%=imageServer%>/eng_img/apply/top_txt_res01.gif"></td>
      </tr>
    </table>
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
      <tr>
        <td><table width="679" cellpadding="0" cellspacing="0" border="0" style='margin-left:11px;'>
            <tr>
              <td colspan="7" height="10"></td>
            </tr>
            <tr valign="top">
              <td width="145"><img src="<%=imageServer%>/eng_img/apply/img_res_p0101.gif"><br>
                <a href="agent/agent_list.jsp" target="_self"><img src="<%=imageServer%>/eng_img/btn/btn_agencydesc.gif" border="0" style='margin:14 0 0 9px;'></a></td>
              <td width="33" align="center"><img src="<%=imageServer%>/eng_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/eng_img/apply/img_res_p0102.gif"></td>
              <td width="33" align="center"><img src="<%=imageServer%>/eng_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/eng_img/apply/img_res_p0103.gif"></td>
              <td width="33" align="center"><img src="<%=imageServer%>/eng_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/eng_img/apply/img_res_p0104.gif"></td>
            </tr>
            <tr>
              <td colspan="7" height="30"></td>
            </tr>
            <tr>
              <td colspan="7"><img src="<%=imageServer%>/eng_img/apply/stit_res02.gif"></td>
            </tr>
            <tr>
              <td colspan="7" height="10"></td>
            </tr>
            <tr valign="top">
              <td><img src="<%=imageServer%>/eng_img/apply/img_res_p0201.gif"><br>
                <!--<a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/eng_img/btn/btn_onlinereser.gif" border="0" style='margin:14 0 0 9px;'></a>< --></td>
              <td align="center"><img src="<%=imageServer%>/eng_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/eng_img/apply/img_res_p0202.gif"></td>
              <td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/eng_img/apply/img_res_p0203.gif"></td>
              <td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/eng_img/apply/img_res_p0204.gif"></td>
            </tr>
        </table></td>
      </tr>
    </table>
				<!--------  center area /-------->   </td>
		</tr>
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