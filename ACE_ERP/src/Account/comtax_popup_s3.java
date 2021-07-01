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
public class comtax_popup_s3 extends HttpServlet {
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
				String []  str	= new String [1];
				str[0] = req.getParameter("v_str1");	//계산서번호

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXDIVNM",
					"TAXKND","TAXKNDNM","CCCODE","VEND_NM","TAXDAT",
					"TAXSUM","TAXVATAMT","TAXTOT","REMARK","TAXCDNBR",
					"TAXPRTYN","FSDAT","FSNBR","TAXCNT","TAXKIDIV",
					"FDCODE",
					"WRDT","WRID","UPDT","UPID",
					"VD_DIRECT","BSNS_CND","BSNS_KND","ADDNM"
				}; 

				int[] intArrCN = new int[] { 
					10,   2,   1,   2,  40,
					 1,  40,  13,  32,   8,
					15,  13,  15,  40,  16,
					 1,   9,   6,   3,   1,
					 2,
					 8,   7,   8,   7,
					12,  22,  22, 144
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					 0,   0,   0,  -1,  -1,
					-1,  -1,  -1,   0,  -1,
					-1,
					-1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1
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
						sql.append( " A.COCODE,                           /*사업소코드*/		\n");
						sql.append( " RTRIM(A.TAXIODIV) TAXIODIV,         /*계산서구분*/		\n");
						sql.append( " RTRIM(A.TAXDIV) TAXDIV,             /*귀속구분*/			\n");
						sql.append( " RTRIM(D.CDNAM) TAXDIVNM,            /*귀속명*/				\n");
						sql.append( " RTRIM(A.TAXKND) TAXKND,             /*계산서종류*/		\n");
						sql.append( " RTRIM(C.CDNAM) TAXKNDNM,            /*종류명*/				\n");
						sql.append( " RTRIM(A.CCCODE) CCCODE,             /*거래처코드*/		\n");
						sql.append( " RTRIM(B.VEND_NM) VEND_NM,           /*거래처명*/			\n");
						sql.append( " A.TAXDAT,                           /*계산서일자*/		\n");
						sql.append( " COALESCE(A.TAXSUM,0) TAXSUM,        /*공급가액*/			\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,  /*부가세액*/			\n");
						sql.append( " COALESCE(A.TAXTOT,0) TAXTOT,        /*합계금액*/			\n");
						sql.append( " RTRIM(A.REMARK) REMARK,             /*적요*/					\n");
						sql.append( " RTRIM(A.TAXCDNBR) TAXCDNBR,         /*신용카드번호*/	\n");
						sql.append( " A.TAXPRTYN,                         /*발행구분*/			\n");
						sql.append( " A.FSDAT,                            /*전표일자*/			\n");
						sql.append( " A.FSNBR,                            /*전표번호*/			\n");
						sql.append( " COALESCE(A.TAXCNT,0) TAXCNT,        /*발행횟수*/			\n");
						sql.append( " A.TAXKIDIV,                         /*기수*/					\n");
						sql.append( " A.FDCODE,                           /*지점*/					\n");
						sql.append( " A.WRDT,                             /*작업일자*/			\n");
						sql.append( " A.WRID,                             /*작업자*/				\n");
						sql.append( " A.UPDT,                             /*수정일자*/			\n");
						sql.append( " A.UPID,                             /*수정자*/				\n");
						sql.append( " B.VD_DIRECT,												/*대표자*/				\n");
						sql.append( " B.BSNS_CND,													/*업태*/					\n");
						sql.append( " B.BSNS_KND,													/*종목*/					\n");
						sql.append( " RTRIM(B.ADDRESS1) || ' ' || RTRIM(B.ADDRESS2) ADDNM 	\n");
						sql.append( " FROM ACCOUNT.ATTAXMST A /*세금계산서MST*/							\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.CCCODE=B.VEND_CD /*거래처코드*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.TAXKND=C.CDCODE AND C.CMTYPE ='0013' /*공통-계산서종류*/ \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.TAXDIV=D.CDCODE AND D.CMTYPE ='0014' /*공통-귀속구분*/	 \n");
						sql.append( " LEFT JOIN ACCOUNT.CARDCODE E ON A.TAXCDNBR=E.CANBR    /*카드관리*/		\n");
						sql.append( " WHERE A.TAXNBR = '"+str[0]+"'                          \n");
						sql.append( " ORDER BY TAXNBR,TAXDAT,TAXIODIV,TAXKND								\n");
						
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