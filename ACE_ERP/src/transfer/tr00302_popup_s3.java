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
public class tr00302_popup_s3 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "CAR_SEQ_NO",	"ACCSECTION", "CAR_NO",	"CAR_TYPE", "PERSON_NO",	
													  "LD_CARGO", "LD_CARGONM",	"OFF_CARGO", "OFF_CARGONM", "PURPOSE",
														   "LEAD_FEE","PERSON_CNT", "START_DATE" ,  "START_TIME", "RTRN_DATE",
																"RTRN_TIME","BAECHA_NO", "ACCESS_NO","RDS_GOODS", "REMARK",
															"CREATE_DT","CREATE_USR", "UPDATE_DT","UPDATE_UST", "PSN_KNAME"
																		
																	};

				int[] intArrCN = new int[]{ 10, 1, 12, 20, 20,
										    	4, 50, 4, 50, 100, 
								                    1, 5, 8, 4, 8, 
														4, 20, 10, 50, 512,
													10, 10, 10, 10, 20
														
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, 
												  -1, 0, -1, -1, -1, 
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
					sql.append( " SELECT A.CAR_SEQ_NO, A.ACCSECTION, A.CAR_NO, A.CAR_TYPE, A.PERSON_NO,  \n" );
					sql.append( " A.LD_CARGO, A.LD_CARGONM, A.OFF_CARGO, A.OFF_CARGONM, A.PURPOSE, \n" );
					sql.append( " A.LEAD_FEE, A.PERSON_CNT, A.START_DATE, A.START_TIME, A.RTRN_DATE, \n" );
					sql.append( " A.RTRN_TIME, A.BAECHA_NO, A.ACCESS_NO, A.RDS_GOODS, A.REMARK, \n" );
					sql.append( " A.CREATE_DT, A.CREATE_USR, A.UPDATE_DT, A.UPDATE_UST, B.PSN_KNAME \n" );
					
					sql.append( " FROM TRANSFER.LTCARACC A \n" );
					
					sql.append( " LEFT JOIN TRANSFER.LTPERSON B ON B.PERSON_NO = A.PERSON_NO  \n" );
					
					sql.append( " WHERE A.ACCSECTION <> 'O'  \n");
										
					if (!str1.equals("")) sql.append( " AND A.CAR_NO = '"+str1+"' \n" );
					//if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					//if (!str3.equals("")) sql.append( "  AND  A.START_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
					
						
					//logger.dbg.println( this, sql.toString() );
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