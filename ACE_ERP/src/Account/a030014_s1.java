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
public class a030014_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//회계년도
				str[2] = req.getParameter("v_str3");	//계정코드1
				str[3] = req.getParameter("v_str4");	//계정코드2

				for(int i=0;i<=3;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE" , "ATKORNAM",
												"A01", "A02", "A03", "A04", "A05", "A06",
												"A07", "A08", "A09", "A10", "A11", "A12",
												"TSUM"
				}; 

				int[] intArrCN = new int[] {	7,	66,
												15,  15,  15,  15,  15,  15,
												15,  15,  15,  15,  15,  15,
												15
				}; 
			
				int[] intArrCN2 = new int[]{	-1,  -1,
												0,  0,  0,  0,  0,  0,
												0,  0,  0,  0,  0,  0,
												0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


					if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "	SELECT X.ATCODE,X.ATKORNAM, " );
					sql.append( "		COALESCE(SUM(X.A01),0)A01, COALESCE(SUM(X.A02),0)A02, COALESCE(SUM(X.A03),0)A03, COALESCE(SUM(X.A04),0)A04, \n" );
					sql.append( "		COALESCE(SUM(X.A05),0)A05, COALESCE(SUM(X.A06),0)A06, COALESCE(SUM(X.A07),0)A07, COALESCE(SUM(X.A08),0)A08, \n" );
					sql.append( "		COALESCE(SUM(X.A09),0)A09, COALESCE(SUM(X.A10),0)A10, COALESCE(SUM(X.A11),0)A11, COALESCE(SUM(X.A12),0)A12, \n" );
					sql.append( "		COALESCE(SUM(X.A01),0)+COALESCE(SUM(X.A02),0)+COALESCE(SUM(X.A03),0)+COALESCE(SUM(X.A04),0)+ \n" );
					sql.append( "		COALESCE(SUM(X.A05),0)+COALESCE(SUM(X.A06),0)+COALESCE(SUM(X.A07),0)+COALESCE(SUM(X.A08),0)+ \n" );
					sql.append( "		COALESCE(SUM(X.A09),0)+COALESCE(SUM(X.A10),0)+COALESCE(SUM(X.A11),0)+COALESCE(SUM(X.A12),0)AS TSUM \n" );
					sql.append( " FROM( \n" );
					sql.append( "		SELECT A.ATCODE, B.ATKORNAM, B.ATDECR, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='01' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A01, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='02' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A02, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='03' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A03, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='04' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A04, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='05' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A05, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='06' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A06, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='07' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A07, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='08' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A08, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='09' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A09, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='10' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A10, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='11' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A11, \n" );
					sql.append( "        CASE WHEN SUBSTR(A.ACTYYMM,5,2)='12' THEN CASE WHEN B.ATDECR='1' THEN SUM(A.DETOT)-SUM(A.CRTOT) ELSE SUM(A.CRTOT)-SUM(A.DETOT) END END A12  \n" );
					sql.append( "   FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B \n" );
					sql.append( "  WHERE A.ATCODE LIKE '44%' \n" );
					sql.append( "    AND A.ATCODE = B.ATCODE \n" );
					sql.append( "    AND B.ATUSEYN='Y' " );
					if(!str[0].equals(""))  sql.append( " AND A.FDCODE='"+str[0]+"' \n");
					if(!str[1].equals(""))	sql.append( " AND SUBSTR(A.ACTYYMM,1,4)='"+str[1]+"' \n");
					if(!str[2].equals(""))	sql.append( " AND A.ATCODE BETWEEN '"+str[2]+"' AND '"+str[3]+"' \n");
					sql.append( "  GROUP BY A.ATCODE,B.ATKORNAM,A.ACTYYMM,B.ATDECR \n" );
					sql.append( " ) X \n" );
					sql.append( " GROUP BY X.ATCODE,X.ATKORNAM \n" );
					sql.append( " ORDER BY X.ATCODE,X.ATKORNAM \n" );

					//logger.dbg.println(this, sql.toString());
					//System.out.println("a080007_s1::"+sql.toString());

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