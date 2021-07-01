package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class bm053i_s2 extends HttpServlet {

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
				String [] str = new String[1];
        str[0] =  req.getParameter("v_str1"); //년월
		
        for(int i=0;i<=0;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "TELHIS_SID", "CUST_SID",  "CT",       "TEL_SID", "TEL_NUM",
                                           "TEL_DATE",   "TEL_STIME", "TEL_ETIME","TEL_DURA","TEL_FEE",
					                                 "CAL_YN",     "UP_SID",    "WORK_NO",  "OP",
					                                 "I_EMPNO",    "U_EMPNO"
																		  	}; 

				int[] intArrCN = new int[] { 10, 10,  1, 10, 15,
					                            8,  6,  6,  3,  3,
					                            1, 10, 20,  1, 
					                           10, 10
																		}; 
			
				int[] intArrCN2 = new int[]{  0, 0,-1, 0,-1,
					                           -1,-1,-1,-1, 1,
					                           -1, 0,-1,-1,
					                           -1,-1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append(" 	 SELECT TELHIS_SID, CUST_SID,  CT,       TEL_SID, TEL_NUM,   \n");
						sql.append(" 	        TEL_DATE,   TEL_STIME, TEL_ETIME,TEL_DURA,TEL_FEE,   \n");
						sql.append(" 	        CAL_YN,     UP_SID,    WORK_NO,  OP,      I_EMPNO,    U_EMPNO  \n");
						sql.append(" 	   FROM SALES.TCM080                                      \n");
						sql.append(" 	   WHERE 1=1                                              \n");						
						if(!str[0].equals(""))sql.append(" 	  AND TEL_DATE LIKE '"+str[0]+"%'    \n");
						//logger.dbg.println(this,sql.toString());
						stmt = conn.getGauceStatement(sql.toString());

  	 				stmt.executeQuery(dSet);
					}
		
/*********************************************************************************************/

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