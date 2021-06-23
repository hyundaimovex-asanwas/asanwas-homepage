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

//############### Connection���� ##########################
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
//�Խ��� Ÿ�԰���
String boardType		= "09";


//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// �Խù� ���
Tbrd_comment_de_bean record [] = stardao.getCommentList(requestedPage, pageSize, part, keyword ,current_board_seq);

// ��ü �Խù� ��
int allCount = stardao.getCommentTotalCount(part, keyword ,current_board_seq );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);

%>
<HTML>
<HEAD>
<title></title>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<script language="javascript">
function openSch(){
   var form = document.frm;
   if (form.schVal.value == "Ű���带 �Է��ϼ���"){
      form.schVal.value="";
   }
   form.submit();
}

function chk(){
	var obj = document.f1;
	var uid = "<%=session_id%>";

	if(uid == ""){
		alert("�α����� �ʿ��� �����Դϴ�.");
		return false;
	}	

	if(obj.content.value == ""){
		alert("������ �Է��ϼ���.");
		return false;
	}

	obj.cmd.value = "insert";

	return true;

}

function del(idx){
	if(confirm("�����Ͻðڽ��ϱ�?")){
		var obj = document.f1;
		obj.comment_seq.value = idx;
		obj.cmd.value = "del";

		obj.submit();
	}
}
</script>
</HEAD>
<body>
   <TABLE cellspacing=0 cellpadding=0 width=650>
		<TR valign=top>
			<!-- main -->
			<TD width=650 valign=top>
				<table width=650 border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>���������</td>
						</tr>
						</table>
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=center><img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=Special Them class=btn><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle></td>
                           <td>&nbsp;</td>
                           <td>
                             <%if(recordview.length > 0){%>
								<img src="<%=img_name%>"><br>
								<b><%=title%></b><br>
								<%=content%>	
							 <% }else{%>
								�ֱٿ� ��ϵ� ������ �����ϴ�.
							 <% } %>
                           </td>
                          </tr>
                        </table>                
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
                          <td align=right>
                           <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                              <td class="dblue rpad5">
							  <% if(board_seq > 0){ %>
							  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="������������" class="btn" onclick="location.href='sympathy_list.jsp'" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
							  <% }else{ %>
                              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value="������������" class="btn" onclick="location.href='sympathy_prelist.jsp'" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'>
							  <% } %>
							  </td>                                                                
                            </tr>
                           </table>                           
                          </td>
						</tr>
						</table>                          
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=center><img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=BEST class=btn><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle></td>
                           <td>&nbsp;</td>
                           <td>
                              <% if(bestcommentview.length > 0){ %>
								<%=best_content%>
							  <% }else{ %>
								��ϵ� Best�� �����ϴ�.		
							  <% } %>
                           </td>
                          </tr>
                        </table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>    						
						<br>													
         			     
						 <% if(recordview.length > 0){ %>
						 <!--���-->
         			     ��ü ���� <%=allCount%>��
         			     <table width=100% border=0 cellspacing=0 cellpadding=0>
         			     	<FORM METHOD=POST name="f1" ACTION="sympathy_ok.jsp" onsubmit="return chk();">
							<INPUT TYPE="hidden" name="cmd">
							<INPUT TYPE="hidden" name="board_seq" value="<%=current_board_seq%>">
							<INPUT TYPE="hidden" name="part" value="<%=part%>">
							<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
							<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
							<INPUT TYPE="hidden" name="comment_seq">
         			     	<tr height=28 >
                               <td colspan=2 class=lpad10 style='padding-top:7;padding-bottom:7;'>
                               <textarea name=content cols=80 rows=2></textarea><br>
                               <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value=���ǰ�������ϱ� class=btn ><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
                               </td>
         			     	</tr>     
         			     	</FORM>    			
         			     	<% 
							if(record.length <= 0){ %>	
							<tr>
								<td colspan="2" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
							</tr>
							<%
							}else{
								//����Ʈ ȭ�鿡 ����
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
									
									out.println(use_yn);
									
									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();

									if(use_yn.equals("1")){ 
									
							%>
							
										<tr height=28>
										   <td width=100><%=user_name%>(<%=user_id%>)</td>
										   <td class=tdcolor th style='padding-top:7;padding-bottom:7;'>
										  <%=content%>  <%=reg_date_string%>
										  <% if(session_id.equals(user_id)){ %>
										   <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=X class=btn onclick="javascript:del('<%=comment_seq%>');"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style=margin-right:1;>
										   <% } %>
										   </td>
										</tr>
							<%
									}else{
							%>
										<tr height=28>
											<td colspan="2" height="20">
												�����ڿ� ���� �����Ǿ����ϴ�.
											</td>
										</tr>
							<%

									}

								}
							}
							%>
         			     </table>
                    
						<table width=100% border=0 cellspacing=0 cellpadding=0>
							<tr>
                              <td width=50%></td>
                              <td align=center>
                                <!--����¡ -->
						        <table width=600 border=0 cellspacing=0 cellpadding=0>
						         <tr>
							        <td align=center>
							        <%=HtmlUtil.doPageCut(requestedPage, pageCount , position , 
			                      "sympathy_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
							        </td>
                                 </tr>
                                </table>
                                <!--����¡ -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                      <% } %>
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>