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
public class userlogin extends HttpServlet {

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
				if (gstr1==null || gstr1.equals("")) gstr1 = "";
				String  gstr2	= req.getParameter("vstr2");
				if (gstr2==null || gstr2.equals("")) gstr2 = "";

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "USERID","USERPW","USERNM","REGNO","ZIPCD",
																					"ADDR1","ADDR2","REGNM","TEL1","TEL2",
																					"TEL3","FAX1","FAX2","FAX3","MOBILE1",
																					"MOBILE2","MOBILE3","EMAIL","RELPART","CDATE",
																					"VEND_CD","VEND_NM","TEMPFLAG","NDATE","USER_DIV"
																				}; 
				int[] intArrCN	= new int[]{  10,  10, 30, 13,  6,
																		 100, 100, 30,  3,  4,
																			 4,   3,  4,  4,  3,
																			 4,   4, 30,  4, 10,
																			13,  62,  1,  8,  1
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
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
					query.append(" SELECT RTRIM(A.USERID) USERID, RTRIM(A.USERPW) USERPW, RTRIM(A.USERNM) USERNM, A.REGNO, RTRIM(A.ZIPCD) ZIPCD,  \n")
							 .append("        RTRIM(A.ADDR1) ADDR1, RTRIM(A.ADDR2) ADDR2, RTRIM(A.REGNM) REGNM, RTRIM(A.TEL1) TEL1, RTRIM(A.TEL2) TEL2,\n")
							 .append("				RTRIM(A.TEL3) TEL3, RTRIM(A.FAX1) FAX1, RTRIM(A.FAX2) FAX2, RTRIM(A.FAX3) FAX3, RTRIM(A.MOBILE1) MOBILE1, \n")
							 .append("				RTRIM(A.MOBILE2) MOBILE2, RTRIM(A.MOBILE3) MOBILE3, RTRIM(A.EMAIL) EMAIL, A.RELPART, CURRENT DATE CDATE, \n")
							 .append("				B.VEND_CD, RTRIM(B.VEND_NM) VEND_NM, A.TEMPFLAG, SUBSTR(CHAR(CURRENT TIMESTAMP + 2 DAYS),1,4)||SUBSTR(CHAR(CURRENT TIMESTAMP + 2 DAYS),6,2)||SUBSTR(CHAR(CURRENT TIMESTAMP + 2 DAYS),9,2) NDATE, USER_DIV \n")
							 .append("	 FROM TRANSFER.LTUSER A \n")
							 .append("				LEFT OUTER JOIN ACCOUNT.GCZM_VENDER B ON A.REGNO = B.VEND_ID \n")
							 .append("	WHERE USERID = UPPER('" + gstr1 + "') ");

					if (!gstr2.equals("")) query.append("    AND UPPER(USERPW) = UPPER('" + gstr2 + "')") ;

					//logger.dbg.println(this,""+query.toString());

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



