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
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/chn_img/start/tit_start03.gif"></td>
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
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="502">
								<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
								<tr><td colspan="2" valign="top" style="padding:11 0 0 0px;"><img src="<%=imageServer%>/chn_img/start/txt_start03.gif"></td></tr>
								<tr><td width="11" height="61"></td><td width="491"></td></tr>
								<tr><td colspan="2"><img src="<%=imageServer%>/chn_img/start/stit_start031.gif"></td></tr>
								<tr><td colspan="2" height="12"></td></tr>
								<tr>
									<td></td>
									<td><span class="style1">金刚山入出境过程类似于海外旅行。 </span></td>
								</tr>
								</table>
							</td>
							<td width="188"><img src="<%=imageServer%>/chn_img/start/img_top_start03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="685" cellpadding="0" cellspacing="0" border="0" style="margin-left:5px;">
						<tr><td></td><td><img src="<%=imageServer%>/chn_img/start/img_start031.jpg" width="674" height="142"></td></tr>
						<tr><td width="11" height="40"></td><td width="674"></td></tr>
						<tr><td colspan="2"><img src="<%=imageServer%>/chn_img/start/stit_start032.gif"></td></tr>
						<tr><td colspan="2" height="19"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0321.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">-身份证是能够证明本人的证件。类似于海外旅行，必须要携带身份证。<br>
							  -要携带居民身份证、驾驶证、护照中的任一证件。<br>
							  -持有永居权、市民权的人及外国人必须要携带护照。<br>
							  ※咨询电话 : 现代峨山高城事务所 (033)681-9400 </span></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0322.gif"></td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td><span class="style1">-到集合场所(花津浦峨山休息所)，可以领取观光所需的证件材料。<br>
							  -如果材料中的内容有误，请向观光组长解释。 </span></td>
						</tr>
						<tr><td colspan="2" height="17"></td></tr>
						<tr>
							<td></td>
							<td><img src="<%=imageServer%>/chn_img/start/stit_start0323.gif"></td>
						</tr>
						<tr><td colspan="2" height="8"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange style1">[出境所需材料]南部 -&gt; 金刚山 </td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/chn_img/start/img_start0321.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><span class="style1"><strong>金刚山观光券 </strong></span></td>
										</tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532"> 共发给公司保管用、回收用、游客用等三张。<span class="style1"></span></td>
										</tr>
										<tr valign="top">
											<td>- </td><td><span class="style1">标有宿舍及客房号以及班组名。 </span></td>
										</tr>
										</table>
									</td>
								</tr>
								<tr valign="top" class="bpad_15">
									<td><img src="<%=imageServer%>/chn_img/start/img_start0322.jpg"></td>
									<td>
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><span class="style1"><strong>观光证两张 </strong></span></td>
										</tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532"><span class="style1">发给原本和小本观光证各一本。</span></td>
										</tr>
										<tr valign="top">
											<td>- </td><td><span class="style1">相当于海外旅行中使用的护照。 </span></td>
										</tr>
										<tr valign="top">
											<td>- </td><td><span class="style1">损坏或丢失观光证，可将罚款，因此在旅行中要妥善保管。 </span></td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="12"></td></tr>
						<tr>
							<td></td>
							<td class="b txt_orange style1">[入境所需材料] 金刚山 –&gt; 南部 </td>
						</tr>
						<tr><td colspan="2" height="7"></td></tr>
						<tr>
							<td></td>
							<td>
								<table width="674" cellpadding="0" cellspacing="0" border="0">
								<tr valign="top" class="bpad_15">
									<td width="131"><img src="<%=imageServer%>/chn_img/start/img_start0324.jpg"></td>
									<td width="543" class="tpad_5">
										<table width="543" cellpadding="0" cellspacing="0" border="0">
										<tr><td colspan="2"><span class="style1"><strong>检疫质询单 </strong></span></td>
										</tr>
										<tr><td colspan="2" height="7"></td></tr>
										<tr valign="top">
											<td width="11">- </td><td width="532"><span class="style1">该单是保健福利部发行的调查单，通过调查可简化检疫法第9条规定的检疫调查。 </span></td>
										</tr>
										</table>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td colspan="2" height="25"></td></tr>
						<tr>
							<td colspan="2" align="right"><a href="javascript:;" onClick="fc_print();"><img src="<%=imageServer%>/chn_img/start/btn_start_print.gif" class="btn"></a><!-- μϱ --></td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
</div>				<!--  content / -->
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


</body>
</html>