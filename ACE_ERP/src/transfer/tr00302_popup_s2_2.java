package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00302_popup_s2_2 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //
				String  str2	= req.getParameter("v_str2");    //
				
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PERSON_NO", "PRSN_NAME",	"COMPANY", "JOB_DUTY",	
													  "GENDER", "PRSN_REGNO", "ADDRESS1", "PRSN_CMPY"																	
																	};

				int[] intArrCN = new int[]{ 50, 50, 50, 50,
										    	50, 50, 50, 50
														
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					                           -1, -1, -1, -1
														
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.PERSON_NO, IFNULL(A.PRSN_NAME,'') AS PRSN_NAME,   \n" );
					sql.append( " IFNULL(A.PRSN_CMPY,'') AS COMPANY,   \n" );
					sql.append( " IFNULL(A.JOB_DUTY,'') AS JOB_DUTY, A.GENDER,  \n" );

					sql.append( " IFNULL(A.PRSN_REGNO,'') AS PRSN_REGNO, A.ADDRESS1,  \n" );
					sql.append( " IFNULL(B.MINORNM,'') AS PRSN_CMPY   \n" );
					sql.append( " FROM TRANSFER.LTPSRNACC A  \n" );
					
					sql.append( " LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.PRSN_CMPY AND B.MAJORCD = '0015' \n" );
					//sql.append( " LEFT JOIN TRANSFER.LTCARTYPE C ON C.CAR_TYPE = A.CAR_TYPE \n" );
					
					sql.append( " WHERE A.ACCSECTION = 'I'   \n" );
					sql.append( " AND A.START_DATE < '"+str1+"'  \n" );
					//sql.append( " AND A.RTRN_DATE > '"+str1+"' \n" );

								
					if (str2 != null && !str2.equals("")) sql.append( " AND A.PRSN_NAME LIKE '%"+str2+"%' \n");//null값 체크
												
GauceRes.writeException("Sql",":",sql.toString());				
						
					logger.err.println( this, sql.toString() );
/*********************************************************************************************/
		//			GauceRes.writeException("Sql",":",sql.toString());
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