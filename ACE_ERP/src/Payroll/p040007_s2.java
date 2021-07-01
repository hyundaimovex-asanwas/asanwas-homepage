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
public class p040007_s2 extends HttpServlet {

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

				//현대아산
				String dbUrl    = "jdbc:as400://203.242.32.198";
				String driver   = "com.ibm.as400.access.AS400JDBCDriver";
				String userName = "QPILOT";
				String userPass = "PILOT";

        //테스트
				/*String dbUrl    = "jdbc:as400://218.145.103.181";
				String driver   = "com.ibm.as400.access.AS400JDBCDriver";
				String userName = "PAYROLL";
				String userPass = "PAY";*/

				Class.forName(driver);			
				conn = DriverManager.getConnection(dbUrl, userName, userPass);

				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//기준년월
				str[1]	= req.getParameter("v_str2");		//부서
				str[2]	= req.getParameter("v_str3");		//직급
				str[3]	= req.getParameter("v_str4");		//성명
				str[4]  = req.getParameter("v_str5");		//현재일자
				str[5]	= req.getParameter("v_str6");		//고정값 '6'
				str[6]	= req.getParameter("v_str7");		//고정값 'N'
				str[7]  = req.getParameter("v_str8");		//프로시져명

				for (int s=0;s<=7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "YEARMM", "PAYREF", "PAYDAY", "RETCOD" };

				int[] intArrCN = new int[] { 6,  1,  8,  1 }; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer query = new StringBuffer();
	 		      query.append(" CALL PAYROLL."+ str[7] +"(?,?,?,?) ");

						cstmt = conn.prepareCall(query.toString());
						cstmt.setString(1, str[0] );	//기준년월
 						cstmt.setString(2, str[5] );	//고정값 '6'
   					cstmt.setString(3, str[4] );	//현재일자
   					cstmt.setString(4, str[6] );	//고정값 'N'
   					
						cstmt.registerOutParameter (1, Types.CHAR);
						cstmt.registerOutParameter (2, Types.CHAR);
						cstmt.registerOutParameter (3, Types.CHAR);
						cstmt.registerOutParameter (4, Types.CHAR);

						cstmt.execute();					
						
						GauceDataRow row = dSet.newDataRow();
						row.addColumnValue(cstmt.getString(1));
						row.addColumnValue(cstmt.getString(2));
						row.addColumnValue(cstmt.getString(3));
						row.addColumnValue(cstmt.getString(4));
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