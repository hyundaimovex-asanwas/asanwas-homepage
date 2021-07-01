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
public class a090004_s10 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //사업장
				String  str2	= req.getParameter("v_str2");    //기준년월
				String  str3	= req.getParameter("v_str3");    //자산중분류

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
          "JSGUBUN", "NEYONG", "ASNBR", "JSNAME", "GETDATE", 
          "GETAMTY", "GETAMT", "SANGNUAMT","DANGGIAMT","JANJONAMT",
          "YONGDO", "GUIPCHEO","JEJAKCHEO","COSTNM","BIGO"
        };  

				int[] intArrCN = new int[]{ 
          40, 3, 2, 40, 8,
          10, 13, 13, 13, 13,
          30, 62,62,40,50}; 
					
				int[] intArrCN2 = new int[]{ 
          -1, 0, -1, -1, -1,
            4, 0, 0, 0, 0,
            -1, -1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					
					sql.append("\n SELECT Z.CDNAM AS JSGUBUN,                                                                                                   ");
					sql.append("\n        C.ASTYUSE AS NEYONG,                                                                                                  ");
					sql.append("\n        CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S'                                                                   ");
					sql.append("\n                      WHEN '03' THEN 'K' WHEN '04' THEN 'G' END||                                                             ");
					sql.append("\n        CASE A.AST2ND WHEN '11' THEN 'L' WHEN '12' THEN 'B' WHEN '13' THEN 'S'                                                ");
					sql.append("\n                      WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F'                                                ");
					sql.append("\n                      WHEN '17' THEN 'E' END||                                                                                ");
					sql.append("\n        CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C'                                                ");
					sql.append("\n                      WHEN '04' THEN 'O' WHEN '05' THEN 'T' WHEN '06' THEN 'F'                                                ");
					sql.append("\n                      WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ AS ASNBR,                                           ");
					sql.append("\n        X.CDNAM AS JSNAME,                                                                                                    ");
					sql.append("\n        B.ASAQSDAT AS GETDATE,                                                                                                ");
					sql.append("\n        C.ASTAQAMTY AS GETAMTY,                                                                                               ");
					sql.append("\n        C.ASTAQAMT AS GETAMT,                                                                                                 ");
					sql.append("\n        A.ABDEPRAMT AS SANGNUAMT,                                                                                             ");
					sql.append("\n        A.ACDEPRAMT AS DANGGIAMT,                                                                                             ");
					sql.append("\n        C.ASTAQAMT - A.ABDEPRAMT - A.ACDEPRAMT AS JANJONAMT,                                                                  ");
					sql.append("\n        C.USELOC AS YONGDO,                                                                                                   ");
					sql.append("\n        V.VEND_NM AS GUIPCHEO,                                                                                                ");
					sql.append("\n        U.VEND_NM AS JEJAKCHEO,                                                                                               ");
					sql.append("\n        Y.CDNAM AS COSTNM,                                                                                                    ");
					sql.append("\n        C.ASTNOTE AS BIGO                                                                                                     ");
					sql.append("\n   FROM ACCOUNT.ASTDEPR A,ACCOUNT.ASTMST B,                                                                                   ");
					sql.append("\n        ACCOUNT.ASTBASIC C LEFT OUTER JOIN ACCOUNT.GCZM_VENDER V ON C.BUYFROM = V.VEND_CD                                     ");
					sql.append("\n                           LEFT OUTER JOIN ACCOUNT.GCZM_VENDER U ON C.MAKER = V.VEND_CD                                       ");
					sql.append("\n                           LEFT OUTER JOIN (SELECT * FROM ACCOUNT.COMMDTIL WHERE CMTYPE = '0030') Y ON C.COSTCD = Y.CDCODE,   ");
					sql.append("\n        ACCOUNT.COMMDTIL X,ACCOUNT.COMMDTIL Z                                                                                 ");
					sql.append("\n  WHERE A.FDCODE = B.FDCODE AND A.ATCODE = B.ATCODE AND A.AST1ST = B.AST1ST                                                   ");
					sql.append("\n    AND A.AST2ND = B.AST2ND AND A.AST3RD = B.AST3RD AND A.ASTSEQ = B.ASTSEQ                                                   ");
					sql.append("\n    AND A.FDCODE = C.FDCODE AND A.ATCODE = C.ATCODE AND A.AST1ST = C.AST1ST                                                   ");
					sql.append("\n    AND A.AST2ND = C.AST2ND AND A.AST3RD = C.AST3RD AND A.ASTSEQ = C.ASTSEQ                                                   ");
					sql.append("\n    AND A.AST2ND >= '11'                                                                                                      ");
					if(str2!=null && !str2.equals("")){
					sql.append("\n    AND SUBSTR(B.ASAQSDAT,1,6) <= '"+str2+"'	                                                                           ");
					}
					sql.append("\n    AND B.ASTNAME = X.CDCODE                                                                                                  ");
					sql.append("\n    AND X.CMTYPE = '2161'                                                                                                     ");
					sql.append("\n    AND A.AST2ND = Z.CDCODE                                                                                                   ");
					sql.append("\n    AND Z.CMTYPE = '2101'                                                                                                     ");
					if(str2!=null && !str2.equals("")){
					sql.append("\n    AND SUBSTR(A.DEPRENDDT,1,6) = '"+str2+"'                                                                          ");
					}
					if(str1!=null && !str1.equals("")){
					sql.append("\n    AND A.FDCODE LIKE '"+str1+"%'                                                                                  ");
					}
					if(str3!=null && !str3.equals("")){
					sql.append("\n    AND A.AST2ND LIKE '"+str3+"%'	                                                                                 ");
					}
					sql.append("\n ORDER BY A.AST2ND,C.ASTYUSE,A.AST3RD,A.ASTSEQ                                                                                ");
					
			
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