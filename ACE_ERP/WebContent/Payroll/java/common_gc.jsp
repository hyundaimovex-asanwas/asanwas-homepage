<%@ page import="java.io.*"%> 
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.*"%> 
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.gauce.*, com.gauce.io.*, com.gauce.common.*, com.gauce.log.*, com.gauce.db.*" %>
<%@ page import="com.microsoft.jdbc.sqlserver.*,com.microsoft.jdbc.base.*,com.microsoft.util.*" %>
<%
	ServiceLoader loader = new ServiceLoader(request, response);

	GauceService service = loader.newService();
	GauceContext context = service.getContext();
	Logger logger = context.getLogger();

	GauceDBConnection gconn = null;
	GauceStatement gstmt =null;
	GauceDataSet dSet = null;
	GauceDataSet dSet2 = null;
	GauceDataRow gRow = null;
	GauceDataRow gRow2 = null;

	Statement stmt = null;
	PreparedStatement pstmt = null;
	CallableStatement cstmt = null;

	Connection conn = null;
	ResultSet rs = null;

	GauceRequest req = service.getGauceRequest();
	GauceResponse res = service.getGauceResponse();

%>

<%!

public Connection ConnDB() throws Exception{ 

	String dbUrl    = "jdbc:as400://211.49.125.7";
	String driver   = "com.ibm.as400.access.AS400JDBCDriver";
	String userName = "QPILOT";
	String userPass = "PILOT";

	Class.forName(driver);
	
	return DriverManager.getConnection(dbUrl, userName, userPass);
} 

public Connection ConnDB2() throws Exception{ 
	String dbUrl    = "jdbc:microsoft:sqlserver://150.1.11.243:1433";
	String driver   = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
	String userName = "SELMIS";
	String userPass = "SAMIK";

	Class.forName(driver);
	
	return DriverManager.getConnection(dbUrl, userName, userPass);
} 

public String convertCharSet(String conStr) throws Exception
{
	return new String(conStr.getBytes("8859_1"),"ksc5601");
}

public String convertCharSet(StringBuffer conStr) throws Exception
{
	return new String(conStr.toString().getBytes("8859_1"),"ksc5601");
}

public String LTrim(String s)
{
    int i = s.length();
    int j = 0;
    for(j = 0; j < i; j++)
        if(s.charAt(j) != ' ')
            break;

    return s.substring(j);
}

%>
