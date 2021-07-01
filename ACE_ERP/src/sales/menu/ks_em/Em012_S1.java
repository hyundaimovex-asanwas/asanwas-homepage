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
public class Em012_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //기준일        
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //직종          
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //근무업체      
				String  str4	= req.getParameter("v_str4"); if (str4 == null) { str4 = ""; } //부서          
				String  str5	= req.getParameter("v_str5"); if (str5 == null) { str5 = ""; } //소속팀        
				String  str6	= req.getParameter("v_str6"); if (str6 == null) { str6 = ""; } //근무지        
				String  str7	= req.getParameter("v_str7"); if (str7 == null) { str7 = ""; } //현재시스템날짜
				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ 
																					"YYYYMM","SEQ","CUST_SID","VEND_CD","DEPT_CD","TEAM_CD","JOB_CD",//7
																					"TO_MCNT","TO_FCNT","TO_CNT",
																					"CUR_MCNT","CUR_FCNT","CUR_CNT",
																					"ARR_MCNT","ARR_FCNT","ARR_CNT",
																					"HOL_MCNT","HOL_FCNT","HOL_CNT",
																					"BAK_MCNT","BAK_FCNT","BAK_CNT",
																					"SKM_MCNT","SKM_FCNT","SKM_CNT",
																					"CHO_MCNT","CHO_FCNT","CHO_CNT",
																					 "I_EMPNO","U_EMPNO","I_DATE","U_DATE"
																			  }; //32

				int[] intArrCN = new int[] { 
																					6, 2, 10, 10, 5, 5, 5,
																					4, 4, 4,
																					4, 4, 4,
																					4, 4, 4,
																					4, 4, 4,
																					4, 4, 4,
																					4, 4, 4,
																					4, 4, 4,
																					10, 10, 10, 10
																			}; 
			
				int[] intArrCN2 = new int[]{
                                          -1, 0, 0, 0, -1, -1, -1,
                                           0, 0, 0,
                                           0, 0, 0,
                                           0, 0, 0,
                                           0, 0, 0,
                                           0, 0, 0,
                                           0, 0, 0,
                                           0, 0, 0,
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
						sql.append( "	 SELECT  A.YYYYMM, A.SEQ,0 CUST_SID, A.VEND_CD,  A.DEPT_CD, A.TEAM_CD, A.JOB_CD,                                                           \n");
						sql.append( "	         IFNULL(A.TO_MAN,0) AS TO_MCNT,    IFNULL(A.TO_WOM,0) AS TO_FCNT,      IFNULL(A.TO_MAN,0)+IFNULL(A.TO_WOM,0) AS TO_CNT,            \n");
						sql.append( "	         IFNULL(B.CUR_MCNT,0) AS CUR_MCNT, IFNULL(B.CUR_FCNT,0) AS CUR_FCNT,   IFNULL(B.CUR_MCNT,0)+IFNULL(B.CUR_FCNT,0) AS CUR_CNT,       \n");
						sql.append( "	         IFNULL(A.ARR_MAN,0) AS ARR_MCNT,  IFNULL(A.ARR_WOM,0) AS ARR_FCNT,    IFNULL(A.ARR_MAN,0)+IFNULL(A.ARR_WOM,0) AS ARR_CNT,         \n");
						sql.append( "	         IFNULL(C.HOL_MCNT,0) AS HOL_MCNT, IFNULL(C.HOL_FCNT,0) AS HOL_FCNT,   IFNULL(C.HOL_MCNT,0)+IFNULL(C.HOL_FCNT,0) AS HOL_CNT,       \n");
						sql.append( "	         IFNULL(A.BAK_MAN,0) AS BAK_MCNT,  IFNULL(A.BAK_WOM,0) AS BAK_FCNT,    IFNULL(A.BAK_MAN,0)+IFNULL(A.BAK_WOM,0) AS BAK_CNT,         \n");
						sql.append( "	         0 AS SKM_MCNT,       0 AS SKM_FCNT,         0 AS SKM_CNT,                                                                         \n");
						sql.append( "	         0 AS CHO_MCNT,       0 AS CHO_FCNT,         0 AS CHO_CNT,                                                                         \n");
						sql.append( "	         A.I_EMPNO,    A.U_EMPNO,    A.I_DATE,    A.U_DATE                                                                                 \n");
						sql.append( "	   FROM SALES.TCM320 A                                                                                                                     \n");
						sql.append( "	   LEFT JOIN ( SELECT X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD,                                                                           \n");
						sql.append( "	                 CASE WHEN Y.SEX ='M' THEN COUNT(*) ELSE 0 END AS CUR_MCNT,  --현재원                                                      \n");
						sql.append( "	                 CASE WHEN Y.SEX ='F' THEN COUNT(*) ELSE 0 END AS CUR_FCNT                                                                 \n");
						sql.append( "	                 FROM SALES.TCM300 X                                                                                     \n");
						sql.append( "	                 LEFT JOIN SALES.TCU010 Y ON X.CUST_SID = Y.CUST_SID                                                                                      \n");
						sql.append( "	                WHERE 1=1                                                                                             \n");
						sql.append( "	                  AND X.USESTS='1'                                                                                                         \n");
						sql.append( "	                  AND X.START_DT <='"+str7+"'                                                                                              \n");
						sql.append( "	                  AND NOT EXISTS ( SELECT EMPNO                                                                                            \n");
						sql.append( "	                                     FROM SALES.TCM355 Z                                                                                   \n");
						sql.append( "	                                    WHERE Z.EMPNO = X.EMPNO                                                                                \n");
						sql.append( "	                                      AND ('"+str7+"'>=Z.START_DT AND '"+str7+"'<=Z.END_DT)                                                \n");
						sql.append( "	                                 )                                                                                                         \n");
						sql.append( "	                GROUP BY X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD,Y.SEX                                                                   \n");
						sql.append( "	            ) B ON A.VEND_CD = B.VEND_CD                                                                                                   \n");
						sql.append( "	               AND A.DEPT_CD = B.DEPT_CD                                                                                                   \n");
						sql.append( "	               AND A.TEAM_CD = B.TEAM_CD                                                                                                   \n");
						sql.append( "	               AND A.JOB_CD = B.JOB_CD                                                                                                     \n");
						sql.append( "	               AND A.YYYYMM = '200802'                                                                                                     \n");
						sql.append( "	    LEFT JOIN ( SELECT X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD,                                                                          \n");
						sql.append( "	                  CASE WHEN Y.SEX ='M' THEN COUNT(*) ELSE 0 END AS HOL_MCNT,   --휴가자                                                    \n");
						sql.append( "	                  CASE WHEN Y.SEX ='F' THEN COUNT(*) ELSE 0 END AS HOL_FCNT                                                                \n");
						sql.append( "	                  FROM SALES.TCM355 Z,  SALES.TCM300 X                                                                      \n");
						sql.append( "	                  LEFT JOIN SALES.TCU010 Y ON   Z.CUST_SID = Y.CUST_SID                                                                      \n");
						sql.append( "	                 WHERE 1=1                                                                                           \n");
						sql.append( "	                   AND Z.CUST_SID = X.CUST_SID                                                                                             \n");
						sql.append( "	                   AND X.USESTS='1'                                                                                                        \n");
						sql.append( "	                   AND ('"+str7+"'>=Z.START_DT AND '"+str7+"'<Z.END_DT)                                                                    \n");
						sql.append( "	                 GROUP BY X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD, Y.SEX                                                                  \n");
						sql.append( "	            ) C ON A.VEND_CD = C.VEND_CD                                                                                                   \n");
						sql.append( "	               AND A.DEPT_CD = C.DEPT_CD                                                                                                   \n");
						sql.append( "	               AND A.TEAM_CD = C.TEAM_CD                                                                                                   \n");
						sql.append( "	               AND A.JOB_CD = C.JOB_CD                                                                                                     \n");
						sql.append( "	               AND A.YYYYMM = '"+str1+"'                                                                                                      \n");
						if(!str1.equals(""))sql.append( "	WHERE A.YYYYMM = '"+str1+"'   \n");
						if(!str2.equals(""))sql.append( "	  AND A.JOB_CD = '"+str2+"'   \n");
						if(!str3.equals(""))sql.append( "	  AND A.VEND_CD = '"+str3+"'  \n");
						if(!str4.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str4+"'  \n");
						if(!str5.equals(""))sql.append( "	  AND A.TEAM_CD = '"+str5+"'  \n");
						//if(!str6.equals(""))sql.append( "	  AND WORK_CD = '"+str6+"'  \n");
						sql.append( "	ORDER BY A.SEQ ASC     \n");
						logger.dbg.println(this,"sql::"+sql.toString());
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