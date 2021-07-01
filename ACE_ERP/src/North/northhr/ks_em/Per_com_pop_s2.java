/************************************************************************************************
 * 개인정보관리 : 협력업체 조회
 ************************************************************************************************/
package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.

public class Per_com_pop_s2 extends HttpServlet {

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
        String  str1	= GauceReq.getParameter("v_str1"); 
				String  str2	= GauceReq.getParameter("v_str2"); 
				String  str3	= GauceReq.getParameter("v_str3"); 
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";
				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{  "EMPNO"  ,"EMPNMK" ,"DEPT_NM" ,"TEAM_NM" ,"CUST_SID",
                                           "JOB_CD", "DEPT_CD", "TEAM_CD", "VEND_CD", "WORK_CD", "SKILL_CD" }; 

				int[] intArrCN = new int[] { 10, 30, 50, 50, 10,
                                     5,   5,  5, 10,  5,  3 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 0,
                                     -1, -1, -1, 0, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT                            \n");
				sql.append( " IFNULL(A.EMPNO,'')EMPNO,          \n");
				sql.append( " RTRIM(IFNULL(A.EMPNMK,''))EMPNMK, \n");
				sql.append( " C.DETAIL_NM AS DEPT_NM,           \n");
				sql.append( " D.DETAIL_NM AS TEAM_NM,           \n");
				sql.append( " A.CUST_SID,                       \n");
				sql.append( " A.JOB_CD,                         \n");
				sql.append( " A.DEPT_CD,                        \n");
				sql.append( " A.TEAM_CD,                        \n");
				sql.append( " A.VEND_CD,                        \n");
				sql.append( " A.WORK_CD, A.SKILL_CD             \n");
				sql.append( " FROM SALES.TCM300 A                                                                                           \n");
				sql.append( " LEFT OUTER JOIN SALES.TSY010 C ON TRIM(C.DETAIL) = TRIM(A.DEPT_CD) AND C.HEAD='CM006' AND TRIM(C.DETAIL)<>''  \n");
				sql.append( " LEFT OUTER JOIN SALES.TSY010 D ON TRIM(D.DETAIL) = TRIM(A.TEAM_CD) AND D.HEAD='CM003' AND TRIM(D.DETAIL)<>''  \n");
				sql.append( " WHERE 1=1        \n");
if (!str1.equals("")) sql.append( " AND A.EMPNO = '"+str1+"'          \n");
if (!str2.equals("")) sql.append( " AND A.EMPNMK LIKE '"+str2+"%'     \n");
if (str3.equals("3")) sql.append( " AND A.USESTS ='"+str3+"'     \n");
if (!str3.equals("3")) sql.append( " AND A.USESTS  IN ('1' ,'2')    \n");
                      sql.append( " ORDER BY A.EMPNO                  \n");
                      
        logger.dbg.println(this,sql.toString());

				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

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