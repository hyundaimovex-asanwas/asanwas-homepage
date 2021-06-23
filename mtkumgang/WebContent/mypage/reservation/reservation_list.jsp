<%--
  - 작성자: 이소연
  - 일자: 2006.07.03
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 마이페이지>나의예약보기
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.util.*"%>
<%
  String McNum = "0";
  String sub = "0";
  String pageNum = "2";
%>

<%
//request parameters
String r_mail = ParamUtil.getReqParameter(request.getParameter("r_mail"), "");
String r_pass = ParamUtil.getReqParameter(request.getParameter("r_pass"), "");

//변수선언
int idx = 0;
String idx_m = "";
String r_name = "";
String r_stdt = "";
String r_edt = "";
String daynight = "";
String regdate = "";
String regtime  = "";
String r_stat= "";
String final_time = "";
String final_type = "";
String accept_no= "";

int pageSize = 10;
int blockSize = 10;

// DB연결 객체
ReservationInfo dao = new ReservationInfo();

// 파라메터
String key_str = "&r_mail="+r_mail+"&r_pass="+r_pass;
//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);
//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);
// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);
// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);
// 전체 게시물 수
int allCount = dao.getTotalCount(r_mail,r_pass);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Reservation_bean record [] = dao.getList(pageSize, requestedPage, r_mail, r_pass);

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
<!--
  function PageMov(val) {
     document.form.idx.value = val;
     document.form.action="reservation_01.jsp";
     document.form.submit();
  }
-->
</script>
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
<% if(record.length <= 0){ %>
                        <table width="690" cellpadding="0" cellspacing="0" border="0">
						  <tr><td height="2" class="line_dg"></td></tr>
						  <tr align="center">
						  	<td height="26">예약하신 정보가 없습니다.</td>
						  </tr>
						  <tr><td height="1" class="line_dg"></td></tr>
						</table>
<%
}else{
%>
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
							<!--<td><img src="<%=imageServer%>/tour_img/txt24.gif"> 결제 마감 일시 </td> -->
						</tr>				
<%
	for(int i=0;i<record.length; i++){ 
		Reservation_bean tbean = record[i];
		
		idx      = tbean.getIdx();
		//idx_m    = tbean.getIdx_m(); 
		r_stdt   = tbean.getRstdt(); 
		r_edt    = tbean.getRedt(); 
		daynight = tbean.getDaynight(); 
		regdate  = tbean.getRegdate(); 
		r_stat   = tbean.getRstat(); 
		regtime  = tbean.getRegtime(); 
		final_type   = tbean.getFinal_type();  //F; 종료, I: 진행중
		final_time   = tbean.getFinal_time(); 
		accept_no = tbean.getAccept_no(); 
		
%>
						<col width="40"><col width="110"><col width="85"><col width="85">
						<col width="70"><col width="85"><col width="85"><col width="130">
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr align="center">
							<td height="26"><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td>
							<%if(r_stat.equals("취소")){%>
							   <%=accept_no%>
                                                  <%}else{%>
                                                            <a href="javascript:PageMov(<%=idx%>);" class="listtxt07"><span class="txt_sky"><u><%=accept_no%></u></span></a>
                                                  <%}%>
							</td>
							<td><%=r_stdt%></td>
							<td><%=r_edt%></td>
							<td><%=daynight%></td>
							<td><%=regdate%></td>
							<td><%=final_type%></td>
			      <%
//                              if(final_type.equals("F")){
//                                out.println("<font color='red'>"+final_time+"</font>");
//                              }else{
//                                out.println(final_time);
//                              }
                              %>

						</tr>
						<tr><td height="1" colspan="8" class="line_g2"></td></tr>
<%
	 }
%>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						</table>
<%
}
%>

						<!-- list table / -->


						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "reservation_list.jsp", "500", key_str ,imageServer+"imjk_img/", blockPerPage)%>
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

<form name="form" method="post" action="reservation_01.jsp">
    <input type="hidden" name="r_name" value="<%=r_name%>">
    <input type="hidden" name="r_pass" value="<%=r_pass%>">
    <input type="hidden" name="idx">
</form>
</body>
</html>