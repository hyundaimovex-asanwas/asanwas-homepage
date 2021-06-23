<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<% 
String McNum = "3";
String sub = "1";
String pageNum = "1";
String subNum = "";
%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript"> 
    function fc_print()
    { 
       //document.all.prt.style.display="none";
       var win = window.open("/common/blank.jsp","print","left=-10000,top=-10000,width="+ (document.all.print_area.offsetWidth + 18) + ",height="+document.all.print_area.offsetHeight);
       
       //document.all.prt.style.display = "";
       // window.print();
    } 
</script> 
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/start/tour_start_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../include/start/tour_start_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/start/tit_start01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">출발안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">짐꾸리기</span></td>
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
				<tr><td><img src="<%=imageServer%>/tour_img/start/img_top_start01.jpg"></td></tr>
				<tr><td height="10"></td></tr>
				<tr>
					<td>
						<!-- / 탭메뉴 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="102" height="28"><a href="packup01.jsp"><img src="<%=imageServer%>/tour_img/start/tab_start0101.gif" onmouseover="this.src='<%=imageServer%>/tour_img/start/tab_start0101_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/start/tab_start0101.gif'"></a></td>
							<td width="102"><img src="<%=imageServer%>/tour_img/start/tab_start0102_on.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0111.gif"></td>
							<td width="482" background="<%=imageServer%>/tour_img/start/tab_start0112.gif"></td>
							<td width="2"><img src="<%=imageServer%>/tour_img/start/tab_start0113.gif"></td>
						</tr>
						</table>
						<table width="690" class="bg_lgreen" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td  height="33" class="txt_dgreen tpad_10 bpad_10 lpad_25 rpad_10 lh20">
								① 10배율 이상의 쌍안경/망원경, 160미리 이상의 망원렌즈가 달린 사진기, 24배줌(광학기준) 이상의 줌렌즈가 달린<br>&nbsp;&nbsp;&nbsp;&nbsp;비디오카메라<br>
								② 개인의 치료목적을 위한 것을 제외한, 상표와 설명서가 없어 그 성분과 용도를 알 수 없는 약품 및 상품<br>
								③ 관광객의 문화생활 및 편의목적으로 인정되는 종류와 수량을 제외한 인쇄물, 그림, 글자판, 녹화테이프<br>
								④ 위조지폐<br>
								⑤ 의료목적을 위한 것을 제외한 독약, 마약, 그 밖의 유독성 화학물질<br>
								⑥ 무기, 총탄, 폭발물, 군용품, 흉기, 방사성물질, 인화물질<br>
								⑦ 무전기와 그 부속품<br>
								⑧ 전염병이 발생한 지역의 물건<br>
								⑨ 기타 관광에 적합하지 않는 물건
							</td>
						</tr>
						</table>
						<!-- 탭메뉴 / -->
					</td>
				</tr>
				<tr><td height="30"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr class="bpad_15" valign="top">
							<td width="135"><img src="<%=imageServer%>/tour_img/start/img_start0121.jpg" width="115" height="110"></td>
							<td width="555"><img src="<%=imageServer%>/tour_img/start/txt_start0121.gif" style="margin-top:2px;"></td>
						</tr>
						<tr class="bpad_15" valign="top">
							<td><img src="<%=imageServer%>/tour_img/start/img_start0122.jpg" width="115" height="110"></td>
							<td><img src="<%=imageServer%>/tour_img/start/txt_start0122.gif" style="margin-top:2px;"></td>
						</tr>
						<tr><td height="10" colspan="4"></td></tr>
						<tr>
							<td align="right" colspan="4"><a href="javascript:;" onclick="fc_print()"><img src="<%=imageServer%>/tour_img/btn/btn_start_print.gif" class="btn"></a><!-- 인쇄하기 --></td>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>