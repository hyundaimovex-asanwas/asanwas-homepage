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
public class a080005_s2 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//지점코드     
				str[1] = req.getParameter("v_str2");	//신청서번호     

				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK",   "BGTRQNO","FDCODE", "BGTYY",	 "BGTMM",	 
					"BGTDIV","BGTDPT", "ATCODE", "FSREFCD","SATCODE",
					"BGTRQDIV","BGTRQAMT","CNT"
				}; 

				int[] intArrCN = new int[] { 
					 1,  12,   2,    4,   2,   
					 4,   4,   7,   4,	 2,   
					 2,  15,   5  
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,   
					-1,  -1,  -1,  -1,  -1,   
					-1,   0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT                                                                    					\n");
						sql.append( " 'F' AS CHK,											/*구분*/		                         \n");
						sql.append( " RTRIM(B.BGTRQNO)  BGTRQNO,      /*신청서번호*/                          \n"); 
						sql.append( " RTRIM(B.FDCODE)   FDCODE,       /*지점코드*/                             	\n"); 
						sql.append( " RTRIM(A.BGTYY)    BGTYY,        /*예산년도*/                             		\n"); 
						sql.append( " RTRIM(B.BGTTOMON) BGTMM,        /*배정월*/                               	\n"); 
						sql.append( " RTRIM(A.BGTDIV)   BGTDIV,       /*예산본부*/                             		\n"); 
						sql.append( " RTRIM(A.BGTDPT)   BGTDPT,       /*예산부서*/                             	\n"); 
						sql.append( " RTRIM(A.ATCODE)   ATCODE,       /*계정과목*/                             	\n"); 
						sql.append( " RTRIM(A.FSREFCD)  FSREFCD,      /*관리항목*/                             	\n"); 
						sql.append( " RTRIM(A.SATCODE)  SATCODE,      /*세세목*/                               	\n"); 
						sql.append( " RTRIM(B.BGTRQDIV) BGTRQDIV,     /*신청서구분*/                           	\n"); 
						sql.append( " RTRIM(B.BGTRQAMT) BGTRQAMT,     /*신청금액*/                            \n"); 
						sql.append( " (SELECT COUNT(*) FROM ACCOUNT.BGTRQDTL1                           	\n"); 
						sql.append( " WHERE FDCODE='"+str[0]+"' AND BGTRQNO='"+str[1]+"') CNT			\n"); 
						sql.append( " FROM ACCOUNT.BGTRQDTL1 B                                                 		\n"); 
						sql.append( " LEFT JOIN ACCOUNT.BGTRQMST A ON A.FDCODE=B.FDCODE AND A.BGTRQNO=B.BGTRQNO	\n"); 
						sql.append( " WHERE B.FDCODE='"+str[0]+"' AND B.BGTRQNO='"+str[1]+"' 				\n"); 
						sql.append( " ORDER BY FDCODE,BGTRQNO														\n");

						
						System.out.println("# Query : \n" + sql);
						
/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try {stmt.close(); } catch (Exception e) {}
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