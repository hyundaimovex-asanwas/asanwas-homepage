<%
/*
	�������� ��� ȭ��
   (�� �������� KCB�˾�â���� �Է¿�)
*/
	/* ���� ���� �׸� */
	String idcf_mbr_com_cd			=	request.getParameter("idcf_mbr_com_cd");//		�����ڵ�
	String hs_cert_svc_tx_seqno		=	request.getParameter("hs_cert_svc_tx_seqno");//	�ŷ���ȣ
	String rst_cd					=	request.getParameter("rst_cd");//				����ڵ�
	String rst_msg					=	request.getParameter("rst_msg");//				����޼���
			rst_msg = 	java.net.URLDecoder.decode(rst_msg);
	String cert_dt_tm				=	request.getParameter("cert_dt_tm");//			�����Ͻ�

	//���������κ��� �޴� parameter��  encPsnlInfo, WEBPUBKEY, WEBSIGNATURE���� ��ҹ��� �����Ͽ��� �Ѵ�.
    //�������˾����� ��ȸ�� PERSONALINFO�̴�.
	String encInfo = request.getParameter("encInfo");
	String cpCode    = idcf_mbr_com_cd;				//�ߺ�����Ȯ������ ������ ���� ����Ʈ �ĺ���ȣ (ȸ�����ڵ带 ���)

	//������ ������ ����� ���� Ű���� ����
	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	//KCB���� ����Ű
	String WEBPUBKEY = request.getParameter("WEBPUBKEY") == null || "".equals(request.getParameter("WEBPUBKEY").trim()) ? "" : request.getParameter("WEBPUBKEY").trim();
	//KCB���� ����
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
		cmd[3] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// � ����
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

	ArrayList outData = new ArrayList(0); 		//�������
		
	try {

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
			// writer.write(s);	
		}
    	while ((s = stdError.readLine()) != null){
			//	writer.write(s);
		}
    
		int ret = oProcess.exitValue();
	
		// �ܺ� ���α׷� ��ȯ�� ��� (�� �κ��� �ʼ��� �ƴ�)
//		writer.write("ret=" + ret + "<br>");
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
%>
<html>
<head>
<title>KCB �������� ����</title>
</head>
<body>
<h3>�������</h3>
<h4> �� </h4>
<ul>
  <li>����ڵ�		: <%=rst_cd%></li>
  <li>����޼���	: <%=rst_msg%></li>
  <li>�ŷ���ȣ		: <%=hs_cert_svc_tx_seqno%> </li>
  <li>������û�ڵ�	: <%=hs_cert_msr_cd%></li>
</ul>
</body>
</html>
