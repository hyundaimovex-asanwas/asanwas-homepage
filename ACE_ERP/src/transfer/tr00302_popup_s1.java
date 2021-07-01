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
public class tr00302_popup_s1 extends HttpServlet {

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


				String[] strArrCN = new String[]{ "CAR_NO",	"AA", "PERSON_NO",	"PSN_KNAME","ACCSECTION",
													  "RDS_GOODS", "CARTYPENO", "CAR_TYPE", "CAR_NAME",
												"CAR_NO", "AA", "PERSON_NO", "PSN_KNAME","ACCSECTION", 
														"RDS_GOODS","CARTYPENO" ,  "CAR_TYPE", "CAR_NAME"																		
																	};

				int[] intArrCN = new int[]{ 50, 50, 50, 50, 50,
										    	50, 50, 50, 50,
								            50, 50, 50, 50, 50, 
												50, 50, 50, 50
													
														
					}; 
						
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1,
											 -1, -1, -1, -1, -1, 
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
					sql.append( " SELECT DISTINCT IFNULL(A.CAR_NO,'') CAR_NO,'Y' AA, A.PERSON_NO,IFNULL(C.PSN_KNAME,'') PSN_KNAME, A.ACCSECTION,  \n" );
					sql.append( " IFNULL(A.RDS_GOODS,'') RDS_GOODS, D.CARTYPENO,A.CAR_TYPE,IFNULL(E.CAR_NAME,'') CAR_NAME   \n" );
					sql.append( " FROM TRANSFER.LTCARACC A , TRANSFER.LTACCPLCAR B \n" );
					sql.append( " LEFT JOIN TRANSFER.LTPERSON C ON C.PERSON_NO = A.PERSON_NO \n" );
					sql.append( " LEFT JOIN TRANSFER.LTCARINFO D ON D.CAR_NO = A.CAR_NO AND D.PERSON_NO = A.PERSON_NO \n" );
					sql.append( " LEFT JOIN TRANSFER.LTCARTYPE E ON E.CAR_TYPE = D.CARTYPENO \n" );
					sql.append( " WHERE A.CAR_NO IN ( \n" );
					
					sql.append( " SELECT DISTINCT CAR_NO FROM TRANSFER.LTACCPLCAR B)  \n" );
					sql.append( " AND A.ACCSECTION ='O'  \n" );
					
					if (!str1.equals("")) sql.append( " AND A.CAR_NO LIKE '"+str1+"%' \n" );
					
					sql.append( " UNION ALL \n");

					sql.append( " SELECT DISTINCT IFNULL(A.CAR_NO,'') CAR_NO,'N' AA ,A.PERSON_NO,IFNULL(C.PSN_KNAME,'') PSN_KNAME,'' AS ACCSECTION,   \n" );
					sql.append( " '' AS RDS_GOODS, A.CARTYPENO, D.CAR_TYPE, IFNULL(D.CAR_NAME,'') CAR_NAME  \n" );
					sql.append( " FROM TRANSFER.LTCARINFO A , TRANSFER.LTACCPLCAR B    \n" );
					sql.append( " LEFT JOIN TRANSFER.LTPERSON C ON C.PERSON_NO = A.PERSON_NO  \n");
					sql.append( " LEFT JOIN TRANSFER.LTCARTYPE D ON D.CAR_TYPE = A.CARTYPENO \n");
					
					sql.append( " WHERE A.CAR_NO IN ( \n");
					sql.append( " SELECT DISTINCT CAR_NO FROM TRANSFER.LTCARACC C)  \n");
					sql.append( " AND A.CAR_NO NOT IN  ( SELECT DISTINCT CAR_NO FROM TRANSFER.LTACCPLCAR C) \n");

					//sql.append( " AND B.ACCSECTION ='O'  \n" );

									
					if (!str1.equals("")) sql.append( " AND A.CAR_NO LIKE '%"+str1+"%' \n" );
					//if (!str2.equals("")) sql.append( " AND A.PURPOSE = '"+str2+"' \n" );
					//if (!str3.equals("")) sql.append( "  AND  A.START_DATE BETWEEN '"+str3+"' AND '"+str4+"' \n");
         
GauceRes.writeException("Sql",":",sql.toString());				
						
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