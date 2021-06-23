<%--
  - 작성자: 임형수
  - 일자: 2006.05.26
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 신규등록 or 수정
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));

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
String virtual_name	= "";
String real_name		= "";
int recomm_num = 0;

if (board_seq > 0){
	//DAO
	TourGalleryBoard dao = new TourGalleryBoard();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	user_name					= bean[0].getUser_name();
	virtual_name = bean[0].getVirtual_name();
	real_name   = bean[0].getReal_name();
    recomm_num = bean[0].getRecomm_num();

	

	cmd = "edit";
}else{
	cmd = "insert";
	regdate = Util.getDate();
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



//이미지 싸이즈 고정
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 450){
		obj.width = 450;
	}
}


//코멘트 웹페이지 싸이즈 게산 1 
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
          		        <span class=locon>회원겔러리</A> </span></TD>
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
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>회원겔러리</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>

							<FORM METHOD=POST name="mainForm" ACTION="tour_gallery_ok.jsp" >
							<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
							<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=8 height=2 class=linec1></td></tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>제목</td>
                					<td class=lpad10 colspan=7>
                					<input type=text name=title style=width:300; value="<%=title%>">
                					</td>
                				</tr>
								<tr><td colspan=8 height=1 class=linec0></td></tr>
								<tr height=28>
                					<td class='tdcolor th' align=center>작성자</td>
                					<td class=lpad10>
                					   <%=user_name%>(<%=user_id%>)
                					</td>
									<td class='tdcolor th' align=center>등록일</td>
                					<td class=lpad10>
                					  <%=regdate%>
                					</td>
									<td class='tdcolor th' align=center>조회</td>
                					<td class=lpad10>
                					  <%=read_num%>
                					</td>
									<td class='tdcolor th' align=center>추천</td>
                					<td class=lpad10>
                					   <%=recomm_num%>
                					</td>
                				</tr>
                				<tr><td colspan=8 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>내용</td>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=100 valign=top colspan=7>
                                 <textarea name=content cols=60 rows=10><%=content%></textarea>
                                 </td>
                				</tr>
                				<tr><td colspan=8 height=1 class=linec1></td></tr>
								<tr><td colspan=8 height=1 class=linec1></td></tr>
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
								  
								    <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=삭제  class=btn onclick="javascript:del()" ><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
								  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=목록 class=btn onclick="location.href='tour_gallery.jsp'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
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

		   		<!-- 코멘트 START -->
				<table width=100% border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>
								<iframe id="myframe" src="tour_gallery_comment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
						</td>

					</tr>
			    </table>
                <!--  코멘트 END -->


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
