<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
	//	생년월일 본인 확인서비스 결과 화면
	/* 공통 리턴 항목 */
	String idcfMbrComCd		= request.getParameter("idcf_mbr_com_cd");		// 고객사코드
	String hsCertSvcTxSeqno	= request.getParameter("hs_cert_svc_tx_seqno");	// 거래번호
	String hsCertRqstCausCd	= request.getParameter("hs_cert_rqst_caus_cd");	// 인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타);// 

	String resultCd			= request.getParameter("result_cd");				// 결과코드
	String resultMsg		= new String(request.getParameter("result_msg").getBytes("8859_1"), "EUC-KR");	// 결과메세지
	String certDtTm			= request.getParameter("cert_dt_tm");				// 인증일시
	String di				= request.getParameter("di");						// DI
	String ci				= request.getParameter("ci");						// CI
	String name				= new String(request.getParameter("name").getBytes("8859_1"), "EUC-KR");		// 성명
	String birthday			= request.getParameter("birthday");					// 생년월일
	String gender			= request.getParameter("gender");					//성별
	String nation			= request.getParameter("nation");					//내외국인구분
	String telComCd			= request.getParameter("tel_com_cd");				//통신사코드
	String telNo			= request.getParameter("tel_no");					//휴대폰번호
	String returnMsg		= request.getParameter("return_msg");				//리턴메시지
%>
<html>
<head>
<title>KCB 생년월일 본인 확인서비스 샘플</title>
</head>
<body>
<h3>인증결과</h3>
<ul>
  <li>고객사코드	: <%=idcfMbrComCd%> </li>
  <li>인증사유코드	: <%=hsCertRqstCausCd%></li>
  <li>결과코드		: <%=resultCd%></li>
  <li>결과메세지	: <%=resultMsg%></li>
  <li>거래번호		: <%=hsCertSvcTxSeqno%> </li>
  <li>인증일시		: <%=certDtTm%> </li>
  <li>DI			: <%=di%> </li>
  <li>CI			: <%=ci%> </li>
  <li>성명			: <%=name%> </li>
  <li>생년월일		: <%=birthday%> </li>
  <li>성별			: <%=gender%> </li>
  <li>내외국인구분	: <%=nation%> </li>
  <li>통신사코드	: <%=telComCd%> </li>
  <li>휴대폰번호	: <%=telNo%> </li>
  <li>리턴메시지	: <%=returnMsg%> </li>
</ul>
</body>
</html>
