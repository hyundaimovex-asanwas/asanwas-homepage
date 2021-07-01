package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a030011_s2 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//회계기간 from
				str[2] = req.getParameter("v_str3");	//회계기간 to
				str[3] = req.getParameter("v_str4");	//현계정코드
				str[4] = req.getParameter("v_str5");	//전기이월fr
				str[5] = req.getParameter("v_str6");	//전기이월to

				for(int i=0;i<=5;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATDECR","ATCODE","ATKORNAM","ACTYYMM","LEVELS",
																					"DETOT","CRTOT","SLPVLA"
				}; 

				int[] intArrCN = new int[] {  1,   7,  66,   8,   7,
																			9,   9,   9
				}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,  -1,  -1,   
																			0,   0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,'전기이월' AS ATKORNAM,															\n");		
						sql.append( "				 '전기이월' AS ACTYYMM,																																			\n");
						sql.append( "				 SUBSTR(A.ACTDAT,1,4)||'00' AS LEVELS,																											\n");
						sql.append( "        SUM(A.DETOT) AS DETOT,SUM(A.CRTOT) AS CRTOT,																								\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR = '1'  THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA			\n");
						sql.append( " FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B																													\n");
						sql.append( " WHERE A.ATCODE = B.ATCODE																																					\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE = '"+str[0]+"'																								\n");
						sql.append( " AND A.ACTDAT BETWEEN '"+str[4]+"00' AND '"+str[5]+"00'																						\n");
						sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"'  AND '"+str[3]+"'																								\n");
						sql.append( " GROUP BY B.ATDECR,B.ATCODE,SUBSTR(A.ACTDAT,1,4)||'00'																							\n");
						sql.append( " UNION ALL																																													\n");
						sql.append( " SELECT B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,B.ATKORNAM AS ATKORNAM,															\n");
						sql.append( " SUBSTR(A.ACTYYMM,1,4)||'/'||SUBSTR(A.ACTYYMM,5,2) AS ACTYYMM,																			\n");
						sql.append( " SUBSTR(A.ACTYYMM,1,6) AS LEVELS,																																	\n");
						sql.append( "        SUM(A.DETOT) AS DETOT,SUM(A.CRTOT) AS CRTOT,																								\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR = '1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA			\n");
						sql.append( " FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B																												\n");
						sql.append( " WHERE A.ATCODE = B.ATCODE																																					\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE = '"+str[0]+"'																								\n");
						sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'																								\n");
						sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"'  AND '"+str[3]+"'																								\n");
						sql.append( " GROUP BY B.ATDECR,B.ATCODE,B.ATKORNAM,SUBSTR(A.ACTYYMM,1,4)||'/'||SUBSTR(A.ACTYYMM,5,2),					\n");
						sql.append( " SUBSTR(A.ACTYYMM,1,6)																																							\n");
						sql.append( " UNION ALL																																													\n");
						sql.append( " SELECT B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,'합계' AS ATKORNAM,																	\n");
						sql.append( "				 '합계' AS ACTYYMM,																																					\n");
						sql.append( "				 SUBSTR(A.ACTYYMM,1,4)||'13'  AS LEVELS,																										\n");
						sql.append( "        SUM(A.DETOT) AS DETOT,SUM(A.CRTOT) AS CRTOT,																								\n");
						sql.append( "        SUM(CASE WHEN B.ATDECR = '1' THEN A.DETOT-A.CRTOT ELSE A.CRTOT-A.DETOT END) AS SLPVLA			\n");
						sql.append( " FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B																												\n");
						sql.append( " WHERE A.ATCODE = B.ATCODE																																					\n");
						if(!str[0].equals(""))  sql.append( " AND A.FDCODE = '"+str[0]+"'																								\n");
						sql.append( " AND A.ACTYYMM BETWEEN '"+str[1]+"' AND '"+str[2]+"'																								\n");
						sql.append( " AND A.ATCODE BETWEEN '"+str[3]+"'  AND '"+str[3]+"'																								\n");
						sql.append( " GROUP BY B.ATDECR,B.ATCODE,SUBSTR(A.ACTYYMM,1,4)||'13'																						\n");
						sql.append( " ORDER BY LEVELS \n");

						//logger.dbg.println(this,sql.toString());
						
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