<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourNotice"%>
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
String use_yn			= "";
String user_level		= "";
int board_top_no		= 0;
String user_id			= "";

int pageSize			= 10;
int blockSize			= 10;
//�Խ��� Ÿ�԰���
String boardType		= "08";

// DB���� ��ü(ibatis���)  
TourNotice dao = new TourNotice();
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


// �Խù� ���
Tbrd_board_ma_bean record [] = dao.getList(requestedPage, pageSize, part, keyword );

// ��ü �Խù� ��
int allCount = commonDao.getTotalCount(boardType, part,keyword);
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
</script>
</HEAD>
<body>
<form name="frm" method="post" onsubmit='return openSch()' >
   <TABLE cellspacing=0 cellpadding=0 width=650>
         
		<TR valign=top>
			<!-- main -->

			<TD width=650 valign=top>
				<table width=650 border=0 cellspacing=0 cellpadding=0>
				<tr>
					<td>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td class='title'><img src='../../asanway/img/tour_img/bu_blue_title.gif' align=texttop class=rmar10>��������</td>
						</tr>
						</table>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<col width=10%>
							<col width=50% style='padding:5 3 3 3;'>
							<col width=20%>
							<col width=20%>
							<tr><td colspan=4 height=2 class=linec1></td></tr>
							<tr height=28 align=center>
                             <td class=th>��ȣ</td>
                             <td class=th>����</td>
                             <td class=th>�����</td>
                             <td class=th>��ȸ��</td>
							</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr> 
							<% 
							if(record.length <= 0){ %>	
							<tr align=center height=35>
								<td colspan="4" align="center" height="30">����Ÿ�� �������� �ʽ��ϴ�.</td>
							</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr>
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
									use_yn				= tbean.getUse_yn(); 
									user_level			= tbean.getUser_level(); 
									board_top_no		= tbean.getBoard_top_no(); 
									user_id				= tbean.getUser_id();
									use_yn				= tbean.getUse_yn();

									java.util.Date writeday = tbean.getReg_date();
									String reg_date_string = tbean.getReg_date_String();
									String re_img	= BoardUtil.getReImg(level_no,sort_no,imageServer);
									String new_img	= BoardUtil.getNewArticle(writeday,imageServer);
							%>
							<tr align=center height=28 align=center height=28 style="cursor:hand" onmouseOver="this.style.backgroundColor='#E5E5E5';" onmouseout="this.style.backgroundColor='#FFFFFF';">
                             <td><%=BoardUtil.getNum(allCount,requestedPage,rowsPerPage,(i+1))%></td>
                             <td><a href="notice_view.jsp?board_seq=<%=board_seq%>&requestedPage=<%=requestedPage%><%=key_str%>"><%=title%></a></td>
                             <td><%=reg_date_string%></td>
                             <td><%=read_num%></td>
							</tr>
							<tr><td colspan=4 height=1 class=linec1></td></tr>
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
			                      "notice_list.jsp", "500", key_str ,
			                      imageServer+"imjk_img/", blockPerPage)%>
							        
                                    </td>
                                 </tr>
                                </table>
                                <!--����¡ -->
                              </td>
                              <td width=50% align=right></td>
							</tr>
						</table>
                        <table border=0 cellspacing=0 cellpadding=0><tr><td height=50></td></tr></table>
						<table width=100% border=0 cellspacing=0 cellpadding=0>
						<tr>
							<td align=right>
								<table border=0 cellspacing=0 cellpadding=0>
								<FORM METHOD=POST ACTION="notice_list.jsp">
								<tr>
                                  <td width="100" align=center>
                                    <select name="part" style='width:80;'>
                                    <option value='1'>����</option>
                                    </select>
                                  </td>                                  
                                  <td class="dblue rpad5">
                                  <input type=text style='width:200;' name="keyword">
                                  <img src=../../asanway/img/tour_img/btn_l.gif align=absmiddle><input type=submit value="�˻�" class="btn" onclick="openSch()" onfocus="this.blur();"><img src=../../asanway/img/tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
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
</form>

</BODY>
</HTML>
