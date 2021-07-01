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
public class a090004_s2 extends HttpServlet {
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
				String  str6	= req.getParameter("v_str6");    //취득일자FROM
				String  str7	= req.getParameter("v_str7");    //취득일자TO

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASETNO", "ASTNAME", "ASTSOJE", "ASTPOST", "ASTPYUNG", 
					"ASTREGYMD", "ACARTYPE", "ACARNO","ACARBEGI","AMMODEL",
					"AMWEIGHT", "CDNAM"};  

				int[] intArrCN = new int[]{ 11, 30, 8, 30, 6, 
					20, 8, 2, 20, 10,
					20, 30}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
					-1, -1, -1, -1, -1, 
					0, -1}; 

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
					sql.append( " COALESCE(A.ASTNAME,'') as ASTNAME, ");
					sql.append( " COALESCE(B.ASTSOJE,'') AS ASTSOJE, COALESCE(B.ASTPOST,'') AS ASTPOST, "); 
					sql.append( " COALESCE(B.ASTPYUNG,'') AS ASTPYUNG, COALESCE(B.ASTREGYMD,'') AS ASTREGYMD, ");
					sql.append( " COALESCE(C.ACARTYPE,'') AS ACARTYPE, COALESCE(C.ACARNO,'') AS ACARNO, ");		    
					sql.append( " COALESCE(C.ACARBEGI,'') AS ACARBEGI, COALESCE( D.AMMODEL,'') AS AMMODEL, ");
					sql.append( " COALESCE(D.AMWEIGHT,0) AS AMWEIGHT, X.CDNAM ");
					sql.append( " FROM (((ACCOUNT.ASTMST A LEFT OUTER JOIN ACCOUNT.ASTADINFO1 B ON ");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST AND ");
					sql.append( " A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ) LEFT ");
					sql.append( " OUTER JOIN ACCOUNT.ASTADINFO2 C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE ");
					sql.append( " AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD ");
					sql.append( " AND A.ASTSEQ=C.ASTSEQ) LEFT OUTER JOIN ACCOUNT.ASTADINFO3 D ON ");
					sql.append( " A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE AND A.AST1ST=D.AST1ST AND ");
					sql.append( " A.AST2ND=D.AST2ND AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ) LEFT ");
					sql.append( " OUTER JOIN ACCOUNT.ASTMST E ON A.FDCODE=E.FDCODE AND A.ATCODE=E.ATCODE AND ");
					sql.append( " A.AST1ST=E.AST1ST AND A.AST2ND=E.AST2ND AND A.AST3RD=E.AST3RD AND ");
					sql.append( " A.ASTSEQ=E.ASTSEQ ");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL X ON A.ASTNAME=X.CDCODE AND X.CMTYPE='2161' \n");
					if (!str6.equals("")) sql.append( " WHERE E.ASAQSDAT BETWEEN '" + str6 + "' " );
					if (!str7.equals("")) sql.append( " AND '" + str7 + "' " );
					if (!str1.equals("")) sql.append( " WHERE B.AST1ST = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.ATCODE = '" + str2 + "' " );
					if (!str3.equals("")) sql.append( " AND A.AST2ND = '" + str3 + "' " );
					if (!str4.equals("")) sql.append( " AND A.AST3RD = '" + str4 + "' " );
					if (!str5.equals("")) sql.append( " AND B.MNGDPT = '" + str5 + "' " );
								
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