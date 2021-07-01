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
public class trLdCarGoods_4 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		
		//ServiceLoader loader = new ServiceLoader(req, res);
		com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
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


				//기 배정자료 삭제
				String DeleteSql = "";
				DeleteSql = " DELETE FROM TRANSFER.LTCARGOODS " 
									+ "  WHERE ORDER_NO = '" + str1 + "'";

				gstmt = conn.getGauceStatement(DeleteSql);
				gstmt.executeUpdate(); 
				gstmt = null;

				String [] garr1 = new String[1000];
				String [] garr2 = new String[100];

				//물품조회
				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT ORDER_SEQ \n")
					 .append( "		FROM TRANSFER.LTORDERDTL  \n")
					 .append( "  WHERE ORDER_NO = '" + str1 + "' \n");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				int iprd = 0;
				while(rs.next()) {
					garr1[iprd] = rs.getString(1);
					iprd++;
				}	
				stmt = null;
				rs = null;
				sql = null;

				//차량 조회
				sql = new StringBuffer();
				sql.append( " SELECT CAR_SEQ_NO \n")
					 .append( "		FROM TRANSFER.LTORDCAR  \n")
					 .append( "  WHERE ORDER_NO = '" + str1 + "' \n");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				int icar = 0;
				while(rs.next()) {
					garr2[icar] = rs.getString(1);
					icar++;
				}	
				stmt = null;
				rs = null;
				sql = null;

				String sprd = iprd + "";
				String scar = icar + "";
				float ftot1 = (Float.parseFloat(sprd))/(Float.parseFloat(scar));
				if (icar==0) icar = 1;
				int itot = iprd/icar;
				String stot = itot + "";
				float ftot2 = (Float.parseFloat(stot));

				int istr = Integer.parseInt(str2);

				for (int k=1; k<=icar; k++){
					String bet1 = "";
					String bet2 = "";

					if (k==1) {
						bet1 = "0";
						bet2 = garr1[itot*k-1];
					} else {
						if (istr==k) {
							if (ftot1>ftot2){
								bet1 = garr1[itot*k-itot];
								bet2 = garr1[itot*k];
							} else {
								bet1 = garr1[itot*k-itot];
								bet2 = garr1[itot*k-1];
							}
						} else {
							bet1 = garr1[itot*k-itot];
							bet2 = garr1[itot*k-1];
						}
					}

					StringBuffer query = new StringBuffer();
					/*
					query.append( " SELECT COUNT(*) CNT \n")
							 .append( "   FROM TRANSFER.LTORDERDTL \n")
							 .append( "  WHERE ORDER_NO = '" + str1 + "' \n")
							 .append( "    AND ORDER_SEQ BETWEEN '" + bet1 + "' AND '" + bet2 + "' ");
					*/
					query.append( " INSERT INTO TRANSFER.LTCARGOODS \n")
						 .append( "		(  \n")
						 .append( "		 ORDER_NO, ORDER_SEQ, ARTC_CNT, PKG_CNT, PKG_WGHT,  \n")
						 .append( "		 PKG_CBM, CREATE_DT, CAR_SEQ_NO, ARTC_UNIT, PKG_UNIT \n")
						 .append( "		) \n")
						 .append( " SELECT  \n")
						 .append( "		ORDER_NO, ORDER_SEQ, ARTC_CNT, PKG_CNT, PUNIT_WGHT*PKG_CNT, \n")
						 .append( "		PKG_LNGTH*PKG_HEIGHT*PKG_WIDTH/1000000, CURRENT TIMESTAMP, '" + garr2[k-1] + "',0 ,0 \n")
						 .append( "   FROM TRANSFER.LTORDERDTL \n")
						 .append( "  WHERE ORDER_NO = '" + str1 + "' \n")
						 .append( "    AND ORDER_SEQ BETWEEN '" + bet1 + "' AND '" + bet2 + "' ");

					
					System.out.println("trLdCarGoods_4::"+query.toString());
					gstmt = conn.getGauceStatement(query.toString());
					gstmt.executeUpdate(); 
					gstmt.close();

 		    	    GauceDataRow row = null;
 		    	    row = dSet.newDataRow();
					row.addColumnValue("S");
					dSet.addDataRow(row);

				}
			
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