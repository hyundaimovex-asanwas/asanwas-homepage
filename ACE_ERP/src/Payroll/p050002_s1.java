package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p050002_s1 extends HttpServlet {

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
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//기준년월
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//성명
				str[3]	= req.getParameter("v_str4");		//보험구분
				str[4]	= req.getParameter("v_str5");		//LEVEL
				str[5]	= req.getParameter("v_str6");		//TREECD


				for (int s=0;s<6;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTNM", "EMPNO", "EMPNMK", "APPYM", "RESINO", 
																				  "GRDCD", "STDAMT", "INSAMT", "MEDSNO", "GETDT", 
                                          "LOSDT", "REPDT"
				};

				int[] intArrCN = new int[]{  
				                            50, 7, 20, 6, 13, 
																		 3, 9, 9, 20, 8, 
                                     8, 8
            	}; 

				int[] intArrCN2 = new int[]{
					                         -1, -1, -1, -1, -1, 
																		0 , 0, 0, -1, -1, 
                                   -1, -1
                    }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT             ");
					sql.append( " C.DEPTNM AS DEPTNM,");	  
					sql.append( " A.EMPNO,           ");   
					sql.append( " B.EMPNMK,          ");
					sql.append( " A.APPYM,           ");	  
					sql.append( " B.RESINO,          ");   
					sql.append( " A.GRDCD,           ");
					sql.append( " A.STDAMT,          ");	  
					sql.append( " A.INSAMT,          ");   
					sql.append( " A.MEDSNO,          ");
					sql.append( " RTRIM(A.GETDT)GETDT,           ");	  
					sql.append( " RTRIM(A.LOSDT)LOSDT,           ");   
					sql.append( " RTRIM(A.REPDT)REPDT            ");
				  sql.append( " FROM  PAYROLL.PWINDIPN_H A  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON B ON  A.EMPNO = B.EMPNO                  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD                   ");
					sql.append( " WHERE SUBSTR(A.EMPNO,1,1) IN( '1','2')  \n                   ");
					if(!str[0].equals("") && !str[0].equals("0"))
							sql.append(" AND A.APPYM  = '" + str[0] + "' ");
					if(!str[2].equals("") && !str[2].equals("0"))
							sql.append(" AND B.EMPNMK LIKE '" + str[2] + "%' ");
					if (str[4].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str[5] + "' \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str[5] + "' \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str[5] + "' \n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str[5] + "'     \n");

          sql.append( " UNION ALL ");

					sql.append( " SELECT             ");
					sql.append( " C.DEPTNM AS DEPTNM,");	  
					sql.append( " A.EMPNO,           ");   
					sql.append( " B.EMPNMK,          ");
					sql.append( " A.APPYM,           ");	  
					sql.append( " B.RESINO,          ");   
					sql.append( " A.GRDCD,           ");
					sql.append( " A.STDAMT,          ");	  
					sql.append( " A.INSAMT,          ");   
					sql.append( " A.MEDSNO,          ");
					sql.append( " RTRIM(A.GETDT)GETDT,           ");	  
					sql.append( " RTRIM(A.LOSDT)LOSDT,           ");   
					sql.append( " RTRIM(A.REPDT)REPDT            ");
				  sql.append( " FROM  PAYROLL.PWINDIPN_H A  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.T_HIPERSON B ON  A.EMPNO = B.EMPNO                  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD                   ");
					sql.append( " WHERE SUBSTR(A.EMPNO,1,1) IN( '3','4', '5', '6')  \n                   ");
					if(!str[0].equals("") && !str[0].equals("0"))
							sql.append(" AND A.APPYM  = '" + str[0] + "' ");
					if(!str[2].equals("") && !str[2].equals("0"))
							sql.append(" AND B.EMPNMK LIKE '" + str[2] + "%' ");
					if (str[4].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str[5] + "' \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str[5] + "' \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str[5] + "' \n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str[5] + "'     \n");

					//logger.err.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
						//logger.err.println(this,"1");
					stmt = conn.getGauceStatement(sql.toString());

	 		    stmt.executeQuery(dSet);
					//logger.err.println(this,"2");

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