<%--
  - 작성자: 박상배
  - 일자: 2006.05.26
   - 에러 수정자 : 이소연 (2006.07, 2006.08)
  - 저작권 표시: IMJ Korea
  - 설명: 사용자 - 여행후기 게시판 상세보기
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourReview"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>
<%
int board_seq		= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));

String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	

String key_str = "&part="+part+"&keyword="+keyword;
String board_type	= "01";

//############### Connection생성 ##########################
TourReview dao	= new TourReview();
//#########################################################


int ref_no				= 0;
int level_no			= 0;
int sort_no				= 0;
String title			= "";
String content			= "";
String user_id			= "";
String user_name		= "";
String user_nick		= "";
String user_level		= "";
String user_icon		= "";
String regdate			= "";
int read_num			= 0;
int recomm_num			= 0;
int comment_num			= 0;
String notice_from		= "";
String notice_to		= "";
int board_top_no		= 0;
String edit_yn			= "";
String use_yn			= "";
int point				= 0;
String password			= "";
String isbest			= "";

int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";

Tbrd_board_ma_bean[] record = dao.getPrevAndNextBoard(board_seq);

int totalCount = record.length;


dao.updateReadnum(board_seq);
	
for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = record[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		ref_no					= tbean.getRef_no();
		level_no				= tbean.getLevel_no();
		sort_no					= tbean.getSort_no();
		title					= tbean.getTitle();
		content					= tbean.getContent();
		
		user_id					= tbean.getUser_id();
		user_name				= tbean.getUser_name();
		user_nick				= tbean.getUser_nick();
		user_level				= tbean.getUser_level();
		user_icon				= tbean.getUser_icon();
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		recomm_num				= tbean.getRecomm_num();
		comment_num				= tbean.getComment_num();
		board_top_no			= tbean.getBoard_top_no();
		edit_yn					= tbean.getEdit_yn();
		use_yn					= tbean.getUse_yn();
		point					= tbean.getPoint();
		password				= tbean.getPassword();
		isbest					= tbean.getBest().trim();
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

content = Util.encodeHTMLSpecialChar(content,11);
%>
<html>
<head>
<link rel=stylesheet href=../css/tour_admin.css type=text/css>
<SCRIPT LANGUAGE="JavaScript">
<!--
function best(){
	var obj = document.f1;
	
	var val = obj.bestidx.checked;
	if(val){
		if(confirm("Best 게시물로 선정하시겠습니까?")){
			obj.mode.value = "1";
			obj.cmd.value = "choicebest";
			obj.action = "tour_review_ok.jsp";
			obj.submit();
		}else{
			obj.bestidx.checked = false;
		}
	}else{
		if(confirm("Best 게시물로 선정을 해제하시겠습니까?")){
			obj.mode.value = "0";
			obj.cmd.value = "choicebest";
			obj.action = "tour_review_ok.jsp";
			obj.submit();
		}else{
			obj.bestidx.checked = true;
		}
	}
}

function openDel(){
	var obj = document.delform;
	if(confirm("정말 삭제하시겠습니까? 원본게시물 삭제 시 답글,댓글도 삭제됩니다. ")){
		obj.cmd.value = "del";
		obj.action = "tour_review_ok.jsp";
		obj.submit();
	}else{
		return;
	}
}

function resize_frame(){
	
	var name = "myframe";
	
	var oBody =  document.frames[name].document.body;
	var oFrame =  document.all[name];

	oFrame.style.height =  oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);	
}
//코멘트 웹페이지 싸이즈 게산 2
function resize_frame1(){
	myframe.history.go(0);
	var name = "myframe";	
	var oBody =  document.frames[name].document.body;
	var oFrame =  document.all[name];
	
	//oFrame.style.height =  453;
	oFrame.style.height =  oBody.scrollHeight + (oBody.offsetHeight-oBody.clientHeight);	
}

//-->
</SCRIPT>
<%@ include file="/asanway/common/head.jsp" %>

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
          		        <img src="../img/tour_img//bu_sky.gif" align=absmiddle hspace=3><A HREF=# class=loc>홈</A> > 
          		        <A HREF=# class=loc>커뮤니티</A> > 
          		        <span class=locon>여행후기</span>
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
                				<td class='title'><img src=../img/tour_img//bu_blue_title.gif align=texttop class=rmar10>여행후기</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=8 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10 colspan=7>
                					<%=title%>
                					</td>
                				</tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>작성자</td>
                					<td class=lpad10><%=user_name%>(<%=user_id%>)</td>
                					<td class='tdcolor th' align=center>등록일</td>
                					<td class=lpad10><%=regdate%></td>
                					<td class='tdcolor th' align=center>조회</td>
                					<td class=lpad10><%=read_num%></td>
                					<td class='tdcolor th' align=center>추천</td>
                					<td class=lpad10><%=recomm_num%></td>
                				</tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>         				    
                				<tr height=28>
                                 <td  colspan=8 class=lpad10 style='padding-top:7;padding-bottom:7;' height=300 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				<tr><td colspan=8 height=1 class=linec1></td></tr>
                				<FORM METHOD=POST name="f1">
								<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
								<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
								<INPUT TYPE="hidden" name="part" value="<%=part%>">
								<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
								<INPUT TYPE="hidden" name="cmd">
								<INPUT TYPE="hidden" name="mode">
	
                				<tr height=28 >
                                 <td class='tdcolor th'colspan=8>
								 <%// if(isbest.equals("0")){ %>
                                 <input type=checkbox name=bestidx value=<%=board_seq%> <%if(isbest.equals("1")){%>checked<%}%> onClick="javascript:best();"><b>Best 게시물로 선정</b>
								 <%// } %>
                                 </td>
                				</tr>     
                				</FORM>    				
                				<tr><td colspan=8 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                					<td align=right> 
                						<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=확인 onclick="javascript:best();" class=btn ><img src=../img/tour_img/btn_r.gif align=absmiddle><img src=../img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                						<img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=삭제 onclick="javascript:openDel()" class=btn ><img src=../img/tour_img//btn_r.gif align=absmiddle><img src=../img/tour_img//btn_r.gif align=absmiddle style=margin-right:1;>
                						<a href="tour_review.jsp"><img src=../img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_review.jsp'"></a><img src=../img/tour_img/btn_r.gif align=absmiddle>
                					</td>
                				</tr>
                			</table>
                
                			<table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
                		</td>
                	</tr>
                	</table>
					<br>
					<iframe id="myframe" src="listComment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
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
<FORM METHOD=POST name="delform">
<INPUT TYPE="hidden" name="cmd">
<INPUT TYPE="hidden" name="board_seq" value=<%=board_seq%>>
</FORM>
</body>
</html>
