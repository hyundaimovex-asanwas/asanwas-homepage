<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "java.sql.*, java.net.*, java.util.*, java.io.*,javax.naming.*, javax.naming.directory.* " %>
<%!
public String replace(String org, String from, String to)
{
    int last=0, next=0;
    String result = "";
    String uppper_str = org.toUpperCase();
    from = from.toUpperCase();
    
    while (true) 
    {
        next = uppper_str.indexOf(from, last);
        if (next >= 0 ) 
        {
            result += org.substring(last, next) + to;
            last = next + from.length();
        }
        else 
        {
            result += org.substring(last);
            break;
        }
    }
    
    return result;
}
%>
<html>
<head>
<title>Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
</head>
<body leftmargin=0 topmargin=0 marginheight=0 marginwidth=0 style="font-family:dotum;font-size:9pt" >
<%
    Connection con = null;
    PreparedStatement ps = null;
    Statement stmt = null;
    ResultSet rs = null;
    String sql = new String();
    StringBuffer sb = new StringBuffer("");        
    String sql1 = new String();
    StringBuffer sb1 = new StringBuffer("");        
    int count = 0;
    int sqlcnt = 0;
    ResultSetMetaData rsmd = null;
    String sqlArr [] = null;
    StringTokenizer st = null;
    String temp = new String();
    Context ctx = new InitialContext();
    try
    {
    	javax.sql.DataSource ds  = (javax.sql.DataSource)ctx.lookup("jdbc/tourtestds");
        con = ds.getConnection();

        sql = request.getParameter("qry").trim();
        
        st = new StringTokenizer(sql,";");
        
        sqlArr = new String[st.countTokens() ];
        
        while(st.hasMoreTokens())
        {
            sqlArr[sqlcnt] = (String)st.nextToken();
            sqlArr[sqlcnt] = sqlArr[sqlcnt].trim();
            sqlcnt ++;
        }
        
        for(int k=0;k<sqlcnt;k++)
        {
            out.println(replace(sqlArr[k],"\n","<br>")+"<br>");    
            
            if(sqlArr[k].substring(0,6).toUpperCase().equals("INSERT")||sqlArr[k].substring(0,6).toUpperCase().equals("DELETE")||sqlArr[k].substring(0,6).toUpperCase().equals("UPDATE"))
            {
                stmt = con.createStatement();
                stmt.execute(sqlArr[k]);
                con.commit();
                stmt.close();
            }
            else if(sqlArr[k].substring(0,6).toUpperCase().equals("SELECT"))
            {
                stmt = con.createStatement();
                stmt.execute(sqlArr[k]);
                rs = stmt.getResultSet();               
    
                rsmd = rs.getMetaData();                
                count = rsmd.getColumnCount();
                System.out.println("column count : "+String.valueOf(count)+"<br>");
%>
<table border=0 bgcolor="434343" cellpadding=0 cellspacing=1>
<tr>
<%            
                for(int j=0;j<count;j++)
                {
%>
<td valign="top" bgcolor="E5E5E5" style="font-family:dotum;font-size:9pt;padding:3px" align="center"><b><%= rsmd.getColumnName(j+1)%>(<%= rsmd.getColumnTypeName(j+1)%>(<%= rsmd.getColumnDisplaySize(j+1)%>))</font></td>
<%                
                }
%>
</tr>
<%                
                while( rs.next() )
                {
%>
<tr>
<%
                    for(int i=0;i<count;i++)
                    {
                        if(rsmd.getColumnTypeName(i+1).indexOf("BIT DATA")>= 0)
                        {
                            byte [] b = rs.getBytes(i+1);
                            InputStream is = new ByteArrayInputStream(b);
                            ByteArrayOutputStream  baos = new ByteArrayOutputStream();
                            baos.write(b,0,b.length-1);
                            //for (int j = 0; j< b.length;j++)
                            //{
                            //    baos.write(b, j, 1) ;
                            //}
                            //while(
                            //for(int j = 0;j<b.length;j++)
                            //{
                            //    temp += String.valueOf(b[j]);
                            //}
%>
<td valign="top" bgcolor="FFFFFF" style="font-family:dotum;font-size:9pt;padding:3px"><%= is.toString()%></td>
<%
                            //os.close();
                        }
                        else
                        {
                            temp = rs.getString(i+1);
%>
<td valign="top" bgcolor="FFFFFF" style="font-family:dotum;font-size:9pt;padding:3px"><%= (temp==null||temp.equals(""))?"&nbsp":temp%></td>
<%
                        }
                    }
%>                
</tr>
<%                
                }
%>
</table><br><br><br><br>
<%            
                
                rs.close();
                stmt.close();
            }
            else
            {
                out.println("else<br>");
                stmt = con.createStatement();
                stmt.execute(sqlArr[k]);
                //ps.executeQuery();
                out.println("stmt.execute(sql);<br>");
                stmt.close();
            }
            //ps.close();
        }
    }
    catch(SQLException sqle)
    {
        sqle.printStackTrace(new PrintWriter(out));
    }
    catch(Exception e)
    {  
        e.printStackTrace(new PrintWriter(out));
    }
    finally
    {
        try
        {
            if(con !=null)
            {
                con.close();
            }
        }
        catch(SQLException sqle1)
        {
            sqle1.printStackTrace(new PrintWriter(out));
        }
    }
%>    
</body>
</html>