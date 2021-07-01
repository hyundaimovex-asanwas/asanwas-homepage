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
public class a050010_s3 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//법인구분  
				String  str2 = req.getParameter("v_str2");	//귀속년도  
				String  str3 = req.getParameter("v_str3");	//반기구분  
				String  str4 = req.getParameter("v_str4");	//반기내순번
				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
          "FDCODE", 	"RCDGB",	"ACCYY",	 "ACCHF",	  "HALFNO",	 "VENDID",
					"TVCNT1",	 "TVCNT2",  "TVCNT3",  "TVCNT4",
          "TREQAMT1","TREQAMT2","TREQAMT3","TREQAMT4",
          "TTAXAMT1","TTAXAMT2","TTAXAMT3","TTAXAMT4",
					"TVCNT",	 "TREQAMT", "TTAXAMT",
					"FILLER"
				}; 

				int[] intArrCN = new int[]{
          2, 2, 4, 1, 1, 10, 
          9, 9, 9, 9,
         15,15,15,15, 
			   15,15,15,15, 
				  9,15, 15,	
					74
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1, -1,
					 0,  0,  0, 0,
           0,  0,  0, 0,
           0,  0,  0, 0,
           0,  0,  0,
          -1 
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append(" SELECT X.FDCODE, X.RCDGB, X.ACCYY, X.ACCHF, X.HALFNO, X.VENDID,                                             \n");
					sql.append("        SUM(X.TVCNT1)TVCNT1,SUM(X.TVCNT2)TVCNT2,SUM(X.TVCNT3)TVCNT3,SUM(X.TVCNT4)TVCNT4,                     \n");
					sql.append("        SUM(X.TREQAMT1)TREQAMT1, SUM(X.TREQAMT2)TREQAMT2, SUM(X.TREQAMT3)TREQAMT3, SUM(X.TREQAMT4)TREQAMT4,  \n");
					sql.append("        SUM(X.TTAXAMT1)TTAXAMT1, SUM(X.TTAXAMT2)TTAXAMT2, SUM(X.TTAXAMT3)TTAXAMT3, SUM(X.TTAXAMT4)TTAXAMT4,  \n");
					sql.append("        SUM(X.TVCNT)TVCNT, SUM(X.TREQAMT)TREQAMT,  SUM(X.TTAXAMT)TTAXAMT, X.FILLER                           \n");
					sql.append(" FROM (  \n");
					sql.append(" SELECT FDCODE, RCDGB, ACCYY, ACCHF, HALFNO, VENDID, CARDGB,        \n");
					sql.append("        CASE WHEN CARDGB='1' THEN SUM(VCNT) ELSE 0 END TVCNT1,      \n");
					sql.append("        CASE WHEN CARDGB='2' THEN SUM(VCNT) ELSE 0 END TVCNT2,      \n");
					sql.append("        CASE WHEN CARDGB='3' THEN SUM(VCNT) ELSE 0 END TVCNT3,      \n");
					sql.append("        CASE WHEN CARDGB='4' THEN SUM(VCNT) ELSE 0 END TVCNT4,      \n");
					sql.append("        CASE WHEN CARDGB='1' THEN SUM(REQAMT) ELSE 0 END TREQAMT1,  \n");
					sql.append("        CASE WHEN CARDGB='2' THEN SUM(REQAMT) ELSE 0 END TREQAMT2,  \n");
					sql.append("        CASE WHEN CARDGB='3' THEN SUM(REQAMT) ELSE 0 END TREQAMT3,  \n");
					sql.append("        CASE WHEN CARDGB='4' THEN SUM(REQAMT) ELSE 0 END TREQAMT4,  \n");
					sql.append("        CASE WHEN CARDGB='1' THEN SUM(TAXAMT) ELSE 0 END TTAXAMT1,  \n");
					sql.append("        CASE WHEN CARDGB='2' THEN SUM(TAXAMT) ELSE 0 END TTAXAMT2,  \n");
					sql.append("        CASE WHEN CARDGB='3' THEN SUM(TAXAMT) ELSE 0 END TTAXAMT3,  \n");
					sql.append("        CASE WHEN CARDGB='4' THEN SUM(TAXAMT) ELSE 0 END TTAXAMT4,  \n");
					sql.append("        SUM(VCNT)TVCNT, SUM(REQAMT)TREQAMT, SUM(TAXAMT)TTAXAMT,     \n");
					sql.append("        ''FILLER    \n");
					sql.append("   FROM ACCOUNT.AVATRPT82                                           \n");
					sql.append("  WHERE RCDGB='DL' \n");
					if(!str1.equals("")) sql.append(" AND FDCODE = '"+str1+"'");      
					if(!str2.equals("")) sql.append(" AND ACCYY = '"+str2+"' ");
					if(!str3.equals("")) sql.append(" AND ACCHF = '"+str3+"' ");
					if(!str4.equals("")) sql.append(" AND HALFNO= '"+str4+"' ");
					sql.append("  GROUP BY FDCODE, RCDGB, ACCYY, ACCHF, HALFNO, VENDID,CARDGB \n");
					sql.append("  ) X \n");
					sql.append(" GROUP BY X.FDCODE, X.RCDGB, X.ACCYY, X.ACCHF, X.HALFNO, X.VENDID,X.FILLER \n");
          
					//logger.dbg.println(this, sql.toString());

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