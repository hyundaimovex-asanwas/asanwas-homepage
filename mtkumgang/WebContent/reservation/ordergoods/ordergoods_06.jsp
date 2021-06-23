<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>  
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourProductReview"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int level_no			= 0;
int sort_no				= 0;
int read_num			= 0;
String title			= ""; 
String content			= "";
String user_nick		= "";
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";
String user_name    	= "";

int pageSize			= 10;
int blockSize			= 10;

String McNum = "2";
String sub = "3";
String pageNum = "3";
String subNum = "6";

//게시판 타입결정
String boardType		= "11";

// DB연결 객체(ibatis사용)  
TourProductReview dao = new TourProductReview();
CommonBoard commonDao = new CommonBoard();

String part ="";
String keyword ="";
String key_str = "";

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize);

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
%>
<html>
<head>
<title> 금강산관광      </title>
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
		alert("로그인이 필요한 서비스입니다.");
		return;
	}	

	if(obj.content.value == ""){
		alert("내용을 입력하세요.");
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
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/reservation/tour_reservation_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
				<%@ include file="../../include/reservation/tour_reservation_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/apply/tit_app36.gif"><img src="<%=imageServer%>/tour_img/apply/tit_app05.gif" hspace="9"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">예약안내</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">맞춤상품</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">기업연수/워크샵</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td colspan="2" height="22"></td></tr>
				<tr><td colspan="2"><img src="<%=imageServer%>/tour_img/apply/top_txt_app05.gif"></td></tr>
				<tr><td colspan="2" height="56"></td></tr>
				<tr valign="top">
					<td width="300">
						<table width="287" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="29"><img src="<%=imageServer%>/tour_img/apply/stit_app0301.gif"></td></tr>
						<tr>
							<td valign="top" height="261"><img src="<%=imageServer%>/tour_img/apply/_temp_limg01.gif" width="269" height="246" id="limg"></td>
						</tr>
						<tr>
							<td><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg01.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg01.gif" width="83" height="48"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg02.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg02.gif" width="83" height="48" style="margin-left:10px;"></a><a href="javascript:;" onmouseover="limg.src='<%=imageServer%>/tour_img/apply/_temp_limg03.gif'"><img src="<%=imageServer%>/tour_img/apply/_temp_simg03.gif" width="83" height="48" style="margin-left:10px;"></a></td>
						</tr>
						</table>
					</td>
					<td width="390">
						<table width="390" cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td height="29" colspan="4" valign="top" align="right"><a href="#01"><img src="<%=imageServer%>/tour_img/apply/tab_order01.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order01_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order01.gif'" class="btn"></a><a href="#02"><img src="<%=imageServer%>/tour_img/apply/tab_order02.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order02_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order02.gif'" class="btn"></a><a href="#03"><img src="<%=imageServer%>/tour_img/apply/tab_order03.gif" onmouseover="this.src='<%=imageServer%>/tour_img/apply/tab_order03_on.gif'" onmouseout="this.src='<%=imageServer%>/tour_img/apply/tab_order03.gif'"></a></td>
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
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order05.gif"><!-- 최소인원 --></td>
							<td><strong>최소 30명이상</strong></td>
						</tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr valign="top">
							<td height="172" width="73"><img src="<%=imageServer%>/tour_img/apply/txt_order03.gif"><!-- 상품소개 --></td>
							<td width="1" class="bg_dgray"></td>
							<td width="23"></td>
							<td>금강산은 산의 경치도 아름답지만 풍부한 즐길거리와 단체 수용 시설이 있어 단체행사를 하기에 최상의 조건을 가지고 있습니다. 대규모 연회장과, 세미나, 공연시설이 준비되어 있고 크고작은 수많은 행사를 진행한 전문가들이 최적의 지원을 약속합니다.※ 단체의 성격에따라 관광일정 조정이 가능합니다.</td>
						</tr>
						<tr><td colspan="4" height="7"></td></tr>
						<tr><td class="line_g2" colspan="4" height="1"></td></tr>
						<tr>
							<td height="29" colspan="3"><img src="<%=imageServer%>/tour_img/apply/txt_order04.gif"><!-- 가격 --></td>
							<td><span class="txt_orange b">290,000원 ~ 650,000원</span>&nbsp;&nbsp;※중석식은 별도 매식</td>
						</tr>
						<tr><td class="line_dg" colspan="4" height="1"></td></tr>
						<tr><td colspan="4" height="20"></td></tr>
						<tr><td colspan="4" align="right"><a href="#"><img src="<%=imageServer%>/tour_img/btn/btn_app_date.gif" class="btn"></a></td></tr>
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
							<td><a href="javascript:;" onclick="opentab(1);"><img src="<%=imageServer%>/tour_img/apply/tab_date01_on.gif" id="tabview1"></a><a href="javascript:;" onclick="opentab(2);"><img src="<%=imageServer%>/tour_img/apply/tab_date02.gif" id="tabview2"></a><a href="javascript:;" onclick="opentab(3);"><img src="<%=imageServer%>/tour_img/apply/tab_date03.gif" id="tabview3"></a><img src="<%=imageServer%>/tour_img/apply/tab_date00.gif"></td>
						</tr>
						<tr><td height="20"></td></tr>
						<tr>
							<td>
								<script> // 탭 메뉴 스크립트
								function opentab(opennum)
								{
									if(opennum == 1){
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01_on.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03.gif";
										dateview1.style.display = "block";
										dateview2.style.display = "none";
										dateview3.style.display = "none";
									}
									else if(opennum == 2){
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02_on.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03.gif";
										dateview1.style.display = "none";
										dateview2.style.display = "block";
										dateview3.style.display = "none";
									}
									else{
										tabview1.src = "<%=imageServer%>/tour_img/apply/tab_date01.gif";
										tabview2.src = "<%=imageServer%>/tour_img/apply/tab_date02.gif";
										tabview3.src = "<%=imageServer%>/tour_img/apply/tab_date03_on.gif";
										dateview1.style.display = "none";
										dateview2.style.display = "none";
										dateview3.style.display = "block";
									}
								}
							</script>
								<!-- / 표1 -->
								<div id="dateview1" style="display:show;">	
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:30</td>
									<td class="bg_white lpad_20">서울 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:00</td>
									<td class="bg_white lpad_20">집결지(화진포 아산 휴게소) 도착</td>
									<td class="bg_white lpad_20">관광증 수령</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:00~13:30</td>
									<td class="bg_white lpad_20">중식 및 발권</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30~14:00</td>
									<td class="bg_white lpad_20">집결지 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:00~14:40</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:45</td>
									<td class="bg_white lpad_20">남측 출입사무소 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:55</td>
									<td class="bg_white lpad_20">MDL 통과</td>
									<td class="bg_white lpad_20">군사분계선 통과</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:00</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착/수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:50</td>
									<td class="bg_white lpad_20">북측 출입사무소 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">15:50~16:50</td>
									<td class="bg_white lpad_20">삼일포 코스 관광</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">17:00</td>
									<td class="bg_white lpad_20">숙소 체크인</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">석식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">자유시간<br>-온천(개별탕,대중탕)<br>-중국전통마사지(발,전신)<br>-금강산예술소조 가무공연(21:00~22:00)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20">금강산 나이트라이프<br>(호프&주점, 노래방, 야외바베큐 등)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
								</div>
								<!-- 표1 / -->


								<!-- / 표2 -->
								<div id="dateview2" style="display:none;">
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">07:00</td>
									<td class="bg_white lpad_20">조식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:30~16:30</td>
									<td class="bg_white lpad_20">세존봉 코스관광</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">16:30~18:00</td>
									<td class="bg_white lpad_20">교예공연 관람(특석,일반석)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30~16:00</td>
									<td class="bg_white lpad_20">자유시간<br>해금강 코스관광<br>온천(개별탕,대중탕)<br>중국전통마사지(발,전신)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">16:30~18:00</td>
									<td class="bg_white lpad_20">교예공연 관람(특석,일반석)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">석식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" rowspan="2">19:00~</td>
									<td class="bg_white lpad_20" height="26">자유시간<br>-온천(개별탕,대중탕)<br>-중국전통마사지(발,전신)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20">금강산 나이트라이프<br>(호프&주점, 노래방, 야외바베큐 등)</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								</table>
								</div>
								<!-- 표2 / -->

								<!-- / 표3 -->
								<div id="dateview3" style="display:none;">
								<table cellspacing="1" cellpadding="3" border="0" width="690" class="tabline">
								<tr align="center">
									<td width="20%" class="bg_white lpad_20" height="26">시간</td>
									<td width="50%" class="bg_white lpad_20">세부일정</td>
									<td width="30%" class="bg_white lpad_20">비고</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">07:00</td>
									<td class="bg_white lpad_20">조식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">08:00~11:30</td>
									<td class="bg_white lpad_20">자유시간<br>- 수정봉 코스관광<br>- 구룡연 코스관광<br>- 만물상 코스관광<br>- 하계시 : 해수욕장<br>- 동계시 : 눈썰매장</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">11:30~12:30</td>
									<td class="bg_white lpad_20">중식</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:30</td>
									<td class="bg_white lpad_20">온정각 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:45</td>
									<td class="bg_white lpad_20">북측 출입사무소 도착</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">12:45~13:30</td>
									<td class="bg_white lpad_20">북측 출입사무소 수속 및 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:35</td>
									<td class="bg_white lpad_20">MDL 통과</td>
									<td class="bg_white lpad_20">군사분계선 통과</td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">13:45</td>
									<td class="bg_white lpad_20">남측 출입사무소 도착 수속</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">14:00</td>
									<td class="bg_white lpad_20">남측 출입사무소 출발</td>
									<td class="bg_white lpad_20"></td>
								</tr>
								<tr>
									<td class="bg_white lpad_20" height="26">18:00</td>
									<td class="bg_white lpad_20">서울 도착</td>
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
					<td colspan="2">
						<!-- / 관광TIP -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/apply/stit_app0303.gif" name="02"></td></tr>
						<tr>
							<td class="txt_orange2 lpad_10 rpad_10">컨텐츠 수급 후 분량 가늠 가능함<td>
						</tr>
						<tr><td height="20"></td></tr>
						</table>
						<!-- 관광TIP / -->
					</td>
				</tr>
				<tr>
					<td colspan="2" valign="top">
						<!-- / 상품이용후기 -->
<form method="post" name="f1" action="ordergoods_06_ok.jsp">
<input type="hidden" name="cmd">
<input type="hidden" name="board_seq">
<input type="hidden" name="board_type" value="<%=boardType%>">
<input type="hidden" name="requestedPage" value="<%=requestedPage%>">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td  class="fs11"><img src="<%=imageServer%>/tour_img/apply/stit_app0304.gif" name="03">&nbsp;&nbsp;(전체공감 <span class="txt_green b"><%=allCount%></span>건)</td></tr>
						<tr><td height="10"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="reply_bg02">
						<tr>
							<td><textarea name="content" style="width:616px;height:39px;overflow:auto;"></textarea>
							<a href="javascript:chk();"><img src="<%=imageServer%>/tour_img/btn/btn_reply_regis.gif" class="btnl7" align="absmiddle"></a></td>
						</tr>
						</table>
</form>						
						<!-- 상품이용후기 / -->

						<!-- / 댓글목록 -->
						
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="80" style="padding:0 12 0 12"><col width="1"><col width="560" style="padding:0 10 0 15">
          <% if(record.length <= 0){ %>
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3" align="center">데이타가 존재하지 않습니다.</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
          <%
          }else{
          	//리스트 화면에 전시
          	for(int i=0;i<record.length; i++){ 
          		Tbrd_board_ma_bean tbean = record[i];
          		
          		board_seq			= tbean.getBoard_seq();
          		ref_no				= tbean.getRef_no(); 
          		level_no			= tbean.getLevel_no(); 
          		sort_no				= tbean.getSort_no(); 
          		read_num			= tbean.getRead_num(); 
          		title				= tbean.getTitle(); 
		        //content				= tbean.getContent();
		        content					= Util.getString(tbean.getContent(),"");
		        //content				= content.replaceAll("\"", "'");
          		use_yn				= tbean.getUse_yn(); 
          		user_level			= tbean.getUser_level(); 
          		board_top_no		= tbean.getBoard_top_no(); 
          		user_id				= tbean.getUser_id();
          		user_name			= tbean.getUser_name();
          		use_yn				= tbean.getUse_yn();
          
          		java.util.Date writeday = tbean.getReg_date();
          		String reg_date_string = tbean.getReg_date_String();
          		String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
          		String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
          %>
						<tr><td class="bg_lgreen" colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" class="bg_lgreen"><strong><%=user_name%></strong><br>(<%=user_id%>)</td>
							<td class="bg_dgray"></td>
							<td class="bg_lgreen">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><%=content%></td>
								</tr>
								<tr>
									<td class="tpad_5"><img src="<%=imageServer%>/tour_img/bu/bu_dgray_rec.gif" align="texttop" vspace="5"> 
									<span class="fs11"><%=reg_date_string%></span>
									<% if(session_id.equals(user_id)){ %>
									<a href="javascript:del('<%=board_seq%>');"><img src="<%=imageServer%>/tour_img/btn/btn_s_delete.gif" align="absmiddle"></a>
									<% } %>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td class="bg_lgreen" colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
          <%
          	}
          }
          
          %>
						</table>
						<!-- 댓글목록 / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="60">
						<tr>
						 <td align="center">
							<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "ordergoods_06.jsp.jsp", "500", key_str ,imageServer+"imjk_img/", blockPerPage)%>
						 </td>
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