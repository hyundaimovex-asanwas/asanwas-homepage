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
public class tr00514_s1 extends HttpServlet {

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
				String[] strArrCN = new String[]{ "CHARGECODE", "PACK_TYPE", "FROM_CBM", "TO_CBM", "UNIT_PRICE" 
													, "RQST_PRICE", "RQST_PRICE2", "ACM_PRICE", "EFF_DATE", "EXP_DATE"
														, "CREATE_DT", "CREATE_USR", "UPDATE_DT", "UPDATE_USR"
				
												}; 
				int[] intArrCN	= new int[]{  10,  10,  13,  13,  13,
												  13,  13,  13,  10,  10,
														10, 10, 10, 10
															
													}; 
				int[] intArrCN2 = new int[]{ -1, -1, 2, 2, 2,
												 2, 2, 2, -1, -1,
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

					query.append(" SELECT CHARGECODE, PACK_TYPE, COALESCE(FROM_CBM,0) FROM_CBM, COALESCE(TO_CBM,0) TO_CBM \n ");
					query.append(" , COALESCE(UNIT_PRICE,0) UNIT_PRICE, COALESCE(RQST_PRICE,0) AS RQST_PRICE , COALESCE(RQST_PRICE2,0) AS RQST_PRICE2 \n ");
					query.append(" , COALESCE(ACM_PRICE,0) ACM_PRICE, EFF_DATE, EXP_DATE  \n ");
					query.append(" , CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR \n ");
					
					query.append(" FROM TRANSFER.LTPCKCHRG ");

					query.append(" WHERE PACK_TYPE <> '' ") ;

				 if (gstr1 != null && !gstr1.equals("")) query.append( "  AND  PACK_TYPE =  '"+gstr1+"'  \n");//null값 체크
				 //if (gstr2 != null && !gstr2.equals("")) query.append( "  AND  PACK_TYPE =  '"+gstr2+"'  \n");//null값 체크
				 if (gstr2 != null && !gstr2.equals("")) query.append( "  AND '"+gstr2+"' BETWEEN FROM_CBM AND TO_CBM  \n");//null값 체크
				   
				// if (gstr2 != null && !gstr2.equals("")) query.append( "  AND  MINORNM LIKE '"+gstr2+"%'  \n");
				 //if (gstr3 != null && !gstr3.equals("")) query.append( "  AND  MINORNM LIKE  '"+gstr3+"%'  \n");
				 //if (gstr4 != null && !gstr4.equals("")) query.append( "  AND  A.LOGIS_TYPE =  '"+gstr4+"'  \n");
			     //if (gstr5 != null && !gstr5.equals("")) query.append( "  AND  E.CAR_TYPE =  '"+gstr5+"'  \n");
				// if (!gstr1.equals("")) query.append("		AND RELPART = '" + gstr1 + "'") ;
				//null값이 들어오면 실행이 되버려서 값이 조회할때 데이터가 안나온다

logger.dbg.println(this,query.toString());

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



