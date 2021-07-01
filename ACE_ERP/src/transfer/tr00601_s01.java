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
public class tr00601_s01 extends HttpServlet {

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
				String  gstr2	= req.getParameter("v_str2");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "USERID","USERPW","USERNM","REGNO","ZIPCD",
																					"ADDR1","ADDR2","REGNM","TEL1","TEL2",
																					"TEL3","FAX1","FAX2","FAX3","MOBILE1",
																					"MOBILE2","MOBILE3","EMAIL","RELPART","CDATE"
																				}; 
				int[] intArrCN	= new int[]{  10,  10, 30, 13,  6,
																		 100, 100, 30,  3,  4,
																			 4,   3,  4,  4,  3,
																			 4,   4, 30,  2, 10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1
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
					query.append(" SELECT RTRIM(USERID) USERID, RTRIM(USERPW) USERPW, RTRIM(USERNM) USERNM, REGNO, RTRIM(ZIPCD) ZIPCD,  \n")
							 .append("        RTRIM(ADDR1) ADDR1, RTRIM(ADDR2) ADDR2, RTRIM(REGNM) REGNM, RTRIM(TEL1) TEL1, RTRIM(TEL2) TEL2,\n")
							 .append("				RTRIM(TEL3) TEL3, RTRIM(FAX1) FAX1, RTRIM(FAX2) FAX2, RTRIM(FAX3) FAX3, RTRIM(MOBILE1) MOBILE1, \n")
							 .append("				RTRIM(MOBILE2) MOBILE2, RTRIM(MOBILE3) MOBILE3, RTRIM(EMAIL) EMAIL, RELPART, CURRENT DATE CDATE \n")
							 .append("	 FROM TRANSFER.LTUSER ")
							 .append("  WHERE USERID LIKE UPPER('" + gstr2 + "%')") ;

					if (!gstr1.equals("")) query.append("		AND RELPART = '" + gstr1 + "'") ;

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



