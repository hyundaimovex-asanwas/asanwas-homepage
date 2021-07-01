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
public class a070003_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //지점코드  
				String  str2	= req.getParameter("v_str2"); //부서코드   
				String  str3	= req.getParameter("v_str3"); //신청년월
				String  str4	= req.getParameter("v_str4"); //신청년월

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ACYYMM","ACWEEK","DEPTCD","REMCODE",
					"AMTDIV","PLAMT","EXAMT","REMARK","EXDATE",
					"STATDIV","ATKORNAM", "VENDNM"
				};

				int[] intArrCN = new int[]{
					2,   6,   1,   4,  7,  
					1,  15,  15, 132,  8, 
					1,  66,  200
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, -1,
					-1,  0,  0, -1, -1,
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
					sql.append( " SELECT																		\n");
					sql.append( " RTRIM(A.FDCODE)   FDCODE,   /*지점*/			\n");
					sql.append( " RTRIM(A.ACYYMM)   ACYYMM,   /*신청년월*/	\n");
					sql.append( " RTRIM(A.ACWEEK)   ACWEEK,   /*주간구분*/	\n");
					sql.append( " RTRIM(A.DEPTCD)   DEPTCD,   /*부서*/			\n");
					sql.append( " RTRIM(A.REMCODE)  REMCODE,  /*계정과목*/	\n");
					sql.append( " RTRIM(A.AMTDIV)   AMTDIV,   /*지급기준*/	\n");
					sql.append( " nvl(A.PLAMT,0) PLAMT,    /*신청금액*/	\n");
					sql.append( " nvl(A.EXAMT,0) EXAMT,    /*실적금액*/	\n");
					sql.append( " RTRIM(A.REMARK)   REMARK,   /*적요*/			\n");
					sql.append( " RTRIM(A.EXDATE)   EXDATE,   /*결재일자*/	\n");
					sql.append( " RTRIM(A.STATDIV)  STATDIV,  /*처리구분*/	\n");
					sql.append( " RTRIM(F.ATKORNAM) ATKORNAM  /*계정명*/ , RTRIM(G.VEND_NM) VENDNM		\n");
					sql.append( " FROM ACCOUNT.AFUNDWEK A,ACCOUNT.ACTCODE F,  ACCOUNT.GCZM_VENDER G	\n");
					sql.append( " WHERE A.REMCODE=F.ATCODE									\n");
					sql.append( " AND A.VENDCD =G.VEND_CD								\n");
 					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' ");
 					if (!str2.equals("")) sql.append( " AND A.DEPTCD = '" + str2 + "' ");
 					if (!str3.equals("")) sql.append( " AND A.ACYYMM = '" + str3 + "'");
 					if (!str4.equals("")) sql.append( " AND A.ACWEEK = '" + str4 + "'");

 					System.out.println("# a070003_s1 : \n" + sql.toString());
 					
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