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
public class hcdept_s4 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //부서코드
				String  str2	= req.getParameter("v_str2"); //부서명
				String  str3	= req.getParameter("v_str3"); //관리부서 와 현업부서 구분 
				                                            //( A-관리부서(전체), B-현업부서)
				String  str4	= req.getParameter("v_str4"); //본부코드
				String  str5	= req.getParameter("v_str5"); //지점코드

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";


				if(str5.equals("01")) str5="02";
				
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM","TREECD","TREECD2","DEPTCD2",
					                                "BGTDEPT","BGTDIVCD","BGTDETPNM","BGTDIVNM",
					                                "DEPT_LEVEL", "DEPTCD_M", "DEPTNM_M"     }; 

				int[] intArrCN = new int[] { 4, 50,8,8,4, 
					                           4, 4, 40, 40,
					                           1, 4, 50 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,
					                           -1, -1, -1, -1,
					                           -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.DEPTCD,RTRIM(A.DEPTNM)DEPTNM,A.TREECD,X.TREECD2,Y.DEPTCD AS DEPTCD2,                     \n");
					sql.append( "        COALESCE(A.BGTDEPT,'')BGTDEPT,COALESCE(A.BGTDIVCD,'')BGTDIVCD,              		            \n");
					sql.append( "  	     COALESCE(E.CDNAM,'') AS BGTDETPNM, COALESCE(F.CDNAM,'') AS BGTDIVNM,  			                \n");
					sql.append( "  	     '111' SEQ,  A.DEPT_LEVEL, A.DEPTCD_M, RTRIM(G.DEPTNM) AS DEPTNM_M                               \n");
					sql.append( "   FROM PAYROLL.HCDEPT A																																						\n");
					sql.append( "   LEFT JOIN																																												\n");
					sql.append( "   (SELECT B.DEPTCD,B.DEPTNM,SUBSTR(B.TREECD,1,4)TREECD1, SUBSTR(B.TREECD,1,4)||'0000' TREECD2			\n");
					sql.append( "      FROM PAYROLL.HCDEPT B																																				\n");
					sql.append( "    ) X ON SUBSTR(A.TREECD,1,4) = SUBSTR(X.TREECD1,1,4)																						\n");
					sql.append( "      AND A.DEPTCD =X.DEPTCD																																				\n");
					sql.append( "   LEFT JOIN																																												\n");
					sql.append( "   ( SELECT C.DEPTCD,C.DEPTNM,C.TREECD																															\n");
					sql.append( "       FROM PAYROLL.HCDEPT C																																				\n");
					sql.append( "      WHERE SUBSTR(C.TREECD,5,4) = '0000'																													\n");
					sql.append( "    )Y ON Y.TREECD = X.TREECD2																																			\n");
					sql.append( "  	LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = A.BGTDEPT AND E.CMTYPE = '0003'					            \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = A.BGTDEPT AND F.CMTYPE = '0004'         						  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT G ON G.DEPTCD = A.DEPTCD_M                               						  \n");
					sql.append( "   WHERE A.USEYN='T'																																								\n");
				//	sql.append( "     AND A.TREECD<>'99999999'																																			\n");
					sql.append( "     AND A.DEPTCD NOT IN ('A000','A240')				  																									\n");
					if (!str1.equals("")) sql.append( " AND A.DEPTCD ='" + str1 + "'																								\n");
					if (!str2.equals("")) sql.append( " AND A.DEPTNM LIKE '%" + str2 + "%'																					\n");
					if (str3.equals("B")) sql.append( " AND Y.DEPTCD = '" + str4 + "'																					     \n");
					if (!str5.equals("")) sql.append( " AND A.FDCODE = '" + str5 + "'																			      		\n");

					sql.append( "  UNION ALL 	\n");
					
					sql.append( "  SELECT A.DEPTCD,RTRIM(A.DEPTNM)DEPTNM,A.TREECD,X.TREECD2,A.DEPTCD AS DEPTCD2,               	\n");
					sql.append( "  			COALESCE(A.BGTDEPT,'')BGTDEPT,COALESCE(A.BGTDIVCD,'')BGTDIVCD,                         	\n");
					sql.append( "  			COALESCE(E.CDNAM,'') AS BGTDETPNM, COALESCE(F.CDNAM,'') AS BGTDIVNM,                   	\n");
					sql.append( "  			'000' SEQ,  A.DEPT_LEVEL, A.DEPTCD_M, ''DEPTNM_M                                            	\n");
					sql.append( "   FROM PAYROLL.HCDEPT A                                                                      	\n");
					sql.append( "   LEFT JOIN                                                                                  	\n");
					sql.append( "   (SELECT B.DEPTCD,B.DEPTNM,SUBSTR(B.TREECD,1,4)TREECD1, SUBSTR(B.TREECD,1,4)||'0000' TREECD2	\n");
					sql.append( "  		FROM PAYROLL.HCDEPT B                                                                    	\n");
					sql.append( "  	) X ON SUBSTR(A.TREECD,1,4) = SUBSTR(X.TREECD1,1,4)                                        	\n");
					sql.append( "  		AND A.DEPTCD =X.DEPTCD                                                                   	\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = A.BGTDEPT AND E.CMTYPE = '0003'                 	\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL F ON F.CDCODE = A.BGTDEPT AND F.CMTYPE = '0004'                 	\n");
					sql.append( "   WHERE A.USEYN='F'                                                                          	\n");
					sql.append( "  	 AND A.TREECD='99999999'                                                                   	\n");
					sql.append( "  	 AND SUBSTR(A.DEPTCD,1,1)='Y'                                                              	\n");
					if (!str1.equals("")) sql.append( " AND A.DEPTCD ='" + str1 + "'																						\n");
					if (!str2.equals("")) sql.append( " AND A.DEPTNM LIKE '%" + str2 + "%'																			\n");
					sql.append( "  ORDER BY SEQ, DEPTCD	\n");
			
					//System.out.println("hcdept_s4 \n"+sql.toString() );
					//logger.dbg.println(this,sql.toString()); 
/*******************************************************************************************/
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