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
public class hscode_s02 extends HttpServlet {

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
		Statement stmt = null;
		ResultSet rs = null;

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
				String  gstr1	= req.getParameter("vstr1");
				String  gstr2	= req.getParameter("vstr2");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "MAJOR_CD", "MINOR_CD", "MINOR_NM", "MINOR_LEN", "ETC_CD1",
																					"ETC_CD2", "ETC_CD3", "ETC_NO1", "ETC_NO2", "ETC_NO3",
																					"STS_CD", "WRITE_PS", "WRITE_DT", "UPDATE_PS", "UPDATE_DT",
																					"MLEN"
																				}; 

				int[] intArrCN	= new int[]{  4, 10, 1024,  2, 20,
																		 20, 20,   18, 18, 18,
																			1, 10,   10, 10, 10,
																			2
																	 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1,  0, -1,
																		 -1, -1,  5,  5,  5,
																		 -1, -1, -1, -1, -1,
																			0
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
					query.append(" SELECT MAJOR_CD, MINOR_CD, RTRIM(MINOR_NM) MINOR_NM, MINOR_LEN, ETC_CD1, \n")
							 .append("				ETC_CD2, ETC_CD3, ETC_NO1, ETC_NO2, ETC_NO3, \n")
							 .append("				STS_CD, WRITE_PS, WRITE_DT, UPDATE_PS, UPDATE_DT, \n")
							 .append("				LENGTH(RTRIM(MINOR_CD)) MLEN \n")
							 .append("	 FROM TRANSFER.LTHSCODE \n")
							 .append("	WHERE STS_CD = '1' \n");

					if (gstr1.equals("1")) query.append("	  AND MAJOR_CD = '9999' ");
					else if (gstr1.equals("2")) query.append("	  AND MAJOR_CD = '" + gstr2 + "' \n ");

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
		  GauceRes.commit();
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



