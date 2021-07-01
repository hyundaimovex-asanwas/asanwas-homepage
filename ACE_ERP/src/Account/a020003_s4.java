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
public class a020003_s4 extends HttpServlet {
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
			  
				String [] str = new String [3];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//반제전표일자
				str[2]	= req.getParameter("v_str3");		//반제전표번호
				
       
				for (int s=0;s<=2;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FSNUM",     "ATCODE",    "ATKORNAM", "CHAAMT",  "DAEAMT",
					                                "REMARK",    "FDCODE",	  "BTSDAT",   "BTSNBR",  "BTSSEQ",  "DEPTCD",
				                                  "DEPTNM",    "VENDCD",    "VENDNM",   "FSREFCD", "FSREFVAL",
																					"FSREFNM",   "TSDAT",     "TSNBR",    "TSSEQ"
				                                };

				int[] intArrCN = new int[]{  3,  7,  66,  15, 15,
					                         132,  2,   9,   6,  5,  4, 
					                          50, 13,  62,   4, 20,
					                          40,  9,   6,   5 
					                         }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  0,  0,
					                           -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
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

					/*
					sql.append( "  SELECT  B.FSNUM, B.ATCODE, E.ATKORNAM,                                                					\n" );
					sql.append( "          CASE WHEN B.ATDECR ='1' THEN COALESCE(A.BJDEAMT,0)                            			\n" );
					sql.append( "  	            WHEN B.ATDECR ='2' THEN 0 END CHAAMT,                                    					\n" );
					sql.append( "          CASE WHEN B.ATDECR ='1' THEN 0                                                						\n" );
					sql.append( "  	            WHEN B.ATDECR ='2' THEN COALESCE(A.BJCRAMT,0) END DAEAMT,                		\n" );
					sql.append( "  B.REMARK, A.FDCODE, A.BTSDAT,  A.BTSNBR, A.BTSSEQ,                                    			\n" );
					sql.append( "  D.DEPTCD, F.CDNAM DEPTNM,                                                             							\n" );
					sql.append( "  D.VENDCD, G.CDNAM VENDNM,  D.FSREFCD, D.FSREFVAL, H.CDNAM FSREFNM,                   \n" );
					sql.append( "  A.TSDAT,  A.TSNBR, A.TSSEQ                                                            							\n" );    
					sql.append( "  FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPDTL B, ACCOUNT.FSLIPREF C, ACCOUNT.BANJAEMST D \n" );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE E ON B.ATCODE = E.ATCODE                                    				\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL F ON D.DEPTCD = F.CDCODE AND F.CMTYPE='0002'               	\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL G ON D.VENDCD = G.CDCODE AND G.CMTYPE='0020'               	\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL H ON D.FSREFVAL = H.CDCODE AND H.CMTYPE=D.FSREFCD        \n" );
					
					sql.append( " WHERE A.FDCODE = '"+str[0]+"'                                              	\n" );
					sql.append( " AND A.BTSDAT = '"+str[1]+"'                                                		\n" );
					sql.append( " AND A.BTSNBR = '"+str[2]+"'                                                		\n" );
					sql.append( " AND A.FDCODE = B.FDCODE                                                    	\n" );
					sql.append( " AND A.BTSDAT = B.FSDAT                                                     		\n" );
					sql.append( " AND A.BTSNBR = B.FSNBR                                                     	\n" );
					sql.append( " AND A.BTSSEQ = B.FSSEQ                                                     	\n" );
					sql.append( " AND A.FDCODE = C.FDCODE                                                    	\n" );
					sql.append( " AND A.BTSDAT = C.FSDAT                                                     		\n" );
					sql.append( " AND A.BTSNBR = C.FSNBR                                                     	\n" );
					sql.append( " AND A.BTSSEQ = C.FSSEQ                                                     	\n" );
					sql.append( " AND C.FSREFCD='0020'                                                       		\n" );
					sql.append( " AND A.FDCODE =D.FDCODE  														\n" );
					sql.append( " AND A.TSDAT = D.TSDAT   															\n" );
					sql.append( " AND A.TSNBR = D.TSNBR   														\n" );
					sql.append( " AND A.TSSEQ = D.TSSEQ   														\n" );
					*/
	
					sql.append( "  SELECT  B.FSNUM, B.ATCODE, E.ATKORNAM,                                                					\n" );
					sql.append( "          CASE WHEN B.ATDECR ='1' THEN COALESCE(A.BJDEAMT,0)                            			\n" );
					sql.append( "  	            WHEN B.ATDECR ='2' THEN 0 END CHAAMT,                                    					\n" );
					sql.append( "          CASE WHEN B.ATDECR ='1' THEN 0                                                						\n" );
					sql.append( "  	            WHEN B.ATDECR ='2' THEN COALESCE(A.BJCRAMT,0) END DAEAMT,                		\n" );
					sql.append( "  B.REMARK, A.FDCODE, A.BTSDAT,  A.BTSNBR, A.BTSSEQ,                                    			\n" );
					sql.append( "  D.DEPTCD, F.CDNAM DEPTNM,                                                             							\n" );
					sql.append( "  D.VENDCD, G.CDNAM VENDNM,  D.FSREFCD, D.FSREFVAL, H.CDNAM FSREFNM,                   \n" );
					sql.append( "  A.TSDAT,  A.TSNBR, A.TSSEQ                                                            							\n" );    
					sql.append( "  FROM ACCOUNT.BANJAEREL A 																						\n" );
					sql.append( "  LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE                                    		\n" );
					sql.append( " AND A.BTSDAT = B.FSDAT                                                     											\n" );
					sql.append( " AND A.BTSNBR = B.FSNBR                                                     										\n" );
					sql.append( " AND A.BTSSEQ = B.FSSEQ                                                     										\n" );
					sql.append( "  LEFT JOIN ACCOUNT.FSLIPREF C ON  A.FDCODE = C.FDCODE                                  			\n" );
					sql.append( " AND A.BTSDAT = C.FSDAT                                                     											\n" );
					sql.append( " AND A.BTSNBR = C.FSNBR                                                     										\n" );
					sql.append( " AND A.BTSSEQ = C.FSSEQ                                                     										\n" );
					sql.append( " AND C.FSREFCD='0020'                                                       											\n" );
					sql.append( "  LEFT JOIN ACCOUNT.BANJAEMST D ON  A.FDCODE =D.FDCODE											\n" );
					sql.append( " AND A.TSDAT = D.TSDAT   																								\n" );
					sql.append( " AND A.TSNBR = D.TSNBR   																							\n" );
					sql.append( " AND A.TSSEQ = D.TSSEQ   																							\n" );						
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE E ON B.ATCODE = E.ATCODE                                    				\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL F ON D.DEPTCD = F.CDCODE AND F.CMTYPE='0002'               	\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL G ON D.VENDCD = G.CDCODE AND G.CMTYPE='0020'               	\n" );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL H ON D.FSREFVAL = H.CDCODE AND H.CMTYPE=D.FSREFCD        \n" );
					sql.append( " WHERE A.FDCODE = '"+str[0]+"'                                              	\n" );
					sql.append( " AND A.BTSDAT = '"+str[1]+"'                                                		\n" );
					sql.append( " AND A.BTSNBR = '"+str[2]+"'                                                		\n" );

					//System.out.println("# Query : " + sql);	
					//logger.dbg.println(this , sql.toString());
					
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