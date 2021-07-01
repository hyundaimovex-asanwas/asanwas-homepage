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
public class a040080_s2 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1");		//지점
				str[1] = req.getParameter("v_str2");		//CONNO 품의번호 
				str[2] = req.getParameter("v_str3");		//상세검수일자 
				
				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"DATE_CGCD", "ITEM_SID" , "ITEM_NM" ,"ITEM_SIZE", "ITEM_UNIT" ,
					"CGCD_NOW_CNT", "CGCD_NOW_AMT"
				}; 

				int[] intArrCN = new int[] { 
					 8,   10 ,  200,  200,   20, 
					10,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,   0,   -1,  -1,  -1, 
					 0,    0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.DATE_CGCD, D.ITEM_SID, E.ITEM_NM, E.ITEM_SIZE, E.ITEM_UNIT,     		\n");
					sql.append( "              A.CGCD_NOW_CNT,A.CGCD_NOW_AMT                                                 \n");
					sql.append( "    FROM PMS.TPU520 A, PMS.TPU510 D                                                              \n");
					sql.append( "      LEFT JOIN PMS.TPU010 E ON D.ITEM_SID = E.ITEM_SID                                 	\n");
					sql.append( "  WHERE A.CGC_SID = D.CGC_SID                                                                        \n");
					sql.append( "       AND A.CGC_SID IN ( SELECT B.CGC_SID                                                       \n");
					sql.append( "                                          FROM PMS.TPU510 B ,PMS.TPU410 C                        \n");
					sql.append( "                                       WHERE B.CON_SID = C.CON_SID                                   \n");
					sql.append( "                                             AND C.CON_NO = '"+str[1] +"' )                                \n");
					sql.append( "       AND A.DATE_CGCD = '"+str[2] +"'                                                                   \n");
					sql.append( "  ORDER BY D.ITEM_SID                                                                                        \n");
					                                                                                   		   				   
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