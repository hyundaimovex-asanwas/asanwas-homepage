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
public class a020001_s18 extends HttpServlet {
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
				String [] str = new String [8];

				str[0]	= req.getParameter("v_str1");		//지점코드
				str[1]	= req.getParameter("v_str2");		//예산년도
				str[2]	= req.getParameter("v_str3");		//예산본부
				str[3]	= req.getParameter("v_str4");		//예산부서
				str[4]	= req.getParameter("v_str5");		//계정코드
				str[5]	= req.getParameter("v_str6");		//관리항목
				str[6]	= req.getParameter("v_str7");		//세목코드
				str[7]	= req.getParameter("v_str8");		//예산월


			  for (int s=0;s<=7;s++ ){
					if(str[s]==null) str[s]="";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "REALBGT","RESULTS","BRESULTS","JANAMT"
				                                   }; 

				int[] intArrCN = new int[]{ 15, 15, 15, 15 }; 
				int[] intArrCN2 = new int[]{ 0, 0, 0, 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT COALESCE(REALBGT,0)REALBGT, COALESCE(RESULTS,0)RESULTS, 							\n");
					sql.append( "        COALESCE(RESULTS,0)+COALESCE(BRESULTS,0) AS BRESULTS,									\n");
					sql.append( "        COALESCE(REALBGT,0)-COALESCE(RESULTS,0)-COALESCE(BRESULTS,0)AS JANAMT		\n");
					sql.append( "   FROM ACCOUNT.BGTDTL                                                  												\n");
					sql.append( "  WHERE FDCODE='"+str[0]+"'                                             												\n");
					if(!str[1].equals(""))sql.append( "    AND BGTYY='"+str[1]+"'                        												\n");
					if(!str[7].equals(""))sql.append( "    AND BGTMM ='"+str[7]+"'                       												\n");
					if(!str[2].equals(""))sql.append( "    AND BGTDIV ='"+str[2]+"'                      												\n");
					if(!str[3].equals(""))sql.append( "    AND BGTDPT ='"+str[3]+"'                      												\n");
					if(!str[4].equals(""))sql.append( "    AND ATCODE ='"+str[4]+"'                      												\n");
					if(!str[5].equals(""))sql.append( "    AND FSREFCD ='"+str[5]+"'                     												\n");
					if(!str[6].equals(""))sql.append( "    AND SATCODE ='"+str[6]+"'                     												\n");

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