<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/header.jsp" %>

<script>
<!--
function hold()
{
	alert("서비스 준비 중입니다.");
}
-->
</script>

<body leftmargin="0" topmargin="0" bgcolor="#FCFCF6">
<!---------- GNB AREA---------->
<%@ include file="/common/gnb.jsp" %>
<!---------- //GNB AREA---------->


<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
<tr valign="top">
	<td width="206">
		<!----- LEFT MENU----->
		<table border="0" cellpadding="0" cellspacing="0" height="100%" background="/img/common/menu_bg.gif">
		<tr>
			<td valign="top">
				<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" 	codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" 	width="206" height="522">
				<param name="movie" value="/swf/HA_subnavi_11.swf">
				<param name="quality" value="high">
				<param name="wmode" value="opaque">
				<embed src="/swf/HA_subnavi_11.swf" quality="high" 
				pluginspage="http://www.macromedia.com/go/getflashplayer" 
				type="application/x-shockwave-flash" 
				wmode="opaque"
				width="206" height="522"></embed>
				</object></td>
		</tr>
		<tr>
			<td valign="bottom"><%@ include file="/member/menu_member.jsp" %></td>
		</tr>
		</table>
		<!----- //LEFT MENU----->
	</td>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
		<tr valign="top">
			<td bgcolor="#E4E0C2" height="29">
				
				<!----- Navigrtion----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="29" background="/img/common/navi_bg.gif">
				<tr>
					<td align="right" class="navi"><a href="/">Home</a> / <font color="#4E4700">사이트맵</span></td>
				</tr>
				</table>
				<!----- //Navigrtion----->

			</td>
		</tr>
		<tr><td height="20"></td></tr>
		<tr valign="top">
			<td>
				<!----- Title----->
				<table border="0" cellpadding="0" cellspacing="0" width="644" background="/img/common/tit_bg.gif">
				<tr>
					<td width="10"><img src="/img/common/tit_left.gif"></td>
					<td><img src="/img/member/tit_04.gif"></td>
					<td align="right"><img src="/img/member/tit_img_01.gif"></td>
				</tr>
				</table>
				<!----- //Title----->

				<!----- 글자크기조정-->
				<%@ include file="/common/textsize.jsp" %>
				<!----- //글자크기조정-->
				<table border="0" cellpadding="0" cellspacing="0" width="644" height="30"><tr><td></td></tr></table>
				
				<table border="0" cellpadding="0" cellspacing="0" width="644">
				<tr>
					<td align="center">
					
					<!----- CONTENTS START----->	
					<table border="0" cellpadding="0" cellspacing="0" width="624">
					<col width="190"></col>
					<col width="27"></col>
					<col width="190"></col>
					<col width="27"></col>
					<col width="190"></col>
					<tr valign="top">
						<td>
							<!-- 회사소개-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><a href="javascript:goPage(page_1_0_0);" onFocus="blur()"><img src="/img/common/img_sitemap_01.gif"></a></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_1_0);"><b>개요</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_2_0);"><b>연혁</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_3_0);"><b>CEO</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_3_1);">- 인사말</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_3_2);">- 약력</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_3_3);">- 경영철학</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_3_4);">- CEO 동정</a></td>
									</tr>
									<!--tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_3_4);">- CEO 메세지</a></td>
									</tr-->
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_4_0);"><b>경영현황</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_4_1);">- 경영현황</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_4_2);">- 사업추진현황</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_5_0);"><b>인재상</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_6_0);" onClick="javascript:hold();"><b>채용</b></a></td>
									</tr>
									<!--tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_6_1);">- 채용공고 및 안내</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_6_2);">- 인사제도</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_6_3);">- 교육제도</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_6_4);">- 복리후생제도</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_6_5);">- 채용Q&A</a></td>
									</tr-->
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_7_0);"><b>조직도</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_8_0);"><b>CI</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_8_1);">- CI</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_1_8_2);">- BI</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_1_9_0);"><b>사업소위치</b></a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="10">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 회사소개-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" height="10"><tr><td></td></tr></table>

							<!-- 관광사업-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><a href="javascript:goPage(page_2_0_0);" onFocus="blur()"><img src="/img/common/img_sitemap_02.gif"></a></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_2_1_0);"><b>금강산</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_1_1);">- 관광안내</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_1_2);">- 개발계획</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_1_3);">- 투자안내</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_2_2_0);"><b>개성</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_2_1);">- 관광안내</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_2_3_0);"><b>백두산</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_3_1);">- 관광안내</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_2_4_0);"><b>기타</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_4_1);">- 평양</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_4_2);">- 묘향산</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_2_4_3);">- 칠보산</a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="74">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 관광사업-->

						</td>
						<td></td>
						<td>
							<!-- 개성공단-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><a href="javascript:goPage(page_3_0_0);" onFocus="blur()"><img src="/img/common/img_sitemap_03.gif"></a></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_1_0);"><b>개성공단발자취</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_1_1);">- 주요추진경과</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_1_2);">- 기록사진</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_1_3);">- 최근모습</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_2_0);"><b>공단조성현황</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_2_1);">- 공단1단계부지조성</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_2_2);">- 공단1단계기반시설</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_3_0);"><b>건축공사현황</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_3_1);">- 건축공사실적</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_3_2);">- 공장건축안내</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_3_3);">- 입주업체현황</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_4_0);"><b>건설지원현황</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_4_1);">- 개성사업소</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_4_2);">- 인력현황</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_4_3);">- 장비현황</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_4_4);">- 관련지원기관</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_4_5);">- 기타시설</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_5_0);"><b>개발총계획</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_1);">- 사업개요</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_2);">- 개발목표</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_3);">- 입지환경</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_4);">- 전체조감도</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_5);">- 개발총계획지표</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_6);">- 권역별개발계획</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_7);">- 구역별개발계획</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_8);">- 기반시설계획</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_9);">- 투자계획</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_5_10);">- 입주의향업체</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_6_0);"><b>개성출입지원</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_6_1);">- 출입수속</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_6_2);">- 물자반출입절차</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_6_3);">- 행사절차</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_6_4);">- 개성가는길</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_7_0);"><b>투자정보</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_7_1);">- 투자환경</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_7_2);">- 투자시참고사항</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_3_7_8);">- 상담절차</a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_3_8_0);"><b>자료실</b></a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="10">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 개성공단-->
						</td>
						<td></td>
						<td>
							<!-- 건설사업-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><a href="javascript:goPage(page_4_0_0);" onFocus="blur()"><img src="/img/common/img_sitemap_04.gif"></a></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_1_0);"><b>사업소개</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_2_0);"><b>금강산</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_3_0);"><b>개성공단</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_4_0);"><b>국내공사</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_5_0);"><b>조직및연락처</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_6_0);"><b>기술자보유현황</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_7_0);"><b>건설면허보유현황</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_4_8_0);"><b>건설장비보유현황</b></a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="174">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 건설사업-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" height="10"><tr><td></td></tr></table>

							<!-- 기타사업-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><a href="javascript:goPage(page_5_0_0);" onFocus="blur()"><img src="/img/common/img_sitemap_05.gif"></a></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_1_0);"><b>SOC개발사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_2_0);"><b>물류사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_3_0);"><b>교역사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_4_0);"><b>농업협력사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_5_0);"><b>용역서비스업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_6_0);"><b>알선ㆍ중개컨설팅사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_7_0);"><b>체육ㆍ문화교류사업</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_5_8_0);"><b>인도지원</b></a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="106">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 기타사업-->
						</td>
					</tr>

					<tr><td colspan="5" height="30"></td></tr>
					
					<tr valign="top">
						<td>
							<!-- 사이버홍보실-->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><img src="/img/common/img_sitemap_06.gif"></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_1_0);"><b>뉴스</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_2_0);"><b>보도자료</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_3_0);"><b>언론기사</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_4_0);"><b>뉴스레터</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_10_0);"><b>아산역사관</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_5_0);"><b>갤러리</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_6_0);"><b>웰페이퍼</b></a></td>
									</tr>
									<tr height="35">
										<td valign="top" style="padding-top:6"><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_7_0);"><b>미래를열어가는<br>현대아산人</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_6_8_0);"><b>자료실</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_1);">- 동영상</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_2);">- 이미지</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_3);">- 문서자료</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_4);">- 관련법규</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_5);">- 관련사이트</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_6_8_6);">- 기타</a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="10">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- 사이버홍보실-->

						</td>
						<td></td>
						<td>
							<!-- -->
							<table border="0" cellpadding="0" cellspacing="0" width="190" background="/img/common/box_190_bg.gif">
							<tr valign="top" height="40">
								<td><img src="/img/common/img_sitemap_07.gif"></td>
							</tr>
							<tr>
								<td align="center">
									<table border="0" cellpadding="0" cellspacing="0" width="164">
									<col width="10"></col>
									<col width="154"></col>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_7_1_0);"><b>공지사항</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_7_2_0);"><b>FAQ</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_7_3_0);"><b>고객문의</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_7_4_0);"><b>POLL</b></a></td>
									</tr>
									<tr height="20">
										<td><img src="/img/common/bl02.gif"></td>
										<td class="brown"><a href="javascript:goPage(page_7_5_0);"><b>이벤트</b></a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_7_5_1);">- 이벤트</a></td>
									</tr>
									<tr height="16">
										<td></td>
										<td class="brown11"><a href="javascript:goPage(page_7_5_2);">- 당첨자발표</a></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr valign="bottom" height="149">
								<td><img src="/img/common/box_190_bottom.gif"></td>
							</tr>
							</table>
							<!-- -->
						</td>
						<td></td>
						<td></td>
					</tr>
					</table>

					<!----- //CONTENTS END----->
					
					</td>
				</tr>
				</table>

			</td>
		</tr>
		<tr><td height="50"></td></tr>
		<tr><td height="10" bgcolor="#F1F1DB"></td></tr> <!--//하단 10픽셀라인//-->
		</table>
	</td>
</tr>
</table>

<!---------- FOOTER AREA---------->
<%@ include file="/common/footer.jsp" %>
<!---------- //FOOTER AREA---------->

<!----- Mt.Kumgang----->
<%@ include file="/common/mt_gumgang.jsp" %>
<!----- //Mt.Kumgang----->

<!----- Top----->
<%@ include file="/common/top.jsp" %>
<!----- //Top----->

</body>
</html>
