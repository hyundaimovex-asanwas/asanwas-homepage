<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.dao.QnABoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hmm.asan.board.Plz_BoardBean" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%
	Plz_BoardBean pb = new Plz_BoardBean();
	pb.Read(request, response);
	// 로그인 여부 체크
	String memberlogin = (String)session.getAttribute("memberidx");
	String MEM_ID = (String)session.getAttribute("memberid");
	String MEM_NAME = (String)session.getAttribute("membername");
String idx = request.getParameter("idx");
	
%>
<jsp:useBean id="read" class="java.util.HashMap" scope="request" />



<html>
<head>
<title> 금강산관광 </title>
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
			<td><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt17.gif' align='absmiddle'>&nbsp;&nbsp;&nbsp;<span class='dpurple b fs16'><%=Utility.ko((String)read.get("MEM_NAME"))%></span><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt18.gif' align='absmiddle' hspace='2'></td>
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
			<td><%=read.get("REG_DATE").toString().substring(0,10)%></td>
			<td><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b02.gif'></td>
			<td><%=read.get("RPL_DATE").toString().substring(0,10)%></td>
		</tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr>
			<td height='26' colspan='3'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b03.gif'></td>
			<td colspan='3'><strong><%=Utility.ko((String)read.get("TITLE"))%></strong></td>
		</tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr><td colspan='6' height='9'></td></tr>
		<tr>
			<td height='127'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b04.gif'></td>
			<td background='http://test1.hdasan.com/asanway/img//tour_img/mail/vline.gif'></td>
			<td></td>
			<td colspan='3' valign='top'><%=Utility.ko((String)read.get("CONTENT"))%></td>
		</tr>
		<tr><td colspan='6' height='7'></td></tr>
		<tr><td colspan='6' height='1' bgcolor='#424242'></td></tr>
		<tr><td colspan='6' height='9'></td></tr>
		<tr>
			<td height='127'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/txt_b05.gif'></td>
			<td background='http://test1.hdasan.com/asanway/img//tour_img/mail/vline.gif'></td>
			<td></td>
			<td colspan='3' valign='top'><%=Utility.ko((String)read.get("REPLY"))%></td>
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
	<td width='124'><a href='#'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/btn_ccentergo.gif' vspace='3'></a><!-- 고객센터 바로 가기  --></td>
</tr>
<tr><td colspan='3'><img src='http://test1.hdasan.com/asanway/img//tour_img/mail/footer.gif'></td></tr>
</table>
<!-- footer / -->
</body>
</html>