package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em023_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";}
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";}
				String  str4	= req.getParameter("v_str4"); if (str4==null) {str4="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PAY_YM",  "PAY_DIV",   "EMPNO",  "EMPNMK",     "START_DT",
                                          "END_DT",  "AGENCY_CD", "H_DAY",  "W_DAY1",     "W_DAY2",
                                          "B_PAY1",  "B_PAY2",    "O_TIME", "BASIC_TOT",  "O_TIME_TOT",
                                          "SEN_PAY", "AIR_PAY",   "B20_PAY","BON_PAY",    "LST_PAY",
                                          "RET_PAY", "TEL_PAY",   "ADV_PAY","TELUBO_PAY", "ETC_PAY",
                                          "TELSAVE_PAY","PAY_DT", "TEAM_CD","PAY_SUM",    "DEDUCT_SUM",
                                          "REAL_PAY_SUM", "PASS_NO","SEX",  "JOB_CD",     "JOB_NM",     
					                                "MM",      "W_DAY",     "DEPT_NM","TEAM_NM",    "WORK_NM"
																			}; 

				int[] intArrCN = new int[] {    6,  1,  10,  30,  8,
                                        8,  3, 	 3,		3,	3,
																			 10,	10,  5, 10,  10,
																			 10,	10,	 10, 10, 10,
																			 10,	10,  10, 10, 10,
																			 10,   8,		5, 10, 10,
																			 10,  20,   2,  5, 50,
					                              2,   2,  50, 50, 50 
																			}; 
			
				int[] intArrCN2 = new int[]{   -1, -1, -1, -1, -1,
																		   -1, -1,  1,	1,	1,//10
																				2,	2,	2,  2,  2,
																				2,	2,	2,	2,  2,
																				2,	2,	2,	2,  2,
																				2, -1, -1,	2,  2,
																				2, -1, -1, -1, -1,
                                       -1,  0, -1, -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  A.PAY_YM, A.PAY_DIV, A.EMPNO,  B.EMPNMK,  IFNULL(B.START_DT,'') AS START_DT,                             \n");
						sql.append( "					IFNULL(B.END_DT,'') AS END_DT, B.AGENCY_CD,  A.H_DAY,  A.W_DAY1, A.W_DAY2,                               \n");
						sql.append( "					A.B_PAY1, A.B_PAY2, (A.O_TIME1 + A.O_TIME2) O_TIME,  A.BASIC_TOT,  A.O_TIME_TOT,                         \n");
						sql.append( "					A.SEN_PAY,  A.AIR_PAY,  A.B20_PAY,  A.BON_PAY, A.LST_PAY,                                                \n");
						sql.append( "					A.RET_PAY,  A.TEL_PAY,  A.ADV_PAY,  A.TELUBO_PAY,  A.ETC_PAY,                                            \n");
						sql.append( "					A.TELSAVE_PAY,  A.PAY_DT,  A.TEAM_CD,  A.PAY_SUM,  A.DEDUCT_SUM,                                         \n");
						sql.append( "					A.REAL_PAY_SUM , A.PASS_NO,                                                                              \n");
						sql.append( "					CASE WHEN C.SEX ='M' THEN '남'                                                                           \n");
						sql.append( "							 WHEN C.SEX ='F' THEN '여' ELSE '' END SEX,                                                          \n");
						sql.append( "					A.JOB_CD, D.DETAIL_NM AS JOB_NM, SUBSTR(A.PAY_YM,5,2)MM ,(W_DAY1+W_DAY2)W_DAY,                           \n");
						sql.append( "         E.DETAIL_NM AS DEPT_NM, F.DETAIL_NM AS TEAM_NM, G.DETAIL_NM AS WORK_NM                                   \n");
						sql.append( "		FROM SALES.TCM400 A                                                                                            \n");
						sql.append( "		LEFT OUTER JOIN SALES.TCM300 B ON A.EMPNO=B.EMPNO                                                              \n");
						sql.append( "		LEFT OUTER JOIN SALES.TCU010 C ON A.CUST_SID=C.CUST_SID                                                        \n");
						sql.append( "		LEFT OUTER JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.JOB_CD) AND D.HEAD='CM004' AND RTRIM(D.DETAIL)<>'' \n");    
						sql.append( "   LEFT OUTER JOIN SALES.TSY010 E ON TRIM(E.DETAIL)=TRIM(A.DEPT_CD) AND E.HEAD='CM006' AND TRIM(E.DETAIL)<>'' \n"); 
						sql.append( "   LEFT OUTER JOIN SALES.TSY010 F ON TRIM(F.DETAIL)=TRIM(A.TEAM_CD) AND F.HEAD='CM003' AND TRIM(F.DETAIL)<>'' \n");
						sql.append( "   LEFT OUTER JOIN SALES.TSY010 G ON TRIM(G.DETAIL)=TRIM(A.WORK_CD) AND G.HEAD='CM007' AND TRIM(G.DETAIL)<>'' \n");
						sql.append( "	WHERE 1=1                        \n");
						if(!str1.equals(""))sql.append( "	AND A.PAY_YM = '"+str1+"'        \n");
						if(!str2.equals(""))sql.append( "	AND A.PAY_DIV = '"+str2+"'       \n");
						if(!str3.equals(""))sql.append( "	AND A.TEAM_CD = '"+str3+"'       \n");
						if(!str4.equals(""))sql.append( "	AND A.EMPNO = '"+str4+"'         \n");
						sql.append( "	ORDER BY A.EMPNO                 \n");

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