package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class now_time extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Get 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		StringBuffer query = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				gconn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String  gstr1	= req.getParameter("v_str1");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "CAL_DT","YES_DATE","HH","MM","SS"
																				}; 
				int[] intArrCN	= new int[]{  8, 8, 2, 2, 2
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1,  0,  0,  0
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING,intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				// 실제 쿼리문 작성
		   	if (!GauceReq.isBuilderRequest()) {
					query = new StringBuffer();
//					query.append(" SELECT X.CAL_DT, SUBSTR(X.Y_DATE,1,4)||SUBSTR(X.Y_DATE,6,2)||SUBSTR(X.Y_DATE,9,2) YES_DATE, X.HH, X.MM, X.SS \n")
					query.append(" SELECT X.CAL_DT, X.YES_DATE, X.HH, X.MM, X.SS \n")
							 .append("	 FROM ( SELECT MIN(A.CAL_DT) CAL_DT, \n")
//							 .append("								 MIN(CHAR(DATE(SUBSTR(A.APP_DT1,1,4)||'-'||SUBSTR(A.APP_DT1,5,2)||'-'||SUBSTR(A.APP_DT1,7,2))- 1 DAYS)) Y_DATE, \n")
							 .append("								 MIN(A.APP_DT3) YES_DATE, \n")
							 .append("								 SUBSTR(CHAR(TIME(CURRENT TIMESTAMP)),1,2) AS HH, \n")
							 .append("								 SUBSTR(CHAR(TIME(CURRENT TIMESTAMP)),4,2) MM, \n")
							 .append("								 SUBSTR(CHAR(TIME(CURRENT TIMESTAMP)),7,2) SS \n")
							 .append("						FROM TRANSFER.LTCALENDAR A, \n")
							 .append("								 (SELECT LINE_PART, ETD_DT FROM TRANSFER.LTORDERMST WHERE ORDER_NO = '" + gstr1 + "') B \n")
							 .append("					 WHERE A.LINE_PART = B.LINE_PART \n")
							 .append("						 AND A.APP_DT1 = B.ETD_DT \n")
							 .append("				) X ");

/*********************************************************************************************/

					gstmt = gconn.getGauceStatement(query.toString());
	 		    gstmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
				if (gconn != null) try {gconn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit(query.toString());
		  GauceRes.close();

		} catch (Exception e) {

			// GAUCE30/LOG/ERROR.LOG 화일로 메세지 확인
			logger.err.println(this,e);

			// GAUCE30/LOG/DEBUG.LOG 화일로 메세지 확인
			logger.dbg.println(this,e.toString());

		} finally {

			loader.restoreService(service);
  	}
	}
}



