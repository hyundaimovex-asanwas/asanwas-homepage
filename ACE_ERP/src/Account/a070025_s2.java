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
public class a070025_s2 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //지점
				String  str2 = req.getParameter("v_str2");    //회계년월FR
				String  str3 = req.getParameter("v_str3");    //지급일자FR
				String  str4 = req.getParameter("v_str4");    //지급일자TO
				String  str5 = req.getParameter("v_str5");    //거래처코드 
				String  str6 = req.getParameter("v_str6");    //거래처명 
				String  str7 = req.getParameter("v_str7");    //지급구분 1 현금, 2 어음, 3 전체  
				String  str8 = req.getParameter("v_str8");    //어음만기일자
				String  str9 = req.getParameter("v_str9");    //회계년월TO
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8= "";
				if (str9 == null) str9= "";
				
				GauceRes.enableFirstRow(dSet);
				

				String[] strArrCN = new String[]{"FDCODE",    "TSDAT",    "TSNBR",    "TSSEQ",    "SSDAT",
                                                 "SSNBR",     "FSNUM",    "ACTDAT",   "PAYDAT",   "ATCODE",
                                                 "ATKORNAM",  "VENDCD",   "VENDNM",   "DEAMT",    "CRAMT",   "TAXDAT",
                                                 "JANAMT",    "BJANAMT",  "FSREFCD",  "FSREFVAL", "FSREFNM", "REMARK", 
                                                 "CHKCASH",   "CHKBILL",  "FULDAT",   "FSDAT",    "FSNBR" ,  "FSSTAT",
                                                 "I_EMPNO",   "I_DATE",   "U_EMPNO",  "U_DATE",   "GUBUN",
                                                 "EMPNO",     "EMPNMK",   "FSLOCK"
					                                                }; 

				int[] intArrCN = new int[]{ 2 ,  9,   6,   5,   9,
	                                        6,   3,   8,   8,   7, 
	                                       66, 13, 32, 15, 15, 8,
	                                       15, 15,   4,  20, 40,  132,
	                                         1,   1,  8,    9,  6,  1,
	                                       10, 10,  10, 10, 1,
	                                        7,  32, 1
					                        }; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
											-1,-1,-1,-1,-1,
											-1,-1,-1,  0, 0, -1,
											 0 , 0, -1, -1,-1,-1,
	                                        -1,-1,-1, -1,-1,-1,
											-1,-1,-1,-1, -1,
	                                        -1, -1, -1
                                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT A.FDCODE,   A.TSDAT,      A.TSNBR,      A.TSSEQ,    D.SSDAT,                     					\n"); 
					sql.append( "        D.SSNBR,    D.FSNUM,      A.ACTDAT,     A.PAYDAT,   A.ATCODE,                  					\n"); 
					sql.append( "        B.ATKORNAM, A.VENDCD,     C.VEND_NM AS VENDNM,   0 DEAMT,  0 CRAMT,   L.TAXDAT AS TAXDAT,			\n");
					sql.append( "        A.JANAMT,   0 BJANAMT,    A.FSREFCD,    A.FSREFVAL,  P.CDNAM AS FSREFNM,  A.REMARK, 	            \n"); 
					sql.append( "        A.CHKCASH,  A.CHKBILL,    RTRIM(A.FULDAT) FULDAT,    A.FSDAT,    A.FSNBR,     F.FSSTAT,            \n"); 
					sql.append( "        A.I_EMPNO,  A.I_DATE,     A.U_EMPNO,    A.U_DATE ,  'B' AS GUBUN,                                  \n");
					sql.append( "        M.EMPNO,    ASNHR.SF_GET_ENONAME('01',M.EMPNO ) AS EMPNMK , M.FSLOCK                               \n"); 
					sql.append( "   FROM ACCOUNT.AETCPAY A                                                                                  \n"); 
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE =B.ATCODE  						\n");
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VENDCD =C.VEND_CD  				\n");
					sql.append( "   LEFT JOIN ACCOUNT.BANJAEMST D ON A.FDCODE = D.FDCODE AND A.TSDAT  = D.TSDAT  	   \n");
					sql.append( "                                AND A.TSNBR  = D.TSNBR  AND A.TSSEQ  = D.TSSEQ      	\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL P ON A.FSREFVAL= P.CDCODE AND A.FSREFCD=P.CMTYPE 		\n");
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST F ON A.FDCODE  = F.FDCODE AND A.FSDAT = F.FSDAT AND A.FSNBR =F.FSNBR \n");
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST M ON A.FDCODE  = M.FDCODE AND A.TSDAT = M.FSDAT AND A.TSNBR =M.FSNBR  \n");
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPDTL N ON A.FDCODE  = N.FDCODE AND A.TSDAT = N.FSDAT AND A.TSNBR =N.FSNBR AND A.TSSEQ = N.FSSEQ AND N.DOCUVAL IS NOT NULL  \n");
					sql.append( "   LEFT JOIN ACCOUNT.ATTAXMST L ON N.DOCUVAL = L.TAXNBR		 \n");
					
					sql.append( "  WHERE A.ATCODE =B.ATCODE                                      \n"); 
					sql.append( "    AND A.FDCODE ='"+str1+"'                                    \n"); 
					sql.append( "    AND SUBSTR(A.ACTDAT,1,6) BETWEEN '"+str2+"' AND '"+str9+"'  \n"); 
					sql.append( "    AND A.PAYDAT BETWEEN '"+str3+"' AND  '"+str4+"'             \n"); 
					if(!str5.equals("")) sql.append( "   AND A.VENDCD = '"+str5+"' 				 \n"); 
					if(!str6.equals("")) sql.append( "   AND C.VEND_NM LIKE '"+str6+"%' 		 \n"); 
					if(str7.equals("1")) sql.append( "   AND A.CHKCASH = 'T' 					 \n");
					if(str7.equals("2")) sql.append( "   AND A.CHKBILL = 'T' 					 \n"); 
					if(!str8.equals("")) sql.append( "   AND A.FULDAT ='"+str8+"' 				 \n"); 
					sql.append( "  ORDER BY  C.VEND_NM, D.SSDAT, D.SSNBR, D.FSNUM,A.ATCODE       \n"); 

					//System.out.println("# Query a070025_s2 : \n" + sql);
					//logger.dbg.println( this, sql.toString() ); 
					
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