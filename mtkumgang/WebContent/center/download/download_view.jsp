<%-- 
  - 작성자: 이소연
  - 일자: 2006.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>다운로드
--%>
<%@ page contentType="text/html;charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
String pageNum = "4";
String McNum = "6";
String sub = "4";
%> 
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="javascript">
 function savePds(val) {
     location.href="download.jsp?file="+val;
 }
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus03.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">고객센터</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">다운로드</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus03.jpg"></td></tr>
				<tr>
					<td valign="top">
						<!-- / download  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td width="232"><img src="<%=imageServer%>/tour_img/customer/desc_cus03_01.jpg"></td>
							<td width="458">
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td width="298">금강산 관광 안내서 ( PDF 파일 )</td>
									<td width="55"><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></td>
									<td width="95"><a href="javascript:savePds('금강산관광안내서.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/customer/desc_cus03_02.jpg"></td>
							<td>
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td width="298">금강산관광   전도 ( jpg 이미지 파일 )</td>
									<td width="55" rowspan="3"><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></td>
									<td width="95"><a href="javascript:savePds('금강산관광전도.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								<tr class="tpad_3">
									<td><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td>금강산 등산지도 ( jpg 이미지 파일 )</td>
									<td><a href="javascript:savePds('금강산등산지도.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif" vspace="1"></a></td>
								</tr>
								<tr class="tpad_3">
									<td><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></td>
									<td>고성항과 온정리 ( jpg 이미지 파일 )</td>
									<td><a href="javascript:savePds('고성항과온정리.jpg')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr>
							<td><img src="<%=imageServer%>/tour_img/customer/desc_cus03_03.jpg"></td>
							<td>
								<table width="458" cellpadding="0" cellspacing="0" border="0">
								<tr class="tpad_3">
									<td width="10"><p><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></p>
								    <p><img src="<%=imageServer%>/tour_img/bu/bu_purple_arw.gif" style="margin-bottom:3px;"></p></td>
									<td width="298"><p>금강산 관광 표준 약관 ( PDF 파일 )</p>
								    <p>금강산 관광 여행자보험 ( PDF 파일 )</p></td>
									<td width="55" rowspan="3"><p><img src="<%=imageServer%>/tour_img/customer/arw_download.gif"></p>								    </td>
									<td width="95"><p><a href="javascript:savePds('금강산관광표준약관.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></p>
								    <p><a href="javascript:savePds('여행자보험.pdf')"><img src="<%=imageServer%>/tour_img/btn/btn_download.gif"></a></p></td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="20" colspan="2"></td></tr>
						<tr><td height="1" class="line_g" colspan="2"></td></tr>
						</table>
						<!-- download / -->
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
        <%@ include file="../../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>