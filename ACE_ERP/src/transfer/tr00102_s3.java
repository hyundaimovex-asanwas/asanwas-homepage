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
public class tr00102_s3 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); 
				if (str1==null || str1=="") str1 = "";
				String  str2	= req.getParameter("v_str2"); 
				if (str2==null || str2=="") str2 = "";
				String  str3	= req.getParameter("v_str3"); 
				if (str3==null || str3=="") str3 = "";
				String  str4	= req.getParameter("v_str4"); 
				if (str4==null || str4=="") str4 = "";
				String  str5	= req.getParameter("v_str5"); 
				if (str5==null || str5=="") str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","ORDER_SEQ","ETD_DT","ARTC_NM","ARTC_CNT",
																					"UNIT_PRICE","STN_SZNM","LDCARGONM","OFFCARGONM","CHK",
																					"LINE_PART","PROJECT"
																				}; 

				int[] intArrCN = new int[] {	10,  4,  8, 100, 13,
																			13, 50, 50,  50,  1,
																			30, 50
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1,  2,
																			 2, -1, -1, -1, -1,
																			-1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				if (str1.equals("Y")) {
					sql.append( " SELECT A.ORDER_NO, B.ORDER_SEQ, A.ETD_DT, B.ARTC_NM, B.ARTC_CNT, \n") 
						 .append( "				 B.UNIT_PRICE, B.STN_SZNM, C.MINORNM LDCARGONM, D.MINORNM OFFCARGONM, 'F' CHK, \n") 
						 .append( "				 E.MINORNM LINE_PART, CASE WHEN F.DETAIL_NM='' THEN F.PROJECT_NM ELSE F.DETAIL_NM END PROJECT \n") 
						 .append( "		FROM TRANSFER.LTORDERMST A, \n") 
						 .append( "				 TRANSFER.LTORDERDTL B \n") 
						 .append( "				 LEFT OUTER JOIN TRANSFER.LTLCODE C ON B.LDCARGO = C.MINORCD AND C.MAJORCD = '0007' \n") 
						 .append( "				 LEFT OUTER JOIN TRANSFER.LTLCODE D ON B.OFFCARGO = D.MINORCD AND D.MAJORCD = '0007', \n") 
						 .append( "        TRANSFER.LTLCODE E, \n") 
						 .append( "        TRANSFER.LTUNTCOD F \n") 
						 .append( "	 WHERE A.ORDER_NO = B.ORDER_NO \n") 
						 .append( "    AND A.LINE_PART = E.MINORCD \n")
						 .append( "    AND A.LINE_PART = F.LINE_PART \n")
						 .append( "    AND A.PROJECT = F.TR_PROJECT \n")
						 .append( "    AND A.LINE_PART = '" + str5 + "' \n")
						 .append( "    AND E.MAJORCD = '0002' \n")
						 .append( "		 AND A.IN_OUT = 'O' \n") 
						 .append( "		 AND A.ETD_DT BETWEEN '" + str2 + "' AND '" + str3 + "' \n") 
						 .append( "		 AND A.CREATE_USR = '" + str4 + "' \n") 
						 .append( "	 ORDER BY A.ETD_DT DESC, ORDER_NO DESC, ORDER_SEQ \n");

					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}

/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
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