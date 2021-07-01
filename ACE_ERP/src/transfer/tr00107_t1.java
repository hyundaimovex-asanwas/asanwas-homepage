package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00107_t1 extends HttpServlet{

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
			String gubun="0";

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
				String carno = "";
				String InsertSql	= "";
				String UpdateSql	= "";
				String DeleteSql	= "";
				String sql = "";

				//출입계획 차량 삭제를 위한 정보
				sql = " SELECT ACCESSNO FROM TRANSFER.LTACCPLAN  "
						+ "  WHERE ACC_DATE = '" + gstr2 + "'"
						+ "    AND PROJECT_CD = '" + gstr4 + "'";

				stmt = gconn.createStatement();
				rs = stmt.executeQuery(sql);

				while(rs.next()) {
					//출입계획 차량계획
					DeleteSql  = " DELETE FROM TRANSFER.LTCARACC \n" +
											 "  WHERE ACCESS_NO = '" + rs.getString(1) +"'";

					GauceStatement gstmt_bef = gconn.getGauceStatement(DeleteSql);
					gstmt_bef.executeUpdate(); 
					gstmt_bef.close();
				}	
				stmt = null;
				rs = null;

				//출입계획 마스터
				DeleteSql  = " DELETE FROM TRANSFER.LTACCPLAN \n" +
										 "  WHERE ACC_DATE = '" + gstr2 + "'" +
										 "    AND PROJECT_CD = '" + gstr4 + "'";

				GauceStatement gstmt_bef = gconn.getGauceStatement(DeleteSql);
				gstmt_bef.executeUpdate(); 
				gstmt_bef = null;
				/*
				//출입계획 방문인원
				DeleteSql  = " DELETE FROM TRANSFER.LTPSRNACC \n" +
										 "  WHERE START_DATE = '" + gstr2 +"'";

				gstmt_bef = gconn.getGauceStatement(DeleteSql);
				gstmt_bef.executeUpdate(); 
				gstmt_bef.close();
				*/

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						carno = rows[j].getString(idx[13]);

						String cstr1 = rows[j].getString(idx[3]);
						String cstr2 = "";

						if (cstr1.equals("0001")) cstr2 = "개성공단 물자";
						else if (cstr1.equals("0002")) cstr2 = "금강산사업소 물자";
						else if (cstr1.equals("0003")) cstr2 = "철도도로 물자";

						if (j==0)	{

							//출입계획 No 생성
							sql = " SELECT MAX(SUBSTRING(ACCESSNO,7,10))+1 FROM TRANSFER.LTACCPLAN  "
									+ "  WHERE SUBSTRING(ACCESSNO,1,6) = '" + gstr1 + "'";

							stmt = gconn.createStatement();
							rs = stmt.executeQuery(sql);
							while(rs.next()) {
								icnt = rs.getInt(1);
							}	

							stmt = null;
							rs = null;
							if (icnt<1) saccno = gstr1 + "0001";
							else if (icnt<10) saccno = gstr1 + "000" + icnt;
							else if (icnt<100) saccno = gstr1 + "00" + icnt;
							else if (icnt<1000) saccno = gstr1 + "0" + icnt;
							else if (icnt<10000) saccno = gstr1 + icnt;

							stime = rows[j].getString(idx[15]);

							//출입계획 마스터

							InsertSql  = " INSERT INTO TRANSFER.LTACCPLAN \n" +
													 " ( " +
													 "		ACCESSNO, PROJECT_CD, ACC_NAME, ACC_DATE, RTRN_DATE, \n" +
													 "		START_TIME, SMDL_TIME, RTRN_TIME, RMDL_TIME, SPERSON_CNT,  \n" +
													 "		SCAR_CNT, RPERSON_CNT, RCAR_CNT, PURPOSE, GOODS,   \n" +
													 "		CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST  \n" +
													 " ) VALUES (  " +
													 "  '" + saccno + "', '" + cstr1 +"', '" + cstr2 + "', '" + gstr2 + "', '" + rows[j].getString(idx[17]) + "', \n" +
													 " '" + stime + "', '" + stime + "', '" + rows[j].getString(idx[18]) + "', '" + rows[j].getString(idx[18]) + "', 0, \n" +
													 " 0, 0, 0, '" + cstr2 + "', '" + rows[j].getString(idx[9]) + "', \n" +
													 " CURRENT TIMESTAMP, '" + gstr3 + "', CURRENT TIMESTAMP, '" + gstr3 + "' ) ";

							GauceStatement gstmt = gconn.getGauceStatement(InsertSql);
							gstmt.setGauceDataRow(rows[j]);
							gstmt.executeUpdate(); 
							gstmt.close();
						} else { //j<>0

							if (!stime.equals(rows[j].getString(idx[15])) && rows[j].getString(idx[12]).equals("O") ){
								//출입계획 No 생성
								sql = " SELECT MAX(SUBSTRING(ACCESSNO,7,10))+1 FROM TRANSFER.LTACCPLAN  "
										+ "  WHERE SUBSTRING(ACCESSNO,1,6) = '" + gstr1 + "'";

								stmt = gconn.createStatement();
								rs = stmt.executeQuery(sql);

								while(rs.next()) {
									icnt = rs.getInt(1);
								}	

								stmt = null;
								rs = null;

								if (icnt<1) saccno = gstr1 + "0001";
								else if (icnt<10) saccno = gstr1 + "000" + icnt;
								else if (icnt<100) saccno = gstr1 + "00" + icnt;
								else if (icnt<1000) saccno = gstr1 + "0" + icnt;
								else if (icnt<10000) saccno = gstr1 + icnt;

								stime = rows[j].getString(idx[15]);

								//출입계획 마스터


                //logger.dbg.println(carno,"test_122222222222222201");

								InsertSql  = " INSERT INTO TRANSFER.LTACCPLAN \n" +
														 " ( " +
														 "		ACCESSNO, PROJECT_CD, ACC_NAME, ACC_DATE, RTRN_DATE, \n" +
														 "		START_TIME, SMDL_TIME, RTRN_TIME, RMDL_TIME, SPERSON_CNT,  \n" +
														 "		SCAR_CNT, RPERSON_CNT, RCAR_CNT, PURPOSE, GOODS,   \n" +
														 "		CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST  \n" +
														 " ) VALUES (  " +
														 "  '" + saccno + "', '" + cstr1 +"', '" + cstr2 + "', '" + gstr2 + "', '" + rows[j].getString(idx[17]) + "', \n" +
														 " '" + stime + "', '" + stime + "', '" + rows[j].getString(idx[18]) + "', '" + rows[j].getString(idx[18]) + "', 0, \n" +
														 " 0, 0, 0, '" + cstr2 + "', '" + rows[j].getString(idx[9]) + "', \n" +
														 " CURRENT TIMESTAMP, '" + gstr3 + "', CURRENT TIMESTAMP, '" + gstr3 + "' ) ";

								GauceStatement gstmt = gconn.getGauceStatement(InsertSql);
								gstmt.setGauceDataRow(rows[j]);
								gstmt.executeUpdate(); 
								gstmt.close();
							}
						} //if (j==0)	{

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

						//배차자료 검색
						sql = " SELECT CAR_SEQ_NO, ACCSECTION, CAR_NO " +
									"		FROM TRANSFER.LTCARACC " +
									"  WHERE CAR_SEQ_NO = '" + apm[0] + "'" + 
							        "    AND ACCSECTION = '" + rows[j].getString(idx[12]) + "'" +
							        "    AND CAR_NO = '" + rows[j].getString(idx[13]) + "'" ;

						stmt = gconn.createStatement();
						rs = stmt.executeQuery(sql);
						//String apm[] = new String[8];
                        gubun="0";
						while(rs.next()) {
							gubun = "1";
						}	
             //logger.dbg.println(this,"test_109");
					   //logger.dbg.println(this,"gubun::"+gubun);

                       if(gubun.equals("1")){
						//출입계획 차량계획(배차정보) 업데이트
						InsertSql = " UPDATE TRANSFER.LTCARACC \n" +
							        "    SET START_TIME = '" + rows[j].getString(idx[15]) + "', \n" +
							        "        RTRN_DATE = '" + rows[j].getString(idx[17]) + "', \n" + 
							        "        RTRN_TIME = '" + rows[j].getString(idx[18]) + "', \n" +
							        "        UPDATE_DT = CURRENT TIMESTAMP, \n" +
							        "        UPDATE_UST = '" + gstr3 + "' \n" +
							        "  WHERE CAR_SEQ_NO = '" + apm[0] + "' \n" +
							        "    AND ACCSECTION = '" + rows[j].getString(idx[12]) + "' \n" +
							        "    AND CAR_NO = '" + rows[j].getString(idx[13]) + "'" ;
						
						  //logger.dbg.println(this,"update::"+InsertSql.toString());
						}else{
						
							if(carno.equals("")){
								carno +="                    ";
								rows[j].setString(idx[13],carno);//이 데이타셋에 carno를 넣겠다는 뜻.
							} 
							//logger.dbg.println(carno,"test23");
						//출입계획 차량계획(배차정보) 인서트

							if(apm[0]==null) apm[0] = "";
							if(apm[3]==null) apm[3] = "";
							if(apm[4]==null) apm[4] = "";
							if(apm[5]==null) apm[5] = "";
							if(apm[6]==null) apm[6] = "";
							if(apm[7]==null) apm[7] = "";
		/*					if(idx[4]==null) idx[4] = "";
							if(idx[10]==null) idx[10] = "";
							if(idx[12]==null) idx[12] = "";
							if(idx[13]==null) idx[13] = "";
							if(idx[14]==null) idx[14] = "";
							if(idx[15]==null) idx[15] = "";
							if(idx[17]==null) idx[17] = "";
							if(idx[18]==null) idx[18] = "";*/
							if(saccno==null) saccno = "";
							if(gstr3==null) gstr3 = "";
							if(cstr2==null) cstr2 = "";

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
													 "  '" + rows[j].getString(idx[15]) + "', '" + rows[j].getString(idx[17]) + "', '" + rows[j].getString(idx[18]) + "', '" + saccno + "',  \n" +
													 " CURRENT TIMESTAMP, '" + gstr3 + "', CURRENT TIMESTAMP, '" + gstr3 + "' ) ";
						
						   //logger.dbg.println(this,"insert::"+InsertSql.toString());
						}//if(gubun.equals("1")){
                        
						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gstmt1 = gconn.getGauceStatement(InsertSql);
						gstmt1.setGauceDataRow(rows[j]);
						gstmt1.executeUpdate(); 
						gstmt1.close();
					 } //if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT)

				}//for
//logger.dbg.println(carno,"test33");
				//출입계획 No 생성
				sql = " SELECT ACCESS_NO, START_TIME, SUM(PERSON_CNT), SUM(CASE WHEN CAR_NO='' THEN 0 ELSE 1 END) " +
							"		FROM TRANSFER.LTCARACC " +
							"	 WHERE ACCSECTION = 'I' " +
							"		 AND START_DATE = '" + gstr2 + "'" +
							"  GROUP BY ACCESS_NO, START_TIME ";

				stmt = gconn.createStatement();
				rs = stmt.executeQuery(sql);

				String sno = "";
				int ipc = 0;
				int icc = 0;

				while(rs.next()) {
					sno = rs.getString(1);
					ipc = rs.getInt(3);
					icc = rs.getInt(4);

					//출입계획 마스터 인원, 차량
					UpdateSql  = " UPDATE TRANSFER.LTACCPLAN \n" +
											 "		SET SPERSON_CNT = " + ipc + "," +
											 "				RPERSON_CNT = " + ipc + "," +
											 "				SCAR_CNT = " + icc + "," +
											 "				RCAR_CNT = " + icc +
											 "  WHERE ACCESSNO = '" + sno + "'";

					GauceStatement gstmt_m = gconn.getGauceStatement(UpdateSql);
					gstmt_m.executeUpdate(); 
					gstmt_m.close();

				}	

				stmt.close();
				rs.close();

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