// * 개인정보관리 : 개인정보조회 (조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import sales.common.StringUtil;

public class bm011s_s01 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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

		        String  str1	= GauceReq.getParameter("v_str1"); //회사코드
				String  str2	= GauceReq.getParameter("v_str2"); //주민/여권번호
				String  str3	= new String(GauceReq.getParameter("v_str3").getBytes("8859_1"),"KSC5601");//성명

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					                                "VEND_SID",		"VEND_NM",		"TEAM_CD",		"DETAIL_NM",		"WORK_NO",
					                                "CUST_NM",		"REGI_NO",		"PASS_NO",		"TEL_NO",				"MOBILE_NO",
					                                "POSITIONS",		"ADDRESS1",		"ADDRESS2",		"ADDRESS"
														};

				int[] intArrCN = new int[] {
					                              10,		50,	5,		50,	20,
					                              30,		13,	20,	20,	20,
					                              30,		80,	60,	140
												};

				int[] intArrCN2 = new int[]{
					                             -1,	-1,	-1,	-1,	-1,
					                             -1,	-1,	-1,	-1,	-1,
					                             -1,	-1,	-1,	-1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																						\n" );
				sql.append( "   A.CLIENT_SID VEND_SID,															\n" );
				sql.append( "   D.CLIENT_NM VEND_NM,															\n" );
				sql.append( "   A.TEAM_CD,																			\n" );
				sql.append( "   C.DETAIL_NM,																			\n" );
				sql.append( "   B.WORK_NO,																			\n" );
				sql.append( "   B.CUST_NM,																			\n" );
				sql.append( "   B.REGI_NO,																				\n" );
				sql.append( "   B.PASS_NO,																				\n" );
				sql.append( "   B.TEL_NO,																				\n" );
				sql.append( "   B.MOBILE_NO,																			\n" );
				sql.append( "   B.POSITIONS,																			\n" );
				sql.append( "   B.ADDRESS1,																			\n" );
				sql.append( "   B.ADDRESS2,																			\n" );
				sql.append( "   LTRIM(B.ADDRESS1) || LTRIM(B.ADDRESS2) ADDRESS				\n" );
				sql.append( " FROM SALES.TCM010 A																\n" );
				sql.append( "   JOIN SALES.TCU010 B ON A.CUST_SID = B.CUST_SID					\n" );
				sql.append( "   LEFT JOIN SALES.TSY010 C ON A.TEAM_CD = C.DETAIL				\n" );
				sql.append( "                      AND C.HEAD    = 'CM003' AND ITEM1 = 'Y'				\n" );
				sql.append( "   JOIN SALES.TCU030 D ON A.CLIENT_SID = D.CLIENT_SID			\n" );
				sql.append( " WHERE 1=1																				\n" );

				if (!str1.equals("")) sql.append( "  AND A.CLIENT_SID =" + str1 + "						\n");
				if (!str2.equals("")) sql.append( "  AND B.REGI_NO = '" + str2 + "'						\n");
				if (!str3.equals("")) sql.append( "  AND B.CUST_NM LIKE '%" + str3 + "%'			\n");

				sql.append( "  ORDER BY A.TEAM_CD,B.CUST_NM													");
				//StringUtil.printMsg("bm011s_s01", sql.toString(),this);
				//logger.dbg.println(this,sql.toString());
				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

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