<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page import="sales.common.*"%>

<%// ContextPath
			String dirPath = request.getContextPath();
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script language="javascript" src="<%=dirPath%>/common/include/embedControl.js"></script>
<script>
		<!--
			function fnSelect() {
				ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SAMPLE%>DevCodeGe?dsType=1" 
																			+ "&query=" + query.value;
																			
				ds1.Reset(); 
			}
			
		-->
	</script>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>


</head>
<body>
<table>

	<tr>
		<td><a href="javascript:fnSelect();">Query</a></td>
	</tr>
	<tr>
		<td><textarea cols="300" rows="30" id="query"></textarea></td>
	</tr>

</table>
</body>
</html>
