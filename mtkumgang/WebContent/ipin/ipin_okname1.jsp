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
String memid = "";// 회원사 아이디 
String qryBrcCd = "x"; 
String qryBrcNm = "x"; 
String qryId = "u1234";// 쿼리ID, 현재는 고정값 
String qryKndCd = "1";// 요청구분  개인 : 1, 외국인 : 2 
String qryRsnCd = "01";// 조회사유  회원가입 : 01, 회원정보수정 : 02, 회원탈회 : 03, 성인인증 : 04, 기타 : 05
String qryIP = "";// 회원사 IP 
String qryDomain = "";// 회원사 도메인 
String qryDt = df.format(cal.getTime());//date(Ymd);//<- 현재 시간 함수로 적용하세요.
String EndPointURL  = "http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService"; 
String logpath = "d:\\okname\\src";

// 모듈은 언제나 절대패스로 적용해야함
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

// 화변에 뿌리기
for(int i=0; i<cmd.length; i++) {
	writer.write(cmd[i] + " ");
}
writer.write("<br>");

try {
	Process oProcess = oRuntime.exec(cmd);
	// 외부 프로그램 출력 읽기
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));

	oProcess.waitFor();// 프로세스가 끝날때 까지 기다림
	int ret = oProcess.exitValue();

	// 외부 프로그램 반환값 출력 (이 부분은 필수가 아님)
	writer.write("ret=" + ret + "<br>");

	// 성공일 경우 CI, DI를 가져옴
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