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
public class a090021_s1 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //취득일자 fro
				String  str3	= req.getParameter("v_str3");    //취득일자 to  
				String  str4	= req.getParameter("v_str4");    //상태구분 ^전체,0^정상, 1^매각,2^폐기,3^자본적지출
				String  str5	= req.getParameter("v_str5");    //원가코드
				String  str6	= req.getParameter("v_str6");    //자산중분류 
				String  str7	= req.getParameter("v_str7");    //자산소분류     
				String  str8	= req.getParameter("v_str8");    //ast1st         
				String  str9	= req.getParameter("v_str9");    //자산명코드
				String  str10	= req.getParameter("v_str10");   //담당자사번    
				String  str12	= req.getParameter("v_str12");   //자산명    
				String  str13	= req.getParameter("v_str13");   //전표상태  
				String  str14	= req.getParameter("v_str14");   //사용자  
			
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				if (str8 == null) str8 = "";
				if (str9 == null) str9 = "";
				if (str10 == null) str10 = "";
				if (str12 == null) str12 = "";
				if (str13 == null) str13 = "";			
				if (str13.equals("A")) str13 = "";
				if (str14 == null) str14 = "";

				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{  "ASTSEQ",  "SEQ",      "SEQ2",	   "ASAQSDAT",  "AST2ND", 	
													"ASTNAME", "ASTUNIT",   
													"ASTQTY",  "ASTAQAMT", "MNGDPT",   "USEDPT",   "ASTYUSE",
													"FDCODE",  "ATCODE" ,  "AST1ST",   "AST3RD",
													"MNGDPTNM","USEDPTNM", "ASTNAME2", "ASTNAME3", "CDNAM", "EMPNMK",
					                                "ASTNBR",  "H_ASTNBR", "DEPTCD",   "DEPTNM",   "EMPNO", "ASTSTAT",
					                                "FSDAT",   "FSNBR",    "FSSEQ",    "FSSTAT",   "COSTCD", "COSTNM", "S_ASTNBR"
																				}; 
 
				int[] intArrCN = new int[]{ 5, 11, 11, 10, 2,
					                          30, 10,
					                          10, 13, 4, 4,  5,
					                   		     2,  7, 2, 2,
												30, 30, 30, 30, 100, 20,
					                           8,  8, 4,  40, 7, 1,
					                           9,  6, 5,   1, 6, 100, 8
				}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1,
					                            0,  0, -1, -1,  2,
												-1, -1, -1, -1,
												-1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1, -1
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
					sql.append( " SELECT                 ");
					sql.append( " A.ASTSEQ,                        \n ");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ, \n");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ2,\n");
					sql.append( " A.ASAQSDAT,                         \n");
					sql.append( " A.AST2ND,                         \n");
					sql.append( " A.ASTNAME,                          \n");
					sql.append( " B.ASTUNIT,                          \n");
					sql.append( " nvl(B.ASTQTY,0)   ASTQTY,         \n");
					sql.append( " nvl(B.ASTAQAMT,0) ASTAQAMT,      \n");
					sql.append( " B.MNGDPT,                        \n");
					sql.append( " B.USEDPT,                         \n");
					sql.append( " nvl(B.ASTYUSE,0) ASTYUSE,     \n");
					sql.append( " A.FDCODE, A.ATCODE,A.AST1ST, A.AST3RD,  \n");
					sql.append( " TRIM(C.DEPTNM) AS MNGDPTNM, TRIM(D.DEPTNM) AS USEDPTNM,  \n");
					sql.append( " TRIM(A.ASTNAME2) AS ASTNAME2,TRIM(A.ASTNAME3) AS ASTNAME3, TRIM(E.ASTNM) AS CDNAM, TRIM(F.EMPNMK) AS EMPNMK,  \n");
					sql.append( " A.ASTNBR, A.H_ASTNBR, A.DEPTCD, G.DEPTNM, A.EMPNO, B.ASTSTAT,  \n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSDAT  ELSE A.FSDAT END FSDAT, \n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSNBR  ELSE A.FSNBR END FSNBR, \n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSSEQ  ELSE A.FSSEQ END FSSEQ, \n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSSTAT ELSE 'Y'     END FSSTAT,\n");
					sql.append( " B.COSTCD, TRIM(Y.CDNAM) AS COSTNM,  A.S_ASTNBR \n");
					sql.append( " FROM ACCOUNT.ASTMSTN A   ");
					sql.append( " LEFT JOIN  ACCOUNT.ASTBASICN B ON A.FDCODE=B.FDCODE   \n");
					sql.append( "	                              AND A.ATCODE=B.ATCODE AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD  AND A.ASTSEQ=B.ASTSEQ  \n");	
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON B.MNGDPT=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT D ON B.USEDPT=D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT G ON A.DEPTCD=G.DEPTCD AND G.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( " LEFT JOIN ACCOUNT.ASTNAME E ON A.AST2ND=E.AST2ND AND A.AST3RD=E.AST3RD AND A.ASTNAME=E.ASTCD \n");
					sql.append( " LEFT JOIN PAYROLL.CIPERSON F ON B.ASTUSER=F.EMPNO \n");		
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Y ON B.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'	 \n");		
					sql.append( " LEFT JOIN ( SELECT K1.FSDAT, K1.FSNBR, K1.FSSEQ,  K1.FSREFVAL AS H_ASTNBR, K2.FSSTAT      \n");			
					sql.append( "               FROM ACCOUNT.FSLIPREF K1, ACCOUNT.FSLIPMST K2                               \n");			
					sql.append( "              WHERE K1.FDCODE = K2.FDCODE                                                  \n");			
					sql.append( "                AND K1.FSDAT = K2.FSDAT                                                    \n");			
					sql.append( "                AND K1.FSNBR = K2.FSNBR                                                    \n");			
					if (!str1.equals(""))sql.append( " AND K1.FDCODE = '"+str1+"'                                           \n");			
					sql.append( "                AND K2.ACTDAT >='20110615'                                                 \n");			
					sql.append( "                AND K1.FSREFCD ='1135'                                                     \n");			
					sql.append( "            )K ON A.H_ASTNBR = K.H_ASTNBR                                                  \n");			
					sql.append( " WHERE	A.FDCODE IS NOT NULL \n");	 
					if (!str1.equals(""))  sql.append( "  AND  A.FDCODE = '"+str1+"'  \n");
 					if (!str2.equals(""))  sql.append( "  AND  A.ASAQSDAT BETWEEN  '"+str2+"' AND '"+str3+"' \n"); 
 					if (!str4.equals(""))  sql.append( "  AND  B.ASTSTAT = '"+str4+"' \n");
					if (!str5.equals(""))  sql.append( "  AND  B.COSTCD = '"+str5+"'  \n");
					if (!str6.equals(""))  sql.append( "  AND  A.AST2ND = '"+str6+"'  \n");				
					if (!str7.equals(""))  sql.append( "  AND  A.AST3RD = '"+str7+"'  \n");
 					if (!str8.equals(""))  sql.append( "  AND	 A.AST1ST  = '"+str8+"' \n");
					if (!str9.equals(""))  sql.append( "  AND	 ( A.ASTNAME = '"+str9+"'  AND  E.ASTNM ='"+str12+"' ) \n");
					if (!str10.equals("")) sql.append( "  AND  A.EMPNO  = '"+str10+"' \n"); 
					if (!str13.equals("")){
							if(str13.equals("Y")){
								sql.append( "  AND  ( K.FSSTAT = '"+str13+"' OR ( A.FDCODE='"+str1+"' AND A.FSDAT='A20110603' AND A.FSNBR='000003' AND A.FSSEQ='00001'))\n"); 
							}else{
								sql.append( "  AND  K.FSSTAT = '"+str13+"' \n"); 
							}
					}
					if (!str14.equals("")) sql.append( "  AND  B.ASTUSER = '"+str14+"' \n");				
					sql.append( "	ORDER BY A.ASAQSDAT, FLOAT(SEQ)    \n");	
			*/
				
					
					sql.append( " SELECT                 																		\n");
					sql.append( " A.ASTSEQ,                        															\n");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ, 		\n");
					sql.append( " (A.AST1ST  || A.AST2ND  || A.AST3RD  ||  A.ASTSEQ) AS SEQ2,		\n");
					sql.append( " A.ASAQSDAT,                         														\n");
					sql.append( " A.AST2ND,                         															\n");
					sql.append( " A.ASTNAME,                          														\n");
					sql.append( " B.ASTUNIT,                          														\n");
					sql.append( " nvl(B.ASTQTY,0)   ASTQTY,         													\n");
					sql.append( " nvl(B.ASTAQAMT,0) ASTAQAMT,      												\n");
					sql.append( " B.MNGDPT,                        															\n");
					sql.append( " B.USEDPT,                         															\n");
					sql.append( " nvl(B.ASTYUSE,0) ASTYUSE,     														\n");
					sql.append( " A.FDCODE, A.ATCODE,A.AST1ST, A.AST3RD,  									\n");
					//sql.append( " ''MNGDPTNM, '' USEDPTNM,  									\n");
					sql.append( " ASNHR.SF_GET_DPTNAME0('01','A6',B.MNGDPT ) AS MNGDPTNM,  	\n");					
					sql.append( " ASNHR.SF_GET_DPTNAME0('01','A6',B.USEDPT ) AS USEDPTNM,  		\n");					
					sql.append( " TRIM(A.ASTNAME2) AS ASTNAME2,TRIM(A.ASTNAME3) AS ASTNAME3, TRIM(E.ASTNM) AS CDNAM, \n");
					//sql.append( " ''EMPNMK,  									\n");
					sql.append( " ASNHR.SF_GET_ENONAME('01',B.ASTUSER ) AS EMPNMK,  					\n");
					sql.append( " A.ASTNBR, A.H_ASTNBR, A.DEPTCD, 													\n");
					//sql.append( " ''DEPTNM, 	 									\n");
					sql.append( " ASNHR.SF_GET_DPTNAME0('01','A6',A.DEPTCD ) DEPTNM, 						\n");					
					sql.append( " A.EMPNO, B.ASTSTAT,  																	\n");					
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSDAT  ELSE A.FSDAT END FSDAT, 		\n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSNBR  ELSE A.FSNBR END FSNBR, 		\n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSSEQ  ELSE A.FSSEQ END FSSEQ, 		\n");
					sql.append( " CASE WHEN A.FSDAT='' THEN K.FSSTAT ELSE 'Y'     END FSSTAT,			\n");
					sql.append( " B.COSTCD, TRIM(Y.CDNAM) AS COSTNM,  A.S_ASTNBR 						\n");
					sql.append( " FROM ACCOUNT.ASTMSTN A   																");
					sql.append( " LEFT JOIN  ACCOUNT.ASTBASICN B ON A.FDCODE=B.FDCODE   				\n");
					sql.append( "	                              AND A.ATCODE=B.ATCODE AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD  AND A.ASTSEQ=B.ASTSEQ  \n");	
					sql.append( " LEFT JOIN ACCOUNT.ASTNAME E ON A.AST2ND=E.AST2ND AND A.AST3RD=E.AST3RD AND A.ASTNAME=E.ASTCD \n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL Y ON B.COSTCD=Y.CDCODE AND Y.CMTYPE='0030'	 \n");		
					sql.append( " LEFT JOIN ( SELECT K1.FSDAT, K1.FSNBR, K1.FSSEQ,  K1.FSREFVAL AS H_ASTNBR, K2.FSSTAT      \n");			
					sql.append( "               FROM ACCOUNT.FSLIPREF K1, ACCOUNT.FSLIPMST K2                    \n");			
					sql.append( "              WHERE K1.FDCODE = K2.FDCODE                                                  \n");			
					sql.append( "                AND K1.FSDAT = K2.FSDAT                                                    		\n");			
					sql.append( "                AND K1.FSNBR = K2.FSNBR                                                    		\n");			
					if (!str1.equals(""))sql.append( " AND K1.FDCODE = '"+str1+"'                                           	\n");			
					sql.append( "                AND K2.ACTDAT >='20110615'                                                 		\n");			
					sql.append( "                AND K1.FSREFCD ='1135'                                                     		\n");			
					sql.append( "            )K ON A.H_ASTNBR = K.H_ASTNBR                                                  	\n");			
					sql.append( " WHERE	A.FDCODE IS NOT NULL 																\n");	 
					if (!str1.equals(""))  sql.append( "  AND  A.FDCODE = '"+str1+"'  											\n");
 					if (!str2.equals(""))  sql.append( "  AND  A.ASAQSDAT BETWEEN  '"+str2+"' AND '"+str3+"' 		\n"); 
 					if (!str4.equals(""))  sql.append( "  AND  B.ASTSTAT = '"+str4+"' 											\n");
					if (!str5.equals(""))  sql.append( "  AND  B.COSTCD = '"+str5+"'  												\n");
					if (!str6.equals(""))  sql.append( "  AND  A.AST2ND = '"+str6+"'  												\n");				
					if (!str7.equals(""))  sql.append( "  AND  A.AST3RD = '"+str7+"'  												\n");
 					if (!str8.equals(""))  sql.append( "  AND	 A.AST1ST  = '"+str8+"' 											\n");
					if (!str9.equals(""))  sql.append( "  AND	 ( A.ASTNAME = '"+str9+"'  AND  E.ASTNM ='"+str12+"' ) \n");
					if (!str10.equals("")) sql.append( "  AND  A.EMPNO  = '"+str10+"' 												\n"); 
					if (!str13.equals("")){
							if(str13.equals("Y")){
								sql.append( "  AND  ( K.FSSTAT = '"+str13+"' OR ( A.FDCODE='"+str1+"' AND A.FSDAT='A20110603' AND A.FSNBR='000003' AND A.FSSEQ='00001'))\n"); 
							}else{
								sql.append( "  AND  K.FSSTAT = '"+str13+"' \n"); 
							}
					}
					if (!str14.equals("")) sql.append( "  AND  B.ASTUSER = '"+str14+"' 	\n");				
					sql.append( "	ORDER BY A.ASAQSDAT,SEQ   							\n");						
					
					System.out.println("a090021_s1 : \n" + sql.toString());
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