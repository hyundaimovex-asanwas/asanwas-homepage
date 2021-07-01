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
public class a040001_s4 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//계산서번호
				str[1] = req.getParameter("v_str2");	//사업소
				str[2] = req.getParameter("v_str3");	//계산서일자
				str[3] = req.getParameter("v_str4");	//거래처코드 
				str[4] = req.getParameter("v_str5");	//귀속구분   
				str[5] = req.getParameter("v_str6");	//계산서종류 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"TAXNBR","TAXSEQ","TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC","TAXSUM","TAXVATAMT","BIGO","WRDT",
					"WRID","UPDT","UPID",
					"TAXMM","TAXDT","TAXDAT","MTAXSUM","MTAXVATAMT","REMARK",
					"VEND_NM","VD_DIRECT","BSNS_CND","BSNS_KND","ADDNM","ADDNM2",
					"TSUM_11","TSUM_10","TSUM_9","TSUM_8","TSUM_7",	
					"TSUM_6","TSUM_5","TSUM_4","TSUM_3","TSUM_2","TSUM_1",	
					"TVAT_10","TVAT_9","TVAT_8","TVAT_7","TVAT_6",
					"TVAT_5","TVAT_4","TVAT_3","TVAT_2","TVAT_1",
					"BlkCnt","CNT",
					"SEQ_1","SEQ_2","SEQ_3","SEQ_4","SEQ_5","SEQ_6",
					"VSEQ_1","VSEQ_2","VSEQ_3","VSEQ_4","VSEQ_5",
					"VSEQ_6","VSEQ_7","VSEQ_8","VSEQ_9","VSEQ_10",
					"CEONAME"
				}; 


				int[] intArrCN = new int[] { 
					11,   3,  36,  36,  13,
					15,  15,  13,  66,   8,
					 7,   8,   7,
					 2,   2,   8,  15,  13,	132,  
					32,  12,  22,  22, 144, 144,
					 1,   1,   1,   1,   1, 
					 1,   1,   1,   1,   1,  1,
					 1,   1,   1,   1,   1, 
					 1,   1,   1,   1,   1, 
					 3,   4, 
					 1,   1,   1,   1,   1,  1,
   				 3,   3,   3,   3,   3,
					 3,   3,   3,   3,   3,
          30
					 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,   0,
					 0,   0,   0,  -1,  -1,
					-1,  -1,  -1,
					-1,  -1,  -1,   0,   0,	-1,
					-1,  -1,  -1,  -1,  -1, -1, 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1, -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,  -1, 
					-1,  -1,  -1,  -1,  -1, -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
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
						sql.append( " SELECT																								\n");	
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,             /*계산서번호*/		\n");
						sql.append( " RTRIM(A.TAXSEQ) TAXSEQ,             /*계산서순서*/		\n");
						sql.append( " RTRIM(A.TAXPDTNAM) TAXPDTNAM,				/*품목*/					\n");
						sql.append( " RTRIM(A.TAXSTD) TAXSTD,							/*규격*/					\n");
						sql.append( " COALESCE(A.TAXQTY,0)  TAXQTY,       /*수량*/					\n");
						sql.append( " COALESCE(A.TAXPRIC,0) TAXPRIC,      /*단가*/					\n");
						sql.append( " COALESCE(A.TAXSUM,0)  TAXSUM,       /*공급가액*/			\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,  /*부가세액*/			\n");
						sql.append( " RTRIM(A.BIGO) BIGO,									/*비고*/					\n");
						sql.append( " RTRIM(A.WRDT) WRDT,									/*작업일자*/			\n");
						sql.append( " RTRIM(A.WRID) WRID,									/*작업자*/				\n");
						sql.append( " RTRIM(A.UPDT) UPDT,									/*수정일자*/			\n");
						sql.append( " RTRIM(A.UPID) UPID,									/*수정자*/				\n");
						sql.append( " SUBSTR(B.TAXDAT,5,2) AS TAXMM,      /*월*/						\n");
						sql.append( " SUBSTR(B.TAXDAT,7,2) AS TAXDT,			/*일*/						\n");
						/* 세금계산서MST*/
						sql.append( " B.TAXDAT,                           /*계산서일자*/		\n");
						sql.append( " COALESCE(B.TAXSUM,0) MTAXSUM,       /*공급가액*/			\n");
						sql.append( " COALESCE(B.TAXVATAMT,0) MTAXVATAMT, /*부가세액*/			\n");
						sql.append( " RTRIM(B.REMARK) REMARK,             /*적요*/					\n");
						/* 거래처관리 */
						sql.append( " RTRIM(C.VEND_NM) VEND_NM,           /*거래처명*/			\n");
						sql.append( " C.VD_DIRECT,												/*대표자*/				\n");
						sql.append( " C.BSNS_CND,													/*업태*/					\n");
						sql.append( " C.BSNS_KND,													/*종목*/					\n");
						sql.append( " RTRIM(C.ADDRESS1) ADDNM, RTRIM(C.ADDRESS2) ADDNM2,  	\n");
						/* 공급가액 - Truncate */
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-10,1) TSUM_11,			\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-9,1)  TSUM_10,			\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-8,1)  TSUM_9,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-7,1)  TSUM_8,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-6,1)  TSUM_7,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-5,1)  TSUM_6,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-4,1)  TSUM_5,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-3,1)  TSUM_4,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-2,1)  TSUM_3,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))-1,1)  TSUM_2,				\n");
						sql.append( " SUBSTR(B.TAXSUM,LENGTH(RTRIM(B.TAXSUM))  ,1)  TSUM_1,				\n");
						/* 부가세액 - Truncate */
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-9,1) TVAT_10, \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-8,1) TVAT_9,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-7,1) TVAT_8,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-6,1) TVAT_7,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-5,1) TVAT_6,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-4,1) TVAT_5,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-3,1) TVAT_4,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-2,1) TVAT_3,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))-1,1) TVAT_2,  \n");
						sql.append( " SUBSTR(B.TAXVATAMT,LENGTH(RTRIM(B.TAXVATAMT))  ,1) TVAT_1,  \n");
						sql.append( " 11-LENGTH(RTRIM(B.TAXSUM)) BlkCnt, 	/*공급가액 공란수*/			\n");
						sql.append( " SUBSTR(RTRIM(B.TAXNBR),6,2) CNT,								/*책번호 - XXXX 호*/		\n");
						sql.append( " '0'   SEQ_1,						/*일련번호 6자리*/			\n");
						sql.append( " '0'   SEQ_2,																		\n");
						sql.append( " SUBSTR(RTRIM(B.TAXNBR),8,1)   SEQ_3,																		\n");
						sql.append( " SUBSTR(RTRIM(B.TAXNBR),9,1)   SEQ_4,																		\n");
						sql.append( " SUBSTR(RTRIM(B.TAXNBR),10,1)  SEQ_5,																		\n");
						sql.append( " SUBSTR(RTRIM(B.TAXNBR),11,1)  SEQ_6, 																		\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),1,1)  VSEQ_1,		/*거래처-등록번호 10자리*/		\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),2,1)  VSEQ_2, 											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),3,1)  VSEQ_3, 											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),4,1)  VSEQ_4,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),5,1)  VSEQ_5,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),6,1)  VSEQ_6,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),7,1)  VSEQ_7,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),8,1)  VSEQ_8,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),9,1)  VSEQ_9,											\n");
						sql.append( " SUBSTR(RTRIM(C.VEND_ID),10,1) VSEQ_10, 										\n");
						sql.append( " CASE WHEN B.TAXDAT<'20080828' THEN '윤만준' ELSE '조건식' END CEONAME   			\n");
						sql.append( " FROM ACCOUNT.ATTAXDTL A							/*세금계산서DTL*/									\n");
						sql.append( " LEFT JOIN ACCOUNT.ATTAXMST B ON A.TAXNBR = B.TAXNBR /*세금계산서MST*/				\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER C ON B.VEND_CD=C.VEND_CD /*거래처코드*/			\n");
						sql.append( " WHERE A.TAXNBR IS NOT NULL AND B.TAXIODIV ='B' /*매출*/										\n");
						if(!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.TAXNBR = '"+str[0]+"'			\n");
						if(!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.COCODE = '"+str[1]+"'			\n");
						if(!str[2].equals("")) sql.append( " AND B.TAXDAT   = '"+str[2]+"'										\n");
						if(!str[3].equals("")) sql.append( " AND B.VEND_CD   = '"+str[3]+"'									\n");
						if(!str[4].equals("")) sql.append( " AND B.TAXDIV   = '"+str[4]+"'										\n");
						if(!str[5].equals("")) sql.append( " AND B.TAXKND   = '"+str[5]+"'										\n");

						sql.append( " ORDER BY TAXNBR,TAXSEQ																	\n");

						//System.out.println("a040001_s1: \n" + sql.toString());
						
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