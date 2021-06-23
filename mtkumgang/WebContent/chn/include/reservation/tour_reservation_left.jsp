<script language="JavaScript" type="text/JavaScript">
function show_01()
{
	document.all("lst_01").style.display="";
	document.all("lst_02").style.display="none";
	document.all("lst_03").style.display="none";
	document.all("lst_04").style.display="none";
}


function show_02()
{
	document.all("lst_01").style.display="none";
	document.all("lst_02").style.display="";
	document.all("lst_03").style.display="none";
	document.all("lst_04").style.display="none";
}

function show_03()
{
	document.all("lst_01").style.display="none";
	document.all("lst_02").style.display="none";
	document.all("lst_03").style.display="";
	document.all("lst_04").style.display="none";	
}

function show_04()
{
	document.all("lst_01").style.display="none";
	document.all("lst_02").style.display="none";
	document.all("lst_03").style.display="none";
	document.all("lst_04").style.display="";	
}


</script>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td style="padding-bottom:11px;"><img src="<%=imageServer%>/chn_img/apply/leftmenu_title.gif"></td>
								</tr>
								<tr>
									<td><a href="http://test1.hdasan.com/chn/reservation/reservation_process.jsp"><img src="<%=imageServer%>/chn_img/apply/leftmenu_01.gif" onmouseover="this.src='<%=imageServer%>/chn_img/apply/leftmenu_01on.gif'" onmouseout="this.src='<%=imageServer%>/chn_img/apply/leftmenu_01.gif'" border="0"></a></td>
								</tr>
								<!--�޴�1_3deps start-->
								<tr>
								 <td><div style='display:none;' id='lst_01'></div>
									</td>
								</tr>
								<!--�޴�1_3deps end-->
								<tr>
									<td><a href="javascript:show_02();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02','','<%=imageServer%>/chn_img/apply/leftmenu_02on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02.gif" name="sub_02" border="0"></a></td>
								</tr>
								<!--�޴�2_3deps start-->
								<tr>
								 <td>
									 <div style='display:none;' id='lst_02'>
										<table cellpadding="0" cellspacing="0">
											<tr><td height="7" bgcolor="F4F4F4"></td></tr>
											<tr>
												<td><a href="http://test1.hdasan.com/chn/reservation/basic_goods_01.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02_1','','<%=imageServer%>/chn_img/apply/leftmenu_02_01on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02_01.gif" name="sub_02_1" border="0"></a></td>
											</tr>
											<tr>
												<td><a href="http://test1.hdasan.com/chn/reservation/basic_goods_01_1.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02_2','','<%=imageServer%>/chn_img/apply/leftmenu_02_02on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02_02.gif" name="sub_02_2" border="0"></a></td>
											</tr>
											<tr>
												<td><a href="http://test1.hdasan.com/chn/reservation/basic_goods_02.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02_3','','<%=imageServer%>/chn_img/apply/leftmenu_02_03on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02_03.gif" name="sub_02_3" border="0"></a></td>
											</tr>
											<tr>
												<td><a href="http://test1.hdasan.com/chn/reservation/basic_goods_03.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02_4','','<%=imageServer%>/chn_img/apply/leftmenu_02_04on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02_04.gif" name="sub_02_4" border="0"></a></td>
											</tr>
											<tr>
												<td><a href="http://test1.hdasan.com/chn/reservation/basic_goods_04.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('sub_02_5','','<%=imageServer%>/chn_img/apply/leftmenu_02_05on.gif',1)"><img src="<%=imageServer%>/chn_img/apply/leftmenu_02_05.gif" name="sub_02_5" border="0"></a></td>
											</tr>
											<tr><td height="9" bgcolor="F4F4F4"></td></tr>
										</table>
								  </div>
									</td>
								</tr>
								<!--�޴�2_3deps end-->
								<tr>
									<td><a href="http://test1.hdasan.com/chn/reservation/price/price_list.jsp"><img src="<%=imageServer%>/chn_img/apply/leftmenu_03.gif" onmouseover="this.src='<%=imageServer%>/chn_img/apply/leftmenu_03on.gif'" onmouseout="this.src='<%=imageServer%>/chn_img/apply/leftmenu_03.gif'" border="0"></a></td>
								</tr>
								<!--�޴�3_3deps start-->
								<tr>
								 <td>
									 <div style='display:none;' id='lst_03'></div>
									</td>
								</tr>
								<!--�޴�3_3deps end-->
								<tr>
									<td><a href="http://test1.hdasan.com/chn/reservation/agent/agent_list.jsp"><img src="<%=imageServer%>/chn_img/apply/leftmenu_04.gif" onmouseover="this.src='<%=imageServer%>/chn_img/apply/leftmenu_04on.gif'" onmouseout="this.src='<%=imageServer%>/chn_img/apply/leftmenu_04.gif'" border="0"></a></td>
								</tr>
								<!--�޴�4_3deps start-->
								<!--�޴�4_3deps end-->
								<tr>
								 <td> <div style='display:none;' id='lst_04'></div>
									
									</td>
								</tr>
							</table>