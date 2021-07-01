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
public class a050006_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산번호
				String  str3 = req.getParameter("v_str3");    //자산명
				String  str4 = req.getParameter("v_str4");    //자산중분류
				String  str5 = req.getParameter("v_str5");    //자산소분류
				String  str6 = req.getParameter("v_str6");    //규격
				String  str7 = req.getParameter("v_str7");    //소분류
				String  str8 = req.getParameter("v_str8");    //소분류

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"FDCODE", "FSDAT", "FSNBR","FSSEQ", "FSREFCD", 
					"FSREFVAL", "SSDAT" , "SSNBR", "CMTYPE", "CDCODE", 
					"CDNAM", "VEND_CD", "VEND_ID", "ATCODE", "CD_NAM", "REMARK"
						}; 

					
				int[] intArrCN = new int[]{ 2, 9, 6, 5, 4,
												20, 9, 6, 4,	20, 
					40, 13, 15, 7, 40, 132
					}; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
														-1, -1, -1, -1, -1, 
					-1, -1, -1, -1, -1, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.FDCODE,A.FSDAT, A.FSNBR,  A.FSSEQ, A.FSREFCD, 								\n");
					sql.append( " A.FSREFVAL,A.SSDAT, A.SSNBR, B.CMTYPE, B.CDCODE, 										\n");
					sql.append( " B.CDNAM, C.VEND_CD, C.VEND_ID, D.ATCODE, E.CDNAM AS CD_NAM, F.REMARK 		\n");
					sql.append( " FROM ACCOUNT.GENENREF A 																			\n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.COMMDTIL B ON B.CMTYPE = A.FSREFCD AND B.CDCODE = A.FSREFVAL 	\n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.GCZM_VENDER C ON C.VEND_CD = A.FSREFVAL 										\n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.GENENLED D ON D.FDCODE = A.FDCODE AND A.FSDAT = D.FSDAT 				\n");
					sql.append( " AND A.FSNBR = D.FSNBR AND A.FSSEQ = D.FSSEQ  																		\n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.COMMDTIL E ON E.CDCODE = D.ATCODE  												\n");
					sql.append( " LEFT OUTER JOIN ACCOUNT.FSLIPDTL F ON F.FDCODE = A.FDCODE AND A.FSDAT=F.FSDAT  					\n");
					sql.append( " AND A.FSNBR=F.FSNBR AND A.FSSEQ = F.FSSEQ  									\n");				
					sql.append( " WHERE A.FSREFCD = '0020' 																	\n");
					sql.append( " AND E.CMTYPE='2160' 																			\n");
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' 										\n" );
					if (!str2.equals("")) sql.append( " AND A.SSDAT BETWEEN 'A" +str2+ "' AND 'Z" +str3+"' 		\n" );
					if (!str4.equals("")) sql.append( " AND D.ATCODE BETWEEN '" + str4 + "' AND '"+ str5 + "' 	\n" );

					//System.out.println("# Query : \n" + sql);
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