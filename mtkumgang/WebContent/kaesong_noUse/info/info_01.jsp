<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>

<html>
<head>
<title>::: ���� ���� :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="/kaesong/inc/java.js"></script>
<style type="text/css">
<!--
#Layer1 {	position:absolute;
	z-index:1;
	visibility: hidden;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #fe842b}
-->
</style>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"></head>
<body onLoad="MM_preloadImages('/kaesong/images/info/leftmenu_02o.gif')">
	<table cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr>
		  <td background="/kaesong/images/info/sub_02.gif">
		<!-------- / top start -------->
        <%@ include file="../include/info_top.jsp" %>
		<!-------- top  end / --------></td>
		</tr>
		<tr>
			<td height="100%" valign="top">
				<table width="890" height="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td height="100%" valign="top" style="padding-left:30px;" width="220">
							<!--left menu start-->
							<%@ include file="../include/left_menu_info.jsp" %>
							<!--����Ʈ�޴���-->
						</td>
						<td valign="top">
							<table cellpadding="0" cellspacing="0">
								<tr>
									
                <td style="padding-right:20px;" width="670" height="31" align="right" valign="top" background="/kaesong/images/info/subtop_bg.gif"><a href="#" class="linemap">Home</a> 
                  &gt; <a href="#" class="linemap">���� �˾ƺ���</a> &gt; <span class="linemap_now">�����Ұ�</span></td>
								</tr>
								<tr>
									<td background="/kaesong/images/info/submiddle_bg.gif" style="padding-left:30px;">
									<!--����־��ּ���-->
										
                  <table cellpadding="0" cellspacing="0">
                    <tr> 
                      <td><img src="/kaesong/images/info/menu_01_con2.gif" width="118" height="19"></td>
                    </tr>
                    <tr> 
                      <td style="padding-top:28px; padding-bottom:16px;"><img src="/kaesong/images/info/menu_01_con2.jpg"></td>
                    </tr>
                    <tr> 
                      <td><img src="/kaesong/images/info/menu_01_con3.gif"></td>
                    </tr>
                    <tr> 
                      <td style="padding-top:26px; padding-bottom:25px;"> <table cellpadding="0" cellspacing="0" width="100%">
                          <tr> 
                            <td align="left">
             <script language="javascript" src="/kaesong/inc/ActiveX_Run.js"></script> 
            <script language="javascript">view_flash('/kaesong/images/info/gaeseong.swf','255','270','window');</script> </td>
                            <td align="right" valign="top" style="padding-top:7px;"><img src="/kaesong/images/info/menu_01_con4-1.gif"></td>
                          </tr>
                        </table></td>
                    </tr>
                  </table>
									</td>
								</tr>
								<tr>
									<td style="padding-bottom:10px;"><img src="/kaesong/images/info/subbottom_bg.gif"></td>
								</tr>
							</table>
						</td>
					</tr>
			 </table>
			</td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<!--bottom start-->
		<tr>
			<td background="/kaesong/images/kaesong_main/bottom_bg.gif" height="85" valign="top">
				<%@ include file="../include/footer.jsp" %>
			</td>
		</tr>
	<!--bottom end-->
<!--   < % @ include file="/inc/bottom.jsp" % > ���⸦ ���̼���  -->
	</table>
</body>
</html>
