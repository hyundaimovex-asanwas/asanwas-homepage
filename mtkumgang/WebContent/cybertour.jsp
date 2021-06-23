<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> 금강산관광 </title>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
</head>

<!-- 창사이즈 : 1000 * 700 -->
<body topmargin="0" leftmargin="0">
<table width="1000" height="700" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td><!--useguide flash -->
		<script language="javascript">
			f_id = "hy_DefaultSWF";//플래시 아이디
			f_name ="<%=imageServer%>/tour_swf/hy_DefaultSWF.swf"; //플래시 파일명
			f_width = "1000";//가로크기
			f_height ="700"; //세로높이
			f_trans =""; //공백, transparent(투명)
			f_para =""; //파라미터
			show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
		</script>
	</td>
</tr>
</table>
</body>
</html>