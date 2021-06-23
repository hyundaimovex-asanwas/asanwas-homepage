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


// 경국 소스 원본 -----------------------------------------------------------------------------//

	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	//writer.write(request.getParameter("ssn")+"<br>");
	//writer.write(request.getParameter("hs_cert_msr_cd")+"<br>");

/**************************************************************************
okname 파라미터
**************************************************************************/
	String empid = request.getParameter("empid");						// *** 아이디 ***
	//String ssID = request.getParameter("ssID");						// *** 세션id***
	String ssn = request.getParameter("ssn");						// *** 주민번호 ***
	//String hs_cert_msr_cd = request.getParameter("hs_cert_msr_cd");	// 인증요청수단코드(00:전체, 10:휴대폰, 20:신용카드, 30:공인인증서)
	String hs_cert_msr_cd = "00";	// 인증요청수단코드(00:전체, 10:휴대폰, 20:신용카드, 30:공인인증서)
	String filler1 = "000";					
	
	String idcf_mbr_com_cd = "P05170000000";					// *** 회원사코드 ***
	String client_ip = "203.242.32.194";										// 회원사 IP, InetAddress.getLocalHost().getHostAddress() 로 얻어올 수 있음.
	String client_domain = "www.hyundai-asan.com";						// *** 회원사 도메인.
	
	String ebz_svc_tp_cd = "001";								// 서비스구분코드(001:팝업형, 002:임베디드형)
//	String hs_cert_svc_tx_seqno = "291200020091";				// 거래일련번호 ( 20자리의 문자열. 0-9,A-Z,a-z 사용.)
	/**  거래 일련 번호는 아래와 같이 생성하는 것을 추천. *********************************
	** 별도 생성하여 사용할 경우 동일 거래번호를 두번 사용할 수 없는 것에 주의하여 작성. **/
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String hs_cert_svc_tx_seqno = df.format(cal.getTime()); 
	//**********************************************************************************/
	
	//okname을 호출할 파라미터 정보(내부에서 암호화하여 리턴함. 팝업창에 미리 세팅하는 경우 암호화된 값을 팝업으로 전달할 수 있다.)
	String mbphn_no = "002";						// 아이디로 대체
	//String mbphn_no = "003";//현재 사용하지 않으므로 3자리 이상의 값으로 채움 
	String card_no = "004";//현재 사용하지 않으므로 3자리 이상의 값으로 채움 
	String email = "005";//현재 사용하지 않으므로 3자리 이상의 값으로 채움 

	//okname 실행 정보
	//String exe = "d:\\okname\\src\\okname.exe";
	String exe = "/home/webadmin/okname/okname_v2.91/okname";//exe
	//String server_domain = "tallcredit.kcb4u.com:9088";//////////////////////////////////////////////////////////////////////////////////맞낭?;;
	String server_domain = "http://www.allcredit.co.kr";//////////////////////////////////////////////////////////////////////////////////맞낭?;;
	
	//** (테스트) 
	//String EndPointURL = "http://"+server_domain+"/KcbWebService/OkNameService";
	
	//** (운영시) 
	String EndPointURL  = "http://www.allcredit.co.kr/KcbWebService/OkNameService"; 

	String logpath = "./";
	String Options = "P";
	//String Options = "P";
	
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

	//for(int i=0; i<15; i++) {
		//writer.write (cmd[i]+" ");
	//}
	//writer.write("<br>");

/**************************************************************************
okname 실행
**************************************************************************/

    Process oProcess = null;
    BufferedReader stdOut = null;
    BufferedReader stdError = null;
    InputStream outstream = null;
    InputStream errorstream = null;
	
			
	String retcode = "";
	String retmsg = "";
	hs_cert_svc_tx_seqno = "";
	String e_ssn = "";
	String e_mbphn_no = "";
	String e_card_no = "";
	String e_email = "";	

	try {

		oProcess = oRuntime.exec(cmd);
		oProcess.waitFor();					// 프로세스 종료를 기다림.
     
        outstream = oProcess.getInputStream();
        errorstream = oProcess.getErrorStream();
        stdOut = new BufferedReader ( new InputStreamReader( outstream ) );
        stdError = new BufferedReader ( new InputStreamReader( errorstream ) );

    	// "표준 출력"과 "표준 에러 출력"을 출력. 
    	// **주의** 환경에따라 해당버퍼를 소진시키지 않는 경우 프로세스가 즉시 종료되지 않을 수 있다.

		String[] out1 = new String[7];
		String s="";
				
    	while ((s = stdError.readLine()) != null) writer.write(s);

		int ret_cnt=0;
		while ((s =stdOut.readLine()) != null)
		{
			out1[ret_cnt++] = s;
			//writer.write(s);
		}
        
    	int ret = oProcess.exitValue();
    	//writer.write("ret=" + ret + "<br>");
    
		/**************************************************************************
		okname 응답 정보
		**************************************************************************/

			
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
	

/**************************************************************************
hscert3.jsp 실행 정보(SOAP호출에서는 사용하지 않고 POPUP시에만 사용함)
**************************************************************************/

String rqst_site_nm = "현대아산";							// 사이트명 16byte (휴대폰인증번호 송신시 제휴사명에 노출)
//String target_id = "target_id";							// 타겟ID (팝업오픈 스크립트의 window.name 과 동일하게 설정
//String target_id = "http://www.hyundai-asan.com/popup/hscert1.jsp";							///////////////////////////////////////////////맞낭?;; 
//String target_id = "http://localhost:9080/newRecover.jsp";							///////////////////////////////////////////////맞낭?;; 
//String target_id = "http://erp.hdasan.com/services/newFPwd3.jsp";							///////////////////////////////////////////////맞낭?;; 
String target_id = "https://www.mtkumgang.com/popup/hscert2_f.jsp";							///////////////////////////////////////////////맞낭?;; 
//String return_url = "https://www.mtkumgang.com/popup/hscert3.jsp";	// ** 본인인증 완료후 리턴될 URL (도메인 포함 full path)
//String return_url = "http://10.61.108.46:9080/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** 본인인증 완료후 리턴될 URL (도메인 포함 full path)
String return_url = "http://erp.hdasan.com/services/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** 본인인증 완료후 리턴될 URL (도메인 포함 full path)
String hs_cert_rqst_caus_cd	= "03";			// 인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타)
%>
<html>
<head>
<title>KCB 본인인증</title>
<script>
	function openPop(){
		window.name = "<%=target_id%>";
		window.open("", "auth_popup", "width=432,height=560,scrollbar=yes");

		document.form1.action = "http://www.allcredit.co.kr/CommonSvl";
		
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
  <input type="hidden" name="tc" value="kcb.pis.front.gw.cmd.GW001AuthGWCmd">			  <%-- 변경불가--%>
  <input type="hidden" name="idcf_mbr_com_cd"			value="<%=idcf_mbr_com_cd%>">	  <%-- 고객사코드 --%>
  <input type="hidden" name="hs_cert_svc_tx_seqno"	value="<%=hs_cert_svc_tx_seqno%>">	  <%-- 거래번호 --%>
  <input type="hidden" name="ebz_svc_tp_cd"			value="<%=ebz_svc_tp_cd%>">			  <%-- 서비스구분코드 001:팝업형, 002:임베디드형 --%>
  <input type="hidden" name="hs_cert_msr_cd"			value="<%=hs_cert_msr_cd%>">	  <%-- 인증요청수단코드 --%>
  <input type="hidden" name="ssn"						value="<%=e_ssn%>">				  <%-- 주민번호 --%>
  <input type="hidden" name="hs_cert_rqst_caus_cd"	value="<%=hs_cert_rqst_caus_cd%>">	  <%-- 인증요청사유코드 --%>
  <input type="hidden" name="rqst_site_nm"			value="<%=rqst_site_nm%>">			  <%-- 사이트명 (휴대폰인증번호 송신시 제휴사명에 노출) --%>
  <input type="hidden" name="target_id"				value="<%=target_id%>">				  <%-- 타겟ID --%>
  <input type="hidden" name="return_url"				value="<%=return_url%>">		  <%-- 리턴URL --%>
  <!-- 필수 항목 //-->
  <!--// 선택 항목 -->
  <input type="hidden" name="email" value="">			  <%-- 이메일주소 (고객에게 본인인증 결과 메일을 송신할 경우) - 서비스 예정  --%>
  <input type="hidden" name="mbl_tel_cmm_cd" value="">	  <%-- 통신사 구분코드 (01:SKT, 02:KTF, 03:LGT) --%>
  <input type="hidden" name="mbphn_no" value="">		  <%-- 휴대폰번호--%>
  <input type="hidden" name="card_no" value="">			  <%-- 신용카드번호 --%>
  <input type="hidden" name="card_vld_term" value="">	  <%-- 신용카드유효기간 YY/MM --%>
  <input type="hidden" name="card_pwd" value="">		  <%-- 신용카드빌밀번호 앞2자리 --%>
  <!-- 선택 항목 //-->
</form>
<%
 	if (retcode.equals("B000")) {
		//팝업요청
		out.println ("<script>openPop();</script>");
	} else {
		//요청 실패 페이지로 리턴
		out.println ("<script>alert(\""+retcode+"\"); window.history.back();</script>");
	}
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">
  	<tr>
	  	<td><label ><h3>194_본인인증 진행 중!!!</h3></label></td>
  	</tr>
  	<tr>
	  	<td><font color="blue" onclick="openPop()" style="cursor:hand;">본인인증 창 띄우기</font></td>
  	</tr>

</table>
</body>
</html>

<%
// 경국 소스 원본 -----------------------------------------------------------------------------//

}//if(!result.equals(ssID))
%>