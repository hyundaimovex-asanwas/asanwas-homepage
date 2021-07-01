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
public class a090001_s17 extends HttpServlet {
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
		CallableStatement stmt =null;
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

				String  str1 = req.getParameter("v_str1");          	//지점코드  FDCODE    VARCHAR(2)       
				String  str2 = req.getParameter("v_str2");  			//자산명   ASTNAME VARCHAR(30)             
				String  str3 = req.getParameter("v_str3");         	//자산중분류  필수   AST2ND  VARCHAR(2)      
				String  str4 = req.getParameter("v_str4");        	//자산소분류  필수  AST3RD   VARCHAR(2)        
				String  str5 = req.getParameter("v_str5");          //계정코드   필수    ATCODE   VARCHAR(7)  

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
			
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE",	    "ASTNAME",   "AST2ND",	    "AST3RD",        "ATCODE",	
		
                                                   "ASAQSDAT",	     "TAXNBR",	  "FSNBR",	     "DEPTCD",	    "EMPNO",		
		
                                                  "MNGTYPE",         "ASTSTAT",	  "ASCOSDIV",	  "COSTCD",   	 "ASAQSDIV",	

                                                  "GODDIV",		    "ASTCLASS",	   "ASTRIS",	  "ASTUNIT",	 "ASTQTY",		
                
                                                   "ASTSTD",	  "ASTAQAMT",	  "ASTYUSE",	  "ASTVALYMD",	 "MNGDPT",		
                
                                                "USEDPT",		  "USELOC",		  "BUYFROM",	  "MAKER",		  "ASTNOTE"  };  

				int[] intArrCN = new int[]{ 2,   30,     2,    2,     7,    	       
                                           8,    10,     6,     4,    7,     	       
                                           1,     1,     1,     6,     1,     
                                           1,     1,     1,     2,     10,                
                                           30,    13 ,  3,      8,      4,                   
                                          4,     30,    13,    30,  	50	}; 
					
				int[] intArrCN2 = new int[]{ -1,   -1,   -1,   -1,    -1, 
                                             -1,   -1,   -1,   -1,   -1,  
                                             -1,   -1,   -1,   -1,   -1,  
                                             -1,   -1,   -1,   -1,    0,		
                                             -1,       -1,    -1,  
                                            -1,    -1,  -1,    -1,   -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
	
					sql.append( " SELECT DISTINCT    ");
					sql.append( " A.FDCODE,          ");	 
					sql.append( " A.ASTNAME,          ");		 
					sql.append( " A.AST2ND,          ");		 
					sql.append( " A.AST3RD,          ");		 
					sql.append( " A.ATCODE,          ");			
					sql.append( " A.ASAQSDAT,          ");		 
					sql.append( " A.TAXNBR,          ");	 
					sql.append( " A.FSNBR,          ");		 
					sql.append( " A.DEPTCD,          ");		 
					sql.append( " A.EMPNO,          ");				
					sql.append( " B.MNGTYPE,          ");	   
					sql.append( " B.ASTSTAT,          ");		 
					sql.append( " B.ASCOSDIV,          ");		 
					sql.append( " B.COSTCD,          ");		 
					sql.append( " B.ASAQSDIV,          ");		 
					sql.append( " B.GODDIV,          ");			
					sql.append( " B.ASTCLASS,          ");		 
					sql.append( " B.ASTRIS,          ");		 
					sql.append( " B.ASTUNIT,          ");		 
					sql.append( " nvl(B.ASTQTY,0)  ASTQTY,         ");			
					sql.append( " B.ASTSTD,                  ");		 
					sql.append( "  nvl(B.ASTAQAMT,0)    ASTAQAMT,        ");		 
					sql.append( "  nvl(B.ASTYUSE,0)     ASTYUSE,          ");		 
					sql.append( " B.ASTVALYMD,          ");	 
					sql.append( " B.MNGDPT,          ");				
					sql.append( " B.USEDPT,          ");		 
					sql.append( " B.USELOC,          ");		 
					sql.append( " B.BUYFROM,          ");		 
					sql.append( " B.MAKER,          ");		 
					sql.append( " B.ASTNOTE	   ");
					sql.append( " FROM ACCOUNT.ASTMST A   ");
					sql.append( " LEFT JOIN  ACCOUNT.ASTBASIC B ON A.FDCODE=B.FDCODE   ");
					sql.append( "	   AND A.ATCODE=B.ATCODE AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD   ");	  
					sql.append( " WHERE	A.FDCODE IS NOT NULL	");	 

					//logger.dbg.println( this, sql.toString() );
					
/*********************************************************************************************/
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