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

//게시판 타입결정
String boardType		= "11";

// DB연결 객체(ibatis사용)  
TourProductReview dao = new TourProductReview();
CommonBoard commonDao = new CommonBoard();

String part ="1";
String keyword = reviewType;
String key_str = "&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize, reviewType);

// 전체 게시물 수
int allCount = commonDao.getTotalCount(boardType, part , keyword);

// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
%>


						<table width="690" cellpadding="0" cellspacing="0" border="0">
<form method="post" name="f1" action="order_goods_review_ok.jsp">
<input type="hidden" name="cmd">
<input type="hidden" name="board_seq">
<input type="hidden" name="board_type" value="<%=boardType%>">
<input type="hidden" name="requestedPage" value="<%=requestedPage%>">
<input type="hidden" name="reviewType" value="<%=reviewType%>">
<input type="hidden" name="returnUrl" value="<%=returnUrl%>">
						<tr><td  class="fs11"><img src="<%=imageServer%>/tour_img/apply/stit_app0304.gif" name="03">&nbsp;&nbsp;(전체  <span class="txt_green b"><%=allCount%></span>건)</td></tr>
						<tr><td height="10"></td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="reply_bg02">
						<tr>
							<td><textarea name="content" style="width:616px;height:39px;overflow:auto;" onFocus="clearText(this)">의견은 500자 이내로 등록 할 수 있으며 로그인 후 이용하시기 바랍니다.</textarea>
							<a href="javascript:chk();"><img src="<%=imageServer%>/tour_img/btn/btn_reply_regis.gif" class="btnl7" align="absmiddle"></a></td>
						</tr>
</form>	
						</table>
					
						<!-- 상품이용후기 / -->

						<!-- / 댓글목록 -->
						
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="80" style="padding:0 12 0 12">
						<col width="1">
						<col width="560" style="padding:0 10 0 15">
          <% if(record.length <= 0){ %>
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3" align="center">등록된 데이터가 없습니다..</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
          <%
          }else{
          	//리스트 화면에 전시
          	int j =0 ;
          	String colorTxt = new String();
          	for(int i=0;i<record.length; i++){ 
          		Tbrd_board_ma_bean tbean = record[i];
          		
          		board_seq			= tbean.getBoard_seq();
          		ref_no				= tbean.getRef_no(); 
          		level_no			= tbean.getLevel_no(); 
          		sort_no				= tbean.getSort_no(); 
          		read_num			= tbean.getRead_num(); 
          		title				= tbean.getTitle(); 
		        //content			= tbean.getContent();
		        content				= Util.getString(tbean.getContent(),"");
		        //content			= content.replaceAll("\"", "'");
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
          		if(j%2==0)
          		    colorTxt = "";
          		else
          		    colorTxt = " class=\"bg_lgreen\"";
          		    
          		j++;
          %>
						<tr><td <%=colorTxt%> colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" <%=colorTxt%>><strong><%=user_name%></strong><br>(<%=user_id%>)</td>
							<td <%=colorTxt%>></td>
							<td <%=colorTxt%>>
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
						<tr><td <%=colorTxt%> colspan="3" height="8"></td></tr>
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
							<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , returnUrl, "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
						 </td>
						</tr>
						</table>
						<!-- paging/ -->