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
public class a020003_s3 extends HttpServlet {
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
				str[0]	= req.getParameter("v_str1");		//회계일자 FR
				str[1]	= req.getParameter("v_str2");		//회계일자 TO
				str[2]	= req.getParameter("v_str3");		//전표상태
				str[3]	= req.getParameter("v_str4");		//지점
				str[4]	= req.getParameter("v_str5");		//적요

       
				for (int s=0;s<=4;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",    "FDNAME",     "BSDAT",     "BSNBR",	  "SSDATNBR",
					                                "FSAMT",     "BTSDAT",     "BTSNBR",	  "FSDATNBR", 
					                                "FSSTAT",    "BANJAEYN",   "DETOT",     "CRTOT",
					                                "REMARK"    
				                                }; 

				int[] intArrCN = new int[]{  2,  20,  9,  6, 16,
					                           15,  9,  6, 16,
					                           1,   1, 15, 15,
					                          132  
					                         }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                            0, -1, -1, -1,
					                           -1, -1,  0,  0,
					                           -1 
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
					sql.append( " SELECT DISTINCT B.FDCODE, D.FDNAME, B.SSDAT BSDAT, B.SSNBR BSNBR, B.SSDAT||'-'||B.SSNBR SSDATNBR,  \n" );
					sql.append( "        B.FSAMT,  B.FSDAT BTSDAT, B.FSNBR BTSNBR , B.FSDAT||'-'||B.FSNBR FSDATNBR,  	\n" );
					sql.append( "        B.FSSTAT, A.BANJAEYN, B.DETOT, B.CRTOT,                                     						\n" );
					sql.append( "				 B.REMARK 																                              	 	\n" );
					sql.append( "   FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPMST B ,  ACCOUNT.BANJAEMST  C       		\n" );
					sql.append( "   LEFT JOIN ACCOUNT.FIELDCODE D ON B.FDCODE = D.FDCODE                     					\n" );
					sql.append( "		LEFT JOIN ACCOUNT.COMMDTIL  F ON C.DEPTCD = F.CDCODE AND F.CMTYPE='0002'      \n" );
					sql.append( "		LEFT JOIN ACCOUNT.COMMDTIL  H ON C.FSREFVAL = H.CDCODE AND H.CMTYPE=C.FSREFCD 	\n" );
					sql.append( " WHERE A.FDCODE = B.FDCODE                                                     										\n" );
					sql.append( "   AND A.BTSDAT = B.FSDAT                                                      												\n" );
					sql.append( "   AND A.BTSNBR = B.FSNBR                                                      												\n" );				
					sql.append( "   AND B.ACTDAT >='"+str[0]+"' AND B.ACTDAT<='"+str[1]+"'                      	\n" );
					sql.append( "   AND B.FDCODE = '"+str[3]+"'                                                 				\n" );
					if(!str[2].equals("")) sql.append( "   AND B.FSSTAT='"+str[2]+"'                            			\n" );
					sql.append( "   AND B.REMARK LIKE '%"+str[4]+"%'                                            			\n" );
					sql.append( "		AND A.FDCODE =C.FDCODE 																\n" ); 
					sql.append( "		AND A.TSDAT = C.TSDAT  																\n" );
					sql.append( "		AND A.TSNBR = C.TSNBR  																\n" ); 
					sql.append( "		AND A.TSSEQ = C.TSSEQ 														 		\n" );
					 */			
					
					
					sql.append( " SELECT DISTINCT B.FDCODE, C.FDNAME, B.SSDAT BSDAT, B.SSNBR BSNBR, B.SSDAT||'-'||B.SSNBR SSDATNBR,  \n" );
					sql.append( "        B.FSAMT,  B.FSDAT BTSDAT, B.FSNBR BTSNBR , B.FSDAT||'-'||B.FSNBR FSDATNBR,  			\n" );
					sql.append( "        B.FSSTAT, A.BANJAEYN, B.DETOT, B.CRTOT, B.REMARK    													\n" );
					sql.append( "   FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPMST B ,  ACCOUNT.FIELDCODE  C       				\n" );
					sql.append( " WHERE A.FDCODE = B.FDCODE                                                     										\n" );
					sql.append( "   AND A.BTSDAT = B.FSDAT                                                      												\n" );
					sql.append( "   AND A.BTSNBR = B.FSNBR                                                      												\n" );				
					sql.append( "   AND B.ACTDAT >='"+str[0]+"' AND B.ACTDAT<='"+str[1]+"'                      	\n" );
					sql.append( "   AND B.FDCODE = '"+str[3]+"'                                                 				\n" );
					sql.append( "   AND B.FDCODE(+) = C.FDCODE                     										\n" );
					if(!str[2].equals("")) sql.append( "   AND B.FSSTAT='"+str[2]+"'                            			\n" );
					sql.append( "   AND B.REMARK LIKE '%"+str[4]+"%'                                            			\n" );
					
					System.out.println("a020003_s3:\n"+sql.toString());
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