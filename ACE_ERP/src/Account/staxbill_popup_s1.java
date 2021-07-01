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
public class staxbill_popup_s1 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");     //취득일자 fro
				String  str3	= req.getParameter("v_str3");    //취득일자 to  
				String  str4	= req.getParameter("v_str4");    //소속(관리자)   
				
				String  str5	= req.getParameter("v_str5");    //소속(관리자)   
				String  str6	= req.getParameter("v_str6");    //자산중분류 
				String  str7	= req.getParameter("v_str7");    //자산소분류     
				//String  str7	= req.getParameter("v_str7");     //자산번호    
				String  str8	= req.getParameter("v_str8");    //ast1st         
			

               //  logger.dbg.println(this,"str11:" + str11); 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{  "CHECK", "ASTSEQ", "TAXNBR", "SEQ","SEQ2",	 "ASAQSDAT",  "AST2ND", 	
													  	"ASTNAME",   "ASTUNIT",   
													  	"ASTQTY",    "ASTAQAMT",   "MNGDPT",   "USEDPT",   
													    "ASTYUSE",
													    "FDCODE", "ATCODE" , "AST1ST", "AST3RD", "CNT"
				}; 
 
				int[] intArrCN = new int[]{ 1, 5, 11, 11,11, 10, 2,
					                          30, 2,
					                           10, 13, 4, 4,
					                          3,
					                          2, 7, 2, 2, 3
					}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1,-1,-1, -1, -1,
					                         -1,  -1,
					                         0, 0, -1, -1,
					                         0,
					                         -1, -1, -1, -1, -1 
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT 'F' AS CHECK,                													");
					//sql.append( "  DISTINCT    ");
					sql.append( " A.ASTSEQ,  A.TAXNBR,                      /*일련번호*/ 						\n ");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ, 	\n");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ2,	\n");
					sql.append( " A.ASAQSDAT,                     /*취득일자*/    								\n");
					sql.append( " A.AST2ND,                       /*자산중분류*/   									\n");
					sql.append( " A.ASTNAME,                      /*자산이름*/    									\n");
					sql.append( " B.ASTUNIT,                      /*단위*/     										\n");
					sql.append( " nvl(B.ASTQTY,0)   ASTQTY,     /*수량*/    									\n");
					sql.append( " nvl(B.ASTAQAMT,0) ASTAQAMT,   /*취득금액*/   							\n");
					sql.append( " B.MNGDPT,                       /*관리부서*/  					\n");
					sql.append( " B.USEDPT,                       /*사용부서*/   					\n");
					sql.append( " nvl(B.ASTYUSE,0) ASTYUSE,   /*내용년수*/ 					\n");
					sql.append( " A.FDCODE, A.ATCODE,A.AST1ST, A.AST3RD, X.CNT  	\n");
					sql.append( " FROM ACCOUNT.ASTMST A,  	 									\n");
					sql.append( " (  																			\n");
					sql.append( " SELECT COUNT(*) CNT FROM ACCOUNT.ASTMST C   	\n");
					sql.append( " WHERE C.TAXNBR = '"+str2+"'  									\n");
					sql.append( " ) X  																		\n");

					
					sql.append( " LEFT JOIN  ACCOUNT.ASTBASIC B ON A.FDCODE=B.FDCODE   \n");
					sql.append( "	   AND A.ATCODE=B.ATCODE AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD  AND A.ASTSEQ=B.ASTSEQ  \n");	  
					sql.append( " WHERE	A.FDCODE IS NOT NULL 								\n");	 
					sql.append( " AND A.TAXNBR = '"+str2+"'  										\n");	 



/*	        if (!str1.equals(""))  sql.append( "  AND   A.FDCODE = '"+str1+"'  \n");
 					if (!str2.equals(""))  sql.append( "  AND   A.ASAQSDAT BETWEEN  '"+str2+"' AND '"+str3+"' \n"); 
 					if (!str4.equals(""))  sql.append( "  AND   B.ASTSTAT = '"+str4+"'   \n");
					if (!str5.equals(""))  sql.append( "  AND   B.MNGDPT = '"+str5+"'   \n");
			    if (!str6.equals(""))  sql.append( "  AND   A.AST2ND = '"+str6+"'  \n");				
				
					if (!str7.equals(""))   sql.append( "  AND  A.AST3RD = '"+str7+"' \n");
 				//	if (!str7.equals(""))   sql.append( "  AND  A.ASTSEQ    = '"+str7+"'  \n");
 					if (!str8.equals(""))   sql.append( "  AND	A.AST1ST  = '"+str8+"'  \n");
*/

					sql.append( "	order by int(seq)    \n");	
					
					//System.out.println("# Query : \n" + sql);
				
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