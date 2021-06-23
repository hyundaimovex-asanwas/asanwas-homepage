<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
/**************************************************************************
	파일명 : safe_hs_cert3.jsp
	
	생년월일 본인 확인서비스 결과 화면(return url)
**************************************************************************/
	/* apass_action 구분 값 */
	//String cmd="C";//회원가입 체크

	/* 공통 리턴 항목 */
	String idcfMbrComCd		=	request.getParameter("idcf_mbr_com_cd");		// 고객사코드
	String hsCertSvcTxSeqno	=	request.getParameter("hs_cert_svc_tx_seqno");	// 거래번호
	String rqstSiteNm		=	request.getParameter("rqst_site_nm");						// 접속도메인	
	String hsCertRqstCausCd	=	request.getParameter("hs_cert_rqst_caus_cd");	// 인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타);// 

	String resultCd			=	request.getParameter("result_cd");				// 결과코드
	String resultMsg		=	java.net.URLDecoder.decode(request.getParameter("result_msg"));	// 결과메세지
	String certDtTm			=	request.getParameter("cert_dt_tm");				// 인증일시

	/**************************************************************************
	 * 모듈 호출	; 생년월일 본인 확인서비스 결과 데이터를 복호화한다.
	 **************************************************************************/
	String encInfo = request.getParameter("encInfo");

	//KCB서버 공개키와 서명값
	String WEBPUBKEY = request.getParameter("WEBPUBKEY") == null || "".equals(request.getParameter("WEBPUBKEY").trim()) ? "" : request.getParameter("WEBPUBKEY").trim();
	String WEBSIGNATURE = request.getParameter("WEBSIGNATURE") == null || "".equals(request.getParameter("WEBSIGNATURE").trim()) ? "" : request.getParameter("WEBSIGNATURE").trim();

    // 모듈 파라미터 설정.

	String[] cmd = new String[9];
	//okname 실행 정보
	// ########################################################################
	// # 모듈 경로 지정 및 권한 부여 (절대경로)
	// ########################################################################
	cmd[0] = "/home/webadmin/linux32_nonstatic_glibc2.3.4/okname";

	// ########################################################################
	// # 암호화키 파일 설정 (절대경로) - 파일은 주어진 파일명으로 자동 생성 됨
	// ########################################################################
	cmd[1] = "/home/webadmin/linux32_nonstatic_glibc2.3.4/safecert_"+idcfMbrComCd+".key";				// IPIN에서 설정된 키파일명과 다른 이름으로 설정해야함.

	cmd[2] = idcfMbrComCd;            // 회원사코드

	// ########################################################################
	// # 운영전환시 변경 필요
	// ########################################################################
	//cmd[3] = "http://tsafe.ok-name.co.kr:29080/KcbWebService/OkNameService";	//테스트 EndPointURL
     cmd[3] = "http://safe.ok-name.co.kr/KcbWebService/OkNameService";		// 운영 EndPointURL

	cmd[4] = WEBPUBKEY;       //server publickey
	cmd[5] = WEBSIGNATURE;    //server signature
	cmd[6] = encInfo;     //PERSONALINFO

	// ########################################################################
	// # 로그 경로 지정 및 권한 부여 (절대경로)
	// # 옵션값에 'L'을 추가하는 경우에만 로그가 생성됨.
	// ########################################################################
	cmd[7] ="C:\\okname\\";
	cmd[8] ="SL";

	String[] field = new String[17];

	Runtime oRuntime = null;
    Process oProcess = null;
    BufferedReader stdOut = null;
    BufferedReader stdError = null;
    InputStream outstream = null;
    InputStream errorstream = null;

	ArrayList outData = new ArrayList(0); 		//인증결과
		
	try {
        oRuntime = Runtime.getRuntime();
		oProcess = oRuntime.exec(cmd);
		oProcess.waitFor();					// 프로세스 종료를 기다림.
     
        outstream = oProcess.getInputStream();
        errorstream = oProcess.getErrorStream();
        stdOut = new BufferedReader ( new InputStreamReader( outstream ) );
        stdError = new BufferedReader ( new InputStreamReader( errorstream ) );

    	String s;
		int cnt = 0;
    	// "표준 출력"과 "표준 에러 출력"을 출력. 
    	// **주의** 환경에따라 해당버퍼를 소진시키지 않는 경우 프로세스가 즉시 종료되지 않을 수 있다.
    	while ((s = stdOut.readLine()) != null){	
			field[cnt++]=s;	
			out.println(cnt+":"+s+"<br/>");	
		}
		cnt = 0;
    	while ((s = stdError.readLine()) != null){
			out.println(cnt+":"+s+"<br/>");	
		}
    
		int ret = oProcess.exitValue();
	
		// 외부 프로그램 반환값 출력 (이 부분은 필수가 아님)

        if( ret == 0 ){
			out.println("복호화 요청 호출 성공.<br/>");		 
            resultCd = field[0];                    
            hsCertSvcTxSeqno = field[2];
        }
        else {
			out.println("복호화 요청 호출 에러. 리턴값 : " + ret + "<br/>");		 
		}
	}
    catch(Exception e) {
        e.printStackTrace();

    //finally절에 명시적으로 close 선언
    }finally{

        if(oProcess != null) {
            try{
                if(stdOut != null) stdOut.close();
                if(stdError != null) stdError.close();
                if(outstream != null ) outstream.close();
                if(errorstream != null ) errorstream.close();
            }
            finally {
                oProcess.destroy();
            }
        }
    }
    
	//**************************************************************************
	// 복호화된 본인확인 결과 데이터
	//**************************************************************************
    out.println("처리결과코드	:" + field[0]	+ "<br/>");		 
    out.println("처리결과메시지	:" + field[1]	+ "<br/>");		 
    out.println("거래일련번호	:" + field[2]	+ "<br/>");		 
    out.println("인증일시		:" + field[3]	+ "<br/>");		 
    out.println("DI				:" + field[4]	+ "<br/>");		 
    out.println("CI				:" + field[5]	+ "<br/>");		 
    out.println("성명			:" + field[7]	+ "<br/>");		 
    out.println("생년월일		:" + field[8]	+ "<br/>");		 
    out.println("성별			:" + field[9]	+ "<br/>");		 
    out.println("내외국인구분	:" + field[10]	+ "<br/>");	 
    out.println("통신사코드		:" + field[11]	+ "<br/>");	 
    out.println("휴대폰번호		:" + field[12]	+ "<br/>");	 
    out.println("리턴메시지		:" + field[16]	+ "<br/>");	 

// 데이터 검증 종료 */
%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "No-cache");

	String ssID		= request.getParameter("ssID");
	if(ssID==null) ssID="";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>KCB 생년월일 본인 확인서비스 샘플</title>
    <script language="javascript" type="text/javascript" >
	function fncOpenerSubmit() {
		opener.document.kcbResultForm.idcf_mbr_com_cd.value = "<%=idcfMbrComCd%>";
		opener.document.kcbResultForm.hs_cert_rqst_caus_cd.value = "<%=hsCertRqstCausCd%>";
		opener.document.kcbResultForm.result_cd.value = "<%=field[0]%>";
		opener.document.kcbResultForm.result_msg.value = "<%=field[1]%>";
		opener.document.kcbResultForm.hs_cert_svc_tx_seqno.value = "<%=field[2]%>";
		opener.document.kcbResultForm.cert_dt_tm.value = "<%=field[3]%>";
		opener.document.kcbResultForm.di.value = "<%=field[4]%>";
		opener.document.kcbResultForm.ci.value = "<%=field[5]%>";
		opener.document.kcbResultForm.name.value = "<%=field[7]%>";
		opener.document.kcbResultForm.birthday.value = "<%=field[8]%>";
		opener.document.kcbResultForm.gender.value = "<%=field[9]%>";
		opener.document.kcbResultForm.nation.value = "<%=field[10]%>";
		opener.document.kcbResultForm.tel_com_cd.value = "<%=field[11]%>";
		opener.document.kcbResultForm.tel_no.value = "<%=field[12]%>";
		//opener.document.kcbResultForm.return_msg.value = "<%=field[16]%>";
		opener.document.kcbResultForm.return_msg.value = "<%=field[16]%>";
		opener.document.kcbResultForm.action = "safe_apass_action.jsp";
		opener.document.kcbResultForm.submit();
		
		self.close();
	}	
	</script>
</head>
<body onload="javascript:fncOpenerSubmit()">
	<b>본인인증결과</b>
 	결과코드		: <%=resultCd%><br />
 	결과메세지		: <%=resultMsg%><br />
	거래번호		: <%=hsCertSvcTxSeqno%><br />
 	인증일시		: <%=certDtTm%><br />
	고객사코드		: <%=idcfMbrComCd%><br />
	접속도메인		: <%=rqstSiteNm%><br />
	인증요청사유코드: <%=hsCertRqstCausCd%><br />
	
</body>
</html>

