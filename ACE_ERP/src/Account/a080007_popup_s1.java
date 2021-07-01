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
public class a080007_popup_s1 extends HttpServlet {
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
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//from 년월일         
				str[2]	= req.getParameter("v_str3");		//to   년월일          
				str[3]	= req.getParameter("v_str4");		//계정코드        
				str[4]	= req.getParameter("v_str5");		//구분
				str[5]	= req.getParameter("v_str6");		//추가계정
				
				
				for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACTYYMM","ACTDAT", "ATCODE","ATKORNAM",
					                                "FDCODE", "FSDAT",  "FSNBR", "FSSEQ",
					                                "SSDAT",  "SSNBR",  "DEAMT", "BGTCD",  "BGTDPT",
				                               	  "REMARK", "VENDGB", "VEND_CD", "VEND_NM"
					                                
        }; 

				int[] intArrCN = new int[]{  6,  8,  7, 66, 
					                           2,  9,  6,  5,
                                     9,  6, 15,  4,  4,
					                         200,  4, 13, 62  
				}; 
		 	
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                           -1, -1,  0, -1, -1,
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
					sql.append( " SELECT SUBSTR(A.ACTDAT,1,6) AS ACTYYMM,   A.ACTDAT,   A.ATCODE,   F.ATKORNAM, \n " );
					sql.append( "        A.FDCODE,   A.FSDAT,    A.FSNBR,   A.FSSEQ,                            						\n " );
					sql.append( "        A.SSDAT,    A.SSNBR,    A.DEAMT,   B.FSREFCD BGTCD, B.FSREFVAL BGTDPT, 	\n " );
					sql.append( "        TRIM(C.REMARK) REMARK,                                                 								\n " );
					sql.append( "        D.FSREFCD  VENDGB ,  D.FSREFVAL VEND_CD, E.VEND_NM                     			\n " );
					sql.append( "   FROM ACCOUNT.GENENLED A                                                     							\n " );
					sql.append( "   LEFT JOIN ACCOUNT.GENENREF B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT   \n " );
					sql.append( "                               AND A.FSNBR  = B.FSNBR  AND A.FSSEQ = B.FSSEQ   				\n " );
					sql.append( "                               AND B.FSREFCD ='0003' --예산부서                							\n " );
					sql.append( "   LEFT JOIN ACCOUNT.GENENREF D ON A.FDCODE = D.FDCODE AND A.FSDAT = D.FSDAT   \n " );
                    sql.append( "                               AND A.FSNBR  = D.FSNBR  AND A.FSSEQ = D.FSSEQ   				\n " );
					sql.append( "                               AND D.FSREFCD ='0020' --거래처                  							\n " );
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT   \n " );
					sql.append( "                               AND A.FSNBR  = C.FSNBR  AND A.FSSEQ = C.FSSEQ   				\n " );
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER E ON D.FSREFVAL = E.VEND_CD                   		\n " );
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE AND F.ATUSEYN='Y'        \n " );
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                  	\n " );
					sql.append( "    AND A.FSDAT = B.FSDAT                                                          	\n " );
					sql.append( "    AND A.FSNBR = B.FSNBR                                                         	\n " );
					sql.append( "    AND A.FSSEQ = B.FSSEQ                                                          \n " );
					sql.append( "    AND A.FDCODE ='"+str[0]+"'                                                      	\n " );
					sql.append( "    AND A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'                		\n " );
					sql.append( "    AND (A.ATCODE ='"+str[3]+"' OR A.ATCODE='"+str[5]+"' )             	\n " );
                    sql.append( "    AND B.FSREFVAL IN ( SELECT X.BGTDPT                                    	\n " );
					sql.append( "                          FROM ACCOUNT.BGTMATCH X                              \n " );
					sql.append( "                         WHERE X.BGTDIV ='"+str[4]+"'                          		\n " );
					sql.append( "                           AND SUBSTR(A.ACTDAT,1,6) BETWEEN X.BGTFRYM AND X.BGTTOYM )      \n " );

					//System.out.println("a080007_popup_s1 : \n" + sql.toString());
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