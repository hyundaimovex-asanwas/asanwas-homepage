<%-- 
  - 작성자: 이소연
  - 일자: 2006.07.26
  - 저작권 표시: IMJ Korea
  - 설명: 커뮤니티>지난이벤트보기 리스트
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrevent"%>
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

TourPrevent dao = new TourPrevent();

//조회수 증가
dao.updateReadnum(board_seq);

Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);

int totalCount = recordview.length;

for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		title					= tbean.getTitle();
		content				= tbean.getContent();
		content				= content.replaceAll("\"", "'");
		regdate				= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();		
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

Tbrd_attach_file_de_bean[] fileRecord = dao.getFileView(board_seq);

%>

<%
String McNum = "5";
String sub = "2";
String pageNum = "2";
%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script  language="javascript">
//이미지 싸이즈 고정
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}
</script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
                     <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
      <%@ include file="../../include/community/tour_gallery_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm022.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">이벤트</span></td>
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
						<table width="690" cellpadding="0" cellspacing="0">
						<tr valign="top">
							<td width="77" height="141" style="padding-top:12px;"><img src="<%=imageServer%>/tour_img/community/img_comm02_1.gif"></td>
							<td width="414" style="padding-top:26px;">
								<table width="100%" cellpadding="0" cellspacing="0">
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_12.gif"><a href="ingevent.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_ingevent.gif" hspace="7"></a><!-- 진행이벤트보기 --></td></tr>
								<tr><td height="11"></td></tr>
								<tr><td><img src="<%=imageServer%>/tour_img/community/txt_comm02_22.gif"></td></tr>
								</table>
							</td>
							<td width="199" rowspan="2" align=right><img src="<%=imageServer%>/tour_img/community/img_comm02_3.gif"></td>
						</tr>
						<tr>
							<td colspan="3" valign="top" height="25"><img src="<%=imageServer%>/tour_img/community/stit_comm022.gif" hspace="5"></td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="71"><col width="257" class="lpad_15 tpad_3">
						<col width="79"><col width="253" class="lpad_15 tpad_3">
						<tr><td height="2" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td colspan="3"><strong><%=title%></strong></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view14.gif"><!-- 등록일 --></td>
							<td><%=regdate%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view15.gif"><!-- 참여수 --></td>
							<td><%=read_num%></td>
						</tr>
						<tr><td height="1" colspan="4" class="line_dg"></td></tr>
						<tr>
							<td colspan="4" style="padding:17 0 40 0px;" valign="top" align="center">
								<!-- / 지난이벤트 내용 -->
								<table width="680" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
                                                                <% 
                                                                if(fileRecord != null){ 
                                                                     StringBuffer sb = new StringBuffer();
                                                                     for(int j=0; j<fileRecord.length; j++){
                                                                          Tbrd_attach_file_de_bean fbean = fileRecord[j];
                                                                          virtual_name= Util.getString(fbean.getVirtual_name(),"");
                                                                          real_name= Util.getString(fbean.getReal_name(),"");								
                                                                         String img_name =  virtual_name;
                                                                         %>
                                                                        <img src="<%=img_name%>" onload=resizeImg(this) vspace="9"> 
                                                                       <%
                                                                     }
                                                                } 
                                                                %>	
                             
									</td>
								</tr>
								</table>
								<!--  지난이벤트 내용/ -->
							</td>
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
							                            <a href="prevent_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt07"><%=prev_title%></a>
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
							                            <a href="prevent_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>" class="listtxt07"><%=next_title%></a>
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
							<td align="right"><a href="prevent_list.jsp?requestedPage=<%=requestedPage%><%=key_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a></td>
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