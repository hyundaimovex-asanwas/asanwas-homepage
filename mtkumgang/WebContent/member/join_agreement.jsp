<%--
  - �ۼ���: ������ 
  - �ۼ� ����: 2006.06.01
  - ���� ������ : ������
  - ���� ������ : 2006.06.14
  - ���۱� ǥ��: IMJ Korea
  - ����: �Ǹ�Ȯ�������� , ������ �Ǹ��� Ȯ������ �ʰ� , �����ڿ� �ֹι�ȣ�� �̸��� ������
			�ߺ����� Ȯ�� ���θ��� ó���Ѵ�. ���� �Ǹ�Ȯ�� �ý��� ������ �� �������� �̿��ϸ�
			�ȴ�.
--%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr"> 
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import= "com.hmm.asan.common.util.Utility"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ include file="/common/properties.jsp" %>
<%@ include file="/common/session.jsp" %>
<%@ include file="/common/header.jsp" %>
<%
	//���ǰ� �̷�� ������ Ȯ�� �ʿ�. step1
	//String sRefUrl = "";
	//if ( request.getHeader("Referer") != null ) sRefUrl = request.getHeader("Referer");
	//if ( sRefUrl.indexOf("join_agreement.jsp") == -1 ) response.sendRedirect("/member/join_agreement.jsp");

%>
<%	
	//�����ɼ���_20110525_�ڰ汹
	String idpUrl = "";

    //������Ʈ�� PERSONALINFO�� RECEIVE�ϴ� ������
	String returnUrl = "";

	//KCB �׽�Ʈ������ ȣ���� ���
	//idpUrl    = "https://tipin.ok-name.co.kr:8443/tis/ti/POTI90B_SendCertInfo.jsp";
	//returnUrl = "http://localhost/ipin2.jsp";

	//KCB ������� ȣ���� ���
	idpUrl    = "https://ipin.ok-name.co.kr/tis/ti/POTI90B_SendCertInfo.jsp";
	returnUrl = "http://www.mtkumgang.com/member/ipin2.jsp?";


	String idpCode   = "V";//������Ʈ ��ȣ����Ȯ�α��(KCB���)�ڵ�
	String cpCode    = "P05170000000";//�ߺ�����Ȯ������ ������ ���� ����Ʈ �ĺ���ȣ

	//������ ������ ����� ���� Ű���� ���� &�Ǹ����� 
	//HTML �������� write�� Writer ��ü ����, �ܺ� ���α׷� ������ ���� Runtime ��ü ����
	Writer writer    = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();

	//�Ǹ�����
	//��¥ ������ ���� Calendar�� SimpleDateFormat ��ü ����
	//���� �ڵ� ������ ���� DecimalFormat ��ü ����
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");
	
	String name=(String)request.getParameter("name");//�̸�
	String ssn=(String)request.getParameter("regno1")+(String)request.getParameter("regno2");//�ֹι�ȣ
	String memid = "P05170000000";// ȸ���� ���̵�                                        
	String qryBrcCd = "x";                                                                
	String qryBrcNm = "x";                                                                
	String qryId = "u1234";// ����ID, ����� ������                                       
	String qryKndCd = "1";// ��û����  ���� : 1, �ܱ��� : 2                               
	String qryRsnCd = "01";// ��ȸ����  ȸ������ : 01, ȸ���������� : 02, ȸ��Żȸ : 03, ?
	String qryIP = "203.242.32.194";// ȸ���� IP                                          
	String qryDomain = "http://www.mtkumgang.com/";// ȸ���� ������                       
	String qryDt = df.format(cal.getTime());//date(Ymd);//<- ���� �ð� �Լ��� �����ϼ���. 
	String EndPointURL  = "http://www.allcredit.co.kr/KcbWebService/OkNameService"; 


	//JSP�� ����� �н��� �����н��� �����ؾ���
	//String exe = "/usr/local/tomcat/webapps/ROOT/okname";
	//String exe = "d:\\oknameweb\\okname.exe";
	String exe = "/home/webadmin/okname/okname_v2.91/okname";

	// ������ ���� ȸ��� x
	//String qryBrcCd = "x";
	//String qryBrcNm = "x";
	// ���� �׸��� ȸ���� ���� 
	//String qryId = "u1234";// ����ID, ����� ������ 
	// ���� ��¥ 
	//String qryDt = df.format(cal.getTime());//date(Ymd);//<- ���� �ð� �Լ��� �����ϼ���.

	/*
	String[] cmd = new String[4];
	cmd[0] = "/home/jeus/okname/src/okname";
	cmd[1] = "/home/jeus/okname/src/okname.key";
	cmd[2] = "/home/jeus/okname/src/";
	cmd[3] = "KL";
	*/
	String[] cmd = new String[8]; //������ 
//	cmd[0] = "d:\\okname\\bin\\win32\\exe\\okname.exe";//exe
//	cmd[1] = "d:\\okname\\src\\okname.key";//keypath

	cmd[0] = "/home/webadmin/okname/okname_v2.91/okname";//exe
	cmd[1] = "/home/webadmin/okname/okname_v2.91/okname.key";//keypath

	cmd[2] = cpCode;//memid
	cmd[3] = "0";//reserved1
	cmd[4] = "0";//reserved2
	//cmd[5] = "http://tallcredit.kcb4u.com:9088/KcbWebService/OkNameService";//EndPointURL
	cmd[5] = "http://www.allcredit.co.kr/KcbWebService/OkNameService";// � ����
	
	cmd[6] = "/home/webadmin/okname/okname_v2.91/";// logpath
	cmd[7] = "CL";// Option

//for(int i=0; i<8; i++) {
//	out.write(cmd[i]);
//	out.write(" ");
//}
	//������
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
<%
	 //20110614..���ο� �Ǹ����� ���� ��... �Ǹ����� ������ �ϱ� ���� ���� �ִ� �κ�..
     //String name   = new String();
     String regno1 = new String();
     String regno2 = new String();
     //String returnUrl = new String();
     
     String resultName = new String();
     String resultJumin = new String();
     String resultJumin1 = new String();
     String resultJumin2 = new String();
     String resultCode = new String();
     
     name   = ParamUtil.getReqParameter(request.getParameter("name"),"");
     regno1 = ParamUtil.getReqParameter(request.getParameter("regno1"),"");
     regno2 = ParamUtil.getReqParameter(request.getParameter("regno2"),"");
     resultCode = ParamUtil.getReqParameter(request.getParameter("resultCode"),"");
     resultName = ParamUtil.getReqParameter(request.getParameter("resultName"),"");
     resultJumin = ParamUtil.getReqParameter(request.getParameter("resultJumin"),"");
     if (!resultJumin.equals("")){
        resultJumin1 = resultJumin.toString().substring(0,6);
        resultJumin2 = resultJumin.toString().substring(6,13);
     }
     //returnUrl = "test1.hdasan.com/member/join_agreement.jsp";
     
     //�Ǹ� ���� ������ ���� �Ѵ�.
     //�Ǹ� ���� ������ ���� return �� �޴´�.
     if (name != "" && regno1 != "" && regno2 != ""){
          //response.sendRedirect //("http://www.mtkumgang.com/webCom/cNameCheckWEB.asp?revJumin1="+regno1.trim()+"&revJumin2="+regno2.trim()+"&revName="+name.trim()+"&returnUrl="+r//eturnUrl.trim());
          //http://www.mtkumgang.com/webCom/cNameCheckWEB.asp?revJumin1=751217&revJumin2=2036619&revName=�̼ҿ�&returnUrl=test1.hdasan.com/member/join_agreement.jsp
     }else{
     
     }
    
%>
<%
  String McNum= "0";
  String sub= "0";
%>

<script language="JavaScript" src="<%=imageServer%>/tour_common/checkform.js"></script>
<script language="JavaScript">
//<!-- �����ɼ���
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
<script language="javascript">
<!--

	function checkForm()
	{
		var form = document.form;
		
		if (!form.agrck[0].checked == true){
		    alert("����� ������ �ֽʽÿ�.");
		    return;
		}

		if (!form.privacy_chk[0].checked == true){
		    alert("����������޹�ħ�� ������ �ֽʽÿ�.");
		    return;
		}
		
	    if(form.name.value == ""){
		   alert("�̸��� �Է��� �ֽʽÿ�");
		   form.name.focus();
		   return;
	    }
	    s_str = form.name.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("���鸸 �Է��ϸ� �ȵ˴ϴ�. �̸��� �Է��� �ֽʽÿ�.");
		  form.name.focus();
		   return;
	    }
        
	    if(form.regno1.value == ""){
		   alert("�ֹι�ȣ�� �Է��� �ֽʽÿ�");
		   form.regno1.focus();
		   return;
	    }
	    s_str = form.regno1.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("���鸸 �Է��ϸ� �ȵ˴ϴ�. �ֹι�ȣ�� �Է��� �ֽʽÿ�.");
		  form.regno1.focus();
		   return;
	    }	 
	    if(form.regno2.value == ""){
		   alert("�ֹι�ȣ�� �Է��� �ֽʽÿ�");
		   form.regno2.focus(); 
		   return;
	    }   	    
	    s_str = form.regno2.value;
	    if ( s_str.match(/\S/)==null ) {
		  alert("���鸸 �Է��ϸ� �ȵ˴ϴ�. �ֹι�ȣ�� �Է��� �ֽʽÿ�.");
		  form.regno2.focus();
		   return;
	    }  
    
		var ssn = form.regno1.value + form.regno2.value;
		if (!Jumin_Num_Check(ssn) ) 
		{
			alert("��ȿ���� ���� �ֹε�Ϲ�ȣ�Դϴ�.");
			form.regno1.focus();
			return;
		}
			//form.action="join_agreement.jsp";
			form.action="member_action.jsp";
			form.submit();	
	}
//-->

</script>
<html>
<head>
<title> �ݰ������      </title>
<link rel="STYLESHEET" type="text/css" href="<%=imageServer%>/tour_common/common.css">
<script language="JavaScript" src="<%=imageServer%>/tour_common/flash.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/menulink.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/quickmenu2.js"></script>
<script language="JavaScript" src="<%=imageServer%>/tour_common/select_footer.js"></script>
</head>

<body>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr valign="top">
	<td valign="top">
		<!-------- / top area -------->
        <%@ include file="../include/member/tour_member_top.jsp" %>
		<!-------- top area / -------->

		<!-------- / center area -------->
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr valign="top">
			<td width="174"><!--  left menu --><img src="<%=imageServer%>/tour_img/leftMenu07.gif" width="174"></td>
			<td>
				<!-- / content  -->
				<table width="710" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td class="lpad_20">
					<!--/ TITLE & LINEMAP -->
					<table width="690" cellpadding="0" cellspacing="0">
					<tr>
						<td height="54"><img src="<%=imageServer%>/tour_img/mem/tit_mem01.gif"></td>
						<td align="right" class="linemap"><img src="<%=imageServer%>/tour_img/bu/bu_linemap.gif" class="linemap_margin"><a href="#" class="linemap">HOME</a><img src="<%=imageServer%>/tour_img/bu/bu_linemap2.gif" class="linemap_margin2"><span class="linemap_now">ȸ������</span></td>
					</tr>
					</table>
					<!-- TITLE & LINEMAP/ -->
					</td>
				</tr>
				<tr><td height="1" class="line_g"></td></tr>
				</table>

<form name="form" method="post" >
 		<input type = hidden name=cmd value="C">
 		<input type = hidden name=mtype value="">
		
				
				<table width="690" cellpadding="0" cellspacing="0" border="0" class="lpad_20">
				<tr><td height="11"></td></tr>
				<tr><td><img src="<%=imageServer%>/tour_img/mem/img_top_mem01.jpg"></td></tr>
				<tr>
					<td valign="top">
						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem11.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:7 2 7 7px;">
								<div style="width:678px;height:214px;overflow:auto;" class="div06">
<strong>��1�� ��Ģ </strong><br><br>

��1��(����)<br>
 �� ����� ����ƻ�(��)�� �����ϴ� mt.KumGang����(���� ���񽺶� �մϴ�.)�� �̿����� �� ������ ���� ���װ� ��Ÿ �ʿ��� ������ �������� �������� �մϴ�.<br><br>

�� 2 �� (�̿����� ȿ�� �� ����)<br>
 �� �� ����� ���� �޴� �� ȸ�翡 �Խ��Ͽ� ���������ν� ȿ���� �߻��մϴ�.<br>
 �� ȸ��� �ո����� ������ �߻��� ��쿡�� �� ����� ������ �� ������, ����� ����� ��쿡�� ��ü ���� �̸� �����մϴ�.<br>
 �� ȸ�������� �̿���� ����� ��� ���׿� �������� ������ ���� �̿��� �ߴ��ϰ� �̿����� ������ �� �ֽ��ϴ�. ����� ȿ�¹߻��� ������ ������� ���� �̿��� ����� ������׿� ���� �� ������ �����մϴ�.<br><br>

�� 3 �� (����� ����)<br>
 �� �� ����� ��õ��� �ƴ��� ���׿� ���ؼ��� ������� �� ���񽺺� �ȳ��� ������ ���� ������ �� �ֽ��ϴ�.<br><br>
	
�� 4 �� (����� ����)<br>
 �� �� ������� ����ϴ� ����� ���Ǵ� ������ �����ϴ�.<br>
   1. ȸ��� ���� ����ƻ�(��)�� ���մϴ�.<br>
   2. ���񽺶� ���� ����ƻ�(��)���� �����ϴ� ���� ���񽺸� ���մϴ�.<br>
   3. �̿�� �̶� ���� ȸ�������񽺸� �̿��ϴ� �̿��ڸ� ���մϴ�.<br>
   4. �̿��� �̶� ���� ���� �̿�� �����Ͽ� ȸ��� �̿������ ü���ϴ� ����� ���մϴ�.<br>
   5. �̿��ڹ�ȣ(ID)�� ���� �̿���� �ĺ��� �̿���� ���� �̿��� ���Ͽ� �̿���� �����ϰ� ȸ�簡 �ο��ϴ� ���ڿ� ������ ������ ���մϴ�.<br>
   6. ��й�ȣ�� ���� �̿���� �ο����� �̿��ڹ�ȣ�� ��ġ�� �̿������ Ȯ���ϰ� �̿���� ���ͺ�ȣ�� ���Ͽ� �̿���� ������ ���ڿ� ������ ������ ���մϴ�.<br>
   7. �ܸ���� ���� ȸ�簡 �����ϴ� ���񽺸� �̿��ϱ� ���� �̿���� ��ġ�� ���ο� ��ǻ�� �� �� ���� ���մϴ�.<br><br>


<strong>�� 2 �� ����� ȿ��</strong><br><br>
�� 5 �� (������ ����)<br>
 �� ������ ������ ���� ���� ȸ���� ���񽺺� �ȳ����� ������ ���ϴ� �ٿ� ���մϴ�.<br><br>
	
�� 6 �� (�̿����� ���� �� ü�����)<br>
 �� �̿����� �̿���� �̿��û�� ���Ͽ� ȸ���� �̿�³����� �����մϴ�.<br><br>
	
�� 7 �� (�̿� ��û �� ����� ����)<br>
 �� ȸ��� ����ƻ�(��) ����� �����Ͻ� �̿��ڿ��� ��κ��� ���񽺸� �����մϴ�.<br>
   �̿��ڰ� ��������� ���� ���� ��ư�� �������ν� �� ���� ����� ������ ������ �����մϴ�.<br><br>


<strong>�� 3 ��  �̿����� �ǹ�</strong><br><br>
�� 8 �� (������ ���� �� ����)<br>
 �� ȸ��� ���� �� ȣ�� �ش��ϴ� ���� �̿��û�� ���Ͽ��� �³��� ���� ���� �� �ֽ��ϴ�.<br>
   1.	Ÿ�� ���Ƿ� ��û�� ���<br>
   2. ȸ������ ��������� ������ ������ �������� �������� ���<br>
   3. ��Ÿ �̿��û���� ��å������ �̿�³��� ����� ���<br>
 �� ȸ��� ���� �̿��û�� ���� �� ȣ�� �ش��ϴ� ��쿡�� �� ��û�� ���� �³� ���ѻ����� �ؼҵ� �������� �³��� ���� ���� �� �ֽ��ϴ�.<br>
   1. ȸ�簡 ������ ������ ���� ���<br>
   2. ȸ���� ����� ������ �ִ� ���<br>
   3. ��Ÿ ȸ���� ��å������ �̿�³��� ����� ���<br>
 �� ȸ��� �� 2 ���� ������ ���Ͽ� �̿��û�� �ҽ³� �ǰų� �³��� �����ϴ� �� �쿡�� �̸� �̿��û������ ��� �˷��� �մϴ�.<br>
 �� ȸ��� �̿��û���� �̼������� ��쿡�� ���񽺺� �ȳ����� ���ϴ� �ٿ� ���� �³��� ������ �� �ֽ��ϴ�.<br><br>

�� 9 �� (�̿��� ID �ο� �� ����)<br>
 �� ȸ��� ȸ�������� �̿���� ���Ͽ� ���񽺺� ����� ���ϴ� �ٿ� ���� �̿��� ID�� �ο��մϴ�.<br>
 �� �̿��� ID�� ���� �� ȣ�� �ش��ϴ� ��쿡�� �̿�� �Ǵ� ȸ���� ��û�� ���Ͽ� ���� �� �� �ֽ��ϴ�.<br>
   1. �̿��� ID�� �̿����� ��ȭ��ȣ �Ǵ� �ֹε�Ϲ�ȣ ������ ��ϵǾ� ���Ȱ ħ�ذ� ����� �ִ� ���<br>
   2. Ÿ�ο��� �������� �ְų� ��ǳ��ӿ� ��߳��� ���<br>
   3. ��Ÿ �ո����� ������ �ִ� ���<br>
 �� �̿���� �̿���ID�� �� 3 �ڿ��� ����ϰ� �� �� ������, �̿���ID �� ��й�ȣ ������ ���Ǹ� ���Ͽ��� �մϴ�.<br>
 �� ��Ÿ �̿���ID�� ���� �� ���� � ���� ������ ���񽺺� �ȳ��� ���ϴ� �ٿ� ���մϴ�.<br><br>


<strong>�� 4 �� ������ ���� �� ����</strong><br><br>
�� 10 �� (õ������)<br>
 �� ȸ��� ����, �纯, õ������ �Ǵ� �̿� ���ϴ� ���������°� �߻��ϰų� �߻��� ����� �ִ� ���� ������Ż���� ���� �Ⱓ��Ż���ڰ� ������ż��񽺸� �����ϴ� ���Ÿ �ε����� ������ �ִ� ��쿡�� ������ ���� �Ǵ� �Ϻθ� �����ϰų� ������ �� �ֽ��ϴ�.<br>
 �� ȸ��� �� 1 ���� ������ ���Ͽ� ������ �̿��� �����ϰų� ������ ������ �� ���� �� ���� �Ⱓ ���� ��ü ���� �̿������ �˷��� �մϴ�.<br><br>

�� 11 �� (���� ����)<br>
 �� ȸ��� �̿���� ���� �̿볻���� ���� �� ȣ�� �ش��ϴ� ��쿡�� �Խù��� �����ϰų� ������ ���� �Ǵ� �Ϻ��� �̿��� �����ϰų� ������ �� �ֽ��ϴ�.<br>
   1. �̿���� �ǹ��� �������� �ƴ��� ���<br>
   2. ������ �������� ��� �����ϴ� ���<br>
   3. �������� �ǻ翡 ���ϴ� ����, ����, �������� �����̳� ���� ����, ���ڿ��� ���� ���������� �����ϴ� ���<br>
   4.	������� ������ �� �����̳� ���� ���� �ı��� ���߽�Ű�� ��ǻ�� ���̷��� ���α׷��� �����ϴ� ���<br>
   5.	Ÿ���� ���������� ħ���ϴ� ������ �Խ�, ���� , ���ڸ��� �Ǵ� ��Ÿ�� ������� �����ϴ� ���<br>
   6. ���������������ȸ�� �����䱸�� �ְų� �ҹ����ſ�� �����Ͽ� ���Ű�������ȸ�� �����ؼ��� ���� ���<br>
   7. Ÿ���� ���̵�(ID)�� ��й�ȣ(PESSWORD)�� ����ϴ� ���<br>
   8. ���� ������ �̿��Ͽ� ���� ������ ȸ���� ���� �³� ���� ���� �Ǵ� �����Ű�ų� ��������� �̿��ϴ� ���<br>
   9. ������� ���ù��� � ����Ǵ� ���<br>
   10. �ٸ� ������� ���������� ���� �Ǵ� �����ϴ� ���<br>
   11. ����� ������ ���� �ʰ� ���� , ���˹�, ��ũ����, ����, ����� ���� �� ��Ÿ �ٸ� ������ ������ �Խ�, ����, ���ڸ��� �Ǵ� ��Ÿ ������� �����ϴ� ���<br>
   12. �� 3 ���� �Ǹ��� ħ���ϰų� Ÿ���� ����ϴ� ��� <br><br>

�� 12 �� (���� �̿� ���� �� ����)<br>
 �� ȸ��� �� 11 ���� ������ ���Ͽ� ���� �̿� ������ ���� �ϰ��� �ϴ� ���<br>
   �� ������ �Ͻ� ���� �̿������ �����մϴ�.<br>
   �ٸ�, ȸ�簡 ����ϰ� �̿��� ������ �ʿ䰡 �ִٰ� �����ϴ� ��쿡�� �׷����� �ƴ��մϴ�.
 �� �� 1 ���� ������ ���Ͽ� �̿������� ���� ���� �̿���� �� �̿������� ������ ���� ���ǰ� ���� ������ ���ǽ�û�� �� �� �ֽ��ϴ�.<br>
 �� ȸ��� �� 2 ���� ������ ���� ���ǽ�û�� ���Ͽ� �� Ȯ���� ���� �Ⱓ���� �̿������� �Ͻ� ������ �� ������, �� ����� �̿������ �����մϴ�.<br>
 �� ȸ��� �̿������Ⱓ �߿� �� �̿����������� �ؼҵ� ���� Ȯ�ε� ��쿡�� �̿����� ��ġ�� ��� �����մϴ�.<br><br>

�� 13 �� (ȸ������ ��� ������ ����)<br>
 �̿���� �ּ� �� ȸ������ ��� ������ �����ϰ��� �ϴ� ��쿡�� ���񽺺� �ȳ��� ���ϴ� �ٿ� ���Ͽ� �̿��� ���� ��û���� ���� �Ǵ� ��ȭ���� �̿��Ͽ� ������ �� �ֽ��ϴ�.<br><br>

�� 14 �� (�̿�����)<br>
 �� �� ����� ��õ��� ���� ������ �̿����ῡ ���� ������ ������� �� ���񽺺� �ȳ����� ���ϴ� �ٿ� ���մϴ�.<br><br>

�� 15 �� (�̿����� ����������ȣ)<br>
   ȸ��� ���� ������ ���ϴ� �ٿ� ���� �̿����� ��������� ������ �̿����� ���������� ��ȣ�ϱ� ���Ͽ� ����մϴ�.<br>
   �̿����� ����������ȣ�� ���ؼ��� ���� ���� �� ȸ�簡 ���ϴ� "����ƻ�(��) �������� ��ȣ��å"���� ���� �ٿ� ���մϴ�.<br><br>

�� 16 �� (��å)<br>
 �� ȸ��� �̿���� ȸ���� ���� �������κ��� ���Ǵ� ������ ���� ���Ͽ��ų� ���� �ڷῡ ���� ��缱�� �Ǵ� �̿����� �߻��ϴ� ���� � ���ؼ��� å���� �����˴ϴ�.<br>
 �� ȸ��� �̿���� ��å������ ���Ͽ� ���� �̿��� ��ְ� �߻��� ��쿡�� å���� �����˴ϴ�.<br>
 �� ȸ��� �̿��ڰ� �Խ� �Ǵ� ������ �ڷ��� ���뿡 ���ؼ��� å���� �����˴ϴ�.<br>
 �� ȸ��� �̿��� ��ȣ�� �Ǵ� �̿��ڿ� �� 3 �� ��ȣ���� ���񽺸� �Ű��� �Ͽ� ��ǰ�ŷ� ���� �� ��쿡�� å���� �����˴ϴ�.<br>
 �� ȸ��� ��� ������ �ڷ� ���� �� ���ۿ� ���� å���� ������ �ڷ��� �ս��� �ִ� ��쿡�� å���� �����˴ϴ�.<br>
 �� �� ���� ������ ���� ���λ����� �� ���񽺺� �̿��Ģ�� ���� ����ƻ�(��)�� å���� �����˴ϴ�.<br>
 �� ��8�� ���׿� �ǰ� Ÿ���� �ֹε�Ϲ�ȣ�� �̸��� �������� ���, �� å���� �̿��ڿ��� ������ ȸ��� å���� �����˴ϴ�.<br><br>


�� Ģ (������) �� ����� 2003�� 04�� 01�Ϻ��� �����մϴ�.
</div>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr>
						 <td height="40" align=center>
							<input type="radio" name="agrck" value="Y" class="noborder"><img src="<%=imageServer%>/tour_img/mem/txt_mem15.gif">
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="agrck" value="N" class="noborder">
							<img src="<%=imageServer%>/tour_img/mem/txt_mem16.gif">
                         </td>
						</tr>
						<tr><td height="40"></td></tr>
						</table>


						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top">��<font color="white">�������� ���� �� �̿뿡 ���� �ȳ�</font></td>
							<td class="bg_dblue" align=right><a href="/include/privacy.jsp"><font color="yellow"><b>����������޹�ħ �ٷΰ���</b></font></a>��</td>
						</tr>
						<tr>
							<td style="padding:7 2 7 7px;" colspan=2>
<textarea id='xmlarea' name='xmlarea' rows='8' style='width : 100%;font-size : 12px;'>
�� ���������� ���� �� �̿����

ȸ��� ������ ���������� ������ ������ ���� Ȱ���մϴ�..

 �� ���� ������ ���� ��� ���� �� ���� ������ ���� �������
���� �� ��� ����
 �� ȸ�� ����
ȸ���� ���� �̿뿡 ���� ����Ȯ�� , ���� �ĺ� , �ҷ�ȸ���� ���� �̿� ������ ���ΰ� ��� ���� , �Ҹ�ó�� �� �ο�ó�� , �������� ����
 �� ������ �� ���� Ȱ��
�̺�Ʈ �� ���� ���� ���� , �α�������� Ư���� ���� ���� ���� �� ���� ���� , ���� �� �ľ� �Ǵ� ȸ���� ���� �̿뿡 ���� ���
 �� ��Ÿ
�������� ��������������



�� �����ϴ� �������� �׸�

ȸ��� ȸ������, ���, ���� ��û ����� ���� �Ʒ��� ���� ���������� �����ϰ� �ֽ��ϴ�.

�� �����׸� : �̸� , ������� , ���� , �α���ID , ��й�ȣ , ���� �ּ� , �޴���ȭ��ȣ , �̸��� , ȸ��� , ��å , �ֹε�Ϲ�ȣ , �ſ�ī�� ���� , ��Ű , ���� IP ���� , �������
�� �������� ������� : Ȩ������(ȸ������, �Խ���, ��������) , ��ȭ/�ѽ��� ���� ȸ������ , ��ǰ ��� ���� 


�� ���������� ���� �� �̿�Ⱓ

ȸ��� �������� ���� �� �̿������ �޼��� �Ŀ��� ���� ���� �ش� ������ ��ü ���� �ı��մϴ�.
</textarea>
							</td>
						</tr>
						<tr><td height="1" class="line_dg" colspan=2></td></tr>
						<tr>
						 <td height="40" colspan=2 align=center>
							<input type="radio" name="privacy_chk" value="Y" class="noborder">����
							&nbsp;&nbsp;&nbsp;
							<input type="radio" name="privacy_chk" value="N" class="noborder">�������� �ʽ��ϴ�.
                         </td>
						</tr>
						<tr><td height="40" colspan=2></td></tr>
						</table>

						<table width="690" cellpadding="0" cellspacing="0" border="0">
						<tr><td height="19" class="bg_dblue" valign="top"><img src="<%=imageServer%>/tour_img/mem/txt_mem12.gif" style="margin:4 0 0 12px;"></td></tr>
						<tr>
							<td style="padding:27 0 32 0px;" align="center">
								<table width="350" cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td width="75"><img src="<%=imageServer%>/tour_img/mem/txt_mem13.gif"></td>
									<td width="275"><input type="text" name="name" value="<%=resultName%>" style="width:275px;" onkeypress="if (13 == event.keyCode) checkForm();" tabindex=1 ></td>
								</tr>
								<tr><td height="9" colspan="2"></td></tr>
								<tr>
									<td><img src="<%=imageServer%>/tour_img/mem/txt_mem14.gif"></td>
									<td class="txt_gray">
									<input type="text" name="regno1" maxlength="6" value="<%=resultJumin1%>" style="width:130px;" onkeyup=movenext(this.form.regno1,this.form.regno2,6)   tabindex=2> - 
									<input type="password" name="regno2" maxlength="7" value="<%=resultJumin2%>" style="width:131px;" onkeypress="if (13 == event.keyCode) checkForm();" tabindex=3>
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr><td height="1" class="line_dg"></td></tr>
						<tr><td height="40"></td></tr>
						<tr><td align="center">
						<!--<a href="javascript:checkForm();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_confirm.gif" class="btn" alt="aaaaaaa"></a>-->
<a href="javascript:goWarning();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_confirm.gif" class="btn" alt="aaaaaaa"></a>						
						<a href="javascript:document.all.reset();"><img src="<%=imageServer%>/tour_img/btn/btn_mem_cancel.gif" class="btn"></a></td></tr>
					</table>
</form>

					<!-- //������-->
					<table border="0" cellpadding="0" cellspacing="0" width="624" height="30"><tr><td></td></tr></table>
					<table cellpadding="0" cellspacing="0" width="624">
						<tr>
							<td width="9" valign="top"><img src="<%=imageServer%>/tour_img/mem/bl03.gif"></td>
							<td class="ti_b">�ֹε�Ϲ�ȣ �Ǹ�Ȯ�� ��� ������ ������ ���� ������ ���Ͻø� <br>
							�Ʒ� '������ ����'��ư�� ���� ȸ�������� ������ �ּ���. </td>
						</tr>
						<tr>
							<td colspan="2" height="8"></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" width="624">
						<tr>
							<td width="9" valign="top"><img src="<%=imageServer%>/tour_img/mem/bl03.gif"></td>
							<td class="ti_b">������(I-PIN)�� ���ΰ� �ְ��ϴ� �ֹι�ȣ ��ü�����Դϴ�.<BR>
							<B>�����ɼ��񽺴� ���ͳ� �󿡼� ������ �ĺ��� �� �ִ� ������ID�� ��й�ȣ�� �ο�</B>�Ͽ�<BR>
							���ͳ� ����Ʈ ȸ������ �Ǵ� �������� ��, �ֹε�Ϲ�ȣ�� ��� ���� �������� �ĺ��� �� <BR>
							�ֵ��� �����ϴ� �����Դϴ�.
							</td>
						</tr>
						<tr>
							<td colspan="2" height="8"></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" width="624">
						<tr>
							<td colspan="2" height="8"></td>
						</tr>
						<td width="200"></td>
						<td>
				<!--	<input type="button" value="������" align="right" style="font-family:����; font-weight:bold; color:white; background-color:limegreen;"        onclick="certKCBIpin()"/> -->
					<input type="button" value="������" align="right" style="font-family:����; font-weight:bold; color:white; background-color:limegreen;"        onclick="goWarning()"/> 

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
						</td>
						<tr>
							<td colspan="2" height="8"></td>
						</tr>
					</table>
					
					<!-- //������-->
	

<%
     if (!resultCode.equals("") && !resultCode.equals("1")){
           out.println("<script language='javascript'>alert('�Ǹ� ������ ���� �Ͽ����ϴ�.');document.location='join_agreement.jsp';</script>");
     }else if(!resultCode.equals("") && resultCode.equals("1")){
           out.println("<script language='javascript'> document.form.action='member_action.jsp'; document.form.submit(); </script>");
     }else{
           
     }
%>
					</td>
				</tr>
				</table>
				<!--  content / -->
			</td>
		</tr>
		</table>
		<!--------  center area /-------->
	</td>
</tr>
<tr>
	<td valign="bottom">
		<!--/ footer -->           
        <%@ include file="../include/footer.jsp" %>
		<!-- footer /-->
	</td>
</tr>
</table>

<script language="javascript">
function goWarning(){
	
		alert("�ý��� �������� ȸ�������� �� �����ϴ�");
		return ;
	

}
</script>


</body>
</html>