/* 전체 조회 */
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
public class h050005_s1 extends HttpServlet {

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
				String []  str	= new String [5];
				str[0] = req.getParameter("v_str1");  //FROM 일자
				str[1] = req.getParameter("v_str2");  //TO일자
				str[2] = req.getParameter("v_str3");  //근태코드
				str[3] = req.getParameter("v_str4");  //사번
				str[4] = req.getParameter("v_str5");  //성명

				for(int i=0;i<=4;i++){
					if(str[i] == null) str[i] = "";
				}
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"LAZCD",		"DEPTCD",		"PAYSEQ",
																					"FRDT",			"TODT",			"DTYREM",   "CLOSYN",		"SGDT",
																					"SGNID",		"AGRDT",		"AGRID",    "PAYDT",		"AMT",
																					"DEPTNM",		"PAYGRDNM",	"EMPNMK",   "LAZFEENM", "BEFYEAR",
																					"CURYEAR",	"USEYEAR",	"PAYYEAR",  "SGNM",  	"AGNM"   
																					}; 

				int[] intArrCN = new int[]{ 8,  7,  4,  4,  4,
																		8,  8, 200, 1,  8,
																		7,  8,  7,  8,  7,
																		50, 30, 20,20,  3,
																		3,  3,  3, 20, 20
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,  0,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT D.APPDT, D.EMPNO, D.LAZCD,  D.DEPTCD, D.PAYSEQ,                       \n");
					sql.append( "         D.FRDT,  D.TODT,  D.DTYREM, D.CLOSYN, D.SGDT,                         \n");
					sql.append( "         D.SGNID, D.AGRDT, D.AGRID,  D.PAYDT,  IFNULL(D.AMT,0) AMT,            \n");
					sql.append( "         C.DEPTNM,B.MINORNM AS PAYGRDNM,                \n");
          sql.append( "         CASE WHEN RTRIM(A.EMPNMK)='' OR A.EMPNMK IS NULL THEN K.EMPNMK ELSE A.EMPNMK END EMPNMK, \n");
					sql.append( "         E.LAZFEENM,                 \n");
					sql.append( "         COALESCE(F.BEFYEAR,0) AS BEFYEAR,  COALESCE(F.CURYEAR,0) AS CURYEAR,  \n");
					sql.append( "         COALESCE(F.USEYEAR,0) AS USEYEAR,  COALESCE(F.PAYYEAR,0) AS PAYYEAR,  \n");
					sql.append( "         G.EMPNMK AS SGNM, I.EMPNMK AS AGNM                                    \n");
					sql.append( "    FROM PAYROLL.HLDUTY D                                                      \n");
					sql.append( "    LEFT JOIN PAYROLL.HIPERSON  A ON A.EMPNO  = D.EMPNO                        \n");
					sql.append( "    LEFT JOIN PAYROLL.HCLCODE  B ON B.MINORCD =D.PAYSEQ AND B.MAJORCD='2002'   \n");
					sql.append( "    LEFT JOIN PAYROLL.HCDEPT    C ON C.DEPTCD = D.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                      \n");
					sql.append( "    LEFT  JOIN PAYROLL.HCHOLFEE E ON D.LAZCD  = E.LAZCD                        \n");
					sql.append( "    LEFT  JOIN PAYROLL.PCMONPAY F ON D.EMPNO = F.EMPNO                         \n");
					sql.append( "                                 AND F.STRDT = (SELECT MAX(STRDT) STRDT        \n");
					sql.append( "                                                  FROM PAYROLL.PCMONPAY        \n");
					sql.append( "                                                 WHERE F.EMPNO = D.EMPNO )     \n");
					sql.append( "    LEFT  JOIN PAYROLL.HIPERSON G ON D.SGNID   = G.EMPNO                       \n");
					sql.append( "    LEFT  JOIN PAYROLL.HIPERSON I ON D.AGRID   = I.EMPNO                       \n");
					sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON K ON K.EMPNO  = D.EMPNO                       \n");
					sql.append( "   WHERE ((D.FRDT >='"+str[0]+"' AND D.FRDT <='"+str[1]+"')                    \n");
					sql.append( "      OR  (D.TODT >='"+str[0]+"' AND D.TODT <='"+str[1]+"'))                   \n");
					if(!str[2].equals(""))sql.append( " AND D.LAZCD ='"+str[2]+"'                               \n");
					if(!str[3].equals(""))sql.append( " AND D.EMPNO='"+str[3]+"'                                \n");
					if(!str[4].equals(""))sql.append( " AND (A.EMPNMK LIKE '"+str[4]+"%' OR K.EMPNMK LIKE '"+str[4]+"%') \n");
					sql.append( "   ORDER BY D.APPDT, D.EMPNO \n");
         
          logger.dbg.println(this, sql.toString());
					/*
					sql.append( " SELECT  \n");
					sql.append( " RTRIM(D.APPDT) APPDT,RTRIM(D.EMPNO) EMPNO, RTRIM(D.LAZCD) LAZCD, RTRIM(D.DEPTCD) DEPTCD, RTRIM(D.PAYSEQ) PAYSEQ,  \n");
					sql.append( " RTRIM(D.FRDT) FRDT, RTRIM(D.TODT) TODT, RTRIM(D.DTYREM) DTYREM, \n");
					sql.append( " RTRIM(D.CLOSYN) CLOSYN, RTRIM(D.SGDT) SGDT, RTRIM(D.SGNID) SGNID, RTRIM(D.AGRDT) AGRDT, RTRIM(D.AGRID) AGRID, \n");
          sql.append( " RTRIM(D.PAYDT) PAYDT,  IFNULL(D.AMT,0) AMT, C.DEPTNM,  B.MINORNM, A.EMPNMK, E.LAZFEENM, \n");
					sql.append( " COALESCE(F.BEFYEAR,0) AS BEFYEAR, COALESCE(F.CURYEAR,0) AS CURYEAR, COALESCE(F.USEYEAR,0) AS USEYEAR,  COALESCE(F.PAYYEAR,0) AS PAYYEAR, \n");
					sql.append( " G.EMPNMK AS SGNM, B.MINORCD,I.EMPNMK AS AGNM \n");
					sql.append( " FROM \n");
					sql.append( "	PAYROLL.HIPERSON A \n");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HLDUTY D ON A.EMPNO = D.EMPNO   \n");

          if (!str7.equals("")) sql.append( " AND A.EMPNMK LIKE '" + str7 + "%' \n" );
		    	if (!str1.equals("")) sql.append( " AND APPDT BETWEEN '" + str1 + "' AND '" + str2 + "' \n");
                    
					sql.append( "	 AND (D.LAZCD LIKE 'C%' OR D.LAZCD LIKE 'G%' OR D.LAZCD LIKE 'H%') \n");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HIPERSON G ON D.SGNID   = G.EMPNO \n");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HIPERSON I ON D.AGRID   = I.EMPNO \n");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD   = C.DEPTCD \n");
					sql.append( " LEFT  OUTER JOIN PAYROLL.HCLCODE  B ON B.MINORCD  = A.PAYGRD AND B.MAJORCD='2002' \n");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HCHOLFEE E ON D.LAZCD    = E.LAZCD \n");
		      sql.append( " LEFT  OUTER JOIN PAYROLL.PCMONPAY F ON A.EMPNO = F.EMPNO \n");
					sql.append( " AND F.STRDT = (SELECT MAX(STRDT) STRDT FROM PAYROLL.PCMONPAY WHERE F.EMPNO = A.EMPNO ) \n"); 
					sql.append( " WHERE A.EMPNO <>'' " );
			    if (!str3.equals("")&&!str6.equals(""))sql.append( " AND A.EMPNO BETWEEN '" + str3 + "' AND '" + str6 +  "' \n" );  
					sql.append( " ORDER BY APPDT \n");

					logger.dbg.println(this, sql.toString());
          
					*/

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