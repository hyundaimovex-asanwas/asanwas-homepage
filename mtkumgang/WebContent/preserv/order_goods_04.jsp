<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
  String McNum = "2";
  String sub = "3";
  String pageNum = "3";
  String subNum = "4";
%>
<%
  String reviewType = "04"; //산악등산관광
  String returnUrl = "order_goods_04.jsp"; 
%>
<%
    String dateview = ParamUtil.getReqParameter(request.getParameter("dateview"),"1");
%>
<html>
<head>
<title> 금강산관광  </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/maplink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript">
function chk(){
	var obj = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		//alert("로그인이 필요한 서비스입니다.");
		popLogin();
		return;
	}	

	if(obj.content.value == "" || obj.content.value =="의견은 500자 이내로 등록 할 수 있으며 로그인 후 이용하시기 바랍니다."){
		alert("내용을 입력하세요.");
		obj.content.value="";
		obj.content.focus();
		return;
	}

	obj.cmd.value = "insert";

	obj.submit();
}

function del(idx){
	if(confirm("삭제하시겠습니까?")){
		var obj = document.f1;
		obj.board_seq.value = idx;
		obj.cmd.value = "del";

		obj.submit();
	}
}

function clearText(thefield){
    if (thefield.defaultValue==thefield.value)
        thefield.value = ""
}


function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}
 
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
		    <%@ include file="../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app34.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app05.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">맞춤상품</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">산악/등산관광</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr>
					<td colspan="2">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr valign="top">
							<td><img src="<%=imageServer%>/tour_img/apply/top_txt_app34.gif" style="margin-top:12px;"></td>
							<td align="right"><img src="<%=imageServer%>/tour_img/apply/img_top_app03.jpg"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="8"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="29"><img src="<%=imageServer%>/tour_img/apply/stit_app0301.gif"></td></tr>
						<tr>
							<td valign="top" height="261"><img src="<%=imageServer%>/tour_img/apply/img_order41.jpg" width="269" height="246" id="limg"></td>
						</tr>
						<tr>
							<td><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order41.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s41.jpg" width="83" height="48"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order42.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s42.jpg" width="83" height="48" style="margin-left:10px;"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/img_order43.jpg'"><img src="<%=imageServer%>/tour_img/apply/img_order_s43.jpg" width="83" height="48" style="margin-left:10px;"></a></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="29" colspan="4" valign="top" align="right"><a href="#01"><img src="<%=imageServer%>/tour_img/apply/tab_order01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order01.gif'" class="btn"></a><a href="#03"><img src="<%=imageServer%>/tour_img/apply/tab_order03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order03.gif'"></a></td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="2"></td></tr>
						<tr>
							<td height="29" colspan="3" width="97"><img src="<%=imageServer%>/tour_img/apply/txt_order01.gif"><!-- 출발일 --></td>
							<td width="293">매일</td> 
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order02.gif"><!-- 여행기간 --></td>
							<td><strong>2박 3일</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order05.gif"><!-- 최소출발인원 --></td>
							<td><strong>최소 30명이상</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="172" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- 상품소개 --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>천하제일명산 금강산은 말 그대로 사시사철 최고의 모습만을 보여줍니다. 그 중에서도 세존봉-동석동코스는 금강산의 절경만을 한곳에 모아둔 것처럼 하늘의 선택을 받은 코스입니다.<br>8시간의 대장정 뒤에 세존봉전망대에 오르면 금강산 일대 전경이 한눈에 들어와 산행의 피로를 자연에의 경탄과 감동으로 바꾸어줍니다.<br>※ 여름에 암벽등반과 겨울에 빙폭등반도 협의에 의해 가능합니다.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- 가격 --></td>
							<td><span class="txt_orange b">290,000원 ~ 650,000원</span>&nbsp;&nbsp;※중석식은 별도 매식</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<!--<tr><td colspan="4" align="right"><a href="javascript:;" onclick="javascript:alert('준비 중 입니다.');"><img src="<%=imageServer%>/tour_img/btn/btn_app_date.gif" class="btn"></a></td></tr>-->
						</table>
					</td>
				</tr>
				<tr><td colspan="2" height="14"></td></tr>
				<tr>
					<td colspan="2">
						<!-- / 일정보기 -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0302.gif" name="01"></td></tr>
						<tr>
							<td><%if(dateview.equals("1")){%><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=1';"><img src="<%=imageServer%>/tour_img/apply/tab_date01.gif" ></a><%}%><%if(dateview.equals("2")){%><img src="<%=imageServer%>/tour_img/apply/tab_date02_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=2';"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" ></a><%}%><%if(dateview.equals("3")){%><img src="<%=imageServer%>/tour_img/apply/tab_date03_on.gif" ><%}else{%><a href="javascript:document.location.href='?dateview=3';"><img src="<%=imageServer%>/tour_img/apply/tab_date03.gif" ></a><%}%><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								
								<!-- / 표1 -->
<div id="dateview1" <%if(dateview.equals("1")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:00</td>
									<td class="bg_white lpad_20">집결지(화진포 아산 휴게소) 도착</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:10</td>
									<td class="bg_white lpad_20">중식 및 발권</td>
									<td class="bg_white lpad_20">관광증 수령</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">14:00</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">15:00</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:00</td>
									<td class="bg_white lpad_20">숙소 체크인</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:30</td>
									<td class="bg_white lpad_20">금강산관광      특구 투어</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">18:00</td>
									<td class="bg_white lpad_20">석식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">온천/중국전통마사지/가무공연</td>
									<td class="bg_white lpad_20">택1</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">금강산 나이트라이프<br>(호프&주점, 노래방, 야외바베큐 등)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- 표1 / -->


								<!-- / 표2 -->
<div id="dateview2" <%if(dateview.equals("2")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">조식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:30</td>
									<td class="bg_white lpad_20">세존봉 코스 관광</td>
									<td class="bg_white lpad_20">중식 : 도시락</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">16:30</td>
									<td class="bg_white lpad_20">교예공연 관람(일반석)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">18:00</td>
									<td class="bg_white lpad_20">석식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">온천(대중탕)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">금강산 나이트라이프<br>(호프&주점, 노래방, 야외 바베큐 등)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- 표2 / -->

								<!-- / 표3 -->
<div id="dateview3" <%if(dateview.equals("3")){%>style="display:show;"<%}else{%>style="display:none;"<%}%>>
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">07:00</td>
									<td class="bg_white lpad_20">조식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">08:00</td>
									<td class="bg_white lpad_20">수정봉 코스 관광</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">11:30</td>
									<td class="bg_white lpad_20">중식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:30</td>
									<td class="bg_white lpad_20">온정각 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">12:45</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착 및 수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white" align="center" height="26">13:45</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착 수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
</div>
								<!-- 표3 / -->

 

							</td>
						</tr>
						<tr><td height="31" valign="bottom" class="txt_orange2 fs11 lpad_10">※ 상기 일정은 현지 사정에 의하여 변경될 수 있습니다.</td></tr>
						</table>
						<!-- 일정보기 / -->
					</td>
				</tr>
				<tr><td colspan="2" height="12"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/img_tip_order.gif"></td></tr>
				<tr><td colspan="2" height="30"></td></tr>
				
				<tr>
					<td colspan="2" valign="top">
						<!-- / 상품이용후기 -->
                        <%@ include file="order_goods_review.jsp" %>
                        <!-- / 상품이용후기 -->
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
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>


</body>
</html>