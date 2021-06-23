<%--
  - 작성자: 임형수
  - 일자: 2006.06.07
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 고객센터>묻고답하기 상세보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
int position = Util.parseInt(request.getParameter("position"), 1);
// 검색 - 파라메터
String key_str = "&part="+part+"&keyword="+keyword;
//페이지 페라메터
String page_str = "&page="+requestedPage+"&position="+position;

//변수 선언
String cmd	= "edit";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
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
boolean editYn = false; //답변가능여부
boolean deleteYn = false; //답변가능여부
String user_name =""; 
String email =""; 
String tel =""; 

//DAO
QnABoard dao = new QnABoard();
CommonBoard commonDao = new CommonBoard();
//DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title	= bean[0].getTitle();
	content	= bean[0].getContent();
	//content= content.replaceAll("\"", "'");
	user_id	= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate	= bean[0].getReg_date_String();
	read_num= bean[0].getRead_num();
	use_yn	= bean[0].getUse_yn();
	open_yn	= bean[0].getOpen_yn();
    ref_no	=  bean[0].getRef_no();
    replyRegdate  = ParamUtil.getReqParameter(bean[0].getReply_reg_date_String());
	reply_yn=  bean[0].getReply_yn();
	if(reply_yn.equals("0")){replyRegdate="";}
	reply_content=  bean[0].getReply_content();
    reply_content= reply_content.replaceAll("\"", "'");
	email	= bean[0].getEmail();
	tel	= bean[0].getTel();

	//조회수 증가
    commonDao.updateReadnum(board_seq);

//답변 등록 되지 않았을 경우 수정 가능 
if(reply_yn.equals("0")){
	//로그인한 사람과 글쓴이가 같아야 수정가능
	if(user_id.equals(session_id))
	{  
	   editYn = true;
	   deleteYn = true;
     }

	 //비회원이 등록한 글일때 수정가능
	 if(user_id.equals("")){
	     editYn = true;
		 deleteYn = false;
	 }

}else{}






%>
<html>
<head>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	f = document.mainForm;
	f.submit();
}


function del(){

	f = document.mainForm;
	if(confirm("게시물을 삭제하시겠습니까?")){
		f.cmd.value = "del";
		f.action="qna_ok.jsp";
	    f.submit();
	}else{
		return;
	}
}

//-->
</SCRIPT>
</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
				<FORM METHOD=POST name="mainForm" ACTION="qna_edit.jsp" >
					<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
					<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
					<INPUT TYPE="hidden" name="part" value="<%=part%>">
					<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
					<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                    <INPUT TYPE="hidden" name="position" value="<%=position%>">

                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>묻고답하기</td>
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
                					<td class=lpad10>
										<!--회원-->
										<% 
											if(!user_id.equals("")){%>
											<%=user_name%>(<%=user_id%>)
										<%}else{%>
										   <!--비회원-->
											<%=user_name%>
										<%}%>
									</td>
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
									<td class='tdcolor th' align=center></td>
                					<td class=lpad10></td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>문의내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
								<!--답변 등록되어 있을 경우 보임 -->
								<%if(reply_yn.equals("1")){%>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>답변내용</td>
                                 <td colspan=4 class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top>
                                 <%=reply_content%>
                                 </td>
                				</tr>
								<%}%>
                				<tr><td colspan=6 height=1 class=linec1></td></tr>
                				
                				
                				
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right>
										<% if(editYn){ %>
									      <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=수정하기  class=btn onclick="javascript:chk(this)" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
										<%}%>
										 <% if(deleteYn){%>
										 <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=삭제하기  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
									    <%}%>
										<img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='qna_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
									 
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
</BODY>
</HTML>