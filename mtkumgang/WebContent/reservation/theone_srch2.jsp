<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.reservation.bean.Reservation_bean"%>
<%@ page import="kr.co.imjk.reservation.dao.ReservationInfo"%>
<%@ page import="java.util.*"%>
<%
//request parameters
String rmail = request.getParameter("rmail");	//전화번호
String rpass = request.getParameter("rpass");	//비밀번호


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
String confirm_msg= "";

int pageSize = 10;
int blockSize = 10;

// DB연결 객체
ReservationInfo dao = new ReservationInfo();

// 파라메터
String key_str = "&rmail="+rmail+"&rpass="+rpass;
//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);
//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);
// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);
// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);
// 전체 게시물 수
int allCount = dao.getTotalCount(rmail,rpass);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Reservation_bean record [] = dao.getList(pageSize, requestedPage, rmail, rpass);

%>
<html>
<head>
<title>현대아산 온라인 예약　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>

<script language="javascript">
<!--
  function PageMov(val) {
     document.form.idx.value = val;
     document.form.action="theone_srch3.jsp";
     document.form.submit();
  }
-->
</script>
</head>

<body>
<table width="690" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td height="54"><img src="<%=imageServer%>/tour_img/mypage/tit_reservation.gif"></td>
  </tr>
  <tr>
    <td height="1px" bgcolor="E6E6E6"></td>
  </tr>
  <tr>
    <td height="16">&nbsp;</td>
  </tr>
  <tr>
    <td>



	
				<!-- / content  -->
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>	
					<td style="padding:20 0 10 16"><img src="<%=imageServer%>/reservation/img/title_srch2.gif"></td>
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
						<tr><td height="2" colspan="7" class="line_dg"></td></tr>
						<tr align="center" height="26">
							<td width="50"><img src="<%=imageServer%>/tour_img/txt01.gif"><!-- 번호 --></td>
							<td width="100"><img src="<%=imageServer%>/tour_img/txt25.gif"><!-- 상품 --></td>
							<td width="170"><img src="<%=imageServer%>/tour_img/txt18.gif"><!-- 신청서 번호--></td>
							<td width="80"><img src="<%=imageServer%>/tour_img/txt19.gif"><!-- 출발일 --></td>
							<td width="80"><img src="<%=imageServer%>/tour_img/txt20.gif"><!-- 도착일 --></td>
							<td width="80"><img src="<%=imageServer%>/tour_img/txt22.gif"><!-- 신청일시 --></td>
							<td width="130"><img src="<%=imageServer%>/tour_img/txt23.gif"><!-- 예약상태 --></td>
						</tr>				
						<%
							for(int i=0;i<record.length; i++){ 
								Reservation_bean tbean = record[i];
								
								idx      = tbean.getIdx();
								r_stdt   = tbean.getRstdt(); 
								r_edt    = tbean.getRedt(); 
								daynight = tbean.getDaynight(); 
								regdate  = tbean.getRegdate(); 
								r_stat   = tbean.getRstat(); 
								regtime  = tbean.getRegtime(); 
								final_type   = tbean.getFinal_type();  //F; 종료, I: 진행중
								final_time   = tbean.getFinal_time(); 
								accept_no = tbean.getAccept_no(); 
								if(r_stat.equals("1")){
									confirm_msg="상담원 통화요망";
								}else if(r_stat.equals("2")){
									confirm_msg="결제가능";
								}else if(r_stat.equals("3")){
									confirm_msg="예약완료";
								}else if(r_stat.equals("4")){
									confirm_msg="취소";
								}
								
						%>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr align="center" height="26">
							<td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
							<td><%=daynight%></td>
							<td>
							<%if(r_stat.equals("4")){%>
							   <%=accept_no%>
                            <%}else{%>
                               <a href="javascript:PageMov(<%=idx%>);" class="listtxt07"><span class="txt_sky"><u><%=accept_no%></u></span></a>
                            <%}%>
							</td>
							<td><%=r_stdt%></td>
							<td><%=r_edt%></td>
							<td><%=regdate%></td>
							<td><b><%=confirm_msg%></b></td>
						</tr>
						<tr><td height="1" colspan="7" class="line_g2"></td></tr>
						<%
							 }
						%>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						</table>
						<%
						}
						%>
						<!-- list table / -->


						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "theone_srch2.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
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





<form name="form" method="post">
    <input type="hidden" name="r_name" value="<%=r_name%>">
    <input type="hidden" name="rpass" value="<%=rpass%>">
    <input type="hidden" name="idx">
</form>
</body>
</html>