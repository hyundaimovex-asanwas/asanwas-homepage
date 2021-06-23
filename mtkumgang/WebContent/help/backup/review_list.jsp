<%--
  - �ۼ���: �ڻ��
  - ����: 2006.05.26
  - ���۱� ǥ��: IMJ Korea
  - ����: ������ - �����ı� �Խ���
--%>


<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourReview"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%
//���� ����
int board_seq			= 0;
int ref_no				= 0; 
int level_no			= 0;
int sort_no				= 0;
int read_num			= 0;
String title			= ""; 
String content			= "";
String user_nick		= "";
String user_name		= "";
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";
int recomm_num			= 0;
int comment_num			= 0;
String isbest			= "";


int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType	= "01";
// DB���� ��ü(ibatis���)  
TourReview dao = new TourReview();
CommonBoard commonDao = new CommonBoard();


// �˻� - �÷���
String part       = ParamUtil.getReqParameter(request.getParameter("part"));
// �˻� - �˻���
String keyword    = ParamUtil.getReqParameter(request.getParameter("keyword"));
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;

//��û�� ������ �ѹ�
int requestedPage = Util.parseInt(request.getParameter("page"), 1);

//�� ������ �� �Խù� ����
int rowsPerPage = Util.parseInt(request.getParameter("rowsPerPage"), pageSize);

// ������ ��Ͽ����� ��ġ
int position = Util.parseInt(request.getParameter("position"), 1);

// �� �� ������ ����  
int blockPerPage = Util.parseInt(request.getParameter("blockPerPage"), blockSize);

// ��ü �Խù� ��
int allCount = commonDao.getFrontTotalCount(boardType, part,keyword);

// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getFrontList(requestedPage, pageSize, part, keyword );

// ��ü ������ ��
int pageCount = Util.getPageCount(rowsPerPage, allCount);
// �Խù� ��ȣ ����
int dataNum = Util.getDataNum(rowsPerPage, requestedPage, allCount);


Tbrd_board_ma_bean best_record[] = dao.getBestList();

String best_title	= "";
String best_content = "";

if(best_record.length > 0 ){
	Tbrd_board_ma_bean bestbean = best_record[0];
	best_title		= bestbean.getTitle();
	best_content	= bestbean.getContent();
}


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
							<td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>�����ı�</td>
						</tr>
						</table>
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=center><img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=BEST class=btn><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle></td>
                           <td>&nbsp;</td>
                           <td>
                             <% if(best_record.length > 0 ){ %>
							  <b><%=best_title%></b><br>
                              <%=best_content%>
							 <% }else{ %>
							����Ʈ�� �������� �ʾҽ��ϴ�.	
							 <% } %>
                           </td>
                          </tr>
                        </table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>    						
						<br>						
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<col width=10%>
							<col width=40% style='padding:5 3 3 3;'>
							<col width=20%>
							<col width=10%>
							<col width=10%>
							<col width=10%>
							<tr><td colspan=6 height=2 class=linec1></td></tr>
							<tr height=28 align=center>
                             <td class=th>��ȣ</td>
                             <td class=th>����</td>
                             <td class=th>�ۼ���</td>
                             <td class=th>�ۼ���</td>
                             <td class=th>��ȸ��</td>
                             <td class=th>��õ��</td>
							</tr>
							<tr><td colspan=6 height=1 class=linec1></td></tr>
							<% 
							//out.println(list.size());
							if(record.length <= 0){ %>	
							
							<tr align=center height=28 align=center height=35>
								<td colspan="7" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
							</tr>
							<tr><td colspan=7 height=1 class=linec1></td></tr>
							<%
							}else{
								//����Ʈ ȭ�鿡 ����
								for(int i=0;i<record.length; i++){ 
									Tbrd_board_ma_bean tbean = record[i];
									
									board_seq			= tbean.getBoard_seq();
									ref_no				= tbean.getRef_no(); 
									level_no			= tbean.getLevel_no(); 
									sort_no				= tbean.getSort_no(); 
									read_num			= tbean.getRead_num(); 
									title				= tbean.getTitle(); 
									content				= tbean.getContent(); 
									user_name			= tbean.getUser_name(); 
									use_yn				= tbean.getUse_yn(); 
									user_level			= tbean.getUser_level(); 
									board_top_no		= tbean.getBoard_top_no(); 
									user_id				= tbean.getUser_id();
									recomm_num			= tbean.getRecomm_num();
									comment_num			= tbean.getComment_num();
									isbest				= tbean.getBest().trim();
									use_yn				= tbean.getUse_yn().trim();
									
									
									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();
									String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
									String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
									int listNum = BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1));
							%>
							<tr height=28 height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                             <td align=center >
								<% if(isbest.equals("1")){ %>
									<font color="red">BEST</font>
								<% }else{ %>
									<%=listNum%>
								<% } %>
							 </td>
                             <td>
								<% if(use_yn.equals("0")){ %>
								������ �Խù� �Դϴ�.
								<% }else{ %>
								&nbsp;&nbsp;<%=re_img%><a href="review_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%>&listnum=<%=listNum%><%=key_str%>"><%=Util.getStringLimit((title).trim(),30)%></a> (<%=comment_num%>)&nbsp;<%=new_img%>
								<% } %>
							</td>
                            <td align=center d>
								<% if(use_yn.equals("0")){ %>
								������ �Խù� �Դϴ�.
								<% }else{ %>
								<%=reg_date_string%>
								<% } %>
							</td>
                            <td align=center >
								<% if(use_yn.equals("0")){ %>
								������ �Խù� �Դϴ�.
								<% }else{ %>
								<%=user_id%>
								<% } %>
							</td>
							<td align=center >
								<% if(use_yn.equals("0")){ %>
								������ �Խù� �Դϴ�.
								<% }else{ %>
								<%=read_num%>
								<% } %>
							</td>
							<td align=center >
								<% if(use_yn.equals("0")){ %>
								������ �Խù� �Դϴ�.
								<% }else{ %>
								<%=recomm_num%>
								<% } %>
							</td>
							</tr>
							<tr><td colspan=6 height=1 class=linec1></td></tr>
							<%
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
			                      "review_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
							        </td>
                                 </tr>
                                </table>
                                <!--����¡ -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                        <table width=100% border=0 cellspacing=0 cellpadding=0>
                          <tr><td height=10></td></tr>
                          <tr>
                           <td align=right>
                            <% if(!session_id.equals("")){ %>
							<img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=button value=�����ı⾲�� class=btn onclick="location.href='review_edit.jsp'"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle>
							<% } %>

                           </td>
                          </tr>
                        </table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=20></td></tr></table>                   
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
                          <td align=right>
                           <table border=0 cellspacing=0 cellpadding=0>
                            <FORM METHOD=POST ACTION="review_list.jsp">
                            <tr>
                              <td width="100" align=center>
                                <select name="part" style='width:80;'>
          								<option value=''>����</option>
          								<option value="1" <%if(part.equals("1")){%>selected<%}%>>����</option>
          								<option value='2' <%if(part.equals("2")){%>selected<%}%>>�̸�</option>
          								<option value='3' <%if(part.equals("3")){%>selected<%}%>>���̵�</option>
          								</select>
                              </td>
                              <td class="dblue rpad5">
                              <input type=text style='width:200;' name="keyword">
                              <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value="�˻�" class="btn" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
                              <td>                                  
                            </tr>
                            </FORM>
                           </table>                           
                          </td>
						</tr>
						<tr><td height=6></td></tr>
						</table>                        
					 </td>
				   </tr>
				</table>
			 </TD>
			<!-- //main -->
         </TR>
      </TABLE>
</BODY>
</HTML>