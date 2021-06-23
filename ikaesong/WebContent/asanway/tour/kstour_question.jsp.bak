<%--
  - 작성자: 임형수
  - 일자: 2006.05.03
  - 수정자 : 2006.08  
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 리스트
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
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
int pageSize			= 10;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "06";


// DB연결 객체
BestQuestion dao = new BestQuestion();
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
int allCount = dao.getTotalCount(searchTypeCode,part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);
//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;

// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, searchTypeCode, part, keyword );



//out.println("key_str: "+key_str);


//out.println("allCount: "+allCount);
//out.println("pageCount: "+pageCount);
//out.println("dataNum: "+dataNum);

%>


<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--


	

//검색
function goSearch(){
	f = document.searchForm;
	f.submit();
}




//-->
</SCRIPT>

</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">
<jsp:include page="/asanway/common/top.jsp" flush="true" />

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="25" bgcolor="E4E3C3">
    	<jsp:include page="/asanway/common/topbutton.jsp" flush="true" />
	</td>
  </tr>
  <tr>
    <td valign="top">
      <table width="850" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="180" height="32" valign="top" bgcolor="E4E3C3" ><table width="100%" height="95%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td valign="top" bgcolor="FCFCF6">
					<jsp:include page="/asanway/tour/left.jsp" flush="true" />
                </td>
                <td width="2"></td>
              </tr>
            </table></td>
          <td valign="top" bgcolor="FCFCF6" align="right">
          <!--// IMJK START -->
          <TABLE cellspacing=0 cellpadding=0 width=650>
               <TR>
                 <TD>
                <TABLE cellspacing=0 cellpadding=0 width=650>
                 <!-- loc -->
                   <TR valign=top>
          	        <TD colspan=2 height=50 align=right style='padding-top: 10'>
          	        <img src="<%=imageServer%>tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          	        <A HREF=# class=loc>고객센터</A> > 
          	        <span class=locon>자주묻는질문</span>
          	        </TD>
                    </TR>
                 <!-- //loc -->
                 </TABLE>
                 </TD>
              </TR>
          <TR valign=top>
          	<!-- main -->
          
          	<TD width=650 valign=top>
          		<table width=650 border=0 cellspacing=0 cellpadding=0>
          		<tr>
          			<td>
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          				<tr>
          					<td class='title'><img src='<%=imageServer%>tour_img/bu_blue_title.gif' align=texttop class=rmar10>자주묻는질문</td>
          				</tr>
          				</table>
          				<br>
          				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          					<col width=10%>
          					<col width=20%>
          					<col width=60% style='padding:5 3 3 3;'>
          					<col width=10%>
          					<tr><td colspan=4 height=2 class=linec1></td></tr>
          					<tr height=28 align=center>
                                   <td class=th>번호</td>
                                   <td class=th>분류</td>
                                   <td class=th>제목</td>
                                   <td class=th>조회수</td>
          					</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr>
							   <% 
								//out.println(list.size());
								if(record.length <= 0){ %>	
								<tr align=center height=28 align=center height=35>
									<td colspan="4" align="center" height="30">데이타가 존재하지 않습니다.</td>
								</tr>
								<tr>
								    <td colspan="4" height=1 class=linec1></td>
								</tr>
								<%
								}else{
									//리스트 화면에 전시
									for(int i=0;i<record.length; i++){ 
										Tbrd_board_ma_bean tbean = record[i];
										board_seq			= tbean.getBoard_seq();
										ref_no				= tbean.getRef_no(); 
										read_num			= tbean.getRead_num(); 
										title				= tbean.getTitle(); 
										content				= tbean.getContent(); 
										use_yn				= tbean.getUse_yn(); 
										user_id				= tbean.getUser_id();
										type_code				= tbean.getType_code();
										if(type_code.equals("01")){  type_name = "육로관광";
										}else if(type_code.equals("02")){ type_name = "예약신청/취소";
										}else if(type_code.equals("03")){ type_name = "관광요금";
										}else if(type_code.equals("04")){ type_name = "여행준비";
										}else if(type_code.equals("05")){ type_name = "현지관광";
										}else if(type_code.equals("06")){ type_name = "세관출입국";
										}else if(type_code.equals("07")){ type_name = "현대아산";
										}else if(type_code.equals("08")){ type_name = "기타";
										}else{ type_name = "기타";
										}

										String reg_date_string = tbean.getReg_date_String();
										String re_img	= BoardUtil.getReImg(0,0,imageServer);
										String new_img	= BoardUtil.getNewArticle(reg_date_string,imageServer);
								%>
          					
          					<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                                   <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
                                   <td><%=type_name%></td>
                                   <td align=left><a href="tour_question_edit.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><%=Util.getStringLimit(title,30)%></a></td>
                                   <td><%=read_num%></td>
          					</tr>
          					<tr><td colspan=4 height=1 class=linec1></td></tr>
          						<%
									}
								}
								
								%>
          				</table>
          				
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
                                    <td width=50%></td>
                                    <td align=center>
                                    <!--페이징 -->
          					        <table width=600 border=0 cellspacing=0 cellpadding=0>
          					         <tr>
          						        <td align=center>
          						       <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "tour_question.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
                                           </td>
                                        </tr>
                                       </table>
                                       <!--페이징 -->
                                    </td>
                                    <td width=50% align=right></td>
          					</tr>
          					<tr>
          					  <td colspan=2 align=right>
          					    <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value="신규등록" class="btn" onclick="location.href='tour_question_edit.jsp'" onfocus="this.blur();"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>  
          					  </td>
          					</tr>
          				</table>
                              <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          				<tr>
          					<td align=right>
							<!--검색 START -->
							  <FORM METHOD=POST NAME=searchForm ACTION="tour_question.jsp">
          						<table border=0 cellspacing=0 cellpadding=0>
          						<tr>
          						  <td>
                                          <select name="searchTypeCode" style='width:80;'>
											<option value=''>분류선택</option>
											 <option <%if(searchTypeCode.equals("01")){%>selected<%}%>  value="01">육로관광</option>
											 <option <%if(searchTypeCode.equals("02")){%>selected<%}%>  value="02">예약신청/취소</option>
											 <option <%if(searchTypeCode.equals("03")){%>selected<%}%>  value="03">관광요금</option>
											 <option <%if(searchTypeCode.equals("04")){%>selected<%}%>  value="04">여행준비</option>
											 <option <%if(searchTypeCode.equals("05")){%>selected<%}%>  value="05">현지관광</option>
											 <option <%if(searchTypeCode.equals("06")){%>selected<%}%>  value="06">세관출입국</option>
											 <option <%if(searchTypeCode.equals("07")){%>selected<%}%>  value="07">현대아산</option>
											 <option <%if(searchTypeCode.equals("08")){%>selected<%}%>  value="08">기타</option>
											</select>
                                        
                                        <input type=text style='width:200;' name="keyword"  value="<%=keyword%>" >
                                        <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value="검색" class="btn" onclick="goSearch()" onfocus="this.blur();"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                                        <td>                                  
          						</tr>
          						</table>
							  </FORM>
							  <!--검색 END -->
          					</td>
          				</tr>
          				<tr><td height=6></td></tr>
          				</table>                        
          			 </td>
          		   </tr>
          		</table>
          	 </TD>
          	<!-- //main -->
               </TR>
            </TABLE>    
          <!--// IMJK END -->
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="E4E3C3" height="10"></td>
  </tr>
  <tr>
    <td  height="15"></td>
  </tr>
  <tr>
    <td height="30"  bgcolor="D4D4B2">
		<jsp:include page="/asanway/common/copyright.jsp" flush="true" />
    </td>
  </tr>
</table>
<iframe id='uframe' name='uframe' src='about:blank' width=0 height=0 frameborder=0 border=0></iframe>
</body>
</html>
