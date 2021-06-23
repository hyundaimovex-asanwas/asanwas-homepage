<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>  
<%@ page import="java.io.*"%>
<%
	//���������κ��� �޴� parameter��  encPsnlInfo, WEBPUBKEY, WEBSIGNATURE���� ��ҹ��� �����Ͽ��� �Ѵ�.
    //�������˾����� ��ȸ�� PERSONALINFO�̴�.
	String encPsnlInfo = request.getParameter("encPsnlInfo");

	String cpCode    = "P05170000000";//�ߺ�����Ȯ������ ������ ���� ����Ʈ �ĺ���ȣ

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
	cmd[0] = "/home/webadmin/okname/okname_v2.91/";
	cmd[1] = "/home/webadmin/okname/okname_v2.91/okname.key";
	cmd[2] = cpCode;//memid
	//cmd[3] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
	cmd[3] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// � ����
	cmd[4] = WEBPUBKEY;       //server publickey
	cmd[5] = WEBSIGNATURE;    //server signature
	cmd[6] = encPsnlInfo;     //PERSONALINFO
	cmd[7] ="/home/webadmin/okname/okname_v2.91/";
	cmd[8] ="SL";

	String[] field = new String[13];
	try {
		Process oProcess = oRuntime.exec(cmd);
		// �ܺ� ���α׷� ��� �б�
		BufferedReader stdOut = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
		String s = "";
		
		int ret_cnt = 0;
		// ����� StdOut���� ù��° ������ PublicKey, �ι�°������ Signature��
		while ((s = stdOut.readLine()) != null){
			if(ret_cnt < 13){
				field[ret_cnt] = s;
			}
			ret_cnt++;
		}
	}
	catch(Exception e) {
		writer.write(e.toString() + "<br>");
	}
%>

<html>
<head>
<script language="JavaScript">

function fncOpenerSubmit() {

	opener.document.kcbOutForm.encPsnlInfo.value 		= document.dForm.encPsnlInfo.value;
	opener.document.kcbOutForm.dupinfo.value 			= document.dForm.dupinfo.value;
	opener.document.kcbOutForm.coinfo1.value            = document.dForm.coinfo1.value;
	opener.document.kcbOutForm.coinfo2.value            = document.dForm.coinfo2.value;
	opener.document.kcbOutForm.ciupdate.value           = document.dForm.ciupdate.value;
	opener.document.kcbOutForm.virtualno.value 			= document.dForm.virtualno.value;
	opener.document.kcbOutForm.cpcode.value             = document.dForm.cpcode.value;
	opener.document.kcbOutForm.realname.value 			= document.dForm.realname.value;
	opener.document.kcbOutForm.cprequestnumber.value 	= document.dForm.cprequestnumber.value;
	opener.document.kcbOutForm.age.value 				= document.dForm.age.value;
	opener.document.kcbOutForm.sex.value 				= document.dForm.sex.value;
	opener.document.kcbOutForm.nationalinfo.value 		= document.dForm.nationalinfo.value;
	opener.document.kcbOutForm.birthdate.value 			= document.dForm.birthdate.value;
	opener.document.kcbOutForm.authinfo.value           = document.dForm.authinfo.value;
	opener.document.kcbOutForm.action = "join_register2.jsp";
	opener.document.kcbOutForm.submit();
	self.close();
}

</script>
</head>
<body onload="javascript:fncOpenerSubmit();">
<form name="dForm" method="post">
	<input type="hidden" name="encPsnlInfo" 	value ="<%=encPsnlInfo %>" />
	<input type="hidden" name="dupinfo" 		value="<%=field[0] %>" />
	<input type="hidden" name="coinfo1" 		value="<%=field[1] %>" />
	<input type="hidden" name="coinfo2" 		value="<%=field[2] %>" />
	<input type="hidden" name="ciupdate" 		value="<%=field[3] %>" />
	<input type="hidden" name="virtualno"  		value="<%=field[4] %>" />
	<input type="hidden" name="cpcode"          value="<%=field[5] %>" />
	<input type="hidden" name="realname" 		value="<%=field[6] %>" />
	<input type="hidden" name="cprequestnumber" value="<%=field[7] %>" />
	<input type="hidden" name="age" 			value="<%=field[8] %>" />
	<input type="hidden" name="sex" 			value="<%=field[9] %>" />
	<input type="hidden" name="nationalinfo" 	value="<%=field[10]%>" />
	<input type="hidden" name="birthdate" 		value="<%=field[11]%>" />
	<input type="hidden" name="authinfo"        value="1" />
</form>
</body>
</html>