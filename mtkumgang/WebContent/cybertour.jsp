<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> �ݰ������ </title>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
</head>

<!-- â������ : 1000 * 700 -->
<body topmargin="0" leftmargin="0">
<table width="1000" height="700" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td><!--useguide flash -->
		<script language="javascript">
			f_id = "hy_DefaultSWF";//�÷��� ���̵�
			f_name ="<%=imageServer%>/tour_swf/hy_DefaultSWF.swf"; //�÷��� ���ϸ�
			f_width = "1000";//����ũ��
			f_height ="700"; //���γ���
			f_trans =""; //����, transparent(����)
			f_para =""; //�Ķ����
			show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
		</script>
	</td>
</tr>
</table>
</body>
</html>