<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %> 
<% 
  String McNum = "0";
  String sub = "0";
%>
<html>
<head>
<title> 금강산관광   </title>
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
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td height="87" valign="top">
		<!-------- / top area -------->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td height="87" valign="top">
			<!-- top menu flash -->
              <script language="javascript">
                  show_flash_F("topFlash","<%=imageServer%>/tour_swf/topMenu1.swf?aaa=<%=aaa%>&bbb=<%=bbb%>","910","87","transparent","")
              </script>
            </td>
		</tr>
		<tr>
			<td height="165" valign="top">
				<!-- top flash -->
              <script language="javascript">
                  show_flash_F("topFlash15","<%=imageServer%>/tour_swf/topFlash15.swf","100%","165","transparent","")
              </script>
			</td>
		</tr>
		</table>		
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu86.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/footer/tit_footer06.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">사이트맵</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="36"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td width="250">
								<!-- / 금강산 알아보기 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/preview/intro.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_01.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/preview/intro.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0101.gif"></a><!-- 금강산 소개 --></td>
								</tr>
								<tr>
									<td><a href="/preview/story.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0102.gif"></a><!-- 관광의 역사 --></td>
								</tr>
								<tr>
									<td><a href="/preview/gallery/gallery_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0103.gif"></a><!-- 갤러리 --></td>
								</tr>
								<tr>
									<td><a href="/preview/pr_room/pr_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0104.gif"></a><!-- 홍보자료실 --></td>
								</tr>
								</table>
								<!-- 금강산 알아보기 / -->
							</td>
							<td width="250">
									<!-- / 에약안내 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/reservation/reservation_process.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_02.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/reservation/reservation_process.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0201.gif"></a><!-- 예약방법 --></td>
								</tr>
								<tr>
									<td><a href="/reservation/basic_goods_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0202.gif"></a><!-- 기본상품 --></td>
								</tr>
								<tr>
									<td><a href="/reservation/order_goods_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0203.gif"></a><!-- 맞춤상품 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0204.gif"></a><!-- 일정/견적 짜기 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0205.gif"></a><!--요금표  --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0206.gif"></a><!-- 대리점 안내 --></td>
								</tr>
								</table>
								<!-- 에약안내 / -->
							</td>
							<td width="140">
								<!-- / 출발안내 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/start/packup01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_03.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/start/packup01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0301.gif"></a><!-- 금강산 소개 --></td>
								</tr>
								<tr>
									<td><a href="/start/traffic.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0302.gif"></a><!-- 관광의 역사 --></td>
								</tr>
								<tr>
									<td><a href="/start/admission.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0303.gif"></a><!-- 갤러리 --></td>
								</tr>
								<tr>
									<td><a href="/start/keeping.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0304.gif"></a><!-- 홍보자료실 --></td>
								</tr>
								</table>
								<!-- 출발안내 / -->
							</td>
						</tr>
						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / 현지안내 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/guide/course/course01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_04.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/guide/course/course01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0401.gif"></a><!-- 코스안내 --></td>
								</tr>
								<tr>
									<td><a href="/guide/hotel/hotel01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0402.gif"></a><!-- 숙박안내 --></td>
								</tr>
								<tr>
									<td><a href="/guide/food/food01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0403.gif"></a><!-- 먹을거리 --></td>
								</tr>
								<tr>
									<td><a href="/guide/play/play01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0404.gif"></a><!-- 문화/놀이 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0405.gif"></a><!-- 쇼핑안내 --></td>
								</tr>
								<tr>
									<td><a href="#"><img src="<%=imageServer%>/tour_img/footer/sitemap_0406.gif"></a><!-- 기타안내 --></td>
								</tr>
								</table>
								<!-- 현지안내 / -->
							</td>
							<td>
									<!-- / 커뮤니티 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/cummunity/review/review_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_05.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/cummunity/review/review_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0501.gif"></a><!-- 여행후기 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0502.gif"></a><!-- 이벤트 --></td>
								</tr>
								<tr>
									<td><a href="/cummunity/praise/praise_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0503.gif"></a><!-- 칭찬하기 --></td>
								</tr>
								<tr>
									<td><a href="/cummunity/gallery/tour_gallery.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0504.gif"></a><!-- 회원갤러리 --></td>
								</tr>
								</table>
								<!-- 커뮤니티 / -->
							</td>
							<td>
								<!-- / 고객센터 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/center/question/question_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_06.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/center/question/question_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0601.gif"></a><!-- 자주 묻는 질문 --></td>
								</tr>
								<tr>
									<td><a href="/center/qna/qna_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0602.gif"></a><!-- 묻고 답하기 --></td>
								</tr>
								<tr>
									<td><a href="/center/download/download_view.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0603.gif"></a><!-- 다운로드 --></td>
								</tr>
								<tr>
									<td><a href="/utility/notice/notice_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0604.gif"></a><!-- 공지사항 --></td>
								</tr>								
								</table>
								<!-- 고객센터 / -->
							</td>
						</tr>

						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / 사이버투어 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_07.gif"></a></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0701.gif"></a><!-- 코스안내 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0702.gif"></a><!-- 숙박안내 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0703.gif"></a><!-- 먹을거리 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0704.gif"></a><!-- 문화/놀이 --></td>
								</tr>
								</table>
								<!-- 사이버투어 / -->
							</td>
							<td>
									<!-- / 관광가이드 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_08.gif"></a></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0801.gif"></a><!-- 예약하기 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0802.gif"></a><!-- 출발하기 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0803.gif"></a><!-- 여행하기 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0804.gif"></a><!-- 돌아오기 --></td>
								</tr>
								</table>
								<!-- 관광가이드 / -->
							</td>
							<td>
								<!-- / 온라인예약 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_09.gif"></a></td>
								</tr>
								</table>
								<!-- 온라인예약 / -->
							</td>
						</tr>

						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / 마이페이지 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/mypage/member/modify_register.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_10.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/mypage/member/modify_register.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1001.gif"></a><!-- 개인정보 수정 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_1002.gif"></a><!-- 나의 예약정보 --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_1003.gif"></a><!-- 나의 일정/견적 --></td>
								</tr>
								</table>
								<!-- 마이페이지 / -->
							</td>
							<td>
									<!-- / 관광가이드 -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/tour/baekdusan_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_11.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/tour/gaesung_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1102.gif"></a><!-- 개성 관광 --></td>
								</tr>								
								<tr>
									<td><a href="/tour/baekdusan_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1101.gif"></a><!-- 백두산 관광 --></td>
								</tr>
								</table>
								<!-- 관광가이드 / -->
							</td>
							<td></td>
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
        <%@ include file="footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>