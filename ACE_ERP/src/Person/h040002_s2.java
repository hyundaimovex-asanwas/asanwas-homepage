package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h040002_s2 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				
				String DB_gubun="1"; //1->현대아산, 0->테스트
				String dbUrl    = "";
				String driver   = "";
				String userName = "";
				String userPass = "";

				if(DB_gubun.equals("1"))
				{
				//현대아산
					 dbUrl    = "jdbc:as400://203.242.32.198";
					 driver   = "com.ibm.as400.access.AS400JDBCDriver";
					 userName = "QPILOT";
					 userPass = "PILOT";
                }else{
                //테스트
					 dbUrl    = "jdbc:as400://218.145.103.181";
					 driver   = "com.ibm.as400.access.AS400JDBCDriver";
					 userName = "PAYROLL";
					 userPass = "PAY";
				}

				Class.forName(driver);			
				conn = DriverManager.getConnection(dbUrl, userName, userPass);

				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				GauceRes.enableFirstRow(dSet);
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//부서구분
				str[1]	= req.getParameter("v_str2");		//발령구분
				str[2]	= req.getParameter("v_str3");		//From
				str[3]	= req.getParameter("v_str4");		//To
				str[4]	= req.getParameter("v_str5");		//사번
				str[5]	= "T";													//

				for (int s=0;s<6;s++) {
					if (str[s].equals("")) str[s] = "%";
				}

				String[] strArrCN = new String[]{ "TEMP1","TEMP2","TEMP3","TEMP4","TEMP5", "FLAG"
																				};

				int[] intArrCN = new int[]{ 4,  4,  8,  8,  7, 1  }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
	 		      query.append("  CALL PAYROLL.SP_H040002(?,?,?,?,?,?) ");

						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
   					cstmt.setString(3, str[2] );
   					cstmt.setString(4, str[3] );
   					cstmt.setString(5, str[4] );
   					cstmt.setString(6, str[5] );
   					
						cstmt.registerOutParameter (1, Types.CHAR);
						cstmt.registerOutParameter (2, Types.CHAR);
						cstmt.registerOutParameter (3, Types.CHAR);
						cstmt.registerOutParameter (4, Types.CHAR);
						cstmt.registerOutParameter (5, Types.CHAR);
						cstmt.registerOutParameter (6, Types.CHAR);

						cstmt.execute();

						GauceDataRow row = dSet.newDataRow();
						for (int i=1;i<7;i++) {
							row.addColumnValue(cstmt.getString(i));
						//	logger.dbg.println(this,"str" + i + " : " + cstmt.getString(i));
						}
						dSet.addDataRow(row);

						cstmt.close();
						conn.close();

		/*********************************************************************************************/

				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (cstmt != null) try { cstmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
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