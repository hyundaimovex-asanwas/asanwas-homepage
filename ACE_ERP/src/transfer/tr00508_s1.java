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
public class tr00508_s1 extends HttpServlet {

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
				String  gstr3	= req.getParameter("v_str3");
				String  gstr4	= req.getParameter("v_str4");
				String  gstr5	= req.getParameter("v_str5");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "CHARGECODE", "EFF_DATE", "EXP_DATE", "LINE_PART", "CLASS"
													, "SECTION", "SECTION2", "ARTC_CD", "LOGIS_TYPE", "LOGIS_UNIT"
														, "UNIT_PRICE", "RQST_PRICE", "RQST_PRICE2", "RQST_PRCNT", "CURRENCY"
															,"CAR_CLASS", "CANCLE1", "CANCLE2", "CANCLE3", "CANCLE4"
																, "CANCLE5", "CREATE_DT", "CREATE_USR", "UPDATE_DT", "UPDATE_USR"
																	, "A_CD", "S_TION", "S_TION2", "LOGIS"

																				}; 
				int[] intArrCN	= new int[]{  10,  8,  8,  10,  10,
												  10,  10,  10,  10,  10,
													13,  13,  13,  13,  10, 
														10,  13,  13, 13,  13,
															 13,  10, 10, 10, 10,
																50, 50, 50, 50
													}; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
												 -1, -1, -1, -1,  -1,
													  2, 2, 2, 2, -1,
														 -1, 2, 2, 2, 2,
															 2, -1, -1, -1, -1,
																-1, -1, -1, -1
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

					query.append(" SELECT A.CHARGECODE, A.EFF_DATE, A.EXP_DATE, A.LINE_PART, A.CLASS \n ");
					query.append(" , A.SECTION, A.SECTION2, A.ARTC_CD, A.LOGIS_TYPE, A.LOGIS_UNIT \n ");
					query.append(" , COALESCE(A.UNIT_PRICE,0) UNIT_PRICE, COALESCE(A.RQST_PRICE,0) AS RQST_PRICE  \n ");
					query.append(" , COALESCE(A.RQST_PRICE2,0) AS RQST_PRICE2, COALESCE(A.RQST_PRCNT,0) RQST_PRCNT, A.CURRENCY \n ");
					query.append(" , A.CAR_CLASS, COALESCE(A.CANCLE1,0) AS CANCLE1, COALESCE(A.CANCLE2,0) AS CANCLE2, COALESCE(A.CANCLE3,0) CANCLE3, COALESCE(A.CANCLE4,0)CANCLE4 \n ");
					query.append(" , COALESCE(A.CANCLE5,0) CANCLE5, A.CREATE_DT, A.CREATE_USR, A.UPDATE_DT, A.UPDATE_USR, B.MINORNM A_CD \n ");
					query.append(" , C.MINORNM S_TION, D.MINORNM S_TION2, E.CAR_NAME LOGIS  \n ");
					query.append(" FROM TRANSFER.LTCHARGE A ");

					query.append(" LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.ARTC_CD AND B.MAJORCD = '0006' \n ");
					query.append(" LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.SECTION AND C.MAJORCD = '0007' \n ");
					query.append(" LEFT JOIN TRANSFER.LTLCODE D ON D.MINORCD = A.SECTION2 AND D.MAJORCD = '0007' \n ");
					query.append(" LEFT JOIN TRANSFER.LTCARTYPE E ON E.CAR_TYPE = A.LOGIS_UNIT \n ");
					query.append(" WHERE A.CLASS <> '' ") ;

				 if (gstr1 != null && !gstr1.equals("")) query.append( "  AND  A.CLASS =  '"+gstr1+"'  \n");//null값 체크
				 if (gstr2 != null && !gstr2.equals("")) query.append( "  AND  C.MINORNM LIKE '"+gstr2+"%'  \n");
				 if (gstr3 != null && !gstr3.equals("")) query.append( "  AND  D.MINORNM LIKE  '"+gstr3+"%'  \n");
				 if (gstr4 != null && !gstr4.equals("")) query.append( "  AND  A.LOGIS_TYPE =  '"+gstr4+"'  \n");
			     if (gstr5 != null && !gstr5.equals("")) query.append( "  AND  E.CAR_TYPE =  '"+gstr5+"'  \n");
				// if (!gstr1.equals("")) query.append("		AND RELPART = '" + gstr1 + "'") ;
				//null값이 들어오면 실행이 되버려서 값이 조회할때 데이터가 안나온다

//logger.dbg.println(this,query.toString());

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



