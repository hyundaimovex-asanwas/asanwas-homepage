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
public class a030006_s1_OLD extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점코드
				String  str2  = req.getParameter("v_str2"); //년초 일
				String  str3  = req.getParameter("v_str3"); //하루 전일
				String  str4  = req.getParameter("v_str4"); //현재일

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACTDAT","ACTDAT2", "ATCODE", "ATKORNAM", "ATPRTSEQ", "DETOT", "DECRVAL",
												"CRCASH", "DECASH", "CRDEVAL", "CRTOT" }; 

				int[] intArrCN = new int[]{   8, 8,  7,  66,  7,  15,  15,
												15, 15, 15, 15 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1,  -1,  -1,   0,   0,   0,
												0,  0,  0,  0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ACTDAT            AS ACTDAT, A.ACTDAT  AS ACTDAT2, \n" );
					sql.append( "        A.ATCODE            AS ATCODE,   \n" );
					sql.append( "        B.ATKORNAM          AS ATKORNAM, \n" );
					sql.append( "        B.ATPRTSEQ          AS ATPRTSEQ, \n" );
					sql.append( "        IFNULL(SUM(DETOT),0)          AS DETOT,   \n" );
					sql.append( "        IFNULL(SUM(DETOT - CRCASH),0) AS DECRVAL, \n" );
					sql.append( "        IFNULL(SUM(CRCASH),0)         AS CRCASH,  \n" );
					sql.append( "        IFNULL(SUM(DECASH),0)         AS DECASH,  \n" );
					sql.append( "        IFNULL(SUM(CRTOT - DECASH),0) AS CRDEVAL, \n" );
					sql.append( "        IFNULL(SUM(CRTOT),0)          AS CRTOT    \n" );
					sql.append( " FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B        \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE \n" );
					if(!str1.equals(""))
						sql.append( "   AND A.FDCODE = '"+str1+"' \n" );
					sql.append( " AND A.ACTDAT = '"+str4+"'     \n" );
					sql.append( " AND A.ATCODE NOT IN ('1110101','1110102') \n" );
					sql.append( " AND B.ATDAYBALYN = 'Y' \n" );
					sql.append( " AND B.ATUSEYN = 'Y'    \n" );
					sql.append( " GROUP BY A.ACTDAT, A.ATCODE, B.ATKORNAM, B.ATPRTSEQ \n" );
					sql.append( " UNION ALL \n" );

					sql.append( " SELECT A.ACTDAT            AS ACTDAT, A.ACTDAT   AS ACTDAT2, \n" );
					sql.append( "        '8888888'           AS ATCODE, \n" );
					sql.append( "        '           금   일   소   계'          AS ATKORNAM, \n" );
					sql.append( "        '77777'             AS ATPRTSEQ, \n" );
					sql.append( "        SUM(DETOT)          AS DETOT, \n" );
					sql.append( "        IFNULL(SUM(DETOT - CRCASH),0) AS DECRVAL, \n" );
					sql.append( "        IFNULL(SUM(CRCASH),0)         AS CRCASH,  \n" );
					sql.append( "        IFNULL(SUM(DECASH),0)         AS DECASH,  \n" );
					sql.append( "        IFNULL(SUM(CRTOT - DECASH),0) AS CRDEVAL, \n" );
					sql.append( "        IFNULL(SUM(CRTOT),0)          AS CRTOT    \n" );
					sql.append( " FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B        \n" );
					sql.append( " WHERE A.ATCODE = B.ATCODE     \n" );
					if(!str1.equals(""))
						sql.append( "   AND A.FDCODE = '"+str1+"' \n" );
					sql.append( " AND A.ACTDAT = '"+str4+"'     \n" );
					sql.append( " AND A.ATCODE NOT IN ('1110101','1110102') \n" );
					sql.append( " AND B.ATDAYBALYN = 'Y' \n" );
					sql.append( " AND B.ATUSEYN = 'Y'    \n" );
					sql.append( " GROUP BY A.ACTDAT      \n" );
					sql.append( " UNION ALL  \n" );

					sql.append( " SELECT '22001231'                 AS ACTDAT,''  AS ACTDAT2, \n" );
					sql.append( "        '8999999'                  AS ATCODE, \n" );
					sql.append( "        '           금일잔고/전일잔고'        AS ATKORNAM, \n" );
					sql.append( "        '88888'                    AS ATPRTSEQ, \n" );
					sql.append( "        IFNULL((C.DEBF + C.DETO - C.CRTO),0) AS DETOT, \n" );
					sql.append( "        0                          AS DECRVAL, \n" );
					sql.append( "        IFNULL((C.DEBF + C.DETO - C.CRTO),0) AS CRCASH, \n" );
					sql.append( "        IFNULL(DEBF,0)                       AS DECASH, \n" );
					sql.append( "        0                          AS CRDEVAL,          \n" );
					sql.append( "        IFNULL(DEBF,0)                       AS CRTOT   \n" );
					sql.append( " FROM (  \n" );
					sql.append( "   SELECT '22001231', \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN CRCASH END) AS CRTO, \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN DECASH END) AS DETO, \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT >= '"+str2+"' AND A.ACTDAT <= '"+str3+"' THEN DECASH - CRCASH ELSE 0 END) AS DEBF \n" );
					sql.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B \n" );
					sql.append( "   WHERE A.ATCODE = B.ATCODE \n" );
					if(!str1.equals(""))
						sql.append( "   AND A.FDCODE = '"+str1+"' \n" );
					sql.append( "   AND A.ACTDAT BETWEEN '"+str2+"' AND '"+str4+"' \n" );
					sql.append( "   AND A.ATCODE NOT IN ('1110101','1110102') \n" );
					sql.append( "   AND B.ATDAYBALYN = 'Y' \n" );
					sql.append( "   AND B.ATUSEYN = 'Y' \n" );
					sql.append( " ) C \n" );
					sql.append( " UNION ALL  \n" );

					sql.append( " SELECT '22001231'                              AS ACTDAT,''   AS ACTDAT2, \n" );
					sql.append( "        '9999999'                               AS ATCODE, \n" );
					sql.append( "        '           합             계'                                  AS ATKORNAM, \n" );
					sql.append( "        '99999'                                 AS ATPRTSEQ, \n" );
					sql.append( "        IFNULL((C.DEBF + C.DECASH - C.CRCASH) + DETOT,0)  AS DETOT, \n" );
					sql.append( "        IFNULL((DETOT - CRCASH),0)                        AS DECRVAK, \n" );
					sql.append( "        IFNULL(CRCASH + (C.DEBF + C.DECASH - C.CRCASH),0) AS CRCASH, \n" );
					sql.append( "        IFNULL(DECASH + DEBF,0)                           AS DECASH, \n" );
					sql.append( "        IFNULL((CRTOT - DECASH),0)                        AS CRDEVAL, \n" );
					sql.append( "        IFNULL(CRTOT + DEBF,0)                            AS CRTOT \n" );
					sql.append( " FROM ( \n" );
					sql.append( "   SELECT '22001231', ''     AS ACTDAT2, \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN CRCASH ELSE 0 END) AS CRCASH, \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN DECASH ELSE 0 END) AS DECASH, \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN CRTOT  ELSE 0 END) AS CRTOT,  \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT = '"+str4+"' THEN DETOT  ELSE 0 END) AS DETOT,  \n" );
					sql.append( "     SUM(CASE WHEN A.ACTDAT >= '"+str2+"' AND A.ACTDAT <= '"+str3+"' THEN DECASH - CRCASH ELSE 0 END) AS DEBF \n" );
					sql.append( "   FROM ACCOUNT.TOTALBAL A,ACCOUNT.ACTCODE B \n" );
					sql.append( "   WHERE A.ATCODE = B.ATCODE  \n" );
					if(!str1.equals(""))
					sql.append( "   AND A.FDCODE = '"+str1+"' \n " );
					sql.append( "   AND A.ACTDAT BETWEEN '"+str2+"' AND '"+str4+"' \n" );
					sql.append( "   AND A.ATCODE NOT IN ('1110101','1110102') \n" );
					sql.append( "   AND B.ATDAYBALYN = 'Y' \n" );
					sql.append( "   AND B.ATUSEYN = 'Y' \n" );
					sql.append( " ) C \n" );
					sql.append( " ORDER BY 1,5 \n" );

					logger.dbg.println(this,sql.toString());

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