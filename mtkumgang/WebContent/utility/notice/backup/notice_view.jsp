<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourNotice"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&part="+part+"&keyword="+keyword;

//변수 선언
String cmd			= "";
String board_type	= "";
String title		= "";
String content		= "";
String user_id		= "";
String user_name	= "";
String regdate		= "";
int read_num		= 0;
String use_yn		= "";
String type_code	= "";
String type_name	= "";
String virtual_name	= "";
String real_name	= "";
int recomm_num		= 0;

int prev_board_seq  = 0;
int next_board_seq	= 0;

String prev_title		= "";
String next_title		= "";


TourNotice dao = new TourNotice();

Tbrd_board_ma_bean[] recordview = dao.getPrevAndNextBoard(board_seq);

int totalCount = recordview.length;


for(int i=0; i<totalCount; i++){
	Tbrd_board_ma_bean tbean = recordview[i];
	String gubun = tbean.getGubun();
	
	if(gubun.equals("NOW")){
		title					= tbean.getTitle();
		content					= tbean.getContent();
		content					= content.replaceAll("\"", "'");
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		
	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	


%>
<html>
<head>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>

</head>

<body bgcolor="FCFCF6" text="#000000" leftmargin="0" topmargin="0">

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<TR valign=top>
                <!-- main -->
                <TD width=650 valign=top>
                	<table width=650 border=0 cellspacing=0 cellpadding=0>
                	<tr>
                		<td>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                			<tr>
                				<td class='title'><img src=../../asanway/img/tour_img/bu_blue_title.gif align=texttop class=rmar10>공지사항</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10>
                					<%=title%>
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>내용</td>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=300 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>이전글</td>
                					<td class=lpad10>
                					<%if(prev_board_seq > 0){%>
										<a href="tour_praise_view.jsp?board_seq=<%=prev_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=prev_title%></a>
									<% }else{ %>
										이전글이 존재하지 않습니다.
									<% } %>									
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>다음글</td>
                					<td class=lpad10>
                					<%if(next_board_seq > 0){%>
										<a href="tour_praise_view.jsp?board_seq=<%=next_board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=next_title%></a>
									<% }else{ %>
										다음글이 존재하지 않습니다.	
									<% } %>		
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec1></td></tr>                				                				
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
                                  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='notice_list.jsp?requestedPage=<%=requestedPage%><%=key_str%>'"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle>         					
                                 </td>
                				</tr>
                			</table>
                
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
