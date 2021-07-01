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
public class a020001_s23 extends HttpServlet {
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
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//FDCODE
				str[1]	= req.getParameter("v_str2");		//FSDAT
				str[2]	= req.getParameter("v_str3");		//FSNBR
				str[3]	= req.getParameter("v_str4");		//FSNBR

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "BTSDAT", "BTSNBR", "SSDATNBR", "BTSSEQ",   "BSDATNBR",
					                                "SSDAT",   "SSNBR",  "FSNUM",  "BJDEAMT",  "BJCRAMT",
					                                "BSDAT",   "BSNBR",  "TSDAT",  "TSNBR",    "TSSEQ",
					                                "VENDCD",  "VENDNM", "FSREFCD","FSREFVAL", "FSREFNM",
					                                "FSREFCD2","REFVAL2","REFVALNM2","REMARK", "CHK"
				};                              
       
				int[] intArrCN = new int[]{2, 9, 6,  20, 5,  9,
											9, 6, 3, 15, 15,
					                        9, 6, 9,  6,  5,
					                        13,62, 4, 20, 40,
					                         4,30,40,132, 1  
				}; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1, 
					                          -1, -1, -1,  0,  0,
					                          -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1,
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
					sql.append( "	SELECT A.FDCODE, A.BTSDAT,  A.BTSNBR, A.SSDAT||'-'||A.SSNBR SSDATNBR,  A.BTSSEQ,   A.BSDAT||A.BSNBR BSDATNBR,    \n");
					sql.append( "	       A.SSDAT,  A.SSNBR,   A.FSNUM,   A.BJDEAMT,  A.BJCRAMT,                    					\n");
					sql.append( "	       A.BSDAT,  A.BSNBR,   B.TSDAT,   B.TSNBR,    B.TSSEQ,                      					\n");
					sql.append( "	       B.VENDCD, D.VEND_NM VENDNM,     B.FSREFCD, B.FSREFVAL, E.CDNAM FSREFNM,   	            \n");
					sql.append( "	       B.FSREFCD2, RTRIM(B.FSREFVAL2) REFVAL2,E2.CDNAM REFVALNM2,                        				\n");
					sql.append( "	       C.REMARK, 'F' CHK                                                                  				\n");
					sql.append( "	  FROM ACCOUNT.BANJAEREL A, ACCOUNT.BANJAEMST B,                                  				\n");
					sql.append( "	       ACCOUNT.FSLIPDTL C , ACCOUNT.GCZM_VENDER D, ACCOUNT.COMMDTIL E, ACCOUNT.COMMDTIL E2      \n");
					
					/*
					sql.append( "	  LEFT JOIN ACCOUNT.FSLIPDTL C ON A.FDCODE = C.FDCODE                            				\n");
					sql.append( "	                              AND A.SSDAT = C.SSDAT                              									\n");
					sql.append( "	                              AND A.SSNBR = C.SSNBR                              									\n");
					sql.append( "	                              AND A.FSNUM = C.FSNUM                              									\n");
					sql.append( "	  LEFT JOIN ACCOUNT.GCZM_VENDER D ON  B.VENDCD = D.VEND_CD                       			\n");
					sql.append( "	  LEFT JOIN ACCOUNT.COMMDTIL E ON B.FSREFVAL = E.CDCODE AND B.FSREFCD=E.CMTYPE   				\n");
					sql.append( "	  LEFT JOIN ACCOUNT.COMMDTIL E2 ON B.FSREFVAL2 = E2.CDCODE AND B.FSREFCD2=E2.CMTYPE          \n");
					*/
					sql.append( "	 WHERE A.FDCODE ='"+str[0]+"'                                                    													\n");
					sql.append( "	   AND A.BTSDAT ='"+str[1]+"'                                                    														\n");
					sql.append( "	   AND A.BTSNBR ='"+str[2]+"'                                                    														\n");
					sql.append( "	   AND A.BTSSEQ ='"+str[3]+"'                                                    														\n");
					sql.append( "	   AND A.FDCODE = B.FDCODE                                                       													\n");
					sql.append( "	   AND A.TSDAT = B.TSDAT                                                         														\n");
					sql.append( "	   AND A.TSNBR = B.TSNBR                                                         														\n");
					sql.append( "	   AND A.TSSEQ = B.TSSEQ                                                         														\n");
					sql.append( "	   AND A.FDCODE = C.FDCODE(+) \n");
					sql.append( "	   AND A.SSDAT = C.SSDAT(+)  \n");
					sql.append( "	   AND A.SSNBR = C.SSNBR(+)\n");
					sql.append( "	   AND A.FSNUM = C.FSNUM(+)  \n");
					sql.append( "	   AND B.VENDCD = D.VEND_CD(+)\n");
					sql.append( "	   AND B.FSREFVAL = E.CDCODE(+)   AND B.FSREFCD=E.CMTYPE(+)\n");
					sql.append( "	   AND B.FSREFVAL2 = E2.CDCODE(+) AND B.FSREFCD2=E2.CMTYPE(+)\n");			
					
					//sql.append( "	   AND B.STATUS='1'\n");
					
					 
					System.out.println("a020001_s23" + sql.toString());
				 // logger.dbg.println(this,sql.toString());
					
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