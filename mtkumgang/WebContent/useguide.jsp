<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> �ݰ������ </title>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
</head>

<!-- â������ : 780 * 600 -->
<body bgcolor="#4A1800" topmargin="0" leftmargin="0">
<table width="780" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td height="580"><!--useguide flash -->
		<script language="javascript">
			f_id = "TourGuide_Main";//�÷��� ���̵�
			f_name ="<%=imageServer%>/tour_swf/TourGuide_Main.swf"; //�÷��� ���ϸ�
			f_width = "780";//����ũ��
			f_height ="580"; //���γ���
			f_trans =""; //����, transparent(����)
			f_para =""; //�Ķ����
			show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
		</script>
	</td>
</tr>
<tr><td height="20"><img src="<%=imageServer%>/tour_img/footer_useguide.gif" height="20"></td></tr>
</table>
</body>
</html>