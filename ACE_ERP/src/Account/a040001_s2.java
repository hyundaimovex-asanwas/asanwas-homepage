package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

//음 테스트위해 임의로 수정함.  a040001_s2 ==>a040001_s2_9

// class 이름은 화일명과 항상 동일해야 함.
public class a040001_s2 extends HttpServlet {
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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"TAXNBR","TAXSEQ","TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC","TAXSUM","TAXVATAMT","TAXTOT2","BIGO",
					"WRDT","WRID","UPDT","UPID","TAXMM",
					"TAXDT","TAXNBR_R", "EMPNO", "EMPNMK", "DEPTCD", "DEPTNM"
				}; 

				int[] intArrCN = new int[] { 
					11,   3,  70,  36,  13,
					15,  15,  13,  15,  66,   
					 8,		7,   8,   7,   2,   
					 2,  11, 7, 30, 4, 30
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,   0,
					 0,   0,   0,   0,  -1,  
					-1,  -1,  -1,	 -1,  -1,
					-1,  -1, -1, -1, -1, -1
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
						sql.append( " RTRIM(A.TAXNBR) TAXNBR,             				/*계산서번호*/		\n");
						sql.append( " RTRIM(A.TAXSEQ) TAXSEQ,             				/*계산서순서*/		\n");
						sql.append( " RTRIM(A.TAXPDTNAM) TAXPDTNAM,				/*품목*/					\n");
						sql.append( " RTRIM(A.TAXSTD) TAXSTD,							/*규격*/					\n");
						sql.append( " COALESCE(A.TAXQTY,0)  TAXQTY,       			/*수량*/					\n");
						sql.append( " COALESCE(A.TAXPRIC,0) TAXPRIC,      			/*단가*/					\n");
						sql.append( " COALESCE(A.TAXSUM,0)  TAXSUM,       			/*공급가액*/			\n");
						sql.append( " COALESCE(A.TAXVATAMT,0) TAXVATAMT,  				/*부가세액*/				\n");
						sql.append( " COALESCE(A.TAXSUM+A.TAXVATAMT,0) TAXTOT2,  	/*합계*/						\n");
						sql.append( " RTRIM(A.BIGO) BIGO,											/*비고*/						\n");
						sql.append( " RTRIM(A.WRDT) WRDT,											/*작업일자*/				\n");
						sql.append( " RTRIM(A.WRID) WRID,											/*작업자*/					\n");
						sql.append( " RTRIM(A.UPDT) UPDT,											/*수정일자*/				\n");
						sql.append( " RTRIM(A.UPID) UPID,												/*수정자*/					\n");
						sql.append( " SUBSTR(B.TAXDAT,5,2) AS TAXMM,     	 				/*월*/						\n");
						sql.append( " SUBSTR(B.TAXDAT,7,2) AS TAXDT, 						/*일*/						\n");
						sql.append( " RTRIM(SUBSTR(A.TAXNBR,2,11)) TAXNBR_R, B.EMPNO,   							\n");
						sql.append( " D.ENO_NM EMPNMK, B.DEPTCD, E.DPT_NM DEPTNM												\n");
						sql.append( " FROM ACCOUNT.ATTAXDTL A									/*세금계산서DTL*/					\n");
						sql.append( " LEFT JOIN ACCOUNT.ATTAXMST B ON A.TAXNBR = B.TAXNBR /*세금계산서MST*/		\n");
						sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER C ON B.VEND_CD=C.VEND_CD /*거래처코드*/	\n");
						sql.append( " LEFT JOIN ASNHR.T_CM_PERSON D ON D.ENO_NO=B.EMPNO 								\n");
						sql.append( " LEFT JOIN ASNHR.T_CM_DEPT E ON E.DPT_CD=B.DEPTCD 									\n");
						//sql.append( " LEFT JOIN PAYROLL.HIPERSON D ON D.EMPNO=B.EMPNO 	\n");
						//sql.append( " LEFT JOIN PAYROLL.HCDEPT E ON E.DEPTCD=B.DEPTCD  AND E.CHGYM = (SELECT MAX(Z.CHGYM) FROM PAYROLL.HCDEPT Z \n");
						//sql.append( " WHERE Z.CHGYM <= SUBSTR(B.TAXDAT,1,6) \n");
						//sql.append( " ) \n");
						//sql.append( " LEFT JOIN PAYROLL.T_HIPERSON T ON B.EMPNO=T.EMPNO   \n");
						sql.append( " WHERE A.TAXNBR IS NOT NULL                                  \n");
						if(!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.TAXNBR = '"+str[0]+"'	\n");
						sql.append( " ORDER BY TAXNBR,TAXSEQ																\n");


						//System.out.println("# Query : \n" + sql.toString());
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