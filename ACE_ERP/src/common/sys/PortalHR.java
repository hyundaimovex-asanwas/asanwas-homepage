
package common.sys;

import com.gauce.*;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.LogBase;
import com.gauce.log.Logger;
import com.hmm.ejb.common.UtilDB;
import java.sql.*;
import javax.servlet.ServletResponse;
import javax.servlet.http.*;
//class 이름은 화일명과 항상 동일해야 함.
public class PortalHR extends HttpServlet
{

	public PortalHR()
	{
	}
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res)
	{
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		Connection conn = null;
		//CallableStatement cstmt =null;		
		Statement stmt = null;
		GauceDataSet dSet = null;
		try
		{
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();
			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();
			try
			{
				logger.dbg.println(this, "step1::");
				dSet = new GauceDataSet();
				GauceRes.enableFirstRow(dSet);
				String str[] = new String[4];
				/**
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//년월
				str[2]	= req.getParameter("v_str3");		//사번
				str[3]	= "N";													//Default 'N'
				**/
				
				for(int s = 0; s <= 3; s++)
					if(str[s] == null)
						str[s] = "";

				String strArrCN[] = {
					"EMPNO", "SEQ", "EDCCD", "GRAYY", "SCHNM"
				};
				int intArrCN[] = {
					7, 2, 4, 4, 60
				};
				int intArrCN2[] = {
					-1, -1, -1, -1, -1
				};
				for(int i = 0; i < strArrCN.length; i++)
					switch(intArrCN2[i])
					{
					case -1: 
						dSet.addDataColumn(new GauceDataColumn(strArrCN[i], 1, intArrCN[i]));
						break;

					default:
						dSet.addDataColumn(new GauceDataColumn(strArrCN[i], 4, intArrCN[i], intArrCN2[i]));
						break;
					}

				if(!GauceReq.isBuilderRequest())
				{
					StringBuffer query = new StringBuffer();
					conn = UtilDB.getConnection("jdbc/asanhr");
					
					logger.dbg.println(this, "step63::");
					query.append("  SELECT EMPNO, SEQ, EDCCD, GRAYY, SCHNM FROM ASNHR2.YA_T_HIEDUC ");
					logger.dbg.println(this, "step7::");
					stmt = conn.createStatement();
					logger.dbg.println(this, "step8::");
					ResultSet rs = stmt.executeQuery(query.toString());
					logger.dbg.println(this, "step9::");
					GauceDataRow row = null;
					logger.dbg.println(this, "step10::");
					for(; rs.next(); logger.dbg.println(this, "step11::"))
					{
						row = dSet.newDataRow();
						row.addColumnValue(rs.getString(1));
						row.addColumnValue(rs.getString(2));
						row.addColumnValue(rs.getString(3));
						row.addColumnValue(rs.getString(4));
						row.addColumnValue(rs.getString(5));
						dSet.addDataRow(row);
					}

					logger.dbg.println(this, "step12::");
					rs.close();
					logger.dbg.println(this, "step13::");
					stmt.close();
					logger.dbg.println(this, "step14::");
				}
			}
			catch(Exception e)
			{
				logger.err.println(this, "\uC624\uB958");
				logger.err.println(this, e);
			}
			finally
			{
				if(stmt != null)
					try
					{
						stmt.close();
					}
					catch(Exception exception1) { }
				if(conn != null)
					try
					{
						conn.close();
					}
					catch(Exception e) { }
			}
			dSet.flush();
			GauceRes.commit();
			GauceRes.close();
		}
		catch(Exception e)
		{
			logger.err.println(this, e);
			logger.dbg.println(this, e.toString());
		}
		finally
		{
			loader.restoreService(service);
		}
	}
}
