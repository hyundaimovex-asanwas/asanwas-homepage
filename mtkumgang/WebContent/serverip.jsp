<%@ page import="java.net.*" %>
requested URL: <%=request.getRequestURL()%>
requested Info: <%=request.getRequestURI()%>
<%

// ¼­¹ö ip
InetAddress inet= InetAddress.getLocalHost();
%>
<br/>server ip:
<%=inet.getHostAddress()%>
<br/>
194
