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
public class h070001_s1 extends HttpServlet {

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

				String [] str = new String[5];
        str[0] =  req.getParameter("v_str1"); // 검색일자 fr  
				str[1] =  req.getParameter("v_str2"); // 검색일자 to
				str[2] =  req.getParameter("v_str3"); // 성명  
				str[3] =  req.getParameter("v_str4"); //    
				str[4] =  req.getParameter("v_str5"); // 구분자  

        for(int i=0;i<=4;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO", "REQDT", "SEQ", "SUBJECT", "FRDT", "TODT", "EDUDAY", "EDUPLC", "EDUINST", "SGDT", 
                                           "SGID", "APDT", "APID", "MEMO", "EMPNMK"
																			  }; 

				int[] intArrCN = new int[]{  7, 8, 1, 50, 8, 8, 3, 50, 30, 8, 
                                     7, 8, 7, 30, 20
																	}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, 0, -1, -1, -1, 0, -1, -1, -1, 
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

					sql.append( " SELECT \n");
					sql.append( " RTRIM(A.EMPNO) EMPNO, RTRIM(A.REQDT) REQDT, A.SEQ, RTRIM(A.SUBJECT) SUBJECT, RTRIM(A.FRDT) FRDT,    \n");
					sql.append( " RTRIM(A.TODT) TODT, A.EDUDAY, RTRIM(A.EDUPLC) EDUPLC, RTRIM(A.EDUINST) EDUINST, RTRIM(A.SGDT) SGDT, \n");
					sql.append( " RTRIM(A.SGID) SGID, RTRIM(A.APDT) APDT, RTRIM(A.APID) APID, RTRIM(A.MEMO) MEMO ,                    \n");
					sql.append( " CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN  C.EMPNMK ELSE B.EMPNMK END EMPNMK \n");
					sql.append( " FROM PAYROLL.HEDUCATION A                                                                           \n");
					sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                                   \n");
          sql.append( " LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO = C.EMPNO                                                   \n");
					sql.append( " WHERE A.REQDT BETWEEN '" + str[0] + "' AND '" + str[1] + "'  \n");
					
					if(str[3].equals("1")){
						sql.append( " AND A.EMPNO = '" + str[2] + "'   \n");
					}else{
						if(!str[2].equals(""))sql.append( " AND ( B.EMPNMK LIKE  '" + str[2] + "%' OR C.EMPNMK LIKE  '" + str[2] + "%' ) \n");
					}
					
					if(str[4].equals("A"))sql.append( "   AND (RTRIM(A.APDT) <> ''  AND  A.APDT <>'99999999')  \n");
				
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