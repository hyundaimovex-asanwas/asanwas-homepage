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
public class a080010_popup_s1 extends HttpServlet {
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
				String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//from 년월일         
				str[2]	= req.getParameter("v_str3");		//to   년월일          
				str[3]	= req.getParameter("v_str4");		//계정코드        
				str[4]	= req.getParameter("v_str5");		//구분
				str[5]	= req.getParameter("v_str6");		//추가계정
				str[6]	= req.getParameter("v_str7");		//세목구분
				str[7]	= req.getParameter("v_str8");		//세목
				
				
				for (int s=0;s<=7;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACTYYMM", "ACTDAT",  "ATCODE",  "FDCODE",  "FSDAT",
					                               "FSNBR",  "FSSEQ",   "SSDAT",   "SSNBR",   "DEAMT",
					                               "BGTDEPT","SATCODE", "REMARK",  "VEND_CD" , "VEND_NM"
				                               	  
					                                
                }; 

				int[] intArrCN = new int[]{  6,  8,  7,  2,  9,
					                          6,  5,  9,  6, 15,
                                              4,  2, 200, 13, 100  
					                        
				}; 
		 	
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1,  0,
					                          -1, -1, -1, -1,  -1
				                           
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					
					sql.append( " SELECT SUBSTR(A.ACTDAT,1,6) AS ACTYYMM,   A.ACTDAT,   A.ATCODE,  A.FDCODE,   A.FSDAT,  \n " );
					sql.append( "        A.FSNBR,   A.FSSEQ,  A.SSDAT,    A.SSNBR,    A.DEAMT,                           \n " );
					sql.append( "        Z.BGTDEPT, Z.SATCODE,TRIM(C.REMARK) REMARK,   Z.VEND_CD , ACCOUNT.FN_VENDNM(Z.VEND_CD) AS VEND_NM  \n " );
					sql.append( "     FROM ACCOUNT.GENENLED A ,                                                          \n " );
					sql.append( "     ( SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ,                                      \n " );
					sql.append( "               MAX(CASE WHEN X.FSREFCD ='0003' THEN X.FSREFVAL ELSE '' END) AS BGTDEPT, \n " );
					sql.append( "               MAX(CASE WHEN X.FSREFCD ='0020' THEN X.FSREFVAL ELSE '' END) AS VEND_CD, \n " );
					sql.append( "               MAX(CASE WHEN X.FSREFCD ='"+str[6]+"' THEN X.FSREFVAL ELSE '' END) AS SATCODE  \n " );
					sql.append( "          FROM ACCOUNT.GENENREF X , ACCOUNT.GENENLED Y                                  \n " );
					sql.append( "         WHERE X.FDCODE = Y.FDCODE                                                      \n " );
					sql.append( "           AND X.FSDAT = Y.FSDAT                                                        \n " );
					sql.append( "           AND X.FSNBR = Y.FSNBR                                                        \n " );
					sql.append( "        GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ                                    \n " );
					sql.append( "     ) Z , ACCOUNT.FSLIPDTL C                                                           \n " );
					sql.append( "    WHERE A.FDCODE = Z.FDCODE                                                  	      \n " );
					sql.append( "      AND A.FSDAT = Z.FSDAT                                                          	\n " );
					sql.append( "      AND A.FSNBR = Z.FSNBR                                                         	\n " );
					sql.append( "      AND A.FSSEQ = Z.FSSEQ                                                             \n " );
					sql.append( "      AND A.FDCODE = C.FDCODE                                                           \n " );
					sql.append( "      AND A.FSDAT = C.FSDAT                                                             \n " );
					sql.append( "      AND A.FSNBR  = C.FSNBR                                                            \n " );
					sql.append( "      AND A.FSSEQ = C.FSSEQ                                                             \n " );
					sql.append( "      AND A.FDCODE ='"+str[0]+"'                                                 	     \n " );
					sql.append( "      AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                 		         \n " );
					sql.append( "      AND (A.ATCODE ='"+str[3]+"' OR A.ATCODE='"+str[5]+"' )             	             \n " );
					sql.append( "      AND Z.BGTDEPT =  '"+str[4]+"'                                                     \n " );
					if(!str[7].equals(""))sql.append( " AND Z.SATCODE =  '"+str[7]+"'                                    \n " );
					   
					//System.out.println("a080010_popup_s1 : \n" + sql.toString());
					//logger.dbg.println(this,sql.toString());

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