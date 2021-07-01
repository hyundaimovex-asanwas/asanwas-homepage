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
public class Em012_S2 extends HttpServlet {

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

						sql.append( "	SELECT '"+str1+"'YYYYMM,                                                    \n");
						sql.append( "	       1 SEQ,                                                               \n");
						sql.append( "        IFNULL(MAX(X.CUST_SID),0)CUST_SID,                                   \n");
						sql.append( "	        X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD,                          \n");
						sql.append( "	       IFNULL(SUM(X.TO_MCNT),0)TO_MCNT, IFNULL(SUM(X.TO_FCNT),0)TO_FCNT,    \n");
						sql.append( "	       IFNULL(SUM(X.TO_CNT),0)TO_CNT,                                       \n");
						sql.append( "	       IFNULL(SUM(X.CUR_MCNT),0)CUR_MCNT,         \n");
						sql.append( "	       IFNULL(SUM(X.CUR_FCNT),0)CUR_FCNT,         \n");
						sql.append( "	       (IFNULL(SUM(X.CUR_MCNT),0)+IFNULL(SUM(X.CUR_FCNT),0)) CUR_CNT,       \n");
						sql.append( "	       IFNULL(SUM(X.ARR_MCNT),0)ARR_MCNT,IFNULL(SUM(X.ARR_FCNT),0)ARR_FCNT, \n");
						sql.append( "	       IFNULL(SUM(X.ARR_CNT),0)ARR_CNT,                                     \n");
						sql.append( "	       IFNULL(SUM(X.HOL_MCNT),0)HOL_MCNT,IFNULL(SUM(X.HOL_FCNT),0)HOL_FCNT, \n");
						sql.append( "	       (IFNULL(SUM(X.HOL_MCNT),0)+IFNULL(SUM(X.HOL_FCNT),0))HOL_CNT,        \n");
						sql.append( "	       IFNULL(SUM(X.SKM_MCNT),0)SKM_MCNT,IFNULL(SUM(X.SKM_FCNT),0)SKM_FCNT, \n");
						sql.append( "	       IFNULL(SUM(X.SKM_CNT),0)SKM_CNT,                                     \n");
						sql.append( "	       IFNULL(SUM(X.BAK_MCNT),0)BAK_MCNT,IFNULL(SUM(X.BAK_FCNT),0)BAK_FCNT, \n");
						sql.append( "	       IFNULL(SUM(X.BAK_CNT),0)BAK_CNT,                                     \n");
						sql.append( "	       IFNULL(SUM(X.CHO_MCNT),0)CHO_MCNT,IFNULL(SUM(X.CHO_FCNT),0)CHO_FCNT, \n");
						sql.append( "	       IFNULL(SUM(CHO_CNT),0)CHO_CNT,                                       \n");
						sql.append( "	       ''I_EMPNO,''U_EMPNO,''I_DATE,''U_DATE                                \n");
						sql.append( "	FROM(                                                                       \n");
/*현재인원*/sql.append( "	SELECT A.VEND_CD, A.DEPT_CD, A.TEAM_CD, A.JOB_CD,                           \n");
						sql.append( "	       0 TO_MCNT, 0 TO_FCNT, 0 TO_CNT,                                      \n");
						sql.append( "	       CASE WHEN B.SEX ='M' THEN COUNT(*) ELSE 0 END AS CUR_MCNT,           \n");
						sql.append( "	       CASE WHEN B.SEX ='F' THEN COUNT(*) ELSE 0 END AS CUR_FCNT,           \n");
						sql.append( "	       0 CUR_CNT,                                                           \n");
						sql.append( "	       0 ARR_MCNT, 0 ARR_FCNT, 0 ARR_CNT,                                   \n");
						sql.append( "	       0 HOL_MCNT, 0 HOL_FCNT, 0 HOL_CNT,                                   \n");
						sql.append( "	       0 SKM_MCNT, 0 SKM_FCNT, 0 SKM_CNT,                                   \n");
						sql.append( "	       0 BAK_MCNT, 0 BAK_FCNT, 0 BAK_CNT,                                   \n");
						sql.append( "	       0 CHO_MCNT, 0 CHO_FCNT, 0 CHO_CNT,                                   \n");
						sql.append( "	       ''I_EMPNO,''U_EMPNO,''I_DATE,''U_DATE ,A.CUST_SID                    \n");
						sql.append( "	  FROM SALES.TCM300 A                                    \n");
						sql.append( "	  LEFT JOIN SALES.TCU010 B ON A.CUST_SID = B.CUST_SID                        \n");
						sql.append( "	 WHERE 1=1                                            \n");
						sql.append( "	   AND A.USESTS='1'                                                         \n");
						sql.append( "	   AND A.START_DT <='"+str7+"'                                              \n");
						sql.append( "	   AND NOT EXISTS ( SELECT EMPNO                                            \n");
						sql.append( "	   									FROM SALES.TCM355 C                                     \n");
						sql.append( "	   								 WHERE C.EMPNO = A.EMPNO                                  \n");
						sql.append( "	   									 AND ('"+str7+"'>=C.START_DT AND '"+str7+"'<=C.END_DT)  \n");
						sql.append( "	   							  )                                                         \n");
            if(!str6.equals(""))sql.append( "	   AND A.WORK_CD = '"+str6+"'      \n");					
						sql.append( "	 GROUP BY A.VEND_CD, A.DEPT_CD, A.TEAM_CD, A.JOB_CD,B.SEX ,A.CUST_SID \n");
						sql.append( "	UNION ALL                                                                   \n");
/*휴가인원*/sql.append( "	SELECT A.VEND_CD, A.DEPT_CD, A.TEAM_CD, A.JOB_CD,                           \n");
						sql.append( "	       0 TO_MCNT, 0 TO_FCNT, 0 TO_CNT,                                      \n");
						sql.append( "	       0 CUR_MCNT, 0 CUR_FCNT, 0 CUR_CNT,                                   \n");
						sql.append( "	       0 ARR_MCNT, 0 ARR_FCNT, 0 ARR_CNT,                                   \n");
						sql.append( "	       CASE WHEN B.SEX ='M' THEN COUNT(*) ELSE 0 END AS HOL_MCNT,           \n");
						sql.append( "	       CASE WHEN B.SEX ='F' THEN COUNT(*) ELSE 0 END AS HOL_FCNT,           \n");
						sql.append( "	       0 HOL_CNT,                                                           \n");
						sql.append( "	       0 SKM_MCNT, 0 SKM_FCNT, 0 SKM_CNT,                                   \n");
						sql.append( "	       0 BAK_MCNT, 0 BAK_FCNT, 0 BAK_CNT,                                   \n");
						sql.append( "	       0 CHO_MCNT, 0 CHO_FCNT, 0 CHO_CNT,                                   \n");
						sql.append( "	       ''I_EMPNO,''U_EMPNO,''I_DATE,''U_DATE ,A.CUST_SID                    \n");
						sql.append( "	  FROM SALES.TCM355 C,                                    \n");
						sql.append( "	       SALES.TCM300 A                                                       \n");
						sql.append( "	  LEFT JOIN SALES.TCU010 B ON C.CUST_SID = B.CUST_SID                       \n");
						sql.append( "	 WHERE 1=1                                              \n");
						sql.append( "	   AND C.CUST_SID = A.CUST_SID                                              \n");
						sql.append( "	   AND A.USESTS ='1'                                                        \n");
						sql.append( "	   AND ('"+str7+"'>=C.START_DT AND '"+str7+"'<=C.END_DT)                    \n");
						if(!str6.equals(""))sql.append( "	   AND A.WORK_CD = '"+str6+"'      \n");
						sql.append( "	GROUP BY A.VEND_CD, A.DEPT_CD, A.TEAM_CD, A.JOB_CD,B.SEX ,A.CUST_SID        \n");
						sql.append( "	)X                                                                          \n");
						sql.append( "	GROUP BY X.VEND_CD, X.DEPT_CD, X.TEAM_CD, X.JOB_CD                          \n");
						sql.append( "	HAVING 1=1               \n");

						if(!str2.equals(""))sql.append( "	   AND JOB_CD = '"+str2+"'      \n");
						if(!str3.equals(""))sql.append( "	   AND VEND_CD = '"+str3+"'      \n"); 
						if(!str4.equals(""))sql.append( "	   AND DEPT_CD = '"+str4+"'      \n");
						if(!str5.equals(""))sql.append( "	   AND TEAM_CD = '"+str5+"'      \n");

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