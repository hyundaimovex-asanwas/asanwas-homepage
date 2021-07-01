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
public class a070007_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");    //지점코드  
				String  str2	= req.getParameter("v_str2");	 //실사일자

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CDREMARK", "CDCODE", "GRP", "CDNAM" ,"QUANTY", "ACAMT", "REMARK" };

				int[] intArrCN = new int[]{11, 4, 1, 7, 6, 15, 132 };
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0, 0, 0, -1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();            
					sql.append( " SELECT A.CDREMARK, A.CDCODE, 															   \n");
					sql.append( "        CASE SUBSTR(A.CDCODE,1,1) WHEN '2' THEN '1' ELSE SUBSTR(A.CDCODE,1,1) END as GRP, \n");
					sql.append( "        TO_NUMBER(A.CDNAM) AS CDNAM, nvl(B.QUANTY,0) AS QUANTY, 				           \n");
					sql.append( "        nvl(B.ACAMT,0) AS ACAMT,  nvl(B.REMARK,'') AS REMARK 						       \n");
					sql.append( "   FROM ACCOUNT.ACASHSUR B                                                                \n");
					sql.append( "   LEFT OUTER JOIN ACCOUNT.COMMDTIL A ON CDCODE=CASHUNIT   							   \n");
					sql.append( " WHERE CMTYPE='0055' 																	   \n");
					sql.append( "   AND A.DSUDT IS NULL											                           \n");	
					if (!str1.equals("")) sql.append( " AND FDCODE = '" + str1 + "' 									   \n");
					if (!str2.equals("")) sql.append( " AND ACDATE = '" + str2 + "'										   \n" );
					sql.append( " ORDER BY TO_NUMBER(A.PSEQ)                    									       \n");
				   
                    //System.out.println(sql.toString());
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