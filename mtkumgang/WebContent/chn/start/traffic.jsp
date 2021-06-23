<%@ page language="java" contentType="text/html; charset=utf-8"%> 
<%@ include file="/common/properties_utf8.jsp" %> 
<%@ include file="/common/session_utf8.jsp" %>
<%  
String pageNum = "1";
String subNum = "1";
String McNum = "4";
String sub = "1";
%>
<html>
<head>
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
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
        <%@ include file="/chn/include/start/tour_start_top_utf8.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/start/tour_start_left_utf8.jsp" %>
            <!--  left menu flash -->			
			</td>
			<td>
				<!-- / content  -->
<p>				
			  <table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/start/tit_start02.gif"></td>
						<td align="right" class="linemap"></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
			  </table>
<DIV id="print_area" class=newpage style="width:690">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="20"></td></tr>
				<tr><td><img src="<%=imageServer%>/chn_img/start/img_top_start02.jpg"></td></tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr>
							<td width="11" height="40"></td>
							<td width="674"></td>
						</tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/chn_img/start/stit_start021.gif"></td></tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">花津浦峨山休息所是进入金刚山的团队集合场所，到集合场所可以办理售票手续。 </span> </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0211.gif"><!-- ൵ --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">- 集合场所 : 花津浦峨山休息所<br>
							  - 地址 : 江原道 高城郡 县内面 草岛里 山28号<br>
							  - 集合相关咨询服务 : 现代峨山高城事务所 (033)681-9400 </span></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/img_map_start02.jpg" width="674" height="416" border="0" usemap="#Map"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0212.gif"><!-- ž ӽð --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">- 3天2日 : 13:00<br>
							  - 2天1日(8点出发) : 06:00<br>
							  - 当天 : 06:00 <br>
							  ※要赶上乘车手续办理时间，并要配合有关工作人员的安排。  </span></td>
						</tr>
						<tr><td colspan="2" height="47"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/chn_img/start/stit_start022.gif"></td></tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0221.gif"><!--  ̿   ��� --></td>
						</tr>
						<tr><td colspan="2" height="10"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">车可以免费停到花津浦峨山休息所，要准备花津浦峨山休息所到南部入出境事务所的往返车费。 </span></td>
						</tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" bgcolor="#F6F6F6" cellpadding="0" cellspacing="0" border="0">
								<tr><td height="15"></td></tr>
								<tr>
									<td align="center">
										<table width="640" cellpadding="0" cellspacing="0" border="0">
										<tr valign="top">
											<td width="9"><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td width="631"><span class="style1">出发首尔 – 八堂大桥 – 杨平 – 洪川 – 麟蹄(44号) – 元通 – 龙大三叉路口 – 陈富岭 – 直往杆城方向 – 统一展望台外路(7号国道) – 到达花津浦峨山休息所 </span></td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td><span class="style1">出发首尔 – 华克山庄 – 九里市 – 加平 – 春川 – 中央高速公路 – 洪川 – 麟蹄 – 龙大里 - 陈富岭 – 直往杆城方向 – 统一展望台外路(7号国道) – 到达花津浦峨山休息所 </span></td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td><span class="style1">岭东高速公路 – 原州 –中央高速公路 – 洪川 – 麟蹄 – 龙大里 - 陈富岭 – 直往杆城方向 – 统一展望台外路(7号国道) – 到达花津浦峨山休息所 </span></td>
										</tr>
										<tr valign="top" class="tpad_5">
											<td><img src="<%=imageServer%>/tour_img/bu/bu_gray_arw.gif" vspace="4"></td>
											<td><span class="style1">岭东高速公路 – 江陵 – 注文津 – 束草 – 直往杆城方向 – 统一展望台外路(7号国道) – 到达花津浦峨山休息所</span></td>
										</tr>
										</table>
									</td>
								</tr>
								<tr><td height="15"></td></tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0222.gif"><!-- ü ̿ ���   --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td><p class="style1">在居住地团体包车到集合地点的游客至少在5天前向代理处通报客车车牌号及乘坐人数等。<br>
							  ※要通过民控线检查所，应将车牌号事前通报给管辖军区。 </p>
							  </td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0223.gif"><!--  ̿ ���() --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">为了给游客提供方便，观光客车在不同地区开往到出发地(南部入出境事务所)，请参考以下客运公司路线后预约。 </span></td>
						</tr>
						<tr><td colspan="2" height="27"></td></tr>
						<tr>
							<td></td>
							<td height="27" valign="top">- <span class="style1"><strong>各地区指定客车运行现况(金刚山观光) </strong></span></td>
						</tr>
						<tr>
							<td></td>
							
                        <td valign="top"> <table width="674" cellpadding="1" cellspacing="1" border="0" class="tabline">
                            <tr> 
                              <td width="38" height="26" align="center" class="bg_white style1">区间 </td>
                              <td width="34" align="center" class="bg_white style1">地区 </td>
                              <td width="37" align="center" class="bg_white style1">地区</td>
                              <td width="65" align="center" class="bg_white style1">客运公司 </td>
                              <td width="57" align="center" class="bg_white style1">联系电话 </td>
                              <td width="33" align="center" class="bg_white style1">出发时间 </td>
                              <td width="250" align="center" class="bg_white style1">出发地 </td>
                              <td width="72" align="center" class="bg_white style1">往返费用 </td>
                              <td width="60" align="center" class="bg_white">简图 </td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white style1">2天1宿 (11点) </td>
                              <td rowspan="2" align="center" class="bg_white b style1">首尔</td>
                              <td rowspan="2" align="center" class="bg_white style1">每天 </td>
                              <td rowspan="2" align="center" class="bg_white style1">大化观光 </td>
                              <td rowspan="2" align="left" class="bg_white lpad_10 style1">02)<br>
                                764-2255</td>
                              <td height="26" align="center" class="bg_white style1">05:50</td>
                              <td align="left" class="bg_white lpad_5 style1">光化门十字路口往西大门方向70m处国民银行前 </td>
                              <td rowspan="2" align="center" class="bg_white"><span class="style1"><font color="#459E9D">30,000韩元/人 </font></span></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">06:20</td>
                              <td align="left" class="bg_white lpad_5 style1">综合运动场6号出口 GS小麦店前 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="2" align="center" class="bg_white style1">2天1宿 (8点) 当天 </td>
                              <td rowspan="2" align="center" class="bg_white b style1">首尔 </td>
                              <td rowspan="2" align="center" class="bg_white style1"><b></b>周二周五周六周二:当天(周三)观光周五:当天/2天1宿(周六)观光周六:当天(周日)观光 </td>
                              <td rowspan="2" align="center" class="bg_white style1"><p>大元观光 </p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/chn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10 style1">02)<br>
                                458-4514</td>
                              <td height="217" align="center" class="bg_white style1">20:00</td>
                              <td align="left" class="bg_white lpad_5 style1">光化门十字路口往西大门方向70m处国民银行前  <br> 
                              <img src="<%=imageServer%>/chn_img/start/date01.gif" width="234" height="219">                              </td>
                              <td rowspan="2" align="center" class="bg_white"><span class="style1"><font color="#459E9D">40,000韩元/人 (20,000韩元 单程) </font></span></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="201" class="bg_white style1">20:30</td>
                              <td align="left" class="bg_white lpad_5 style1">综合运动场6号出口 GS小麦店前<br> 
                              <img src="<%=imageServer%>/chn_img/start/date02.gif" width="234" height="219">                              </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr> 
                              <td rowspan="15" align="center" class="bg_white style1">1 night2 days(8 O'clock)One day</td>
                              <td rowspan="4" align="center" class="bg_white b style1">首尔 </td>
                              <td rowspan="4" align="center" class="bg_white style1">每天 </td>
                              <td rowspan="2" align="center" class="bg_white style1"><p>大化观光 </p>
                                <p><a href="http://www.daehwatour.co.kr/" target="_blank"><img src="<%=imageServer%>/chn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10 style1">02)<br>
                                733-0017</td>
                              <td height="26" align="center" class="bg_white style1">08:30</td>
                              <td align="left" class="bg_white lpad_5 style1">桂洞现代办公大楼体育中心前 </td>
                              <td rowspan="4" align="center" class="bg_white"><span class="style1"><font color="#459E9D">30,000韩元/人 </font></span></td>
                              <td align="center" class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gaedong.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">08:45</td>
                              <td align="left" class="bg_white lpad_5 style1">光化门十字路口往西大门方向70m处国民银行前 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_gwanghwa.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td rowspan="2" class="bg_white style1"><p>大元观光 </p>
                                <p><a href="http://www.buspia.co.kr/Shuttle/GuemGang/DetailMain.asp?cat1no=5&cat2no=8&cat3no=16&shType=2&idx=18&mode=1" target="_blank"><img src="<%=imageServer%>/chn_img/start/btn_online.gif" width="57" height="44" border="0"></a></p></td>
                              <td rowspan="2" align="left" class="bg_white lpad_10 style1"><p>02)<br>
                                  458-4514</p>
                                02)458-4550</td>
                              <td height="26" class="bg_white style1">08:30</td>
                              <td align="left" class="bg_white lpad_5 style1">鸭鸥亭现代百货公司停车场 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_apgujung.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">09:00</td>
                              <td align="left" class="bg_white lpad_5 style1">综合运动场6号出口 GS小麦店前 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_jamsil.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td rowspan="4" class="bg_white b style1">大田 </td>
                              <td rowspan="4" class="bg_white style1">周一, 周三,<br>
                              周五 </td>
                              <td rowspan="4" class="bg_white style1">东仙观光 </td>
                              <td rowspan="4" align="left" class="bg_white lpad_10 style1">1544-5980</td>
                              <td height="26" class="bg_white style1">06:30</td>
                              <td align="left" class="bg_white lpad_5 style1">西大田站出租车乘车场前 </td>
                              <td class="bg_white" rowspan="4"><span class="style1"><font color="#459E9D">50,000韩元 /成人,大学生 40,000韩元 /初高中生 30,000韩元/小学生 以下 </font></span></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">06:50</td>
                              <td align="left" class="bg_white lpad_5 style1">大田站东广场东侧出口停车场前 </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">07:30</td>
                              <td align="left" class="bg_white lpad_5 style1">西清州通行收费站前 </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">08:00</td>
                              <td align="left" class="bg_white lpad_5 style1">天安通行收费站相遇之广场前 </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td rowspan="4" class="bg_white b style1">岭南 </td>
                              <td rowspan="4" class="bg_white style1">周三,周五 </td>
                              <td rowspan="4" class="bg_white style1">新釜山 观光旅行 </td>
                              <td rowspan="4" align="left" class="bg_white lpad_10 style1">051)<br>
                                851-0600</td>
                              <td height="26" class="bg_white style1">05:50</td>
                              <td align="left" class="bg_white lpad_5 style1">西面环行交叉路KT邮政局侧新韩银行前 </td>
                              <td class="bg_white" rowspan="2"><span class="style1"><font color="#459E9D">70,000韩元/人   
                              </font></span></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">06:10</td>
                              <td align="left" class="bg_white lpad_5 style1">东莱地铁共营停车场前 </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">07:10</td>
                              <td align="left" class="bg_white lpad_5 style1">庆州通行收费站相遇之广场休息所 </td>
                              <td class="bg_white" rowspan="2"><span class="style1"><font color="#459E9D">60,000韩元/人 </font></span></td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_goungjutol.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">08:10</td>
                              <td align="left" class="bg_white lpad_5 style1">东大邱通行收费站前 </td>
                              <td class="bg_white"><a href="javascript:;" onClick="window.open ('popup_map_dongdaegu.jsp', 'movieview', 'width=500,height=500,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');"><img src="<%=imageServer%>/chn_img/start/btn_s_view.gif"></a> 
                                <!--  -->                              </td>
                            </tr>
                            <tr align="center"> 
                              <td rowspan="3" class="bg_white b style1">湖南 </td>
                              <td rowspan="3" class="bg_white style1">周三,周五 </td>
                              <td rowspan="3" class="bg_white style1">松光观光 客运 </td>
                              <td rowspan="3" align="left" class="bg_white lpad_10 style1">062)<br>
                                383-1133</td>
                              <td height="26" class="bg_white style1">05:00</td>
                              <td align="left" class="bg_white lpad_5 style1">光州尚武地区松光旅行社前 </td>
                              <td class="bg_white" rowspan="3"><span class="style1"><font color="#459E9D">60,000韩元/人 </font></span></td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">06:00</td>
                              <td align="left" class="bg_white lpad_5 style1"> 井邑 井邑IC (湖南高速公路) </td>
                              <td class="bg_white"></td>
                            </tr>
                            <tr align="center"> 
                              <td height="26" class="bg_white style1">06:50</td>
                              <td align="left" class="bg_white lpad_5 style1">全州世界杯体育场停车场 </td>
                              <td class="bg_white"></td>
                            </tr>
                          </table></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr align="right">
						  <td height="17" colspan="2">&nbsp;</td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
						  <tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0224.gif"><!-- ߱ ̿���  --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td><span class="style1">长途客车 : 在东首尔客运站、上凤客运站乘坐开往杆城(高城)方向的客车，然后在杆城、大津换乘1号或1-1号市内公汽到达集合场所(花津浦峨山休息所)。 </span></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0225.gif"><!-- ӹ ̿��� --></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							
                        <td><span class="style1">在首尔江南高速客运站乘坐开往束草的高速客车，然后换乘开往统一展望台的长途客车到杆城(高城)下车，再换乘市内公汽到达集合场所(花津浦峨山休息所)。 </span></td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/chn_img/start/btn_start_print.gif" class="btn"></a><!-- μϱ --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			  </div>
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
        <%@ include file="/chn/include/footer_utf8.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


<map name="Map">
  <area shape="rect" coords="67,210,170,226" href="http://www.dcffood.co.kr/07business_03.html" target="_blank" onFocus="this.blur()">
</map>
</body>
</html>