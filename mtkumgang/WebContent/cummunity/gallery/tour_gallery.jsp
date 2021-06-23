<%--
  - 작성자: 임형수  
  - 일자: 2006.05.29
  -수정자:이소연(2006.07)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 커뮤니티>회원 갤러리 리스트

  - 2010-10-14 심동현
  - 스크립트 치환자 함수 추가 (XSS방지)
--%>
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
int board_seq			= 0;
int ref_no				= 0; 
int read_num			= 0;
String title			= ""; 
String content		= "";
String type_code  = "";
String type_name = "";
String use_yn			= "";
String user_id		= "";
String user_name		= "";
String virtual_name	= "";
String real_name		= "";
String regdate			= "";
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "04";

// DB연결 객체
TourGalleryBoard dao = new TourGalleryBoard();
CommonBoard commonDao = new CommonBoard();



// 검색 - 분류
String searchTypeCode =ParamUtil.getReqParameter(request.getParameter("searchTypeCode"));
// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    =  ParamUtil.getReqParameter(request.getParameter("keyword"));

// 검색 - 파라메터
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;

//요청된 페이지 넘버
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//한 페이지 당 게시물 숫자
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// 현재의 블록에서의 위치
int position = Util.parseInt(request.getParameter("position"), 1);

// 블럭 당 페이지 숫자  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);


// 전체 게시물 수
int allCount = dao.getFrontTotalCount(part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getFrontList(rowsPerPage, requestedPage, part, keyword );
//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;


//out.println("key_str: "+key_str);


//out.println("allCount: "+allCount);
//out.println("pageCount: "+pageCount);
//out.println("imageServer: "+imageServer);

String McNum = "5";
String sub = "4";
String pageNum = "4";
String subNum = "1";

%>
<html>
<head>
<title> 금강산관광 </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
function goSearch(){
	f = document.searchForm;
	if(f.part.value==""){
		alert("검색종류를 선택하여 주십시요.");
		f.part.focus();
		return;
	}
	f.submit();
}

function writedSeach(){
	f = document.searchForm;
	var keywordId = document.getElementById('keywordId');
    if(f.part.value=="3"){
        f.keyword.value="<%=session_id%>";
		keywordId.innerHTML = "<input type=text style='width:140;' name=keyword  value='<%=session_id%>' readonly >";
	}else{
		var key = f.keyword.value;
        keywordId.innerHTML = "<input type=text style='width:140;' name=keyword  value="+key+" >";
	}
}

function ck() {
	var id = "<%=session_id%>";
	if(id == ""){
		popLogin();
		return;
	}
	
       document.location.href="tour_gallery_edit.jsp";
    
} 

function popLogin() {
   var winOpts="width=370,height=320,scrollbars=no";
   var url = "/member/pop_login.jsp";
   window.open(url,"LoginCheck",winOpts);
}

//-->
</SCRIPT>

</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
    <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->
		<!-------- / center area ----->
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm04.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">커뮤니티</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">회원갤러리</span></td>
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
						<table width="690" height="166" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm04.jpg');fixed no-repeat left top;">
						<tr><td valign="bottom" class="bpad_12"><img src="<%=imageServer%>/tour_img/community/stit_comm04.gif" hspace="5"></td></tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<!-- / view table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="118" class="tpad_20 bpad_25"><col width="25"><col width="118" class="tpad_20 bpad_25"><col width="25">
						<col width="118" class="tpad_20 bpad_25"><col width="25"><col width="118" class="tpad_20 bpad_25"><col width="25"><col width="118" class="tpad_20 bpad_25">
						<tr><td height="2" colspan="9" class="line_dg"></td></tr>
						<% 						
						if(record.length <= 0){ %>						    
                              <tr valign="top">
                                <td  colspan="5" >
                 	              <div align="center">등록된 데이터가 없습니다.</div>
                 	            </td>
                 	          </tr>
                 	          <tr><td height="1" colspan="9" class="line_g"></td></tr>
						<%
						}else{
							int a_table = 0;
							//리스트 화면에 전시
							for(int i=0;i<record.length; i++){ 
								Tbrd_board_ma_bean tbean = record[i];

								//XSS 필터 적용
								title					= clearXSS(tbean.getTitle(),avatag);

								board_seq			= tbean.getBoard_seq();
								ref_no				= tbean.getRef_no(); 
								read_num			= tbean.getRead_num(); 
								content				= tbean.getContent(); 
								user_name			= tbean.getUser_name(); 
								user_id				= tbean.getUser_id(); 
								regdate				= tbean.getReg_date_String();
								use_yn				= tbean.getUse_yn(); 
								virtual_name	= ParamUtil.getReqParameter(tbean.getVirtual_name());
								real_name			= ParamUtil.getReqParameter(tbean.getReal_name());
								
								String img_name = "";
								
								if(virtual_name.equals("")){
									img_name = imageServer+"noimage.gif";
								}else{
									img_name = virtual_name;	
								}
								
								//관리자 삭제의 경우
								if(use_yn.equals("0")) img_name =imageServer+"/noimage.gif";

								a_table = (i+1) % 5;
						%>
						
						<% if(a_table == 1){ %>	
						<tr>
						<% } %>	
							<td>
								<!-- 이미지테이블 -->
								<table width="118" cellpadding="0" cellspacing="0" border="0">
							
								<tr>
                        							
									<td colspan="2"><table cellpadding="2" cellspacing="1" border="0" class="imgline"><tr><td class="bg_white">
									<% if(use_yn.equals("1")){ %>
									  <a href="tour_gallery_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=img_name%>" width="112" height="108"></a>
									<%}else{%>
                                      <img src="<%=img_name%>" width="112" height="108">
                                    <%}%>
									</td></tr></table></td>
								</tr>
								<tr valign="top">
									<td width="6" class="tpad_13 lpad_5"><img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="5"></td>
									<td width="112" class="tpad_13">
                                    <% if(use_yn.equals("1")){ %>
									   <a href="tour_gallery_view.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>" class="listtxt05">
									   <%=Util.getStringLimit((title).trim(),6)%></a><!--<img src="<%=imageServer%>/tour_img/bu/ico_new.gif" align="absmiddle">-->
                                    <%}else{%>
							           관리자에 의해서 삭제되었습니다.
							        <%}%>                                    
									   </td>
								</tr>
								<tr>
									<td></td>
									<td class="txt_gray2 fs11 lh16 tpad_5">
									  <%if(use_yn.equals("1")){ %><%=user_name%>(<%=user_id%>)<%}else{%> <%}%><br>
                                      <%if(use_yn.equals("1")){ %><%=Util.replaceAll(regdate,"-",".")%><%}else{%> <%}%>&nbsp;조회:<%=read_num%>
                                    </td>
                        
								</tr>
								</table>
							</td>
							<td></td>
                        <% if(a_table == 1){ %>
                        <% } %>	
                        


					    <% 
					    if(a_table == 0){ 						
					    	if((i+1) == allCount || (i+1) == 6){
					    %>
					    </tr>
					    <tr><td height=15 colspan=4></td></tr>
					    <%
					    	}else{
					    %>
					    </tr>
					    <tr><td height="1" colspan="9" class="line_g"></td></tr>
					    <% 
					    	}
					    } 
					    %>
				     <%
				     	}
				     }
				     
				     %>
							

						<tr><td height="1" colspan="9" class="line_dg"></td></tr>
						</table>
						<!-- view table / -->

						<!-- /paging -->
                        <table cellspacing="0" cellpadding="0" border="0" width="690" height="50">
						<tr>
							<td width="30%"></td>
							<td width="40%" align="center">
							<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "tour_gallery.jsp", "500", key_str ,imageServer+"/imjk_img/", blockPerPage)%>
			                </td>
			                <td width="30%" align="right">
			                 <!--  <a href="javascript:ck()"><img src="<%=imageServer%>/tour_img/btn/btn_comm_regis.gif" class="btn"></a> -->
			                </td>
						</tr>
						</table>
						<!-- paging/ -->
								
						<!-- /search -->
						<form method=post name=searchForm action="tour_gallery.jsp">
						<table cellspacing="0" cellpadding="0" border="0" align="center">
						<tr>
                          <td width="100">
                            <!--검색-->
                            <select name="part" style='width:80;' onChange="javascript:writedSeach()">
                            <option <%if(part.equals("")){%>selected<%}%>  value=''>선택</option>
                            <option <%if(part.equals("1")){%>selected<%}%> value='1'>제목</option>
                            <option <%if(part.equals("2")){%>selected<%}%> value='2'>이름</option>
                            <%if(!session_id.equals("")){%>
                            <option <%if(part.equals("3")){%>selected<%}%> value='3'>내가쓴글</option>
                            <%}else{%>
                            <option <%if(part.equals("3")){%>selected<%}%> value='3'>아이디</option>
                            <%}%>
                            </select></TD>
                            <TD align="right"><div id="keywordId"><input type="text" name="keyword" value="<%=keyword%>"  <%if(!session_id.equals("") && part.equals("3") ){%>readonly<%}%>  style="width:140px;"></div></TD><td><a href="javascript:goSearch()"><img src="<%=imageServer%>/tour_img/btn/btn_search.gif" align="absmiddle" hspace="4"></a>
                            <!--검색-->
                          </td>
						</tr>
						</table>
						</FORM>
						<!-- search/ -->
					
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