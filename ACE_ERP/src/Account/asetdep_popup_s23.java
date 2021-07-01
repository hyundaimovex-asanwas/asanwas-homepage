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
public class asetdep_popup_s23 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //소속
				String  str2	= req.getParameter("v_str2");    //자산분류
				String  str3	= req.getParameter("v_str3");    //상각년월
				String  str4	= req.getParameter("v_str4");   //1구분
				String  str5	= req.getParameter("v_str5");	//2구분
				String  str6	= req.getParameter("v_str6");	//3구분
				String  str7	= req.getParameter("v_str7");	//시리얼
				String  str8	= req.getParameter("v_str8");	//원화구분

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASTYM", "ASTNBR", "ASTNAME", "ASTAQAMT","ASTYUSE",  "ASTAMT","ASTDAT","ASTNM","COSTCD","COSTNM"};  

				int[] intArrCN = new int[]{ 6, 11, 30, 13, 5,  13, 8, 30, 20, 40}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0, 2,  0, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.ASTYM,                                                                       		\n ");
					sql.append( "        B.ASTNBR, B.ASTNAME,                                                           	\n ");
					sql.append( "        CASE WHEN  '"+str8+"'=1  THEN COALESCE(A.ASTAQAMT,0) ELSE COALESCE(A.FOAQAMT,0) END AS  ASTAQAMT,  \n ");
					sql.append( "        COALESCE(C.ASTYUSE,0) AS ASTYUSE,                                              \n ");
					sql.append( "        CASE WHEN  '"+str8+"'=1  THEN  COALESCE(A.ASTAMT,0) ELSE COALESCE(A.FOATAMT,0) END AS  ASTAMT,  \n ");
					sql.append( "        NVL(A.ASTDAT,'0') AS ASTDAT,                                                			\n ");
					sql.append( "        X.ASTNM, A.COSTCD, TRIM(Y.CDNAM) AS COSTNM                                     	\n ");
					sql.append( "   FROM ACCOUNT.ASTYEPR A                    														\n ");
					sql.append( "   LEFT JOIN ACCOUNT.ASTMSTN B ON  A.FDCODE=B.FDCODE 	\n ");
					sql.append( "    										AND A.ATCODE=B.ATCODE 			\n ");
					sql.append( "    										AND A.AST1ST=B.AST1ST 			\n ");
					sql.append( "    										AND A.AST2ND=B.AST2ND 			\n ");
					sql.append( "    										AND A.AST3RD=B.AST3RD 			\n ");
					sql.append( "    										AND A.ASTSEQ=B.ASTSEQ 			\n ");					
					sql.append( "   LEFT JOIN ACCOUNT.ASTBASICN C ON A.FDCODE=C.FDCODE 	\n ");
					sql.append( "    										AND A.ATCODE=C.ATCODE 			\n ");
					sql.append( "    										AND A.AST1ST=C.AST1ST 			\n ");
					sql.append( "    										AND A.AST2ND=C.AST2ND 			\n ");
					sql.append( "    										AND A.AST3RD=C.AST3RD 			\n ");
					sql.append( "    										AND A.ASTSEQ=C.ASTSEQ 			\n ");		
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME X  ON B.AST2ND=X.AST2ND AND B.AST3RD = X.AST3RD AND B.ASTNAME = X.ASTCD  \n ");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL Y ON A.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'               									\n ");
					sql.append( "  WHERE 1 = 1 														\n ");
					if (!str1.equals("")) sql.append( " AND A.AST1ST = '" + str1 + "' 		\n ");    //지점
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' 		\n ");    //자산분류
					if (!str3.equals("")) sql.append( " AND A.ASTYM <= '" + str3 + "' 		\n ");    //년월
					if (!str4.equals("")) sql.append( " AND A.AST1ST = '" + str4 + "' 		\n ");
					if (!str5.equals("")) sql.append( " AND A.AST2ND = '" + str5 + "' 		\n ");
					if (!str6.equals("")) sql.append( " AND A.AST3RD = '" + str6 + "' 		\n ");
					if (!str7.equals("")) sql.append( " AND A.ASTSEQ = '" + str7 + "' 		\n ");
					sql.append( "  ORDER BY A.ASTYM \n ");		
			
					//System.out.println("asetdep_popup_s23 : \n" + sql.toString());
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