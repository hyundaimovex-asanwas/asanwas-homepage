<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
KCB �Ǹ�Ȯ�� OKname JSP Version Sample Page<br>
<%
	Writer writer = response.getWriter();
	Runtime oRuntime = Runtime.getRuntime();

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");

	// �Ķ������ ���ڵ� ����
	request.setCharacterEncoding("euc-kr");

	String name=(String)request.getParameter("name");//�̸�
	String ssn=(String)request.getParameter("ssn");//�ֹι�ȣ
	String memid=(String)request.getParameter("memid");//ȸ����ID
	String qryIP=(String)request.getParameter("qryIP");//ȸ����IP
	String qryDomain=(String)request.getParameter("qryDomain");//ȸ����DOMAIN
	String qryKndCd=(String)request.getParameter("qryKndCd");//��ȸ����(1: ������, 2: �ܱ���)
	String qryRsnCd=(String)request.getParameter("qryRsnCd");//��ȸ����(ȸ������ : 01, ȸ���������� : 02, ȸ��Żȸ : 03, �������� : 04, ��Ÿ : 05)
	String EndPointURL=(String)request.getParameter("EndPointURL");//EndPointURL(�׽�Ʈ, ��� ������)

	//JSP�� ����� �н��� �����н��� �����ؾ���
	//String exe = "/usr/local/tomcat/webapps/ROOT/okname";
	String exe = "d:\\oknameweb\\okname.exe";

	// ������ ���� ȸ��� x
	String qryBrcCd = "x";
	String qryBrcNm = "x";
	// ���� �׸��� ȸ���� ���� 
	String qryId = "u1234";// ����ID, ����� ������ 
	// ���� ��¥ 
	String qryDt = df.format(cal.getTime());//date(Ymd);//<- ���� �ð� �Լ��� �����ϼ���.

	if (name == null || ssn == null || name.length() == 0 || ssn.length() == 0) {
%>
		<form method="post" action="okname2.jsp">
		<table>
		<tr>
		<td>�̸�</td><td><input type="text" name="name"></td>
		</tr>
		<tr>
		<td>�ֹι�ȣ(���ڸ�)</td><td><input type="text" name="ssn"></td>
		</tr>
		<tr>
		<td>ȸ����ID</td><td><input type="text" name="memid" value=""></td>
		</tr>
		<tr>
		<td>ȸ����DOMAIN</td><td><input type="text" name="qryDomain" value=""></td>
		</tr>
		<tr>
		<td>ȸ����IP</td><td><input type="text" name="qryIP" value=""></td>
		</tr>
		<tr>
		<td>��/�ܱ��� ����</td><td> 
					<input type="radio" name="qryKndCd" value="1" checked>������
				<input type="radio" name="qryKndCd" value="2">�ܱ���</td>
		</tr>
		<tr>
		<td>��û ����</td><td>
				<input type="radio" name="qryRsnCd" value="01" checked>ȸ������
				<input type="radio" name="qryRsnCd" value="02">ȸ����������
				<input type="radio" name="qryRsnCd" value="03">ȸ��Żȸ
				<input type="radio" name="qryRsnCd" value="04">��������
				<input type="radio" name="qryRsnCd" value="05">��Ÿ</td>
		</tr>
		<tr>
			<td>
			EndPointURL</td>
			<td><input type="text" name="EndPointURL" size=80 value="http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService">
			</td>
		</tr>
		<tr><td>
		<input type="submit" value="Ȯ��"><td>http://tallcredit.kcb4u.com:9090/KcbWebService/OkNameService�� �׽�Ʈ(TEST) ���� URL�Դϴ�.</td>
		</td></tr>
		<tr><td>&nbsp;</td><td>http://www.allcredit.co.kr/KcbWebService/OkNameService�� �(REAL) ���� URL�Դϴ�.</td>
		</tr>
		</table>
		</form>	

<%
} else {
	writer.write("<br>");
	//###########################################################################
	//KCB OKNAME ��ȣȭ SOAP ���
	//������Ʈ�� �ִ��� üũ
	File file = new File(exe);
	if(!file.exists()) {
		writer.write(exe + " ������Ʈ�� �����ϴ�. ���� ��θ� Ȯ���ϼ���.<br><br>");
	}
	else {
		String[] cmd = new String[14];
		cmd[0]=exe;
		cmd[1]=name;
		cmd[2]=ssn;
		cmd[3]=memid;
		cmd[4]=qryBrcCd;
		cmd[5]=qryBrcNm;
		cmd[6]=qryId;
		cmd[7]=qryKndCd;
		cmd[8]=qryRsnCd;
		cmd[9]=qryIP;
		cmd[10]=qryDomain;
		cmd[11]=qryDt;
		cmd[12]=EndPointURL;
		cmd[13]="D";// debug����϶��� "D" �ƴϸ� ""

		// ȭ���� �Ѹ���
		for(int i=0; i<cmd.length; i++) {
			writer.write(cmd[i] + " ");
			System.out.print(cmd[i] + " ");
		}
		writer.write("<br>");
		System.out.print("\n");

		String result="";

		try {
			Process oProcess = oRuntime.exec(cmd);
			oProcess.waitFor();// ���μ����� ������ ���� ��ٸ�

			// �ܺ� ���α׷� ��� �б�
			BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));
			BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));
			String s;
			// "ǥ�� ���"�� "ǥ�� ���� ���"�� ���
			while ((s =   stdOut.readLine()) != null) writer.write(s);
			while ((s = stdError.readLine()) != null) writer.write(s);

			int ret = oProcess.exitValue();
			writer.write("ret="+ret+"<br>");// debug
			if(ret <=200) {
				result = "B" + dcf.format(ret);
			}
			else {
				result = "S" + dcf.format(ret);
			}
			//###########################################################################
		}
		catch(Exception e) {
			System.out.println("[okname] exec error");
			writer.write("[okname] exec error<br>");
		}
		
		writer.write("<br>�̸�: "+name+"<br>");
		writer.write("�ֹι�ȣ(���ڸ�): "+ssn+"<br>");
		writer.write("ȸ����ID: "+memid+"<br>");
		writer.write("ȸ����Domain: "+qryDomain+"<br>");
		writer.write("ȸ����IP: "+qryIP+"<br>");
		writer.write("��/�ܱ��� ����: "+qryKndCd+" (��û����  ���� : 1, �ܱ��� : 2)<br>");
		writer.write("��û ����: "+qryRsnCd+" (��ȸ����  ȸ������ : 01, ȸ���������� : 02, ȸ��Żȸ : 03, �������� : 04, ��Ÿ : 05)<br>");
	
		writer.write("<br>chkName result: "+result+"<br>");
		writer.write("<br>");
	}
}
%>
����:<br>
�� sample ���α׷��� ���缭�� <-> KCB ���̱����� �������� ��ȣȭ�� �����ϸ�<br>
EndUser�� ���缭������ ������ ��ȣȭ�� �������� �ʽ��ϴ�.
