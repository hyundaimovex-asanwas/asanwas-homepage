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
public class a030009_s2_BB extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//회계년월(전)기
				str[2] = req.getParameter("v_str3");	//회계년월(당)기
				str[3] = req.getParameter("v_str4");	//사업장코드
				str[4] = req.getParameter("v_str5");	//본부코드
		
				for(int i=0;i<=4;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				String strbyyyy = str[1].substring(0,4); //전기년
				String strayyyy = str[2].substring(0,4); //당기년

//      logger.dbg.println(this, "strbyyyy"+strbyyyy);
//			logger.dbg.println(this, "strayyyy"+strayyyy);
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE","PRTNAM","LTTOT","RTTOT","COM",
																					"READ","LTTOT2","RTTOT2","COM2","READ2"
																				}; 

				int[] intArrCN = new int[] {  7,  66,  15,  15,  60,  
																			1,  15,  15,  60,   1 }; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,   0,   0,  -1,
																		 -1,   0,   0,  -1,  -1	}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();			
						sql.append( " SELECT X.ATCODE,X.PRTNAM,																														\n");
						sql.append( "				 COALESCE(X.LTTOT,0)  LTTOT, COALESCE(X.RTTOT,0)  RTTOT, X.COM,X.READ,				\n");
						sql.append( "				 COALESCE(Y.LTTOT2,0) LTTOT2,COALESCE(Y.RTTOT2,0) RTTOT2,Y.COM2,Y.READ2				\n");
						sql.append( "	FROM																																								\n");
						sql.append( " (SELECT D.ATCODE,D.PRTNAM,D.PRTSEQ,																									\n");
						sql.append( "        CASE WHEN D.LRDIV = 'L' OR D.LRDIV = 'B'																			\n");
						sql.append( "             THEN CASE WHEN C.ATDECR = '1'																						\n");
						sql.append( "             THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS LTTOT,									\n");
						sql.append( "        CASE WHEN D.LRDIV = 'R' THEN CASE WHEN C.ATDECR = '1'												\n");
						sql.append( "             THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS RTTOT,									\n");
						//sql.append( "        CASE WHEN D.LRDIV = 'B' THEN D.PRTRT END COM,																\n");
						sql.append( "        CASE WHEN D.PRTRT <>'' AND D.PRTRT IS NOT NULL THEN D.PRTRT END COM,					\n");
						
						sql.append( "        CASE WHEN D.LRDIV = 'B' THEN 'B' END READ																		\n");
						sql.append( "   FROM ACCOUNT.RPTPRTACT D 																													\n");
						sql.append( " 	LEFT JOIN																																					\n");
						sql.append( "						(	SELECT G.ATDECR, G.ATCODE, SUM(G.DETOT) AS DETOT, SUM(G.CRTOT) AS CRTOT   \n");
						sql.append( "							FROM (                                                                   \n");
						sql.append( "										SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT  \n");
						sql.append( "											FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B                       \n");
						sql.append( "										 WHERE A.ATCODE = B.ATCODE                                         \n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'	                                   \n");
						if(!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+strayyyy+"01' AND '"+str[2]+"'       \n");
						if(!str[3].equals("")) sql.append( " AND A.COCODE = '"+str[3]+"'                                   \n");
						if(!str[4].equals("")) sql.append( " AND A.DIVCD = '"+str[4]+"'																	  	\n");
						sql.append( "											 AND B.ATBALSHTYN = 'Y'                                          \n");
						sql.append( "										 UNION ALL                                                         \n");
						sql.append( "										SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT  \n");
						sql.append( "											FROM ACCOUNT.MDMTOTAL A,ACCOUNT.ACTCODE B                        \n");
						sql.append( "										 WHERE A.ATCODE = B.ATCODE                                         \n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'	                                 \n");
						if(!str[2].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+strayyyy+"01' AND '"+str[2]+"'       \n");
						if(!str[3].equals("")) sql.append( " AND A.COCODE = '"+str[3]+"'                                   \n");
						if(!str[4].equals("")) sql.append( " AND A.DIVCD = '"+str[4]+"'		                              		\n");
						sql.append( "											 AND B.ATBALSHTYN = 'Y'                                          \n");
						sql.append( "									)G                                                                   \n");
						sql.append( "							GROUP BY G.ATDECR,G.ATCODE                                               \n");
						sql.append( "        ) C   ON C.ATCODE = D.ATCODE 																								\n");
						sql.append( " 				  WHERE D.PRTCODE = '04'																										\n");
						sql.append( " ) X,																																								\n");
						sql.append( " (SELECT D.ATCODE,D.PRTNAM,D.PRTSEQ,																									\n");
						sql.append( "        CASE WHEN D.LRDIV = 'L' OR D.LRDIV = 'B'																			\n");
						sql.append( "             THEN CASE WHEN C.ATDECR = '1'																						\n");
						sql.append( "             THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS LTTOT2,								\n");
						sql.append( "        CASE WHEN D.LRDIV = 'R' THEN CASE WHEN C.ATDECR = '1'												\n");
						sql.append( "             THEN DETOT - CRTOT ELSE CRTOT - DETOT END END AS RTTOT2,								\n");
						//sql.append( "        CASE WHEN D.LRDIV = 'B' THEN D.PRTRT END COM2,																\n");
						sql.append( "        CASE WHEN D.PRTRT <>'' AND D.PRTRT IS NOT NULL THEN D.PRTRT END COM2,																\n");
						sql.append( "        CASE WHEN D.LRDIV = 'B' THEN 'B' END READ2																		\n");
						sql.append( "   FROM ACCOUNT.RPTPRTACT D 																													\n");
						sql.append( " 	LEFT JOIN																																					\n");
						sql.append( "         (	\n");
						sql.append( "						SELECT G.ATDECR, G.ATCODE, SUM(G.DETOT) AS DETOT, SUM(G.CRTOT) AS CRTOT    	\n");
						sql.append( "						FROM (                                                                     	\n");
						sql.append( "									SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT    	\n");
						sql.append( "										FROM ACCOUNT.MTOTALBAL A,ACCOUNT.ACTCODE B                         	\n");
						sql.append( "									 WHERE A.ATCODE = B.ATCODE                                           	\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE =  '"+str[0]+"'	                                 	\n");
						if(!str[1].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+strbyyyy+"01' AND '"+str[1]+"'       	\n");
						if(!str[3].equals("")) sql.append( "AND A.COCODE = '02'                                            	\n");
						if(!str[4].equals("")) sql.append( " AND A.DIVCD = '"+str[4]+"'																	  	\n");
						sql.append( "										 AND B.ATBALSHTYN = 'Y'                                            	\n");
						sql.append( "									 UNION ALL                                                           	\n");
						sql.append( "									SELECT B.ATDECR  AS ATDECR, B.ATCODE  AS ATCODE, A.DETOT, A.CRTOT    	\n");
						sql.append( "										FROM ACCOUNT.MDMTOTAL A,ACCOUNT.ACTCODE B                          	\n");
						sql.append( "									 WHERE A.ATCODE = B.ATCODE                                           	\n");
            if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'	                                 	\n");
						if(!str[1].equals("")) sql.append( " AND A.ACTYYMM BETWEEN '"+strbyyyy+"01' AND '"+str[1]+"'       	\n");
						if(!str[3].equals("")) sql.append( " AND A.COCODE = '"+str[3]+"'	                                	\n");
						if(!str[4].equals("")) sql.append( " AND A.DIVCD = '"+str[4]+"'																	  	\n");
						sql.append( "										 AND B.ATBALSHTYN = 'Y'                                            	\n");
						sql.append( "								)G                                                                     	\n");
						sql.append( "						GROUP BY G.ATDECR,G.ATCODE                                                 	\n");

						sql.append( "        ) C   ON C.ATCODE = D.ATCODE																									\n");
						sql.append( " 					WHERE D.PRTCODE = '04'																										\n");
						sql.append( " ) Y																																									\n");
						sql.append( "  WHERE X.ATCODE = Y.ATCODE																													\n");
						sql.append( "  ORDER BY X.PRTSEQ																																	\n");

						//logger.dbg.println(this, sql.toString());

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