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
public class h060005_s4 extends HttpServlet {

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

				String [] str = new String[2];
        str[0] =  req.getParameter("v_str1"); // 고과년월  
				str[1] =  req.getParameter("v_str2"); // 정규직 계약직 구분 1-정규직, 2-계약직 				

        for(int i=0;i<=1;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM", "EMPNO","PAYGRD","PAYGRD2","TOTAVG","RNK","CNT", "GRADE" }; 
				int[] intArrCN = new int[]{ 6, 7, 4, 4, 5, 3, 3, 1	}; 	
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 2, 0, 0, -1 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					//2011.06.02 JYS 부서장과 부서장외 부장 등급만들 때 동일 직급으로 함.
					
					sql.append( " SELECT Y.EVAYM, Y.EMPNO, Y.PAYGRD, Y.PAYGRD2, Y.TOTAVG, Y.RNK, Y.CNT, ''GRADE                  \n");
					sql.append( "   FROM(                                                                                        \n");
					sql.append( "        SELECT X.EVAYM, X.EMPNO, X.PAYGRD, X.PAYGRD2, X.TOTAVG,                                 \n");
					sql.append( "               RANK() OVER( PARTITION BY X.PAYGRD2 ORDER BY X.TOTAVG DESC ) RNK,                \n");
					sql.append( "               PAYROLL.FN_MAXCNT(X.EVAYM, X.GRSREF, X.PAYGRD2) CNT                              \n");
					sql.append( "         FROM ( SELECT A.EVAYM, A.GRSREF, A.EMPNO, A.PAYGRD, A.TOTAVG,                          \n");
					sql.append( "                       CASE WHEN (B.JOBDTY IN ('05','17','29','34') OR                          \n");
					sql.append( "                                 (B.JOBDTY ='20' AND B.PAYGRD IN ('140','150','160','170')) OR  \n");
          sql.append( "                                 (A.PAYGRD >='140' AND A.PAYGRD<='170')                         \n");
					sql.append( "                          ) THEN '130'                                                          \n");
					sql.append( "                       ELSE                                                                     \n");
					//sql.append( "														 CASE WHEN (A.PAYGRD >='140' AND A.PAYGRD<='170') OR A.PAYGRD='850' THEN '140'  \n");
					sql.append( "														 CASE WHEN (A.PAYGRD >='180' AND A.PAYGRD<='190') THEN '180'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='200' AND A.PAYGRD<='210') THEN '200'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='220' AND A.PAYGRD<='230') THEN '220'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='240' AND A.PAYGRD<='270') THEN '240'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='300' AND A.PAYGRD<='300') THEN '700'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='700' AND A.PAYGRD<='700') THEN '700'         \n");
					sql.append( "														      WHEN (A.PAYGRD >='890' AND A.PAYGRD<='890') THEN '700'         \n");
					sql.append( "                            ELSE '999' END                                                      \n");
					sql.append( "                       END PAYGRD2                                                              \n");
					sql.append( "                 FROM PAYROLL.HVEMP A                                                           \n");
					sql.append( "                 LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                              \n");
					sql.append( "                WHERE A.EVAYM ='"+str[0]+"'                                                     \n");
					sql.append( "                  AND A.GRSREF = '"+str[1]+"'                                                   \n");
					sql.append( "              ) X                                                                               \n");
					sql.append( "        WHERE X.EVAYM ='"+str[0]+"'                                                             \n");
					sql.append( "          AND X.GRSREF ='"+str[1]+"'                                                            \n");
					sql.append( "  ) Y                                                                                           \n");
					sql.append( " ORDER BY Y.PAYGRD2, INTEGER(Y.RNK)                                                             \n");
					
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