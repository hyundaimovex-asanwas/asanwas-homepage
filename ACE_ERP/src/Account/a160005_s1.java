package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a160005_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String  str1 = req.getParameter("v_str1");	//년도        
				String  str2 = req.getParameter("v_str2");	//월        
				String  str3 = req.getParameter("v_str3");	//성명        
				
				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str2 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"YYYY",	     "INC_MM",	    "INC_SEQ",	    "PAY_DT",	  "CO_CRNO",	     
						"CO_NO",	 "CO_NM",	    "CO_RENM",	    "CO_AD",	  "EA_NM",	     
						"EA_NO",	 "EA_AD",	    "EA_CRNO",	    "EA_FMARK",	  "EA_FAD",	     
						"EA_BSGB",	 "TOT_AMT",	    "TAX_RATE",	    "INC_TAX",	  "LINC_TAX",	
						"SUM_AMT",	 "INOUT_GB",	"RESID_NM",	    "RESID_GB",	             
						"CREATE_ID", "CREATE_DATE",	"UPDATE_ID",	"UPDATE_DATE"                 

				}; 

				int[] intArrCN = new int[]{
						  4,  2,  3,  8, 10, 
						 13, 50, 20,100, 20, 
						 13,100, 10, 50,100, 
						 50, 10,  4, 10, 10, 
						 10,  1, 20,  2, 
						 10,  6, 10,  6
				}; 
			
				int[] intArrCN2 = new int[]{     
						-1, -1,  0, -1, -1,
						-1, -1, -1, -1, -1,
						-1, -1, -1, -1, -1,
						-1,  0,  1,  0,  0,
						 0, -1, -1, -1,
						-1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT YYYY,	INC_MM,	INC_SEQ,	PAY_DT,	CO_CRNO,	            \n");
					sql.append("        CO_NO,	CO_NM,	CO_RENM,	CO_AD,	EA_NM,	                \n");
					sql.append("        EA_NO,	EA_AD,	EA_CRNO,	EA_FMARK,	EA_FAD,	            \n");
					sql.append("        EA_BSGB,	TOT_AMT,	TAX_RATE,	INC_TAX,	LINC_TAX,	\n");
					sql.append("        SUM_AMT,	INOUT_GB,	RESID_NM,	RESID_GB,	            \n");
					sql.append("        CREATE_ID,	CREATE_DATE,	UPDATE_ID,	UPDATE_DATE         \n");
					sql.append("   FROM ACCOUNT.BINCOME                                             \n");
					sql.append("  WHERE YYYY= '"+str1+"'   \n");
					
					if(!str2.equals("")) sql.append(" AND INC_MM = '"+str2+"' \n");//
					if(!str3.equals("")) sql.append(" AND EA_NM = '"+str3+"' \n");//
				    			
					//System.out.println("sql.toString()::"+sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
			logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
	}
	}
}