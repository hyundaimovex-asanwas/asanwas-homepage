<%--
  - 2009-10-14 심동현
  - 로긴 인증 우회 방지 처리 (인젝션)
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
if(cmd.equals("I") ) {				//회원가입
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
				alert('이미 가입된 주민등록 번호 입니다.');
				history.go(-2);
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('사용중인 ID입니다.');
				history.go(-2);
			</script>
	<% } else { %>
			<script language=javascript>
				alert('정상적으로 등록되지 않았습니다.');
				history.go(-2);
			</script>
	<% } %>


<% } else if( cmd.equals("U") ) {			//회원정보 변경
			int result = ab.Update(request, response);
%>
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('수정되었습니다.');
					location.replace("/member/myinfo.jsp");
				</script>
		<% } else {	%>
				<script language=javascript>
					alert('정상적으로 수정되지 않았습니다.');
					history.go(-1);
				</script>
		<% } %>


<% } else if( cmd.equals("C") ) {				//회원가입 체크
			int result = ab.JoinConfirm(request, response);
%>
		
		<% if(result > 0 ) { %>
				<script language=javascript>
					alert('이미 회원가입하셨습니다.');
					location.replace("/member/login.jsp");
				</script>


		<% } else {	

						//<-- 실명인증확인



						Writer writer = response.getWriter();                                           
						Runtime oRuntime = Runtime.getRuntime();                                        
																										
						Calendar cal = Calendar.getInstance();                                          
						SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");                         
						java.text.DecimalFormat dcf = new java.text.DecimalFormat("000");               
																										
						// 파라미터의 인코딩 셋팅                                                       
						request.setCharacterEncoding("euc-kr");                                         
																										
						String name=(String)request.getParameter("name");//이름                         
						String ssn=(String)request.getParameter("regno1")+(String)request.getParameter("regno2");//주민번호
						String memid = "P05170000000";// 회원사 아이디                                        
						String qryBrcCd = "x";                                                                
						String qryBrcNm = "x";                                                                
						String qryId = "u1234";// 쿼리ID, 현재는 고정값                                       
						String qryKndCd = "1";// 요청구분  개인 : 1, 외국인 : 2                               
						String qryRsnCd = "01";// 조회사유  회원가입 : 01, 회원정보수정 : 02, 회원탈회 : 03, ?
						String qryIP = "203.242.32.194";// 회원사 IP                                          
						String qryDomain = "http://www.mtkumgang.com/";// 회원사 도메인                       
						String qryDt = df.format(cal.getTime());//date(Ymd);//<- 현재 시간 함수로 적용하세요. 
						String EndPointURL  = "http://www.allcredit.co.kr/KcbWebService/OkNameService"; 


						//JSP는 모듈의 패스를 절대패스로 지정해야함
						//String exe = "/usr/local/tomcat/webapps/ROOT/okname";
						//String exe = "d:\\oknameweb\\okname.exe";
						String exe = "/home/webadmin/okname/okname_v2.91/okname";


						String[] cmd2 = new String[14];  //실명인증
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

						//화변에 뿌리기                                                                                       
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
								oProcess.waitFor();// 프로세스가 끝날때 까지 기다림                                                                                 
																																								
								// 외부 프로그램 출력 읽기                                                                                                          
								BufferedReader stdOut   = new BufferedReader(new InputStreamReader(oProcess.getInputStream()));                                     
								BufferedReader stdError = new BufferedReader(new InputStreamReader(oProcess.getErrorStream()));                                     
								String s;                                                                                                                           
								// "표준 출력"과 "표준 에러 출력"을 출력                                                                                            
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
												alert("실명인증에 성공하였습니다.");
											</script>
							<%			
							/*
							writer.write("<br>이름: "+name+"<br>");                                                                                               
							writer.write("주민번호(숫자만): "+ssn+"<br>");                                                                                        
							writer.write("회원사ID: "+memid+"<br>");                                                                                              
							writer.write("회원사Domain: "+qryDomain+"<br>");                                                                                      
							writer.write("회원사IP: "+qryIP+"<br>");                                                                                              
							writer.write("내/외국인 구분: "+qryKndCd+" (요청구분  개인 : 1, 외국인 : 2)<br>");                                                    
							writer.write("요청 구분: "+qryRsnCd+" (조회사유  회원가입 : 01, 회원정보수정 : 02, 회원탈회 : 03, 성인인증 : 04, 기타 : 05)<br>");    
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
												alert("실명인증에 실패하였습니다.");
												location.replace("/member/join_agreement.jsp");
											</script>
							<%}
											
		}//실명인증 --!>%>      

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

<% } if(cmd.equals("D") ) {	//회원탈퇴
	int result = ab.Withdrawal(request, response);
%>
	<% if(result > 0 ) {
			//logout 처리
			LoginBean lb = new LoginBean();
			lb.Logout(request, response);
	%>
			<script language=javascript>
				alert("회원탈퇴가 정상적으로 처리 되었습니다");
				location.replace("/index.jsp");
			</script>

	<% } else if(result == -1) {	%>
			<script language=javascript>
				alert('로그인한 아이디와 입력하신 아이디가 일치 하지 않습니다.');
				history.go(-2);
			</script>

	<% } else { %>
			<script language=javascript>
				alert('입력하신 정보와 일치하는 회원정보가 없습니다.');
				history.go(-2);
			</script>
	<% } %>
<% } %>