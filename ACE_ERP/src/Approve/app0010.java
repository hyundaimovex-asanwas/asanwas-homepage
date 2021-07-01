package Approve;

import com.gauce.*;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import java.sql.*;
import java.util.Iterator;
import javax.servlet.ServletException;
import sales.common.HDUtil;
import sales.common.SuperServlet;

public class app0010 extends SuperServlet
{
	public app0010()
	{
	}
	public void makeSql()
	{
		for(int i = 0; i < super.arr_sql.length; i++)
			super.arr_sql[i] = new StringBuffer();
		super.arr_sql[0].append("{call SALES.PR_APP0010_01 (?,?,?,?) }");
	}
	public void init(GauceDBConnection gaucedbconnection, GauceRequest gaucerequest, GauceResponse gauceresponse)
		throws ServletException, Exception
	{
	}
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)
		throws ServletException, Exception
	{
		com.gauce.db.GauceStatement stmt = null;
		ResultSet rs = null;
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		java.sql.ResultSetMetaData rsmd = null;
		String columnName[] = (String[])null;
		String sNowEmpno = HDUtil.nullCheckStr(req.getParameter("v_empno"));
		String sFrDate = HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String sToDate = HDUtil.nullCheckStr(req.getParameter("v_to_date"));
		String sDocGu = HDUtil.nullCheckStr(req.getParameter("v_doc_gu"));
		try
		{
			for(Iterator it = req.getGauceDataSetKeys(); it.hasNext();)
			{
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1 != null)
				{
					res.enableFirstRow(ds1);
					if("MASTER".equals(gauceName))
					{
						cstmt = conn.prepareCall(super.arr_sql[0].toString());
						cstmt.setString(1, sNowEmpno);
						cstmt.setString(2, sFrDate);
						cstmt.setString(3, sToDate);
						cstmt.setString(4, sDocGu);
						rs = cstmt.executeQuery();
					}
					getDataSet(rs, ds1).flush();
				}
			}
		}
		catch(SQLException sqle)
		{
			res.writeException("ERROR", sqle.getErrorCode() + "", sqle.getMessage());
			throw sqle;
		}
		catch(Exception e)
		{
			res.writeException("ERROR", "", e.toString());
			throw e;
		}
		finally
		{
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
		}
	}
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)
		throws ServletException, Exception
	{
	}
}
