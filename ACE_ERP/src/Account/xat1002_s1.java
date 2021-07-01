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
public class xat1002_s1 extends HttpServlet {

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
		
		System.out.println(" 시작 \n");	

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "JOUNO",	    "JOU_NAME",     "JOUSEQ",	"ATCODE",    "ATKORNAM",	  "ATDECR",	 "ACCCHK" ,	"CHKNAME",
						                           "VENDCD",	"VENDNM",	   
						                           "FSREFCD1",  "FSREFCDNM1","FSREFVAL1","FSREFVALNM1",	
						                           "FSREFCD2",	"FSREFCDNM2","FSREFVAL2","FSREFVALNM2",   
						                           "FSREFCD3",  "FSREFCDNM3","FSREFVAL3","FSREFVALNM3",	
						                           "FSREFCD4",	"FSREFCDNM4","FSREFVAL4","FSREFVALNM4",   
						                           "FSREFCD5",	"FSREFCDNM5","FSREFVAL5","FSREFVALNM5",   
						                           "FSREFCD6",  "FSREFCDNM6","FSREFVAL6","FSREFVALNM6",	
						                           "FSREFCD7",	"FSREFCDNM7","FSREFVAL7","FSREFVALNM7",
						                           "USEGB",	    "ENDDT",	  "SORTSEQ",	
						                           "CREATE_ID",	"CREATE_DATE", "UPDATE_ID",	"UPDATE_DATE",				                                  
				                                 }; 

				int[] intArrCN = new int[]{ 3,	 30,  2,  7,  66,  13,  5, 30,	
						                    13,	100,  
						                     4,  30, 30, 30,	
						                     4,	 30, 30, 30,
						                     4,  30, 30, 30,	
						                     4,	 30, 30, 30,
						                     4,	 30, 30, 30,
						                     4,  30, 30, 30,	
						                     4,	 30, 30, 30,
						                     1,   8,  2,	
						                    10,	 10, 10,  10 
					                        }; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1, -1, -1,  -1, 
						                      -1,- 1, 
						                      -1, -1,-1, -1,		
						                      -1, -1,-1, -1,	
						                      -1, -1,-1, -1,		
						                      -1, -1,-1, -1,	
						                      -1, -1,-1, -1,	
						                      -1, -1,-1, -1,		
						                      -1, -1,-1, -1,
						                      -1, -1,	0,	
						                      -1, -1, -1, -1
					                         }; 

                
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT A.JOUNO , B.JOU_NAME, A.JOUSEQ,A.ATCODE,C.ATKORNAM, A.ATDECR,A.ACCCHK , 	A.CHKNAME,	     \n");
					sql.append( "        A.VENDCD,A.VENDNM,           \n");
					sql.append( "        A.FSREFCD1,A.FSREFCDNM1,A.FSREFVAL1,A.FSREFVALNM1,      \n");
					sql.append( "        A.FSREFCD2,A.FSREFCDNM2,A.FSREFVAL2,A.FSREFVALNM2,      \n");
					sql.append( "        A.FSREFCD3,A.FSREFCDNM3,A.FSREFVAL3,A.FSREFVALNM3,      \n");
					sql.append( "        A.FSREFCD4,A.FSREFCDNM4,A.FSREFVAL4,A.FSREFVALNM4,      \n");
					sql.append( "        A.FSREFCD5,A.FSREFCDNM5,A.FSREFVAL5,A.FSREFVALNM5,      \n");
					sql.append( "        A.FSREFCD6,A.FSREFCDNM6,A.FSREFVAL6,A.FSREFVALNM6,      \n");
					sql.append( "        A.FSREFCD7,A.FSREFCDNM7,A.FSREFVAL7,A.FSREFVALNM7,      \n");
					sql.append( "        A.USEGB,A.ENDDT,A.SORTSEQ,   \n");
					sql.append( "        A.CREATE_ID,A.CREATE_DATE,A.UPDATE_ID,A.UPDATE_DATE \n");
					sql.append( "   FROM ACCOUNT.TBIF_ACCJOU A, ACCOUNT.TBIF_ACCJOUMST B, ACCOUNT.ACTCODE C 		 \n");
					
					sql.append( " WHERE A.JOUNO =B.JOUNO													 	     \n");
					sql.append( "   AND A.ATCODE =C.ATCODE AND C.ATUSEYN='Y'							 	         \n");
					if (!str1.equals("")) sql.append( " AND A.JOUNO='"+str1+"'	                                 	 \n");
					if (!str2.equals("")) sql.append( " AND B.JOU_NAME LIKE '%"+str2+"%'	                      	 \n");
					sql.append( "ORDER BY A.SORTSEQ									 	                          	 \n");
				
					
					//System.out.println("xat1002_s1 \n" + sql.toString());					
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		        stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  	System.out.println("xat1002_s1 error: \n" + e);	
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