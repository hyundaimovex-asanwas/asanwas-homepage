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
public class a050015_s3 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//기수구분         
				String  str2 = req.getParameter("v_str2");	//신고구분    
				String  str3 = req.getParameter("v_str3");	//귀속년도    


				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		            "FDCODE",	  "RCDGB",	  "DATADIV",	"ACCYYQT", "RPTGB",	
					"TAXOFF",	  "SEQ",	  "VENDID",	    "ACCYY",   "FRYMD",	
					"TOYMD",	  "WRYMD",	  "VENDCNT",	"SHTCNT",  "NUMEXP",	
					"REQAMT",	  "VENDCNT1", "SHTCNT1",	"NUMEXP1", "REQAMT1",	
					"VENDCNT2",	  "SHTCNT2",  "NUMEXP2",	"REQAMT2", "FILLER"
				}; 

				int[] intArrCN = new int[]{
				   2,  1,  2,  1,  1,
				   3,  6, 10,  4,  8,
				   8,  8,  6,  6,  1,
				  14,  6,  6,  1, 14,
				   6,  6,  1, 14, 97   
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1,
					-1,  0, -1, -1, -1,
					-1, -1,  0,  0,  0,
					 0,  0,  0,  0,  0,
					 0,  0,  0,  0, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer(); 
					sql.append(" SELECT                                         \n");
					sql.append(" FDCODE,	RCDGB,	  DATADIV,  ACCYYQT,	RPTGB,	\n");
					sql.append(" TAXOFF,	SEQ,	    VENDID,	  ACCYY,	  FRYMD,	\n");
					sql.append(" TOYMD,	  WRYMD,	  VENDCNT,  SHTCNT,	  NUMEXP,	\n");
					sql.append(" REQAMT,	VENDCNT1, SHTCNT1,  NUMEXP1,	REQAMT1,\n");
					sql.append(" VENDCNT2,SHTCNT2,	NUMEXP2,  REQAMT2,	FILLER  \n");
					sql.append("   FROM  ACCOUNT.AVATRPT13    \n");
					sql.append("  WHERE  1=1 \n");		
					if(!str1.equals("")) sql.append(" AND ACCYYQT = '"+str1+"' "); // 기수구분     
					if(!str2.equals("")) sql.append(" AND RPTGB = '"+str2+"'  ");  // 신고구분
					if(!str2.equals("")) sql.append(" AND ACCYY = '"+str3+"'  ");  // 귀속년도
				
					//logger.dbg.println(this, sql.toString());
					//System.out.println("a050015_s3"+sql.toString()); 
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