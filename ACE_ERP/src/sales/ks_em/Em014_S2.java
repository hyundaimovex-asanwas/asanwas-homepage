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
public class Em014_S2 extends HttpServlet {

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
				String [] str = new String[6];
        str[0] =  req.getParameter("v_str1"); // 부서 
				str[1] =  req.getParameter("v_str2"); // 소속   
				str[2] =  req.getParameter("v_str3"); // from 일자 
				str[3] =  req.getParameter("v_str4");	// to 일자 
				str[4] =  req.getParameter("v_str5");	// 사번      
				str[5] =  req.getParameter("v_str6"); // 성명  
				
        for(int i=0;i<=5;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO","EMPNMK", "ATT_DT", "CUST_SID",
					                                 "VEND_CD","VEND_NM","DEPT_CD","DEPT_NM",
					                                 "TEAM_CD","TEAM_NM","WORK_CD","WORK_NM",
					                                 "WORK_GB","WKGB_NM","W_TIME","W2_TIME", "W_TIME_TOT", "W_REMARK",
                                           "O_TIME","O2_TIME","O_TIME_TOT","O_DTIME","O_NTIME","O_REMARK","REMARK",
                                           "CHK", "I_EMPNO","U_EMPNO","I_DATE","U_DATE", "JOB_CD","SKILL_CD","JOB_NM","SKILL_NM"  ,"O3_TIME"                               
																		  	}; //

				int[] intArrCN = new int[] { 10, 30, 8, 10,
					                           10, 50, 5, 50,
																		  5, 50, 5, 50,
					                            3, 50, 50,  4, 3, 40,
					                            50, 4,  3,  3, 3, 40, 40,
					                            1, 10,10, 10, 10, 5, 3, 50, 50, 50
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1, 0,
					                            0,-1,-1,-1,
                                     -1,-1,-1,-1,
					                           -1,-1,-1,-1, 1,-1,
					                           -1,-1, 1, 1, 1,-1,-1,
					                           -1,-1,-1,-1,-1,-1,-1,-1,-1,-1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer(); 

						sql.append( "	 SELECT A.EMPNO,   F.EMPNMK, A.ATT_DT, A.CUST_SID,  \n");
						sql.append( "	        A.VEND_CD, B.DETAIL_NM AS VEND_NM,          \n");
						sql.append( "	        A.DEPT_CD, C.DETAIL_NM AS DEPT_NM,          \n");
						sql.append( "	        A.TEAM_CD, D.DETAIL_NM AS TEAM_NM,          \n");
						sql.append( "	        A.WORK_CD, E.DETAIL_NM AS WORK_NM,          \n");
						sql.append( "	        A.WORK_GB, G.DETAIL_NM AS WKGB_NM,          \n");
						sql.append( "	        (SUBSTR(A.W_TIME,1,2)||':'||SUBSTR(A.W_TIME,3,2)||'~'||SUBSTR(A.W2_TIME,1,2)||':'||SUBSTR(A.W2_TIME,3,2)) AS W_TIME,    \n");
						sql.append( "	        A.W2_TIME, A.W_TIME_TOT,                     \n");
						sql.append( "	        A.W_REMARK,     \n");
						sql.append( "	        (CASE WHEN A.O_TIME ='0000' THEN ''          \n");
						sql.append( "	             ELSE SUBSTR(A.O_TIME,1,2)||':'||SUBSTR(A.O_TIME,3,2)||'~'||SUBSTR(A.O2_TIME,1,2)||':'||SUBSTR(A.O2_TIME,3,2) END) AS O_TIME,     \n");
						sql.append( "	        A.O2_TIME,A.O_TIME_TOT,  A.O_DTIME, A.O_NTIME,        \n");
						sql.append( "	        A.O_REMARK, A.REMARK,  ''CHK,  A.I_EMPNO, A.U_EMPNO, A.I_DATE,   A.U_DATE,   \n");
						sql.append( "	        A.JOB_CD,  H.DETAIL_NM AS JOB_NM,                                    \n");
						sql.append( "	        A.SKILL_CD,I.DETAIL_NM AS SKILL_NM,                                   \n");
						sql.append( "	        (CASE WHEN  (RTRIM(A.O3_TIME) ='' OR A.O3_TIME IS NULL OR A.O3_TIME='0000')  THEN ''          \n");
						sql.append( "	             ELSE SUBSTR(A.O3_TIME,1,2)||':'||SUBSTR(A.O3_TIME,3,2)||'~'||SUBSTR(A.O4_TIME,1,2)||':'||SUBSTR(A.O4_TIME,3,2) END) AS O3_TIME    \n");
						sql.append( "	   FROM SALES.TCM350 A                                                       \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''    \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='CM006' AND RTRIM(C.DETAIL)<>''    \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.TEAM_CD) AND D.HEAD='CM003' AND RTRIM(D.DETAIL)<>''    \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD) AND E.HEAD='CM007' AND RTRIM(E.DETAIL)<>''    \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TCM300 F ON RTRIM(F.EMPNO) = RTRIM(A.EMPNO)                                                  \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.WORK_GB)  AND G.HEAD='CM014' AND RTRIM(G.DETAIL)<>''   \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 H ON RTRIM(H.DETAIL) = RTRIM(A.JOB_CD)   AND H.HEAD='CM004' AND RTRIM(H.DETAIL)<>''   \n");
						sql.append( "	   LEFT OUTER JOIN SALES.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.SKILL_CD) AND I.HEAD='CM013' AND RTRIM(I.DETAIL)<>''   \n");
						sql.append( "	  WHERE 1=1                                                                                    \n");				
						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'    \n");
						if(!str[1].equals(""))sql.append( "	  AND A.TEAM_CD = '"+str[1]+"' \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "	  AND A.ATT_DT BETWEEN '"+str[2]+"' AND '"+str[3]+"'\n");
						if(!str[4].equals(""))sql.append( "	  AND A.EMPNO = '"+str[4]+"' \n");
						if(!str[5].equals(""))sql.append( "	  AND F.EMPNMK LIKE '"+str[5]+"%' \n");

					  sql.append( "	  ORDER BY A.ATT_DT, A.TEAM_CD, A.EMPNO \n");

						logger.dbg.println(this,sql.toString());
					
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