<%--
  - 2009-10-14 �ɵ���
  - �α� ���� ��ȸ ���� ó�� (������)
--%>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">                    
<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.io.*, java.util.*, java.text.SimpleDateFormat, java.util.Date" %> 
<%@ page import="com.hmm.asan.www.member.MemberBean" %>
<%@ page import="com.hmm.asan.www.member.LoginBean" %>
<%@ page import= "com.hmm.asan.common.util.Utility"%> 
<%@ page import="kr.co.imjk.util.*"%>                 
<%@ include file="/common/properties.jsp" %>
<%@ include file="/secinc/config.inc.jsp" %> 
<%@ include file="/secinc/secure.inc.jsp" %>
<%@ include file="/common/header.jsp" %>

<%
	MemberBean ab = new MemberBean();
	String cmd = request.getParameter("cmd");
%>

<%
if(cmd.equals("I") ) {				//ȸ������
	int result = ab.Insert(request, response);
%>
	<% if(result > 0 ) { %>
			<form name="form" method=post action="/member/join_complete.jsp">
				<input type=hidden name=name value="<%=request.getParameter("name")%>">
				<input type=hidden name=id value="<%=request.getParameter("id")%>">
				<input type=hidden name=pwd value="<%=request.getParameter("pwd")%>">
				<input type=hidden name=domain value="<%=ROOT_DNS%>">
			</form>
			<script language=javascript>
				document.form.submit();
			</script>

	<% } else if(result == -2) {	%>
			<script language=javascript>
				alert('�̹� ���Ե� �ֹε�� ��ȣ �Դϴ�.');
				history.go(-2);
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('������� ID�Դϴ�.');
				history.go(-2);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('���������� ��ϵ��� �ʾҽ��ϴ�.');
				history.go(-2);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {			//ȸ������ ����
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�����Ǿ����ϴ�.');
					location.replace("/member/myinfo.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('���������� �������� �ʾҽ��ϴ�.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("C") ) {				//ȸ������ üũ
			int result = ab.JoinConfirm(request, response);
%>
		
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('�̹� ȸ�������ϼ̽��ϴ�.');
					location.replace("/member/login.jsp");
				</script>


		<% } else {	

						//<-- �Ǹ�����Ȯ��



						Writer writer = response.getWriter();                                           
						Runtime oRuntime = Runtime.getRuntime();                                        
																										
						Calendar cal = Calendar.getInstance();                                          
						SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");                         
						java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");               
																										
						// �Ķ������ ���ڵ� ����                                                       
						request.setCharacterEncoding("euc-kr");                                         
																										
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


						String[] cmd2 = new String[14];  //�Ǹ�����
							cmd2[0]=exe;                     
							cmd2[1]=name;                    
							cmd2[2]=ssn;                     
							cmd2[3]=memid;                   
							cmd2[4]=qryBrcCd;                
							cmd2[5]=qryBrcNm;                
							cmd2[6]=qryId;                   
							cmd2[7]=qryKndCd;                
							cmd2[8]=qryRsnCd;                
							cmd2[9]=qryIP;                   
							cmd2[10]=qryDomain;              
							cmd2[11]=qryDt;                  
							cmd2[12]=EndPointURL;            
							cmd2[13]="D";              

						//ȭ���� �Ѹ���                                                                                       
						/*
						for(int i=0; i<cmd2.length; i++) {     
							writer.write(cmd2[i] + " ");         
							System.out.print(cmd2[i] + " ");     
						}                                     
						writer.write("<br>");                 
						System.out.print("\n");               
						*/								  
						String result2="";            
							try {    
						
								Process oProcess = oRuntime.exec(cmd2);                                                                                              
								oProcess.waitFor();// ���μ����� ������ ���� ��ٸ�                                                                                 
																																								
								// �ܺ� ���α׷� ��� �б�                                                                                                          
								BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));                                     
								BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));                                     
								String s;                                                                                                                           
								// "ǥ�� ���"�� "ǥ�� ���� ���"�� ���                                                                                            
								//while ((s =   stdOut.readLine()) != null) writer.write(s);                                                                          
								//while ((s = stdError.readLine()) != null) writer.write(s);                                                                          
																																								
								int ret = oProcess.exitValue();                                                                                                     
								//writer.write("ret="+ret+"<br>");// debug                                                                                            
								if(ret <=200) {                                                                                                                     
									result2 = "B" + dcf.format(ret);  
									//writer.write(result2);
								}                                                                                                                                   
								else {                                                                                                                              
									result2 = "S" + dcf.format(ret);                                                                                                   
								}                                                                                                                                   
								//###########################################################################                                                       
							}                                                                                                                                     
							catch(Exception e) {                                                                                                                  
								System.out.println("[okname] exec error");                                                                                          
								writer.write("[okname] exec error<br>");                                                                                            
							}                                                                                                                                     
							
							if(result2.equals("B000")){
							%>
											<script language=javascript>
												alert("�Ǹ������� �����Ͽ����ϴ�.");
											</script>
							<%			
							/*
							writer.write("<br>�̸�: "+name+"<br>");                                                                                               
							writer.write("�ֹι�ȣ(���ڸ�): "+ssn+"<br>");                                                                                        
							writer.write("ȸ����ID: "+memid+"<br>");                                                                                              
							writer.write("ȸ����Domain: "+qryDomain+"<br>");                                                                                      
							writer.write("ȸ����IP: "+qryIP+"<br>");                                                                                              
							writer.write("��/�ܱ��� ����: "+qryKndCd+" (��û����  ���� : 1, �ܱ��� : 2)<br>");                                                    
							writer.write("��û ����: "+qryRsnCd+" (��ȸ����  ȸ������ : 01, ȸ���������� : 02, ȸ��Żȸ : 03, �������� : 04, ��Ÿ : 05)<br>");    
							writer.write("<br>chkName result: "+result2+"<br>");                                                                                   
							writer.write("<br>");  
							*/
							%>
								<form name="form" method=post action="/member/join_register.jsp">
									<input type=hidden name=name value="<%=request.getParameter("name")%>">
									<input type=hidden name=regno1 value="<%=request.getParameter("regno1")%>">
									<input type=hidden name=regno2 value="<%=request.getParameter("regno2")%>">
								</form>
								<script language=javascript>
									document.form.submit();
								</script>
							<%}
							if(!result2.equals("B000")){
							%>
											<script language=javascript>
												alert("�Ǹ������� �����Ͽ����ϴ�.");
												location.replace("/member/join_agreement.jsp");
											</script>
							<%}
											
		}//�Ǹ����� --!>%>      

<% } else if( cmd.equals("IS") ) {				//id search
			int result = ab.IdSearch(request, response);
%>
	
		<form name="form" method=post action="/member/id_search_result.jsp">
			<input type=hidden name=result value="<%=result%>">
			<input type=hidden name=cmd value="<%=cmd%>">
			<input type=hidden name=name value="<%=request.getParameter("name")%>">
			<input type=hidden name=id value="<%=request.getAttribute("id")%>">
		</form>
		<script language=javascript>
				document.form.submit();
		</script>


<% } else if( cmd.equals("PS") ) {				//pwd search
			int result = ab.PwdSearch(request, response);
%>	
			<form name="form" method=post action="/member/id_search_result.jsp">
				<input type=hidden name=result value="<%=result%>">
				<input type=hidden name=cmd value="<%=cmd%>">
				<input type=hidden name=semail value="<%=request.getParameter("semail")%>">
			</form>
			<script language=javascript>
				document.form.submit();
			</script>

<% } if(cmd.equals("D") ) {	//ȸ��Ż��
	int result = ab.Withdrawal(request, response);
%>
	<% if(result > 0 ) {
			//logout ó��
			LoginBean lb = new LoginBean();
			lb.Logout(request, response);
	%>
			<script language=javascript>
				alert("ȸ��Ż�� ���������� ó�� �Ǿ����ϴ�");
				location.replace("/index.jsp");
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('�α����� ���̵�� �Է��Ͻ� ���̵� ��ġ ���� �ʽ��ϴ�.');
				history.go(-2);
			</script>

	<% } else { %>
			<script language=javascript>
				alert('�Է��Ͻ� ������ ��ġ�ϴ� ȸ�������� �����ϴ�.');
				history.go(-2);
			</script>
	<% } %>
<% } %>