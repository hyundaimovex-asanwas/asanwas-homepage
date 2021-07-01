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
public class a080010_s1 extends HttpServlet {
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
				String [] str = new String [5];
				str[0]	= req.getParameter("v_str1");		//지점                  
				str[1]	= req.getParameter("v_str2");		//from년월           
				str[2]	= req.getParameter("v_str3");		//to년월          
				str[3]	= req.getParameter("v_str4");		//계정명        
				str[4]	= req.getParameter("v_str5");		//계정코드

				for (int s=0;s<=4;s++) {
					if (str[s]==null) str[s] = "";
				}
				
			    String strYYYY = str[2].substring(0,4 ); 
				int intYYYY = Integer.parseInt(strYYYY);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","PRTNAM","ATPRTSEQ","SATGB", "SATCODE","SATNAM","BGTDPT", "BGTDPTNM", "AMT", "XATCODE"  }; 

				int[] intArrCN = new int[]{  7,  66, 4,  4,  2, 50,  4, 50, 15, 7  	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,-1,  -1, -1, 0, -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT K.ATCODE, V.ATKORNAM PRTNAM, V.ATPRTSEQ, NVL(K.SATGB,'')SATGB, NVL(K.SATCODE,'')SATCODE, NVL(K.CDNAM,'') SATNAM,        \n " );
					sql.append( "        K.BGTDEPT BGTDPT, D.CDNAM BGTDPTNM, SUM(K.DEAMT) AMT , MAX(K.XATCODE) XATCODE                                           \n " );
					sql.append( "   FROM(                                                                                                                        \n " );
					sql.append( "     SELECT CASE WHEN F.ATCODE='' OR F.ATCODE IS NULL THEN Z.ATCODE ELSE F.ATCODE END ATCODE,                                   \n " );
					sql.append( "            C.ATKORNAM PRTNAM, C.ATPRTSEQ, Z.SATGB, Z.SATCODE, D.CDNAM, Z.BGTDEPT, SUM(Z.DEAMT)DEAMT, Z.ATCODE XATCODE          \n " );
					sql.append( "       FROM(                                                                                                                    \n " );
					sql.append( "            SELECT Y.FDCODE, Y.FSDAT, Y.FSNBR, Y.FSSEQ, Y.ATCODE,                                                               \n " );
					sql.append( " 	          MAX(Y.BGTDPTGB)BGTDPTGB,MAX(Y.BGTDEPT)BGTDEPT, MAX(Y.SATGB)SATGB, MAX(Y.SATCODE)SATCODE, SUM(Y.DEAMT)DEAMT         \n " );
					sql.append( "              FROM (                                                                                                            \n " );
					sql.append( "                    SELECT A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ, A.ATCODE,                                                       \n " );
					//sql.append( " 		                    B.FSREFCD BGTDPTGB, B.FSREFVAL BGTDEPT, '0' SATGB, '0' SATCODE , A.DEAMT                             \n " );
					sql.append( " 		                    B.FSREFCD BGTDPTGB,                                                                                  \n " );
					sql.append( "  					        CASE WHEN (A.ACTDAT LIKE '2016%' AND B.FSREFVAL='4001') THEN '1080'                                  \n " );
					sql.append( "  					             WHEN (A.ACTDAT LIKE '2016%' AND B.FSREFVAL='4511') THEN '3440'                                  \n " );
					sql.append( "  					             WHEN (A.ACTDAT LIKE '2016%' AND B.FSREFVAL='4312') THEN '3090'                                  \n " );
					sql.append( "  					             WHEN (A.ACTDAT LIKE '2016%' AND B.FSREFVAL='4222') THEN '3430'                                  \n " );
					sql.append( "  					             WHEN (A.ACTDAT LIKE '2016%' AND B.FSREFVAL='4251') THEN '2690'                                  \n " );
					sql.append( "  					        ELSE B.FSREFVAL END BGTDEPT,                                                                         \n " );
					sql.append( " 		                   '0' SATGB, '0' SATCODE , A.DEAMT                                                                      \n " );
					sql.append( "                      FROM ACCOUNT.GENENLED A,ACCOUNT.GENENREF B                                                                \n " );
					sql.append( "                     WHERE A.FDCODE = B.FDCODE                                                                                  \n " );
					sql.append( "                       AND A.FSDAT = B.FSDAT                                                                                    \n " );
					sql.append( "                       AND A.FSNBR = B.FSNBR                                                                                    \n " );
					sql.append( "                       AND A.FSSEQ = B.FSSEQ                                                                                    \n " );
					sql.append( "                       AND A.FDCODE ='"+str[0]+"'                                                                               \n " );
					sql.append( "                       AND A.ACTDAT BETWEEN  '"+str[1]+"01' AND '"+str[2]+"31'                                                  \n " );
					if(!str[4].equals(""))sql.append( " AND A.ATCODE = '"+str[4]+"'                                                                              \n " );
					sql.append( "                       AND A.ATCODE >'4400000' AND A.ATCODE < '4510000'                                                         \n " );
					sql.append( "                       AND B.FSREFCD ='0003'                                                                                    \n " );
					sql.append( "                     UNION ALL                                                                                                  \n " );
					sql.append( "                    SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, X.ATCODE,                                                       \n " );
					sql.append( " 		          '0' BGTDPTGB,'0' BGTDEPT,  X.FSREFCD SATGB , X.FSREFVAL SATCODE, 0 DEAMT                                       \n " );
					sql.append( "                      FROM(                                                                                                     \n " );
					sql.append( "                            SELECT A.FDCODE, A.FSDAT, A.FSNBR, A.FSSEQ, A.ATCODE, B.FSREFCD, B.FSREFVAL, 0 DEAMT,  '0' SATCODE  \n " );
					sql.append( "                              FROM ACCOUNT.GENENLED A,ACCOUNT.GENENREF B                                                        \n " );
					sql.append( "                             WHERE A.FDCODE = B.FDCODE                                                                          \n " );
					sql.append( "                               AND A.FSDAT = B.FSDAT                                                                            \n " );
					sql.append( "                               AND A.FSNBR = B.FSNBR                                                                            \n " );
					sql.append( "                               AND A.FSSEQ = B.FSSEQ                                                                            \n " );
					sql.append( "                               AND A.FDCODE ='"+str[0]+"'                                                                       \n " );
					sql.append( "                               AND A.ACTDAT BETWEEN  '"+str[1]+"01' AND '"+str[2]+"31'                                          \n " );
					if(!str[4].equals(""))sql.append( "         AND A.ATCODE = '"+str[4]+"'                                                                      \n " );
					sql.append( "                               AND A.ATCODE >'4400000' AND A.ATCODE < '4510000'                                                 \n " );
					sql.append( "                         )X, ACCOUNT.COMMDTIL C                                                                                 \n " );
					sql.append( "                     WHERE X.ATCODE = C.CDCODE AND X.FSREFCD =C.GBCD AND C.CMTYPE ='2220'                                       \n " );
					sql.append( "                  )Y                                                                                                            \n " );
					sql.append( "           GROUP BY  Y.FDCODE, Y.FSDAT, Y.FSNBR, Y.FSSEQ, Y.ATCODE                                                              \n " );
					sql.append( "     )Z                                                                                                                         \n " );
					sql.append( "     LEFT JOIN ACCOUNT.ACTCODE C ON Z.ATCODE = C.ATCODE AND C.ATUSEYN='Y'                                                       \n " );
					sql.append( "     LEFT JOIN ACCOUNT.COMMDTIL D ON D.CDCODE = Z.SATCODE AND D.CMTYPE = Z.SATGB                                                \n " );
					sql.append( "     LEFT JOIN ACCOUNT.ACTMATCH F ON F.BATCODE = Z.ATCODE                                                                       \n " );
					sql.append( "     GROUP BY F.ATCODE, Z.ATCODE,C.ATKORNAM, C.ATPRTSEQ, Z.SATGB, Z.SATCODE, D.CDNAM, Z.BGTDEPT, Z.SATCODE ,Z.ATCODE            \n " );
					sql.append( " ) K                                                                                                                            \n " );
					sql.append( "  LEFT JOIN ACCOUNT.ACTCODE V ON V.ATCODE = K.ATCODE AND V.ATUSEYN='Y'                                                          \n " );
					sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL D ON K.BGTDEPT = D.CDCODE AND CMTYPE ='0003'                                                       \n " );
					sql.append( " GROUP BY  K.ATCODE, V.ATKORNAM , V.ATPRTSEQ, K.SATGB, K.SATCODE, K.CDNAM, K.BGTDEPT, D.CDNAM                                   \n " );
					sql.append( " ORDER BY  V.ATPRTSEQ,K.SATCODE,   K.BGTDEPT                                                                                    \n " );
					
					//System.out.println("a080010_s1 : \n" + sql.toString());
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