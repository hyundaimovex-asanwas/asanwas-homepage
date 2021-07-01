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
public class Em014_S1_Pop extends HttpServlet {

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
				String [] str = new String[2];
				//String strFrdt="";
				//String strTodt="";
				str[0] =  req.getParameter("v_str1"); // 부서코드 
				str[1] =  req.getParameter("v_str2");	// 소속코드 
				
							
        for(int i=0;i<=1;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);
        
				String[] strArrCN = new String[]{  "CHK",           "EMPNO",     "EMPNMK", 
					                                                     "VEND_CD",  "VEND_NM",  "DEPT_CD",  "DEPT_NM",
					                                                     "TEAM_CD",  "TEAM_NM", "WORK_CD", "WORK_NM",
					                                                     "SKILL_CD",  "JOB_CD",
                                                                        "WORK_GB", "W_TIME",     "W2_TIME",  "W_TIME_TOT", "W_REMARK",
                                                                        "O_TIME","O2_TIME","O3_TIME","O4_TIME","O_TIME_TOT","O_DTIME","O_NTIME","O_REMARK",
                                                                        
                                                                         "I_EMPNO",  "U_EMPNO", "I_DATE", "U_DATE"                    
																		  	                   }; //


				int[] intArrCN = new int[] {  1, 10, 30,      
												              5, 50,  5, 50, 
					                                            5, 50,  5, 50,
					                                            3,  5, 
                                                               3,  4,   4,  3,  40,
                                                               4,  4,   4,  4,  3,  3,  3, 40,
					                                          10, 10, 10, 10 
																		             	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, 
					                                           -1, -1, -1, -1,
					                                           -1, -1, -1, -1,
					                                           -1, -1,
					                                           -1, -1, -1,  1, -1,
					                                           -1, -1, -1, -1,  1, 1, 1, -1,
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

            //strFrdt = str[2].substring(0,4)+"-"+str[2].substring(4,6)+"-"+str[2].substring(6,8);
						//strTodt = str[3].substring(0,4)+"-"+str[3].substring(4,6)+"-"+str[3].substring(6,8);
						sql.append( "	SELECT ''CHK,  A.EMPNO,   A.EMPNMK,  \n");
						sql.append( "	        COALESCE(A.VEND_CD,'')VEND_CD, COALESCE( B.DETAIL_NM ,'')AS VEND_NM,   COALESCE(A.DEPT_CD,'')DEPT_CD,   COALESCE(C.DETAIL_NM,'') AS DEPT_NM,   \n");
						sql.append( "	        COALESCE(A.TEAM_CD,'')TEAM_CD,  COALESCE(D.DETAIL_NM,'') AS TEAM_NM,  COALESCE(A.WORK_CD,'')WORK_CD,  COALESCE(E.DETAIL_NM,'') AS WORK_NM,      \n");
						sql.append( "	       COALESCE(A.SKILL_CD,'')SKILL_CD,COALESCE(A.JOB_CD,'')JOB_CD,                                                                                                       \n");
						sql.append( "	       COALESCE(X.WORK_GB,'')WORK_GB, RTRIM(COALESCE(X.W_TIME,''))W_TIME, RTRIM(COALESCE(X.W2_TIME,''))W2_TIME, COALESCE(X.W_TIME_TOT,0)W_TIME_TOT, COALESCE(X.W_REMARK,'')W_REMARK,      \n");
						sql.append( "	       RTRIM(COALESCE(X.O_TIME,''))O_TIME, RTRIM(COALESCE(X.O2_TIME,''))O2_TIME,RTRIM(COALESCE(X.O3_TIME,''))O3_TIME, RTRIM(COALESCE(X.O4_TIME,''))O4_TIME,      \n");
						sql.append( "	       COALESCE(X.O_TIME_TOT,0)O_TIME_TOT, COALESCE(X.O_DTIME,0)O_DTIME,COALESCE(X.O_NTIME,0)O_NTIME, COALESCE(X.O_REMARK,'')O_REMARK,    \n");
						sql.append( "	       COALESCE(X.I_EMPNO,'')I_EMPNO, '' I_DATE,COALESCE( X.U_EMPNO,'')U_EMPNO,'' U_DATE                                                                   \n");
						sql.append( "	  FROM SALES.TCM300 A                                                                                                           \n");
						sql.append( "	  LEFT JOIN SALES.TCM360 X ON A.EMPNO = X.EMPNO                                                            \n");
						sql.append( "	  LEFT OUTER JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''  \n");
						sql.append( "	  LEFT OUTER JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='CM006' AND RTRIM(C.DETAIL)<>''  \n");
						sql.append( "	  LEFT OUTER JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.TEAM_CD) AND D.HEAD='CM003' AND RTRIM(D.DETAIL)<>''  \n");
						sql.append( "	  LEFT OUTER JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD) AND E.HEAD='CM007' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( "	 WHERE A.USESTS='1'                                                                                                \n");

					  if(!str[0].equals(""))sql.append( "	AND A.DEPT_CD = '"+str[0]+"'   \n");
					  if(!str[1].equals(""))sql.append( "	AND A.TEAM_CD = '"+str[1]+"'   \n");
						sql.append( "	  ORDER BY  A.START_DT, A.EMPNMK \n");
	
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