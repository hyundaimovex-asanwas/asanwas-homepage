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
public class a040001_s1_e extends HttpServlet {
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
				//웹페이지에서 조건값을 넘겨받음
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//접수번호(=계산서번호)
				str[2] = req.getParameter("v_str3");	//회계구분
				str[3] = req.getParameter("v_str4");	//회계구분
				str[4] = req.getParameter("v_str5");	//회계구분

				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				if(str[3].equals("3080087")){ //개성관리자이면
					str[4]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"TAXNBR",  "COCODE",   "DEPTCD",   "EMPNO",    "TAXIODIV",
					"TAXDIV",  "TAXDIVNM", "TAXKND",   "TAXKNDNM", "VEND_CD",  "VEND_ID",
					"VEND_NM", "TAXDAT",   "TAXSUM",   "TAXVATAMT","TAXTOT",
					"REMARK",  "TAXCDNBR", "ATCODE",   "ATKORNAM", "ATDECR",   "TAXPRTYN",
					"TAXCNT",  "LASTPRT",  "TAXTYPE",  "FSDAT",    "FSNBR",
					"TAXKIDIV","WRDT",     "WRID",     "UPDT",     "UPID",
					"FDCODE",  "VD_DIRECT","BSNS_CND", "BSNS_KND", "ADDNM",
					"FSSTAT",  "TAXNBR_R", "WORKTYPE", "EMPNMK",   "DEPTNM",
				  "SEQ",     "EMPNM",    "DEPTNM_2", "HPNO",     "TELNO",    "EMAIL",
					"DTI_STATUS"

				}; 

				int[] intArrCN = new int[] { 
					11,   2,   4,   7,   1,   
					 4,  40,   1,  40,  13,  15,
					32,   8,	15,  13,  15,  
					132,  16,   7,  66,   1,   1,
					 3,		8,   1,   9,   6,   
					 1,   8,   7,   8,   7,   
					 2,	 12,  22,  22, 144,
					 1,  11,   1,  30,  30,  
					 2,  30,  30,  15,  15,  30,
					 1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,	-1,
					-1,  -1,   0,   0,   0,
					-1,  -1,  -1,  -1,  -1, -1,    
					 0,	 -1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,  -1,  -1,  -1,  -1, -1,
					-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT                                               	\n");	
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,             /*계산서번호*/   	\n");
						sql.append( " A.COCODE,                           /*사업소코드*/   	\n");
						sql.append( " A.DEPTCD,                           /*담당부서*/     	\n");
						sql.append( " A.EMPNO,                            /*담당자*/       	\n");
						sql.append( " A.TAXIODIV,                         /*계산서구분*/   	\n");
						sql.append( " A.TAXDIV,                           /*귀속구분*/     	\n");
						sql.append( " CASE WHEN A.TAXIODIV='A' THEN RTRIM(D.CDNAM) ELSE RTRIM(D2.CDNAM) END  TAXDIVNM,  /*귀속명*/ \n");
						sql.append( " A.TAXKND,                           /*계산서종류*/   	\n");
						sql.append( " RTRIM(C.CDNAM) TAXKNDNM,            /*종류명*/       	\n");
						sql.append( " RTRIM(A.VEND_CD) VEND_CD,           /*거래처코드*/ 		\n");
						sql.append( " RTRIM(B.VEND_ID) VEND_ID,           /*사업자번호*/ 		\n");
						sql.append( " RTRIM(B.VEND_NM) VEND_NM,           /*거래처명*/     	\n");
						sql.append( " A.TAXDAT,                           /*계산서일자*/   	\n");
						sql.append( " COALESCE(A.TAXSUM,0) TAXSUM,        /*공급가액*/     	\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,  /*부가세액*/     	\n");
						sql.append( " COALESCE(A.TAXTOT,0) TAXTOT,        /*합계금액*/     	\n");
						sql.append( " RTRIM(A.REMARK) REMARK,             /*적요*/         	\n");
						sql.append( " RTRIM(A.TAXCDNBR) TAXCDNBR,         /*신용카드번호*/ 	\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE,             /*계정코드*/     	\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM,         /*계정명*/	     	\n");
						sql.append( " RTRIM(F.ATDECR) ATDECR,							/*차대구분*/	   	\n");
						sql.append( " A.TAXPRTYN,                         /*발행여부*/     	\n");
						sql.append( " COALESCE(A.TAXCNT,0) TAXCNT,        /*발행횟수*/     	\n");
						sql.append( " A.LASTPRT,                          /*최종출력일*/   	\n");
						sql.append( " A.TAXTYPE,                          /*발행구분*/     	\n");
						sql.append( " A.FSDAT,                            /*전표일자*/     	\n");
						sql.append( " A.FSNBR,                            /*전표번호*/     	\n");
						sql.append( " A.TAXKIDIV,                         /*기수*/         	\n");
						sql.append( " A.WRDT,                             /*작업일자*/     	\n");
						sql.append( " A.WRID,                             /*작업자*/       	\n");
						sql.append( " A.UPDT,                             /*수정일자*/     	\n");
						sql.append( " A.UPID,                             /*수정자*/       	\n");
						sql.append( " A.FDCODE,                           /*지점코드*/     	\n");
						sql.append( " B.VD_DIRECT,                        /*대표자*/       	\n");
						sql.append( " B.BSNS_CND,                         /*업태*/         	\n");
						sql.append( " B.BSNS_KND,                         /*종목*/         	\n");
						sql.append( " RTRIM(B.ADDRESS1) || ' ' || RTRIM(B.ADDRESS2) ADDNM,  \n");
						sql.append( " RTRIM(G.FSSTAT) FSSTAT,  															\n");
						sql.append( " RTRIM(SUBSTR(A.TAXNBR,2,11)) TAXNBR_R, 								\n");
						sql.append( " RTRIM(A.WORKTYPE) WORKTYPE, 									\n");
						sql.append( " H.EMPNMK, I.DEPTNM ,	\n");
						sql.append( " COALESCE(A.SEQ,0)SEQ, J.EMPNM, J.DEPTNM AS DEPTNM_2, J.HPNO, J.TELNO, J.EMAIL, COALESCE(X.DTI_STATUS,'')DTI_STATUS 	\n");
						sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.ACTCODE F /*세금계산서MST*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD /*거래처코드*/												\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0013' /*공통-계산서종류*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='0014' /*공통-귀속구분*/		\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D2 ON A.TAXDIV=D2.CDCODE AND D2.CMTYPE ='1215' /*공통-귀속구분*/		\n");
						sql.append( " LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR    /*카드관리*/													\n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST G ON A.FDCODE=G.FDCODE AND A.FSDAT=G.FSDAT AND A.FSNBR=G.FSNBR		\n");
						sql.append( " LEFT JOIN PAYROLL.YIPERSON H ON H.EMPNO=A.EMPNO 		\n");	
						sql.append( " LEFT JOIN PAYROLL.HCDEPT I ON I.DEPTCD=H.DEPTCD		\n");				 
						sql.append( " LEFT JOIN ACCOUNT.CUSTOMER J ON A.VEND_CD=J.VEND_CD AND A.SEQ = J.SEQ		\n");		
						sql.append( " LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS X ON A.CONVERSATION_ID = X.CONVERSATION_ID \n");	
						sql.append( "                                       AND A.SUPBUY_TYPE = X.SUPBUY_TYPE         \n");	
						sql.append( "                                       AND A.DIRECTION = X.DIRECTION             \n");	
						sql.append( " WHERE A.TAXNBR IS NOT NULL AND A.ATCODE = F.ATCODE		\n");	
						if(!str[0].equals("")) sql.append( " AND A.FDCODE = '"+str[0]+"'			\n");
						if(!str[1].equals("")) sql.append( " AND A.TAXNBR LIKE '"+str[1]+"%'	\n");
						if(!str[2].equals("")) sql.append( " AND A.WORKTYPE = '"+str[2]+"'	\n");
						if(!str[4].equals("")&&!str[4].equals("1")) sql.append( " AND A.EMPNO= '"+str[3]+"'		\n");
						sql.append( " ORDER BY FDCODE,TAXNBR	\n");

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