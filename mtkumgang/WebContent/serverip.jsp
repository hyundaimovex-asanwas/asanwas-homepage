<%@ page import="java.net.*" %>
requested URL: <%=request.getRequestURL()%>
requested Info: <%=request.getRequestURI()%>
<%

// ���� ip
InetAddress inet= InetAddress.getLocalHost();
%>
<br/>server ip:
<%=inet.getHostAddress()%>
<br/>
194
