<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> 금강산관광 </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/mypage/tour_mypage_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
			<%@ include file="../../include/mypage/tour_mypage_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">나의 예약정보</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" height="159" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td>
								<table cellpadding="0" cellspacing="0" border="0">
								<tr><td height="26"></td></tr>
								<tr><td height="108" valign="top"><img src="<%=imageServer%>/tour_img/mypage/txt_reservation.gif"></td></tr>
								<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/mypage/stit_reservation.gif" hspace="5"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/mypage/img_reservation.jpg"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / list table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="40"><col width="110"><col width="85"><col width="85">
						<col width="70"><col width="85"><col width="85"><col width="130">
						<tr><td height="2" colspan="8" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt18.gif"><!-- 신청서 번호--></td>
							<td><img src="<%=imageServer%>/tour_img/txt19.gif"><!-- 출발일 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt20.gif"><!-- 도착일 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt21.gif"><!-- 숙박일수 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt22.gif"><!-- 신청일시 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt23.gif"><!-- 예약상태 --></td>
							<td><img src="<%=imageServer%>/tour_img/txt24.gif"><!-- 결제 마감 일시 --></td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26">20</td>
							<td><a href="reservation_01.jsp" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">19</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">18</td>
							<td>990000-10000461</td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>예약취소</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">17</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">16</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">15</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">14</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">13</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>결제완료</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">12</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>미입금</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
						<tr align="center">
							<td height="26">11</td>
							<td><a href="#" class="listtxt07"><span class="txt_sky"><u>990000-10000461</u></span></a></td>
							<td>2006-06-01</td>
							<td>2006-06-03</td>
							<td>2박 3일</td>
							<td>2006-05-24</td>
							<td>미입금</td>
							<td>2006-05-26 08:00</td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						</table>
						<!-- list table / -->


						
						<!-- / list table - 예약내용없을때  -->
						<!--table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="2" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26">예약하신 정보가 없습니다.</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						</table-->
						<!-- list table - 예약내용없을때 / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_first.gif" align="absmiddle" hspace="1"></a><!--처음으로--><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_prev.gif" hspace="2" align="absmiddle"></a><!--이전-->&nbsp;&nbsp;<a href="#" class="paging">1</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><span class="pagingon">2</span><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">3</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">4</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">5</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">6</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">7</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">8</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">9</a><img src="<%=imageServer%>/tour_img/bu/paging_vline.gif" align="absmiddle" hspace="6"><a href="#" class="paging">10</a>&nbsp;&nbsp;<a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_next.gif" hspace="2" align="absmiddle"></a><!--다음--><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_last.gif" align="absmiddle" hspace="1"></a><!--마지막으로--></td>
						</tr>
						</table>
						<!-- paging/ -->
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