<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>

<%@ page import="com.hdasan.util.EmpIdInfo" %>
<%
//���� üũ ///////////////////////////////////////////////////////////////////////
String ssID 			= request.getParameter("ssID");
EmpIdInfo EI = new EmpIdInfo();
String result = EI.FPwd(request, response); //�α� ó��
//���� üũ ///////////////////////////////////////////////////////////////////////
if(!result.equals(ssID)){	//���н�

	return;
}else{//üũ ����!

    //**************************************************************************
	// ���ϸ� : safe_hs_cert2.jsp
	//
	// ������� ���� Ȯ�μ��� ���� ���� �Է� ȭ��
	//    (�� �������� KCB�˾�â���� �Է¿�)
    //
    // ������
    // 	���� ��ÿ��� 
    // 	response.write�� ����Ͽ� ȭ�鿡 �������� �����͸� 
    // 	�����Ͽ� �ֽñ� �ٶ��ϴ�. �湮�ڿ��� ����Ʈ�����Ͱ� ����� �� �ֽ��ϴ�.
    //**************************************************************************

	
	/**************************************************************************
	 * okname ������� ���� Ȯ�μ��� �Ķ����
	 **************************************************************************/
    String empid = request.getParameter("empid");						// *** ���̵� ***
	String ssn = request.getParameter("ssn");						// *** �ֹι�ȣ ***
	String inTpBit 		= "0";											// �Է±����ڵ� (������ '0' - KCB�˾����� �������� �Է�)
	String name 		= "x";											// ���� (������ 'x' - KCB�˾����� �������� �Է�)
	String birthday 	= "x";											// ������� (������ 'x' - KCB�˾����� �������� �Է�)
	String gender 		= "x";											// ���� (������ 'x' - KCB�˾����� �������� �Է�)
	String ntvFrnrTpCd 	= "x";											// ���ܱ��α��� (������ 'x' - KCB�˾����� �������� �Է�)
	String mblTelCmmCd 	= "x";											// �̵���Ż��ڵ� (������ 'x' - KCB�˾����� �������� �Է�)
	String mbphnNo 		= "x";											// �޴�����ȣ (������ 'x' - KCB�˾����� �������� �Է�)
	
	// ########################################################################
	// # ���ȯ�� Ȯ�� �ʿ�
	// ########################################################################
	String memId = "P05170000000";										// ȸ�����ڵ�
	String clientIp = "203.242.32.194";												// ȸ���� IP, InetAddress.getLocalHost().getHostAddress() �� ���� �� ����.
	String clientDomain = "www.mtkumgang.com";									// ȸ���� ������. (�޴���������ȣ �۽Ž� ���޻�� ����)
	
	// �ŷ��Ϸù�ȣ ( 20�ڸ��� ���ڿ�. 0-9,A-Z,a-z ���.)
	/**  �ŷ� �Ϸ� ��ȣ�� �Ʒ��� ���� �����ϴ� ���� ��õ. *********************************
	** ���� �����Ͽ� ����� ��� ���� �ŷ���ȣ�� �ι� ����� �� ���� �Ϳ� �����Ͽ� �ۼ�. **/
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String svcTxSeqno = df.format(cal.getTime()); 
	//**********************************************************************************/
	
	// ���� �׸�
	String rsv1 = "0";
	String rsv2 = "0";
	String rsv3 = "0";
	
	String hsCertMsrCd	=	"10";										// ���������ڵ� 2byte  (10:�ڵ���)
	String hsCertRqstCausCd	=	"00";									// ������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ)
	
	//okname�� ȣ���� �Ķ���� ����(���ο��� ��ȣȭ�Ͽ� ������. �˾�â�� �̸� �����ϴ� ��� ��ȣȭ�� ���� �˾����� ������ �� �ִ�.)
	String returnMsg = "x";
	
	// ########################################################################
	// # ���� URL ����
	// ########################################################################
	String returnUrl = "http://erp.hdasan.com/services/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** �������� �Ϸ��� ���ϵ� URL (������ ���� full path);
	
	//okname ���� ����
	// ########################################################################
	// # ��� ��� ���� �� ���� �ο� (������)
	// ########################################################################
	String exe = "/home/webadmin/linux32_nonstatic_glibc2.3.4/okname";

	// ########################################################################
	// # ���ȯ�� ���� �ʿ�
	// ########################################################################
	//String endPointURL = "http://tsafe.ok-name.co.kr:29080/KcbWebService/OkNameService";	// �׽�Ʈ ����
     String endPointURL = "http://safe.ok-name.co.kr/KcbWebService/OkNameService";		// � ����
	
	// ########################################################################
	// # �α� ��� ���� �� ���� �ο� (������)
	// # �ɼǰ��� 'L'�� �߰��ϴ� ��쿡�� �αװ� ������.
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
	okname ����
	**************************************************************************/
	
	//cmd ����
	Runtime oRuntime = Runtime.getRuntime();
	Process oProcess = oRuntime.exec(cmd);
	// �ܺ� ���α׷� ��� �б�
	BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
	
	String[] out1 = new String[20];
	String s="";
	int ret_cnt=0;
	while ((s =   stdOut.readLine()) != null) {
//		out.println(s+"<br/>");
		out1[ret_cnt++] = s;
	}
	
	// �ܺ� ���α׷� ��ȯ�� ��� 
	oProcess.waitFor();// ���μ����� ������ ���� ��ٸ�
	int ret = oProcess.exitValue();
	
//	out.println("ret="+ret+"<br>");
	
	/**************************************************************************
	okname ���� ����
	**************************************************************************/
	
	String retcode = "";
	String retmsg = "";
	String e_rqstData = "";
	
	if (ret == 0) {//������ ��� ������ ������� ����
		retcode = out1[0];
		retmsg  = out1[1];
		e_rqstData = out1[2];
	}
	else {
		retcode = out1[0];
		retmsg  = out1[1];
	}
	
	
	/**************************************************************************
	safe_hs_cert3.jsp ���� ����(SOAPȣ�⿡���� ������� �ʰ� POPUP�ÿ��� �����)
	**************************************************************************/
	
	String targetId = "";// Ÿ��ID (�˾����� ��ũ��Ʈ�� window.name �� �����ϰ� ����
	 
	// ########################################################################
	// # ���ȯ�� ���� �ʿ�
	// ########################################################################
    //String commonSvlUrl = "https://tsafe.ok-name.co.kr:2443/CommonSvl";	// �׽�Ʈ URL
     String commonSvlUrl = "https://safe.ok-name.co.kr/CommonSvl";	// � URL
%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "No-cache");

	//String ssID		= request.getParameter("ssID");
	//if(ssID==null) ssID="";
%>

<html>
	<title>KCB ������� ���� Ȯ�μ���</title>
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
	<!-- ���� ��û ���� -->
	<!--// �ʼ� �׸� -->
	<input type="hidden" name="tc" value="kcb.oknm.online.safehscert.popup.cmd.P901_CertChoiceCmd">				<!-- ����Ұ�-->
	<input type="hidden" name="rqst_data"		value="<%=e_rqstData%>">		<!-- ��û������ -->
	<input type="hidden" name="target_id"		value="<%=targetId%>">			<!-- Ÿ��ID --> 
	<!-- �ʼ� �׸� //-->	
	</form>
 </body>
<%
 	if ("B000".equals(retcode)) {
		//������û
		out.println("<script>request();</script>");
	} else {
		//��û ���� �������� ����
		out.println("<script>alert(\""+retcode+"\"); self.close(); </script>");
	}
%>
</html>
<%
}//if(!result.equals(ssID))
%>
