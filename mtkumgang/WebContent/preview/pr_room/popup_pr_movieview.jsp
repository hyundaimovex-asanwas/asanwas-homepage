<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="kr.co.imjk.util.*"%>
<%
  String img_name = new String();
  int board_seq = 0;
  img_name       = ParamUtil.getReqParameter(request.getParameter("img_name"));
  board_seq      = Util.parseInt(request.getParameter("board_seq"), 0);
  
	//��ȸ�� ����
	CommonBoard commonDao = new CommonBoard();
    commonDao.updateReadnum(board_seq);  
%>
<html>
<head>
<title> �ݰ������ </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
</head>

<body class="popmargin">

<!-- �˾������� : 450 X 436 -->
<table cellspacing="0" cellpadding="0" border="0" width="420">
<tr>
	<td width="100%">
			<!-- / Ÿ��Ʋ -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" height="65" class="bg_dgreen2">
			<tr valign="top">
				<td class="tpad_20 lpad_20"><img src="<%=imageServer%>/tour_img/preview/pop_tit_movview.gif"></td>
				<td align="right" class="tpad_20 rpad_15"><img src="<%=imageServer%>/tour_img/preview/pop_logo.gif"></td>
			</tr>
			</table>
			<!-- Ÿ��Ʋ / -->
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tr><td height="29"></td></tr>
			<tr>
				<td style="padding:0 5 0 5" align="center"><!-- ������ -->
<%
  if(!img_name.equals("")){
%>				
				<script language="javascript">
					m_id = "mplayer";//������ ���̵�
					m_width = "320";//����ũ��
					m_height ="240"; //���γ���
					//m_filename ="mms://211.49.227.161/00/01/57/81_x1_200.asf"; //������ ���ϸ�
					m_filename ="<%=img_name%>";
					m_control = "true"; // ��Ʈ�� ���Ӽ���
					m_start ="true"; // �ڵ��÷��� ����
					m_transparent =""; //����, transparent(����)
					show_movie_F(m_id,m_width,m_height,m_filename,m_control,m_start,m_transparent);
				</script>
<%}else{%>
                ��ϵ� �������� �����ϴ�.
<%}%>
				</td>
			</tr>
			<tr><td height="22"></td></tr>
			<tr>
				<td align="center"><a href="javascript:;" onclick="window.close();"><img src="<%=imageServer%>/tour_img/btn/btn_pre_confirm.gif"></a><!-- Ȯ�� --></td>
			</tr>
			<tr><td height="23"></td></tr>
			</table>

			
			<!-- �ϴܹ�  --><table cellspacing="0" cellpadding="0" border="0" width="100%" height="8" class="bg_dgreen2"><tr><td></td></tr></table>
	</td>
</tr>
</table>

</body>
</html>