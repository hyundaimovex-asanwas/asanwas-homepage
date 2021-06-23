<%@ page import="java.sql.*,java.util.*,java.net.*,java.lang.*,java.io.*, java.text.NumberFormat" contentType="text/html;charset=EUC_KR"%>
<%@ page import="com.hmm.ejb.common.*" %>
<%@ page import="com.hmm.asan.common.util.Utility" %>

<%
	String query = "";

	if(request.getParameter("query") != null){
		query = request.getParameter("query");
	}
%>

<HTML>
<HEAD>
<TITLE> 자유질의 결과 </TITLE>
<link rel="stylesheet" href="/css/a1.css">
</HEAD>
<BODY>

<!--  자유질의 툴 시작 -->
	<SCRIPT LANGUAGE="JavaScript">
	<!--
		function check_value()
		{
			if(document.freequery.query.value == "")
			{
				alert("실행할 쿼리문이 없습니다.");
				document.freequery.query.focus();
				return;
			}
			document.freequery.submit();
		}
		function clear_value()
		{
			document.freequery.query.value = "";
			document.freequery.query.focus();
		}
	//-->
	</SCRIPT>

	<form action="freequery.jsp" name="freequery" method="post">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td height="5"></td></tr></table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td width="12"></td>
          <td align="left" valign="top"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0" height="25">
              <tr align="left" valign="top"> 
                <td bgcolor="#C7C7AF"> 
                  <table width=100% border="0" cellspacing="1" cellpadding="2">
                    <tr bgcolor="#ffffff" align="left" valign="top"> 
                      <td> 
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolor="#999999" style="font-size:9pt;">
                          <tr align="left" valign="middle" bgcolor="#EAEAD5"> 
                            <td height="25">
								&nbsp;<img src="/image/icon02.gif" width="10" height="8"><span class="title"> Free Query Tool </span>&nbsp; : 
								&nbsp; SELECT 등 SQL 관련 쿼리를 실행할 수 있다.
							</td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr align="center"> 
          <td width="12"></td>
          <td bgcolor="#F4F4E7" height=95><textarea name='query' rows=5 cols=80 style='width:80%;'><%=query%></textarea></td>
        </tr>
        <tr align="center"> 
          <td width="12"></td>
          <td bgcolor="#F4F4E7" height=25 valign=top>
			<input type=button value=" Query " onclick="javascript:check_value()">&nbsp;&nbsp;
			<input type=button value=" Clear " onclick="javascript:clear_value()">
		  </td>
        </tr>
      </table>
</form>
<br>
<!-- 자유질의 툴 끝 -->

<%
	if(query.length() > 0){
%>
<TABLE>
<TR>
<TD>
		<font color=darkblue>【 <b>SQL</b> : <%=query%> 】</font>
</TD>
</TR>
<TR>
<TD>

<%
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;

		con = UtilDB.getConnection("jdbc/asands");
		stmt = con.createStatement();

		Vector col_name = null;
		Vector result = null;
		int result_count = 0;

		try
		{
			rs = stmt.executeQuery(query);

			ResultSetMetaData md = rs.getMetaData();
			int col_count = md.getColumnCount();
			int row = 0;

			//rs.last();
			//result_count = rs.getRow();
			//rs.beforeFirst();
%>
			<TABLE width="100%" border="0" style="font-size:9pt;">
			<TR align="center" valign="middle" bgcolor="#CFD2CA">
<%
			for (int k=1;k<=col_count ;k++ )
			{
%>
			<TD height="20" bgcolor="#DDDFD9"><font color="#000000"><%= md.getColumnName(k)%></font></TD>
<%
			}
%>
			</TR>
<%
			while(rs.next())
			{	
%>		
			<TR align="center" valign="middle" bgcolor="#E3E3CC">
<%
				for(int i = 1; i <= col_count; i++)
				{
%>
			<TD><font color="#000000"><%=(rs.getString(i)==null || rs.getString(i).equals("") ? "-":rs.getString(i)) %></font></TD>
<%
				}
%>
			</TR>
<%
			}
%>
			</TABLE>
</TD>
</TR>
<TR>
<TD>
<%
			rs.close();
			if (!con.isClosed())
				con.close();
		}
		catch(SQLException sel) 
		{
%>
				<br>
				<TABLE>
				<TR>
					<TD><font color=red> * Query 에러 : </font></TD>
					<TD><%=sel.getMessage()%></TD>
				</TR>
				</TABLE>
<%
		}
%>
</TD>
</TR>
</TABLE>
<%
	}
%>

</BODY>
</HTML>
