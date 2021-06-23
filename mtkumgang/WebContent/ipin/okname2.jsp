<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
KCB 실명확인 OKname JSP Version Sample Page<br>
<%
	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");

	// 파라미터의 인코딩 셋팅
	request.setCharacterEncoding("euc-kr");

	String name=(String)request.getParameter("name");//이름
	String ssn=(String)request.getParameter("ssn");//주민번호
	String memid=(String)request.getParameter("memid");//회원사ID
	String qryIP=(String)request.getParameter("qryIP");//회원사IP
	String qryDomain=(String)request.getParameter("qryDomain");//회원사DOMAIN
	String qryKndCd=(String)request.getParameter("qryKndCd");//조회종류(1: 내국인, 2: 외국인)
	String qryRsnCd=(String)request.getParameter("qryRsnCd");//조회사유(회원가입 : 01, 회원정보수정 : 02, 회원탈회 : 03, 성인인증 : 04, 기타 : 05)
	String EndPointURL=(String)request.getParameter("EndPointURL");//EndPointURL(테스트, 운영이 존재함)

	//JSP는 모듈의 패스를 절대패스로 지정해야함
	//String exe = "/usr/local/tomcat/webapps/ROOT/okname";
	String exe = "d:\\oknameweb\\okname.exe";

	// 지점이 없는 회사는 x
	String qryBrcCd = "x";
	String qryBrcNm = "x";
	// 다음 항목은 회원사 공통 
	String qryId = "u1234";// 쿼리ID, 현재는 고정값 
	// 현재 날짜 
	String qryDt = df.format(cal.getTime());//date(Ymd);//<- 현재 시간 함수로 적용하세요.

	if (name == null || ssn == null || name.length() == 0 || ssn.length() == 0) {
%>
		<form method="post" action="okname2.jsp">
		<table>
		<tr>
		<td>이름</td><td><input type="text" name="name"></td>
		</tr>
		<tr>
		<td>주민번호(숫자만)</td><td><input type="text" name="ssn"></td>
		</tr>
		<tr>
		<td>회원사ID</td><td><input type="text" name="memid" value=""></td>
		</tr>
		<tr>
		<td>회원사DOMAIN</td><td><input type="text" name="qryDomain" value=""></td>
		</tr>
		<tr>
		<td>회원사IP</td><td><input type="text" name="qryIP" value=""></td>
		</tr>
		<tr>
		<td>내/외국인 구분</td><td> 
					<input type="radio" name="qryKndCd" value="1" checked>내국인
				<input type="radio" name="qryKndCd" value="2">외국인</td>
		</tr>
		<tr>
		<td>요청 구분</td><td>
				<input type="radio" name="qryRsnCd" value="01" checked>회원가입
				<input type="radio" name="qryRsnCd" value="02">회원정보수정
				<input type="radio" name="qryRsnCd" value="03">회원탈회
				<input type="radio" name="qryRsnCd" value="04">성인인증
				<input type="radio" name="qryRsnCd" value="05">기타</td>
		</tr>
		<tr>
			<td>
			EndPointURL</td>
			<td><input type="text" name="EndPointURL" size=80 value="http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService">
			</td>
		</tr>
		<tr><td>
		<input type="submit" value="확인"><td>http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService은 테스트(TEST) 서버 URL입니다.</td>
		</td></tr>
		<tr><td>&nbsp;</td><td>http://www.allcredit.co.kr/KcbWebService/OkNameService은 운영(REAL) 서버 URL입니다.</td>
		</tr>
		</table>
		</form>	

<%
} else {
	writer.write("<br>");
	//###########################################################################
	//KCB OKNAME 암호화 SOAP 통신
	//콤포넌트가 있는지 체크
	File file = new File(exe);
	if(!file.exists()) {
		writer.write(exe + " 콤포넌트가 없습니다. 파일 경로를 확인하세요.<br><br>");
	}
	else {
		String[] cmd = new String[14];
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
		cmd[13]="D";// debug모드일때는 "D" 아니면 ""

		// 화변에 뿌리기
		for(int i=0; i<cmd.length; i++) {
			writer.write(cmd[i] + " ");
			System.out.print(cmd[i] + " ");
		}
		writer.write("<br>");
		System.out.print("\n");

		String result="";

		try {
			Process oProcess = oRuntime.exec(cmd);
			oProcess.waitFor();// 프로세스가 끝날때 까지 기다림

			// 외부 프로그램 출력 읽기
			BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
			BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));
			String s;
			// "표준 출력"과 "표준 에러 출력"을 출력
			while ((s =   stdOut.readLine()) != null) writer.write(s);
			while ((s = stdError.readLine()) != null) writer.write(s);

			int ret = oProcess.exitValue();
			writer.write("ret="+ret+"<br>");// debug
			if(ret <=200) {
				result = "B" + dcf.format(ret);
			}
			else {
				result = "S" + dcf.format(ret);
			}
			//###########################################################################
		}
		catch(Exception e) {
			System.out.println("[okname] exec error");
			writer.write("[okname] exec error<br>");
		}
		
		writer.write("<br>이름: "+name+"<br>");
		writer.write("주민번호(숫자만): "+ssn+"<br>");
		writer.write("회원사ID: "+memid+"<br>");
		writer.write("회원사Domain: "+qryDomain+"<br>");
		writer.write("회원사IP: "+qryIP+"<br>");
		writer.write("내/외국인 구분: "+qryKndCd+" (요청구분  개인 : 1, 외국인 : 2)<br>");
		writer.write("요청 구분: "+qryRsnCd+" (조회사유  회원가입 : 01, 회원정보수정 : 02, 회원탈회 : 03, 성인인증 : 04, 기타 : 05)<br>");
	
		writer.write("<br>chkName result: "+result+"<br>");
		writer.write("<br>");
	}
}
%>
주의:<br>
이 sample 프로그램은 고객사서버 <-> KCB 사이구간인 서버구간 암호화만 제공하며<br>
EndUser와 고객사서버간의 웹구간 암호화는 제공하지 않습니다.
