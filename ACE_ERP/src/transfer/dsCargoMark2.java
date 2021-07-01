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
public class dsCargoMark2 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		Statement stmt = null;
		ResultSet rs = null;

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
				
				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }

logger.dbg.println(this,str1);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"OBJ_REMK","ORDER_NO","ETD_DT","REGNM","SHIPPER_NM",
																					"REMARK","ARTCNM","LDCARGO","OFFCARGO" }; 

				int[] intArrCN = new int[] { 100,  10,  8, 60, 40,
																		 100, 200, 20, 20 }; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1,
																		-1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				String [] rsstr = new String[6];
				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT A.OBJ_REMK, A.ORDER_NO, A.ETD_DT, A.RECIPIENT || '/'|| A.RECP_OWN REGNM, B.VEND_NM, A.REMARK \n")
					 .append( "   FROM TRANSFER.LTORDERMST A, \n")
					 .append( "        ACCOUNT.GCZM_VENDER B \n")
					 .append( "  WHERE A.ORDER_NO = '" + str1 + "' \n")
					 .append( "    AND A.SHIPPER  = B.VEND_CD \n");

				//logger.dbg.println(this,sql.toString());

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				while (rs.next())	{
					for (int i=0; i<rsstr.length ; i++) rsstr[i] = rs.getString(i+1);
				}

				stmt = null;
				rs = null;
				sql = null;

				sql = new StringBuffer();
				sql.append( " SELECT D.MINORNM, E.MINORNM, B.ARTC_NM, C.ARTC_CNT, A.LD_CARGO, A.OFF_CARGO \n")
					 .append( "   FROM TRANSFER.LTORDCAR A, \n")
					 .append( "        TRANSFER.LTORDERDTL B, \n")
					 .append( "        TRANSFER.LTCARGOODS C, \n")
					 .append( "        TRANSFER.LTLCODE D, \n")
					 .append( "        TRANSFER.LTLCODE E \n")
					 .append( "  WHERE A.ORDER_NO		= '" + str1 + "' \n")
					 .append( "    AND A.ORDER_NO		= B.ORDER_NO \n")
					 .append( "    AND A.CAR_SEQ_NO = C.CAR_SEQ_NO \n")
					 .append( "    AND B.ORDER_NO		= C.ORDER_NO \n")
					 .append( "    AND B.ORDER_SEQ	= C.ORDER_SEQ \n")
					 .append( "    AND A.LD_CARGO		= D.MINORCD \n")
					 .append( "    AND A.OFF_CARGO	= E.MINORCD \n")
					 .append( "    AND D.MAJORCD		= '0007' \n")
					 .append( "    AND E.MAJORCD		= '0007' \n")
					 .append( "  ORDER BY D.MINORNM, E.MINORNM ");

				//logger.dbg.println(this,sql.toString());

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				String [][] strgbn = new String[100][6];
				int s = 0;
				String sdata1 = "";
				String sdata2 = "";
				int w = 1;

				while (rs.next())	{
					sdata2 = rs.getString(5)+rs.getString(6);
					if (sdata1.equals(sdata2)) s--;

					for (int k=0; k<6; k++) {
						if (k==2) {
							strgbn[s][k] += ", " + rs.getString(3) + ":" + rs.getInt(4);

							if (w>9) {
								s++;
								w = 1;
							} else w++;

						} else if (k==3) {}
						else strgbn[s][k] = rs.getString(k+1);
					}
					sdata1 = rs.getString(5)+rs.getString(6);
					s++;
				}

				String gbn = "";
				String rgbn = "";
				String artcnm = "";

	    	GauceDataRow row = null;

				for (int k=0; k<strgbn.length ; k++) {
					if (strgbn[k][0]==null || strgbn[k][0].equals("")) break;

					artcnm = strgbn[k][2].substring(6,strgbn[k][2].length());// + ":" + strgbn[k][3];

					row = dSet.newDataRow();

					for (int d=0; d<rsstr.length ;d++ ) row.addColumnValue(new String(rsstr[d].getBytes("euc_kr"),"8859_1"));

					row.addColumnValue(new String(artcnm.getBytes("euc_kr"),"8859_1"));
					row.addColumnValue(new String(strgbn[k][0].getBytes("euc_kr"),"8859_1"));
					row.addColumnValue(new String(strgbn[k][1].getBytes("euc_kr"),"8859_1"));

					dSet.addDataRow(row);

				}

/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
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