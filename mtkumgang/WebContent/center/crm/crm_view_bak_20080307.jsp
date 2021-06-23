<%-- 
  - �ۼ���: ������
  - ����: 2006.06.07
  - ������ : �̼ҿ� 
  - ���� : 2006.07    
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ������>������ϱ� �󼼺���
--%>
 
<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.CrmBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.StringUtil" %>
<%@ page import="java.util.*"%>


<%
//request parameters
int board_seq 	= Util.parseInt(request.getParameter("board_seq"), 0);
int requestedPage	= Util.parseInt(request.getParameter("requestedPage"), 1);
String part        	= ParamUtil.getReqParameter(request.getParameter("part"));
String keyword    	= ParamUtil.getReqParameter(request.getParameter("keyword"));
int position = Util.parseInt(request.getParameter("position"), 1);
// �˻� - �Ķ����
String key_str = "&part="+part+"&keyword="+keyword;
//������ ������
String page_str = "&page="+requestedPage+"&position="+position;

//���� ����
String cmd	= "edit";
String board_type = "";
String title= "";
String content	= "";
String user_id = "";
String regdate = "";
int read_num = 0;
String use_yn = "";
String type_code = "";
String type_name = "";
int ref_no= 0;
String open_yn = "0";
String reply_yn = "0";
String replyRegdate="";
String reply_content="";
boolean editYn = false; //�亯���ɿ���
boolean deleteYn = false; //�亯���ɿ���
String user_name =""; 
String email =""; 
String tel =""; 

String pageNum = "2";
String McNum = "6";
String sub = "3";

//DAO
CrmBoard dao = new CrmBoard();
CommonBoard commonDao = new CommonBoard();
//DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title	= bean[0].getTitle();
           content	= bean[0].getContent();
           content      = StringUtil.textToHtml(content);
	user_id	= bean[0].getUser_id();
	user_name = bean[0].getUser_name();
	regdate	= bean[0].getReg_date_String();
	read_num= bean[0].getRead_num();
	use_yn	= bean[0].getUse_yn();
	open_yn	= bean[0].getOpen_yn();
           ref_no	=  bean[0].getRef_no();
           replyRegdate  = ParamUtil.getReqParameter(bean[0].getReply_reg_date_String());
	reply_yn=  bean[0].getReply_yn();
	if(reply_yn.equals("0")){replyRegdate="";}
	reply_content=  bean[0].getReply_content();
          reply_content= reply_content.replaceAll("\"", "'");
	email	= bean[0].getEmail();
	tel	= bean[0].getTel();


	type_code	= bean[0].getType_code();
	  if(type_code.equals("31"))
		type_name="������";
	  if(type_code.equals("32"))
		type_name="�븮��";
	  if(type_code.equals("33"))
		type_name="���»����";
	  if(type_code.equals("34"))
		type_name="�⡡Ÿ";


	
	//��ȸ�� ����
    commonDao.updateReadnum(board_seq);

//�亯 ��� ���� �ʾ��� ��� ���� ���� 
if(reply_yn.equals("0")){
	//�α����� ����� �۾��̰� ���ƾ� ��������
	if(user_id.equals(session_id))
	{  
	   editYn = true;
	   deleteYn = true;
        }else{
	   editYn = false;
	   deleteYn = false;        
        }

	 //��ȸ���� ����� ���϶� ��������
	 if(user_id.equals("")){
	     editYn = false;
	     deleteYn = false;
	 }

}else{}


%>
<html>
<head>
<title> �ݰ������   </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--


function chk(){	
	f = document.mainForm;
	f.submit();
}


function del(){

	f = document.mainForm;
	if(confirm("�Խù��� �����Ͻðڽ��ϱ�?")){
		f.cmd.value = "del";
		f.action="crm_ok.jsp";
	    f.submit();
	}else{
		return;
	}
}

//-->
</SCRIPT>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../../include/center/tour_center_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174">
			<!--  left menu flash -->
            <%@ include file="../../include/center/tour_center_left.jsp" %>
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
						<td height="54"><img src="<%=imageServer%>/tour_img/customer/tit_cus05.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><a href="#" class="linemap">������</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">���� ���ϱ�</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>
<FORM METHOD=POST name="mainForm" ACTION="crm_edit.jsp" >
	<INPUT TYPE="hidden" name="cmd" value="<%=cmd%>">
	<INPUT TYPE="hidden" name="board_seq" value="<%=board_seq%>">
	<INPUT TYPE="hidden" name="part" value="<%=part%>">
	<INPUT TYPE="hidden" name="keyword" value="<%=keyword%>">
	<INPUT TYPE="hidden" name="requestedPage" value="<%=requestedPage%>">
    <INPUT TYPE="hidden" name="position" value="<%=position%>">
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/customer/img_top_cus04.jpg"></td></tr>
				<tr>
					<td valign="top">
						<!-- / read table  -->
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<col width="72"><col width="1"><col width="243">
						<col width="79"><col width="89">
						<col width="79"><col width="97">

						<tr><td height="2" colspan="7" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_write12.gif"><!-- ���� --></td>
							<td colspan="6" class="tpad_3 lpad_10"><%=type_name%></td>
						</tr>


						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_view01.gif"><!-- ���� --></td>
							<td colspan="6" class="tpad_3 lpad_10"><strong><%=title%></strong></td>
						</tr>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_view02.gif"><!-- �ۼ��� --></td>
							<td class="tpad_3 lpad_10">
                            <% if(!user_id.equals("")){%>
							   <%=user_name%>(<%=user_id%>)
							<%}else{%>
							   <!--��ȸ��-->
							   <%=user_name%>
							<%}%>							
							</td>
							<td><img src="<%=imageServer%>/tour_img/txt_view03.gif"><!-- ����� --></td>
							<td class="tpad_3 lpad_10"><%=regdate%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view07.gif"><!-- �亯�� --></td>
							<td class="tpad_3 lpad_10"><%=replyRegdate%></td>
						</tr>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr>
							<td height="26" align="right" colspan="2"><img src="<%=imageServer%>/tour_img/txt_view08.gif"><!-- �̸��� --></td>
							<td class="tpad_3 lpad_10"><%=email%></td>
							<td><img src="<%=imageServer%>/tour_img/txt_view09.gif"><!-- ����ó --></td>
							<td class="tpad_3 lpad_10">***&nbsp;-&nbsp;***&nbsp;-&nbsp;****</td>
							<td><img src="<%=imageServer%>/tour_img/txt_view11.gif"><!-- �������� --></td>
							<td class="tpad_3 lpad_10">
							<%
							if(open_yn.equals("1")){
							    out.println(" ����");
                            }else{
                                out.println(" �����");
                            }
                            %>
                                                                            
							</td>
						</tr>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr><td height="10" colspan="7"></td></tr>
						<tr>
							<td height="110" align="right"><img src="<%=imageServer%>/tour_img/txt_write04.gif" style="margin-right:13px;"><!-- ���ǳ��� --></td>
							<td class="bg_dgray"></td>
							<td class="lpad_10" colspan="5" valign="top"><%=content%></td>
						</tr>
						<tr><td height="10" colspan="7"></td></tr>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						<tr><td height="10" colspan="7"></td></tr>
						<tr>
							<td height="110" align="right"><img src="<%=imageServer%>/tour_img/txt_view10.gif" style="margin-right:13px;"><!-- �亯���� --></td>
							<td class="bg_dgray"></td>
							<td class="lpad_10" colspan="5" valign="top"><%= Util.replaceAll(reply_content,"\n","<br>")%></td>
						</tr>
						<tr><td height="10" colspan="7"></td></tr>
						<tr><td height="1" colspan="7" class="line_dg"></td></tr>
						</table>
						<!-- read table / -->

						<!-- /button -->
						<table cellspacing="0" cellpadding="0" border="0" width="690">
						<tr><td colspan="2" height="13"></td></tr>
						<tr>
							<td class="lpad_5">
							<% if(editYn){ %><a href="javascript:chk(this)"><img src="<%=imageServer%>/tour_img/btn/btn_cus_modify.gif" class="btn"></a><!-- �����ϱ� --><%}%>
							
							<% if(deleteYn){%><a href="javascript:del()"><img src="<%=imageServer%>/tour_img/btn/btn_cus_delete.gif" class="btn"></a><!-- �����ϱ� --></td><%}%>
							<td align="right"><a href="crm_list.jsp?board_seq=<%=board_seq%><%=key_str%><%=page_str%>"><img src="<%=imageServer%>/tour_img/btn/btn_cus_listview.gif" class="btn"></a><!-- ��Ϻ��� --></td>
						</tr>
						</table>
						<!-- button/ -->
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