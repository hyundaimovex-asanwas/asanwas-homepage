<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%
/**************************************************************************
	���ϸ� : safe_hs_cert3.jsp
	
	������� ���� Ȯ�μ��� ��� ȭ��(return url)
**************************************************************************/
	/* apass_action ���� �� */
	//String cmd="C";//ȸ������ üũ

	/* ���� ���� �׸� */
	String idcfMbrComCd		=	request.getParameter("idcf_mbr_com_cd");		// �����ڵ�
	String hsCertSvcTxSeqno	=	request.getParameter("hs_cert_svc_tx_seqno");	// �ŷ���ȣ
	String rqstSiteNm		=	request.getParameter("rqst_site_nm");						// ���ӵ�����	
	String hsCertRqstCausCd	=	request.getParameter("hs_cert_rqst_caus_cd");	// ������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ);// 

	String resultCd			=	request.getParameter("result_cd");				// ����ڵ�
	String resultMsg		=	java.net.URLDecoder.decode(request.getParameter("result_msg"));	// ����޼���
	String certDtTm			=	request.getParameter("cert_dt_tm");				// �����Ͻ�

	/**************************************************************************
	 * ��� ȣ��	; ������� ���� Ȯ�μ��� ��� �����͸� ��ȣȭ�Ѵ�.
	 **************************************************************************/
	String encInfo = request.getParameter("encInfo");

	//KCB���� ����Ű�� ����
	String WEBPUBKEY = request.getParameter("WEBPUBKEY") == null || "".equals(request.getParameter("WEBPUBKEY").trim()) ? "" : request.getParameter("WEBPUBKEY").trim();
	String WEBSIGNATURE = request.getParameter("WEBSIGNATURE") == null || "".equals(request.getParameter("WEBSIGNATURE").trim()) ? "" : request.getParameter("WEBSIGNATURE").trim();

    // ��� �Ķ���� ����.

	String[] cmd = new String[9];
	//okname ���� ����
	// ########################################################################
	// # ��� ��� ���� �� ���� �ο� (������)
	// ########################################################################
	cmd[0] = "/home/webadmin/linux32_nonstatic_glibc2.3.4/okname";

	// ########################################################################
	// # ��ȣȭŰ ���� ���� (������) - ������ �־��� ���ϸ����� �ڵ� ���� ��
	// ########################################################################
	cmd[1] = "/home/webadmin/linux32_nonstatic_glibc2.3.4/safecert_"+idcfMbrComCd+".key";				// IPIN���� ������ Ű���ϸ�� �ٸ� �̸����� �����ؾ���.

	cmd[2] = idcfMbrComCd;            // ȸ�����ڵ�

	// ########################################################################
	// # ���ȯ�� ���� �ʿ�
	// ########################################################################
	//cmd[3] = "http://tsafe.ok-name.co.kr:29080/KcbWebService/OkNameService";	//�׽�Ʈ EndPointURL
     cmd[3] = "http://safe.ok-name.co.kr/KcbWebService/OkNameService";		// � EndPointURL

	cmd[4] = WEBPUBKEY;       //server publickey
	cmd[5] = WEBSIGNATURE;    //server signature
	cmd[6] = encInfo;     //PERSONALINFO

	// ########################################################################
	// # �α� ��� ���� �� ���� �ο� (������)
	// # �ɼǰ��� 'L'�� �߰��ϴ� ��쿡�� �αװ� ������.
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

	ArrayList outData = new ArrayList(0); 		//�������
		
	try {
        oRuntime = Runtime.getRuntime();
		oProcess = oRuntime.exec(cmd);
		oProcess.waitFor();					// ���μ��� ���Ḧ ��ٸ�.
     
        outstream = oProcess.getInputStream();
        errorstream = oProcess.getErrorStream();
        stdOut = new BufferedReader ( new InputStreamReader( outstream ) );
        stdError = new BufferedReader ( new InputStreamReader( errorstream ) );

    	String s;
		int cnt = 0;
    	// "ǥ�� ���"�� "ǥ�� ���� ���"�� ���. 
    	// **����** ȯ�濡���� �ش���۸� ������Ű�� �ʴ� ��� ���μ����� ��� ������� ���� �� �ִ�.
    	while ((s = stdOut.readLine()) != null){	
			field[cnt++]=s;	
			out.println(cnt+":"+s+"<br/>");	
		}
		cnt = 0;
    	while ((s = stdError.readLine()) != null){
			out.println(cnt+":"+s+"<br/>");	
		}
    
		int ret = oProcess.exitValue();
	
		// �ܺ� ���α׷� ��ȯ�� ��� (�� �κ��� �ʼ��� �ƴ�)

        if( ret == 0 ){
			out.println("��ȣȭ ��û ȣ�� ����.<br/>");		 
            resultCd = field[0];                    
            hsCertSvcTxSeqno = field[2];
        }
        else {
			out.println("��ȣȭ ��û ȣ�� ����. ���ϰ� : " + ret + "<br/>");		 
		}
	}
    catch(Exception e) {
        e.printStackTrace();

    //finally���� ��������� close ����
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
	// ��ȣȭ�� ����Ȯ�� ��� ������
	//**************************************************************************
    out.println("ó������ڵ�	:" + field[0]	+ "<br/>");		 
    out.println("ó������޽���	:" + field[1]	+ "<br/>");		 
    out.println("�ŷ��Ϸù�ȣ	:" + field[2]	+ "<br/>");		 
    out.println("�����Ͻ�		:" + field[3]	+ "<br/>");		 
    out.println("DI				:" + field[4]	+ "<br/>");		 
    out.println("CI				:" + field[5]	+ "<br/>");		 
    out.println("����			:" + field[7]	+ "<br/>");		 
    out.println("�������		:" + field[8]	+ "<br/>");		 
    out.println("����			:" + field[9]	+ "<br/>");		 
    out.println("���ܱ��α���	:" + field[10]	+ "<br/>");	 
    out.println("��Ż��ڵ�		:" + field[11]	+ "<br/>");	 
    out.println("�޴�����ȣ		:" + field[12]	+ "<br/>");	 
    out.println("���ϸ޽���		:" + field[16]	+ "<br/>");	 

// ������ ���� ���� */
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
	<title>KCB ������� ���� Ȯ�μ��� ����</title>
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
	<b>�����������</b>
 	����ڵ�		: <%=resultCd%><br />
 	����޼���		: <%=resultMsg%><br />
	�ŷ���ȣ		: <%=hsCertSvcTxSeqno%><br />
 	�����Ͻ�		: <%=certDtTm%><br />
	�����ڵ�		: <%=idcfMbrComCd%><br />
	���ӵ�����		: <%=rqstSiteNm%><br />
	������û�����ڵ�: <%=hsCertRqstCausCd%><br />
	
</body>
</html>

