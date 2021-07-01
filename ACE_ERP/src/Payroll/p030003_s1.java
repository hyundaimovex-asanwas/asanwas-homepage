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
public class p030003_s1 extends HttpServlet {

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

				String [] str= new String[5] ;
        str[0] = req.getParameter("v_str1");    //귀속년도
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//성명
				str[3]	= req.getParameter("v_str4");		//Level
				str[4]	= req.getParameter("v_str5");		//treecd

		  	for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}
             
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "YYYY",		"EMPNO",	"WKRESINO",	"WKNM",			"STRTDT2",	
																					"ENDDT2",	"BP11000","BP12000",	"BP13000",	"BP10SUM",     
																					"BP21000","BP22000","BP23000",	"BP31000",	"BP32000",	
																					"BP33000","BP41000","BP42000",	"BP43000",	"BP40SUM",
																					"EMPNMK", "PAYGRD", "PAYNM",		"DEPTCD",		"DEPTNM",  
																					"STRTDT", "ENDDT"	
					}; 

				int[] intArrCN = new int[]{  4,  7,   20,  30,  8,
																		 8,  9,    9,   9,  9,
																		 9,  9,    9,   9,  9,
																		 9,  9,    9,   9,  9,
																		20,  4,   30,  4,  70,
																		 8,  8
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
																		 -1,  0,  0,   0,   0, 
																			0,  0,  0,   0,   0, 
																			0,  0,  0,   0,   0, 
																		 -1, -1, -1,  -1,  -1,
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
					sql.append( " SELECT																																	\n");
          sql.append( " A.YYYY,			  A.EMPNO,    A.WKRESINO,  A.WKNM,    A.STRTDT  AS STRTDT2,	\n");
					sql.append( " A.ENDDT AS ENDDT2,        A.BP11000,   A.BP12000, A.BP13000, A.BP10SUM, \n");
					sql.append( " A.BP21000,    A.BP22000,  A.BP23000,   A.BP31000, A.BP32000,						\n");
          sql.append( " A.BP33000,    A.BP41000,  A.BP42000,   A.BP43000, A.BP40SUM,						\n");
					sql.append( " B.EMPNMK,     A.PAYGRD,   RTRIM(C.MINORNM) PAYNM, A.DEPTCD,  D.DEPTNM,  \n");
					sql.append( " B.STRTDT, B.ENDDT \n");
					sql.append( " FROM PAYROLL.YCBEFOFF A \n");
          sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO  \n");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE  C ON A.PAYGRD = C.MINORCD AND MAJORCD='2002' \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT D ON A.DEPTCD = D.DEPTCD \n");
					sql.append( " WHERE A.YYYY  = '" + str[0]+"' \n");
				  sql.append( " AND B.EMPNMK  like '" +str[2] +"%' \n");

					if (str[3].equals("1")) sql.append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] +"'  \n");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(D.TREECD,1,4)= '" + str[4] + "' \n");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(D.TREECD,1,6)= '" + str[4] +"'  \n");
					if (str[3].equals("4")) sql.append( " AND RTRIM(D.TREECD)= '" + str[4] + "'      \n");
    
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