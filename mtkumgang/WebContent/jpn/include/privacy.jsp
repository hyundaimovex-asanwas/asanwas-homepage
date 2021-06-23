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
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/jpn_img/footer/privacy_visual.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/jpn_img/leftMenu83.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/jpn_img/footer/tit_footer03.gif"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="24"></td></tr>
				<tr><td><img src="<%=imageServer%>/jpn_img/footer/txt_privacy02.gif"></td></tr>
				<tr><td height="39"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/jpn_img/footer/txt_privacy01.gif" style="margin:0 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<span style="width:678px;" class="div06 lh16">
								<strong>01. 個人情報の収集目的及び利用目的
</strong><br><br>
								金鋼山観光では、本ホームページ利用者に本サイトを最大限效果的にご利用いただくため、どうしても必要となる最低限の情報のみを伺っております。 金鋼山観光が会員様の個人情報を伺うもう一つの目的は、金鋼山観光サイトを通じて会員様一人一人に最適なサービスを提供するためです。会員の皆様がご提供くださった個人情報を利用すれば、会員様により有用な特定の情報を提供することが可能となります。
<br><br>
								<strong>02. サービス提供者が収集する個人情報</strong><br><br>
								金鋼山観光では效果的な運営のために本ホームページを会員制で運営しています。そのため、実名の確認などを目的に、お名前や生年月日(住民登録番号)、連絡先、職業、住所、メールアドレス、電話番号などの基本的な情報を伺っております。こうしたサイト運営に必要となる基本情報の他にも、アンケートやイベント参加時の統計、もしくは商品を正確に発送するためにも個人情報を伺う場合がございます。
<br><br>
								<strong>03. 個人情報を第三者に提供する場合の被提供者、提供目的及び提供する情報の内容</strong><br><br>
								金鋼山観光では、一般的にお客様の個人情報を共有したり第三者に提供することはありません。金鋼山観光の掲示板などに利用者が自分で入力しない以上、個人情報が外部に流出することはありません。ただし、より良いサービスを提供するために、ビジネスパートナーと会員様の個人情報を共有する場合がございます。こうした場合でも、会員様にビジネスパートナーが誰なのか、そしてどんな情報がどうして必要なのか明らかにし、会員様がこれに同意しない場合には会員様の個人情報は共有されません。一方、他人に被害を与えたり、関連政府機関の要求がある場合、または学術的目的の統計資料や市場調査、統計処理などのために必要な場合には、個人個人の識別が不可能な形で情報が第三者に提供される場合がございます。
<br><br>
								<strong>04. 同意の撤回, 閲覧, 訂正要求及び退会などの利用者の権利及びその行使方法</strong><br><br>
								会員様はいつでも登録した個人情報を閲覧又は訂正することができるものとし、また会員退会をリクエストすることができるものとします。会員様の個人情報の閲覧、訂正及び退会は、金鋼山観光サイト上の「会員広場」で行うことができます。その他の事項や個人情報に関するお問い合わせについては、運営者(電話 399-2326)までご連絡ください。早急にお応えいたします。

								</span>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="30"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
							<td class="lpad_10 rpad_10">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr><td><img src="<%=imageServer%>/jpn_img/footer/txt_privacy03.gif"></td></tr>
								<tr><td height="14"></td></tr>
								<tr>
									<td class="lh16"><strong class="txt_dblue">個人情報関連管理担当者 : </strong>TEL 02) 3669-3883<br>
									  <strong class="txt_dblue">現代牙山（株）ウェッブマスター : </strong><a href="mailto:webmaster@hdasan.com">webmaster@hdasan.com</a></td>
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