package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class xat_dfscost_popup_s1 extends HttpServlet {

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
		
		System.out.println(" 시작 \n");	

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
				String  str1	= req.getParameter("v_str1");  //매장코드 또는 매장명
				String  str2	= req.getParameter("v_str2");  //사용유무
				String  str3	= req.getParameter("v_str3");  //
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
								
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK",        "MAPSID",	   "MAPCD",   "MAPNM",
						                           "INCODE",	"INCODENM",	   "OUTCODE", "OUTCODENM",
						                           "USEGB",     "ENDDT",
				                                   "CREATE_ID", "CREATE_DATE", "UPDATE_ID","UPDATE_DATE" 
				                                 }; 

				int[] intArrCN = new int[]{ 1,  10,  20, 30,
						                     20, 100, 20, 100,
						                      1,   8, 
					                         10 , 10, 10,  10
					                        }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
						                      -1, -1, -1, -1,
						                      -1, -1, 
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
					
					sql.append( " SELECT 'F' CHK,  A.MAPSID, A.MAPCD, B.HEAD_NAME AS MAPNM,	     \n");
					sql.append( "        A.INCODE, A.INCODENM, A.OUTCODE, A.OUTCODENM,			 \n");
					sql.append( "        A.USEGB,  A.ENDDT,							             \n");
					sql.append( "        A.CREATE_ID, A.CREATE_DATE, A.UPDATE_ID, A.UPDATE_DATE	 \n");
					sql.append( "   FROM ACCOUNT.TBIF_POSMAP A 									 \n");
					sql.append( "   LEFT JOIN ACCOUNT.TBIF_COMMST B ON A.MAPCD = B.HEAD_CD		 \n");  
					sql.append( "  WHERE 1=1													 \n");
					if (!str1.equals("")) sql.append( " AND ( A.MAPCD LIKE '%" + str1 + "%'   OR  B.HEAD_NAME LIKE '%" + str1 + "%' )  \n");
					if (!str2.equals("0")) sql.append( " AND A.USEGB  = '" + str2 + "'	  		 \n");
					if (!str3.equals(""))  sql.append( " AND A.MAPCD  = '" + str3 + "'	  		 \n");
					sql.append( "  ORDER BY  A.MAPSID  											 \n");
								
					//System.out.println("xat_posmap_s1 \n" + sql.toString());					
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