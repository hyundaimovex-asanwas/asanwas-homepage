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
</script>
<style type="text/css">
<!--
.style3 {font-weight: bold}
.style13 {font-weight: bold}
.style17 {font-weight: bold}
.style22 {font-weight: bold}
.style40 {color: #993399}
-->
</style>
</head>

<body>
<DIV ID="objContents">
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/reservation/tour_reservation_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
          <tr valign="top">
            <td width="174"><!--  left menu flash -->
                <%@ include file="/chn/include/reservation/tour_reservation_left_utf8.jsp" %>
                <!--  left menu flash -->            </td>
            <td><span id="d1">
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
				    <td class="lpad_20 style3">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/apply/tit_res01.gif"></td>
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
        <td><img src="<%=imageServer%>/chn_img/apply/top_txt_res01.gif"></td>
      </tr>
  <!--  </table>
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">-->
      <tr>
        <td><table width="679" cellpadding="0" cellspacing="0" border="0" style='margin-left:11px;'>
            <tr>
              <td colspan="7" height="10"></td>
            </tr>
            <tr valign="top">
              <td width="145"><img src="<%=imageServer%>/chn_img/apply/img_res_p0101.gif"><br>
                <a href="agent/agent_list.jsp" target="_self"><img src="<%=imageServer%>/chn_img/btn/btn_agencydesc.gif" border="0" style='margin:14 0 0 9px;'></a></td>
              <td width="33" align="center"><img src="<%=imageServer%>/chn_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/chn_img/apply/img_res_p0102.gif"></td>
              <td width="33" align="center"><img src="<%=imageServer%>/chn_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/chn_img/apply/img_res_p0103.gif"></td>
              <td width="33" align="center"><img src="<%=imageServer%>/chn_img/apply/process_vline.gif"></td>
              <td width="145"><img src="<%=imageServer%>/chn_img/apply/img_res_p0104.gif"></td>
            </tr>
            <tr>
              <td colspan="7" height="30"></td>
            </tr>
            <tr>
              <td colspan="7"><img src="<%=imageServer%>/chn_img/apply/stit_res02.gif"></td>
            </tr>
            <tr>
              <td colspan="7" height="10"></td>
            </tr>
            <tr valign="top">
              <td><img src="<%=imageServer%>/chn_img/apply/img_res_p0201.gif"><br>
                <!--예약버튼: <a href="agent/agent_list.jsp" target="_self"><img src="<%=imageServer%>/chn_img/btn/btn_a2.gif" border="0" style='margin:14 0 0 9px;'></a>-->
                <!--<a href="javascript:;" onClick="javascript:alert('غ  Դϴ.');"><img src="<%=imageServer%>/chn_img/btn/btn_onlinereser.gif" border="0" style='margin:14 0 0 9px;'></a>< --></td>
              <td align="center"><img src="<%=imageServer%>/chn_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/chn_img/apply/img_res_p0202.gif"></td>
              <td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/chn_img/apply/img_res_p0203.gif"></td>
              <td align="center"><img src="<%=imageServer%>/tour_img/apply/process_vline2.gif"></td>
              <td><img src="<%=imageServer%>/chn_img/apply/img_res_p0204.gif"></td>
            </tr>
        </table></td>
      </tr>
    </table></span>
				<!--------  center area /-------->   </td>
</tr>
</table>
		<!--------  center area /-------->
	</td></tr>
<tr>
	<td valign="bottom" height="20">
		<!--/ footer -->
        <%@ include file="/chn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
<DIV ID="objSelection"> 
</DIV> 
</body>
</html>