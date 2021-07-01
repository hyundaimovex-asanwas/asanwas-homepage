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
public class p030001_s1 extends HttpServlet {

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
				String [] str = new String [2];
				str[0]	= req.getParameter("v_str1");		//연말정산년월
				str[1]	= req.getParameter("v_str2");		//연말정산구분

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"APPDT",  "PAYDIV", 	"PAYDT", 	"PBDIV" , 	"PAYCD",  
				"FRDT",	  "FRTM",	 	"TODT",	 	"TOTM",	 	"WRKSTS", 
				"MEMO"	
				};

				int[] intArrCN = new int[]{
						6,		30,		8,		8,		8,
						8,		6,			8,		6,		1,
						100
         }; 

				int[] intArrCN2 = new int[]{
					  -1, -1,	-1,	-1, -1,
						-1, -1,	-1,	-1,-1,
						-1
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
					sql.append(	" RTRIM(A.APPDT) AS APPDT,'연말정산' PAYDIV, A.PAYDT,A.PBDIV,A.PAYCD,");  
					sql.append(	" A.FRDT, A.FRTM, A.TODT,A.TOTM, A.WRKSTS,");	  
					sql.append(	" RTRIM(A.MEMO) AS MEMO ");	  
					sql.append( " FROM PAYROLL.PCWRKPAY A  ");
					//sql.append( " LEFT JOIN   PAYROLL.HCLCODE B ON A.PAYDIV = B.MINORCD  AND B.MAJORCD = '1120'  ");
					sql.append( " WHERE A.PAYDIV = 'Y' ");




					
					//if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.PAYDT= '"  + str[0] + "' ");    
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.APPDT= '"  + str[1] + "' ");  
					sql.append( "   ORDER BY  A.PAYCD ASC ");
					logger.dbg.println(this,sql.toString());
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