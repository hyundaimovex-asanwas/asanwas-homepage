<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
Writer writer = response.getWriter();
Runtime oRuntime = Runtime.getRuntime();

writer.write(request.getParameter("ssn")+"<br>");
writer.write(request.getParameter("hs_cert_msr_cd")+"<br>");

/**************************************************************************
okname 파라미터
**************************************************************************/

String ssn = request.getParameter("ssn");//                주민번호
String hs_cert_msr_cd = request.getParameter("hs_cert_msr_cd");//  인증요청수단코드(00:전체, 10:휴대폰, 20:신용카드, 30:공인인증서)
String filler1 = "0";// ""로 채우면 안됨 임의의 값으로 채울것

String idcf_mbr_com_cd = "0000000000";
String client_ip = "192.168.102.109";
String client_domain = "test.co.kr";

String ebz_svc_tp_cd = "001";//                        서비스구분코드(001:팝업형, 002:임베디드형)
String hs_cert_svc_tx_seqno = "291200020091";//            거래일련번호

//okname을 호출할 파라미터 정보(내부에서 암호화 됨)
String mbphn_no = "mbphn_no";
String card_no = "card_no";
String email = "email";

//okname 실행 정보
String exe = "d:\\okname\\src\\okname.exe";
String server_domain = "tallcredit.kcb4u.com:9088";
String EndPointURL = "http://"+server_domain+"/KcbWebService/OkNameService";

String logpath = "./";
String Options = "PL";

String[] cmd = new String[15];
cmd[0]=exe;
cmd[1]=ssn;
cmd[2]=mbphn_no;
cmd[3]=card_no;
cmd[4]=hs_cert_msr_cd;
cmd[5]=email;
cmd[6]=filler1;
cmd[7]=idcf_mbr_com_cd;
cmd[8]=client_ip;
cmd[9]=client_domain;
cmd[10]=ebz_svc_tp_cd;
cmd[11]=hs_cert_svc_tx_seqno;
cmd[12]=EndPointURL;
cmd[13]=logpath;
cmd[14]=Options;

for(int i=0; i<15; i++) {
	writer.write (cmd[i]+" ");
}
writer.write("<br>");

/**************************************************************************
okname 실행
**************************************************************************/

//cmd 실행
Process oProcess = oRuntime.exec(cmd);
// 외부 프로그램 출력 읽기
BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));

String[] out1 = new String[7];
String s="";
int ret_cnt=0;
while ((s =   stdOut.readLine()) != null)
{
	out1[ret_cnt++] = s;
}

// 외부 프로그램 반환값 출력 (이 부분은 필수가 아님)
oProcess.waitFor();// 프로세스가 끝날때 까지 기다림
int ret = oProcess.exitValue();

writer.write("ret="+ret+"<br>");

/**************************************************************************
okname 응답 정보
**************************************************************************/

String retcode = "";
String retmsg = "";
hs_cert_svc_tx_seqno = "";
String e_ssn = "";
String e_mbphn_no = "";
String e_card_no = "";
String e_email = "";

if (ret == 0) {//성공일 경우 변수를 결과에서 얻음
	retcode = out1[0];
	retmsg  = out1[1];
	hs_cert_svc_tx_seqno = out1[2];
	e_ssn = out1[3];
	e_mbphn_no = out1[4];
	e_card_no = out1[5];
	e_email = out1[6];
}
else
	retcode = out1[0];


/**************************************************************************
hscert3.jsp 실행 정보(SOAP호출에서는 사용하지 않고 POPUP시에만 사용함)
**************************************************************************/

String rqst_site_nm = "OKName";// 사이트명 16byte (휴대폰인증번호 송신시 제휴사명에 노출)
String target_id = "";// 타겟ID (팝업오픈 스크립트의 window.name 과 동일하게 설정
String return_url = "http://localhost/hscert3.jsp";// 본인인증 완료후 리턴될 URL (도메인 포함 full path)
String hs_cert_rqst_caus_cd	=	"00";// 인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타)
%>


<html>
	<head>
	<title>KCB 본인인증 샘플</title>
	<script>
		function openPop(obj){
		window.name = "";
		window.open("", "auth_popup", "width=432,height=560,scrollbar=yes");

		document.form1.action = "http://"+obj+"/CommonSvl";
		document.form1.target = "auth_popup";
		document.form1.method = "post";

		//alert(document.form1.action);
		document.form1.submit();
	}
	</script>
	</head>

 <body>
	<form name="form1">
	<!-- POP-UP 요청 정보정보 -->
	<!--// 필수 항목 -->
	<input type="hidden" name="tc" value="kcb.pis.front.gw.cmd.GW001AuthGWCmd">				<!-- 변경불가-->
	<input type="hidden" name="idcf_mbr_com_cd"			value="<%=idcf_mbr_com_cd%>">		<!-- 고객사코드 -->
	<input type="hidden" name="hs_cert_svc_tx_seqno"	value="<%=hs_cert_svc_tx_seqno%>">	<!-- 거래번호 -->
	<input type="hidden" name="ebz_svc_tp_cd"			value="<%=ebz_svc_tp_cd%>">			<!-- 서비스구분코드 001:팝업형, 002:임베디드형 -->
	<input type="hidden" name="hs_cert_msr_cd"			value="<%=hs_cert_msr_cd%>">		<!-- 인증요청수단코드 -->
	<input type="hidden" name="ssn"						value="<%=e_ssn%>">					<!-- 주민번호 -->
	<input type="hidden" name="hs_cert_rqst_caus_cd"	value="<%=hs_cert_rqst_caus_cd%>">	<!-- 인증요청사유코드 -->

	<input type="hidden" name="rqst_site_nm"			value="<%=rqst_site_nm%>">			<!-- 사이트명 (휴대폰인증번호 송신시 제휴사명에 노출) -->
	<input type="hidden" name="target_id"				value="<%=target_id%>">				<!-- 타겟ID --> 
	<input type="hidden" name="return_url"				value="<%=return_url%>">			<!-- 리턴URL --> 
	<!-- 필수 항목 //-->	

	<!--// 선택 항목 -->
	<input type="hidden" name="email" value="">				<!-- 이메일주소 (고객에게 본인인증 결과 메일을 송신할 경우) - 서비스 예정  -->
	<input type="hidden" name="mbl_tel_cmm_cd" value="">	<!-- 통신사 구분코드 (01:SKT, 02:KTF, 03:LGT) -->
	<input type="hidden" name="mbphn_no" value="">			<!-- 휴대폰번호-->
	<input type="hidden" name="card_no" value="">			<!-- 신용카드번호 -->
	<input type="hidden" name="card_vld_term" value="">		<!-- 신용카드유효기간 YY/MM -->
	<input type="hidden" name="card_pwd" value="">			<!-- 신용카드빌밀번호 앞2자리 -->
	<!-- 선택 항목 //-->

	</form>
 </body>

<%
 	if (retcode.equals("B000")) {
		//팝업요청
		writer.write ("<script>openPop(\""+server_domain+"\");</script>");
	} else {
		//요청 실패 페이지로 리턴
		writer.write ("<script>alert(\""+retcode+"\"); window.history.back();</script>");
	}
%>
</html>
