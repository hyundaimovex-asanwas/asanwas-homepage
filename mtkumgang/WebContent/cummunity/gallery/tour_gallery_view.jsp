<%-- 
  - 작성자: 임형수
  - 일자: 2006.05.26
  - 수정자:이소연(2006.07)  
  - 저작권 표시: IMJ Korea
  - 설명: 관리자 - 고객센터>자주 묻는 질문 신규등록 or 수정

  - 2009-10-14 심동현
  - 스크립트 치환자 함수 추가 (XSS방지)
--%>
<%@ page contentType="text/html;charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%> 
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="java.util.*"%>
<%
int board_seq			= ParamUtil.getIntParameter(request.getParameter("board_seq"));
int requestedPage	= ParamUtil.getIntParameter(request.getParameter("requestedPage"));
int position	= ParamUtil.getIntParameter(request.getParameter("position"));
String part			= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));	
String cmd		= ParamUtil.getReqParameter(request.getParameter("cmd"));	

String key_str = "&part="+part+"&keyword="+keyword;
//페이지 페라메터
String page_str = "&requestedPage="+requestedPage+"&position="+position;
String board_type	= "04";


TourGalleryBoard dao  = new TourGalleryBoard();
CommonBoard commonDao = new CommonBoard();


String title				= "";
String content			= "";
String user_id			= "";
String user_name		= "";
String regdate			= "";
int read_num				= 0;
int recomm_num			= 0;
int comment_num			= 0;
String use_yn				= "";
String password			= "";
int prev_board_seq  = 0;
int next_board_seq	= 0;
String prev_title		= "";
String next_title		= "";
String gubun			= "";

String type_name = "";
String virtual_name	= "";
String fullFilename	= "";
String real_name		= "";
boolean deleteYn =false;


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
	 
		//XSS 필터 적용
		title					= clearXSS(tbean.getTitle(),avatag);
		content					= clearXSS(tbean.getContent(),avatag);
		user_id					= tbean.getUser_id();
		user_name				= tbean.getUser_name();
		regdate					= tbean.getReg_date_String();
		read_num				= tbean.getRead_num();
		recomm_num			= tbean.getRecomm_num();
		comment_num			= tbean.getComment_num();
		use_yn					= tbean.getUse_yn();
		//자기가 쓴 글만 삭제 가능
	    if(user_id.equals(session_id)) deleteYn = true;

			

	}else if(gubun.equals("PREV")){
		prev_board_seq	= tbean.getBoard_seq();
		prev_title			= tbean.getTitle();
	}else if(gubun.equals("NEXT")){
		next_board_seq	= tbean.getBoard_seq();
		next_title			= tbean.getTitle();
	}
}	

content = Util.encodeHTMLSpecialChar(content,11);


Tbrd_attach_file_de_bean[] fileRecord = dao.getFileView(board_seq);


String McNum = "5";
String sub = "4";
String pageNum = "4";
String subNum = "1";
%>
<html>
<head>
<title> 금강산관광   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
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

function goRecomm(){
	f = document.mainForm;

    if(confirm("추천하시겠습니까?")){
		f.cmd.value = "recomm";
	    f.submit();
	}else{
		return;
	}



}

//이미지 싸이즈 고정
function resizeImg(obj){
	//a=document.images.i0;
	//alert(obj.width+'x'+obj.height+'='+obj.fileSize);
	if(obj.width > 600){
		obj.width = 600;
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

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/community/tour_gallery_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
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
<FORM METHOD=POST name="mainForm" ACTION="tour_gallery_ok.jsp" >
  <INPUT TYPE="hidden" name="cmd" value="">
  <INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
  <INPUT TYPE="hidden" name="part" value="<%=part%>">
  <INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
  <INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
  <input type="hidden" name="returnUri" value="<%=nowUri%>">	
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
						<col width="70"><col width="148" class="lpad_15 tpad_3">
						<col width="78"><col width="105" class="lpad_15 tpad_3">
						<col width="58"><col width="51" class="lpad_15 tpad_3">
						<col width="58"><col width="62" class="lpad_15 tpad_3">
						<tr><td height="2" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- 제목 --></td>
							<td colspan="7"><strong><%=title%></strong></td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_view02.gif"><!-- 작성자 --></td>
							<td><%=user_name%>(<%=user_id%>)</td>
							<td><img src="<%=imageServer%>/tour_img/txt_view03.gif"><!-- 등록일 --></td>
							<td><%=regdate%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view04.gif"><!-- 조회 --></td>
							<td><%=read_num%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view05.gif"><!-- 추천 --></td>
							<td><%=recomm_num%></td>
						</tr>
						<tr><td height="1" colspan="8" class="line_dg"></td></tr>
						<tr>
							<td colspan="8" style="padding:15 15 25 13px;" valign="top" height="230">
                             <% 
                             if(fileRecord != null){ 
                             %>
                                <%
                                StringBuffer sb = new StringBuffer();
                                for(int j=0; j<fileRecord.length; j++){
                                  Tbrd_attach_file_de_bean fbean = fileRecord[j];
                                  
                                  virtual_name		= Util.getString(fbean.getVirtual_name(),"");
                                  real_name			= Util.getString(fbean.getReal_name(),"");
                                  												
                                  String img_name =  virtual_name;
                                  
                                  
                                  sb.append("<option value='"+virtual_name+"'>"+real_name+"</option>");
                                  
                                %>
                                <table align=center cellpadding=0 cellspacing=0 border=0>
								  <tr height=9>
									<td></td>
								  </tr>
								  <tr>
									<td style="border:1 solid #333333"><img src="<%=img_name%>" onload=resizeImg(this) vspace="0"></td><!--&nbsp;이미지:<%=real_name%>-->
								  </tr>
								  <tr height=9>
									<td></td>
								  </tr>
								</table>
                                <br>      
                                <%
                                }
                                fullFilename = sb.toString();
                                %>
                             <%
                             } 
                             %>	
                             <br>
                             <%=content%>
                            </td>
						</tr>
						</table>
						<!-- view table / -->

						<!-- / 이전글,다음글  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td width="70" height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_prev.gif"></td>
							<td class="lpad_15 tpad_3">
							  <%if(prev_board_seq>0){%> <a href="tour_gallery_view.jsp?board_seq=<%=prev_board_seq%><%=key_str%><%=page_str%>" class="listtxt05">&nbsp;<%=Util.getStringLimit(prev_title.trim(),40)%></a> <%}else{%> 이전글이 없습니다. <% } %>
                            </td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right"><img src="<%=imageServer%>/tour_img/txt_next.gif"></td>
							<td class="lpad_15 tpad_3">
							<%if(next_board_seq>0){%> <a href="tour_gallery_view.jsp?board_seq=<%=next_board_seq%><%=key_str%><%=page_str%>" class="listtxt05">&nbsp;<%=Util.getStringLimit(next_title.trim(),40)%></a> <%}else{%> 다음글이 없습니다. <% } %>
							</td>
						</tr>
						<tr><td height="1" colspan="2" class="line_dg"></td></tr>
						</table>
						<!-- 이전글,다음글 / -->

						<!-- / button  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="13"></td></tr>
						<tr>
							<td class="lpad_5">
							<%if(deleteYn){%>
							           <a href="tour_gallery_edit.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>">
							           <img src="<%=imageServer%>/tour_img/btn/btn_comm_modify.gif" class="btn"></a>
							           <a href="javascript:del()">
							           <img src="<%=imageServer%>/tour_img/btn/btn_comm_delete.gif" class="btn">
							           </a>
							<%}%></td>
						    <td align="right">
						    <%if(!session_id.equals("")){%>
						               <a href="javascript:goRecomm()">
						               <img src="<%=imageServer%>/tour_img/btn/btn_comm_recommand.gif" class="btn">
						               </a><a href="tour_gallery_edit.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_newwrite.gif" class="btn" border="1"></a><%}%><a href="tour_gallery.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_comm_listview.gif" class="btn"></a></td>
						</tr>
						<tr><td height="50"></td></tr>
						</table>
						<!-- button / -->
                        

                        

					</td>
				</tr>
				<tr>
				     <!-- comment /-->
							<table width=100% border=0 cellspacing=0 cellpadding=0 align="center">
							<tr>
								<td>
									<iframe id="myframe" src="tour_gallery_comment.jsp?board_seq=<%=board_seq%>" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"  vspace="0" hspace="0" style="overflow:visible; width:100%;"></iframe>
								</td>

							</tr>
			                </table>
                        <!--comment /-->
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