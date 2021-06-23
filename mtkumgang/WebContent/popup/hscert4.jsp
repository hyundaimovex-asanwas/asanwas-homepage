<%
/*
	본인인증 결과 화면
   (고객 인증정보 KCB팝업창에서 입력용)
*/
	/* 공통 리턴 항목 */
	String idcf_mbr_com_cd			=	request.getParameter("idcf_mbr_com_cd");//		고객사코드
	String hs_cert_svc_tx_seqno		=	request.getParameter("hs_cert_svc_tx_seqno");//	거래번호
	String rst_cd					=	request.getParameter("rst_cd");//				결과코드
	String rst_msg					=	request.getParameter("rst_msg");//				결과메세지
			rst_msg = 	java.net.URLDecoder.decode(rst_msg);
	String cert_dt_tm				=	request.getParameter("cert_dt_tm");//			인증일시

	//아이핀으로부터 받는 parameter는  encPsnlInfo, WEBPUBKEY, WEBSIGNATURE으로 대소문자 동일하여야 한다.
    //아이핀팝업에서 조회한 PERSONALINFO이다.
	String encInfo = request.getParameter("encInfo");
	String cpCode    = idcf_mbr_com_cd;				//중복가입확인정보 생성을 위한 사이트 식별번호 (회원사코드를 사용)

	//아이핀 서버와 통신을 위한 키파일 생성
	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	//KCB서버 공개키
	String WEBPUBKEY = request.getParameter("WEBPUBKEY") == null || "".equals(request.getParameter("WEBPUBKEY").trim()) ? "" : request.getParameter("WEBPUBKEY").trim();
	//KCB서버 서명값
	String WEBSIGNATURE = request.getParameter("WEBSIGNATURE") == null || "".equals(request.getParameter("WEBSIGNATURE").trim()) ? "" : request.getParameter("WEBSIGNATURE").trim();
	
	/*String[] cmd = new String[7];
	cmd[0] = "/home/jeus/okname/src/okname";
	cmd[1] = "/home/jeus/okname/src/okname.key";
	cmd[2] = WEBPUBKEY;       //server publickey
	cmd[3] = WEBSIGNATURE;    //server signature
	cmd[4] = encPsnlInfo;     //PERSONALINFO
	cmd[5] ="/home/jeus/okname/src/";
	cmd[6] ="IL";*/
	
	String[] cmd = new String[9];
	cmd[0] = "/home/jeus6/okname/okname_v327/okname";
	cmd[1] = "/home/jeus6/okname/okname_v327/selfcert_"+cpCode+".key";
	cmd[2] = cpCode;            //memid
	String referer = request.getHeader("referer"); 
	if( 0 <= referer.indexOf("tallcredit") )
		cmd[3] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
	else
		cmd[3] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// 운영 서버
	cmd[4] = WEBPUBKEY;       //server publickey
	cmd[5] = WEBSIGNATURE;    //server signature
	cmd[6] = encInfo;     //PERSONALINFO
	cmd[7] ="/home/jeus6/okname/okname_v327/";
	cmd[8] ="SL";


	String[] field = new String[13];

    Process oProcess = null;
    BufferedReader stdOut = null;
    BufferedReader stdError = null;
    InputStream outstream = null;
    InputStream errorstream = null;

	ArrayList outData = new ArrayList(0); 		//인증결과
		
	try {

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
			// writer.write(s);	
		}
    	while ((s = stdError.readLine()) != null){
			//	writer.write(s);
		}
    
		int ret = oProcess.exitValue();
	
		// 외부 프로그램 반환값 출력 (이 부분은 필수가 아님)
//		writer.write("ret=" + ret + "<br>");
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
%>
<html>
<head>
<title>KCB 본인인증 샘플</title>
</head>
<body>
<h3>인증결과</h3>
<h4> 평문 </h4>
<ul>
  <li>결과코드		: <%=rst_cd%></li>
  <li>결과메세지	: <%=rst_msg%></li>
  <li>거래번호		: <%=hs_cert_svc_tx_seqno%> </li>
  <li>인증요청코드	: <%=hs_cert_msr_cd%></li>
</ul>
</body>
</html>
