<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %> 
<%@ include file="/common/session.jsp" %> 
<% 
  String McNum = "0";
  String sub = "0";
%>
<html>
<head>
<title> �ݰ������   </title>
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
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">����Ʈ��</span></td>
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
								<!-- / �ݰ��� �˾ƺ��� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/preview/intro.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_01.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/preview/intro.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0101.gif"></a><!-- �ݰ��� �Ұ� --></td>
								</tr>
								<tr>
									<td><a href="/preview/story.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0102.gif"></a><!-- ������ ���� --></td>
								</tr>
								<tr>
									<td><a href="/preview/gallery/gallery_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0103.gif"></a><!-- ������ --></td>
								</tr>
								<tr>
									<td><a href="/preview/pr_room/pr_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0104.gif"></a><!-- ȫ���ڷ�� --></td>
								</tr>
								</table>
								<!-- �ݰ��� �˾ƺ��� / -->
							</td>
							<td width="250">
									<!-- / ����ȳ� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/reservation/reservation_process.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_02.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/reservation/reservation_process.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0201.gif"></a><!-- ������ --></td>
								</tr>
								<tr>
									<td><a href="/reservation/basic_goods_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0202.gif"></a><!-- �⺻��ǰ --></td>
								</tr>
								<tr>
									<td><a href="/reservation/order_goods_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0203.gif"></a><!-- �����ǰ --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0204.gif"></a><!-- ����/���� ¥�� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0205.gif"></a><!--���ǥ  --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0206.gif"></a><!-- �븮�� �ȳ� --></td>
								</tr>
								</table>
								<!-- ����ȳ� / -->
							</td>
							<td width="140">
								<!-- / ��߾ȳ� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/start/packup01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_03.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/start/packup01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0301.gif"></a><!-- �ݰ��� �Ұ� --></td>
								</tr>
								<tr>
									<td><a href="/start/traffic.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0302.gif"></a><!-- ������ ���� --></td>
								</tr>
								<tr>
									<td><a href="/start/admission.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0303.gif"></a><!-- ������ --></td>
								</tr>
								<tr>
									<td><a href="/start/keeping.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0304.gif"></a><!-- ȫ���ڷ�� --></td>
								</tr>
								</table>
								<!-- ��߾ȳ� / -->
							</td>
						</tr>
						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / �����ȳ� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/guide/course/course01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_04.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/guide/course/course01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0401.gif"></a><!-- �ڽ��ȳ� --></td>
								</tr>
								<tr>
									<td><a href="/guide/hotel/hotel01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0402.gif"></a><!-- ���ھȳ� --></td>
								</tr>
								<tr>
									<td><a href="/guide/food/food01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0403.gif"></a><!-- �����Ÿ� --></td>
								</tr>
								<tr>
									<td><a href="/guide/play/play01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0404.gif"></a><!-- ��ȭ/���� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0405.gif"></a><!-- ���ξȳ� --></td>
								</tr>
								<tr>
									<td><a href="#"><img src="<%=imageServer%>/tour_img/footer/sitemap_0406.gif"></a><!-- ��Ÿ�ȳ� --></td>
								</tr>
								</table>
								<!-- �����ȳ� / -->
							</td>
							<td>
									<!-- / Ŀ�´�Ƽ -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/cummunity/review/review_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_05.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/cummunity/review/review_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0501.gif"></a><!-- �����ı� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_0502.gif"></a><!-- �̺�Ʈ --></td>
								</tr>
								<tr>
									<td><a href="/cummunity/praise/praise_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0503.gif"></a><!-- Ī���ϱ� --></td>
								</tr>
								<tr>
									<td><a href="/cummunity/gallery/tour_gallery.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0504.gif"></a><!-- ȸ�������� --></td>
								</tr>
								</table>
								<!-- Ŀ�´�Ƽ / -->
							</td>
							<td>
								<!-- / ������ -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/center/question/question_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_06.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/center/question/question_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0601.gif"></a><!-- ���� ���� ���� --></td>
								</tr>
								<tr>
									<td><a href="/center/qna/qna_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0602.gif"></a><!-- ���� ���ϱ� --></td>
								</tr>
								<tr>
									<td><a href="/center/download/download_view.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0603.gif"></a><!-- �ٿ�ε� --></td>
								</tr>
								<tr>
									<td><a href="/utility/notice/notice_list.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_0604.gif"></a><!-- �������� --></td>
								</tr>								
								</table>
								<!-- ������ / -->
							</td>
						</tr>

						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / ���̹����� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_07.gif"></a></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0701.gif"></a><!-- �ڽ��ȳ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0702.gif"></a><!-- ���ھȳ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0703.gif"></a><!-- �����Ÿ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi03();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0704.gif"></a><!-- ��ȭ/���� --></td>
								</tr>
								</table>
								<!-- ���̹����� / -->
							</td>
							<td>
									<!-- / �������̵� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_08.gif"></a></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0801.gif"></a><!-- �����ϱ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0802.gif"></a><!-- ����ϱ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0803.gif"></a><!-- �����ϱ� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onclick="javascript:Q_navi04();"><img src="<%=imageServer%>/tour_img/footer/sitemap_0804.gif"></a><!-- ���ƿ��� --></td>
								</tr>
								</table>
								<!-- �������̵� / -->
							</td>
							<td>
								<!-- / �¶��ο��� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_09.gif"></a></td>
								</tr>
								</table>
								<!-- �¶��ο��� / -->
							</td>
						</tr>

						<tr><td height="30" colspan="3"></td></tr>
						<tr valign="top">
							<td>
								<!-- / ���������� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/mypage/member/modify_register.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_10.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/mypage/member/modify_register.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1001.gif"></a><!-- �������� ���� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_1002.gif"></a><!-- ���� �������� --></td>
								</tr>
								<tr>
									<td><a href="javascript:;" onClick="javascript:alert('�غ� �� �Դϴ�.');"><img src="<%=imageServer%>/tour_img/footer/sitemap_1003.gif"></a><!-- ���� ����/���� --></td>
								</tr>
								</table>
								<!-- ���������� / -->
							</td>
							<td>
									<!-- / �������̵� -->
								<table width="140" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><a href="/tour/baekdusan_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_11.gif"></a></td>
								</tr>
								<tr>
									<td><a href="/tour/gaesung_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1102.gif"></a><!-- ���� ���� --></td>
								</tr>								
								<tr>
									<td><a href="/tour/baekdusan_01.jsp"><img src="<%=imageServer%>/tour_img/footer/sitemap_1101.gif"></a><!-- ��λ� ���� --></td>
								</tr>
								</table>
								<!-- �������̵� / -->
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