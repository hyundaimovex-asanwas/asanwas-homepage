/* 결재자 조회 */
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
public class p040001_s2 extends HttpServlet {

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

				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1"); ///사번           
				str[1]	= req.getParameter("v_str2"); ///지급적용년월-3 
				str[2]	= req.getParameter("v_str3"); ///지급적용년월-2 
				str[3]	= req.getParameter("v_str4"); ///지급적용년월-1 






				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}

			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"EMPNO",  "PAYCDNM",  "AMT1", "AMT2",  
					"AMT3",  "SUMAMT" 
					}; 

				int[] intArrCN = new int[]{ 7, 40, 9, 9,
					                        9,  9
					                      }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, 0,
					0, 0 }; 
			
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
				
sql.append("  SELECT A.EMPNO, A.PAYCDNM,                                                                                  \n "); 
sql.append("          COALESCE(A.AMT,0) AS AMT1,                                                                          \n ");
sql.append("          COALESCE(B.AMT,0) AS AMT2,                                                                          \n ");
sql.append("          COALESCE(C.AMT,0) AS AMT3,                                                                          \n ");
sql.append("          (COALESCE(A.AMT,0) + COALESCE(B.AMT,0) + COALESCE(C.AMT,0)) AS SUMAMT                               \n ");
sql.append("          FROM                                                                                                \n ");
sql.append("                                                                                                              \n ");
sql.append("    (SELECT DISTINCT                                                                                          \n ");
sql.append("             B.EMPNO,                                                                                         \n ");
sql.append("             COALESCE((CASE                                                                                   \n ");
sql.append("             WHEN X.PAYCD='P10000'                                                                            \n ");
sql.append("             THEN B.P10000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P11000'                                                                            \n ");
sql.append("             THEN B.P11000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P12000'                                                                            \n ");
sql.append("             THEN B.P12000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P21000'                                                                            \n ");
sql.append("             THEN B.P21000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P23000'                                                                            \n ");
sql.append("             THEN B.P23000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P24000'                                                                            \n ");
sql.append("             THEN B.P24000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P28000'                                                                            \n ");
sql.append("             THEN B.P28000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P29000'                                                                            \n ");
sql.append("             THEN B.P29000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P31000'                                                                            \n ");
sql.append("             THEN B.P31000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P32000'                                                                            \n ");
sql.append("             THEN B.P32000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P36000'                                                                            \n ");
sql.append("             THEN B.P36000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P37000'                                                                            \n ");
sql.append("             THEN B.P37000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P22000'                                                                            \n ");
sql.append("             THEN B.P22000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P25000'                                                                            \n ");
sql.append("             THEN B.P25000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P26000'                                                                            \n ");
sql.append("             THEN B.P26000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P27000'                                                                            \n ");
sql.append("             THEN B.P27000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P30000'                                                                            \n ");
sql.append("             THEN B.P30000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P38000'                                                                            \n ");
sql.append("             THEN B.P38000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0010'                                                                            \n ");
sql.append("             THEN B.PX0010                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0020'                                                                            \n ");
sql.append("             THEN B.PX0020                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0030'                                                                            \n ");
sql.append("             THEN B.PX0030                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0040'                                                                            \n ");
sql.append("             THEN B.PX0040                                                                                    \n ");
sql.append("             END),0) AS AMT,                                                                                  \n ");
sql.append("             X.PBDIV,                                                                                         \n ");
sql.append("             X.PAYCD,                                                                                         \n ");
sql.append("             X.PAYDIV,                                                                                        \n ");
sql.append("             X.PAYCDNM                                                                                        \n ");
sql.append("             FROM  (SELECT                                                                                    \n ");
sql.append("             PAYDIV,PBDIV,PAYCD,PAYCDNM from payroll.pcpaycd                                                  \n ");
sql.append("                                                           where PAYDIV='1' AND pbdiv='1'                     \n ");
sql.append("                                                           and AUTOYN='Y' ORDER BY PAYCD ASC  )  X            \n ");
sql.append("                                                            LEFT JOIN PAYROLL.PBPAY B ON                      \n ");
sql.append("                                                            B.EMPNO <> ' '                                    \n ");
if (!str[0].equals("")&&!str[0].equals("0")) sql.append("             AND B.EMPNO='" + str[0] +"'                                      \n ");
if (!str[1].equals("")&&!str[1].equals("0")) sql.append("             AND B.APPDT='" + str[1] +"'                                      \n ");
sql.append("                                                                                                              \n ");
sql.append("                                                           ORDER BY X.PAYCD ASC ) A                           \n ");
sql.append("    LEFT OUTER JOIN                                                                                           \n ");
sql.append("    (SELECT DISTINCT                                                                                          \n ");
sql.append("             B.EMPNO,                                                                                         \n ");
sql.append("             COALESCE((CASE                                                                                   \n ");
sql.append("             WHEN X.PAYCD='P10000'                                                                            \n ");
sql.append("             THEN B.P10000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P11000'                                                                            \n ");
sql.append("             THEN B.P11000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P12000'                                                                            \n ");
sql.append("             THEN B.P12000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P21000'                                                                            \n ");
sql.append("             THEN B.P21000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P23000'                                                                            \n ");
sql.append("             THEN B.P23000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P24000'                                                                            \n ");
sql.append("             THEN B.P24000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P28000'                                                                            \n ");
sql.append("             THEN B.P28000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P29000'                                                                            \n ");
sql.append("             THEN B.P29000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P31000'                                                                            \n ");
sql.append("             THEN B.P31000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P32000'                                                                            \n ");
sql.append("             THEN B.P32000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P36000'                                                                            \n ");
sql.append("             THEN B.P36000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P37000'                                                                            \n ");
sql.append("             THEN B.P37000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P22000'                                                                            \n ");
sql.append("             THEN B.P22000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P25000'                                                                            \n ");
sql.append("             THEN B.P25000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P26000'                                                                            \n ");
sql.append("             THEN B.P26000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P27000'                                                                            \n ");
sql.append("             THEN B.P27000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P30000'                                                                            \n ");
sql.append("             THEN B.P30000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P38000'                                                                            \n ");
sql.append("             THEN B.P38000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0010'                                                                            \n ");
sql.append("             THEN B.PX0010                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0020'                                                                            \n ");
sql.append("             THEN B.PX0020                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0030'                                                                            \n ");
sql.append("             THEN B.PX0030                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0040'                                                                            \n ");
sql.append("             THEN B.PX0040                                                                                    \n ");
sql.append("             END),0) AS AMT,                                                                                  \n ");
sql.append("             X.PBDIV,                                                                                         \n ");
sql.append("             X.PAYCD,                                                                                         \n ");
sql.append("             X.PAYDIV,                                                                                        \n ");
sql.append("             X.PAYCDNM                                                                                        \n ");
sql.append("             FROM  (SELECT                                                                                    \n ");
sql.append("             PAYDIV,PBDIV,PAYCD,PAYCDNM from payroll.pcpaycd                                                  \n ");
sql.append("                                                           where PAYDIV='1' AND pbdiv='1'                     \n ");
sql.append("                                                           and AUTOYN='Y'   ORDER BY PAYCD ASC  )  X          \n ");
sql.append("                                                            LEFT JOIN PAYROLL.PBPAY B ON                      \n ");
sql.append("                                                            B.EMPNO <> ' '                                    \n ");
if (!str[0].equals("")&&!str[0].equals("0")) sql.append("             AND B.EMPNO='" + str[0] +"'                                      \n ");
if (!str[2].equals("")&&!str[2].equals("0")) sql.append("             AND B.APPDT='" + str[2] +"'                                      \n ");
sql.append("                                                                                                              \n ");
sql.append("                                                           ORDER BY X.PAYCD ASC )    B ON  A.EMPNO=B.EMPNO  AND A.PAYCD=B.PAYCD   \n ");
sql.append("    LEFT OUTER JOIN                                                                                           \n ");
sql.append("    (SELECT DISTINCT                                                                                          \n ");
sql.append("             B.EMPNO,                                                                                         \n ");
sql.append("             COALESCE((CASE                                                                                   \n ");
sql.append("             WHEN X.PAYCD='P10000'                                                                            \n ");
sql.append("             THEN B.P10000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P11000'                                                                            \n ");
sql.append("             THEN B.P11000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P12000'                                                                            \n ");
sql.append("             THEN B.P12000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P21000'                                                                            \n ");
sql.append("             THEN B.P21000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P23000'                                                                            \n ");
sql.append("             THEN B.P23000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P24000'                                                                            \n ");
sql.append("             THEN B.P24000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P28000'                                                                            \n ");
sql.append("             THEN B.P28000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P29000'                                                                            \n ");
sql.append("             THEN B.P29000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P31000'                                                                            \n ");
sql.append("             THEN B.P31000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P32000'                                                                            \n ");
sql.append("             THEN B.P32000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P36000'                                                                            \n ");
sql.append("             THEN B.P36000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P37000'                                                                            \n ");
sql.append("             THEN B.P37000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P22000'                                                                            \n ");
sql.append("             THEN B.P22000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P25000'                                                                            \n ");
sql.append("             THEN B.P25000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P26000'                                                                            \n ");
sql.append("             THEN B.P26000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P27000'                                                                            \n ");
sql.append("             THEN B.P27000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P30000'                                                                            \n ");
sql.append("             THEN B.P30000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='P38000'                                                                            \n ");
sql.append("             THEN B.P38000                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0010'                                                                            \n ");
sql.append("             THEN B.PX0010                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0020'                                                                            \n ");
sql.append("             THEN B.PX0020                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0030'                                                                            \n ");
sql.append("             THEN B.PX0030                                                                                    \n ");
sql.append("             WHEN X.PAYCD='PX0040'                                                                            \n ");
sql.append("             THEN B.PX0040                                                                                    \n ");
sql.append("             END),0) AS AMT,                                                                                  \n ");
sql.append("             X.PBDIV,                                                                                         \n ");
sql.append("             X.PAYCD,                                                                                         \n ");
sql.append("             X.PAYDIV,                                                                                        \n ");
sql.append("             X.PAYCDNM                                                                                        \n ");
sql.append("             FROM  (SELECT                                                                                    \n ");
sql.append("             PAYDIV,PBDIV,PAYCD,PAYCDNM from payroll.pcpaycd                                                  \n ");
sql.append("                                                           where PAYDIV='1' AND pbdiv='1'                     \n ");
sql.append("                                                           and AUTOYN='Y'  ORDER BY PAYCD ASC  )  X           \n ");
sql.append("                                                            LEFT JOIN PAYROLL.PBPAY B ON                      \n ");
sql.append("                                                            B.EMPNO <> ' '                                    \n ");
if (!str[0].equals("")&&!str[0].equals("0")) sql.append("             AND B.EMPNO='" + str[0] +"'                        \n ");
if (!str[3].equals("")&&!str[3].equals("0")) sql.append("             AND B.APPDT='" + str[3] +"'                        \n ");
sql.append("                                                                                                              \n ");
sql.append("                                                           ORDER BY X.PAYCD ASC  )                            \n ");
sql.append("                                                            C ON  A.EMPNO=C.EMPNO  AND A.PAYCD=C.PAYCD        \n ");


				//	logger.dbg.println(this,sql.toString());
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