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
public class a070010_s1 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //계정과목
				String  str3	= req.getParameter("v_str3");    //일자FROM
				String  str4	= req.getParameter("v_str4");    //일자TO
				String  str5	= req.getParameter("v_str5");    //은행
				String  str6	= req.getParameter("v_str6");    //구분

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"BANCOD","FUNDDIV","REFCODE2","AMT",		"EAMT", 
					"INRATE","CURDIV", "EXRATE",  "STRDATE","ENDDATE" ,
					"BANNAM"
				}; 

				int[] intArrCN = new int[]{ 
					6, 2,30, 15, 15, 
					7, 3, 8, 8, 8,
					66
				};
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, 0, 0, 
					0, -1, 0, -1, -1,
				  -1
				};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.BANCOD,A.FUNDDIV,A.REFCODE2,A.DRAMT-A.CRAMT AS AMT,A.DRFAMT-A.CRFAMT as EAMT,\n");
					sql.append( " A.INRATE,A.CURDIV,A.EXRATE,A.STRDATE,A.ENDDATE,RTRIM(D.CDNAM) BANNAM					\n");
					sql.append( " FROM ACCOUNT.AFUNDLDG	A																\n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.BANCOD=D.CDCODE AND D.CMTYPE='0022' --은행	        \n");
					sql.append( " WHERE A.FDCODE IS NOT NULL						\n");
					
					
					  
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "'  \n" );
					if (!str2.equals("")) sql.append( " AND A.ATCODE = '" + str2 + "'  \n" );
					if (!str3.equals("")) sql.append( " AND A.STRDATE BETWEEN '"+str3+"' AND '"+str4+"'\n" );
					if (!str5.equals("")) sql.append( " AND A.BANCOD = '" + str5 + "'  \n" );
					if (!str6.equals("")) sql.append( " AND A.FUNDDIV = '" + str6 + "' \n" );
					
					//	logger.dbg.println(this,sql.toString());
                    System.out.println("a070010_s1::"+sql.toString());
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