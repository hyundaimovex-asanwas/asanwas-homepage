package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em020_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";}
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";}
				String  str4	= req.getParameter("v_str4"); if (str4==null) {str4="";}
				String  str5	= req.getParameter("v_str5"); if (str5==null) {str5="";}


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
                                          "EMPNO","PAY_DIV","PB_DIV","PAY_CD","CUST_SID",
                                          "EX_PAY","EX_FRDT","EX_TODT","I_EMPNO","U_EMPNO",
                                          "TEAM_CD","EMPNMK","DEPT_CD","I_DATE","U_DATE",
                                          "DEPT_NM","TEAM_NM","JOB_CD","ORG_PB_DIV", "ORG_PAY_CD", "REMARK"
																			}; 

				int[] intArrCN = new int[] { 
                                          10, 1, 1, 3, 10,
                                          10, 8, 8, 10,10,
                                          5, 30, 5, 10, 10,
                                          40,40, 5,  1, 3,  50
																			}; 
			
				int[] intArrCN2 = new int[]{
                                          -1,-1,-1,-1,0,
                                           2,-1,-1,-1,-1,
                                          -1,-1,-1,-1,-1,
                                          -1,-1,-1,-1,-1, -1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "	SELECT                                              \n");
						sql.append( "	A.EMPNO AS EMPNO ,                                  \n");
						sql.append( "	A.PAY_DIV AS PAY_DIV,                               \n");
						sql.append( "	A.PB_DIV AS PB_DIV,                                 \n");
						sql.append( "	A.PAY_CD AS PAY_CD,                                 \n");
						sql.append( "	IFNULL(A.CUST_SID,0) AS CUST_SID,                   \n");
						sql.append( "	IFNULL(A.EX_PAY,0) AS EX_PAY,                       \n");
						sql.append( "	A.EX_FRDT AS EX_FRDT,                               \n");
						sql.append( "	A.EX_TODT AS EX_TODT,                               \n");
						sql.append( "	A.I_EMPNO AS I_EMPNO,                               \n");
						sql.append( "	A.U_EMPNO AS U_EMPNO,                               \n");
						sql.append( "	A.I_DATE AS I_DATE,                                 \n");
						sql.append( "	A.U_DATE AS U_DATE,                                 \n");
						sql.append( "	B.EMPNMK AS EMPNMK,                                 \n");
						sql.append( "	B.TEAM_CD AS TEAM_CD,                               \n");
						sql.append( "	B.DEPT_CD AS DEPT_CD,                               \n");
						sql.append( "	C.DETAIL_NM AS DEPT_NM,                             \n");
						sql.append( "	D.DETAIL_NM AS TEAM_NM,                             \n");
						sql.append( "	B.JOB_CD AS JOB_CD,                                 \n");
            sql.append( "	A.PB_DIV AS ORG_PB_DIV,                             \n");
						sql.append( "	A.PAY_CD AS ORG_PAY_CD,                              \n");
						sql.append( "	A.REMARK                                            \n");
						sql.append( "	FROM SALES.TCM420 A                                 \n");
						sql.append( "	LEFT OUTER JOIN SALES.TCM300 B ON A.EMPNO = B.EMPNO \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 C ON TRIM(C.DETAIL) = TRIM(B.DEPT_CD) AND C.HEAD='CM006' AND TRIM(C.DETAIL)<>'' \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 D ON TRIM(D.DETAIL) = TRIM(B.TEAM_CD) AND D.HEAD='CM003' AND TRIM(D.DETAIL)<>'' \n");
						sql.append( "	WHERE 1=1                                           \n");
						if(!str1.equals(""))sql.append( "	AND B.TEAM_CD = '"+str1+"'                          \n");
						if(!str2.equals(""))sql.append( "	AND A.EX_FRDT <= '"+str2+"'                         \n");
						if(!str3.equals(""))sql.append( "	AND A.EX_TODT >= '"+str3+"'                         \n");
						if(!str4.equals(""))sql.append( "	AND B.EMPNO = '"+str4+"'                            \n");
						if(!str5.equals(""))sql.append( "	AND B.DEPT_CD = '"+str5+"'                          \n");

						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet); 
					}
				
/*********************************************************************************************/

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