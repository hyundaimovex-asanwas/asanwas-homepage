<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>  
<%@ page import="java.io.*"%>
<%	
	String idpUrl = "";

    //������Ʈ�� PERSONALINFO�� RECEIVE�ϴ� ������
	String returnUrl = "";

	//KCB �׽�Ʈ������ ȣ���� ���
	//idpUrl    = "https://tipin.ok-name.co.kr:8443/tis/ti/POTI90B_SendCertInfo.jsp";
	//returnUrl = "http://localhost/ipin2.jsp";

	//KCB ������� ȣ���� ���
	idpUrl    = "https://ipin.ok-name.co.kr/tis/ti/POTI90B_SendCertInfo.jsp";
	returnUrl = "http://www.mtkumgang.com/member/member_action.jsp";


	String idpCode   = "V";//������Ʈ ��ȣ����Ȯ�α��(KCB���)�ڵ�
	String cpCode    = "P05170000000";//�ߺ�����Ȯ������ ������ ���� ����Ʈ �ĺ���ȣ

	//������ ������ ����� ���� Ű���� ����
	Writer writer    = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();
	
	/*
	String[] cmd = new String[4];
	cmd[0] = "/home/jeus/okname/src/okname";
	cmd[1] = "/home/jeus/okname/src/okname.key";
	cmd[2] = "/home/jeus/okname/src/";
	cmd[3] = "KL";
	*/
	String[] cmd = new String[8];
	cmd[0] = "d:\\okname\\bin\\win32\\exe\\okname.exe";//exe
	cmd[1] = "d:\\okname\\src\\okname.key";//keypath

	cmd[2] = cpCode;//memid
	cmd[3] = "0";//reserved1
	cmd[4] = "0";//reserved2
	//cmd[5] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
	cmd[5] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// � ����
	
	cmd[6] = "/home/webadmin/okname/okname_v2.91/";// logpath
	cmd[7] = "CL";// Option

for(int i=0; i<8; i++) {
	out.write(cmd[i]);
	out.write(" ");
	
}
	String s = "", pubkey = "", sig = "", curtime = "";
	
	try {
		Process oProcess = oRuntime.exec(cmd);
		// �ܺ� ���α׷� ��� �б�
		BufferedReader stdOut = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
		
		int ret_cnt=0;

		while ((s = stdOut.readLine()) != null){
			if(ret_cnt == 0)
				pubkey = s;    //client publickey
			if(ret_cnt == 1)
				sig = s;       //client signature
			if(ret_cnt == 2)
				curtime = s;   //cprequestnum
			ret_cnt++;
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
%>

<html>
<head>
<script language="JavaScript">
//<!--
function certKCBIpin(){
	var popupWindow = window.open( "", "kcbPop", "left=200, top=100, status=0, width=450, height=550" );
	document.kcbInForm.target = "kcbPop";
	//KCB �׽�Ʈ������ ȣ���� ���
    //document.kcbInForm.action = "https://tipin.ok-name.co.kr:8443/tis/ti/POTI01A_LoginRP.jsp";

    //KCB ������� ȣ���� ���
	document.kcbInForm.action = "https://ipin.ok-name.co.kr/tis/ti/POTI01A_LoginRP.jsp";

	document.kcbInForm.submit();
	popupWindow.focus();	
	return;	
}
//-->
</script>

<%--
**************************************************************************************
* �ڹٽ�ũ��Ʈ ��
**************************************************************************************
--%>
</head>
<body>
	<input type="button" value="������" onclick="certKCBIpin()"/>
	<form name="kcbInForm" method="post" >
		<input type="hidden" name="IDPCODE" value="<%=idpCode%>" />
		<input type="hidden" name="IDPURL" value="<%=idpUrl %>" />
		<input type="hidden" name="CPCODE" value="<%=cpCode%>" />	
		<input type="hidden" name="CPREQUESTNUM" value="<%=curtime%>" />
		<input type="hidden" name="RETURNURL" value="<%=returnUrl %>" />
		<input type="hidden" name="WEBPUBKEY" value="<%=pubkey%>" />
		<input type="hidden" name="WEBSIGNATURE" value="<%=sig%>" />
	</form>	
	<form name="kcbOutForm" method="post">
		<input type="hidden" name="encPsnlInfo" />
		<input type="hidden" name="virtualno" />
		<input type="hidden" name="dupinfo" />
		<input type="hidden" name="realname" />
		<input type="hidden" name="cprequestnumber" />
		<input type="hidden" name="age" />
		<input type="hidden" name="sex" />
		<input type="hidden" name="nationalinfo" />
		<input type="hidden" name="birthdate" />
		<input type="hidden" name="coinfo1" />
		<input type="hidden" name="coinfo2" />
		<input type="hidden" name="ciupdate" />
		<input type="hidden" name="cpcode" />
		<input type="hidden" name="authinfo" />
	</form>
</body>
</html>