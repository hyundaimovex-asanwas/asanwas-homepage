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
public class Em015_S1_Pop extends HttpServlet {

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
				String [] str = new String[3];
				//String strFrdt="";
				//String strTodt="";
				str[0] =  req.getParameter("v_str1"); // 사번
				str[1] =  req.getParameter("v_str2");	// 성명
				str[2] =  req.getParameter("v_str3");	// 급여지급년월    
				//str[3] =  req.getParameter("v_str4"); // 휴가대상일자 to
				
        for(int i=0;i<=2;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);
        
				String[] strArrCN = new String[]{  "CHK",     "EMPNO",  "EMPNMK", "SEQ",    "CUST_SID",
					                                 "DEPT_CD", "DEPTNMK","TEAM_CD","TEAMNMK",
                                           "START_DT","END_DT", "CONT_GB","CONT_GBNM",
					                                 "VEND_CD", "WORK_CD", "CON_YEAR", "H_YN","REWARD_YM",
                                           "I_EMPNO", "U_EMPNO","I_DATE", "U_DATE"                    
																		  	}; //

				int[] intArrCN = new int[] {  1, 10, 30,  2, 10,    
																		  5, 50,  5, 50, 
                                      8,  8,  3, 50, 
					                           10,  5,  2,  1, 6,
					                           10, 10, 10, 10 
																			}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  0,  0,
					                           -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                            0, -1,  0, -1, -1,
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

						sql.append( "	SELECT ''CHK, A.EMPNO,C.EMPNMK, A.SEQ,                                                           \n");
						sql.append( "	       A.CUST_SID, A.DEPT_CD, E.DETAIL_NM AS DEPTNMK,                                            \n");
						sql.append( "	       A.TEAM_CD, F.DETAIL_NM AS TEAMNMK,                                                        \n");
						sql.append( "	       A.START_DT, A.END_DT, A.CONT_GB, H.DETAIL_NM AS CONT_GBNM,                                \n");
						sql.append( "	       A.VEND_CD, A.WORK_CD, A.CON_YEAR, D.H_YN, A.REWARD_YM, \n");
						sql.append( "	       A.I_EMPNO, A.I_DATE, A.U_EMPNO, A.U_DATE  \n");
						sql.append( "	  FROM SALES.TCM345 A                                                                            \n");
						sql.append( "	  LEFT JOIN SALES.TCM300 C ON A.EMPNO = C.EMPNO                                                  \n");
						sql.append( "	  LEFT JOIN SALES.TCM355 D ON A.EMPNO = D.EMPNO AND A.SEQ = D.SEQ2                               \n");
						sql.append( "	  LEFT JOIN SALES.TSY010 E ON E.DETAIL = A.DEPT_CD AND E.HEAD = 'CM006' AND TRIM(E.DETAIL)<>''   \n");
						sql.append( "	  LEFT JOIN SALES.TSY010 F ON F.DETAIL = A.TEAM_CD AND F.HEAD = 'CM003' AND TRIM(F.DETAIL)<>''   \n");
						sql.append( "	  LEFT JOIN SALES.TSY010 H ON H.DETAIL = A.CONT_GB AND H.HEAD = 'CM015' AND TRIM(H.DETAIL)<>''   \n");
						sql.append( "	 WHERE C.USESTS='1'                      /* 재직자 */                      \n");
						sql.append( "	   AND (D.H_YN <>'Y' OR D.H_YN IS NULL)  /* 휴가 안간 사람 */              \n");
						sql.append( "	   AND (A.CONT_GB <> '001')              /* 신규계약이 아닌경우 */         \n");
						sql.append( "	   AND A.REWARD_YM >= '"+str[2]+"'       /* 현재급여년월 => 휴가미실시 보상년월이 급여년월보다 같거나 큰건*/  \n");
						if(!str[0].equals(""))sql.append( "	  AND A.EMPNO = '"+str[0]+"' \n");
						if(!str[1].equals(""))sql.append( "	  AND C.EMPNMK LIKE '"+str[1]+"%' \n");
						sql.append( "	 ORDER BY A.EMPNO, A.SEQ   \n");

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