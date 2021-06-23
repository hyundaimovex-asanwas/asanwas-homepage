<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
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
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
</head>



<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/preview/tour_preview_left.jsp" %>
            <!--  left menu flash -->
				</td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/preview/tit_preview03.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>






				
            <table width="690%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td colspan="9" height="22">&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="9"><img src="<%=imageServer%>/chn_img/preview/txt_top_preview03.gif"></td>
              </tr>
              <tr> 
                <td colspan="9" height="60">&nbsp;</td>
              </tr>
              <tr> 
                <td width="30">&nbsp;</td>
                <td width="150"><img src="<%=imageServer%>/chn_img/preview/img_gallery01.jpg"></td>
                <td width="10">&nbsp;</td>
                <td width="150"><img src="<%=imageServer%>/chn_img/preview/img_gallery01.jpg"></td>
                <td width="10">&nbsp;</td>
                <td width="150"><img src="<%=imageServer%>/chn_img/preview/img_gallery01.jpg"></td>
                <td width="10">&nbsp;</td>
                <td width="150"><img src="<%=imageServer%>/chn_img/preview/img_gallery04.jpg"></td>
                <td>&nbsp;</td>


              </tr>
              <tr> 
                <td height="22">&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td height="211">&nbsp;</td>
                <td colspan="7" align="left" valign="top"><img src="<%=imageServer%>/chn_img/preview/img_gallery05.jpg"></td>
                <td width="">&nbsp;</td>
              </tr>
              <tr> 
                <td height="63">&nbsp;</td>
                <td colspan="7">&nbsp;</td>
                <td width="">&nbsp;</td>
              </tr>
              <tr> 
                <td height="16">&nbsp;</td>
                <td colspan="7"><img src="<%=imageServer%>/chn_img/preview/txt_preview03.gif"></td>
                <td width="">&nbsp;</td>
              </tr>
              <tr> 
                <td height="89">&nbsp;</td>
                <td colspan="7">&nbsp;</td>
                <td width="">&nbsp;</td>
              </tr>
            </table> 
            <!--  content / -->
          </td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer   -->
        <%@ include file="/chn/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>
