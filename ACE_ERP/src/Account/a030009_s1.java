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
public class a030009_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//회계년월
		
				for(int i=0;i<=1;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PRTACT","PRTNAM","PRTSEQ","DECRTOT"	}; 

				int[] intArrCN = new int[] {  7,  66,   5,   9	}; 
			
				int[] intArrCN2 = new int[]{ -1,  -1,  -1,   0	}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();			
						sql.append( " SELECT F.PRTACT,F.PRTNAM,F.PRTSEQ,COALESCE(E.DECRTOT,0) DECRTOT																										 \n");
						sql.append( " FROM ACCOUNT.RPTPRTACT F																																													 \n");
						sql.append( " LEFT JOIN																																																					 \n");
						sql.append( "      (SELECT D.PRTACT, SUM(CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END) AS DECRTOT          \n"); 
						sql.append( "      FROM ACCOUNT.RPTPRTREF D  																																										 \n");
						sql.append( "      LEFT JOIN																																																		 \n");
						sql.append( "           (SELECT B.ATDECR  AS ATDECR, B.ATCODE AS ATCODE,A.DETOT AS DETOT,A.CRTOT AS CRTOT												 \n");
						sql.append( "           FROM ACCOUNT.BALSHEET A, ACCOUNT.ACTCODE B																															 \n");
						sql.append( "           WHERE A.ATCODE = B.ATCODE AND A.FDCODE = '"+str[0]+"' AND A.ACTYYMM = '"+str[1]+"'											 \n");
						sql.append( "      ) C ON C.ATCODE = D.PRTACTREF AND D.PRTCODE = '03'																														 \n");
						sql.append( "      GROUP BY D.PRTACT																 																 														 \n");
						sql.append( " ) E ON E.PRTACT = F.PRTACT AND F.PRTCODE = '03'																																		 \n");

						sql.append( " UNION ALL	\n");

						sql.append( " SELECT H.PRTACT,H.PRTNAM,H.PRTSEQ,COALESCE(G.DECRTOT,0) DECRTOT																										 \n");
						sql.append( " FROM ACCOUNT.RPTPRTACT H																																													 \n");
						sql.append( " LEFT JOIN																																																					 \n");
						sql.append( "      (SELECT F.ATUPCODE,SUM(E.DECRTOT) AS DECRTOT																																	 \n");
						sql.append( "       FROM ACCOUNT.RPTPRTACT F																																										 \n");
						sql.append( "       LEFT JOIN																																																		 \n");
						sql.append( "            (SELECT D.PRTACT, SUM(CASE WHEN C.ATDECR = '1' THEN DETOT - CRTOT ELSE CRTOT - DETOT END) AS DECRTOT		 \n");
						sql.append( "             FROM ACCOUNT.RPTPRTREF D																																							 \n");
						sql.append( "             LEFT JOIN																																															 \n");
						sql.append( "                 (SELECT B.ATDECR AS ATDECR,B.ATCODE AS ATCODE,A.DETOT AS DETOT,A.CRTOT AS CRTOT										 \n");
						sql.append( "                  FROM ACCOUNT.BALSHEET A, ACCOUNT.ACTCODE B																												 \n");
						sql.append( "                  WHERE A.ATCODE = B.ATCODE AND A.FDCODE = '"+str[0]+"' AND A.ACTYYMM = '"+str[1]+"'								 \n");
						sql.append( "             ) C ON C.ATCODE = D.PRTACTREF AND D.PRTCODE = '03'																										 \n");
						sql.append( "						  GROUP BY D.PRTACT																																											 \n");
						sql.append( "       ) E  ON E.PRTACT = F.PRTACT AND F.PRTCODE = '03'																														 \n");
						sql.append( "			 GROUP BY F.ATUPCODE																																													 \n");
						sql.append( " ) G ON G.ATUPCODE = H.PRTACT AND H.PRTCODE = '03'																																	 \n");
						sql.append( " ORDER BY PRTACT 														\n");
		
						//System.out.println("# Query : " + sql);
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