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
public class a090004_s3 extends HttpServlet {
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
				String  str3	= req.getParameter("v_str3");    //자산중분류
				String  str4	= req.getParameter("v_str4");    //자산소분류
				String  str5	= req.getParameter("v_str5");    //관리부서
				String  str6	= req.getParameter("v_str6");    //이동일자from
				String  str7	= req.getParameter("v_str7");    //이동일자to

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASETNO", "ASTNAME", "MNGDPT", "USEDPT", "MOVDATE", "MOVNOTE", "ACOSTCD", "WRDT","WRID", "CDNAM", "ACOSTNM" };  

				int[] intArrCN = new int[]{ 11, 30, 4, 4, 8, 30, 6, 8, 7, 30, 30}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S' " );
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END|| ");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S' ");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E' ");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C' ");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F' ");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASETNO, ");
					sql.append( " COALESCE(B.ASTNAME,'') as ASTNAME, COALESCE(A.AMNGDEPT,'') as MNGDPT,  ");
					sql.append( " COALESCE(A.AUSEDEPT,'') as USEDPT, COALESCE( A.MOVDATE,'') AS MOVDATE, COALESCE(A.MOVNOTE,'') AS MOVNOTE, "); 
					sql.append( " COALESCE(A.ACOSTCD,'') AS ACOSTCD, COALESCE(A.WRDT,'') AS WRDT, COALESCE(A.WRID,'') AS WRID, X.CDNAM, (Y.CDNAM) AS ACOSTNM ");    
					sql.append( " FROM ACCOUNT.ASTMOVING A LEFT OUTER JOIN ACCOUNT.ASTMST B ON ");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST ");
					sql.append( " AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ ");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL X ON B.ASTNAME=X.CDCODE AND X.CMTYPE='2161' \n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Y ON A.ACOSTCD = Y.CDCODE AND Y.CMTYPE='0030' \n");
					if (!str6.equals("")) sql.append( " WHERE A.MOVDATE BETWEEN '" + str6 + "' " );
					if (!str7.equals("")) sql.append( " AND '" + str7 + "' " );
					if (!str1.equals("")) sql.append( " AND A.AST1ST = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.ATCODE = '" + str2 + "' " );
					if (!str3.equals("")) sql.append( " AND A.AST2ND = '" + str3 + "' " );
					if (!str4.equals("")) sql.append( " AND A.AST3RD = '" + str4 + "' " );
					if (!str5.equals("")) sql.append( " AND A.AMNGDEPT = '" + str5 + "' " );

					//logger.dbg.println( this, sql.toString() );
					
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