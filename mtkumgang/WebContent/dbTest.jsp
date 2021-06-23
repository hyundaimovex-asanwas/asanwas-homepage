<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="kr.co.imjk.lib.db.DBHandler" %>
<%@ page import="kr.co.imjk.util.ConfigFile"%>
<%@ page import="kr.co.imjk.util.Config"%>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, javax.naming.directory.*" %>
<html>
<head>
<title>db test !!!!</title>
</head>

<body>

<%
  
	Connection c=null;
	Statement s=null;
	ResultSet r=null;
   
	try
	{


		c = DBHandler.getInstance().getConnection();
		out.println("c==>"+c); 
		s = c.createStatement();
		r = s.executeQuery( "select * from asan.TBRD_BOARD_MA" );

		while( r.next() )
		{
			out.println(r.getString(1)+"<br>");
		}

	
	}
	catch(SQLException e)
	{
		e.printStackTrace(new PrintWriter(out));
	}
	catch(Exception e)
	{
		e.printStackTrace(new PrintWriter(out));
	}finally{
	
		if(r != null) r.close();
		if(s != null) s.close();
		if(c != null) c.close();
	}
	
%>