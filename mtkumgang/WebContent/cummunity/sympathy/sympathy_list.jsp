<%@ page language="java" contentType="text/html; charset=euc-kr"%> 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%> 
<%@ page import="kr.co.imjk.board.bean.Tbrd_comment_de_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathy"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.board.dao.TourSympathyComment"%>
<%@ page import="java.util.*"%>

<%
int board_seq		= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);

String part			= Util.toKSC(ParamUtil.getReqParameter(request.getParameter("part")));
String keyword		= ParamUtil.getReqParameter(request.getParameter("keyword"));

String key_str = "&board_seq="+board_seq+"&part="+part+"&keyword="+keyword;


//String session_id =  Util.getString((String)session.getAttribute("memberid"),"");

//session_id = "odyssey";

//############### Connection???? ##########################
TourSympathy  dao  = new TourSympathy();

TourSympathyComment stardao = new TourSympathyComment();
//#########################################################

int current_board_seq	= 0;
String title			= "";
String content			= "";
String virtual_name		= "";
String real_name		= "";
String img_name			= "";
String best_content		= "";
String use_yn			= "";

String McNum = "5";
String sub = "2";
String pageNum = "2";

Tbrd_board_ma_bean[] recordview = null;

if(board_seq > 0){
	current_board_seq = board_seq;

	recordview = dao.getBoardView(board_seq);

	if(recordview.length > 0){
		Tbrd_board_ma_bean tbean = recordview[0];
		
		current_board_seq		= tbean.getBoard_seq();
		title					= Util.getString(tbean.getTitle(),"");
		content					= Util.getString(tbean.getContent(),"");
		virtual_name			= Util.getString(tbean.getVirtual_name(),"");
		real_name				= Util.getString(tbean.getReal_name(),"");

		img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;

	}
}else{
	recordview = dao.getBoardView();

	if(recordview.length > 0){
		Tbrd_board_ma_bean tbean = recordview[0];
		
		current_board_seq		= tbean.getBoard_seq();
		title					= Util.getString(tbean.getTitle(),"");
		content					= Util.getString(tbean.getContent(),"");
		virtual_name			= Util.getString(tbean.getVirtual_name(),"");
		real_name				= Util.getString(tbean.getReal_name(),"");

		img_name = rootServer+"asanway/upload/agreeGalleryUpload/"+virtual_name;

	}
}

dao.updateReadnum(current_board_seq);

Tbrd_comment_de_bean[] bestcommentview =  stardao.getBestCommentView(current_board_seq);

if(bestcommentview.length > 0){
	Tbrd_comment_de_bean cbean = bestcommentview[0];
	best_content = Util.getString(cbean.getContent(),"");
}


int comment_seq		= 0;
String user_name	= "";
String user_id		= "";
String isbest		= "";


int pageSize			= 10;
int blockSize			= 10;
//?Խ??? Ÿ?԰???
String boardType		= "09";


//?? ?????? ?? ?Խù? ????
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ?????? ???Ͽ????? ??ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// ???? ?? ?????? ????  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// ?Խù? ????
Tbrd_comment_de_bean record [] = stardao.getCommentList(requestedPage, pageSize, part, keyword ,current_board_seq);

// ??ü ?Խù? ??
int allCount = stardao.getCommentTotalCount(part, keyword ,current_board_seq );

// ??ü ?????? ??
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// ?Խù? ??ȣ ????
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

%>
<html>
<head>
<title> ?ݰ??????? </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "Ű???带 ?Է??ϼ???"){
      form.schVal.value="";
   }
   form.submit();
}

function chk(){
	var obj = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		alert("?α????? ?ʿ??? ???????Դϴ?.");
		return;
	}	

	if(obj.content.value == ""){
		alert("?????? ?Է??ϼ???.");
		obj.content.focus();
		return;
	}

	obj.cmd.value = "insert";

	obj.submit();
}

function del(idx){
	if(confirm("?????Ͻðڽ??ϱ??")){
		var obj = document.f1;
		obj.comment_seq.value = idx;
		obj.cmd.value = "del";

		obj.submit();
	}
}
</script>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/community/tit_comm02.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">Ŀ?´?Ƽ</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">??????????</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr>
					<td>
						<table width="690" cellpadding="0" cellspacing="0">
						<tr><td><img src="<%=imageServer%>/tour_img/community/bg_top_comm21.jpg"></td></tr>
						</table>
						
						<table width="690" height="161" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm22.jpg');fixed no-repeat left top;">
						<tr>
							<td width="160"></td>
							<td width="530" style="padding:40 0 0 20px;" valign="top">
								<table width="510" cellpadding="0" cellspacing="0" border="0">
<%if(recordview.length > 0){%>
								<tr>
									<td colspan="2"><img src="<%=imageServer%>/tour_img/bu/bu_lpurple_larw.gif" align="absmiddle"> 	
									<span class="b fs14 txt_white"><u><%=title%></u></span></td>
								</tr>
								<tr class="tpad_10">
									<td class="txt_lpurple">
									<%=content%>									
									<!--<br>?????? / 05.12.01-->
									</td>
									<td align="right" valign="bottom">
									<% if(board_seq > 0){ %>
                                       <a href="sympathy_prelist.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_thistitview.gif"></a>
                                    <% }else{ %>
									   <a href="sympathy_prelist.jsp"><img src="<%=imageServer%>/tour_img/btn/btn_comm_lasttitview.gif"></a>
									<% } %>
									</td>
								</tr>
<% }else{%>
								<tr>
									<td colspan="2"><img src="<%=imageServer%>/tour_img/bu/bu_lpurple_larw.gif" align="absmiddle"> 	
									<span class="b fs14 txt_white"><u>?ֱٿ? ???ϵ? ?????? ?????ϴ?.</u></span></td>
								</tr>
								<tr class="tpad_10">
									<td class="txt_lpurple">&nbsp;</td>
									<td align="right" valign="bottom">&nbsp;</td>
								</tr>
                                    ?ֱٿ? ???ϵ? ?????? ?????ϴ?.
<% } %>								
								</table>
							</td>
						</tr>
						</table>

						<table width="690" height="107" cellpadding="0" cellspacing="0" border="0" style="background:url('<%=imageServer%>/tour_img/community/bg_top_comm23.jpg');fixed no-repeat left top;">
						<tr>
							<td width="160"></td>
							<td width="530" class="tpad_15 bpad_15">
<% if(bestcommentview.length > 0){ %>
								<table width="510" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td class="txt_lpurple">
									  <%=best_content%>
									</td>
								</tr>
								<tr>
									<td class="tpad_5"><!-- <img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="3"><span class="fs11 txt_lpurple3">??????</span>&nbsp;&nbsp;<img src="<%=imageServer%>/tour_img/bu/bu_gray_rec.gif" vspace="3"> <span class="fs11 txt_lpurple3">05.12.01</span>--></td>
								</tr>
								</table>
								
<% }else{ %>
								<table width="510" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td class="txt_lpurple">
									  ???ϵ? Best?? ?????ϴ?.
									</td>
								</tr>
								<tr>
									<td class="tpad_5">&nbsp;</td>
								</tr>
								</table>
<% } %>
                                    
                                    								
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr><td height="15" valign="bottom" align="right"><img src="<%=imageServer%>/tour_img/community/txt_tip_comm01.gif"></td></tr>
				<tr><td height="25"></td></tr>
				<tr>
					<td valign="top">
<FORM METHOD=POST name="f1" ACTION="sympathy_ok.jsp">
<INPUT TYPE="hidden" name="cmd">
<INPUT TYPE="hidden" name="board_seq" value="<%=current_board_seq%>">
<INPUT TYPE="hidden" name="part" value="<%=part%>">
<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
<INPUT TYPE="hidden" name="comment_seq">
						<!-- / ???۾??? -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="26" valign="top" class="lpad_5 fs11"><img src="<%=imageServer%>/tour_img/community/stit_comm02.gif" align="absmiddle">&nbsp;&nbsp;&nbsp;(??ü ???? <span class="b txt_purple"><%=allCount%></span>??)</td></tr>
						</table>
						<table width="690" cellpadding="0" cellspacing="0" border="0" class="reply_bg05">
						<tr>
							<td><textarea name="content" style="width:595px;height:39px;overflow:auto;"></textarea>
							<a href="javascript:chk();"><img src="<%=imageServer%>/tour_img/btn/btn_reply_myfeelregis.gif" class="btnl7" align="absmiddle"></a></td>
						</tr>
						</table>
						<!-- ???۾??? / -->
</FORM>
						<!-- / ???۸??? -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="80" style="padding:0 12 0 12"><col width="1"><col width="560" style="padding:0 10 0 15">
<% if(record.length <= 0){ %>	
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3" align="center">????Ÿ?? ???????? ?ʽ??ϴ?.</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
<%
}else{
	//????Ʈ ȭ?鿡 ????
	for(int i=0;i<record.length; i++){ 
		Tbrd_comment_de_bean tbean = record[i];
		comment_seq			= tbean.getComment_seq();
		//board_seq			= tbean.getBoard_seq();
		title				= tbean.getTitle(); 
		content				= tbean.getContent(); 
		user_name			= tbean.getUser_name(); 									
		user_id				= tbean.getUser_id();
		isbest				= tbean.getBest().trim();
		use_yn				= tbean.getUse_yn();
		
		
		java.util.Date writeday = tbean.getReg_date();
		String reg_date_string = tbean.getReg_date_String();

		if(use_yn.equals("1")){ 
		
%>
						<tr><td class="bg_lpurple" colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" class="bg_lpurple"><strong><%=user_name%></strong><br>(<%=user_id%>)</td>
							<td class="bg_dgray"></td>
							<td class="bg_lpurple">
								<table width="100%" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td><%=content%> <img src="<%=imageServer%>/tour_img/bu/ico_new.gif" align="absmiddle"></td>
								</tr>
								<tr>
									<td class="tpad_5"><img src="<%=imageServer%>/tour_img/bu/bu_dgray_rec.gif" align="texttop" vspace="5"> <span class="fs11"><%=reg_date_string%></span> 
									<% if(session_id.equals(user_id)){ %>
									<a href="javascript:del('<%=comment_seq%>');"><img src="<%=imageServer%>/tour_img/btn/btn_s_delete.gif" align="absmiddle"></a>
									<% } %>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td class="bg_lpurple" colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
<%
		}else{
%>
						<tr><td colspan="3" height="8"></td></tr>
						<tr>
							<td height="65" colspan="3"  align="center">?????ڿ? ???? ?????Ǿ????ϴ?.</td>
						</tr>
						<tr><td colspan="3" height="8"></td></tr>
						<tr><td colspan="3" class="line_dg" height="1"></td></tr>
<%

		}

	}
}
%>
						
						</table>
						<!-- ???۸??? / -->

						<!-- /paging -->
						<table cellspacing="0" cellpadding="0" border="0" width="690" height="60">
						<tr>
							<td align="center">
								<%=HtmlUtil.doPageCut(requestedPage, pageCount , position , "sympathy_list.jsp", "500", key_str ,imageServer+"imjk_img/", blockPerPage)%>
                            </td>
						</tr>
						</table>
						<!-- paging/ -->
					</td>
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