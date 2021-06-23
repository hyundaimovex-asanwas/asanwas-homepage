<%@ page language="java" contentType="text/html; charset=euc-kr"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<html>
<head>
<title> 금강산관광 </title>
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
</head>

<!-- 창사이즈 : 780 * 600 -->
<body bgcolor="#4A1800" topmargin="0" leftmargin="0">
<table width="780" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td height="580"><!--useguide flash -->
		<script language="javascript">
			f_id = "TourGuide_Main";//플래시 아이디
			f_name ="<%=imageServer%>/tour_swf/TourGuide_Main.swf"; //플래시 파일명
			f_width = "780";//가로크기
			f_height ="580"; //세로높이
			f_trans =""; //공백, transparent(투명)
			f_para =""; //파라미터
			show_flash_F(f_id,f_name,f_width,f_height,f_trans,f_para);
		</script>
	</td>
</tr>
<tr><td height="20"><img src="<%=imageServer%>/tour_img/footer_useguide.gif" height="20"></td></tr>
</table>
</body>
</html>