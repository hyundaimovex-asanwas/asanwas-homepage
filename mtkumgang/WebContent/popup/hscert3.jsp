<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
/****************************************************************
	본인인증 결과 화면
   (고객 인증정보 KCB팝업창에서 입력용)
*****************************************************************/

	/* 공통 리턴 항목 */
	String idcf_mbr_com_cd			= request.getParameter("idcf_mbr_com_cd");		// 고객사코드
	String hs_cert_svc_tx_seqno		= request.getParameter("hs_cert_svc_tx_seqno");	// 거래번호
	String ssn						= request.getParameter("ssn");					// 주민번호 (결과 미전송)
	String rqst_site_nm				= request.getParameter("rqst_site_nm");			// 접속도메인	
	String hs_cert_msr_cd			= request.getParameter("hs_cert_msr_cd");		// 인증요청수단코드(00:전체, 10:휴대폰, 20:신용카드, 30:공인인증서);
	String hs_cert_rqst_caus_cd	= request.getParameter("hs_cert_rqst_caus_cd");		//	인증요청사유코드 2byte  (00:회원가입, 01:성인인증, 02:회원정보수정, 03:비밀번호찾기, 04:상품구매, 99:기타);

	String rqst_ip					= request.getParameter("rqst_ip");		// 사용자접속IP
	String rst_cd					= request.getParameter("rst_cd");		// 결과코드
	String rst_msg					= request.getParameter("rst_msg");		// 결과메세지
	String cert_dt_tm				= request.getParameter("cert_dt_tm");	// 인증일시

	/* 임베디드 버젼 리턴 항목 */
	String mbl_tel_cmm_cd			= request.getParameter("mbl_tel_cmm_cd");	// 통신사 구분코드 (01:SKT, 02:KTF, 03:LGT);
	String mbphn_no					= request.getParameter("mbphn_no");			// 휴대폰번호 (결과 미전송)
	String re_snd_cnt				= request.getParameter("re_snd_cnt");		// 인증번호 재요청 건수
	String card_no					= request.getParameter("card_no");			// 카드번호   (결과 미전송)
	String card_vld_term			= request.getParameter("card_vld_term");	// 카드유효기간(YY/MM)
	String card_pwd					= request.getParameter("card_pwd");			// 카드비밀번호
	String card_com_nm				= request.getParameter("card_com_nm");		// 카드사명

	String orcs_iss_agnc_nm			= request.getParameter("orcs_iss_agnc_nm");	// 공인인증서발급기관명
	String orcs_iss_dt_tm			= request.getParameter("orcs_iss_dt_tm");	// 공인인증서발급일시
	String orcs_exprt_dt_tm			= request.getParameter("orcs_exprt_dt_tm");	// 공인인증서만료일시
%>
<html>
	<head>
	<title>KCB 본인인증 샘플</title>
	</head>
<body>
결과코드		: <%=rst_cd%><br>
거래번호		: <%=hs_cert_svc_tx_seqno%><br>
인증요청코드	: <%=hs_cert_msr_cd%><br>
요청사유		: <%=hs_cert_rqst_caus_cd%><br>
</body>
</html>
