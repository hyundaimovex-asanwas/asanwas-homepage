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
public class a020012_s3 extends HttpServlet {
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
				String [] str = new String [13];
				str[0]	= req.getParameter("v_str1");		//처리기간fr                     
				str[1]	= req.getParameter("v_str2");		//처리기간to             
				str[2]	= req.getParameter("v_str3");		//전표상태            
				str[3]	= req.getParameter("v_str4");		//지점              
				str[4]	= req.getParameter("v_str5");		//회계팀/재무팀 구별 "A" ==>의미없음.
				str[5]	= req.getParameter("v_str6");		//계정FR              
				str[6]	= req.getParameter("v_str7");		//계정TO   
				str[7]	= req.getParameter("v_str8");		//부서 ==>>의미없음.              
				str[8]	= req.getParameter("v_str9");		//적요  
				str[9]	= req.getParameter("v_str10");	//empno(회계팀 재무팀이 아닐 경우 자신의 전표만 조회함)   
				str[10]	= req.getParameter("v_str11");	//관리항목
				str[11]	= req.getParameter("v_str12");	//관리항목값 FR
				str[12]	= req.getParameter("v_str13");	//관리항목값 TO

				for (int s=0;s<=12;s++) {
					if (str[s]==null) str[s] = "";
				}

		

				if (str[3]=="C210") str[3]="";
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",   "FSNBR",    "FSSEQ",    "ATCODE",
                                          "ATDECR",  "FSAMT",   "ACNNBR",   "BANJAEYN", "PRIMCOST",
                                          "DOCUMCD", "DOCUVAL", "FSWRKDIV", "REMARK",   "FSNUM",
                                          "DIVCD",   "BGTDIV",  "SSDAT",    "SSNBR",    "EMPNO",
                                          "EMPNMK",  "DEAMT",   "CRAMT",    "FSDTNB",   "SSDTNB",
                                          "ATKORNAM","FSSTAT",  "WRDT",     "WRID",     "UPDT",     "UPID",
					                                "FSREFCD", "FSREFVAL", "CDNAM"
				}; 

				int[] intArrCN = new int[]{  2,  9, 6,  5, 7, 
					                           1, 15, 9,  1, 5,
																	   3, 20, 2,132, 3,  	
 					                           4,  4, 9,  6, 7,
					                          20, 15,15, 16,16,
					                          66,  1, 8, 7,  8, 7,
					                           4,  30, 30
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1,  0, -1, -1, -1,
				                             -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1,  0,  0, -1, -1,
					                           -1, -1, -1, -1, -1, -1,
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
					
					sql.append( "  SELECT B.FDCODE,  B.FSDAT,   B.FSNBR,     B.FSSEQ,    B.ATCODE,                                     \n " );
					sql.append( "         B.ATDECR,  B.FSAMT,   B.ACNNBR,    B.BANJAEYN, B.PRIMCOST,                                   \n " );
					sql.append( "         B.DOCUMCD, B.DOCUVAL, B.FSWRKDIV,  B.REMARK,   B.FSNUM,                                      \n " );
					sql.append( "         B.DIVCD,   B.BGTDIV,  B.SSDAT,     B.SSNBR,    A.EMPNO,                                      \n " );
                    //sql.append( "         CASE WHEN (RTRIM(C.EMPNMK)='' OR C.EMPNMK IS NULL) THEN F.EMPNMK ELSE C.EMPNMK END EMPNMK,   \n " );
					sql.append( "         C.EMPNMK, \n " );
					sql.append( "         CASE WHEN B.ATDECR ='1' THEN B.FSAMT ELSE 0 END DEAMT,                                       \n " );
					sql.append( "         CASE WHEN B.ATDECR ='2' THEN B.FSAMT ELSE 0 END CRAMT,                                       \n " );
					sql.append( "         CASE  WHEN (A.FSDAT=''OR A.FSDAT IS NULL) THEN '' ELSE A.FSDAT||'-'||A.FSNBR END  FSDTNB,    \n " );
					sql.append( "         CASE  WHEN (A.SSDAT=''OR A.SSDAT IS NULL) THEN '' ELSE A.SSDAT||'-'||A.SSNBR END  SSDTNB,    \n " );
					sql.append( "         E.ATKORNAM, A.FSSTAT,  B.WRDT,    B.WRID,    B.UPDT,      B.UPID,                            \n " );
					sql.append( "         G.FSREFCD, G.FSREFVAL, H.CDNAM                                                               \n " );
					sql.append( "    FROM ACCOUNT.FSLIPMST A, ACCOUNT.FSLIPDTL B,                   			                           \n " );
					sql.append( "         PAYROLL.YIPERSON C, ACCOUNT.ACTCODE E	, ACCOUNT.FSLIPREF G, ACCOUNT.COMMDTIL H		       \n " );				
					/*
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO																								   \n " );
					sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON F ON A.EMPNO = F.EMPNO																							   \n " );
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE E ON B.ATCODE = E.ATCODE																							   \n " );
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPREF G ON B.FDCODE = G.FDCODE																							   \n " );
					sql.append( "   														AND B.FSDAT = G.FSDAT																								   \n " );
					sql.append( "   														AND B.FSNBR = G.FSNBR																								   \n " );
					sql.append( "   														AND B.FSSEQ = G.FSSEQ																								   \n " );
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL H ON H.CMTYPE = G.FSREFCD AND H.CDCODE = G.FSREFVAL									   \n " );
					*/
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                                           \n " );
					sql.append( "    AND A.FSDAT = B.FSDAT                                                                             \n " );
					sql.append( "    AND A.FSNBR = B.FSNBR                                                                             \n " );
					if (!str[0].equals("")&&!str[1].equals("")) sql.append( "  AND A.ACTDAT BETWEEN '"+str[0]+"'  AND '"+str[1]+"'     \n" );
					if (!str[2].equals("A")) sql.append( "  AND A.FSSTAT='" +str[2]+"'  \n" );
                    if (!str[3].equals(""))sql.append( "    AND A.FDCODE ='"+str[3]+"'  \n" );
					if (!str[5].equals("")&&!str[6].equals("")) sql.append( "  AND B.ATCODE BETWEEN '"+str[5]+"'  AND '"+str[6]+"'     \n" );
					if (!str[8].equals(""))sql.append( "    AND B.REMARK LIKE '%"+str[8]+"%'   \n" );				
					
					//2010.02.03 목 JYS : 전표조회시 타부서 및 사번에 대한 권한 추가,,,,,자신의 부서는 자동 조회 안함.    
					if (!str[4].equals("A")&&!str[9].equals("")&&str[7].equals("")) sql.append( "  AND A.EMPNO IN ("+str[9]+") \n" );
					if (!str[4].equals("A")&&!str[9].equals("")&&!str[7].equals("")) sql.append( "  AND ( A.EMPNO IN ("+str[9]+") OR A.DEPTCD IN ("+str[7]+")) \n" );	
					
					if (!str[10].equals(""))sql.append( "   AND G.FSREFCD = '"+str[10]+"'   \n" );
					if (!str[11].equals("")&&!str[12].equals(""))sql.append( " AND G.FSREFVAL BETWEEN '"+str[11]+"' AND '"+str[12]+"' \n" );
					
					sql.append( "   AND A.EMPNO =C.EMPNO(+) AND C.USESTS IN ('1','2','3')  \n " );
					sql.append( "   AND B.ATCODE = E.ATCODE(+) \n " );
					sql.append( "   AND B.FDCODE = G.FDCODE(+) \n " );
					sql.append( "   AND B.FSDAT  = G.FSDAT(+)  \n " );
					sql.append( "   AND B.FSNBR  = G.FSNBR(+)  \n " );
					sql.append( "   AND B.FSSEQ  = G.FSSEQ(+)  \n " );
					sql.append( "   AND G.FSREFCD = H.CMTYPE(+) AND G.FSREFVAL = H.CDCODE(+)	 \n " );
					
					if (str[2].equals("Y"))sql.append( "  ORDER BY B.FDCODE, B.SSDAT ASC, B.SSNBR ASC, B.FSNUM     \n " );
					else sql.append( "  ORDER BY B.FDCODE, B.FSDAT ASC, B.FSNBR ASC, B.FSNUM                       \n " );

					
					//System.out.println("a020012_s3 : " + sql.toString());	
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