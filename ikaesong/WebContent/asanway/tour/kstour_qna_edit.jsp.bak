<%--
  - 작성자: 임형수
  - 일자: 2006.05.26
  -수정자: 이소연 (2006.8)
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>Q N A 신규등록 or 수정
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.KsQnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
int position = Util.parseInt(request.getParameter("position"), 1);
String key_str = "&part="+part+"&keyword="+keyword;
String page_str = "&page="+requestedPage+"&position="+position;


//변수 선언
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String user_name = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_code = "";
String type_name = "";
int ref_no= 0;
String open_yn = "0";
String reply_yn = "0";
String replyRegdate="";
String reply_content="";
String email = "";
String tel = "";
String open_yn_name = "공개";

int prev_board_seq  = 0;
int next_board_seq	= 0;
String prev_title		= "";
String next_title		= "";
String gubun			= "";


//DAO
KsQnABoard dao = new KsQnABoard();
CommonBoard commonDao = new CommonBoard();

Tbrd_board_ma_bean[] record = dao.getBoardView(board_seq);

int totalCount = record.length;

//추천일때는 조회 회수 증가하지 않는다.
if(!cmd.equals("recomm")){
   commonDao.updateReadnum(board_seq);
}


for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = record[i];

	gubun = tbean.getGubun();
	
	//if(gubun.equals("NOW")){

		title						= tbean.getTitle();
		content					= tbean.getContent();
		//content					= content.replaceAll("\"", "'");
		user_id					= tbean.getUser_id();
		user_name					= tbean.getUser_name();
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		use_yn					= tbean.getUse_yn();
		open_yn					= tbean.getOpen_yn();
		ref_no				=  tbean.getRef_no();
		replyRegdate  = ParamUtil.getReqParameter(tbean.getReply_reg_date_String());
		reply_yn				=  tbean.getReply_yn();
		if(reply_yn.equals("0")){replyRegdate="N";}
		reply_content				=  tbean.getReply_content();
		//reply_content					= reply_content.replaceAll("\"", "'");
		email = tbean.getEmail();
		tel = tbean.getTel();
	   
		if(open_yn.equals("0")) open_yn_name = "비공개"; 


		//답변 등록된 상태
		if(reply_yn.equals("1")){
			cmd = "editReply";
		}else{
			cmd = "insertReply";
		}

		

	//}else if(gubun.equals("PREV")){
	//	prev_board_seq	= tbean.getBoard_seq();
	//	prev_title			= tbean.getTitle();
	//}else if(gubun.equals("NEXT")){
	//	next_board_seq	= tbean.getBoard_seq();
	//	next_title			= tbean.getTitle();
	//}
}	

content = Util.encodeHTMLSpecialChar(content,11);



%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<%@ include file="/asanway/common/head.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!--

function chk(){	
	
	f = document.mainForm;

  
    if(f.reply_content.value==""){
		alert ("답변 내용을 입력해주세요");
		f.reply_content.focus();
		return;
	}

	if(confirm("답변이 이메일로 발송됩니다. 등록하시겠습니까?")){
	    f.submit();
	}else{
		return;
	}



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
          		        <img src="../img/tour_img/bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>고객센터</A> > 
          		        <span class=locon>묻고답하기</span>
          		        </TD>
          	          </TR>
          	       <!-- //loc -->
          	       </TABLE>
                  </TD>
               </TR>
          	<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
				<FORM METHOD=POST name="mainForm" ACTION="kstour_qna_ok.jsp" >
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="part" value="<%=part%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
					<INPUT TYPE="hidden" name="open_yn" value="<%=open_yn%>">
					<INPUT TYPE="hidden" name="user_name" value="<%=user_name%>">
					<INPUT TYPE="hidden" name="user_id" value="<%=user_id%>">
					<INPUT TYPE="hidden" name="email" value="<%=email%>">

                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../img/tour_img/bu_blue_title.gif align=texttop class=rmar10>묻고답하기</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=6 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10 colspan=7>
                					<%=title%>
                					</td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>작성자</td>
                					<td class=lpad10><%=user_name%>(<%=user_id%>)</td>
                					<td class='tdcolor th' align=center>등록일</td>
                					<td class=lpad10><%=regdate%></td>
                					<td class='tdcolor th' align=center>답변일</td>
                					<td class=lpad10><%=replyRegdate%></td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>    
                				<tr height=28>
                					<td class='tdcolor th' align=center>이메일</td>
                					<td class=lpad10><%=email%></td>
                					<td class='tdcolor th' align=center>연락처</td>
                					<td class=lpad10><%=tel%></td>
									<td class='tdcolor th' align=center>공개여부</td>
                					<td class=lpad10><%=open_yn_name%>
									<!--
									<select name="open_yn" style='width:80;'>
									<option value=''>공개여부</option>
									 <option <%if(open_yn.equals("1")){%>selected<%}%>  value="1">Y</option>
                                     <option <%if(open_yn.equals("0")){%>selected<%}%>  value="0">N</option>
                                    </select>
									-->
									</td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>문의내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>답변내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <textarea name=reply_content cols=75 rows=10><%=reply_content%></textarea>
                                 </td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
                			</table>


							<!--이전글,다음글 START -->
							<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
                                  <%if(prev_board_seq>0){%> 
                                  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value='<<이전'  class=btn onclick="location.href='kstour_qna_edit.jsp?board_seq=<%=prev_board_seq%><%=key_str%><%=page_str%>'" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                                  <%}%>
								  <%if(next_board_seq>0){%>
								  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value='다음>>'  class=btn onclick="location.href='kstour_qna_edit.jsp?board_seq=<%=next_board_seq%><%=key_str%><%=page_str%>'" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
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
												<p>: <%if(prev_board_seq>0){%> <a href="kstour_qna_edit.jsp?board_seq=<%=prev_board_seq%><%=key_str%><%=page_str%>">&nbsp;<%=Util.getStringLimit(prev_title.trim(),40)%></a> <%}else{%> 이전글이 없습니다. <% } %></p>
											</td>
										</tr>
										<tr>
											<td width="90" height="25">
												<p><img src="<%=imageServer%>a_down.gif" align="absmiddle" width="20" height="20" border="0" alt="다운">다음글</p>
											</td>
											<td>
												<p>: <%if(next_board_seq>0){%> <a href="kstour_qna_edit.jsp?board_seq=<%=next_board_seq%><%=key_str%><%=page_str%>">&nbsp;<%=Util.getStringLimit(next_title.trim(),40)%></a> <%}else{%> 다음글이 없습니다. <% } %></p>
											</td>
										</tr>
									</table>
								</td>
							    </tr>
							</table>
							-->
                            <!--이전글,다음글 END -->

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right>
									<!--
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=확인 onclick="location.href='tour_review_edit.jsp'" class=btn ><img src=../img//tour_img/btn_r.gif align=absmiddle><img src=../img//tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="javascript:openDel()" class=btn ><img src=../img//tour_img/btn_r.gif align=absmiddle><img src=../img//tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img//tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_review.jsp'"><img src=../img//tour_img/btn_r.gif align=absmiddle>
										-->
										<% if(use_yn.equals("1")){%>
											<% if(reply_yn.equals("0") ){ %>
											  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=답변등록  class=btn onclick="javascript:chk(this)" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
											<%  }else{%>
											  <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=답변수정  class=btn onclick="javascript:chk(this)" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
											<%}%>
										     <img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=질문삭제  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
									     <%}%>
										<img src=<%=imageServer%>/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='kstour_qna.jsp'"><img src=<%=imageServer%>/tour_img/btn_r.gif align=absmiddle>         					
									 
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
