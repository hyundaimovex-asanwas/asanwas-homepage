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


// �汹 �ҽ� ���� -----------------------------------------------------------------------------//

	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	//writer.write(request.getParameter("ssn")+"<br>");
	//writer.write(request.getParameter("hs_cert_msr_cd")+"<br>");

/**************************************************************************
okname �Ķ����
**************************************************************************/
	String empid = request.getParameter("empid");						// *** ���̵� ***
	//String ssID = request.getParameter("ssID");						// *** ����id***
	String ssn = request.getParameter("ssn");						// *** �ֹι�ȣ ***
	//String hs_cert_msr_cd = request.getParameter("hs_cert_msr_cd");	// ������û�����ڵ�(00:��ü, 10:�޴���, 20:�ſ�ī��, 30:����������)
	String hs_cert_msr_cd = "00";	// ������û�����ڵ�(00:��ü, 10:�޴���, 20:�ſ�ī��, 30:����������)
	String filler1 = "000";					
	
	String idcf_mbr_com_cd = "P05170000000";					// *** ȸ�����ڵ� ***
	String client_ip = "203.242.32.194";										// ȸ���� IP, InetAddress.getLocalHost().getHostAddress() �� ���� �� ����.
	String client_domain = "www.hyundai-asan.com";						// *** ȸ���� ������.
	
	String ebz_svc_tp_cd = "001";								// ���񽺱����ڵ�(001:�˾���, 002:�Ӻ������)
//	String hs_cert_svc_tx_seqno = "291200020091";				// �ŷ��Ϸù�ȣ ( 20�ڸ��� ���ڿ�. 0-9,A-Z,a-z ���.)
	/**  �ŷ� �Ϸ� ��ȣ�� �Ʒ��� ���� �����ϴ� ���� ��õ. *********************************
	** ���� �����Ͽ� ����� ��� ���� �ŷ���ȣ�� �ι� ����� �� ���� �Ϳ� �����Ͽ� �ۼ�. **/
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	String hs_cert_svc_tx_seqno = df.format(cal.getTime()); 
	//**********************************************************************************/
	
	//okname�� ȣ���� �Ķ���� ����(���ο��� ��ȣȭ�Ͽ� ������. �˾�â�� �̸� �����ϴ� ��� ��ȣȭ�� ���� �˾����� ������ �� �ִ�.)
	String mbphn_no = "002";						// ���̵�� ��ü
	//String mbphn_no = "003";//���� ������� �����Ƿ� 3�ڸ� �̻��� ������ ä�� 
	String card_no = "004";//���� ������� �����Ƿ� 3�ڸ� �̻��� ������ ä�� 
	String email = "005";//���� ������� �����Ƿ� 3�ڸ� �̻��� ������ ä�� 

	//okname ���� ����
	//String exe = "d:\\okname\\src\\okname.exe";
	String exe = "/home/webadmin/okname/okname_v2.91/okname";//exe
	//String server_domain = "tallcredit.kcb4u.com:9088";//////////////////////////////////////////////////////////////////////////////////�³�?;;
	String server_domain = "http://www.allcredit.co.kr";//////////////////////////////////////////////////////////////////////////////////�³�?;;
	
	//** (�׽�Ʈ) 
	//String EndPointURL = "http://"+server_domain+"/KcbWebService/OkNameService";
	
	//** (���) 
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
okname ����
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
		oProcess.waitFor();					// ���μ��� ���Ḧ ��ٸ�.
     
        outstream = oProcess.getInputStream();
        errorstream = oProcess.getErrorStream();
        stdOut = new BufferedReader ( new InputStreamReader( outstream ) );
        stdError = new BufferedReader ( new InputStreamReader( errorstream ) );

    	// "ǥ�� ���"�� "ǥ�� ���� ���"�� ���. 
    	// **����** ȯ�濡���� �ش���۸� ������Ű�� �ʴ� ��� ���μ����� ��� ������� ���� �� �ִ�.

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
		okname ���� ����
		**************************************************************************/

			
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
	

/**************************************************************************
hscert3.jsp ���� ����(SOAPȣ�⿡���� ������� �ʰ� POPUP�ÿ��� �����)
**************************************************************************/

String rqst_site_nm = "����ƻ�";							// ����Ʈ�� 16byte (�޴���������ȣ �۽Ž� ���޻�� ����)
//String target_id = "target_id";							// Ÿ��ID (�˾����� ��ũ��Ʈ�� window.name �� �����ϰ� ����
//String target_id = "http://www.hyundai-asan.com/popup/hscert1.jsp";							///////////////////////////////////////////////�³�?;; 
//String target_id = "http://localhost:9080/newRecover.jsp";							///////////////////////////////////////////////�³�?;; 
//String target_id = "http://erp.hdasan.com/services/newFPwd3.jsp";							///////////////////////////////////////////////�³�?;; 
String target_id = "https://www.mtkumgang.com/popup/hscert2_f.jsp";							///////////////////////////////////////////////�³�?;; 
//String return_url = "https://www.mtkumgang.com/popup/hscert3.jsp";	// ** �������� �Ϸ��� ���ϵ� URL (������ ���� full path)
//String return_url = "http://10.61.108.46:9080/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** �������� �Ϸ��� ���ϵ� URL (������ ���� full path)
String return_url = "http://erp.hdasan.com/services/newFPwd3.jsp?SEmpId="+empid+"&ssID="+ssID;	// ** �������� �Ϸ��� ���ϵ� URL (������ ���� full path)
String hs_cert_rqst_caus_cd	= "03";			// ������û�����ڵ� 2byte  (00:ȸ������, 01:��������, 02:ȸ����������, 03:��й�ȣã��, 04:��ǰ����, 99:��Ÿ)
%>
<html>
<head>
<title>KCB ��������</title>
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
  <!-- POP-UP ��û �������� -->
  <!--// �ʼ� �׸� -->
  <input type="hidden" name="tc" value="kcb.pis.front.gw.cmd.GW001AuthGWCmd">			  <%-- ����Ұ�--%>
  <input type="hidden" name="idcf_mbr_com_cd"			value="<%=idcf_mbr_com_cd%>">	  <%-- �����ڵ� --%>
  <input type="hidden" name="hs_cert_svc_tx_seqno"	value="<%=hs_cert_svc_tx_seqno%>">	  <%-- �ŷ���ȣ --%>
  <input type="hidden" name="ebz_svc_tp_cd"			value="<%=ebz_svc_tp_cd%>">			  <%-- ���񽺱����ڵ� 001:�˾���, 002:�Ӻ������ --%>
  <input type="hidden" name="hs_cert_msr_cd"			value="<%=hs_cert_msr_cd%>">	  <%-- ������û�����ڵ� --%>
  <input type="hidden" name="ssn"						value="<%=e_ssn%>">				  <%-- �ֹι�ȣ --%>
  <input type="hidden" name="hs_cert_rqst_caus_cd"	value="<%=hs_cert_rqst_caus_cd%>">	  <%-- ������û�����ڵ� --%>
  <input type="hidden" name="rqst_site_nm"			value="<%=rqst_site_nm%>">			  <%-- ����Ʈ�� (�޴���������ȣ �۽Ž� ���޻�� ����) --%>
  <input type="hidden" name="target_id"				value="<%=target_id%>">				  <%-- Ÿ��ID --%>
  <input type="hidden" name="return_url"				value="<%=return_url%>">		  <%-- ����URL --%>
  <!-- �ʼ� �׸� //-->
  <!--// ���� �׸� -->
  <input type="hidden" name="email" value="">			  <%-- �̸����ּ� (������ �������� ��� ������ �۽��� ���) - ���� ����  --%>
  <input type="hidden" name="mbl_tel_cmm_cd" value="">	  <%-- ��Ż� �����ڵ� (01:SKT, 02:KTF, 03:LGT) --%>
  <input type="hidden" name="mbphn_no" value="">		  <%-- �޴�����ȣ--%>
  <input type="hidden" name="card_no" value="">			  <%-- �ſ�ī���ȣ --%>
  <input type="hidden" name="card_vld_term" value="">	  <%-- �ſ�ī����ȿ�Ⱓ YY/MM --%>
  <input type="hidden" name="card_pwd" value="">		  <%-- �ſ�ī����й�ȣ ��2�ڸ� --%>
  <!-- ���� �׸� //-->
</form>
<%
 	if (retcode.equals("B000")) {
		//�˾���û
		out.println ("<script>openPop();</script>");
	} else {
		//��û ���� �������� ����
		out.println ("<script>alert(\""+retcode+"\"); window.history.back();</script>");
	}
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%"align="left">
  	<tr>
	  	<td><label ><h3>194_�������� ���� ��!!!</h3></label></td>
  	</tr>
  	<tr>
	  	<td><font color="blue" onclick="openPop()" style="cursor:hand;">�������� â ����</font></td>
  	</tr>

</table>
</body>
</html>

<%
// �汹 �ҽ� ���� -----------------------------------------------------------------------------//

}//if(!result.equals(ssID))
%>