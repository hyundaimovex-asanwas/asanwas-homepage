<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
Writer writer = response.getWriter();
Runtime oRuntime = Runtime.getRuntime();

writer.write(request.getParameter("ssn")+"<br>");
writer.write(request.getParameter("hs_cert_msr_cd")+"<br>");

/**************************************************************************
okname �Ķ����
**************************************************************************/

String ssn = request.getParameter("ssn");//                �ֹι�ȣ
String hs_cert_msr_cd = request.getParameter("hs_cert_msr_cd");//  ������û�����ڵ�(00:��ü, 10:�޴���, 20:�ſ�ī��, 30:����������)
String filler1 = "0";// ""�� ä��� �ȵ� ������ ������ ä���

String idcf_mbr_com_cd = "0000000000";
String client_ip = "192.168.102.109";
String client_domain = "test.co.kr";

String ebz_svc_tp_cd = "001";//                        ���񽺱����ڵ�(001:�˾���, 002:�Ӻ������)
String hs_cert_svc_tx_seqno = "291200020091";//            �ŷ��Ϸù�ȣ

//okname�� ȣ���� �Ķ���� ����(���ο��� ��ȣȭ ��)
String mbphn_no = "mbphn_no";
String card_no = "card_no";
String email = "email";

//okname ���� ����
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
okname ����
**************************************************************************/

//cmd ����
Process oProcess = oRuntime.exec(cmd);
// �ܺ� ���α׷� ��� �б�
BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));

String[] out1 = new String[7];
String s="";
int ret_cnt=0;
while ((s =   stdOut.readLine()) != null)
{
	out1[ret_cnt++] = s;
}

// �ܺ� ���α׷� ��ȯ�� ��� (�� �κ��� �ʼ��� �ƴ�)
oProcess.waitFor();// ���μ����� ������ ���� ��ٸ�
int ret = oProcess.exitValue();

writer.write("ret="+ret+"<br>");

/**************************************************************************
okname ���� ����
**************************************************************************/

String retcode = "";
String retmsg = "";
hs_cert_svc_tx_seqno = "";
String e_ssn = "";
String e_mbphn_no = "";
String e_card_no = "";
String e_email = "";

if (ret == 0) {//������ ��� ������ ������� ����
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
hscert3.jsp ���� ����(SOAPȣ�⿡���� ������� �ʰ� POPUP�ÿ��� �����)
**************************************************************************/

String rqst_site_nm = "OKName";// ����Ʈ�� 16byte (�޴���������ȣ �۽Ž� ���޻�� ����)
String target_id = "";// Ÿ��ID (�˾����� ��ũ��Ʈ�� window.name �� �����ϰ� ����
String return_url = "http://localhost/hscert3.jsp";// �������� �Ϸ��� ���ϵ� URL (������ ���� full path)
String hs_cert_rqst_caus_cd	=	"00";// ������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ)
%>


<html>
	<head>
	<title>KCB �������� ����</title>
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
	<!-- POP-UP ��û �������� -->
	<!--// �ʼ� �׸� -->
	<input type="hidden" name="tc" value="kcb.pis.front.gw.cmd.GW001AuthGWCmd">				<!-- ����Ұ�-->
	<input type="hidden" name="idcf_mbr_com_cd"			value="<%=idcf_mbr_com_cd%>">		<!-- �����ڵ� -->
	<input type="hidden" name="hs_cert_svc_tx_seqno"	value="<%=hs_cert_svc_tx_seqno%>">	<!-- �ŷ���ȣ -->
	<input type="hidden" name="ebz_svc_tp_cd"			value="<%=ebz_svc_tp_cd%>">			<!-- ���񽺱����ڵ� 001:�˾���, 002:�Ӻ������ -->
	<input type="hidden" name="hs_cert_msr_cd"			value="<%=hs_cert_msr_cd%>">		<!-- ������û�����ڵ� -->
	<input type="hidden" name="ssn"						value="<%=e_ssn%>">					<!-- �ֹι�ȣ -->
	<input type="hidden" name="hs_cert_rqst_caus_cd"	value="<%=hs_cert_rqst_caus_cd%>">	<!-- ������û�����ڵ� -->

	<input type="hidden" name="rqst_site_nm"			value="<%=rqst_site_nm%>">			<!-- ����Ʈ�� (�޴���������ȣ �۽Ž� ���޻�� ����) -->
	<input type="hidden" name="target_id"				value="<%=target_id%>">				<!-- Ÿ��ID --> 
	<input type="hidden" name="return_url"				value="<%=return_url%>">			<!-- ����URL --> 
	<!-- �ʼ� �׸� //-->	

	<!--// ���� �׸� -->
	<input type="hidden" name="email" value="">				<!-- �̸����ּ� (������ �������� ��� ������ �۽��� ���) - ���� ����  -->
	<input type="hidden" name="mbl_tel_cmm_cd" value="">	<!-- ��Ż� �����ڵ� (01:SKT, 02:KTF, 03:LGT) -->
	<input type="hidden" name="mbphn_no" value="">			<!-- �޴�����ȣ-->
	<input type="hidden" name="card_no" value="">			<!-- �ſ�ī���ȣ -->
	<input type="hidden" name="card_vld_term" value="">		<!-- �ſ�ī����ȿ�Ⱓ YY/MM -->
	<input type="hidden" name="card_pwd" value="">			<!-- �ſ�ī����й�ȣ ��2�ڸ� -->
	<!-- ���� �׸� //-->

	</form>
 </body>

<%
 	if (retcode.equals("B000")) {
		//�˾���û
		writer.write ("<script>openPop(\""+server_domain+"\");</script>");
	} else {
		//��û ���� �������� ����
		writer.write ("<script>alert(\""+retcode+"\"); window.history.back();</script>");
	}
%>
</html>
