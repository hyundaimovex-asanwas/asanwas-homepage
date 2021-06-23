<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
Writer writer = response.getWriter();
Runtime oRuntime = Runtime.getRuntime();

/* String[] cmd = new String[7];
cmd[0]="/home/jeus/okname/src/okname";
cmd[1]="/home/jeus/okname/src/okname.key";
cmd[2]="AwQYzzeptP4Gi9zm5Gl/H4lO7S855A==";
cmd[3]="fx2UGt5l83Z85iQROsZh/g==";
cmd[4]="/dgq2GditNZVCt96voJxouYM7Zi77ieieZXet5smRKwXTDPaBiSOay0z/aUC42Q38FctFvHotubcLFF55iiOlLiJbonTeXST8Puh3XHz1LYkW+1y64RacxV965ep2D1PAtwGQyE6n9cpGyunSBPZAzJjuHVh025Op6HfK9Eb+uKrjrh2JXStn/tGeQaiAFHRZLdwWhuifHNQj/npD1tGHG4akaMFC0PYIxKc/w7Y8FxYExpffR1isI4aDJ+TFrMShmdfFUxqCQq7VU0hHf4FqF+i00xCntzFXMRVw9fv0aA2";
cmd[5]="/home/jeus/okname/src/";
cmd[6]="IL"; */

String[] cmd = new String[9];
cmd[0]="/home/jeus/okname/src/okname";
cmd[1]="/home/jeus/okname/src/okname.key";
cmd[2]=cpCode;//memid
//cmd[3]="http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
cmd[3]="http://www.allcredit.co.kr/KcbWebService/OkNameService";// 운영 서버
cmd[4]="AwQYzzeptP4Gi9zm5Gl/H4lO7S855A==";
cmd[5]="fx2UGt5l83Z85iQROsZh/g==";
cmd[6]="/dgq2GditNZVCt96voJxouYM7Zi77ieieZXet5smRKwXTDPaBiSOay0z/aUC42Q38FctFvHotubcLFF55iiOlLiJbonTeXST8Puh3XHz1LYkW+1y64RacxV965ep2D1PAtwGQyE6n9cpGyunSBPZAzJjuHVh025Op6HfK9Eb+uKrjrh2JXStn/tGeQaiAFHRZLdwWhuifHNQj/npD1tGHG4akaMFC0PYIxKc/w7Y8FxYExpffR1isI4aDJ+TFrMShmdfFUxqCQq7VU0hHf4FqF+i00xCntzFXMRVw9fv0aA2";
cmd[7]="/home/jeus/okname/src/";
cmd[8]="SL";

String[] field_name_IPIN_DEC = {
	"dupInfo        ",/* 0*/
	"coinfo1        ",/* 1*/
	"coinfo2        ",/* 2*/
	"ciupdate       ",/* 3*/
	"virtualNo      ",/* 4*/
	"cpCode         ",/* 5*/
	"realName       ",/* 6*/
	"cpRequestNumber",/* 7*/
	"age            ",/* 8*/
	"sex            ",/* 9*/
	"nationalInfo   ",/* 10*/
	"birthDate      ",/* 11*/
	"authInfo       ",/* 12*/
};

//writer.write("test");
try {
	Process oProcess = oRuntime.exec(cmd);
	// 외부 프로그램 출력 읽기
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	String s="";
	String[] field = new String[13];
	int ret_cnt=0;
	// 결과의 StdOut에서 첫번째 라인은 PublicKey, 두번째라인은 Signature임
	while ((s =   stdOut.readLine()) != null)
	{
		if(ret_cnt<13)
			field[ret_cnt] = s;
		ret_cnt++;
	}
	for(int i=0; i<13; i++)
		writer.write(field_name_IPIN_DEC[i] + ": " + field[i] + "<br>");
	//writer.write("Client Signature(JSP): " + sig + "<br>");
	
}
catch(Exception e) {
	writer.write(e.toString() + "<br>");
}
%>
