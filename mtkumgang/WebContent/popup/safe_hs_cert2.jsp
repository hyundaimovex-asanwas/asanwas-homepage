<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%@ page import="com.hdasan.util.EmpIdInfo" %>
<%
//세션 체크 ///////////////////////////////////////////////////////////////////////
String ssID 			= request.getParameter("ssID");
EmpIdInfo EI = new EmpIdInfo();
String result = EI.FPwd(request, response); //로긴 처리
//세션 체크 ///////////////////////////////////////////////////////////////////////
if(!result.equals(ssID)){	//실패시

	return;
}else{//체크 성공!

    //**************************************************************************
	// 파일명 : safe_hs_cert2.jsp
	//
	// 생년월일 본인 확인서비스 개인 정보 입력 화면
	//    (고객 인증정보 KCB팝업창에서 입력용)
    //
    // ※주의
    // 	실제 운영시에는 
    // 	response.write를 사용하여 화면에 보여지는 데이터를 
    // 	삭제하여 주시기 바랍니다. 방문자에게 사이트데이터가 노출될 수 있습니다.
    //**************************************************************************

	
	/**************************************************************************
	 * okname 생년월일 본인 확인서비스 파라미터
	 **************************************************************************/
    String empid = request.getParameter("empid");						// *** 아이디 ***
	String ssn = request.getParameter("ssn");						// *** 주민번호 ***
	String inTpBit 		= "0";											// 입력구분코드 (고정값 '0' - KCB팝업에서 인증정보 입력)
	String name 		= "x";											// 성명 (고정값 'x' - KCB팝업에서 인증정보 입력)
	String birthday 	= "x";											// 생년월일 (고정값 'x' - KCB팝업에서 인증정보 입력)
	String gender 		= "x";											// 성별 (고정값 'x' - KCB팝업에서 인증정보 입력)
	String ntvFrnrTpCd 	= "x";											// 내외국인구분 (고정값 'x' - KCB팝업에서 인증정보 입력)
	String mblTelCmmCd 	= "x";											// 이동통신사코드 (고정값 'x' - KCB팝업에서 인증정보 입력)
	String mbphnNo 		= "x";											// 휴대폰번호 (고정값 'x' - KCB팝업에서 인증정보 입력)
	
	// ########################################################################
	// # 운영전환시 확인 필요
	// ########################################################################
	String memId = "P05170000000";										// 회원사코드
	String clientIp = "203.242.32.194";												// 회원사 IP, InetAddress.getLocalHost().getHostAddress() 로 얻어올 수 있음.
	String clientDomain = "www.mtkumgang.com";									// 회원사 도메인. (휴대폰인증번호 송신시 제휴사명에 노출)
	
	// 거래일련번호 ( 20자리의 문자열. 0-9,A-Z,a-z 사용.)
	/**  거래 일련 번호는 아래와 같이 생성하는 것을 추천. *********************************
	** 별도 생성하여 사용할 경우 동일 거래번호를 두번 사용할 수 없는 것에 주의하여 작성. **/
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String svcTxSeqno = df.format(cal.getTime()); 
	//**********************************************************************************/
	
	// 예약 항목
	String rsv1 = "0";
	String rsv2 = "0";
	String rsv3 = "0";
	
	String hsCertMsrCd	=	"10";										// 인증수단코드 2byte  (10:핸드폰)
	String hsCertRqstCausCd	=	"00";									// 인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타)
	
	//okname을 호출할 파라미터 정보(내부에서 암호화하여 리턴함. 팝업창에 미리 세팅하는 경우 암호화된 값을 팝업으로 전달할 수 있다.)
	String returnMsg = "x";
	
	// ########################################################################
	// # 리턴 URL 설정
	// ########################################################################
	String returnUrl = "http://erp.hdasan.com/services/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** 본인인증 완료후 리턴될 URL (도메인 포함 full path);
	
	//okname 실행 정보
	// ########################################################################
	// # 모듈 경로 지정 및 권한 부여 (절대경로)
	// ########################################################################
	String exe = "/home/webadmin/linux32_nonstatic_glibc2.3.4/okname";

	// ########################################################################
	// # 운영전환시 변경 필요
	// ########################################################################
	//String endPointURL = "http://tsafe.ok-name.co.kr:29080/KcbWebService/OkNameService";	// 테스트 서버
     String endPointURL = "http://safe.ok-name.co.kr/KcbWebService/OkNameService";		// 운영 서버
	
	// ########################################################################
	// # 로그 경로 지정 및 권한 부여 (절대경로)
	// # 옵션값에 'L'을 추가하는 경우에만 로그가 생성됨.
	// ########################################################################
	String logpath = "./";
	String option = "QL";
	
	String[] cmd = new String[22];
	cmd[0]=exe;
	cmd[1]=svcTxSeqno;
	cmd[2]=name;
	cmd[3]=birthday;
	cmd[4]=gender;
	cmd[5]=ntvFrnrTpCd;
	cmd[6]=mblTelCmmCd;
	cmd[7]=mbphnNo;
	cmd[8]=rsv1;
	cmd[9]=rsv2;
	cmd[10]=rsv3;
	cmd[11]=returnMsg;
	cmd[12]=returnUrl;
	cmd[13]=inTpBit;
	cmd[14]=hsCertMsrCd;
	cmd[15]=hsCertRqstCausCd;
	cmd[16]=memId;
	cmd[17]=clientIp;
	cmd[18]=clientDomain;
	cmd[19]=endPointURL;
	cmd[20]=logpath;
	cmd[21]=option;

//	for(int i=0; i<22; i++) {
//		out.println(cmd[i]+" ");
//	}
//	out.println("<br>");
	
	/**************************************************************************
	okname 실행
	**************************************************************************/
	
	//cmd 실행
	Runtime oRuntime = Runtime.getRuntime();
	Process oProcess = oRuntime.exec(cmd);
	// 외부 프로그램 출력 읽기
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	
	String[] out1 = new String[20];
	String s="";
	int ret_cnt=0;
	while ((s =   stdOut.readLine()) != null) {
//		out.println(s+"<br/>");
		out1[ret_cnt++] = s;
	}
	
	// 외부 프로그램 반환값 출력 
	oProcess.waitFor();// 프로세스가 끝날때 까지 기다림
	int ret = oProcess.exitValue();
	
//	out.println("ret="+ret+"<br>");
	
	/**************************************************************************
	okname 응답 정보
	**************************************************************************/
	
	String retcode = "";
	String retmsg = "";
	String e_rqstData = "";
	
	if (ret == 0) {//성공일 경우 변수를 결과에서 얻음
		retcode = out1[0];
		retmsg  = out1[1];
		e_rqstData = out1[2];
	}
	else {
		retcode = out1[0];
		retmsg  = out1[1];
	}
	
	
	/**************************************************************************
	safe_hs_cert3.jsp 실행 정보(SOAP호출에서는 사용하지 않고 POPUP시에만 사용함)
	**************************************************************************/
	
	String targetId = "";// 타겟ID (팝업오픈 스크립트의 window.name 과 동일하게 설정
	 
	// ########################################################################
	// # 운영전환시 변경 필요
	// ########################################################################
    //String commonSvlUrl = "https://tsafe.ok-name.co.kr:2443/CommonSvl";	// 테스트 URL
     String commonSvlUrl = "https://safe.ok-name.co.kr/CommonSvl";	// 운영 URL
%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "No-cache");

	//String ssID		= request.getParameter("ssID");
	//if(ssID==null) ssID="";
%>

<html>
	<title>KCB 생년월일 본인 확인서비스</title>
	<head>
	<script type="text/javascript">

		function request(){

		window.name = "<%=targetId%>";

		document.form1.action = "<%=commonSvlUrl%>";
		document.form1.method = "post";

		document.form1.submit();
	}
	</script>
	</head>

 <body>
	<form name="form1">
	<!-- 인증 요청 정보 -->
	<!--// 필수 항목 -->
	<input type="hidden" name="tc" value="kcb.oknm.online.safehscert.popup.cmd.P901_CertChoiceCmd">				<!-- 변경불가-->
	<input type="hidden" name="rqst_data"		value="<%=e_rqstData%>">		<!-- 요청데이터 -->
	<input type="hidden" name="target_id"		value="<%=targetId%>">			<!-- 타겟ID --> 
	<!-- 필수 항목 //-->	
	</form>
 </body>
<%
 	if ("B000".equals(retcode)) {
		//인증요청
		out.println("<script>request();</script>");
	} else {
		//요청 실패 페이지로 리턴
		out.println("<script>alert(\""+retcode+"\"); self.close(); </script>");
	}
%>
</html>
<%
}//if(!result.equals(ssID))
%>
