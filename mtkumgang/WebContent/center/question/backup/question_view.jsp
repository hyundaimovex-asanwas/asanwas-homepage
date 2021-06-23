<%--
  - �ۼ���: ������
  - ����: 2006.06.05
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>���� ���� ���� �űԵ�� or ����
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.BestQuestion"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
int position = Util.parseInt(request.getParameter("position"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
String searchTypeCode    	= ParamUtil.getReqParameter(request.getParameter("searchTypeCode"));
// �˻� - �Ķ����
String key_str = "&searchTypeCode="+searchTypeCode+"&part="+part+"&keyword="+keyword;
//������ ������
String page_str = "&page="+requestedPage+"&position="+position;

//���� ����
String cmd	= "";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_name = "";
String type_code = "";
CommonBoard commonDao = new CommonBoard();

if (board_seq > 0){
	//DAO
	BestQuestion dao = new BestQuestion();
    //DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title						= bean[0].getTitle();
	content					= bean[0].getContent();
	//content					= content.replaceAll("\"", "'");
	user_id					= bean[0].getUser_id();
	regdate					= bean[0].getReg_date_String();
	read_num				= bean[0].getRead_num();
	use_yn					= bean[0].getUse_yn();
	type_code					= bean[0].getType_code();

	//��ȸ�� ����
    commonDao.updateReadnum(board_seq);
}


%>

<html>
<head>
<link rel=stylesheet href=../../asanway/css/tour_admin.css type=text/css>
<script language="javascript">

//�˻�
function goSearch(searchTypeCode){
	f = document.searchForm;
	if(searchTypeCode != ''){
	   f.searchTypeCode.value=searchTypeCode;
	}
	f.submit();
}
</script>
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
                				<td class='title'><img src=<%=imageServer%>tour_img/bu_blue_title.gif align=texttop class=rmar10>���� ���� ����</td>
                			</tr>
                			<tr><td height=17></td></tr>
                			</table>
                            <!--�з� START -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								 <col width=25%>
								<col width=25%>
								<col width=25%>
								<col width=25%>
									<tr height=28 align=center>
									
										<td><%if(type_code.equals("01")){%>���ΰ���<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=���ΰ��� class=btn onclick="javascript:goSearch('01')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("02")){%>�����û/���<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����û/��� class=btn onclick="javascript:goSearch('02')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("03")){%>�������<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=������� class=btn onclick="javascript:goSearch('03')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("04")){%>�����غ�<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�����غ� class=btn onclick="javascript:goSearch('04')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td></td>
									</tr>
									<tr height=28 align=center>
										<td><%if(type_code.equals("05")){%>��������<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�������� class=btn onclick="javascript:goSearch('05')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("06")){%>�������Ա�<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=�������Ա� class=btn onclick="javascript:goSearch('06')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("07")){%>����ƻ�<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=����ƻ� class=btn onclick="javascript:goSearch('07')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td><%if(type_code.equals("08")){%>��Ÿ<%}else{%><img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=��Ÿ class=btn onclick="javascript:goSearch('08')"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle><%}%></td>
										<td></td>
									</tr>
									<tr><td colspan=4 height=2 class=linec1></td></tr>				    
							</table>
							<!--�з� END -->
							<br>

					        <//-- �˻� -->
							<table width=100% border=0 cellspacing=0 cellpadding=0>
							<tr>
								<td align=right>
									<!--�˻� START -->
								  <FORM METHOD=POST NAME=searchForm ACTION="question_list.jsp">
								  <INPUT TYPE="hidden" name="searchTypeCode" value="<%=searchTypeCode%>">
									<table border=0 cellspacing=0 cellpadding=0>
									<tr>
									  <td width="100" align=right>
											                                 
											<td class="dblue rpad5">
											<input type=text style='width:200;' name="keyword"  value="<%=keyword%>" >
											<img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value="�˻�" class="btn" onclick="goSearch('')" onfocus="this.blur();"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle style='margin-right:1;'></td>
											<td>                                  
									</tr>
									</table>
								  </FORM>
								  <!--�˻� END -->
								</td>
							</tr>
							<tr><td height=6></td></tr>
							</table>

                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<col width=100>
                				<tr><td colspan=2 height=2 class=linec1></td></tr>
                				<tr height=28>
                					<td class='tdcolor th' align=center>����</td>
                					<td class=lpad10>
                					<%=title%>
                					</td>
                				</tr>
                				<tr><td colspan=2 height=1 class=linec0></td></tr>
                				<tr height=28>
                                 <td class='tdcolor th' align=center valign=top style=padding-top:7;>����</td>
                                 <td class=lpad10 style='padding-top:7;padding-bottom:7;' height=300 valign=top>
                                 <%=content%>
                                 </td>
                				</tr>
                				
                				<tr><td colspan=2 height=1 class=linec1></td></tr>                				                				
                			</table>
                			<table width=100% border=0 cellspacing=0 cellpadding=0>
                				<tr><td height=10></td></tr>
                				<tr>
                                 <td align=right>
                                  <img src=<%=imageServer%>tour_img/btn_l.gif align=absmiddle><input type=button value=��� class=btn onclick="location.href='question_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>'"><img src=<%=imageServer%>tour_img/btn_r.gif align=absmiddle>         					
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
