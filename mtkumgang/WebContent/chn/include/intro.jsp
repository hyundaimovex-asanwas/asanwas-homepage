<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
<html> 
<head> 
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
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
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="194" valign="top"><a href="/chn/main.jsp"><img src="<%=imageServer%>/chn_img/guide/chn_logo.gif" border="0"></a></td>
			<td width="690" height="87" valign="top">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td height="34" valign="top" align="right"><img src="<%=imageServer%>/chn_img/common/korea_bt.gif"></td>
					</tr>
					<!-- -->
      <tr>
        <td height="29"><table cellpadding="0" cellspacing="0">
          <tr>
            <td><a href="/chn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01','','<%=imageServer%>/chn_img/common/top_menu1on.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu1.gif" name="topsub_01" border="0"></a></td>
            <td><a href="/chn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02','','<%=imageServer%>/chn_img/common/top_menu2on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu2.gif" name="topsub_02" border="0"></a></td>
            <td><a href="/chn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03','','<%=imageServer%>/chn_img/common/top_menu3on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide')"><img src="<%=imageServer%>/chn_img/common/top_menu3.gif" name="topsub_03" border="0"></a></td>
            <td><a href="/chn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04','','<%=imageServer%>/chn_img/common/top_menu4on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show')"><img src="<%=imageServer%>/chn_img/common/top_menu4.gif" name="topsub_04" border="0"></a></td>
          </tr>
        </table></td>
      </tr>
      <!-- -->
      <!-- -->
      <tr>
        <td height="24" valign="top"><div id="Layer1" style="position:absolute; z-index:1; visibility: hidden;">
          <table cellpadding="0" cellspacing="0">
            <tr>
              <td width="45"></td>
              <td><a href="/chn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_01','','<%=imageServer%>/chn_img/common/top_submenu1_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_01.gif" name="topsub_01_01" border="0"></a></td>
              <td><a href="/chn/preview/story.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_02','','<%=imageServer%>/chn_img/common/top_submenu1_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_02.gif" name="topsub_01_02" border="0"></a></td>
              <td><a href="/chn/preview/gallery/gallery_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_03','','<%=imageServer%>/chn_img/common/top_submenu1_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_03.gif" name="topsub_01_03" border="0"></a></td>
              <td><a href="/chn/preview/pr_room/pr_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_04','','<%=imageServer%>/chn_img/common/top_submenu1_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu1_04.gif" name="topsub_01_04" border="0"></a></td>
            </tr>
          </table>
        </div>
              <div id="Layer2" style="position:absolute; z-index:2; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="230"></td>
                    <td><a href="/chn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_01','','<%=imageServer%>/chn_img/common/top_submenu2_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_01.gif" name="topsub_02_01" border="0"></a></td>
                    <td><a href="/chn/reservation/basic_goods_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_02','','<%=imageServer%>/chn_img/common/top_submenu2_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_02.gif" name="topsub_02_02" border="0"></a></td>
                    <td><a href="/chn/reservation/price/price_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_03','','<%=imageServer%>/chn_img/common/top_submenu2_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_03.gif" name="topsub_02_03" border="0"></a></td>
                    <td><a href="/chn/reservation/agent/agent_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_04','','<%=imageServer%>/chn_img/common/top_submenu2_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu2_04.gif" name="topsub_02_04" border="0"></a></td>
                  </tr>
                </table>
              </div>
          <div id="Layer3" style="position:absolute; z-index:3; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="318"></td>
                    <td><a href="/chn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_01','','<%=imageServer%>/chn_img/common/top_submenu3_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_01.gif" name="topsub_03_01" border="0"></a></td>
                    <td><a href="/chn/start/traffic.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_02','','<%=imageServer%>/chn_img/common/top_submenu3_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_02.gif" name="topsub_03_02" border="0"></a></td>
                    <td><a href="/chn/start/admission.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_03','','<%=imageServer%>/chn_img/common/top_submenu3_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_03.gif" name="topsub_03_03" border="0"></a></td>
                    <td><a href="/chn/start/keeping.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_04','','<%=imageServer%>/chn_img/common/top_submenu3_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu3_04.gif" name="topsub_03_04" border="0"></a></td>
                  </tr>
                </table>
          </div>
          <div id="Layer4" style="position:absolute; z-index:4; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="280"></td>
                    <td><a href="/chn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_01','','<%=imageServer%>/chn_img/common/top_submenu4_01on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_01.gif" name="topsub_04_01" border="0"></a></td>
                    <td><a href="/chn/guide/hotel/hotel01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_02','','<%=imageServer%>/chn_img/common/top_submenu4_02on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_02.gif" name="topsub_04_02" border="0"></a></td>
                    <td><a href="/chn/guide/food/food01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_03','','<%=imageServer%>/chn_img/common/top_submenu4_03on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_03.gif" name="topsub_04_03" border="0"></a></td>
                    <td><a href="/chn/guide/play/play01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_04','','<%=imageServer%>/chn_img/common/top_submenu4_04on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_04.gif" name="topsub_04_04" border="0"></a></td>
                    <td><a href="/chn/guide/etc/etcguide.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_05','','<%=imageServer%>/chn_img/common/top_submenu4_05on.gif',1)"><img src="<%=imageServer%>/chn_img/common/top_submenu4_05.gif" name="topsub_04_05" border="0"></a></td>
                  </tr>
                </table>
          </div></td>
      </tr>
      <!-- -->
				</table>			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/chn_img/footer/company_visual.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/chn_img/leftMenu08.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/footer/tit_footer01.gif"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="277">
								<table width="277" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/chn_img/footer/img_intro.jpg"></td></tr>
								<tr><td height="13"></td></tr>
								<tr><td><img src="<%=imageServer%>/chn_img/footer/txt_intro_03.gif"></td></tr>
								</table>
							</td>
							<td width="413">
								<table width="413" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/chn_img/footer/txt_intro_01.gif"></td></tr>
								<tr><td height="30"></td></tr>
								<tr><td><img src="<%=imageServer%>/chn_img/footer/txt_intro_02.gif"></td></tr>
								<tr><td height="70"></td></tr>
								</table>
								<table width="413" cellpadding="0" cellspacing="0" border="0">
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/chn_img/footer/txt01.gif"></td></tr>
								<tr>
									<td width="12"></td>
									<td width="401"><span class="style1">现代峨山（株）</span></td>
								</tr>
								<tr><td height="12" colspan="2"></td></tr>
								<tr><td height="1" class="line_g" colspan="2"></td></tr>
								<tr><td height="15" colspan="2"></td></tr>
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/chn_img/footer/txt02.gif"></td></tr>
								<tr>
									<td></td>
									<td><span class="style1">1999年 2月 5日</span></td>
								</tr>
								<tr><td height="12" colspan="2"></td></tr>
								<tr><td height="1" class="line_g" colspan="2"></td></tr>
								<tr><td height="15" colspan="2"></td></tr>
								<tr><td valign="top" height="21" colspan="2"><img src="<%=imageServer%>/chn_img/footer/txt03.gif"></td></tr>
								<tr>
									<td></td>
									<td>
										<span class="style1"><br>
										首尔本社：首尔 钟路区 桂洞 140-2 现代大楼 12层（略图，联系方法指南）<br>
										金刚山营业所：江原道 高城郡 温井里<br>
										开城营业所：黄海道 开城市 凤洞里 163班<br>
										高城营业所：江原道 高城郡 县内面  草岛里 山28番地 花津浦  峨山 休息所</span></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
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
		<!--/ footer -->           
        <%@ include file="footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>