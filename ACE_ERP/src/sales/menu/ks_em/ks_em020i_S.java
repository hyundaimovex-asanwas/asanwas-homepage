package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class ks_em020i_S extends HttpServlet {

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
				// logger.dbg.println(this, "start");
				
				String [] str = new String[1];
				str[0] =  req.getParameter("v_str1"); // 근무구분

				
		       for(int i=0;i<1;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "WORK_GB","USE_YN1","WKTM_GB1" ,"STDT_GB1" ,"START_DT1","EDDT_GB1","END_DT1","T_UNIT1","STPE_TM1","EDPE_TM1",
																		"USE_YN2","WKTM_GB2" ,"STDT_GB2" ,"START_DT2","EDDT_GB2","END_DT2","T_UNIT2","STPE_TM2","EDPE_TM2",
																		"USE_YN3","WKTM_GB3" ,"STDT_GB3" ,"START_DT3","EDDT_GB3","END_DT3","T_UNIT3","STPE_TM3","EDPE_TM3",
																		"USE_YN4","WKTM_GB4" ,"STDT_GB4" ,"START_DT4","EDDT_GB4","END_DT4","T_UNIT4","STPE_TM4","EDPE_TM4",
																		"DEDU_YN", "RETM1_FR", "RETM1_TO",  "RETM2_FR", "RETM2_TO","EMPNO"
																			}; //

				int[] intArrCN = new int[] {  1, 1, 1, 1, 4, 1, 4, 2, 2, 2 , 
																1, 1, 1, 4, 1, 4, 2, 2, 2,
																1, 1, 1, 4, 1, 4, 2, 2, 2,
																1, 1, 1, 4, 1, 4, 2, 2, 2, 
																1, 4, 4, 4, 4,10
																											}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
																-1,-1,-1,-1,-1,-1,-1,-1,-1,
																-1,-1,-1,-1,-1,-1,-1,-1,-1,
																-1,-1,-1,-1,-1,-1,-1,-1,-1,
																-1, -1, -1, -1, -1,-1
																											}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "SELECT X.WORK_GB,		 \n");
						sql.append( "       MAX(X.USE_YN1)USE_YN1, MAX(X.WKTM_GB1)WKTM_GB1,	MAX(X.STDT_GB1)STDT_GB1,     MAX(X.START_DT1)START_DT1,    MAX(X.EDDT_GB1)EDDT_GB1,    MAX(X.END_DT1)END_DT1,      MAX(X.T_UNIT1)T_UNIT1,      MAX(X.STPE_TM1)STPE_TM1,     MAX(X.EDPE_TM1)EDPE_TM1,   \n");
						sql.append( "       MAX(X.USE_YN2)USE_YN2, MAX(X.WKTM_GB2)WKTM_GB2,    MAX(X.STDT_GB2)STDT_GB2,      MAX(X.START_DT2)START_DT2,    MAX(X.EDDT_GB2)EDDT_GB2,     MAX(X.END_DT2)END_DT2,      MAX(X.T_UNIT2)T_UNIT2,      MAX(X.STPE_TM2)STPE_TM2,     MAX(X.EDPE_TM2)EDPE_TM2,   \n");
						sql.append( "       MAX(X.USE_YN3)USE_YN3, MAX(X.WKTM_GB3)WKTM_GB3,    MAX(X.STDT_GB3)STDT_GB3,      MAX(X.START_DT3)START_DT3,    MAX(X.EDDT_GB3)EDDT_GB3,     MAX(X.END_DT3)END_DT3,      MAX(X.T_UNIT3)T_UNIT3,      MAX(X.STPE_TM3)STPE_TM3,     MAX(X.EDPE_TM3)EDPE_TM3,  \n");
						sql.append( "       MAX(X.USE_YN4)USE_YN4, MAX(X.WKTM_GB4)WKTM_GB4,    MAX(X.STDT_GB4)STDT_GB4,      MAX(X.START_DT4)START_DT4,    MAX(X.EDDT_GB4)EDDT_GB4,     MAX(X.END_DT4)END_DT4,      MAX(X.T_UNIT4)T_UNIT4,      MAX(X.STPE_TM4)STPE_TM4,     MAX(X.EDPE_TM4)EDPE_TM4,  \n");
						sql.append( "		MAX(X.DEDU_YN)DEDU_YN, MAX(X.RETM1_FR)RETM1_FR,      MAX(X.RETM1_TO)RETM1_TO ,    MAX(X.RETM2_FR)RETM2_FR,     MAX(X.RETM2_TO)RETM2_TO , ''EMPNO \n");
						sql.append( "FROM(   \n");
						sql.append( "SELECT A.WORK_GB, Y.DEDU_YN,  Y.RETM1_FR,  Y.RETM1_TO,  Y.RETM2_FR,  Y.RETM2_TO,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.USE_YN   ELSE '' END USE_YN1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.WKTM_GB  ELSE '' END WKTM_GB1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.STDT_GB  ELSE '' END STDT_GB1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.START_DT ELSE '' END START_DT1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.EDDT_GB  ELSE '' END EDDT_GB1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.END_DT   ELSE '' END END_DT1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.T_UNIT   ELSE '' END T_UNIT1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.STPE_TM  ELSE '' END STPE_TM1,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='1' THEN A.EDPE_TM  ELSE '' END EDPE_TM1,   \n");

						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.USE_YN  ELSE ''  END USE_YN2,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.WKTM_GB  ELSE '' END WKTM_GB2,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.STDT_GB  ELSE '' END STDT_GB2,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.START_DT ELSE '' END START_DT2,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.EDDT_GB  ELSE '' END EDDT_GB2,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.END_DT   ELSE '' END END_DT2,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.T_UNIT   ELSE '' END T_UNIT2,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.STPE_TM  ELSE '' END STPE_TM2,  \n");  
						sql.append( "       CASE WHEN A.WKTM_GB ='2' THEN A.EDPE_TM  ELSE '' END EDPE_TM2,   \n");

						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.USE_YN  ELSE ''  END USE_YN3,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.WKTM_GB  ELSE '' END WKTM_GB3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.STDT_GB  ELSE '' END STDT_GB3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.START_DT ELSE '' END START_DT3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.EDDT_GB  ELSE '' END EDDT_GB3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.END_DT   ELSE '' END END_DT3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.T_UNIT   ELSE '' END T_UNIT3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.STPE_TM  ELSE '' END STPE_TM3,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='3' THEN A.EDPE_TM  ELSE '' END EDPE_TM3,  \n");

						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.USE_YN  ELSE '' END USE_YN4,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.WKTM_GB  ELSE '' END WKTM_GB4,   \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.STDT_GB  ELSE '' END STDT_GB4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.START_DT ELSE '' END START_DT4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.EDDT_GB  ELSE '' END EDDT_GB4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.END_DT   ELSE '' END END_DT4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.T_UNIT   ELSE '' END T_UNIT4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.STPE_TM  ELSE '' END STPE_TM4,  \n");
						sql.append( "       CASE WHEN A.WKTM_GB ='4' THEN A.EDPE_TM  ELSE '' END EDPE_TM4  \n");

						sql.append( "	      FROM SALES.KST110  A \n");
						sql.append( "			  LEFT OUTER JOIN SALES.KST120 Y ON A.WORK_GB = Y.WORK_GB    \n");
						sql.append( "		)X		\n");
						sql.append( "	   WHERE 1=1                                                           \n");						
						sql.append( "	AND X.WORK_GB = '"+str[0]+"'   \n");
						sql.append( "	    GROUP BY X.WORK_GB  \n");


						logger.dbg.println(this, sql.toString());
						
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