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
public class com_cartype extends HttpServlet {

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
				String  gstr1	= req.getParameter("vstr1");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "CAR_TYPE", "CAR_NAME", "CAR_LENGTH", "CAR_WIDTH", "CAR_HEIGHT"
																				, "CAR_CBM", "CAR_TON", "CAR_CLASS", "CREATE_DT", "CREATE_USR"
																				, "UPDATE_DT", "UPDATE_USR"
																				}; 
				int[] intArrCN	= new int[]{  4, 30,  7,  7,  7,
																		  7,  7,  4,  8, 10,
																			8, 10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1,  2,  2,  2,
																		  2,  2, -1, -1, -1,
																		 -1, -1
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
					query.append(" SELECT CAR_TYPE, CAR_NAME, CAR_LENGTH, CAR_WIDTH, CAR_HEIGHT \n ");
					query.append(" 			, CAR_CBM, CAR_TON, CAR_CLASS, SUBSTR(CHAR(CREATE_DT),1,4)||SUBSTR(CHAR(CREATE_DT),6,2)||SUBSTR(CHAR(CREATE_DT),9,2) CREATE_DT, CREATE_USR \n ");
					query.append(" 			, SUBSTR(CHAR(UPDATE_DT),1,4)||SUBSTR(CHAR(UPDATE_DT),6,2)||SUBSTR(CHAR(UPDATE_DT),9,2) UPDATE_DT, UPDATE_USR \n ");
					query.append("	 FROM TRANSFER.LTCARTYPE ");
					query.append("	 WHERE CAR_NAME <>'' ");


			 if (gstr1 != null && !gstr1.equals("")) query.append( "  AND CAR_NAME LIKE '"+gstr1+"%'  \n");//null값 체크

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



