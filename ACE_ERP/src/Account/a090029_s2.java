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
public class a090029_s2 extends HttpServlet {
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
				// 자산 이체 및 이동

				String  str1 = req.getParameter("v_str1");    //지점    
				String  str2 = req.getParameter("v_str2");    //관리항목   
				String  str3 = req.getParameter("v_str3");    //건설중인자산명
				String  str4 = req.getParameter("v_str4");    //상태 0 - 진행중 , 1- 완료
				    

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
        
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"FDCODE",     "ASTCIPCD", "ASTCIPNM",  "ASTYYMM",  "ASAQSDAT",
					                               "ASTNAME",    "ASTNM",    "ASTNBR",    "ASTRAMT",  "ASTRAMTY",
					                               "REMARK",     "ATCODE",   "ATKORNAM"
				                                }; 
       
				int[] intArrCN = new int[]{ 2,  5,100,  6,  8,
					                         30,100,  8, 13, 10,
				                          100,  7, 60 
				                           }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
					                          -1, -1, -1,  0,  0,
					                          -1, -1, -1
				                            }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.FDCODE,    A.ASTCIPCD, B.CDNAM AS ASTCIPNM,  A.ASTYYMM,  A.ASAQSDAT,  \n");
					sql.append( "        A.ASTNAME,   C.ASTNM,    A.ASTNBR,   A.ASTRAMT,    A.ASTRAMTY,          \n");
					sql.append( "        A.REMARK,    A.ATCODE,   D.ATKORNAM                                     \n");
					sql.append( "   FROM ACCOUNT.ASTCIPR A                                                       \n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL B ON A.ASTCIPCD = B.CDCODE AND B.CMTYPE ='2180'   \n");
					sql.append( "   LEFT JOIN ACCOUNT.ASTNAME  C ON A.ASTNAME  = C.ASTCD                         \n");
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE  D ON A.ATCODE   = D.ATCODE                        \n");
					if (!str1.equals(""))sql.append( "  AND  A.FDCODE  = '"+str1+"'  \n");      //지점                        
					if (!str3.equals(""))sql.append( "  AND  A.ASTCIPCD= '"+str3+"'  \n");		  //건설중인자산명              
					if (!str4.equals(""))sql.append( "  AND  A.STATUS  = '"+str4+"'  \n");		  //상태 0 - 진행중 , 1- 완료   
					sql.append( "  ORDER BY A.ASAQSDAT, A.ASTCIPCD,  A.ASTYYMM   \n");
					
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