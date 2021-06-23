<%--
  - 작성자: 임형수
  - 일자: 2006.05.26
  -수정자 : 이소연 (2006.08)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 신규등록 or 수정
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
int position = Util.parseInt(request.getParameter("position"), 1);
String searchTypeCode    	= ParamUtil.getReqParameter(request.getParameter("searchTypeCode"));
// 검색 - 파라메터
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;
//페이지 페라메터
String page_str = "&page="+requestedPage+"&position="+position;

//변수 선언
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_code = "";
String type_name = "";
int prev_board_seq  = 0;
int next_board_seq	= 0;
String prev_title		= "";
String next_title		= "";
String gubun			= "";

//DAO
BestQuestion dao = new BestQuestion();
CommonBoard commonDao = new CommonBoard();


Tbrd_board_ma_bean[] record = dao.getPrevAndNextBoard(board_seq);

int totalCount = record.length;

//추천일때는 조회 회수 증가하지 않는다.
if(!cmd.equals("recomm")){
   commonDao.updateReadnum(board_seq);
}
	

for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = record[i];

	gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){

		title						= tbean.getTitle();
		content					= tbean.getContent();
		//content					= content.replaceAll("\"", "'");
		user_id					= tbean.getUser_id();
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		use_yn					= tbean.getUse_yn();
		type_code					= tbean.getType_code();

	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

content = Util.encodeHTMLSpecialChar(content,11);



if (board_seq > 0){
	
	cmd = "edit";
}else{
	cmd = "insert";
}


%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	


	f = document.mainForm;

    if(f.type_code.value==""){
		alert("분류를 선택하여 주세요.");
		f.type_code.focus();
		return false;
	}


	if(f.title.value==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return false;
	}
	
	
  
    if(f.content.value==""){
		alert ("내용을 입력해주세요");
		f.content.focus();
		return;
	}

	f.submit();

}


function del(){
	f = document.mainForm;
	if(confirm("게시물을 삭제하시겠습니까?")){
		f.cmd.value = "del";
	    f.submit();
	}else{
		return;
	}
	
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
          		        <TD height=50 align=right style='padding-top: 10'>
          		        <img src="<%=imageServer%>tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>고객센터</A> > 
          		        <span class=locon>자주묻는질문</A> </span></TD>
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
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>자주묻는질문</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>

							<FORM METHOD=POST name="mainForm" ACTION="tour_question_ok.jsp" >
							<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>분류</td>
                					<td class=lpad10>
                                    <select name="type_code" style='width:80;'>
                                    <option value=''>분류선택</option>
									 <option <%if(type_code.equals("01")){%>selected<%}%>  value="01">육로관광</option>
                                     <option <%if(type_code.equals("02")){%>selected<%}%>  value="02">예약신청/취소</option>
									 <option <%if(type_code.equals("03")){%>selected<%}%>  value="03">관광요금</option>
									 <option <%if(type_code.equals("04")){%>selected<%}%>  value="04">여행준비</option>
									 <option <%if(type_code.equals("05")){%>selected<%}%>  value="05">현지관광</option>
									 <option <%if(type_code.equals("06")){%>selected<%}%>  value="06">세관출입국</option>
									 <option <%if(type_code.equals("07")){%>selected<%}%>  value="07">현대아산</option>
									 <option <%if(type_code.equals("08")){%>selected<%}%>  value="08">기타</option>
                                    </select>
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10>
                					<input type=text name=title style=width:450; value="<%=title%>">
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>내용</td>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <textarea name=content cols=75 rows=10><%=content%></textarea>
                                 </td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                			</table>

							<!--이전글,다음글 START -->
							<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
                                  <%if(prev_board_seq>0){%> 
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value='<<이전'  class=btn onclick="location.href='tour_question_edit.jsp?board_seq=<%=prev_board_seq%><%=key_str%><%=page_str%>'" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <%}%>
								  <%if(next_board_seq>0){%>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value='다음>>'  class=btn onclick="location.href='tour_question_edit.jsp?board_seq=<%=next_board_seq%><%=key_str%><%=page_str%>'" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <%}%>
								  </td>
                				</tr>
                			</table>
							<!--
							//제목과 함께 이전 다음 보여주기
							<table width=100% border=0 cellspacing=0 cellpadding=0>
								<tr>
								<td colspan=8>
									<table cellpadding="0" cellspacing="0" width="640">
										<tr>
											<td width="90" height="25" background="<%=imageServer%>/admin/a_cellbg25.gif">
												<p><img src="<%=imageServer%>a_up.gif" align="absmiddle" width="20" height="20" border="0">이전글</p>
											</td>
											<td background="<%=imageServer%>a_cellbg25.gif">
												<p>: <%if(prev_board_seq>0){%> <a href="tour_question_edit.jsp?board_seq=<%=prev_board_seq%><%=key_str%><%=page_str%>">&nbsp;<%=Util.getStringLimit(prev_title.trim(),40)%></a> <%}else{%> 이전글이 없습니다. <% } %></p>
											</td>
										</tr>
										<tr>
											<td width="90" height="25">
												<p><img src="<%=imageServer%>a_down.gif" align="absmiddle" width="20" height="20" border="0" alt="다운">다음글</p>
											</td>
											<td>
												<p>: <%if(next_board_seq>0){%> <a href="tour_question_edit.jsp?board_seq=<%=next_board_seq%><%=key_str%><%=page_str%>">&nbsp;<%=Util.getStringLimit(next_title.trim(),40)%></a> <%}else{%> 다음글이 없습니다. <% } %></p>
											</td>
										</tr>
									</table>
								</td>
							    </tr>
							</table>-->
                            <!--이전글,다음글 END -->

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  <% if(board_seq <= 0){ %>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=등록  class=btn onclick="javascript:chk(this)" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <%  }else{%>
								   <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=수정  class=btn onclick="javascript:chk(this)" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								    <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=삭제  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <%}%>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_question.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
                                 </td>
                				</tr>
                			</table>
                            </FORM>

                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
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
