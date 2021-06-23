<%@ page import= "java.util.*,java.net.*,java.lang.*,java.io.*, java.text.NumberFormat,java.lang.Runtime" errorPage="dir_error.jsp" contentType="text/html;charset=euc-kr"%>
<%@ page import="com.hmm.ejb.common.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>
<%@ include file="dir_config.inc" %>
<%
	String h_path = g_path;
	String h_mode = request.getParameter("h_mode");

	Process proc;
	DataInputStream dis;
	String msg = "";

	String h_newdir = request.getParameter("h_newdir");

	proc = Runtime.getRuntime().exec("mkdir "+h_path +"/"+h_newdir);
	dis = new DataInputStream(proc.getInputStream());        

	msg = "디렉토리 생성이 완료되었습니다.";
%>

<script>
	//alert('<%=msg%>');
	window.location.href = "dir_Filelist.jsp?path=<%=h_path%>";
</script>
