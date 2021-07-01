package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00107_t2 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest GauceReq = null;
	 		GauceResponse GauceRes = null;

			try {

				gconn = service.getDBConnection();

				GauceReq = service.getGauceRequest();
				GauceRes = service.getGauceResponse();

				String gstr1 = GauceReq.getParameter("v_str1");
				String gstr2 = GauceReq.getParameter("v_str2");
				String gstr3 = GauceReq.getParameter("v_str3");
				String gstr4 = GauceReq.getParameter("v_str4");

				GauceDataSet userSet = GauceReq.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{ "CAR_SEQ_NO","TYPE","ORDER_NO","LINE_PART","CARTYPENO",
																					"LD_DATE","PERSON_NO_C","CAR_TYPE","REMARK","CTN_STDRD",
																					"EDT_DATE","LCT_URL","IN_OUT","CAR_NO","PERSON_NO",
																					"START_TIME","ACCESS_NO","RTRN_DATE","RTRN_TIME","CHECK",
																					"PASS","CAR_CNT","CAR_TYPENM"
																				}; 
				int[] idx = new int[23];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				Statement stmt = null;
				ResultSet rs = null;
				int icnt = 0;
				String saccno = "";
				String stime = "";

				String InsertSql	= "";
				String UpdateSql	= "";
				String DeleteSql	= "";
				String sql = "";

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						String cstr1 = rows[j].getString(idx[3]);
						String cstr2 = "";

						if (cstr1.equals("0001")) cstr2 = "개성공단 물자";
						else if (cstr1.equals("0002")) cstr2 = "금강산사업소 물자";
						else if (cstr1.equals("0003")) cstr2 = "철도도로 물자";

						//배정자료 검색
						sql = " SELECT CAR_SEQ_NO, IN_OUT, IFNULL(PERSON_NO,''), IFNULL(LD_CARGO,''), IFNULL(LD_CARGONM,''), " +
								 	"				 IFNULL(OFF_CARGO,''), IFNULL(OFF_CARGONM,''), IFNULL(CTN_STDRD,'') " +
									"		FROM TRANSFER.LTORDCAR " +
									"  WHERE CAR_SEQ_NO = '" + rows[j].getString(idx[0]) + "'";

						stmt = gconn.createStatement();
						rs = stmt.executeQuery(sql);
						String apm[] = new String[8];

						while(rs.next()) {
							for (int k=0; k<8; k++) {
								apm[k] = rs.getString(k+1);
							}
						}	

						stmt = null;
						rs = null;
						InsertSql = "";
						
						//출입계획 차량계획
						InsertSql  = " INSERT INTO TRANSFER.LTCARACC \n" +
												 " ( " +
												 "		CAR_SEQ_NO, ACCSECTION, PERSON_NO, LD_CARGO, LD_CARGONM,  \n" +
												 "		OFF_CARGO, OFF_CARGONM, RDS_GOODS,  \n" +
												 "		CAR_NO, CAR_TYPE, PURPOSE, PERSON_CNT, START_DATE, " +
												 "		START_TIME, RTRN_DATE, RTRN_TIME, ACCESS_NO,  \n" +
												 "		CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST  \n" +
												 " ) VALUES (  " +
												 "  '" + apm[0] + "', '" + rows[j].getString(idx[12]) +"', '" + rows[j].getString(idx[14]) + "', '" + apm[3] + "', '" + apm[4] + "', \n" +
												 "  '" + apm[5] + "', '" + apm[6] +"', '" + apm[7] + "', \n" +
												 "  '" + rows[j].getString(idx[13]) + "', '" + rows[j].getString(idx[4]) + "', '" + cstr2 + "', 1,'" + rows[j].getString(idx[10]) + "',  \n" +
												 "  '" + rows[j].getString(idx[15]) + "', '" + rows[j].getString(idx[17]) + "', '" + rows[j].getString(idx[18]) + "', '" + rows[j].getString(idx[16]) + "',  \n" +
												 " CURRENT TIMESTAMP, '" + gstr3 + "', CURRENT TIMESTAMP, '" + gstr3 + "' ) ";

						GauceStatement gstmt1 = gconn.getGauceStatement(InsertSql);
						gstmt1.setGauceDataRow(rows[j]);
						gstmt1.executeUpdate(); 
						gstmt1.close();
					}
				}
			}

			catch(Exception e){
				GauceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}


			GauceRes.flush();
			GauceRes.commit();
			GauceRes.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (gconn != null) {	try {	gconn.close();	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}