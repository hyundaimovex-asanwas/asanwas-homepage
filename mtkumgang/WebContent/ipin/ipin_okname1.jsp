<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%
Writer writer = response.getWriter();
Runtime oRuntime = Runtime.getRuntime();
Calendar cal = Calendar.getInstance();
SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");

String name="";
String ssn="";
String memid = "";// ȸ���� ���̵� 
String qryBrcCd = "x"; 
String qryBrcNm = "x"; 
String qryId = "u1234";// ����ID, ����� ������ 
String qryKndCd = "1";// ��û����  ���� : 1, �ܱ��� : 2 
String qryRsnCd = "01";// ��ȸ����  ȸ������ : 01, ȸ���������� : 02, ȸ��Żȸ : 03, �������� : 04, ��Ÿ : 05
String qryIP = "";// ȸ���� IP 
String qryDomain = "";// ȸ���� ������ 
String qryDt = df.format(cal.getTime());//date(Ymd);//<- ���� �ð� �Լ��� �����ϼ���.
String EndPointURL  = "http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService"; 
String logpath = "d:\\okname\\src";

// ����� ������ �����н��� �����ؾ���
//String exe = "/usr/local/tomcat/webapps/ROOT/okname";
String exe = "d:\\okname\\bin\\win32\\exe\\okname.exe";

String[] cmd = new String[15];
cmd[0]=exe;
cmd[1]=name;
cmd[2]=ssn;
cmd[3]=memid;
cmd[4]=qryBrcCd;
cmd[5]=qryBrcNm;
cmd[6]=qryId;
cmd[7]=qryKndCd;
cmd[8]=qryRsnCd;
cmd[9]=qryIP;
cmd[10]=qryDomain;
cmd[11]=qryDt;
cmd[12]=EndPointURL;
cmd[13]=logpath;
cmd[14]="NLX";

// ȭ���� �Ѹ���
for(int i=0; i<cmd.length; i++) {
	writer.write(cmd[i] + " ");
}
writer.write("<br>");

try {
	Process oProcess = oRuntime.exec(cmd);
	// �ܺ� ���α׷� ��� �б�
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));

	oProcess.waitFor();// ���μ����� ������ ���� ��ٸ�
	int ret = oProcess.exitValue();

	// �ܺ� ���α׷� ��ȯ�� ��� (�� �κ��� �ʼ��� �ƴ�)
	writer.write("ret=" + ret + "<br>");

	// ������ ��� CI, DI�� ������
	if(ret == 0) {
		String ci = stdOut.readLine();
		String di = stdOut.readLine();

		writer.write("CI="+ci+"<br>");
		writer.write("DI="+di+"<br>");
	}
}
catch(Exception e) {
	writer.write(e.toString() + "<br>");	
}
%>