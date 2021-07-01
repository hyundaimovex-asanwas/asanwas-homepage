<%@ page language="java" contentType="text/html;charset=euc-kr" %>

한글 파라미터 GET으로 받기
<%
   String mynm = request.getParameter("mynm");
%>
<BR>
<B>my Name is [<%=mynm%>]</B>

