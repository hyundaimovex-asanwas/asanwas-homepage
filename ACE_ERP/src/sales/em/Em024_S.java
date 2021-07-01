package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em024_S extends HttpServlet {

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
				String  str5	= req.getParameter("v_str5"); if (str5==null) {str5="";}
				String  str6	= req.getParameter("v_str6"); if (str6==null) {str6="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
                                          "PAY_YM","PAY_DT","PAY_DIV","EMPNO","CUST_SID",
                                          "VEND_CD","DEPT_CD","TEAM_CD","WORK_CD","JOB_CD",
                                          "SKILL_CD","CON_YEAR","B_PAY1","B_PAY2","T_PAY1",
                                          "T_PAY2","H_DAY","W_DAY1","W_DAY2","O_TIME",
                                          "O_TIME_TOT","BASIC_TOT","RET_PAY","SEN_PAY","AIR_PAY",
                                          "B20_PAY","BON_PAY","LST_PAY","TEL_PAY","ADV_PAY",
                                          "TELUBO_PAY","TELSAVE_PAY","ETC_PAY","EX_AIR_PAY","SND_PAY",
                                          "EMPNMK","SEX","PASS_NO","AGENCY_CD","VEND_NM",
                                          "DEPT_NM","TEAM_NM","WORK_NM","JOB_NM","SKILL_NM",
                                          "CON_YEAR_NM" , "START_DT" , "B_PAY0", "O_TIME1","O_TIME2",
																					"AGENCY_NM", "PAY_SUM","DEDUCT_SUM","REAL_PAY_SUM"
																			  };

				int[] intArrCN = new int[] { 
                                            6, 8, 1, 10,10,
                                            10,5, 5, 5, 5,
                                            3, 2, 10,10,7,
                                            7, 3, 3, 3, 5,
                                            10,10,10,10,10,
                                            10,10,10,10,10,
                                            10,10,10,10,10,
                                            40,2, 20,3,20,
                                            20,20,20,20,20,
                                            20,8, 7, 10, 10,
                                            20,10,10,10 

																			}; 
			
				int[] intArrCN2 = new int[]{
                                            -1,-1,-1,-1,-1,
                                             0,-1,-1,-1,-1,
                                            -1, 0, 0, 0, 2,
                                             2, 1, 1, 1, 2,
                                             2, 2, 2, 2, 2,
                                             2, 2, 2, 2, 2,
                                             2, 2, 2, 2, 2,
                                            -1,-1,-1,-1,-1,
                                            -1,-1,-1,-1,-1,
                                            -1,-1, 0, 2, 2,
																						-1, 2, 2, 2
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

                    sql.append( "	SELECT         \n");
                    sql.append( "	A.PAY_YM,      \n");
                    sql.append( "	A.PAY_DT,      \n");
                    sql.append( "	A.PAY_DIV,     \n");
                    sql.append( "	A.EMPNO,       \n");
                    sql.append( "	A.CUST_SID,    \n");
                    sql.append( "	A.VEND_CD,     \n");
                    sql.append( "	A.DEPT_CD,     \n");
                    sql.append( "	A.TEAM_CD,     \n");
                    sql.append( "	A.WORK_CD,     \n");
                    sql.append( "	A.JOB_CD,      \n");
                    sql.append( "	A.SKILL_CD,    \n");
                    sql.append( "	A.CON_YEAR,    \n");
                    sql.append( "	A.B_PAY1,      \n");
                    sql.append( "	A.B_PAY2,      \n");
                    sql.append( "	A.T_PAY1,      \n");
                    sql.append( "	A.T_PAY2,      \n");
                    sql.append( "	A.H_DAY,       \n");
                    sql.append( "	A.W_DAY1,      \n");
                    sql.append( "	A.W_DAY2,      \n");
                    sql.append( "	A.O_TIME1+A.O_TIME2 AS O_TIME,      \n");
                    sql.append( "	A.O_TIME_TOT,  \n");
                    sql.append( "	A.BASIC_TOT,   \n");
                    sql.append( "	A.RET_PAY,     \n");
                    sql.append( "	A.SEN_PAY,     \n");
                    sql.append( "	A.AIR_PAY,     \n");
                    sql.append( "	A.B20_PAY,     \n");
                    sql.append( "	A.BON_PAY,     \n");
                    sql.append( "	A.LST_PAY,     \n");
                    sql.append( "	A.TEL_PAY,     \n");
                    sql.append( "	A.ADV_PAY,     \n");
                    sql.append( "	A.TELUBO_PAY,  \n");
                    sql.append( "	A.TELSAVE_PAY, \n");
                    sql.append( "	A.ETC_PAY,     \n");
                    sql.append( "	A.EX_AIR_PAY,  \n");
                    sql.append( "	A.SND_PAY,     \n");
                    sql.append( "	B.EMPNMK,      \n");
                    sql.append( "	CASE WHEN C.SEX ='M' THEN '남' WHEN C.SEX='F' THEN '여' ELSE '' END SEX, \n");
                    sql.append( "	A.PASS_NO,     \n");
                    sql.append( "	B.AGENCY_CD,   \n");
										sql.append( "	D.DETAIL_NM AS VEND_NM, \n");
                    sql.append( "	E.DETAIL_NM AS DEPT_NM, \n");
                    sql.append( "	F.DETAIL_NM AS TEAM_NM, \n");
                    sql.append( "	G.DETAIL_NM AS WORK_NM, \n");
                    sql.append( "	H.DETAIL_NM AS JOB_NM,  \n");
                    sql.append( "	I.DETAIL_NM AS SKILL_NM, \n");
                    sql.append( "	J.DETAIL_NM AS CON_YEAR_NM, \n");
                    sql.append( "	B.START_DT, A.B_PAY0, A.O_TIME1, A.O_TIME2,K.DETAIL_NM AS AGENCY_NM, \n");
										sql.append( "	A.PAY_SUM, A.DEDUCT_SUM, A.REAL_PAY_SUM \n");
                    sql.append( "	FROM SALES.TCM400 A                                     \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TCM300 B ON A.EMPNO=B.EMPNO       \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TCU010 C ON A.CUST_SID=C.CUST_SID \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 D ON A.VEND_CD=TRIM(D.DETAIL) AND D.HEAD='CM019' AND TRIM(D.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 E ON TRIM(E.DETAIL)=TRIM(A.DEPT_CD) AND E.HEAD='CM006' AND TRIM(E.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 F ON TRIM(F.DETAIL)=TRIM(A.TEAM_CD) AND F.HEAD='CM003' AND TRIM(F.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 G ON TRIM(G.DETAIL)=TRIM(A.WORK_CD) AND G.HEAD='CM007' AND TRIM(G.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 H ON TRIM(H.DETAIL)=TRIM(A.JOB_CD)  AND H.HEAD='CM004' AND TRIM(H.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 I ON TRIM(I.DETAIL)=TRIM(A.SKILL_CD)  AND I.HEAD='CM013' AND TRIM(I.DETAIL)<>'' \n");
                    sql.append( "	LEFT OUTER JOIN SALES.TSY010 J ON TRIM(J.DETAIL)=TRIM(A.CON_YEAR)  AND J.HEAD='CM017' AND TRIM(J.DETAIL)<>'' \n");
										sql.append( "	LEFT OUTER JOIN SALES.TSY010 K ON TRIM(K.DETAIL)=TRIM(B.AGENCY_CD) AND K.HEAD='CM005' AND TRIM(K.DETAIL)<>'' \n");
                    sql.append( "	WHERE 1=1              \n");
if(!str1.equals(""))sql.append( "	AND A.PAY_YM = '"+str1+"'       \n");
if(!str2.equals(""))sql.append( "	AND A.PAY_DIV = '"+str2+"'      \n");
if(!str3.equals(""))sql.append( "	AND A.TEAM_CD = '"+str3+"'      \n");
if(!str4.equals(""))sql.append( "	AND A.DEPT_CD = '"+str4+"'      \n");
if(!str5.equals(""))sql.append( "	AND A.EMPNO = '"+str5+"'        \n");
if(!str6.equals(""))sql.append( "	AND B.AGENCY_CD = '"+str6+"'    \n");
                    sql.append( "	ORDER BY A.TEAM_CD,A.EMPNO  \n");

								logger.dbg.println(this,sql.toString());

						stmt = conn.getGauceStatement(sql.toString());

								//logger.dbg.println(this,str1);

		 				stmt.executeQuery(dSet);

								//logger.dbg.println(this,"OK_Em010_ED");
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