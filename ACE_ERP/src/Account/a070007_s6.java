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
public class a070007_s6 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");  //지점코드  
				String  str2	= req.getParameter("v_str2");	 //실사일자

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK"};

				int[] intArrCN	= new int[]{	1 };
			
				int[] intArrCN2 = new int[]{ -1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {			
					/* 20160908 jys 수정
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT														");
					sql.append( " CASE WHEN ACDATE IN ('"+str2+"')					");
					sql.append( " THEN 'Y' ELSE 'N' END AS CHK						");
					sql.append( " FROM ACCOUNT.ASURVEND							");
					sql.append( " WHERE FDCODE IS NOT NULL						");
					if(!str1.equals(""))	sql.append( " AND FDCODE='"+str1+"'		");
					if(!str2.equals(""))	sql.append( " AND ACDATE='"+str2+"'		");
					*/
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT CASE WHEN REMARK IS NULL THEN 'N' ELSE REMARK END AS CHK ");
					sql.append( " FROM ACCOUNT.ACASHSUR							");
					sql.append( " WHERE FDCODE IS NOT NULL						");
					if(!str1.equals(""))	sql.append( " AND FDCODE='"+str1+"'		");
					if(!str2.equals(""))	sql.append( " AND ACDATE='"+str2+"'		");
  
					//System.out.println("a070007_s6::"+sql.toString());

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