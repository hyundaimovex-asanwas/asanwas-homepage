<%@ page import="java.io.IOException,java.net.InetAddress"%>
<%
 String s;
        InetAddress inetaddress = InetAddress.getLocalHost();
        s = inetaddress.getHostAddress();
        out.println("IP : " + s);
%>