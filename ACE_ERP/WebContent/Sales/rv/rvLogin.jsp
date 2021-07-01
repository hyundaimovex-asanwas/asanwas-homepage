<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan

%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
	<script language="javascript">
		function fnOnLoad(tree_idx){
//			fnInit_tree(tree_idx);	<%//트리초기화 호출%>
		}
	</script>
</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
<table border='0' cellpadding='0' cellspacing='0' width='100%'>	
	<tr height="480">
		<td width="640px" background="<%=dirPath %>/Sales/images/coming.jpg">
		</td>
	</tr>
</table>
<!--------------------------------- 코딩 부분 끝 -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

