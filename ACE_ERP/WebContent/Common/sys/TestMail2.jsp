<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="java.io.*,java.sql.*,java.util.*, javax.mail.*,javax.mail.internet.*"%>
<%
// [ 수정일자 ][수정자] 내용   
// [2011-08-12][심동현] 테섭 및 운영 웹서버에서 잘 성공함
	
	String name = "발신자";	//발신자 이름
	String from = "asan@hmm21.com";	//발신 이메일
	String title = "test";	//제목
	String content = "test라라라라라";	//메일 내용
	
	String to_name  = "jm";	//수신자 이름
	String to_email = "sim9010@gmail.com";	//수신 이메일

	try
	{
		Properties props = System.getProperties();
		props.put("mail.smtp.host", "localhost");
		
		Session ss = Session.getDefaultInstance(props, null);
		Message msg = new MimeMessage(ss);
		
		msg.setFrom(new InternetAddress(from, name));
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to_email, false));
		msg.setSubject(title);
		msg.setText(content);
		msg.setHeader("Content-Type", "text/html;charset=EUC-KR");
		
		msg.setSentDate(new java.util.Date());
		Transport.send(msg);
		
	}
	catch (Exception e)
	{}

	finally{}
%>

