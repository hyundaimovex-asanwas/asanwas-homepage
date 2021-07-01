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
public class tr00119_s1 extends HttpServlet {

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
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }

				String  str1	= req.getParameter("gstr1");
				String  str2	= req.getParameter("gstr2");
				String  str3	= req.getParameter("gstr3");
				String  str4	= req.getParameter("gstr4");
				String  str5	= req.getParameter("gstr5");
				String  str6	= req.getParameter("gstr6");
				String  str7	= req.getParameter("gstr7");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "CHECK", "MODIFY_NO", "MOD_STS", "ORDER_NO", "ETD_DT", "LINE_PART" 
														, "REQ_DATE", "APP_DATE"
													, "CARGO_TYPE", "DLVL_TYPE", "PROJECT", "CUST_CD", "CUST_PRSN"
														, "CUST_TELNO", "CUST_NM", "MOD_REMARK" 

												}; 
				int[] intArrCN	= new int[]{  1, 10,  1,  10,  8,  4,
													10, 10,
												  4,  4,  10,  13,  50,
														13, 50 ,200
	
													}; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
												-1, -1,
											 -1, -1, -1, -1, -1,
													-1, -1 ,-1
											 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING,intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				// 실제 쿼리문 작성
		   	if (isNotOnlyHeader) {					
					query = new StringBuffer();

					query.append(" SELECT 'F' AS CHECK, \n ")
							 .append("				A.MODIFY_NO, A.MOD_STS, A.ORDER_NO, A.ETD_DT, A.LINE_PART,    \n ")
							 .append("				A.REQ_DATE, A.APP_DATE,     \n ")
							 .append("				B.CARGO_TYPE, B.DLVL_TYPE, B.PROJECT, B.CUST_CD, B.CUST_PRSN, \n ")
							 .append("				B.CUST_TELNO, C.VEND_NM AS CUST_NM , A.MOD_REMARK  \n ")
							 .append("	 FROM TRANSFER.LTMODREQ A, \n ")
							 .append("	 			TRANSFER.LTORDERMST B, \n ")
							 .append("	 			ACCOUNT.GCZM_VENDER C  \n ")
							 .append("  WHERE A.ORDER_NO = B.ORDER_NO \n ")
							 .append("    AND C.VEND_CD = B.CUST_CD \n ");
					
					if (str1 != null && !str1.equals("")) query.append( "  AND  A.ORDER_NO =  '"+str1+"'  \n");//null값 체크
					//if (str2 != null && !str2.equals("")) query.append( "  AND  A.ETD_DT BETWEEN  '"+str2+"' AND '"+str3+" \n");//null값 체크
					if (!str2.equals("")) query.append( "  AND  A.ETD_DT BETWEEN '"+str2+"' AND '"+str3+"' \n");
					if (str4 != null && !str4.equals("")) query.append( "  AND  A.LINE_PART =  '"+str4+"'  \n");//null값 체크
					

					if (str5 != null && !str5.equals("")) query.append( "  AND  A.MOD_STS =  '"+str5+"'  \n");//null값 체크
					if (str6 != null && !str6.equals("")) query.append( "  AND  A.MOD_STS =  '"+str6+"'  \n");//null값 체크
					if (str7 != null && !str7.equals("")) query.append( "  AND  B.CARGO_TYPE =  '"+str7+"'  \n");//null값 체크
					
					//logger.err.println(this,query.toString());
/*********************************************************************************************/

					gstmt = gconn.getGauceStatement(query.toString());
	 		    gstmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
				if (gconn != null) try {gconn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit( );
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



