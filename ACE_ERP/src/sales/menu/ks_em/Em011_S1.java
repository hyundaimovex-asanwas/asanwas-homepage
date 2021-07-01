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
public class Em011_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //소속
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //사번
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //성명
				String  str4	= req.getParameter("v_str4"); if (str4 == null) { str4 = ""; } //부서
				String  str5	= req.getParameter("v_str5"); if (str5 == null) { str5 = ""; } //퇴사자구분
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO","EMPNMK","VEND_CD","VEND_NM","DEPT_CD","DEPT_NM",
					                                 "TEAM_CD","TEAM_NM","WORK_CD","WORK_NM","SKILL_CD","SKILL_NM",
                                           "JOB_CD","JOB_NM", "CHK", "CUST_SID","I_EMPNO","U_EMPNO","I_DATE","U_DATE",
					                                 "C_VEND_CD", "C_VEND_NM"
																			}; //

				int[] intArrCN = new int[] { 10, 30, 10, 50, 5, 50,
																		  5, 50,  5, 50, 3, 50,
					                            5, 50,  1, 10, 10, 10, 10, 10,
					                           10, 62
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,0,-1,-1,-1,
                                     -1,-1,-1,-1,-1,-1,
					                           -1,-1,-1, 0,-1,-1,-1,-1,
					                            0,-1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT A.EMPNO, A.EMPNMK,                       \n");
						sql.append( "				 A.VEND_CD, B.DETAIL_NM AS VEND_NM,       \n");
						sql.append( "				 A.DEPT_CD, C.DETAIL_NM AS DEPT_NM,       \n");
						sql.append( "				 A.TEAM_CD, D.DETAIL_NM AS TEAM_NM,       \n");
						sql.append( "				 IFNULL(A.WORK_CD,'')WORK_CD, IFNULL(E.DETAIL_NM,'') AS WORK_NM,       \n");
						sql.append( "				 A.SKILL_CD, F.DETAIL_NM AS SKILL_NM,     \n");
						sql.append( "				 A.JOB_CD,  G.DETAIL_NM AS JOB_NM,        \n");
            sql.append( "				 ''CHK, COALESCE(A.CUST_SID,0)CUST_SID,  A.I_EMPNO, A.I_DATE, A.U_EMPNO, A.U_DATE, \n");
            sql.append( "				 A.C_VEND_CD, H.CLIENT_NM AS C_VEND_NM       \n");
						sql.append( "	FROM SALES.TCM300 A                             \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='CM006' AND RTRIM(C.DETAIL)<>''  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.TEAM_CD) AND D.HEAD='CM003' AND RTRIM(D.DETAIL)<>''  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD) AND E.HEAD='CM007' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.SKILL_CD) AND F.HEAD='CM013' AND RTRIM(F.DETAIL)<>'' \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.JOB_CD) AND G.HEAD='CM004'   AND RTRIM(G.DETAIL)<>'' \n");
            
						sql.append( "	LEFT OUTER JOIN SALES.TCU030 H ON H.CLIENT_SID =A.C_VEND_CD \n");
						
						sql.append( "	WHERE 1=1   \n");
						if(!str5.equals(""))sql.append( "	  AND A.USESTS = '"+str5+"'     \n");
						if(!str1.equals(""))sql.append( "	  AND A.TEAM_CD = '"+str1+"'    \n");
						if(!str2.equals(""))sql.append( "	  AND A.EMPNO = '"+str2+"'      \n");
						if(!str3.equals(""))sql.append( "	  AND A.EMPNMK LIKE '"+str3+"%' \n");
						if(!str4.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str4+"'    \n");
						
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