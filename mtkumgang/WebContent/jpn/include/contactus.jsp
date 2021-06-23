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
<script language="JavaScript" src="<%=imageServer%>/jpn_img/inc/java.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="194" valign="top"><a href="/jpn/main.jsp"><img src="<%=imageServer%>/jpn_img/guide/jpn_logo.gif" border="0"></a></td>
			<td width="690" height="87" valign="top">
				<table cellpadding="0" cellspacing="0">
					<tr>
						<td height="34" valign="top" align="right"><img src="<%=imageServer%>/jpn_img/common/korea_bt.gif"></td>
					</tr>
					<!--원뎁스 시작-->
      <tr>
        <td height="29"><table cellpadding="0" cellspacing="0">
          <tr>
            <td><a href="/jpn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01','','<%=imageServer%>/jpn_img/common/top_menu1on.gif',1);MM_showHideLayers('Layer1','','show','Layer2','','hide','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/jpn_img/common/top_menu1.gif" name="topsub_01" border="0"></a></td>
            <td><a href="/jpn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02','','<%=imageServer%>/jpn_img/common/top_menu2on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','show','Layer3','','hide','Layer4','','hide')"><img src="<%=imageServer%>/jpn_img/common/top_menu2.gif" name="topsub_02" border="0"></a></td>
            <td><a href="/jpn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03','','<%=imageServer%>/jpn_img/common/top_menu3on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','show','Layer4','','hide')"><img src="<%=imageServer%>/jpn_img/common/top_menu3.gif" name="topsub_03" border="0"></a></td>
            <td><a href="/jpn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04','','<%=imageServer%>/jpn_img/common/top_menu4on.gif',1);MM_showHideLayers('Layer1','','hide','Layer2','','hide','Layer3','','hide','Layer4','','show')"><img src="<%=imageServer%>/jpn_img/common/top_menu4.gif" name="topsub_04" border="0"></a></td>
          </tr>
        </table></td>
      </tr>
      <!--원뎁스 끝-->
      <!--투뎁스 시작-->
      <tr>
        <td height="24" valign="top"><div id="Layer1" style="position:absolute; z-index:1; visibility: hidden;">
          <table cellpadding="0" cellspacing="0">
            <tr>
              <td width="45"></td>
              <td><a href="/jpn/preview/intro.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_01','','<%=imageServer%>/jpn_img/common/top_submenu1_01on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu1_01.gif" name="topsub_01_01" border="0"></a></td>
              <td><a href="/jpn/preview/story.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_02','','<%=imageServer%>/jpn_img/common/top_submenu1_02on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu1_02.gif" name="topsub_01_02" border="0"></a></td>
              <td><a href="/jpn/preview/gallery/gallery_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_03','','<%=imageServer%>/jpn_img/common/top_submenu1_03on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu1_03.gif" name="topsub_01_03" border="0"></a></td>
              <td><a href="/jpn/preview/pr_room/pr_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_01_04','','<%=imageServer%>/jpn_img/common/top_submenu1_04on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu1_04.gif" name="topsub_01_04" border="0"></a></td>
            </tr>
          </table>
        </div>
              <div id="Layer2" style="position:absolute; z-index:2; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="230"></td>
                    <td><a href="/jpn/reservation/reservation_process.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_01','','<%=imageServer%>/jpn_img/common/top_submenu2_01on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu2_01.gif" name="topsub_02_01" border="0"></a></td>
                    <td><a href="/jpn/reservation/basic_goods_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_02','','<%=imageServer%>/jpn_img/common/top_submenu2_02on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu2_02.gif" name="topsub_02_02" border="0"></a></td>
                    <td><a href="/jpn/reservation/price/price_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_03','','<%=imageServer%>/jpn_img/common/top_submenu2_03on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu2_03.gif" name="topsub_02_03" border="0"></a></td>
                    <td><a href="/jpn/reservation/agent/agent_list.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_02_04','','<%=imageServer%>/jpn_img/common/top_submenu2_04on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu2_04.gif" name="topsub_02_04" border="0"></a></td>
                  </tr>
                </table>
              </div>
          <div id="Layer3" style="position:absolute; z-index:3; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="318"></td>
                    <td><a href="/jpn/start/packup01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_01','','<%=imageServer%>/jpn_img/common/top_submenu3_01on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu3_01.gif" name="topsub_03_01" border="0"></a></td>
                    <td><a href="/jpn/start/traffic.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_02','','<%=imageServer%>/jpn_img/common/top_submenu3_02on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu3_02.gif" name="topsub_03_02" border="0"></a></td>
                    <td><a href="/jpn/start/admission.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_03','','<%=imageServer%>/jpn_img/common/top_submenu3_03on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu3_03.gif" name="topsub_03_03" border="0"></a></td>
                    <td><a href="/jpn/start/keeping.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_03_04','','<%=imageServer%>/jpn_img/common/top_submenu3_04on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu3_04.gif" name="topsub_03_04" border="0"></a></td>
                  </tr>
                </table>
          </div>
          <div id="Layer4" style="position:absolute; z-index:4; visibility: hidden;">
                <table cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="280"></td>
                    <td><a href="/jpn/guide/course/course01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_01','','<%=imageServer%>/jpn_img/common/top_submenu4_01on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu4_01.gif" name="topsub_04_01" border="0"></a></td>
                    <td><a href="/jpn/guide/hotel/hotel01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_02','','<%=imageServer%>/jpn_img/common/top_submenu4_02on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu4_02.gif" name="topsub_04_02" border="0"></a></td>
                    <td><a href="/jpn/guide/food/food01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_03','','<%=imageServer%>/jpn_img/common/top_submenu4_03on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu4_03.gif" name="topsub_04_03" border="0"></a></td>
                    <td><a href="/jpn/guide/play/play01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_04','','<%=imageServer%>/jpn_img/common/top_submenu4_04on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu4_04.gif" name="topsub_04_04" border="0"></a></td>
                    <td><a href="/jpn/guide/etc/etcguide.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('topsub_04_05','','<%=imageServer%>/jpn_img/common/top_submenu4_05on.gif',1)"><img src="<%=imageServer%>/jpn_img/common/top_submenu4_05.gif" name="topsub_04_05" border="0"></a></td>
                  </tr>
                </table>
          </div></td>
      </tr>
      <!--투뎁스 끝-->
				</table>			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/jpn_img/footer/contactus_visual.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/jpn_img/leftMenu85.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/jpn_img/footer/tit_footer05.gif"></td>
						</td>
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
						<tr><td valign="top" height="25" colspan="4"><img src="<%=imageServer%>/jpn_img/footer/txt_contactus_01.gif"></td></tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td width="178" height="26" align="LEFT"><img src="<%=imageServer%>/jpn_img/footer/txt04.gif"></td>
							<td width="140" class="lpad_10 tpad_3">コールセンター</td>
							<td width="140" class="lpad_10 tpad_3"><a href="mailto:miran@hdasan.com">miran@hdasan.com</a></td>
							<td width="300" class="lpad_10 tpad_3">02-3669-3000</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="LEFT"><img src="<%=imageServer%>/jpn_img/footer/txt05.gif"></td>
							<td class="lpad_10 tpad_3">チェ・ヨンマン  </td>
							<td class="lpad_10 tpad_3"><a href="mailto:ymchoi@hdasan.com">ymchoi@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3914</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="LEFT"><img src="<%=imageServer%>/jpn_img/footer/txt06.gif"></td>
							<td class="lpad_10 tpad_3">キム・ムヨル </td>
							<td class="lpad_10 tpad_3"><a href="mailto:helloray@hdasan.com">helloray@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3915</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="LEFT"><img src="<%=imageServer%>/jpn_img/footer/txt07.gif"></td>
							<td class="lpad_10 tpad_3">イ・ユンジョン </td>
							<td class="lpad_10 tpad_3"><a href="mailto:smlkong@empal.com">smlkong@empal.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3711</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr>
							<td height="26" align="LEFT"><img src="<%=imageServer%>/jpn_img/footer/txt08.gif"></td>
							<td class="lpad_10 tpad_3">イ・ユンジョン </td>
							<td class="lpad_10 tpad_3"><a href="mailto:lyjtotoro@hdasan.com">lyjtotoro@hdasan.com</a></td>
							<td class="lpad_10 tpad_3">02-3669-3879</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan="4"></td></tr>
						<tr><td height="39" colspan="4"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td valign="top" height="27" colspan="2"><img src="<%=imageServer%>/jpn_img/footer/txt_contactus_02.gif"></td></tr>
						<tr>
							<td width="12"></td>
							<td width="678">- 住所　：　〒110-793 ソウル市鍾路区桂洞 140-2 現代ビル 12階</td>
						</tr>
						<tr>
							<td></td>
							<td>- TEL : 02)3669-3000 (観光のお問い合わせ)
</td>
						</tr>
						<tr><td height="34" colspan="2"></td></tr>
						<tr><td valign="top" height="27" colspan="2"><img src="<%=imageServer%>/jpn_img/footer/txt_contactus_03.gif"></td></tr>
						<tr>
							<td></td>
						  <td>地下鉄  ： 3号線安国駅下車 3番の出口徒歩 3分<br>
						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;支線バス(緑)　　1012番
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;幹線バス(青)　　151番、162番、171番、172番、272番、601番</td>
						</tr>
						<tr><td height="27" colspan="2"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/jpn_img/footer/map.gif"></td></tr>
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