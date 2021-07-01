package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em016_S2 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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
				String [] str = new String[1];
        str[0] =  req.getParameter("v_str1"); //년월일
			
        for(int i=0;i<=0;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "AYM", "AYY", "AMM", "ADD", "mAYM"                    
																		  	}; //

				int[] intArrCN = new int[] { 8, 8, 8, 8, 8 
																	 }; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1
					                         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

          /*해당년월일을 1년1개월, 1년, 1개월, 1일 추가한 날짜를 조회한다.*/
					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						/*
						sql.append( "	 SELECT CAST(SUBSTR('"+str[0]+"',1,4)||'-'||SUBSTR('"+str[0]+"',5,2)||'-'||SUBSTR('"+str[0]+"',7,2) AS DATE) + 1 YEAR + 1 MONTH  AS AYM,   \n");
						sql.append( "	        CAST(SUBSTR('"+str[0]+"',1,4)||'-'||SUBSTR('"+str[0]+"',5,2)||'-'||SUBSTR('"+str[0]+"',7,2) AS DATE) + 1 YEAR  AS AYY, \n");
						sql.append( "	        CAST(SUBSTR('"+str[0]+"',1,4)||'-'||SUBSTR('"+str[0]+"',5,2)||'-'||SUBSTR('"+str[0]+"',7,2) AS DATE) + 1 MONTH AS AMM, \n");
						sql.append( "	        CAST(SUBSTR('"+str[0]+"',1,4)||'-'||SUBSTR('"+str[0]+"',5,2)||'-'||SUBSTR('"+str[0]+"',7,2) AS DATE) + 1 DAYS AS ADD, \n");
						sql.append( "	        CAST(SUBSTR('"+str[0]+"',1,4)||'-'||SUBSTR('"+str[0]+"',5,2)||'-'||SUBSTR('"+str[0]+"',7,2) AS DATE) - 1 YEAR + 1 MONTH  AS mAYM \n");
						sql.append( "	   FROM SYSIBM.SYSDUMMY1 \n");
						*/
						
						
						sql.append( "	SELECT REPLACE(CHAR((CAST(SUBSTRING('"+str[0]+"',1,4)||'-'||SUBSTRING('"+str[0]+"',5,2)||'-'||SUBSTRING('"+str[0]+"',7,2) AS DATE) + 1 YEAR + 1 MONTH ), ISO),'-','')  AS AYM,    \n");
	          sql.append( "		REPLACE(CHAR((CAST(SUBSTRING('"+str[0]+"',1,4)||'-'||SUBSTRING('"+str[0]+"',5,2)||'-'||SUBSTRING('"+str[0]+"',7,2) AS DATE) + 1 YEAR ),ISO),'-','') AS AYY,                 \n");
	          sql.append( "		REPLACE(CHAR((CAST(SUBSTRING('"+str[0]+"',1,4)||'-'||SUBSTRING('"+str[0]+"',5,2)||'-'||SUBSTRING('"+str[0]+"',7,2) AS DATE) + 1 MONTH), ISO),'-','') AS AMM,                 \n");
	          sql.append( "		REPLACE(CHAR((CAST(SUBSTRING('"+str[0]+"',1,4)||'-'||SUBSTRING('"+str[0]+"',5,2)||'-'||SUBSTRING('"+str[0]+"',7,2) AS DATE) + 1 DAYS), ISO),'-','') AS ADD,                 \n");
 	          sql.append( "		REPLACE(CHAR((CAST(SUBSTRING('"+str[0]+"',1,4)||'-'||SUBSTRING('"+str[0]+"',5,2)||'-'||SUBSTRING('"+str[0]+"',7,2) AS DATE) - 1 YEAR + 1 MONTH),ISO),'-','') AS mAYM       \n");
	          sql.append( "	FROM SYSIBM.SYSDUMMY1                                                                                                                                                     \n");

											
						//logger.dbg.println(this,sql.toString());

						stmt = conn.getGauceStatement(sql.toString());

  	 				stmt.executeQuery(dSet);
					}
				
/*********************************************************************************************/

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