<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>  
<%@ page import="java.io.*"%>
<%	
	String idpUrl = "";

    //웹사이트가 PERSONALINFO를 RECEIVE하는 페이지
	String returnUrl = "";

	//KCB 테스트서버를 호출할 경우
	//idpUrl    = "https://tipin.ok-name.co.kr:8443/tis/ti/POTI90B_SendCertInfo.jsp";
	//returnUrl = "http://localhost/ipin2.jsp";

	//KCB 운영서버를 호출할 경우
	idpUrl    = "https://ipin.ok-name.co.kr/tis/ti/POTI90B_SendCertInfo.jsp";
	returnUrl = "http://www.mtkumgang.com/member/member_action.jsp";


	String idpCode   = "V";//웹사이트 선호본인확인기관(KCB기관)코드
	String cpCode    = "P05170000000";//중복가입확인정보 생성을 위한 사이트 식별번호

	//아이핀 서버와 통신을 위한 키파일 생성
	Writer writer    = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	/*
	String[] cmd = new String[4];
	cmd[0] = "/home/jeus/okname/src/okname";
	cmd[1] = "/home/jeus/okname/src/okname.key";
	cmd[2] = "/home/jeus/okname/src/";
	cmd[3] = "KL";
	*/
	String[] cmd = new String[8];
	cmd[0] = "d:\\okname\\bin\\win32\\exe\\okname.exe";//exe
	cmd[1] = "d:\\okname\\src\\okname.key";//keypath

	cmd[2] = cpCode;//memid
	cmd[3] = "0";//reserved1
	cmd[4] = "0";//reserved2
	//cmd[5] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
	cmd[5] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// 운영 서버
	
	cmd[6] = "/home/webadmin/okname/okname_v2.91/";// logpath
	cmd[7] = "CL";// Option

for(int i=0; i<8; i++) {
	out.write(cmd[i]);
	out.write(" ");
	
}
	String s = "", pubkey = "", sig = "", curtime = "";
	
	try {
		Process oProcess = oRuntime.exec(cmd);
		// 외부 프로그램 출력 읽기
		BufferedReader stdOut = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
		
		int ret_cnt=0;

		while ((s = stdOut.readLine()) != null){
			if(ret_cnt == 0)
				pubkey = s;    //client publickey
			if(ret_cnt == 1)
				sig = s;       //client signature
			if(ret_cnt == 2)
				curtime = s;   //cprequestnum
			ret_cnt++;
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
%>

<html>
<head>
<script language="JavaScript">
//<!--
function certKCBIpin(){
	var popupWindow = window.open( "", "kcbPop", "left=200, top=100, status=0, width=450, height=550" );
	document.kcbInForm.target = "kcbPop";
	//KCB 테스트서버를 호출할 경우
    //document.kcbInForm.action = "https://tipin.ok-name.co.kr:8443/tis/ti/POTI01A_LoginRP.jsp";

    //KCB 운영서버를 호출할 경우
	document.kcbInForm.action = "https://ipin.ok-name.co.kr/tis/ti/POTI01A_LoginRP.jsp";

	document.kcbInForm.submit();
	popupWindow.focus();	
	return;	
}
//-->
</script>

<%--
**************************************************************************************
* 자바스크립트 끝
**************************************************************************************
--%>
</head>
<body>
	<input type="button" value="아이핀" onclick="certKCBIpin()"/>
	<form name="kcbInForm" method="post" >
		<input type="hidden" name="IDPCODE" value="<%=idpCode%>" />
		<input type="hidden" name="IDPURL" value="<%=idpUrl %>" />
		<input type="hidden" name="CPCODE" value="<%=cpCode%>" />	
		<input type="hidden" name="CPREQUESTNUM" value="<%=curtime%>" />
		<input type="hidden" name="RETURNURL" value="<%=returnUrl %>" />
		<input type="hidden" name="WEBPUBKEY" value="<%=pubkey%>" />
		<input type="hidden" name="WEBSIGNATURE" value="<%=sig%>" />
	</form>	
	<form name="kcbOutForm" method="post">
		<input type="hidden" name="encPsnlInfo" />
		<input type="hidden" name="virtualno" />
		<input type="hidden" name="dupinfo" />
		<input type="hidden" name="realname" />
		<input type="hidden" name="cprequestnumber" />
		<input type="hidden" name="age" />
		<input type="hidden" name="sex" />
		<input type="hidden" name="nationalinfo" />
		<input type="hidden" name="birthdate" />
		<input type="hidden" name="coinfo1" />
		<input type="hidden" name="coinfo2" />
		<input type="hidden" name="ciupdate" />
		<input type="hidden" name="cpcode" />
		<input type="hidden" name="authinfo" />
	</form>
</body>
</html>