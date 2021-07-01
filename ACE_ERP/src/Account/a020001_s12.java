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
public class a020001_s12 extends HttpServlet {
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
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//계정
				str[1]	= req.getParameter("v_str2");		//계정
				str[2]	= req.getParameter("v_str3");		//거래처
				str[3]	= req.getParameter("v_str4");		//거래처

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

			  String[] strArrCN = new String[]{ "CNT"  };                              
       
				int[] intArrCN = new int[]{5}; 

				int[] intArrCN2 = new int[]{0};
																	 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT COUNT(A.FDCODE) CNT                  										\n");
					sql.append( "   FROM ACCOUNT.FSLIPDTL A, ACCOUNT.FSLIPREF B         					\n");
					sql.append( "   LEFT JOIN ACCOUNT.BANJAEREL C ON A.FDCODE =C.FDCODE 				\n");
					sql.append( " 										 AND A.FSDAT = C.TSDAT          					\n");
					sql.append( " 										 AND A.FSNBR = C.TSNBR          					\n");
					sql.append( " 										 AND A.FSSEQ = C.TSSEQ          					\n");
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER D ON B.FSREFVAL = D.VEND_CD   	\n");
					sql.append( " WHERE A.FDCODE =B.FDCODE                            								\n");
					sql.append( "   AND A.FSDAT = B.FSDAT                               									\n");
					sql.append( "   AND A.FSNBR = B.FSNBR                               									\n");
					sql.append( "   AND A.FSSEQ = B.FSSEQ                               									\n");
					sql.append( "   AND (A.ATCODE BETWEEN '"+str[0]+"' AND '"+str[1]+"')						\n");
					sql.append( "   AND B.FSREFCD ='0020'                               									\n");
					sql.append( "   AND (B.FSREFVAL BETWEEN '"+str[2]+"' AND '"+str[3]+"')						\n");
					sql.append( "   AND C.BANJAEYN <>'Y'                                									\n");
				
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