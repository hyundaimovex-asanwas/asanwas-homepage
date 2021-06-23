<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//변수 선언
 
int comment_seq=0;
String user_id="";
String user_name="";
String content="";
String title				= ""; 
String use_yn				= "";
String regdate			= "";
String virtual_name	= "";
String real_name		= "";
int star_aver = 0;
int pageSize			= 5;
int blockSize			= 10;
//게시판 타입결정
String boardType	= "04";
boolean deleteYn =false;

// DAO   
TourGalleryBoard dao = new TourGalleryBoard();

int board_seq = Util.parseInt(request.getParameter("board_seq"), 0);

// 검색 - 컬럼명
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// 검색 - 검색어
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
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


// 게시물 목록
Tbrd_comment_de_bean record [] = dao.getCommentList(rowsPerPage, requestedPage, part, keyword ,board_seq);

// 전체 게시물 수
int allCount = dao.getCommentTotalCount(part, keyword ,board_seq );
// 전체 페이지 수
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// 게시물 번호 시작
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;

%>



<SCRIPT LANGUAGE="JavaScript">
<!--
function chk(){
	var obj = document.f1;

}



function resize_frame(){
	parent.resize_frame();
}

function resize_frame1(){
	parent.resize_frame1();
}

function moveNextObject(currObject)
{
	var strValue = currObject.value;
	var intDataLength = strValue.length;
	if(intDataLength > 100)
	{
		alert("댓글은 100자 이내로만 입력이 가능합니다.");
		currObject.value = strValue.substr(0, 100);
	}
	
}

function colDeleteComment(board_seq, comment_seq){
	if(confirm("삭제 하시겠습니까?")){
		document.f1.comment_seq.value = comment_seq;
		document.f1.board_seq.value = board_seq;
		document.f1.cmd.value = "deleteComment";
		document.f1.action = "tour_gallery_ok.jsp";
		document.f1.target = "ifr";
		document.f1.submit();

	}
}
//-->
</SCRIPT>
<body class="content_bg" onLoad="resize_frame();">


<link rel=stylesheet href=../../asanway/css/comment.css type=text/css>


<table width="100%" cellpadding="0" border="0" cellspacing="0" class="content_bg">
<FORM METHOD=POST name="f1" ACTION="tour_gallery_ok.jsp"  onsubmit="return chk();" >
	<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
	<INPUT TYPE="hidden" name="comment_seq" value="">
	<INPUT TYPE="hidden" name="cmd">
</FORM>
	<!-- 코멘트 리스트  START-->
	<tr>
		<td>
		<table width="640" cellpadding="0" cellspacing="0" border="0" >
			<% 						
				if(record.length <= 0){ 
			%>
			<tr>
				<td  align="center"  bgcolor="#F6F6F6">
					등록된 데이터가 없습니다.
				</td>
			</tr>

			<%
				}else{
			%>
			<tr><td background="<%=imageServer%>dot.gif" height="1" colspan="4"></td></tr>
			<%
					String starString = "";
					
					int listNum = 0;
					//리스트 화면에 전시
					for(int i=0;i<record.length; i++){ 
							  
						Tbrd_comment_de_bean tbean = record[i];
						comment_seq			= tbean.getComment_seq();
						content				= tbean.getContent(); 
						user_name			= tbean.getUser_name(); 
						user_id			= tbean.getUser_id(); 
						regdate				= tbean.getReg_date_String();
						listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));	
						
						
								
			%> 
					<tr> 
						<td width="50"  bgcolor="#F6F6F6"><strong><font color='#000000'><%=user_name%>(<%=user_id%>)</font></strong></td>		
						<td bgcolor="#F6F6F6"><%=content%>&nbsp; <%=regdate%>&nbsp;<img src="<%=imageServer%>btn_del05.gif" align="absmiddle" style="cursor:hand" onClick="javascript:colDeleteComment('<%=board_seq%>', '<%=comment_seq%>')"> 
						</td>
					</tr>
  
					<tr><td background="<%=imageServer%>dot.gif" height="1" colspan="4"></td></tr>
		
			<%
					} //for END
				}//if(record.length <= 0) END
			%>
		</table>
		</td>
	</tr>
    <!-- 코멘트 리스트  END-->

    <tr><td height="10"></td></tr>
    <% 						
		if(record.length > 0){ 
	%>         
	<!--/ PAGE 처리 START-->
	<tr>
		<td colspan="4" align="center" height="40">
			<table border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td  border="0" ><%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
									  "tour_gallery_comment.jsp", "500", key_str+"&board_seq="+board_seq ,
									  imageServer+"/imjk_img/", blockPerPage)%>
								  <!--END 페이징--></td>
				</tr>
			</table>
		</td>
	</tr>
	<!--/ PAGE 처리 END-->
	<% 
	}
	%>
</table>
<body>

<iframe name="ifr" width="0"  height="0" ></iframe>