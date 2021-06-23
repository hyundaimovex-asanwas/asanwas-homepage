<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
Writer writer = response.getWriter();
Runtime oRuntime = Runtime.getRuntime();

/*String[] cmd = new String[4];
cmd[0]="/home/jeus/okname/src/okname";
cmd[1]="/home/jeus/okname/src/okname.key";
cmd[2]="/home/jeus/okname/src/";
cmd[3]="KL";*/

String[] cmd = new String[8];
cmd[0]="/home/jeus/okname/src/okname";
cmd[1]="/home/jeus/okname/src/okname.key";
cmd[2] = "P00000000000";//memid
cmd[3] = "0";//reserved1
cmd[4] = "0";//reserved2
cmd[5] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
cmd[2]="/home/jeus/okname/src/";
cmd[3]="CL";

//writer.write("test");
try {
	Process oProcess = oRuntime.exec(cmd);
	// 외부 프로그램 출력 읽기
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	String s="";
	String pubkey="",sig="", curtime="";
	int ret_cnt=0;
	// 결과의 StdOut에서 첫번째 라인은 PublicKey, 두번째라인은 Signature임
	while ((s =   stdOut.readLine()) != null)
	{
		if(ret_cnt==0)
			pubkey=s;
		if(ret_cnt==1)
			sig=s;
		if(ret_cnt==2)
			curtime=s;
		ret_cnt++;
	}
	writer.write("Client PublicKey(JSP): " + pubkey + "<br>");
	writer.write("Client Signature(JSP): " + sig + "<br>");
	writer.write("Time: " + curtime + "<br>");
	
}
catch(Exception e) {
	writer.write(e.toString() + "<br>");
}
%>
