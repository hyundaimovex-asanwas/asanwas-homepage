
/* H030003_popup.html 인사쪽에서 이 서블릿을 부름 */
package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p040001_pop_s1 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1");
			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"EMPNO",  "EMPNMK",  "DEPTCD", "DEPTNM",  
					"PAYSEQ",  "PAYSEQNM",  "STRTDT", "ENDDT", "GRSTRTDT" , "PAYGNM", "RESINO", "DUYEAR" 
					}; 

				int[] intArrCN = new int[]{ 7, 20, 4, 50,
					                       4,30,8,8,8,30,13,2
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					-1, -1, -1, -1,-1,-1,-1,0 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				/*		gcem_emo.Text = arrParam[0];     // 사번
				hid_deptcd.value = arrParam[1];  //부서코드
				txt_deptnm.value = arrParam[2];  //부서명
				hid_hocode.value = arrParam[3];  //급호코드
				txt_ho.value = arrParam[4];      //급호명
				txt_name.value = arrParam[5];    //성명
				gcem_ipsail.Text = arrParam[6];  //입사일
				gcem_taesail.Text = arrParam[7]; //퇴사일
				txt_yyyy.value = arrParam[8];    //근속년수
          */
			logger.dbg.println(this,"111");

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					sql.append( " SELECT DISTINCT ");
					sql.append( " RTRIM(A.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, A.DEPTCD, RTRIM(C.DEPTNM) DEPTNM, A.PAYSEQ, ");
					sql.append( " RTRIM(D.MINORNM) PAYSEQNM, A.STRTDT, A.ENDDT, A.GRSTRTDT,E.MINORNM AS PAYGNM, A.RESINO,A.DUYEAR ");
					sql.append( " FROM ");
					sql.append( " PAYROLL.HIPERSON A ");
					sql.append( "         LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD "); //부서
					sql.append( "         LEFT JOIN PAYROLL.HCLCODE D ON A.PAYSEQ =D.MINORCD  AND  D.MAJORCD = '1184' "); //호봉
					sql.append( "         LEFT JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   "); //직위


// 					sql.append( " WHERE A.EMPNMK like '"+str1+"%'");
					if (!str1.equals(""))		
					{
						sql.append( " WHERE A.EMPNMK like '%"+str1+"%' ");
					}
					sql.append( " ORDER BY EMPNO ");

					
					logger.dbg.println(this,sql.toString());
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