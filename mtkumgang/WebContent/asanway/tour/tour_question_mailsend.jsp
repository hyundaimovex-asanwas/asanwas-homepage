<%--
  - �ۼ���: ������
  - ����: 2006.06.07
  - ���۱� ǥ��: IMJ Korea
  - ����: ����� - ��������>�������ϱ� �󼼺���
--%>

<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
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

//DAO
QnABoard dao = new QnABoard();
CommonBoard commonDao = new CommonBoard();
//DTO
	Tbrd_board_ma_bean bean[] = dao.getBoardView(board_seq);
	title	= bean[0].getTitle();
	content	= bean[0].getContent();
	content= content.replaceAll("\"", "'");
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

	//��ȸ�� ����
    commonDao.updateReadnum(board_seq);

//�亯 ��� ���� �ʾ��� ��� ���� ���� 
if(reply_yn.equals("0")){
	//�α����� ����� �۾��̰� ���ƾ� ��������
	if(user_id.equals(session_id))
	{  
	   editYn = true;
	   deleteYn = true;
     }

	 //��ȸ���� ����� ���϶� ��������
	 if(user_id.equals("guest")){
	     editYn = true;
		 deleteYn = false;
	 }

}else{}






%>


<html>
<head>
<title> �ݰ������ </title>
<style>
	body{margin:19 0 0 30px;}
	img{border:none;}
	td,div,input,textarea,select,a:link,a:visited,a:active{font-family:'dotum';font-size:12px;color:#666666;line-height:16px;text-decoration:none}
	.b{font-weight:bold;}
	.fs16{font-size:16px;line-height:14px;}
	.dpurple{color:#44194D;}
	.white{color:#FFFFFF;}
</style>
</head>
<body>
<table cellspacing='0' cellpadding='0' border='0' width='560'>
<tr><td colspan='2' height='31' valign='top'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/lg_gk.gif' hspace='17'></td></tr>
<tr valign='top'>
	<td><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/tit02_gk.gif' width='346' height='95'></td>
	<td rowspan='2'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/img_top02.jpg' width='214' height='201'></td>
</tr>
<tr>
	<td valign='top' height='106'>
		<table cellspacing='0' cellpadding='0' border='0' width='326' style='margin-left:20px;'>
		<tr><td height='41'></td></tr>
		<tr>
			<td><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt17.gif' align='absmiddle'>&nbsp;&nbsp;&nbsp;<span class='dpurple b fs16'><%=user_name%></span><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt18.gif' align='absmiddle' hspace='2'></td>
		</tr>
		<tr><td height='3'></td></tr>
		<tr><td height='1' bgcolor='#8A5D94'></td></tr>
		<tr><td height='27'></td></tr>
		<tr><td valign='top'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt02.gif'></td></tr>
		</table>
	</td>
</tr>
<tr><td colspan='2' style='padding-left:20px;'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt21.gif'></td></tr>
<tr><td colspan='2' height='20'></td></tr>
<tr>
	<td colspan='2' align='center'>
		<table cellspacing='0' cellpadding='0' border='0' width='520'>
		<tr><td height='2' width='71' bgcolor='#424242'></td><td width='1' bgcolor='#424242'></td><td width='15' bgcolor='#424242'></td><td width='163' bgcolor='#424242'></td><td width='93' bgcolor='#424242'></td><td width='178' bgcolor='#424242'></td></tr>
		<tr>
			<td colspan='3' height='26'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b01.gif'></td>
			<td><%=regdate%></td>
			<td><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b02.gif'></td>
			<td><%=replyRegdate%></td>
		</tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr>
			<td height='26' colspan='3'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b03.gif'></td>
			<td colspan='3'><strong><%=title%></strong></td>
		</tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr><td colspan='6' height='9'></td></tr>
		<tr>
			<td height='127'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b04.gif'></td>
			<td background='http://test1.hdasan.com/asanway/img//tour_img/mail/vline.gif'></td>
			<td></td>
			<td colspan='3' valign='top'><%=content%></td>
		</tr>
		<tr><td colspan='6' height='7'></td></tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr><td colspan='6' height='9'></td></tr>
		<tr>
			<td height='127'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b05.gif'></td>
			<td background='http://test1.hdasan.com/asanway/img//tour_img/mail/vline.gif'></td>
			<td></td>
			<td colspan='3' valign='top'><%=reply_content%></td>
		</tr>
		<tr><td colspan='6' height='7'></td></tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr><td colspan='6' height='71'></td></tr>
		</table>
	</td>
</tr>
</table>
<!-- / footer -->
<table cellspacing='0' cellpadding='0' border='0' width='560'>
<tr valign='top'>
	<td width='134'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/footer_lg.gif' style='margin-left:18px;'></td>
	<td width='302'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/footer_txt01.gif' style='margin:3 0 6 0px;'><br><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/footer_txt02.gif'></td>
	<td width='124'><a href='#'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/btn_ccentergo.gif' vspace='3'></a><!-- �������� �ٷ� ����  --></td>
</tr>
<tr><td colspan='3'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/footer.gif'></td></tr>
</table>
<!-- footer / -->
</body>
</html>