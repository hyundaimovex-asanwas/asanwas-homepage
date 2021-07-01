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
public class p020001_s2 extends HttpServlet {

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
				String [] str = new String [14];
				str[0]	= req.getParameter("v_str1");		//사번
				str[1]	= req.getParameter("v_str2");		//년월

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "AMT","PAYAMT","GRDCD1","GRDCD2",         
                                          "INSAMT1","INSAMT2" };

				int[] intArrCN = new int[]{	 9,	 7,	 3,	 3,
																		 9,	 9
																	}; 

				int[] intArrCN2 = new int[]{ 0,	 0,  0,	 0,
																		 0,	 0
                                   }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					 sql.append( " COALESCE(A.AMT,0) AS AMT,COALESCE(A.AMT,0) AS PAYAMT,Z.INSCOD AS GRDCD1,Z.PENCOD AS GRDCD2, ");
					 sql.append( " COALESCE(E.INSAMT1,0) AS INSAMT1,COALESCE(F.INSAMT1,0) AS INSAMT2  ");
					 sql.append( " from PAYROLL.HIPERSON Z  ");
					 sql.append( " LEFT JOIN   --기본급 \n ");
           sql.append( " (SELECT A.CDDIV,A.PAYGRD,A.PAYSEQ,A.AMT FROM  PAYROLL.PCPAYTBL A   ");
					 sql.append( " WHERE A.CDDIV='1' AND A.STDYM=(SELECT MAX(STDYM) FROM PAYROLL.PCPAYTBL WHERE CDDIV='1')) A ON A.CDDIV='1' ");
					 sql.append( " AND Z.PAYGRD=A.PAYGRD AND Z.PAYSEQ=A.PAYSEQ  ");
					 sql.append( " LEFT JOIN PAYROLL.PWINSTBL E ON Z.INSCOD=E.GRDCD AND E.STDYM= '" + str[1]+ "'  --건강월보험료 \n ");
					 sql.append( " LEFT JOIN PAYROLL.PWPENTBL F ON Z.PENCOD=F.GRDCD AND F.STDYM= '" + str[1]+ "'  --연금월보험료   \n  ");
					 sql.append( " WHERE Z.EMPNO <> ' ' ");

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND Z.EMPNO= '" + str[0] + "' ");

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