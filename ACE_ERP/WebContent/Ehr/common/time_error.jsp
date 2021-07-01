<%@ page contentType="text/html;charset=euc-kr" %>
<HTML>
<HEAD>
</HEAD>

<BODY>
<center>
<table>
	<tr>
		<td>
			<img src="/images/common/not_used_time.jpg"><br>
			<span style="position:relative;top:1;left:290;top:-190"><b>[제한시간 : <%=(String)request.getParameter("S_TIME")%>시 ~ <%=(String)request.getParameter("E_TIME")%>시]</b></span>
		</td>
	</tr>
</table>
</center>

</BODY>
</HTML>
