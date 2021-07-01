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
public class a041010_s1 extends HttpServlet {
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
				
				String []  str	= new String [22];
				str[0] = req.getParameter("v_str1");	//계산서구분
				str[1] = req.getParameter("v_str2");	//사업소
				str[2] = req.getParameter("v_str3");	//계산서기간 from
				str[3] = req.getParameter("v_str4");	//계산서기간 to
				str[4] = req.getParameter("v_str5");	//거래처코드
				str[5] = req.getParameter("v_str6");	//귀속구분
				str[6] = req.getParameter("v_str7");	//부가세종류
				str[7] = req.getParameter("v_str8");	//발행여부
				str[8] = req.getParameter("v_str9");	//전표상태
				str[9] = req.getParameter("v_str10");	//거래처명
				str[10] = req.getParameter("v_str11");	//지점코드
				str[11] = req.getParameter("v_str12");	//사용자부서
				str[12] = req.getParameter("v_str13");	//로그인아이디 체크
				str[13] = req.getParameter("v_str14");	//구분값

				str[14] = req.getParameter("v_str15");	//사번
				str[15] = req.getParameter("v_str16");	//부서
				str[16] = req.getParameter("v_str17");	//수정코드
				str[17] = req.getParameter("v_str18");	//수정코드
				str[18] = req.getParameter("v_str19");	//작성자 사번 
				str[19] = req.getParameter("v_str20");	//원가코드 
				str[20] = req.getParameter("v_str21");	//eBill구분 
				str[21] = req.getParameter("v_str22");	//eBill구분
				
				for (int s=0;s<=21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXIODIVNM","TAXDIVNM",
					"TAXKND","TAXKNDNM","VEND_CD","VEND_NM","VEND_ID","TAXDAT",
					"TAXSUM","TAXVATAMT","TAXTOT","REMARK","TAXCDNBR",
					"TAXPRTYN","FSDAT","FSNBR","FSNUM","TAXCNT","TAXKIDIV",
					"VD_DIRECT","BSNS_CND","BSNS_KND","COID","COSANG","ADDNM","ADDNM2",
					"FSSTAT",	"FDCODE","DEPTCD","DEPTNM","TREECD",
					"EMPNO","EMPNMK","ATCODE","ATKORNAM","TAXNBR_R", "GBCD", "FDNAME",
                    "DTI_STATUS", "RETURN_CODE", "RETURN_DESCRIPTION", "SBDESCRIPTION",
                    "GUBUN","AMEND_CODE","AMEND_REMARK", "EXTCHK", "CREATION_DATE",
                    "CONVERSATION_ID","SUPBUY_TYPE","DIRECTION", "COSTCD", "COSTNM", 
                    "VEND_ID_LEN", "DUEDATE", "TAXSTS", "WRDT", "UPDT",
                    "SEQ",       "SB_REASON", "HIS_TAXSTS", "REAL_FILE",  "SYS_FILE", "REAL_FILE2",  "SYS_FILE2"
                    
				}; 			

				int[] intArrCN = new int[] { 
					 1,  11,   2,   1,   4,  10, 40,
					 1,  40,  13,  60,  15,   8,
					15,  13,  15,  132,  16,
					 1,   9,   6,  15,   3,   1,
					12,  22,  22,  10,  66, 144,144,
					 1,   2,	 4,  50,   8,
					 7,  20,   7,  66,  11,  3, 20,
                    1,  5,   2000, 70,  1,  2, 100, 1, 20,
                    35, 2, 1,  6, 100,  
                    2,  8,  1, 8 , 8,
                    2, 100, 1, 50, 30 , 50, 30 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1,
					 0,   0,   0,  -1,  -1,
					-1,  -1,  -1,  -1,   0,  -1,
					-1,  -1,  -1,  -1,  -1,  -1,-1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1, -1,
					-1,  -1,  -1,  -1,  -1,  -1, -1, -1, -1,
					-1,  -1,  -1,  -1,  -1,   
					 0,  -1,  -1,  -1,  -1,
					 0,  -1,  -1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																		\n");	
						sql.append( " 'F' AS CHK,											/*선택*/					\n");
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,								/*계산서번호*/				\n");
						sql.append( " A.COCODE,												/*사업소코드*/				\n");
						sql.append( " A.TAXIODIV,											/*계산서구분*/				\n");
						sql.append( " A.TAXDIV,												/*귀속구분*/				\n");
						sql.append( " CASE WHEN A.TAXIODIV ='A' THEN '매입'	                /*구분명*/	            \n");
						sql.append( "      WHEN A.TAXIODIV ='B' THEN '매출'					        	           	\n");
						sql.append( " END AS TAXIODIVNM,															\n");
						sql.append( " RTRIM(D.CDNAM) TAXDIVNM,							    /*귀속명*/				\n");
						sql.append( " A.TAXKND,												/*부가세종류*/				\n");
						sql.append( " RTRIM(C.CDNAM) TAXKNDNM,							    /*종류명*/				\n");
						sql.append( " RTRIM(A.VEND_CD) VEND_CD,							    /*거래처코드*/				\n");
						sql.append( " RTRIM(B.VEND_NM) VEND_NM,							    /*거래처명*/				\n");
						sql.append( " RTRIM(B.VEND_ID) VEND_ID,							    /*거래처사업자NO*/		    \n");
						sql.append( " A.TAXDAT,												/*계산서일자*/				\n");
						sql.append( " COALESCE(A.TAXSUM,0) TAXSUM,					        /*공급가액*/				\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,		            /*부가세액*/				\n");
						sql.append( " COALESCE(A.TAXTOT,0) TAXTOT,					        /*합계금액*/				\n");
						sql.append( " RTRIM(A.REMARK) REMARK,								/*적요*/					\n");
						sql.append( " RTRIM(A.TAXCDNBR) TAXCDNBR,						    /*신용카드번호*/			\n");
						sql.append( " A.TAXPRTYN,											/*발행구분*/				\n");
						sql.append( " A.FSDAT,												/*전표일자*/				\n");
						sql.append( " A.FSNBR,												/*전표번호*/				\n");
						sql.append( " G.SSDAT || G.SSNBR AS FSNUM,					        /*전표번호*/				\n");
						sql.append( " COALESCE(A.TAXCNT,0) TAXCNT,					        /*발행횟수*/				\n");
						sql.append( " A.TAXKIDIV,											/*기수*/					\n");
						sql.append( " B.VD_DIRECT,											/*대표자*/				\n");
						sql.append( " B.BSNS_CND,											/*업태*/					\n");
						sql.append( " B.BSNS_KND,											/*종목*/					\n");
						sql.append( " F.COID,												/*사업자번호*/				\n");
						sql.append( " RTRIM(F.COSANG) COSANG,								/*상호*/					\n");
						sql.append( " RTRIM(B.ADDRESS1)ADDNM,  RTRIM(B.ADDRESS2) ADDNM2,			             	\n");
						sql.append( " RTRIM(G.FSSTAT) FSSTAT,														\n");
						sql.append( " RTRIM(A.FDCODE) FDCODE,														\n");
						sql.append( " RTRIM(A.DEPTCD) DEPTCD,														\n");
						sql.append( " RTRIM(H.DEPTNM) DEPTNM,														\n");
						sql.append( " SUBSTR(H.TREECD,1,4) || '0000' AS TREECD,             /*본부*/	   	            \n");
						sql.append( " RTRIM(A.EMPNO)  EMPNO,														\n");
                        sql.append( " RTRIM(Y.EMPNMK) EMPNMK,														\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE,								/*계정코드*/  			\n");
						sql.append( " RTRIM(K.ATKORNAM) ATKORNAM,						    /*계정명*/				\n");
						sql.append( " RTRIM(SUBSTR(A.TAXNBR,2,11)) TAXNBR_R,										\n");
						sql.append( " RTRIM(C.GBCD) GBCD, RTRIM(L.FDNAME) FDNAME,									\n");           
						sql.append( " X.DTI_STATUS,  X.RETURN_CODE, X.RETURN_DESCRIPTION, X.SBDESCRIPTION,          \n");
						sql.append( " A.GUBUN, A.AMEND_CODE, A.AMEND_REMARK, A.EXTCHK , Z.CREATION_DATE, 	        \n");
						sql.append( " A.CONVERSATION_ID, A.SUPBUY_TYPE, A.DIRECTION , A.COSTCD, K.CDNAM COSTNM ,    \n");
						sql.append( " LENGTH(B.VEND_ID) VEND_ID_LEN, A.DUEDATE, A.TAXSTS, A.WRDT, A.UPDT,           \n");
						sql.append( " XX.SEQ, XX.SB_REASON, XX.HIS_TAXSTS, A.REAL_FILE, A.SYS_FILE,A.REAL_FILE2, A.SYS_FILE2        \n");
						sql.append( " FROM ACCOUNT.ATTAXMST A																		\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE K ON A.ATCODE = K.ATCODE /*세금계산서MST*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD /*거래처코드*/	\n");
						if(str[0].equals("A")){
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0013' /*매입-부가세종류*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='0014' /*매입-귀속구분*/	 \n");
						}else if(str[0].equals("B")){
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0009' /*매출-부가세종류*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='1215' /*매출-귀속구분*/	 \n");
						}
						sql.append( " LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR    /*카드관리*/		\n");
						sql.append( " LEFT JOIN ACCOUNT.COMPANY  F ON A.COCODE=F.COCODE				        \n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST G ON A.FDCODE=G.FDCODE AND A.FSDAT=G.FSDAT AND A.FSNBR=G.FSNBR		\n");	
						sql.append( " LEFT JOIN PAYROLL.HCDEPT   H ON A.DEPTCD=H.DEPTCD				        \n");	
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL J ON A.DEPTCD=J.CDCODE AND J.CMTYPE='2139' \n");
						sql.append( " LEFT JOIN PAYROLL.YIPERSON Y ON A.EMPNO=Y.EMPNO   \n");
						sql.append( " LEFT JOIN ACCOUNT.FIELDCODE L ON L.FDCODE=A.FDCODE   \n");
						sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS X ON A.CONVERSATION_ID = X.CONVERSATION_ID    \n");
						sql.append( " 										AND A.SUPBUY_TYPE = X.SUPBUY_TYPE            \n");
						sql.append( "                                       AND A.DIRECTION = X.DIRECTION                \n");
						sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_MAIN Z ON A.CONVERSATION_ID = Z.CONVERSATION_ID      \n");
						sql.append( " 									    AND A.SUPBUY_TYPE = Z.SUPBUY_TYPE            \n");
						sql.append( "                                       AND A.DIRECTION = Z.DIRECTION                \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL K ON A.COSTCD=K.CDCODE AND K.CMTYPE ='0030' /*원가*/	 \n");
						sql.append( " LEFT JOIN ( SELECT TAXNBR, SEQ, SB_REASON , TAXSTS AS HIS_TAXSTS              	 \n");
						sql.append( " 	            FROM ACCOUNT.ATTAXHIS X1                                             \n");
						sql.append( " 	           WHERE SEQ = ( SELECT MAX(SEQ) FROM ACCOUNT.ATTAXHIS  WHERE X1.TAXNBR = TAXNBR ) \n");
						sql.append( " 	        ) XX ON XX.TAXNBR = A.TAXNBR AND XX.HIS_TAXSTS = A.TAXSTS                \n");
						sql.append( " WHERE A.TAXNBR IS NOT NULL														 \n");
						sql.append( "    AND A.TAXNBR LIKE 'H%'														     \n");						
						if(!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.TAXIODIV = '"+str[0]+"'			 \n");
						if(!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.COCODE   = '"+str[1]+"'		     \n");
						if(!str[2].equals(""))  sql.append( " AND A.TAXDAT BETWEEN '"+str[2]+"' AND '"+str[3]+"' 	     \n");
						if(!str[4].equals(""))  sql.append( " AND A.VEND_CD  = '"+str[4]+"'								 \n");
						if(!str[5].equals(""))  sql.append( " AND A.TAXDIV   = '"+str[5]+"'								 \n");
						if(!str[6].equals(""))  sql.append( " AND A.TAXKND   IN ('"+str[6]+"')  						    \n");
						if(!str[7].equals(""))  sql.append( " AND A.TAXPRTYN = '"+str[7]+"'									\n");
						if(str[8].equals("X")){ sql.append( " AND ( G.FSSTAT  IN ( 'C','R','N','B') OR G.FSSTAT IS NULL )	\n");
						}else{
							if(!str[8].equals(""))  sql.append( " AND G.FSSTAT   = '"+str[8]+"'	\n");
						}
						if(!str[9].equals(""))  sql.append( " AND B.VEND_NM LIKE '"+str[9]+"%'	\n");
						if(!str[10].equals("")) sql.append( " AND A.FDCODE  = '"+str[10]+"'		\n");
						if(!str[16].equals("")) sql.append( " AND A.AMEND_CODE  = '"+str[16]+"'	\n");
						if(!str[17].equals("")) sql.append( " AND A.GUBUN  = '"+str[17]+"'		\n");
						
						if(!str[13].equals("")&&!str[13].equals("1")){
							//새로운필드를 추가해야함. 
							if(str[14].equals("")&&str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' )	\n");
							if(!str[14].equals("")&&!str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.EMPNO IN ('"+str[14]+"') OR A.DEPTCD IN ('"+str[15]+"'))	\n");
							if(!str[14].equals("")&&str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.EMPNO IN ('"+str[14]+"')) 	\n");
							if(str[14].equals("")&&!str[15].equals(""))sql.append( " AND(A.EMPNO='"+str[12]+"' OR A.DEPTCD IN ('"+str[15]+"'))	\n");
						}						
						//if(!str[18].equals("")) sql.append( " AND A.EMPNO  IN ( '"+str[18]+"')			\n");
						if(!str[19].equals("")) sql.append( " AND A.COSTCD  = '"+str[19]+"'		    	\n");
						if(!str[20].equals("")) sql.append( " AND A.EBILLGB = '"+str[20]+"'		    	\n");
						if(!str[21].equals("")) sql.append( " AND A.TAXSTS  = '"+str[21]+"'		    	\n");

						sql.append( " ORDER BY G.SSDAT,G.SSNBR,A.TAXNBR									\n");
						
						System.out.println("# Query : \n" + sql.toString());
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