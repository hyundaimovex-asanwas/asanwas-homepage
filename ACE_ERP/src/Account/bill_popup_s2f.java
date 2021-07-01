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
public class bill_popup_s2f extends HttpServlet {
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
				String [] str =new String[6];
				str[0] = req.getParameter("v_str1");  //자금구분
				str[1] = req.getParameter("v_str2");  //거래처
				str[2] = req.getParameter("v_str3");  //처리구분
				str[3] = req.getParameter("v_str4");  //지점
				str[4] = req.getParameter("v_str5");  //계정
				str[5] = req.getParameter("v_str6");  //거래처명
				
				
				for (int s=0;s<=5;s++ ){
					if(str[s]==null) str[s]="";
				}
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",	"ATCODE", "FUNDDIV",	"REFCODE2",	"VEND_CD",
				                                  "VEND_NM", "DRAMT", "CRAMT",    "STRDATE", "ENDDATE" ,  "BANCOD", "BANKNM"}; 

				int[] intArrCN = new int[]{ 2,  7,  2, 30, 13,
					                         62, 15, 15,  8,  8,  6, 66 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1,  0,  0, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT A.FDCODE, A.ATCODE, A.FUNDDIV,A.REFCODE2,  A.VEND_CD,B.VEND_NM, " );
					sql.append( "        COALESCE(DRAMT,0) DRAMT,  " );
					sql.append( "        COALESCE(CRAMT,0) CRAMT,  " );
					sql.append( "        A.STRDATE, A.ENDDATE, A.BANCOD ,C.CDNAM BANKNM   " );
					sql.append( "  FROM ACCOUNT.AFUNDLDG A                                " );
					sql.append( "  LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD       " );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL C ON A.BANCOD = C.CDCODE AND C.CMTYPE='0022'  " );
					sql.append( "  WHERE A.FDCODE = '" +str[3]+ "'                                          " );
					sql.append( "    AND A.ATCODE = '" +str[4]+ "'                                          " );
					sql.append( "    AND A.FUNDDIV = '" +str[0]+ "'                                         " );
if(!str[1].equals("")||!str[5].equals(""))sql.append( " AND ( A.VEND_CD = '" +str[1]+ "'  OR B.VEND_NM LIKE '%"+str[5]+"%') " );
				  sql.append( "    AND A.STATDIV = '" +str[2]+ "'                                        " );
									
         // logger.dbg.println(this,sql.toString());
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