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
public class h050006_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");		//부서
				String  str2  = req.getParameter("v_str2");		//년월 from
				String  str3  = req.getParameter("v_str3");		//성명
				String  str4  = req.getParameter("v_str4");		//LEVEL
				String  str5  = req.getParameter("v_str5");		//TREECD
				String  str6  = req.getParameter("v_str6");		//년월 to

				if (str1 == null)	{ str1 = ""; }
				if (str2 == null) { str2 = ""; }
				if (str3 == null) { str3 = ""; }
				if (str4 == null) { str4 = ""; }
				if (str5 == null) { str5 = ""; }
				if (str6 == null) { str6 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "ATTDAY","ATTTIME","CLODAY",
																					"CLOTIME","DEPTCD","ETC","DEPTNM",
																				  "TREECD","SEQ","EMPDIV", "ETC2"};//,"PAYGNM"}; //OVERWK->ETC

				int[] intArrCN = new int[] { 7,  20,	8,  6,  8,  
																		 6,  4,	 30, 70,
																		 8,  3,   4, 30};
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,
																		 -1, 0,  -1, -1};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT DISTINCT																																	\n");	
						sql.append( " RTRIM(E.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, RTRIM(E.ATTDAY) ATTDAY,						\n");
						sql.append( " RTRIM(E.ATTTIME) ATTTIME, RTRIM(E.CLODAY) CLODAY, RTRIM(E.CLOTIME) CLOTIME,			\n");
						sql.append( " RTRIM(E.DEPTCD) DEPTCD, RTRIM(G.MINORNM) ETC,																		\n");
						sql.append( " RTRIM(C.DEPTNM) DEPTNM, C.TREECD, D.SEQ, A.EMPDIV, E.ETC AS ETC2								\n");
						sql.append( " FROM PAYROLL.HLATTEND E 																												\n");
						sql.append( " LEFT JOIN PAYROLL.HIPERSON  A ON E.EMPNO  = A.EMPNO															\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE   D ON A.PAYGRD = D.MINORCD AND D.MAJORCD ='2002'			\n");
						sql.append( " LEFT JOIN PAYROLL.HLDUTYC07 H ON E.EMPNO  = H.EMPNO AND E.ATTDAY = H.USEDT 			\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE   G ON H.CODE  = G.MINORCD AND G.MAJORCD ='1124'		  \n");
						sql.append( " LEFT JOIN PAYROLL.HOORDER K ON E.EMPNO = K.EMPNO                        \n");
						sql.append( "                            AND K.ORDDT = ( SELECT MAX(ORDDT)ORDDT       \n");
						sql.append( "                                                  FROM PAYROLL.HOORDER   \n");
						sql.append( "                                                 WHERE ORDDT<='"+ str6 +"' \n");
						sql.append( "                                                   AND EMPNO =E.EMPNO )  \n");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT  C ON K.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                      \n");
						sql.append( " WHERE SUBSTR(E.EMPNO,1,1) IN ('1','2')	   \n");
						//sql.append( " AND   RTRIM(A.USESTS) IN ('1','2') AND RTRIM(E.DEPTCD) <> ''	                 \n");

						if (!str2.equals("")||!str6.equals("")) {
							sql.append( " AND E.ATTDAY BETWEEN '" + str2 + "' AND '" + str6 + "' 											  \n");
													}
						if (!str3.equals("")) sql.append( " AND A.EMPNMK LIKE '" + str3 + "%'													\n");

						if (str4.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'									\n");
						if (str4.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'									\n");
						if (str4.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '" + str5 + "'									\n");
						if (str4.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" +str5 + "'												\n");

			      sql.append( " UNION ALL		\n");	
            sql.append( " SELECT DISTINCT																																	\n");	
						sql.append( " RTRIM(E.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, RTRIM(E.ATTDAY) ATTDAY,						\n");
						sql.append( " RTRIM(E.ATTTIME) ATTTIME, RTRIM(E.CLODAY) CLODAY, RTRIM(E.CLOTIME) CLOTIME,			\n");
						sql.append( " RTRIM(E.DEPTCD) DEPTCD, RTRIM(G.MINORNM) ETC,																		\n");
						sql.append( " RTRIM(C.DEPTNM) DEPTNM, C.TREECD, D.SEQ, A.EMPDIV, E.ETC AS ETC2	  						\n");
						sql.append( " FROM PAYROLL.HLATTEND E 																												\n");
						sql.append( " LEFT JOIN PAYROLL.T_HIPERSON  A ON E.EMPNO  = A.EMPNO														\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE   D ON A.PAYGRD = D.MINORCD AND D.MAJORCD ='2002'			\n");
						sql.append( " LEFT JOIN PAYROLL.HLDUTYC07 H ON E.EMPNO  = H.EMPNO AND E.ATTDAY = H.USEDT 			\n");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE   G ON H.CODE  = G.MINORCD AND G.MAJORCD ='1124'		  \n");
						sql.append( " LEFT JOIN PAYROLL.T_HOORDER K ON E.EMPNO = K.EMPNO                        \n");
						sql.append( "                            AND K.ORDDT = ( SELECT MAX(ORDDT)ORDDT       \n");
						sql.append( "                                                  FROM PAYROLL.T_HOORDER   \n");
						sql.append( "                                                 WHERE ORDDT<='"+ str6 +"' \n");
						sql.append( "                                                   AND EMPNO =E.EMPNO )  \n");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT  C ON K.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                      \n");
						sql.append( " WHERE SUBSTR(E.EMPNO,1,1) IN ('3','4','5','6')	                          \n");
						//sql.append( " AND   RTRIM(A.USESTS) IN ('1','2') AND RTRIM(E.DEPTCD) <> ''	                  \n");

						if (!str2.equals("")||!str6.equals("")) {
							sql.append( " AND E.ATTDAY BETWEEN '" + str2 + "' AND '" + str6 + "' 											  \n");
													}
						if (!str3.equals("")) sql.append( " AND A.EMPNMK LIKE '" + str3 + "%'													\n");

						if (str4.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'									\n");
						if (str4.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '" + str5 + "'									\n");
						if (str4.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '" + str5 + "'									\n");
						if (str4.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" +str5 + "'												\n");
						
						sql.append( " ORDER BY ATTDAY ASC, TREECD ASC, SEQ ASC														\n");

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