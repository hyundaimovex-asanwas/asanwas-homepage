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
public class h050010_s2 extends HttpServlet {

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
        String [] str = new String[9];
        str[0] =  req.getParameter("v_str1"); // 신청일자
				str[1] =  req.getParameter("v_str2"); // 사번  
				str[2] =  req.getParameter("v_str3"); // 근태코드 
				str[3] =  req.getParameter("v_str4");	// 출발일  
			
        for(int i=0;i<=8;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",	 "EMPNO",		  "LAZCD",	 "FRDT",		 "OTDT",
																					"OTSEQ",	 "SECTION",		"TRAFFIC", "CARFARE",	 "INSTAMT",	
																					"INFDAMT", "INDAYAMT",	"WRDT",    "WRID",     "UPDT",	
																					"UPID",    "EMPNMK",
					                                "ORGAPPDT","ORGEMPNO","ORGLAZCD",	 "ORGFRDT",	 "ORGOTDT",
					                                "ORGOTSEQ","DEPTCD",   "PAYGRD"	,  "MEMO",     "TRAFFICNM", "HLNO"
																					}; 

				int[] intArrCN = new int[]{ 8,  7,  4,  8,   8,
																		2, 20,  4,  7,   7,
																		7,  7,  8, 10,   8, 
					                         10, 20,
					                          8,  7,  4,  8,   8,
                                    2,  4,  4,  30,  30, 14
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		  0,  0, -1, -1, -1,
																		 -1, -1,
					                           -1, -1, -1, -1, -1,
                                     -1, -1, -1, -1, -1, -1
																	 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.APPDT,  A.EMPNO,   A.LAZCD,  A.FRDT, A.OTDT,          \n");
					sql.append( " 			 A.OTSEQ,  A.SECTION, A.TRAFFIC,A.CARFARE, A.INSTAMT,   \n");
					sql.append( " 			 A.INFDAMT,A.INDAYAMT,A.WRDT,   A.WRID,    A.UPDT, \n");
					sql.append( " 			 A.UPID,               \n");
					sql.append( " 			 CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN C.EMPNMK ELSE B.EMPNMK END EMPNMK,  \n");
					sql.append( "        A.APPDT ORGAPPDT, A.EMPNO ORGEMPNO, A.LAZCD ORGLAZCD,  A.FRDT ORGFRDT,  \n");
					sql.append( "        A.OTDT ORGOTDT, A.OTSEQ ORGOTSEQ,  D.DEPTCD, D.PAYGRD, RTRIM(E.MEMO)MEMO, RTRIM(F.MINORNM) AS TRAFFICNM, D.HLNO    \n");
					sql.append( "   FROM PAYROLL.HLOTDTLE A                      \n");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO \n");
					sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO = C.EMPNO \n");
 					sql.append( "   LEFT JOIN PAYROLL.HLOTMST D ON A.APPDT = D.APPDT AND A.EMPNO=D.EMPNO AND A.LAZCD = D.LAZCD AND A.FRDT=D.FRDT \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE E ON D.PAYGRD = E.MINORCD AND E.MAJORCD='2002'  \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON A.TRAFFIC = F.MINORCD AND F.MAJORCD='2053' \n");
					sql.append( "  WHERE A.APPDT ='"+str[0]+"' \n");
					sql.append( "    AND A.EMPNO ='"+str[1]+"' \n");
					sql.append( "    AND A.LAZCD ='"+str[2]+"' \n");
					sql.append( "    AND A.FRDT = '"+str[3]+"' \n");
					sql.append( "  ORDER BY A.OTDT, A.OTSEQ \n");

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