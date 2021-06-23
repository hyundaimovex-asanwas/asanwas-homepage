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
			<td height="165" colspan="2" valign="top"><img src="<%=imageServer%>/chn_img/footer/agreement_visual.jpg"></td>
			<td width="187" bgcolor="#FFFFFF"></td>
			<td bgcolor="#ffffff"></td>
		</tr>
		</table>		

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/chn_img/leftMenu82.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/footer/tit_footer02.gif"></td>
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
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/chn_img/footer/txt_agreement01.gif" style="margin:0 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:274px;overflow:auto;" class="div06">
								<table width="640" cellpadding="0" cellspacing="1" border="0">
								<tr><td colspan="2"><strong>第 1 章 总则 </strong></td></tr>
								<tr><td colspan="2">第1条(目的) </td></tr>
								<tr>
									<td colspan="2">此条约是现代峨山（株）提供的为规定网页服务(<a href="http://www.hdasan.com" target="_blank">www.hdasan.com</a>/<a href="http://www.mtkumgang.com" target="_blank">www.mtKumgang.com</a>)(以下简称为服务.)使用条件及程序事项和其它所需事项而指定的。 </td>
								</tr>
								<tr><td colspan="2">第 2条 (使用条约的效力及变更) </td></tr>
								<tr valign="top">
									<td width="15"></td>
									<td width="625">① 此条约公开服务菜单起产生效力。 </td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司只有在合理事由的情况下可变更此条约，一旦条约变更时要及时进行公告。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 利用会员制服务的顾客如若不同意变更的事项，要中断使用服务可取消使用合同。变更的条约发生效力后如若继续使用服务，被自动认为同意条约的变更事项。 </td>
								</tr>
								<tr><td colspan="2">第 3 条 (条约的准则) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 此条约同时适用于公司提供的关于个别服务使用指南（以下简称为个别服务指南）</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 对于此条约中没有明确规定的事项可根据相关法令及个别服务指南目的适用。 </td>
								</tr>
								<tr><td colspan="2">第 4 条 (用语定义) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 此条约中使用的用语定义如下所示.</td>
								</tr>
								<tr>
									<td></td>
									<td>1. '使用顾客'指使用会员制服务的用户。</td>
								</tr>
								<tr>
									<td></td>
									<td> 2. '使用合同'指关于使用服务事项公司和使用顾客之间签订的合同。</td>
								</tr>
								<tr>
									<td></td>
									<td>3. '用户号码(ID)'指为识别用户和使用用户服务，用户选定由公司赋予的文字和数字的组合。</td>
								</tr>
								<tr>
									<td></td>
									<td>4. '密码'指用户赋予的用户号码并确认用户是否一致，为保护用户的权益，由用户选定的文字和数字的组合。</td>
								</tr>
								<tr>
									<td></td>
									<td>5. '终端机'指为使用公司提供的服务，用户安装的个人用电脑及数据机。</td>
								</tr>
								<tr>
									<td></td>
									<td>6. '解除'指公司或者会员解除使用合同。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 此条约中使用的用语定义除第1条中规定的以外，其他根据相关法令及个别服务指南而定。. </td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第 2 章 签定使用合同 </strong></td></tr>
								<tr><td colspan="2">第 5 条 (使用合同的成立) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 使用合同以用户对本条约内容的同意和公司对使用申请的允许为基础而成立。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 关于对本使用条约的同意以申请使用时点击现代峨山网页的“同意”为基准</td>
								</tr>
								<tr><td colspan="2"> 第 6 条 (申请使用服务) s</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 加入会员使用本服务的用户需提供公司要求的全部信息（姓名，身份证，联系方法等）。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 所有会员一定要提供会员本人的姓名和身份证才可使用服务。如没用实名登录的用户，将无法主张一切权力。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 会员加入要求务必使用实名制，公司可实施实名确认措施</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 盗用他人名义(姓名或身份证申请服务的会员的所有ID将会被删除，根据相关法令会受到惩罚。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑤ 公司对于使用本服务的会员们实行级别制区分，细分使用时间，使用次数，服务菜单等划分级别。</td>
								</tr>
								<tr><td colspan="2">第 7 条 (个人信息的使用及保护) </td></tr>
								<tr>
									<td colspan="2">公司根据相关法令规定，为保护包括用户登录信息的用户个人信息会竭尽全力。关于用户个人信息的保护及使用适用相关法令及公司的个人信息保护证政策。但是，公司正式网页以外的连接的网页不适用公司的个人信息保护政策。除此以外，公司对于因用户失责而泄漏的信息将不会承担责任。</td>
								</tr>
								<tr><td colspan="2">第 8 条 (使用申请的允许及限制)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司根据第6条规定对使用申请的顾客，在业务或者技术上不存在问题时，原则性的按照先后顺序允许使用服务。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司对如下所示的事项不予许可。<br>
								- 不是实名或利用他人名义申请时<br>
								- 虚假填写使用合同申请书时<br>
								- 危害社会和平与秩序，有伤风败俗之嫌时<br>
								- 使用本服务其它不良目的时<br>
								- 以营利为目的使用本服务时<br>
								- 违反其他规定的全部事项申请时<br>
								- 与本服务具有竞争关系的用户申请时<br>
								- 违反其他规定的全部事项申请时<br></td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 公司在用户服务使用申请后，对下列所示的各项情况发生时会保留对申请的许可。<br>
									- 公司无设备时<br>
									- 公司技术上有障碍时<br>
									- 因其它事由引起使用许可困难时</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 使用申请顾客为相关法令规定的未成年人时，根据个别服务指南保留许可。</td>
								</tr>
								<tr><td colspan="2">第 9 条 (赋予及变更用户ID)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司根据条约规定赋予用户ID.</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 用户ID原则性不可变更，因不得以的事由需变更时，需取消相关ID重新加入会员。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 现代峨山的用户ID在用户本人的同意下可与现代峨山运营的自社网页的会员ID连接。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 用户ID在发生下列所示事由时，由用户或公司邀请进行更改。<br>
									- 用户ID使用用户的电话号码或者身份证登录有侵犯私生活的顾虑时<br>
									- 违反美俗，有伤大雅时<br>
									- 其它合理事由存在时</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑤用户负责管理服务用户ID及密码。因管理管理而发生的服务使用上的损失或者第三者非法使用等责任时，公司将不承担任何责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑥ 对于其它用户个人信息管理及变更事项，根据个别服务指南规定而定。</td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第 3 章 合同当事人的义务 </strong></td></tr>
								<tr><td colspan="2">第 10 条 (公司的义务) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司在没有特殊事由的情况下，要满足并提供用户的服务使用。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司为提供持续性，安全性地的服务，在设备发生故障时要迅速进行维修和处理。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 公司为保护个人信息构筑保安系统，遵守个人信息保护政策。</td>
								</tr>
								<tr><td colspan="2">第 11 条 (用户的义务)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 用户在加入会员申请或变更会员信息时，需用实名填写所有事项。登录虚假或他人信息时，将无权主张一切权力。 </td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 会员需遵守本条约规定的事项和其他公司规定的所有事宜，公告等公司通告事宜及相关法令。不可作出防碍其他公司业务或破坏公司名义的行为。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 会员需变更地址，联系方法，电子邮件等使用合同事项时，经过相关程序，需立即告知公司 </td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 公司根据相关法令及'个人信息保护政策'承担相关责任以外，对于因会员疏忽管理ID的密码而发生的所有结果不予承担责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑤ 会员不可未经公司同意使用服务进行营业活动, 对于因此发生的营业活动结果公司不承担责任。会员因上述营业活动造成公司损失时，会员具有赔偿公司损失的义务。公司根据服务使用限制及合法手续可向相关会员要求损失赔偿。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑥ 会员未经公司明文同意不可使用服务，或转让给他人使用合同上的地位，不可以此提供担保</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑦ 会员不可侵害公司或第三者的知识产权。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑧ 会员不可作出下列所示行为, 如有违反时公司将会根据会员服务使用限制及合法措施进行严厉制裁。<br>
									- 申请会员加入或变更会员信息时登录虚假内容<br>
									- 盗用其他用户的ID,密码, 身份证<br>
									- 与他人交易用户ID<br>
									- 冒称公司员工或关系人<br>
									- 未经公司许可变更公司顾客程序, 侵害公司伺服器，故意变更网页或公告信息<br>
									- 危害或故意妨碍服务使用<br>
									- 事前未经公司同意，不得复制，出版，向第三者提供通过本服务获得的资料或用于其它目的<br>
									- 传送，登载，发送的电子邮件，文章，图形，音像，录像中不得含有违反公共秩序及伤风败俗, 淫乱内容信息等<br>
									- 传送，登载，或发送电子邮件中含有侵犯他人名誉的侮辱性内容时<br>
									- 侵犯或威胁其他用户, 持续性地造成特定用户的痛苦或者不便利<br>
									- 未经公司许可，收集或保存其他用户的个人信息<br>
									- 客观地被判断为有犯罪嫌疑<br>
									- 违反包括本条约及其它公司规定的所有事项或者使用条件时<br>
									- 违反其他相关法令<br></td>
								</tr>

								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第 4 章 服务的使用</strong></td></tr>
								<tr><td colspan="2">第 12 条 (使用服务时间)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司业务或技术上没有特殊障碍时，年中午休息，每日二十四小时提供服务。但是，公司为定期检查系统，增加设备或交换设备时，可在规定的时间内临时中断服务，对于预期的临时中断服务，现代峨山会通过网页提前告知会员们</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司因紧急检查系统，增加设施或者交换设备等不得已理可临时中断服务，当公司判断需更新改善服务时，可完全中断当前提供的服务。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 因国家紧急状况，停电，服务设备故障或服务使用爆增等原因无法正常提供服务时，可限制或者停止一部分或者全部服务。但是，公司需事前或者事后公告发生以上情况的事由及时间 。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 公司因无法统制的事而中断服务（不存在系统管理者的故意，过失的硬件故障，系统死机）时事前无法进行通知，对于因他人(PC通信公司, 期间通信事业者等)故意，过失而发生的系统中断等情况将不做任何通知。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑤ 公司对服务范围进行划分，按照范围不同指定不同的使用时间。并对上述情况给予公告。</td>
								</tr>
								<tr><td colspan="2">第 13 条 (管理用户ID)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 会员拥有对用户ID和密码的所有管理责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司根据用户ID，执行管理所有用户业务。会员要求变更用户ID时，如若没有适当的理由，公司限制更改用户 ID. </td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 因登录的用户ID和密码而发生使用上的过失或因第三者非法使用发生的所有责任全部由使用顾客承担。</td>
								</tr>
								<tr><td colspan="2">第 14 条 (管理公告)</td></tr>
								<tr>
									<td colspan="2">公司对符合下列的刊登物及资料，无需事前通知可删除，移动或拒绝登载。<br>
									- 含有侮辱其他会员或第三者，造成他人名誉损失的内容时<br>
									- 包含违反公共秩序，伤风败俗的内容时<br>
									- 制造非法复制内容时<br>
									- 以营利为目的做广告时<br>
									- 客观地被判断为有犯罪嫌疑内容时<br>
									- 含有侵犯其他用户或第三者著作权等其他权利的内容时<br>
									- 违反公司规定的刊登原则，不符合刊登性质等内容<br>
									- 被判断为违反其他相关法令时<br></td>
								</tr>
								<tr><td colspan="2">第 15 条 (公告著作权)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 会员在服务画面内刊登的内容物的著作权归属会员。无刊登人的同意公司无权对刊登内容进行商业性的活动. 非营利目的时拥有服务内的刊登权。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 会员不可任意加工，销售使用服务所获得信息。无权对登载的资料进行商业性的活动。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 公司一旦判断会员公告或登录的服务内的内容物，登载内容符合第14条的各项规定时，可对此进行删除，移动或者拒绝登录。</td>
								</tr>
								<tr><td colspan="2">第 16 条 (信息的提供)</td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司利用邮件或者书信等方法向会员提供认为对会员有帮助的各种信息。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司为改善服务在会员的同意下可向会员要求追添的个人信息。</td>
								</tr>
								<tr><td colspan="2">第 17 条 (登载广告及与广告主的交易)</td></tr>
								<tr valign="top">
									<td></td>
									<td>①	公司通过刊登广告获得向会员们提供一部分服务的投资基础。会员使用服务时同意弹出的广告。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>②	公司对于会员们通过本服务参加广告主促销活动，进行交易而产生的损失和损害不承担任何责任。</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第 5 章 解除合同及使用限制</strong></td></tr>
								<tr><td colspan="2">第 18 条 (变更及解除合同)</td></tr>
								<tr>
									<td colspan="2">会员要求解除使用合同时会员本人可利用现代峨山网页内的[帮助]菜单解除加入。</td>
								</tr>
								<tr><td colspan="2">第 19 条 (使用服务限制) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司一旦发现会员使用服务内容存在违反本条约第 11条，或者存在下列内容时将会限制使用服务。<br>
									- 使用败化伤风的ID及别名时<br>
									- 使用污秽语言乱骂其它用户，或防碍服务使用时<br>
									- 防碍其它正常服务运营时<br>
									- 存有信息通信伦理委员会等相关公共机关的指正要求时<br>
									- 3个月以上未曾使用过服务<br></td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 根据上述使用限制规定，对于使用服务的会员无另行通知可根据不良用户处理规定采取停止使用服务，初级化，解除使用合同等措施。</td>
								</tr>
								<tr><td colspan="2" height="15"></td></tr>
								<tr><td colspan="2"><strong>第 6 章 损失赔偿其它事项 </strong></td></tr>
								<tr><td colspan="2">第 20 条 (损失赔偿)</td></tr>
								<tr><td colspan="2">公司对于提供的免费服务，不符合个人信息保护政策中所规定内容的所有事项将不会承担任何责任。</td></tr>
								<tr><td colspan="2">第 21 条 (免责条款) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司因天灾，战争及其他不可抗力不能提供服务时，将免除提供服务的责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 公司对于期间通信事业者停止电讯通信服务或不能正常提供服务时发生的损失，将不会承担任何责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>③ 公司对于服务用设备的保修，交换，定期检查，施工等不得以事由而发生的损失，将不予承担责任。 </td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>④ 公司对于因会员的失责事由引起的服务使用故障和损失，将不予承担责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑤ 公司对于因用户电脑故障而产生的损失，或者会员没有如实填写个人信息及电子邮件地址而发生的损失，不承担任何责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑥ 公司对于会员使用服务时没有得到预期的收益，将不承担责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑦ 公司对于会员使用服务获得资料而产生的损失，将不承担责任。公司对于会员因其它会员而承受的精神，物质上的损害，不承担补偿责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑧公司对于会员登载在服务上的各种信息，资料，事实的信任度，正确性等内容不承担责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑨ 公司不存在介入用户之间及用户和第三者之间因服务媒介而发生的纷争的义务，对于因此产生的损失也无赔偿责任。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>⑩ 关于公司向会员提供的免费使用服务而产生的任何损失，不予承担责任。</td>
								</tr>
								<tr><td colspan="2">第 22 条 (其它) </td></tr>
								<tr valign="top">
									<td></td>
									<td>① 公司的定额服务会员及其它收费服务使用会员要遵循额外规定的条约及政策。</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td>② 因使用服务而发生纠纷起诉时，由管辖首尔中央地方法院的法院进行处理。</td>
								</tr>
								<tr>
									<td colspan="2"><附录></td>
								</tr>
								<tr>
									<td colspan="2">(实行日) 此条约于 2005年 11月 01日起即时实施。2003年 4月 01日起实行的旧条约由此条约代替。</td>
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
								<!-- ݰ  ǥؾ --><!--
								<table width="169" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><img src="<%=imageServer%>/tour_img/footer/txt_agreement02.gif" align="absmiddle"><img src="<%=imageServer%>/tour_img/bu/ico_pdf.gif"  hspace="3" align="absmiddle"></td>
								</tr>
								<tr>
									<td class="tpad_10"><a href="javascript:savePds('ݰǥؾ.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_footer_pdfdown.gif"></a></td>
								</tr>
								</table>--><!-- PDFٿε -->
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