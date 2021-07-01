package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


// class 이름은 화일명과 항상 동일해야 함.
public class np00901_s1 extends HttpServlet {



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
				String  str1	= req.getParameter("v_str1");   //YYYY

				if (str1==null) str1=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																	"PH_NO","PH_COM","PH_BIZ","PH_DEPT",				//4

																	"PH_Mcom","PH_D_RC","PH_D_DL","PH_DLCN",

																	"PH_COM4","PH_EST4","PH_AMT4"						//48
																					
																			}; 	


				int[] intArrCN = new int[] { 
																				10, 50, 5, 5,			
																					
																				50, 50, 50, 50,  			
											
																				50, 15, 15							//48
																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1,-1,-1,  

																				-1,-1,-1,-1,  	

																				-1,-1,-1				//48
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


						sql.append( "	SELECT  																															\n");		
						
						sql.append( "			A.PH_NO,A.PH_COM,A.PH_BIZ,A.PH_DEPT,																		\n");

						sql.append( "			A.PH_Mcom,A.PH_D_RC,A.PH_D_DL,A.PH_DLCN,																	\n");

						sql.append( "			A.PH_COM4,A.PH_EST4,A.PH_AMT4																					\n");
																																													
						sql.append( "		FROM PURCH.PURH A																											\n");

						sql.append( "	WHERE 1=1																															\n");

			//			sql.append( "		AND A.PH_NO.SUBSTRING(0,4) = '"+str1+"' 																			\n");

						
						logger.dbg.println(this,sql.toString());
           

						
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

