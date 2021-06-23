<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %> 
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourNotice"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&part="+part+"&keyword="+keyword;

//변수 선언
String cmd			= "";
String board_type	= "";
String title		= "";
String content		= "";
String user_id		= "";
String user_name	= "";
String regdate		= "";
int read_num		= 0;
String use_yn		= "";
String type_code	= "";
String type_name	= "";
String virtual_name	= "";
String real_name	= "";
int recomm_num		= 0;

int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";

String pageNum = "5";
String McNum = "6";
String sub="5";



TourNotice dao = new TourNotice();

dao.updateReadnum(board_seq);

Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);

int totalCount = recordview.length;


for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		title					= tbean.getTitle();
		content					= tbean.getContent();
		content					= content.replaceAll("\"", "'");
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	


%>
<html>
<head>
<title> 금강산관광      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer2.js"></script>
<script language="javascript">
function openEvent() {
	window.open("/cummunity/quiz/070711_event_1.jsp","event1","width=700,height=650,top=0,left=0");
}

function openEvent1() {
	window.open("/cummunity/event/pray_event_write.jsp","event2","width=800,height=600,top=0,left=0");
}


//송이버섯 이벤트
function openEvent2() {
	alert("이벤트가 마감되었습니다.");
	//window.open("/cummunity/event_0912/event_01.jsp","event2","width=800,height=600,top=0,left=0");
}

//2008년 새해맞이 - 팔선녀잡기
function go2008() {
	alert("이벤트가 종료되었습니다.");
//	window.open("/cummunity/event_0118/event_0118.jsp","event2008","width=800,height=640,top=0,left=0");
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
			<td width="174"><!--  left menu flash --><%@ include file="../../include/center/tour_center_left.jsp" %></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/notice/tit_notice.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">공지사항</span></td>
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
								<tr><td height="108" valign="top"><img src="<%=imageServer%>/tour_img/notice/txt_notice.gif"></td></tr>
								<tr><td height="25" valign="top"><img src="<%=imageServer%>/tour_img/notice/stit_notice.gif" hspace="5"></td></tr>
								</table>
							</td>
							<td align="right"><img src="<%=imageServer%>/tour_img/notice/img_notice.jpg" width="179" height="159"></td></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="71"><col width="272" class="lpad_15 tpad_3">
						<col width="66"><col width="251" class="lpad_15 tpad_3">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td colspan="3"><strong><%=title%></strong></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view12.gif"><!-- 등록일 --></td>
							<td><%=regdate%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view13.gif"><!-- 조회수 --></td>
							<td><%=read_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td colspan="4" style="padding:15 15 25 13px;" valign="top" height="230"><%=content%></td>
						</tr>
						</table>
						<!-- view table / -->

						<!-- / 이전글,다음글  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td width="70" height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_prev.gif"></td>
							<td class="lpad_15 tpad_3">
							   <%if(prev_board_seq > 0){%>									
							       <a href="notice_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt06"><%=prev_title%></a>
                               <% }else{ %>
                               	이전글이 존재하지 않습니다.
                               <% } %>							
							</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_next.gif"></td>
							<td class="lpad_15 tpad_3">
							   <%if(next_board_seq > 0){%>
							      <a href="notice_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt06"><%=next_title%></a>
                               <% }else{ %>
                                  다음글이 존재하지 않습니다.	
                               <% } %>
							</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						</table>
						<!-- 이전글,다음글 / -->

						<!-- / button  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="13"></td></tr>
						<tr>
							<td align="right"><a href="notice_list.jsp?requestedPage=<%=requestedPage%><%=key_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_cus_listview.gif" class="btn"></a></td>
						</tr>
						<tr><td height="50"></td></tr>
						</table>
						<!-- button / -->
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