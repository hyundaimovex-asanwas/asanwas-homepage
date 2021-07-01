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
public class actcode_fund_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //계정코드 
				String  str2	= req.getParameter("v_str2"); //계정명
				String  str3	= req.getParameter("v_str3"); //자금구분
				String  str4	= req.getParameter("v_str4"); //계정구분
			
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";

				if (str3.equals("A")){
						str3="'00','10','20','30','40','50','60'";
				}else if(str3.equals("B")){
					  str3="'10','20','30','40','50','60'";
				}else if(str3.equals("")){
						str3 ="'"+str3+"'";
				}else if(str3.equals("C")){
						str3 = "C";//전체
				}

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",  "ATKORNAM", "FUNDIV", "FUNDIVNM"	}; 

				int[] intArrCN = new int[] {  7, 66,  2, 62	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT"  );
					sql.append( " A.ATCODE,	A.ATKORNAM,	A.FUNDIV, B.CDNAM FUNDIVNM " );
			        sql.append( " FROM ACCOUNT.ACTCODE A													" );
			        sql.append( " LEFT JOIN ACCOUNT.COMMDTIL B ON A.FUNDIV = B.CDCODE AND B.CMTYPE='0053'" );
			        sql.append( " WHERE A.ATCODE IS NOT NULL																	" );
					if (!str1.equals("")) sql.append( "   AND A.ATCODE LIKE '" + str1 + "%'							" );
					if (!str2.equals("")) sql.append( "   AND A.ATKORNAM  LIKE '%" + str2 + "%'	 				" );
					if (!str3.equals("")&&!str3.equals("C")) sql.append( " AND A.FUNDIV  IN ("+str3+")	" );
					if (!str4.equals("")&&str4.equals("ATUSEYN")) sql.append( " AND A.ATUSEYN='Y'	" );
					sql.append( " ORDER BY A.FUNDIV,A.ATCODE " );

					
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