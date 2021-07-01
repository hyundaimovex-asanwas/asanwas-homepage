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
public class a050001_s2 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//지점
				String  str2 = req.getParameter("v_str2");	//년도
				String  str3 = req.getParameter("v_str3");	//기수기간from
				String  str4 = req.getParameter("v_str4");	//기수기간from
				String  str5 = req.getParameter("v_str5");	//매입/매출 구분

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "VEND_ID","CNT","TAXSUM","TAXVATAMT","COM_CNT","PER_CNT"}; 

				int[] intArrCN  = new int[]{ 13,  2, 15, 13,  2,  2	}; 
			
				int[] intArrCN2 = new int[]{ -1,  0,  0,  0,  0,  0 }; 

				for (int i=0; i<strArrCN.length; i++) {
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(B.VEND_ID) VEND_ID,COUNT(A.TAXNBR) CNT,									\n");
					sql.append( "				 SUM(TAXSUM) TAXSUM, SUM(TAXVATAMT) TAXVATAMT,							\n");
					sql.append( "	CASE WHEN LENGTH(VARCHAR(B.VEND_ID))='10' THEN COUNT(A.TAXNBR) ELSE 0 END AS COM_CNT,	\n");
					sql.append( "	CASE WHEN LENGTH(VARCHAR(B.VEND_ID))='13' THEN COUNT(A.TAXNBR) ELSE 0 END AS PER_CNT		\n");
					sql.append( " FROM ACCOUNT.ATTAXMST A,ACCOUNT.GCZM_VENDER B										\n");
					sql.append( " WHERE A.VEND_CD=B.VEND_CD	AND B.VEND_ID IS NOT NULL									\n");
					if(!str1.equals(""))  sql.append( " AND A.COCODE = '"+str1+"'														\n");
					if(!str2.equals(""))  sql.append( " AND SUBSTR(A.TAXDAT,1,4) ='"+str2+"'										\n");
					if(!str3.equals(""))  sql.append( " AND A.TAXDAT BETWEEN '"+str3+"' AND '"+str4+"'							\n");
					if(str5.equals("B")) sql.append( " AND A.TAXKND IN ('1','2')															\n");//매출 과세구분
					if(str5.equals("B")) sql.append( " AND A.TAXNBR LIKE 'B%'															\n");//매출 과세구분
					sql.append( " GROUP BY B.VEND_ID																						\n");
					sql.append( " ORDER BY VEND_ID																							\n");

					//System.out.println("# Query : \n" + sql);
					//logger.dbg.println(this, sql.toString());

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