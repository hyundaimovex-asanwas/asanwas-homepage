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
public class p040001_s4 extends HttpServlet {

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

				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1"); //사번           
				str[1]	= req.getParameter("v_str2"); //퇴직예정일자  -12 개월 이전년월
				str[2]	= req.getParameter("v_str3"); //퇴직예정년월
				//str[3]  = req.getParameter("v_str4");	//급여평균
				//str[4]  = req.getParameter("v_str5");	//근속년수

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO", "S91000", "COUNT","AMT", "YAMT"	}; 

				int[] intArrCN = new int[] { 7, 9, 2, 9, 9 }; 
			
				int[] intArrCN2 = new int[]{ -1, 0, 0, 0, 0 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					sql.append( " SELECT A.EMPNO,	\n ");
					sql.append( " COALESCE( (SELECT SUM(COALESCE(B.S91000,0))/12 AS S91000  --상여금평균계산	\n ");
					sql.append( " 				FROM PAYROLL.PBPAY B	\n ");
					sql.append( "	  			WHERE B.PAYDIV ='5' AND B.EMPNO='"+str[0]+"'	\n ");
					sql.append( " 				AND B.APPDT > '"+str[1]+"' AND B.APPDT <= '"+str[2]+"'	\n ");
					sql.append( " 				AND SUBSTR(B.APPDT,5,2) IN ('01','03','05','07','09','11','12')) ,0) AS S91000,	\n ");
					sql.append( " COALESCE( (SELECT (C.CURYEAR-C.USEYEAR) AS COUNT          --남은년차일수계산	\n ");
					sql.append( "	  			FROM PAYROLL.PCMONPAY C, PAYROLL.PRDEVPAY D	\n ");
					sql.append( " 				WHERE C.STRDT = '"+str[2]+"' AND D.APPDT = '"+str[2]+"'	\n ");	
					sql.append( " 				AND   C.EMPNO = D.EMPNO  AND C.EMPNO ='"+str[0]+"') ,0) AS COUNT,	\n ");
					sql.append( " COALESCE( (SELECT (E.P10000+E.P11000+E.P12000+E.P21000) AS AMT    --금액합계	\n ");	
					sql.append( " 				FROM PAYROLL.PBPAY E WHERE E.EMPNO ='"+str[0]+"' \n ");
					sql.append( "         AND APPDT ='200501'  AND PAYDIV='1') ,0) AS AMT,	\n ");	
					sql.append( " COALESCE( ((SELECT (E.P10000+E.P11000+E.P12000+E.P21000) AS AMT FROM PAYROLL.PBPAY E \n ");
					sql.append( "   WHERE E.EMPNO ='"+str[0]+"' AND APPDT ='"+str[2]+"'  AND PAYDIV='1') /30) * \n ");
					sql.append( "  (SELECT (C.CURYEAR-C.USEYEAR) AS COUNT \n ");
          sql.append( "   FROM PAYROLL.PCMONPAY C, PAYROLL.PRDEVPAY D \n ");
          sql.append( "   WHERE C.STRDT = '"+str[2]+"' AND D.APPDT = '"+str[2]+"' \n ");
          sql.append( "   AND   C.EMPNO = D.EMPNO  AND C.EMPNO ='"+str[0]+"') /12 ,0) AS YAMT    --년차수당 계산 \n ");
					sql.append( " FROM PAYROLL.HIPERSON A	\n ");
					sql.append( " WHERE A.EMPNO ='"+str[0]+"'	\n ");

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