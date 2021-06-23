<%-- 
  - 작성자: 이소연
  - 일자: 2006.06.13
  - 저작권 표시: IMJ Korea
  - 설명: 프론트 - 금강산 알아보기>PR Room 리스트
--%> 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%> 
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourPrRoomChn"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%

//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		    = "";
String type_code        = "";
String type_name        = "";
String use_yn			= "";
String user_id		    = "";
String user_name		= "";
String thumbnail_virtual_name	= "";
String thumbnail_real_name		= "";
String virtual_name	= "";
String real_name		= "";
String regdate			= "";
int pageSize			= 6;
int blockSize			= 10;

String pageNum = "4";
String McNum = "1";
String sub = "4"; 
  

//게시판 타입결정
String boardType	= "10";

// DB연결 객체
TourPrRoomChn dao = new TourPrRoomChn();
CommonBoard commonDao = new CommonBoard();


// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));

// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 전체 게시물 수
int allCount = dao.getTotalCount(part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>::: Mt.Kumgang Tour :::</title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<script language="JavaScript" src="<%=imageServer%>/chn_img/inc/java.js"></script>
<script type="text/JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
<style type="text/css">
<!--
.style1 {
	color: #f04b01;
	font-weight: bold;
}
-->
</style>

<script language="JavaScript" >
<!--
// 이미지사이즈에맞게 팝업 띄우기
function popimage(imagesrc,winwidth,winheight){
	var look='width='+winwidth+',height='+winheight+','
	popwin=window.open("","",look)
	popwin.document.open()
	popwin.document.write('<html><link rel=STYLESHEET type=text/css href=<%=imageServer%>/tour_common/common.css><title>Image Window</title><body class=popmargin><table cellspacing=0 cellpadding=0 border=0 width=100%><tr><td width=100%><table cellspacing=0 cellpadding=0 border=0 width=100% height=65 class=bg_dgreen2><tr valign=top><td style=padding:20 0 0 20><img src=<%=imageServer%>/tour_img/preview/pop_tit_imgview.gif></td><td align=right style=padding:20 15 0 0><img src=<%=imageServer%>/tour_img/preview/pop_logo.gif></td></tr></table><table cellspacing=0 cellpadding=0 border=0 width=100%><tr><td height=29></td></tr><tr><td style=padding:0 5 0 5 align=center><img src=' + imagesrc + '></td></tr><tr><td height=22></td></tr><tr><td align=center><a href=javascript:; onclick=window.close();><img src=<%=imageServer%>/tour_img/btn/btn_pre_confirm.gif></a></td></tr><tr><td height=23></td></tr></table><table cellspacing=0 cellpadding=0 border=0 width=100% height=8 class=bg_dgreen2><tr><td></td></tr></table></td></tr></table></body></html>')
	popwin.document.close()
}

function goSearch(){
	f = document.searchForm;

	if(f.part.value==""){
		alert("검색종류를 선택하여 주십시요.");
		f.part.focus();
		return;
	}
	
	f.submit();
}

//-->
</script>
</head>

<body>
<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="/chn/include/preview/tour_preview_top.jsp" %>


		<!-------- top area / -------->
		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0"> 
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="/chn/include/preview/tour_preview_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/chn_img/preview/tit_preview04.gif"></td>
						<td align="right" class="linemap">&nbsp;</td>
					</tr>
					<tr><td height="1" class="line_g"></td></tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr>
				  <td height="12" colspan="5"></td>
				  </tr>
				<tr>
				  <td colspan="5"><img src="<%=imageServer%>/chn_img/preview/img_preview04_01.gif"></td>
				  </tr>
				<tr>
				  <td colspan="5" style="padding-bottom:11px"><img src="<%=imageServer%>/chn_img/preview/img_preview04_02.gif"></td>
				  </tr>
				<tr>
				  <td height="2" colspan="5" bgcolor="424242"></td>
				  </tr>
				<tr>
				  <td height="30" colspan="5"></td>
				 </tr>





                 <% 						
                 if(record.length <= 0){ %>
                    <tr valign="top">
                      <td  colspan="5" height="40">
                 	    <div align="center">등록된 데이터가 없습니다.</div>
                 	  </td>
                 	</tr>
                 	<tr><td height="1" colspan="5" class="line_dg"></td></tr>
                 <%
                 }else{
                 	int a_table = 0;
                 	//리스트 화면에 전시
                 	for(int i=0;i<record.length; i++){ 
                 		Tbrd_board_ma_bean tbean = record[i];
                 		
                 		board_seq			= tbean.getBoard_seq();
                 		read_num			= tbean.getRead_num(); 
                 		title				= tbean.getTitle(); 
                 		content				= tbean.getContent();
                 		content				= content.replaceAll("\"", "'");
                 		regdate				= tbean.getReg_date_String();
                 		use_yn				= tbean.getUse_yn(); 
                 		thumbnail_virtual_name	    = ParamUtil.getReqParameter(tbean.getThumbnail_virtual_name());
                 		thumbnail_real_name			= ParamUtil.getReqParameter(tbean.getThumbnail_real_name());
                 		virtual_name	    = ParamUtil.getReqParameter(tbean.getVirtual_name());
                 		real_name			= ParamUtil.getReqParameter(tbean.getReal_name());                 		
                 		type_code           = tbean.getType_code().trim();
                 	    
                 		String thumbnail_img_name = "";
                 		String img_name = "";
                 		
                 		if(thumbnail_virtual_name.equals("")){
                 			thumbnail_img_name = imageServer+"noimage.gif";
                 		}else{
                 			thumbnail_img_name = thumbnail_virtual_name;	
                 		}
                 		
                 		if(virtual_name.equals("")){
                 			img_name = imageServer+"noimage.gif";
                 		}else{
                 			img_name = virtual_name;	
                 		}
                 
                 		a_table = (i+1) % 3;
                 %>
				
				<% if(a_table == 1){ %>
						<tr valign="top">
                <%}%>


			    <td>
				  <table width="201" height="152" border="0" cellpadding="0" cellspacing="0" bgcolor="ededed">
					<tr>
					  <td>
					    <table width="199" height="150" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="ffffff">
						  <tr>
							<td align="center">
							<img src="<%=thumbnail_img_name%>" width="195" height="146" /></td>
						  </tr>
					    </table>
					  </td>
					</tr>
				  </table>
				  <table width="201" border="0" cellspacing="0" cellpadding="0">
					  <tr>
						<td width="7"  height="37">
						<img src="<%=imageServer%>/chn_img/preview/bu_gray_rec.gif" width="2" 
						height="2" />
						</td>

						<td><%=title%></td>

						<td width="61">


							<%
							if (type_code.equals("1")){  //이미지
							%>
							  <a href="javascript:;" onclick="window.open ('popup_pr_imgview.jsp?board_seq=<%=board_seq%>&img_name=<%=img_name%>', 'movieview', 'width=750,height=700,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
							  <img src="<%=imageServer%>/tour_img/btn/btn_pre_img.gif" align="absmiddle">
							  </a>                 	    
							<%
							}else if(type_code.equals("2")){  //동영상
							%>
							  <a href="javascript:;" onclick="window.open ('popup_pr_movieview.jsp?board_seq=<%=board_seq%>&img_name=<%=content%>', 'movieview', 'width=450,height=436,scrollbars=no,toolbar=no,location=no,directories=no,top=100,left=100,noresize');">
							  <img src="<%=imageServer%>/tour_img/btn/btn_pre_play.gif" align="absmiddle">
							  </a>                 	    
							<%
							}else{
							%>

							<%}%>

						</td>
					  </tr>
				  </table>
				</td>


               <% if(a_table == 1){ %>
               <% } %>								
					    <% 
					    if(a_table == 0){ 						
					    	if((i+1) == allCount || (i+1) == 4){
					    %>
					    </tr>


						<tr>
							<td height="30" colspan="5"></td>
						</tr>
						<tr>
							<td height="1" colspan="5" bgcolor="424242"></td>
						</tr>


					    <%
					    	}else{
					    %>
					    </tr>
					    
						<tr>
						  <td height="7" colspan="3"></td>
						</tr>
						<tr>
						  <td height="1" colspan="3" bgcolor="ededed"></td>
						</tr>
						<tr>
						  <td height="14" colspan="3"></td>
						</tr>	
					    
					    <% 
					    	}
					    }else{//3으로 안나우어 질때 ...
							if((i+1) == allCount) {
                                for(int j=0;j<a_table; j++){
									out.println("<td width='201'></td>");
								}
								out.println("<tr>");
							}
						} 

				    }//for
				 } //end if
%>







				<tr>
				    <td height="55" colspan="5" align="center">


						   <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "pr_list.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
					
					</td>
				  </tr>


						<tr>
						  <td height="40" colspan="5" align="center">
						  <form method=post name=searchForm ACTION="pr_list.jsp">
                            <select name="part" style='width:80;'>
                              <option <%if(part.equals("")){%>selected<%}%>  value=''>select</option>
                              <option <%if(part.equals("1")){%>selected<%}%> value='1'>image</option>
                              <option <%if(part.equals("2")){%>selected<%}%> value='2'>movie</option>
                             </select>
							
                             <input type="text" name="keyword" value="<%=keyword%>" style="width:140px;"><a href="javascript:goSearch();"><img src="<%=imageServer%>/tour_img/btn/btn_search_eng.gif" align="absmiddle" hspace="4"></a><!--검색-->
						    </form>	
							</td>
						</tr>

				
				<tr>
				  <td colspan="5" valign="top"> 
      <!-- / detail table  -->
      <!-- detail table / -->      </td>
				  </tr>
				</table>
				<!--  cont / -->

			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->
        <%@ include file="/chn/include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>
</body>
</html>

