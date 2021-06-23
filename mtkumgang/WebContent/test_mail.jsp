<%@page contentType="text/html; charset=euc-kr"%>
<%@page import="java.io.*,java.sql.*,java.util.*, javax.mail.*,javax.mail.internet.*"%>
<%
	
	String name = "asan";
	String from = "asan@hmm21.com";
	String title = "test";
	String content = "test";

	String to_name  = "jm";
	String to_email = "czar.pe.kr@gmail.com";

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

