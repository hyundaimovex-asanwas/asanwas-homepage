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
public class h080003_s1 extends HttpServlet {

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
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM",
																					"T1","T2","T3","T4","T5","T6","T7",					"T8",
																					"T9","T10","T11","T12","T13","T14","T15",		"T16",
																					"T17","T18","T19","T20","T21","T22","T23",	"T24",
																					"T25"
																				};

				int[] intArrCN = new int[]{  4, 30,  
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5,  5
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  
																			0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																			0,  0,  0,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																																														 \n");
					sql.append( " 	S.DEPTCD, T.DEPTNM,    																																					 \n");
					sql.append( " 		SUM(S.T1)  AS  T1, SUM(S.T2)  AS  T2, SUM(S.T3)  AS  T3, SUM(S.T4)  AS  T4, SUM(S.T5)  AS  T5, \n");
					sql.append( " 		SUM(S.T6)  AS  T6, SUM(S.T7)  AS  T7, SUM(S.T8)  AS  T8,																			 \n");			
					sql.append( " 		SUM(S.T9)  AS  T9, SUM(S.T10) AS T10, SUM(S.T11) AS T11, SUM(S.T12) AS T12, SUM(S.T13) AS T13, \n");
					sql.append( " 		SUM(S.T14) AS T14, SUM(S.T15) AS T15, SUM(S.T16) AS T16,																			 \n");
					sql.append( " 		SUM(S.T17) AS T17, SUM(S.T18) AS T18, SUM(S.T19) AS T19, SUM(S.T20) AS T20, SUM(S.T21) AS T21, \n");
					sql.append( " 		SUM(S.T22) AS T22, SUM(S.T23) AS T23, SUM(S.T24) AS T24,																		   \n");
					sql.append( " 		SUM(S.T8)+SUM(S.T16)+SUM(S.T24) AS T25																												 \n");
					sql.append( " FROM																																															 \n");
					sql.append( "  (																																																 \n");
					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " COUNT(A.PAYGRD) AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																		     \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('00','01','02','03','04','05','06','07','08','10','12')										     \n");
					sql.append( " AND A.USESTS <> '3'             																																   \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV     																																	 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, COUNT(A.PAYGRD) AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																		     \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('14','15','16','17')    																												 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																	   \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, COUNT(A.PAYGRD) AS T3, 0 AS T4, 0 AS T5,																		     \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('18','19')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																	   \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, COUNT(A.PAYGRD) AS T4, 0 AS T5,																		     \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('20','21')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																	   \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, COUNT(A.PAYGRD) AS T5,																		     \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('22','23')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " COUNT(A.PAYGRD) AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																		     \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('24','25','26','27','28','29')    																							 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																	   \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, COUNT(A.PAYGRD) AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																		     \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD NOT IN ('00','01','02','03','04','05','06','07','08','10','12','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29') \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 3 THEN 1 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4,0 AS T5,																											   \n");
					sql.append( " 0 AS T6, 0 AS T7, COUNT(A.PAYGRD) AS T8, 0 AS T9, 0 AS T10,																		     \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.USESTS <> '3'    																																					 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('3')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					//기술직이면서 부서별 직군현황
					//[변경] 파견 계약직의 부서별 직군현황 6가지 변경
					//[변경] 입사구분[EMPDIV] 3:기능직/4:파견직/5:재중통포 속한것 조회 조건
					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, COUNT(A.PAYGRD) AS T9, 0 AS T10,																		     \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('00','01','02','03','04','05','06','07','08','10','12')										     \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, COUNT(A.PAYGRD) AS T10,																		     \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('14','15','16','17')    																												 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " COUNT(A.PAYGRD) AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('18','19')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, COUNT(A.PAYGRD) AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('20','21')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, COUNT(A.PAYGRD) AS T13, 0 AS T14, 0 AS T15, 0 AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('22','23')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, COUNT(A.PAYGRD) AS T14, 0 AS T15, 0 AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('24','25','26','27','28','29')																									 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, COUNT(A.PAYGRD) AS T15, 0 AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD NOT IN ('00','01','02','03','04','05','06','07','08','10','12','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29') \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 4 THEN 2 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, COUNT(A.PAYGRD) AS T16,    											 \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.USESTS <> '3'    																																					 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('4')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					//기술직이면서 부서별 직군현황
					//[변경] 재중동포 부서별 직군현황 6가지 변경
					//[변경] 입사구분[EMPDIV] 3:기능직/4:파견직/5:재중통포 속한것 조회 조건
					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15,0 AS T16,																		     \n");
					sql.append( " COUNT(A.PAYGRD) AS T17,0 AS T18, 0 AS T19, 0 AS T20,    																					 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('00','01','02','03','04','05','06','07','08','10','12')										     \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17,COUNT(A.PAYGRD) AS T18, 0 AS T19, 0 AS T20,    																					 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('14','15','16','17')    																												 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, COUNT(A.PAYGRD) AS T19, 0 AS T20,    																					 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('18','19')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, COUNT(A.PAYGRD) AS T20,    																					 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, 0 AS T24																														 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																				   \n");
					sql.append( " WHERE A.PAYGRD IN ('20','21')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " COUNT(A.PAYGRD) AS T21, 0 AS T22, 0 AS T23, 0 AS T24    																					 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																			   \n");
					sql.append( " WHERE A.PAYGRD IN ('22','23')    																																	 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, COUNT(A.PAYGRD) AS T22, 0 AS T23, 0 AS T24    																					 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																			   \n");
					sql.append( " WHERE A.PAYGRD IN ('24','25','26','27','28','29')																									 \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, COUNT(A.PAYGRD) AS T23, 0 AS T24    																					 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																			   \n");
					sql.append( " WHERE A.PAYGRD NOT IN ('00','01','02','03','04','05','06','07','08','10','12','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29') \n");
					sql.append( " AND A.USESTS <> '3'    																																						 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " UNION ALL             																																             \n");

					sql.append( " SELECT A.DEPTCD,																																									 \n");
					sql.append( " CASE INTEGER(RTRIM(A.EMPDIV)) WHEN 5 THEN 3 END AS EMPDIV,																		     \n");
					sql.append( " 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5,																											 \n");
					sql.append( " 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10,																											 \n");
					sql.append( " 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16,																		     \n");
					sql.append( " 0 AS T17, 0 AS T18, 0 AS T19, 0 AS T20,																														 \n");
					sql.append( " 0 AS T21, 0 AS T22, 0 AS T23, COUNT(A.PAYGRD) AS T24    																					 \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A																																			   \n");
					sql.append( " WHERE A.USESTS <> '3'    																																					 \n");
					sql.append( " AND RTRIM(A.EMPDIV) IN ('5')    																																	 \n");
					sql.append( " GROUP BY A.DEPTCD, A.EMPDIV    																																		 \n");
					sql.append( " ) S    																																														 \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT T ON S.DEPTCD = T.DEPTCD																						 \n");
					sql.append( " GROUP BY S.DEPTCD, T.DEPTNM																																				 \n");

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