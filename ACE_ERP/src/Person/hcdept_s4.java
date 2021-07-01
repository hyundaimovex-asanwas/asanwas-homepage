package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class hcdept_s4 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601 ");
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
				
				String str1 = req.getParameter("v_str1"); //부서

				if (str1 == null) { str1 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM","DEPTNMK","DEPTNME","DEPTPRT",
																					"TREECD","FRDT","TODT","USEYN","REDTAXYN",
																					"LEVEL","DEPTGB"
																				};

				int[] intArrCN = new int[]{   5,  50,  70,  50,  4,
																	  	8,   8,   8,   1,  1,
																			1,   4
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( "  SELECT                                                                          \n ");
					sql.append( "  DEPTCD,rtrim(DEPTNM) as  DEPTNM, rtrim(DEPTNMK) as DEPTNMK, DEPTNME,DEPTPRT,    \n ");
					sql.append( "  TREECD,FRDT,TODT,USEYN,REDTAXYN,                                                \n ");
					sql.append( "  COALESCE(LEVEL,'9') LEVEL, DEPTGB                                               \n ");
					sql.append( "  FROM PAYROLL.HCDEPT                                                             \n ");
					sql.append( "  WHERE USEYN='T'                                                                 \n ");
					sql.append( "  AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                             \n ");
					sql.append( "  AND SUBSTR(TREECD,3,6)='000000'                                                 \n ");
          sql.append( "  UNION ALL                                                                       \n ");
					sql.append( "  --본부                                                                          \n ");
					sql.append( "  SELECT                                                                          \n ");
					sql.append( "  DEPTCD,rtrim(DEPTNM) as  DEPTNM, rtrim(DEPTNMK) as DEPTNMK, DEPTNME,DEPTPRT,    \n ");
					sql.append( "  TREECD,FRDT,TODT,USEYN,REDTAXYN,                                                \n ");
					sql.append( "  COALESCE(LEVEL,'9') LEVEL, DEPTGB                                               \n ");
					sql.append( "  FROM PAYROLL.HCDEPT                                                             \n ");
					sql.append( "  WHERE USEYN='T'                                                                 \n ");
					sql.append( "  AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                             \n ");
					sql.append( "  AND SUBSTR(TREECD,1,4)= (SELECT SUBSTR(TREECD,1,4) FROM PAYROLL.HCDEPT          \n ");
					sql.append( "                            WHERE DEPTCD= '"+str1+"'                              \n ");
					sql.append( "                              AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT))\n ");
					sql.append( "  AND SUBSTR(TREECD,5,4)='0000'                                                   \n ");
					sql.append( "  UNION ALL                                                                       \n ");
					sql.append( "  --부서/팀                                                                       \n ");
					sql.append( "  SELECT                                                                          \n ");
          sql.append( "  DEPTCD,rtrim(DEPTNM) as  DEPTNM, rtrim(DEPTNMK) as DEPTNMK, DEPTNME,DEPTPRT,    \n ");
					sql.append( "  TREECD,FRDT,TODT,USEYN,REDTAXYN,                                                \n ");
					sql.append( "  COALESCE(LEVEL,'9') LEVEL, DEPTGB                                               \n ");
					sql.append( "  FROM PAYROLL.HCDEPT                                                             \n ");
					sql.append( "  WHERE USEYN='T'                                                                 \n ");
					sql.append( "  AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                             \n ");
					sql.append( "  AND SUBSTR(TREECD,1,6)= (SELECT SUBSTR(TREECD,1,6) FROM PAYROLL.HCDEPT          \n ");
					sql.append( "                            WHERE DEPTCD= '"+str1+"'                              \n ");
					sql.append( "                              AND CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT))\n ");
					sql.append( "  ORDER BY TREECD                                                                 \n ");
					/*
					sql.append( " SELECT  \n ");
					sql.append( " rtrim(DEPTCD) AS DEPTCD,rtrim(DEPTNM) as  DEPTNM, rtrim(DEPTNMK) as DEPTNMK, DEPTNME,DEPTPRT, \n ");
					sql.append( " TREECD,FRDT,TODT,USEYN,REDTAXYN, \n ");
					sql.append( " COALESCE(LEVEL,'9') LEVEL, DEPTGB \n ");
					sql.append( " FROM PAYROLL.HCDEPT \n ");
          sql.append( " WHERE CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)  \n ");
					if(!str1.equals("")) { sql.append( " AND DEPTCD = '"+str1+"' \n "); }
					sql.append( " ORDER BY DEPTCD \n ");
          */

					
					logger.dbg.println(this,sql.toString());
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