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
public class dsEdCar3 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }


				String str0 = GauceReq.getParameter("gstr0");                    //반입반출
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
				String str1 = GauceReq.getParameter("gstr1");                    // 반출일자
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");                    // 주문번호
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");                    // 
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
        String str4 = GauceReq.getParameter("gstr4");                    // 사업명
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
        String str5 = GauceReq.getParameter("gstr5");                    // 업체명
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }
			  String str6 = GauceReq.getParameter("gstr6");                    //
					if (str6==null || str6.trim().length()==0 ) {   str6=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CARGO_TYPE","CAR_NO",     "CAR_NAME",  "PERSON_NO","USERNM",
					                                "CTN_STDRD", "CAR_CBM",    "CAR_TON",   "LD_CARGO", "LD_CARGONM",
					                                "OFF_CARGO", "OFF_CARGONM","CAR_SEQ_NO","ORDER_NO", "IN_OUT",
					                                "EDT_DATE","DIV_IO", "CHK", "SHIPPER", "SHIPPNM", "PSN_KNAME"
					                                }; 

				int[] intArrCN = new int[] { 10, 20, 30, 20, 30,
					                           60,  7,  7, 10,150,
					                           10,150, 10, 10,  1, 
					                            8,  1,  1, 13, 62, 30
					                         }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
					                           -1,  2,  2, -1, -1, 
                                     -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1
					                         }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append("  SELECT DISTINCT                                                                              \n");
					sql.append("         CASE WHEN A.ORDER_NO IS NULL OR RTRIM(A.ORDER_NO) = '' THEN '혼재'                    \n");
					sql.append("              WHEN M.CARGO_TYPE = '0001' THEN '일반(단독)'                                     \n");
					sql.append("              WHEN M.CARGO_TYPE = '0003' THEN '탁송'                                           \n");
					sql.append("              WHEN M.CARGO_TYPE = '0004' THEN '건설기계'                                       \n");
					sql.append("         ELSE '일반' END AS CARGO_TYPE,                                                        \n");
					sql.append("         D.CAR_NO,                                                                             \n");
					sql.append("         B.CAR_NAME, D.PERSON_NO, C.USERNM, A.CTN_STDRD,B.CAR_CBM, B.CAR_TON,                  \n");
					sql.append("         A.LD_CARGO, A.LD_CARGONM,A.CAR_SEQ_NO,                                                \n");
					sql.append("         A.OFF_CARGO, A.OFF_CARGONM,  A.ORDER_NO  , IFNULL(A.IN_OUT,'') AS IN_OUT,             \n");
          sql.append("         IFNULL(A.EDT_DATE ,'') AS EDT_DATE,   IFNULL(M.DIV_IO,'') AS DIV_IO, ''CHK,           \n");
				  sql.append("         M.SHIPPER, E.VEND_NM AS SHIPPNM ,                                        \n");
					sql.append("         CASE WHEN RTRIM(F.PSN_KNAME)='' OR F.PSN_KNAME IS NULL THEN D.PERSON_NO ELSE F.PSN_KNAME END PSN_KNAME \n"); //2008.10.29 JYS
					sql.append("    FROM TRANSFER.LTORDCAR A, TRANSFER.LTCARTYPE B                                             \n");
					sql.append("    LEFT JOIN TRANSFER.LTORDERMST M ON M.ORDER_NO = A.ORDER_NO                                 \n");
					sql.append("    LEFT JOIN TRANSFER.LTUSER C ON A.CREATE_USR = C.USERID                                     \n");
					sql.append("    LEFT JOIN TRANSFER.LTCARACC D ON A.CAR_SEQ_NO = D.CAR_SEQ_NO AND A.IN_OUT = D.ACCSECTION   \n");
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER E ON M.SHIPPER = E.VEND_CD                                   \n");
					sql.append( "   LEFT JOIN TRANSFER.LTPERSON F ON D.PERSON_NO = F.PERSON_NO                                 \n");
					sql.append("   WHERE A.CARTYPENO = B.CAR_TYPE                                                              \n");
					sql.append("     AND A.IN_OUT = '" + str0 + "'                                                             \n");
					sql.append("     AND D.CAR_SEQ_NO IS NOT NULL                                                              \n");
					if(str1 != null ) sql.append(" AND  A.EDT_DATE  = '" + str1 + "'" );
					if(str2 != null ) sql.append(" AND  A.ORDER_NO  = '" + str2 + "'" );
					if(str4 != null ) sql.append(" AND  A.LINE_PART = '" + str4 + "'" );
					if(str5 != null ) sql.append(" AND  C.USERNM LIKE '" + str5 + "%'" );
					
//			  .append("  WHERE A.CARTYPENO = B.CAR_TYPE \n")
//   		  .append("    AND X.ORDER_NO IS NOT NULL ")
//				.append("    AND A.IN_OUT = '" + str0 + "' ");
					

				//	if(str3 != null ) sql.append(" AND  CAR_SEQ_NO  = '" + str3 + "'" );
				//	if(str2 != null ) sql.append(" AND  A.ORDER_NO  = '" + str2 + "'" );
				//	if(str1 != null ) sql.append(" AND  A.EDT_DATE  = '" + str1 + "'" );
				//	if(str4 != null ) sql.append(" AND  A.LINE_PART = '" + str4 + "'" );
				//	if(str5 != null ) sql.append(" AND  C.USERNM LIKE '" + str5 + "%'" );
				//	if(str6 != null ) sql.append(" AND  FLAG = '" + str6 + "'" );

					sql.append(" ORDER BY A.CAR_SEQ_NO ");


          logger.dbg.println(this,sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
	 				stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			//GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
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