<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<% 
  String pageNum = "2";
  String McNum = "1";
  String sub = "2";  
%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
</head>
 
<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/preview/tour_preview_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../include/preview/tour_preview_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/preview/tit_preview02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">금강산 알아보기</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">관광의 역사</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="22"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/preview/txt_top_preview02.gif"></td></tr>
				<tr><td height="54"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="234"><img src="<%=imageServer%>/tour_img/preview/img_history01.jpg" width="215" height="117"></td>
							<td width="456"><img src="<%=imageServer%>/tour_img/preview/txt_history01.gif" style="margin-top:3px;"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/preview/img_history02.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/preview/txt_history02.gif" style="margin-top:14px;"></td>
						</tr>
						<tr><td colspan="2" height="20"></td></tr>
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/preview/img_history03.jpg" width="215" height="117"></td>
							<td><img src="<%=imageServer%>/tour_img/preview/txt_history03.gif" style="margin-top:14px;"></td>
						</tr>
						<tr><td colspan="2" height="45"></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="426">
								<table width="420" cellpadding="0" cellspacing="0" border="0">
								<tr><td colspan="5"><img src="<%=imageServer%>/tour_img/preview/txt_history00.gif"></td></tr>
								<tr><td colspan="5" height="45"></td></tr>
								<tr valign="top">
								  <td rowspan="2"><img src="<%=imageServer%>/tour_img/preview/2008.gif"></td>
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>05.28</strong></td>
								  <td>금강산골프장(아난티) 그랜드 오픈</td>
								  </tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>03.17</strong></td>
									<td>금강산 승용차 관광개시 </td>
								</tr>
								<tr valign="top">
								  <td rowspan="5"><img src="<%=imageServer%>/tour_img/preview/2007.gif"></td>
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>12.05</strong></td>
								  <td>개성관광 개시 </td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>10.04</strong></td>
								  <td>남북정상회담</td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>06.01</strong></td>
								  <td>내금강 관광 개시 </td>
								  </tr>
								<tr valign="top">
								  <td bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>05.28</strong></td>
								  <td>관광공사 금강산 면세점 그랜드 오픈 </td>
								  </tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>04.13</strong></td>
									<td>금강산 택시(스타랙스 1대) 투입 개시 </td>
								</tr>
								<tr valign="top">
								  <td width="95" rowspan="5"><img src="<%=imageServer%>/tour_img/preview/2006.gif"></td>
								  <td width="1" rowspan="5" bgcolor="#EDEDED"></td>
								  <td></td>
								  <td><strong>09.14</strong></td>
								  <td>금강산관광 항공이용 실시<br>
								    -제주항공 MOU 체결 </td>
								  </tr>
								<tr valign="top">
								  <td></td>
								  <td><strong>08.04</strong></td>
								  <td>정몽헌 회장님 추모음악회 개최 </td>
								  </tr>
								<tr valign="top">
									<td width="22"></td>
									<td width="62"><strong>07.17</strong></td>
									<td width="240">화진포아산휴계소, 외금강호텔 개관</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>05.27</strong></td>
									<td>내금강 관광코스 답사</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>04.28</strong></td>
									<td>제 24회 MBC 창작동요제</td>
								</tr>
								<tr valign="top">
									<td rowspan="7"><img src="<%=imageServer%>/tour_img/preview/2005.gif"></td>
									<td rowspan="7" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>10.04</strong></td>
									<td>제 86회 울산전국체전 성화채화</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>09.01</strong></td>
									<td>옥류관, 비치호텔, 온정각동관 개관</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>08.31</strong></td>
									<td>이산가족면회소 착공</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>07.17</strong></td>
									<td>현정은 회장 김정일 국방위원장 면담</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>06.08</strong></td>
									<td>‘금강산관광 100만명 돌파’ 기념 열린음악회</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>04.01</strong></td>
									<td>남북 신혼부부 나무심기 행사</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>02</strong></td>
									<td>영화 ‘간큰가족’ 촬영</td>
								</tr>
								<tr valign="top">
									<td rowspan="4"><img src="<%=imageServer%>/tour_img/preview/2004.gif"></td>
									<td rowspan="4" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>11.20</strong></td>
									<td>신계사 대웅전 낙성</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>11.19</strong></td>
									<td>금강산골프장 착공</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>09.07</strong></td>
									<td>충북전국체전 성화 채화</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>07.02</strong></td>
									<td>금강산호텔 개관</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2003.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>09</strong></td>
									<td style="padding-top:7px;">금강산 육로관광 실시</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2002.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>04~현재</strong></td>
									<td style="padding-top:7px;">제 4차 - 14차 남북 이산가족 상봉행사</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td><img src="<%=imageServer%>/tour_img/preview/2001.gif"></td>
									<td bgcolor="#EDEDED"></td>
									<td></td>
									<td style="padding-top:7px;"><strong>08.14</strong></td>
									<td style="padding-top:7px;">국제모터사이클 투어링 대회</td>
								</tr>
								<tr valign="top">
									<td rowspan="4"><img src="<%=imageServer%>/tour_img/preview/2000.gif"></td>
									<td rowspan="4" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>09.30</strong></td>
									<td>김정일 국방위원장 금강산 방문</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>06.15</strong></td>
									<td>남북 정상회담</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>05.24</strong></td>
									<td>고성항부두 준공</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>05.08</strong></td>
									<td>미스코리아 선발대회</td>
								</tr>
								<tr valign="top">
									<td rowspan="3"><img src="<%=imageServer%>/tour_img/preview/1998.gif"></td>
									<td rowspan="3" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>11.18</strong></td>
									<td>현대 금강호 첫 출항</td>
								</tr>
								<tr valign="top">
									<td></td>
									<td><strong>10.30</strong></td>
									<td>정주영 명예회장 김정일 국방위원장 면담</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>06.16</strong></td>
									<td>정주영 명예회장 소떼몰이 방북</td>
								</tr>
								<tr valign="top">
									<td rowspan="2"><img src="<%=imageServer%>/tour_img/preview/1989.gif"></td>
									<td rowspan="2" bgcolor="#EDEDED"></td>
									<td></td>
									<td><strong>01.31</strong></td>
									<td>금강산관광개발 의정서 체결(평양)</td>
								</tr>
								<tr valign="top" style="padding-bottom:27px;">
									<td></td>
									<td><strong>01.24</strong></td>
									<td>정주영 명예회장 첫 방북/금강산관광 및<br>시베리아 공동개발의정서 체결</td>
								</tr>
								</table>
							</td>
							<td width="264"><!-- 금강산사업하이라이트 flash -->
								<script language="javascript">
									f_id = "highlight";//플래시 아이디
									f_name ="<%=imageServer%>/tour_swf/highlight.swf"; //플래시 파일명
									f_width = "264";//가로크기
									f_height ="265"; //세로높이
									f_trans =""; //공백, transparent(투명)
									f_para =""; //파라미터
									show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
								</script></td>
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>