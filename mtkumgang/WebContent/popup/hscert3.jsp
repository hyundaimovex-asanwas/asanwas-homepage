<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
/****************************************************************
	�������� ��� ȭ��
   (�� �������� KCB�˾�â���� �Է¿�)
*****************************************************************/

	/* ���� ���� �׸� */
	String idcf_mbr_com_cd			= request.getParameter("idcf_mbr_com_cd");		// �����ڵ�
	String hs_cert_svc_tx_seqno		= request.getParameter("hs_cert_svc_tx_seqno");	// �ŷ���ȣ
	String ssn						= request.getParameter("ssn");					// �ֹι�ȣ (��� ������)
	String rqst_site_nm				= request.getParameter("rqst_site_nm");			// ���ӵ�����	
	String hs_cert_msr_cd			= request.getParameter("hs_cert_msr_cd");		// ������û�����ڵ�(00:��ü, 10:�޴���, 20:�ſ�ī��, 30:����������);
	String hs_cert_rqst_caus_cd	= request.getParameter("hs_cert_rqst_caus_cd");		//	������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ);

	String rqst_ip					= request.getParameter("rqst_ip");		// ���������IP
	String rst_cd					= request.getParameter("rst_cd");		// ����ڵ�
	String rst_msg					= request.getParameter("rst_msg");		// ����޼���
	String cert_dt_tm				= request.getParameter("cert_dt_tm");	// �����Ͻ�

	/* �Ӻ���� ���� ���� �׸� */
	String mbl_tel_cmm_cd			= request.getParameter("mbl_tel_cmm_cd");	// ��Ż� �����ڵ� (01:SKT, 02:KTF, 03:LGT);
	String mbphn_no					= request.getParameter("mbphn_no");			// �޴�����ȣ (��� ������)
	String re_snd_cnt				= request.getParameter("re_snd_cnt");		// ������ȣ ���û �Ǽ�
	String card_no					= request.getParameter("card_no");			// ī���ȣ   (��� ������)
	String card_vld_term			= request.getParameter("card_vld_term");	// ī����ȿ�Ⱓ(YY/MM)
	String card_pwd					= request.getParameter("card_pwd");			// ī���й�ȣ
	String card_com_nm				= request.getParameter("card_com_nm");		// ī����

	String orcs_iss_agnc_nm			= request.getParameter("orcs_iss_agnc_nm");	// �����������߱ޱ����
	String orcs_iss_dt_tm			= request.getParameter("orcs_iss_dt_tm");	// �����������߱��Ͻ�
	String orcs_exprt_dt_tm			= request.getParameter("orcs_exprt_dt_tm");	// ���������������Ͻ�
%>
<html>
	<head>
	<title>KCB �������� ����</title>
	</head>
<body>
����ڵ�		: <%=rst_cd%><br>
�ŷ���ȣ		: <%=hs_cert_svc_tx_seqno%><br>
������û�ڵ�	: <%=hs_cert_msr_cd%><br>
��û����		: <%=hs_cert_rqst_caus_cd%><br>
</body>
</html>
