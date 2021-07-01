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
public class a050002_s01 extends HttpServlet {
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
        String  str6 = req.getParameter("v_str6");	//기수
				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";
        if(str6 == null) str6 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
	          "SEQNO"  , "VENDIDVS" , "VENDNAME" , "SHTCNT"  , "BLKCNT" ,
	          "REQAMT" , "VATAMT"   , "BSNSCND"  , "BSNSKND" , "VD_DIRECT",
	          "ADDRESS1","BSNS_CND","BSNS_KND"
				}; 



				int[] intArrCN = new int[]{
	          4,10,30, 7,2,
	          14,13,17,25,62,
	            132,62,62
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, 0, 0, 
					0, 0, -1, -1,-1,
					-1,-1,-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			          sql.append("\n SELECT TRIM(A.SEQNO) SEQNO       , TRIM(A.VENDIDVS) VENDIDVS , TRIM(A.VENDNAME) VENDNAME , TRIM(A.SHTCNT) SHTCNT   , TRIM(A.BLKCNT) BLKCNT   , ");
			          sql.append("\n        TRIM(A.REQAMT) REQAMT     , TRIM(A.VATAMT) VATAMT     , TRIM(A.BSNSCND) BSNSCND   , TRIM(A.BSNSKND) BSNSKND , TRIM(B.VD_DIRECT) VD_DIRECT , ");
			          sql.append("\n        TRIM(B.ADDRESS1) ADDRESS1 , TRIM(B.BSNS_CND) BSNS_CND , TRIM(B.BSNS_KND) BSNS_KND                            ");
			          sql.append("\n   FROM ACCOUNT.AVATRPT2 A , ( ");
			          sql.append("\n                             SELECT VEND_ID, MAX(VD_DIRECT) AS VD_DIRECT , MAX(ADDRESS1) AS ADDRESS1, MAX (BSNS_CND) AS BSNS_CND, MAX(BSNS_KND) AS BSNS_KND ");
			          sql.append("\n                             FROM ACCOUNT.GCZM_VENDER GROUP BY VEND_ID ");
			          sql.append("\n                              )B ");
			          sql.append("\n  WHERE A.VENDIDVS = B.VEND_ID ");
			          sql.append("\n    AND A.REQAMT+A.VATAMT<>0   ");
			          if(!str1.equals(""))sql.append("\n    AND A.FDCODE = '"+str1+"'                                     ");//지점
			          if(!str2.equals(""))sql.append("\n    AND A.ACCYY = '"+str2+"'                                    ");//년도
			          if(!str6.equals(""))sql.append("\n    AND A.ACCYYQT = '"+str6+"'                                     ");//기수
			          sql.append("\n ORDER BY A.SEQNO                                           ");
			          
			          //	logger.dbg.println(this, sql.toString());

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