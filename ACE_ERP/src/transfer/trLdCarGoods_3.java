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
public class trLdCarGoods_3 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		Statement stmt = null;
		ResultSet rs = null;
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
				String str1 = GauceReq.getParameter("gstr1");
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"RTN" }; 

				int[] intArrCN = new int[] {1 }; 
			
				int[] intArrCN2 = new int[]{-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				sql.append( "	SELECT ARTC_CNT, PKG_CNT \n")
					 .append( "   FROM TRANSFER.LTORDERDTL \n")
					 .append( "  WHERE ORDER_NO = '" + str1 + "' \n")
					 .append( "    AND ORDER_SEQ = '" + str2 + "' ");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				String scar[] = new String[2];
				while(rs.next()) {
					for (int k=0; k<2; k++)	scar[k] = rs.getString(k+1);
				}

				stmt = null;
				rs = null;
				sql = null;

				if (scar[0]==null || scar[0]=="" || str3==null) {
				} else {
					int iartc_cnt = (int) (Float.parseFloat(scar[0]));
					int istr3 = Integer.parseInt(str3);
					int ival = iartc_cnt/istr3;

					int iartc_cnt_2[] = new int[istr3];
					int ichk = 1;
					for (int d=0; d<iartc_cnt_2.length; d++) {
						if (ichk == iartc_cnt_2.length) iartc_cnt_2[d] = (iartc_cnt - (d*ival));
						else iartc_cnt_2[d] = ival;
						ichk++;
					}

					//차량 조회
					sql = new StringBuffer();
					sql.append( " SELECT CAR_SEQ_NO \n")
						 .append( "		FROM TRANSFER.LTORDCAR  \n")
						 .append( "  WHERE ORDER_NO = '" + str1 + "' \n");

logger.dbg.println(this,sql.toString());

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());

					int icar = 0;
					while(rs.next()) {

						StringBuffer query = new StringBuffer();
						query.append( " INSERT INTO TRANSFER.LTCARGOODS \n")
								 .append( "		(  \n")
								 .append( "		 ORDER_NO, ORDER_SEQ, PKG_CBM, PKG_CNT, PKG_WGHT,  \n")
								 .append( "		 ARTC_CNT, CREATE_DT, CAR_SEQ_NO, ARTC_UNIT, PKG_UNIT \n")
								 .append( "		) \n")
								 .append( " SELECT  \n");

						if (icar==0) query.append( "		ORDER_NO, ORDER_SEQ, PKG_LNGTH*PKG_HEIGHT*PKG_WIDTH/1000000, PKG_CNT, PUNIT_WGHT*PKG_CNT, \n");
						else query.append( "		ORDER_NO, ORDER_SEQ, 0, 0, 0, \n");

						query.append( "		" + iartc_cnt_2[icar] + ", CURRENT TIMESTAMP, '" + rs.getString(1) + "',0 ,0 \n")
								 .append( "   FROM TRANSFER.LTORDERDTL \n")
								 .append( "  WHERE ORDER_NO = '" + str1 + "' \n")
								 .append( "    AND ORDER_SEQ = '" + str2 + "' ");

						gstmt = conn.getGauceStatement(query.toString());
						gstmt.executeUpdate(); 
						gstmt.close();

						icar++;
					}

					stmt = null;
					rs = null;

				}

				stmt.close();
				rs.close();

	    	GauceDataRow row = null;
	    	row = dSet.newDataRow();
				row.addColumnValue("S");
				dSet.addDataRow(row);
		
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
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