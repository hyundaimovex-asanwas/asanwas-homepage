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
public class tr00506_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //차량번호
				String  str2	= req.getParameter("v_str2");    //차종
				String  str3	= req.getParameter("v_str3");    //소속
				


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CAR_NO", "PERSON_NO", "CARTYPENO", "CAR_YEAR", "COMPANY",	
													  "LEAD_CLASS", "LEADCHARGE", "REMARK", "CREATE_DT", "CREATE_USR", 
														   "UPDATE_DT", "UPDATE_UST",
																"C_NAME", "PSN_KNAME"
															
															};

				int[] intArrCN = new int[]{ 16, 70, 4, 4, 10,
												4, 1, 512, 10, 10,
								                  10, 10,
													30, 30
												
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, 
												  -1, -1,
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

					sql.append( " SELECT RTRIM(A.CAR_NO) CAR_NO, RTRIM(A.PERSON_NO) PERSON_NO, A.CARTYPENO, A.CAR_YEAR, A.COMPANY,  \n" );
					sql.append( " A.LEAD_CLASS, A.LEADCHARGE, RTRIM(A.REMARK) REMARK, A.CREATE_DT, A.CREATE_USR, \n" );
					sql.append( " A.UPDATE_DT, A.UPDATE_UST, \n" );
					sql.append( " B.CAR_NAME C_NAME, C.PSN_KNAME \n" );
	
					sql.append( " FROM TRANSFER.LTCARINFO A \n" );
					sql.append( " LEFT JOIN TRANSFER.LTCARTYPE B ON B.CAR_TYPE = A.CARTYPENO \n" );
					sql.append( " LEFT JOIN TRANSFER.LTPERSON C ON C.PERSON_NO = A.PERSON_NO \n" );

				
					sql.append( " WHERE A.CAR_NO <> ''  \n");
					
					if (!str1.equals("")) sql.append( " AND A.CAR_NO LIKE '"+str1+"%' \n" );
					if (!str2.equals("")) sql.append( " AND A.CARTYPENO = '"+str2+ "' \n" );
					if (!str3.equals("")) sql.append( " AND A.COMPANY = '"+str3+ "' \n" );
					
			
						
					//logger.dbg.println( this, sql.toString() );
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