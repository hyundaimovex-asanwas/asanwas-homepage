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
<script language="javascript">
 function savePds(val) {
     location.href="../center/download/download.jsp?file="+val;
 }
</script>
<style type="text/css">
<!--
.style1 {font-family: SimHei}
-->
</style>
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
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/jpn_img/footer/agreement_visual.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/jpn_img/leftMenu82.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/jpn_img/footer/tit_footer02.gif"></td>
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
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/jpn_img/footer/txt_agreement01.gif" style="margin:0 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:274px;overflow:auto;" class="div06">
								<table width="640" cellpadding="0" cellspacing="1" border="0">
								<tr><td colspan="2"><strong>第１章　総則</strong></td></tr>
								<tr><td colspan="2">第１条(目的)</td></tr>
								<tr>
									<td colspan="2">この約款は、現代牙山(株)が提供するウェブサービス(<a href="http://www.hdasan.com" target="_blank">www.hdasan.com</a>/<a href="http://www.mtkumgang.com" target="_blank">www.mtKumgang.com</a>)(以下用?件及</td>
								</tr>
								<tr><td colspan="2">「本サービス」といいます。) の利用条件及び手続きに関する事項、そしてその他必要な事項を規定することを目的とします。</td>
								</tr>
								<tr valign="top">
								  <td colspan="2"><p>第２条 (利用約款の効力及び変更)</p></td>
  </tr>
								<tr valign="top">
									<td width="15">①</td>
									<td width="625">この約款は、サービスメニュー及び弊社に掲示し公示することで効力が発生します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>弊社は、合理的な事由が発生した場合には、この約款を変更することができます。約款が変更された場合には、これを直ちに公示します。</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>会員制サービスの利用者は、変更された約款事項に同意しなければ本サービスの利用を中止し、利用契約を解除することができます。変更された約款の効力発生日以後もサービスの利用を続ける場合には、約款の変更事項に同意したものとみなされます。</td>
								</tr>
								<tr><td colspan="2"><p>第３条 (約款外の準則)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>この約款は、弊社が提供する個別サービスに関する利用案内(以下「サービス別案内」といいます。)とともに適用されます。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>この約款に明示されていない事項に関しては、関係法令及びサービス別案内の趣旨に従って適用されます。</td>
								</tr>
								<tr><td colspan="2"><p>第４条 (用語の定義)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>この約款で使う用語の定義は次の通りです。</td>
								</tr>
								<tr>
									<td></td>
									<td>1. 「利用顧客」とは、会員制サービスの利用者のことを指します。</td>
								</tr>
								<tr>
									<td></td>
									<td>2. 「利用契約」とは、サービスの利用に関して弊社と利用顧客との間で締結される契約のことを指します。</td>
								</tr>
								<tr>
									<td></td>
									<td><p>3. 「利用者番号(ID)」とは、利用顧客の識別と利用顧客のサービス利用のために利用顧客が選定し、弊社が承認する文字又は数字の組み合わせのことを指します。 </p></td>
								</tr>
								<tr>
									<td></td>
									<td>4. 「暗証番号」とは、利用顧客が定めた利用者番号と一致し、正しい利用顧客であるかを確認し、利用顧客の個人情報を保護するために利用顧客が設定した文字と数字の組み合わせのことを指します。</td>
								</tr>
								<tr>
									<td></td>
									<td><p> 5. 「端末機'」とは、弊社が提供するサービスを利用するために利用顧客が設置したパソコン及びモデムなどのことを指します。 </p></td>
								</tr>
								<tr>
									<td></td>
									<td>6. 「解約」とは、弊社又は会員が利用契約を解約することを指します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>この約款で使う用語の定義は、第1項で定められたものを除き、関係法令及びサービス別案内に定められたものに準じます。</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第２章　利用契約の締結</strong></td></tr>
								<tr><td colspan="2"><p>第５条 (利用契約の成立)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>利用契約は、利用顧客の本利用約款の内容に対する同意と利用申し込みに対する弊社の利用承諾によって成立します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>本利用約款に対する同意は、利用申し込みの際、現代牙山ホームページの該当する「同意」ボタンを押すことで意思表示できます。</td>
								</tr>
								<tr><td colspan="2"><p>第６条 (サービス利用の申し込み)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>会員登録して本サービスを利用しようとする利用顧客は、弊社が要請する諸般情報(名前、パスポート番号、連絡先など)を提供しなければなりません。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>すべての会員は、必ず本人の名前とパスポート番号を提供することでサービスを利用することができるものとし、実名で登録しない利用者は一切の権利を主張することができません。</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>会員登録は必ず実名のみで行うものとし、弊社は申込者の実名を確認する手続きを取ることができます。</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>他人の名義(名前及びパスポート番号)を盗用して利用申し込みを行った会員のIDは、削除されるとともに関係法令によって処罰される場合があります。</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>弊社は、本サービスを利用する会員を等級別に区分し、利用時間や利用回数、サービスメニューなどを細分して利用に制限を設けることができます。</td>
								</tr>
								<tr><td colspan="2"><p>第７条 (個人情報の保護及び使用)</p></td></tr>
								<tr>
									<td colspan="2"><p>弊社は、関係法令が定めるところにより、利用者の登録情報を含む利用者の個人情報を保護するために努力します。利用者の個人情報の保護及び使用に関しては、関連法令及び弊社の個人情報保護ポリシーが適用されます。但し、弊社の公式ホームページ以外にリンクされたサイトでは、弊社の個人情報保護ポリシーは適用されません。また、弊社は利用者の帰責事由によって外部に漏れた情報については一切の責任を負いません。 </p></td>
								</tr>
								<tr><td colspan="2">第８条  (利用申し込みの承諾と制限)</td>
								</tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社は、第６条の規定に伴う利用申し込み顧客に対し、業務遂行上もしくは技術上の差し支えがないかぎり、原則的に受け付け順にサービスの利用を承認します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td><p>弊社は、次の場合に利用申し込みを承諾しないことがあります。 <br />
									  - 実名ではない、もしくは他人の名義を利用して申し込まれた場合 <br />
									  - 利用契約申込書の内容が虚偽で記載されている場合 <br />
									  - 社会の秩序や美風良俗を害する目的で申し込まれた場合 <br />
									  - 不正な用途で本サービスを利用しようとする場合 <br />
									  - 営利を求める目的で本サービスを利用しようとする場合 <br />
									  - その他、定められた諸般の事項を違反しながら申し込まれた場合 <br />
									  - 本サービスと競争関係にある利用者によって申し込まれた場合。</p>
								  </td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>弊社は、サービス利用の申し込みが次の各号に該当する場合には、その申込みに対し、承諾の制限事由が解消されるまで承諾を保留することができます。 <br />
									  - 弊社の設備に余裕がない場合 <br />
									  - 弊社の技術上差し支えがある場合 <br />
								    - その他の事由で利用の承諾が困難な場合 </p></td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>弊社は、利用申し込み顧客が関係法令に定められた未成年者の場合には、サービス別案内の規定に従って承諾を保留することができます。</td>
								</tr>
								<tr><td colspan="2"><p>第９条 (利用顧客IDの付与及び変更など)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社は利用顧客に対し、約款の規定に従って利用顧客IDを付与します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>利用顧客IDは原則的に変更することができません。やむを得ない事由によって変更する場合には、該当のIDを解約してから再加入する必要があります。</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>現代牙山の利用顧客IDは、利用顧客本人の同意の下、現代牙山が運営する自社サイトの会員IDと連携される場合があります。</td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td><p>利用者IDは、次の各号に該当する場合には、利用者または弊社の要請で変更することができます。 <br />
									  - 利用者IDが利用者の電話番号またはパスポート番号などに登録されており、私生活侵害の恐れがある場合 <br />
									  - 他人に嫌悪感を与えたり美風良俗を害する場合 <br />
								    - その他の合理的な事由がある場合 </p></td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>サービス利用者ID及びパスワードの管理責任は利用者にあります。これらの管理をおろそかにしたために発生するサービス利用上の損害または第三者による不正利用などに関する責任は利用者にあり、弊社はそれに対する責任を一切負いません。</td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>その他利用顧客個人情報の管理や変更などに関する事項は、サービス別案内に定められた規定に従うものとします。</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第３章　契約当事者の義務</strong></td></tr>
								<tr><td colspan="2"><p>第１０条 (弊社の義務)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社は、利用顧客が希望したサービス提供開始日に、特別な事情がない限り、サービスの利用を開始できるようにしなければなりません。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>弊社は、継続的かつ安定的なサービスを提供するため、設備障害や設備損失などが生じた場合には、やむを得ない事由がない限り、直ちにこれを修理または復旧しなければなりません。</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td>弊社は、個人情報を保護するために保安システムを駆逐し、個人情報保護ポリシーを公示してこれを遵守します。</td>
								</tr>
								<tr><td colspan="2"><p>第１１条 (利用顧客の義務)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td><p>利用顧客は、会員加入申し込みまたは会員情報変更時、すべての事項を事実に基づいて実名で申込書及び変更手続き書を作成しなければなりません。また、虚偽や他人の情報を使って登録した場合には、一切の権利を主張することができません。 </p></td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>会員は、本約款に定められた事項、弊社がその他に定めた諸般規定や告知事項など、弊社が公示する事項及び関係法令を遵守しなければなりません。その他弊社の業務を妨げる行為、弊社の名誉を損傷させる行為はしてはなりません。</td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>会員は、住所・連絡先・メールアドレスなど、利用契約事項に変更があった場合には該当の手続きを経てこれを弊社に直ちに知らせなければなりません。 </p></td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td><p>弊社が関係法令及び個人情報保護ポリシーに基づいてその責任を負う場合を除き、会員に付与されたIDのパスワードの管理不徹底や不正使用によって生じるすべての結果に対する責任は会員にあります。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td><p>会員は、弊社の事前の承諾なしにサービスを利用して営業活動を行うことはできません。また、その営業活動の結果に対して弊社は責任を負いません。さらに、会員のこのような営業活動によって弊社が損害を被った場合、会員は弊社に対して損害賠償義務を負い、弊社は該当の会員に対してサービス利用制限及び適法な手続きを経て損害賠償などを請求することができます。 </p>
								    </td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td>会員は、弊社の明示的な同意がない限り、サービスの利用権限やその他利用契約上の地位を他人に譲渡したり贈与することができないものとし、またこれを担保として提供することはできません。</td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td>会員は、弊社及び第三者の知的財産権を侵害してはなりません。</td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td><p>会員は次の各号に該当する行為をしてはならないものとし、該当の行為を行った場合には、弊社は会員のサービス利用制限及び適法措置を含んだ制裁を加えることができます。 <br />
									  - 会員加入申し込みまたは会員情報変更時に虚偽内容を使って登録する行為 <br />
									  - 他の利用顧客のIDや暗証番号、パスポート番号を盗用する行為 <br />
									  - 利用顧客IDを他人と取り引きする行為 <br />
									  - 弊社の役人または関係者を騙る行為 <br />
									  - 弊社から特別な権利を与えられていないのに弊社のクライアントプログラムを変更したり、弊社のサーバーをハッキングしたり、ウェブサイトまたは掲示された情報の一部又は全部を任意的に変更する行為 <br />
									  - サービスに危害を加えたり、サービスを故意に妨げる行為 <br />
									  - 本サービスを通じて得た情報を、弊社の事前の承諾なしにサービス利用以外の目的で複製したり, これを出版及び放送などに使用したり、または第三者に提供する行為 <br />
									  - 公共秩序や美風良俗に反する低俗で淫らな内容の情報・文章・図形・音響・動画を送信・掲示・メールまたはその他の方法で他人に流布する行為 <br />
									  -　侮辱的又は個人的身上に関する内容なため、他人の名誉やプライバシーを侵害する恐れがある内容を送信・掲示・メールまたはその他の方法で他人に流布する行為 <br />
									  - 他の利用顧客を嘲弄または威嚇したり、特定の利用顧客に持続的に苦痛または不便を与える行為 <br />
									  - 弊社の承認を得ずに他の使用者の個人情報を収集または保存する行為 <br />
									  - 客観的に犯罪につながると判断される行為 <br />
									  - 本約款を含み、その他弊社が定めた諸般の規定または利用条件に違反する行為 <br />
								    - その他関係法令に反する行為 </p></td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第４章サービスの利用</strong></td></tr>
								<tr><td colspan="2"><p>第１２条 (サービス利用時間)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td><p>サービス利用は、弊社の業務上または技術上特に差し支えがない限り、年中無休の1日24時間運営を原則とします。但し、弊社は、システムの定期点検やシステムの増設または入れ替えを目的に、弊社が決めた日時にサービスを一時中断することができます。また予定の作業によるサービスの一時中断は、現代牙山のホームページを通じて事前に公示されます。 </p></td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td><p>弊社は、緊急なシステム点検やシステムの増設及び入れ替えなど、やむを得ない事由によって予告なしに一時的にサービスを中断することができるものとします。また、新しいサービスへの入れ替えなど、弊社が適切だと判断した事由によって、現在提供されているサービスを完全に中断することができます。 </p></td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>弊社は、国家の非常事態や停電、サービス設備の障害、又は急激なサービス利用者の増加などにより、正常なサービスの利用に差し支えがある場合、サービスの全部または一部を制限したり中止することができます。但し、この場合、その事由及び期間などを会員に事前又は事後に公示します。 </p></td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td>弊社は、弊社が統制することができない事由によりサービスが中断された場合(システム管理者の故意、過失のないディスク障害、システムダウンなど)は事前通知が不可能となり、他人(PC通信会社、基幹通信業者など)の故意や過失によるシステムの中断などの場合には通知を行いません。。</td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td>弊社は、サービスを特定範囲に分割して各範囲別に利用可能な時間を別途に指定することができます。ただし、この場合はその内容を公示します。</td>
								</tr>
								<tr><td colspan="2"><p>第十三条 (利用顧客IDの管理)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>利用顧客IDとパスワードに関するすべての管理責任は会員にあります。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td><p>弊社では、利用顧客IDを使って利用顧客の諸般管理業務を行っております。会員が利用顧客IDを変更しようとする場合でも、弊社が承認するだけの事由が認められない場合、利用顧客IDの変更を制限することができます。 </p></td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>利用顧客が登録した利用顧客ID及びパスワードによって発生する使用上の過失、または第三者による不正使用などに対するすべての責任は、該当の利用顧客にあります。 </p></td>
								</tr>
								<tr><td colspan="2"><p>第十四条 (掲示物の管理)</p></td></tr>
								<tr>
									<td colspan="2"><p>弊社は、次の各号に該当する掲示物や資料を事前の通知なしに削除・移動したり、登録を拒否することができます。 <br />
									  - 他の会員または第三者にひどい侮辱を与えたり名誉を損傷させる内容の場合 <br />
									  - 公共秩序や美風良俗に反する内容を流布したりリンクした場合 <br />
									  - 不法複製またはハッキングを助長する内容の場合 <br />
									  - 営利を目的とする広告の場合 <br />
									  - 客観的に犯罪につながると認められる内容の場合 <br />
									  - 他の利用顧客または第三者の著作権など、その他の権利を侵害する内容の場合 <br />
									  - 弊社で規定した掲示物原則に反する、もしくは掲示板の性格に符合しない内容の場合 <br />
								    - その他関係法令に反すると判断される場合 </p></td>
								</tr>
								<tr><td colspan="2"><p>第１５条 (掲示物に対する著作権)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td><p>会員がサービス画面に掲示した掲示物の著作権は掲示した会員に帰属します。また、弊社は掲示者の同意なしに掲示物を商業的に利用することはできません。但し、非営利な目的の場合はこれに限らず、また弊社はサービス内の掲載権を有するものとします。 </p></td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td><p>会員は、サービスを利用して取得した情報を任意的に加工して販売するなど、サービスに掲載された資料を商業的に使用することができません。 </p></td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>弊社は、会員が掲示・登録したサービス内の内容物や掲示内容に対し、第14条各号に該当すると判断される場合は、事前通知なしに削除・移動したり、登録を拒否することができるものとします。 
									</p></td>
								</tr>
								<tr><td colspan="2"><p>第十六条 (情報の提供)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社は、サービスの利用に必要だと認められる各種情報をメールや書信郵便などの方法で会員に提供することができます。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>弊社は、サービスの改善及び会員対象のサービスの紹介などを目的に、会員の同意の下でより詳しい個人情報を要求することができます。</td>
								</tr>
								<tr><td colspan="2"><p>第十七条 (広告掲載及びアドバタイザーとの取り引き)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社が会員にサービスを提供することができるようにするサービス投資基盤の一部は、広告掲載を通じた収益でまかなわれています。会員は、サービスの利用時に接することとなる広告の掲載に同意します。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>弊社では、サービスに掲載されている、もしくは本サービスを通じて行われるアドバタイザーの販促活動に会員が参加したり、もしくは交信・取引することで生じる損失や損害に対しては一切責任を負いません。</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第５章契約解約及び利用制限</strong></td></tr>
								<tr><td colspan="2">第１８条 (契約変更及び解約)</td></tr>
								<tr>
									<td colspan="2"><p>会員が利用契約を解約しようとする場合、会員本人が現代牙山のホームページの[ヘルプ] メニューを利用して加入解約を行います。 </p></td>
								</tr>
								<tr><td colspan="2"><p>第１９条 (サービス利用制限)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td><p>弊社は、会員がサービスを利用する内容において、本約款の第１１条の内容に違反したり、次の各号に該当する場合、サービスの利用を制限することができます。 <br />
									  - 美風良俗を害する卑俗なID及びニックネームを使用する場合 <br />
									  - 他の利用顧客にひどい侮辱を与えたり、サービスの利用を妨げる場合 <br />
									  - その他正常なサービス運営を妨げる場合 <br />
									  - 情報通信倫理委員会など、関連の公共機関の是正要求がある場合 <br />
									  - 3ヶ月以上サービスを利用したことがない場合 </p>
								  </td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>不良利用顧客処理規定に従い、上記の利用制限規定に該当するサービス利用者に対し、特別な告知なしにサービス利用の一時停止や初期化、利用契約の解約などの処置を取ることができます。</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第６章損害賠償及びその他の事項</strong></td></tr>
								<tr><td colspan="2"><p>第２０条 (損害賠償)</p></td></tr>
								<tr><td colspan="2"><p>弊社は、無料で提供されるサービスの利用に関連し、個人情報保護ポリシーで定められた内容に該当しない事項に関しては一切の損害も責任も負いません。 </p></td></tr>
								<tr><td colspan="2"><p>第２１条 (免責条項)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社は、天災地変や戦争及びその他これに準ずる不可抗力によってサービスを提供することができなくなった場合には、サービス提供に対する責任が免除されるものとします。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td><p>弊社は、基幹通信業者が電気通信サービスを中止したり、このサービスの正常な供給が行われずに損害が発生した場合にはその責任が免除されるものとします。 </p></td>
								</tr>
								<tr valign="top">
									<td>③</td>
									<td><p>弊社は、サービス用設備の補修・入れ替え・定期点検・工事などのやむを得ない事由で発生した損害に対する責任が免除されるものとします。 </p></td>
								</tr>
								<tr valign="top">
									<td>④</td>
									<td><p>弊社は、会員の帰責事由によるサービス利用の障害または損害に対して責任を負いません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑤</td>
									<td><p>弊社は、利用顧客のコンピューター利用上の失敗によって損害が発生した場合, または会員が個人情報及びメールアドレスを不実に記載して損害が発生した場合には責任を負いません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑥</td>
									<td><p>弊社は、会員がサービスを利用する際に、期待していた収益が得られないなどの不満、もしくは喪失した事物に対して責任を負いません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑦</td>
									<td><p>弊社は、会員がサービスを利用する際に得た資料による損害に対して責任を負いません。また、弊社は、会員がサービスを利用中に他の会員によって被る精神的・物質的被害に対して責任を負いません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑧</td>
									<td><p>弊社は、会員がサービスに掲載した各種情報や資料、事実のネーム・バリュー、正確性など、内容に対して責任を負いません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑨</td>
									<td><p>弊社は、利用顧客の相互間及び利用顧客と第三者の相互間に、サービスを媒介として発生した紛争に対して介入する義務、又これによる損害を賠償する責任がありません。 </p></td>
								</tr>
								<tr valign="top">
									<td>⑩</td>
									<td>弊社は、会員に無料で提供するサービスの利用に関してはいかなる損害も責任を負いません。</td>
								</tr>
								<tr><td colspan="2"><p>第２２条 (その他)</p></td></tr>
								<tr valign="top">
									<td>①</td>
									<td>弊社の定額サービス会員及びその他有料サービス利用会員の場合、弊社が別途に定めた約款及びポリシーによります。</td>
								</tr>
								<tr valign="top">
									<td>②</td>
									<td>サービスの利用によって発生した紛争に対して訴訟が申し立てられる場合、ソウル中央地方裁判所を管轄裁判所とします。</td>
								</tr>
								<tr>
									<td colspan="2"><p>&lt;付則&gt;</p></td>
								</tr>
								<tr>
									<td colspan="2"><p>(施行日) この約款は2005年11月01日より施行されます。2003年４月01日より施行された以前の約款は本約款に取り替えられます。 </p></td>
								</tr>
								</table>
</div>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="50"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0" align="center">
						<tr>
							<td align="left">
								<!-- 금강산관광  표준약관 --><!--
								<table width="169" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><img src="<%=imageServer%>/tour_img/footer/txt_agreement02.gif" align="absmiddle"><img src="<%=imageServer%>/tour_img/bu/ico_pdf.gif"  hspace="3" align="absmiddle"></td>
								</tr>
								<tr>
									<td class="tpad_10"><a href="javascript:savePds('금강산관광표준약관.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_footer_pdfdown.gif"></a></td>
								</tr>
								</table>--><!-- PDF다운로드 -->
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