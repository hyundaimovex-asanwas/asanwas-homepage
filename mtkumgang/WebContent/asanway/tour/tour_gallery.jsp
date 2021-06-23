<%--
  - 작성자: 
  - 일자: 2006.05.29
  - 수정자: 이소연 (2006.08)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 커뮤니티>회원 갤러리 리스트
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
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
String keyword    =  Util.toKSC(ParamUtil.getReqParameter(request.getParameter("keyword")));

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
int allCount = dao.getTotalCount(part,keyword);
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


// 게시물 목록
Tbrd_board_ma_bean record [] = dao.getList(rowsPerPage, requestedPage, part, keyword );



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
function goSearch(){
	f = document.searchForm;
	if(f.part.value==""){
		alert("검색종류를 선택하여 주십시요.");
		f.part.focus();
		return false;
	}
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
          	        <A HREF=# class=loc>커뮤니티</A> > 
          	        <span class=locon>회원갤러리</span>
          	        </TD>
                    </TR>
                 <!-- //loc -->
                 </TABLE>
                 </TD>
              </TR>
          <TR valign=top>
          	<!-- main -->
          
          	<TD width=650 valign=top>
          		<table width=100% border=0 cellspacing=0 cellpadding=0>
          		<tr>
          			<td>
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          				<tr>
          					<td class='title'><img src='<%=imageServer%>tour_img/bu_blue_title.gif' align=texttop class=rmar10>회원갤러리</td>
          				</tr>
          				</table>
          				<br>
 
						 <!--게시판 리스트 -->               
						<table cellpadding=0 cellspacing=0 border=0 width=100%>
						<col width=300><col width=20><col width=300>
						<% 						
						if(record.length <= 0){ %>
							<div align="center">등록된 데이터가 없습니다.</div>
						  <tr>
						    <td colspan="3" class=linec1  height="1"></td>
						  </tr>									
						<%
						}else{
							int a_table = 0;
							//리스트 화면에 전시
							for(int i=0;i<record.length; i++){ 
								Tbrd_board_ma_bean tbean = record[i];
								
								board_seq			= tbean.getBoard_seq();
								ref_no				= tbean.getRef_no(); 
								read_num			= tbean.getRead_num(); 
								title					= tbean.getTitle(); 
								content				= tbean.getContent(); 
								user_name			= tbean.getUser_name(); 
								user_id				= tbean.getUser_id(); 
								regdate				= tbean.getReg_date_String();
								
								virtual_name	= ParamUtil.getReqParameter(tbean.getVirtual_name());
								real_name			= ParamUtil.getReqParameter(tbean.getReal_name());
								
								String img_name = "";
								
								if(virtual_name.equals("")){
									img_name = imageServer+"noimage.gif";
								}else{
									img_name = virtual_name;	
								}
								
								a_table = (i+1) % 5;
						%>
						
						<% if(a_table == 1){ %>
						<tr>
						<% } %>
						<td width="200" align="center">

							<table width="123" border="0" cellspacing="0" cellpadding="0">
						  <tr> 
						    <td colspan="3">
						      <div style="border:1px solid;border-color:#D0D0D0;width:123;height:93;">
						      	<a href="tour_gallery_edit.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>">
						      	<img src="<%=img_name%>" width="123" height="93" border="0">
						        </a>
						      </div>
						    </td>
						  </tr>
						  <tr>
						    <td colspan="3" height="10"></td>
						  </tr>
						  <tr> 
						    <td width="3" rowspan="3"></td>
						    <td width="117"><a href="tour_gallery_edit.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><u><%=Util.getStringLimit((title).trim(),8)%></u></a></td>
						    <td width="3" rowspan="3"></td>
						  </tr>
						  <tr> 
						    <td><%=user_name%>(<%=user_id%>)</td>
						  </tr>
						  <tr> 
						    <td><%=Util.replaceAll(regdate,"-",".")%> </td>
						  </tr>
						</table>
						
						
					</td>
					<% if(a_table == 1){ %>
					<td></td>
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
						<tr><td height=20 colspan=4></td></tr>
						<tr><td height=1 class=board_line colspan=4></td></tr>
						<tr><td height=15 colspan=4></td></tr>
						<% 
							}
						} 
						%>
				<%
					}
				}
				
				%>
          				
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          					<tr>
                                    <td width=50%></td>
                                    <td align=center>
                                    <!--페이징 -->
          					        <table width=600 border=0 cellspacing=0 cellpadding=0>
          					         <tr>
          						        <td align=center>
          						       <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "tour_gallery.jsp", "500", key_str ,
			                      imageServer+"/imjk_img/", blockPerPage)%>
                                           </td>
                                        </tr>
                                       </table>
                                       <!--페이징 -->
                                    </td>
                                    <td width=50% align=right></td>
          					</tr>
          					<tr>

          					</tr>
          				</table>
                              <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
          				<table width=100% border=0 cellspacing=0 cellpadding=0>
          				<tr>
          					<td align=right>
							<!--검색 START -->
							  <FORM METHOD=POST NAME=searchForm ACTION="tour_gallery.jsp">
          						<table border=0 cellspacing=0 cellpadding=0>
          						<tr>
          						  <td>
                                          <select name="part" style='width:80;'>
                                          <option <%if(part.equals("")){%>selected<%}%>  value=''>선택</option>
                                          <option <%if(part.equals("1")){%>selected<%}%> value='1'>제목</option>
                                          <option <%if(part.equals("2")){%>selected<%}%> value='2'>이름</option>
                                          <option <%if(part.equals("3")){%>selected<%}%> value='3'>아이디</option>
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

