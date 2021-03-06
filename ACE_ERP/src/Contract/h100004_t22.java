package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h100004_t22 extends HttpServlet {

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

				if(DB_gubun.equals("1")) {
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
					String [] str = new String [4];

					str[0]	= req.getParameter("v_str2");		//지급구분
					str[1]	= req.getParameter("v_str1");		//급여년월
					str[2]	= req.getParameter("v_str3");		//지급일자
					str[3]	= req.getParameter("v_str4");		//연말정산적용여부
					//str[3]	= "K";													//리턴값

					for (int s=0;s<4;s++) {
						if (str[s]==null) str[s] = "";
					}

         

					String[] strArrCN = new String[]{ "PAYDIV", "APPDT",  "PAYDT", "YCPAYCOL"};

					int[] intArrCN = new int[] {  1,  6,  8, 1}; 

					int[] intArrCN2 = new int[]{ -1, -1, -1, -1}; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						}  
					}

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
					
		//			logger.dbg.println(this, str[3]); 						

						query.append("  call PAYROLL.PR_P020002S( ?, ?, ?, ?, ?, ?, ? )  ");

						

						cstmt = conn.prepareCall(query.toString());

						cstmt.setString(1, str[0] );
 						cstmt.setString(2, str[1] );
						cstmt.setString(3, str[2] );
						if ( str[3].equals("Y") )			
							cstmt.setString(4,  "Y");		
						else
							cstmt.setString(4,  "N");			
						cstmt.registerOutParameter (5, Types.CHAR);
						cstmt.registerOutParameter (6, Types.CHAR);
						cstmt.registerOutParameter (7, Types.CHAR);


	//logger.dbg.println(this,query.toString());

						cstmt.execute();					
						

						GauceDataRow row = dSet.newDataRow();
						row.addColumnValue(cstmt.getString(1));
						row.addColumnValue(cstmt.getString(2));
						row.addColumnValue(cstmt.getString(3));
					

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