package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040065_t2 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceStatement gsmt=null;

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2"); //RETURN용

				String strEmpno = reqGauce.getParameter("v_str1");     //사번
				String strRegno = reqGauce.getParameter("v_str2");     //공급자 사업자 등록번호

				String strID="";
				String strPW="";  

				StringBuffer sql9 = null;
				Statement stmt9 = null;
				ResultSet rs9 = null;

				//스마트빌 ID, PW 조회 >>>>>>>>>>>
				sql9 = new StringBuffer();
				
				sql9.append( " SELECT SMART_ID, SMART_PASSWORD     		\n" ); 
				sql9.append( " 	 FROM HDASAN_EDI.XXSB_DTI_SM_USER  		\n" ); 
				sql9.append( "  WHERE FND_USER ='"+strEmpno+"'     				\n" ); 
				sql9.append( "    AND FND_REGNO ='"+strRegno+"'    				\n" ); 
				
				stmt9 = conn.createStatement();
				rs9 = stmt9.executeQuery(sql9.toString());
				while(rs9.next()){         
					strID = rs9.getString(1);  
					strPW = rs9.getString(2);  
				}
				rs9.close();
				stmt9.close();


				if (userSet2 != null) {
						resGauce.enableFirstRow(userSet2);
						userSet2.addDataColumn(new GauceDataColumn("ID",   GauceDataColumn.TB_STRING,12));
						userSet2.addDataColumn(new GauceDataColumn("PASS", GauceDataColumn.TB_STRING,35));
					 
						GauceDataRow row = null;
						row = userSet2.newDataRow();
						row.addColumnValue(strID);
						row.addColumnValue(strPW);
						userSet2.addDataRow(row);
						userSet2.flush();
				 }
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}