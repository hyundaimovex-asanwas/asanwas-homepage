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
public class a010010_s2 extends HttpServlet {
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
				// 전체조회
				String  str1	= req.getParameter("v_str1");   //사번
				String  str2  = req.getParameter("v_str2");   //화면명

			
				if(str1 == null) str1 = ""; //지점       
				if(str2 == null) str2 = ""; //회계년월   

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "PGMID",   "PGMNM",	  "RPGMID"
        																																		
				}; 

				int[] intArrCN = new int[]{ 10, 40, 10
 				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
				
					/* 
					sql.append(" SELECT TRIM(PGMID)PGMID, TRIM(PGMNM)PGMNM, TRIM(RPGMID)RPGMID  \n ");
					sql.append("   FROM COMMON.USERPGM                                           						\n ");
					sql.append("  WHERE SYSID = 'ACC'                                           						\n ");
					if(!str1.equals(""))sql.append("    AND USRID ='"+str1+"'                   						\n ");
					
					*/
					
					sql.append(" SELECT  PGM_IDX AS PGMID, TRIM(PGMNM)PGMNM, TRIM(RPGMID)RPGMID \n ");
					sql.append("   FROM COMMON.MENU_DETAIL \n ");
					sql.append("  WHERE FLAG ='T'          \n ");
					sql.append("    AND ( UPPER(SYSID)= 'ACC' OR UPPER(RPGMID) LIKE 'SI%'      \n ");
					sql.append("       OR UPPER(SUBSTR(RPGMID,1,3)) BETWEEN 'A01' AND 'A99' )  \n ");
					if(!str2.equals(""))sql.append("    AND TRIM(PGMNM) LIKE '"+str2+"%'       \n ");
					
					              	
					//System.out.println("a010010_s2::"+sql.toString());
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