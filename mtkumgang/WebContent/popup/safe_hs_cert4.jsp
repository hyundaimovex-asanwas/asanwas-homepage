<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
	//	������� ���� Ȯ�μ��� ��� ȭ��
	/* ���� ���� �׸� */
	String idcfMbrComCd		= request.getParameter("idcf_mbr_com_cd");		// �����ڵ�
	String hsCertSvcTxSeqno	= request.getParameter("hs_cert_svc_tx_seqno");	// �ŷ���ȣ
	String hsCertRqstCausCd	= request.getParameter("hs_cert_rqst_caus_cd");	// ������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ);// 

	String resultCd			= request.getParameter("result_cd");				// ����ڵ�
	String resultMsg		= new String(request.getParameter("result_msg").getBytes("8859_1"), "EUC-KR");	// ����޼���
	String certDtTm			= request.getParameter("cert_dt_tm");				// �����Ͻ�
	String di				= request.getParameter("di");						// DI
	String ci				= request.getParameter("ci");						// CI
	String name				= new String(request.getParameter("name").getBytes("8859_1"), "EUC-KR");		// ����
	String birthday			= request.getParameter("birthday");					// �������
	String gender			= request.getParameter("gender");					//����
	String nation			= request.getParameter("nation");					//���ܱ��α���
	String telComCd			= request.getParameter("tel_com_cd");				//��Ż��ڵ�
	String telNo			= request.getParameter("tel_no");					//�޴�����ȣ
	String returnMsg		= request.getParameter("return_msg");				//���ϸ޽���
%>
<html>
<head>
<title>KCB ������� ���� Ȯ�μ��� ����</title>
</head>
<body>
<h3>�������</h3>
<ul>
  <li>�����ڵ�	: <%=idcfMbrComCd%> </li>
  <li>���������ڵ�	: <%=hsCertRqstCausCd%></li>
  <li>����ڵ�		: <%=resultCd%></li>
  <li>����޼���	: <%=resultMsg%></li>
  <li>�ŷ���ȣ		: <%=hsCertSvcTxSeqno%> </li>
  <li>�����Ͻ�		: <%=certDtTm%> </li>
  <li>DI			: <%=di%> </li>
  <li>CI			: <%=ci%> </li>
  <li>����			: <%=name%> </li>
  <li>�������		: <%=birthday%> </li>
  <li>����			: <%=gender%> </li>
  <li>���ܱ��α���	: <%=nation%> </li>
  <li>��Ż��ڵ�	: <%=telComCd%> </li>
  <li>�޴�����ȣ	: <%=telNo%> </li>
  <li>���ϸ޽���	: <%=returnMsg%> </li>
</ul>
</body>
</html>
