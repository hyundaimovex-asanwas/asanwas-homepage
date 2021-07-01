package sales.menu.my;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class My400I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//미결문서 조회
		arr_sql[0].append("{call SALES.PR_MY400I_01 (?,?,?,?,?,   ?) }");
		
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		/*
		 * 검색시 필요한 조건
		 */
		
		String sNowEmpno	= HDUtil.nullCheckStr(req.getParameter("v_empno"));	// 로긴사번
		String sFrDate		= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));	//
		String sToDate		= HDUtil.nullCheckStr(req.getParameter("v_to_date"));	//
		String sDocGu		= HDUtil.nullCheckStr(req.getParameter("v_doc_gu"));	//
		int	   sClientSid	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//
		String sAcceptNo	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));	//
		
		/*
		StringUtil.printMsg("sNowEmpno - ", sNowEmpno, this);
		StringUtil.printMsg("sFrDate - ", sFrDate, this);
		StringUtil.printMsg("sToDate - ", sToDate, this);
		StringUtil.printMsg("sDocGu - ", sDocGu, this);
		StringUtil.printMsg("sClientSid - ", sClientSid, this);
		StringUtil.printMsg("sAcceptNo - ", sAcceptNo, this);
		*/
		
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("MASTER".equals(gauceName)) {
						//StringUtil.printMsg("미결문서 조회",arr_sql[0].toString(), this);
						cstmt = conn.prepareCall(arr_sql[0].toString());

						cstmt.setString(1, sNowEmpno);	
						cstmt.setString(2, sFrDate);	
						cstmt.setString(3, sToDate);	
						cstmt.setString(4, sDocGu);
						cstmt.setInt(5, sClientSid);
						cstmt.setString(6, sAcceptNo);
						
						rs = cstmt.executeQuery();
					}


					/*if ("DS2".equals(gauceName)) {	//하단 고객정보 그리드
						cstmt = conn.prepareCall(arr_sql[7].toString());
						
						cstmt.setString(1, sSDate);		// 시작일자
						cstmt.setString(2, sAccept_no);	// 신청서번호						
						cstmt.setInt   (3, sGoodSid);	// 상품 SID
						cstmt.setString(4, sClass);		// 반
						cstmt.setString(5, sTeam);		// 조
						cstmt.setString(6, sAssign_YN);	// 미배정
						cstmt.setString(7, sJobsel);	// 고객국분						
						
						
						
						rs = cstmt.executeQuery();	
					}*/
					
					getDataSet(rs, ds1).flush();

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","업데이트",this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");		
		
		try {
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					
					// 평면도 상태 변경 
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
//CALL SALES.PR_RV740I_04 ('20061001','20061002','IV',0,487,0,'','2030004','172.16.1.23','3',NULL,NULL,NULL);
						String sSDate 				= HDUtil.nullCheckStr(req.getParameter("sSDate"));	// 시작일자
						String sTDate 				= HDUtil.nullCheckStr(req.getParameter("sTDate"));	// 종료일자
						int colNm_Room_Status		= ds1.indexOfColumn("ROOM_STATUS");
						int colNm_Room_Sid  		= ds1.indexOfColumn("ROOM_SID");

						//int cnt = 1;
						for(int i=0; i<rows.length; i++){
							
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
														
								cstmt.setString(1, sSDate);
								cstmt.setString(2, sTDate);
								cstmt.setString(3, rows[i].getString(colNm_Room_Status));
								cstmt.setInt(4, 0);  
								cstmt.setInt(5, rows[i].getInt(colNm_Room_Sid));
								cstmt.setInt(6, 0);
								cstmt.setString(7, "");  
								cstmt.setString(8, fParamEmpno);
								cstmt.setString(9, fParamIp);
								cstmt.setString(10, "3");
								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);				
								
								//StringUtil.printMsg("평면도상태변경쿼리", cstmt.toString() , this);
								
								cstmt.executeUpdate();
								
								String r_s_yn		= cstmt.getString(11);
								String r_msg_cd	 	= cstmt.getString(12);
								String r_msg		= cstmt.getString(13);
								
								if(!r_s_yn.equals("Y"))
									throw new Exception(r_msg);
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(r_s_yn);
									row1.addColumnValue(r_msg_cd);
									row1.addColumnValue(r_msg);
									
									ds_result.addDataRow(row1);	
								}
								if(cstmt!=null) cstmt.close();
							}
						}
					}
					

					// 객실 수동  배정 - 상품숙박일 기준 
					if ("DS2".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
//CALL SALES.PR_RV740I_05 ('20061001','20061002',1973897, 488, 0,'2030004','172.16.1.23','3',NULL,NULL,NULL);						
						String sSDate 				= HDUtil.nullCheckStr(req.getParameter("sSDate"));	// 시작일자
						String sTDate 				= HDUtil.nullCheckStr(req.getParameter("sTDate"));	// 종료일자
						int sGoodSid				= HDUtil.nullCheckNum(req.getParameter("sGoodSid")); // 상품 SID
						int colNm_Rsv_Sid			= ds1.indexOfColumn("RSV_SID");
						int colNm_Room_Sid  		= ds1.indexOfColumn("ROOM_SID");
						
						//StringUtil.printMsg("시작일", sSDate, this);
						//StringUtil.printMsg("종료일", sTDate, this);
						//StringUtil.printMsg("상품아뒤", sGoodSid, this);
											
						//int cnt = 1;
						for(int i=0; i<rows.length; i++){
							
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
		
								//StringUtil.printMsg("예약sid==", rows[i].getInt(colNm_Rsv_Sid), this);
								//StringUtil.printMsg("름sid==", rows[i].getInt(colNm_Room_Sid), this);
								//StringUtil.printMsg("수동배정쿼리",arr_sql[3].toString(), this);
								cstmt = conn.prepareCall(arr_sql[3].toString());
														
								cstmt.setString(1, sSDate);
								cstmt.setString(2, sTDate);
								cstmt.setInt(3, rows[i].getInt(colNm_Rsv_Sid));
								cstmt.setInt(4, rows[i].getInt(colNm_Room_Sid));
								cstmt.setInt(5, 0);
								cstmt.setInt(6, sGoodSid);
								cstmt.setString(7, fParamEmpno);
								cstmt.setString(8, fParamIp);
								cstmt.setString(9, "3");
								cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);								
								
								cstmt.executeUpdate();
								
								String r_s_yn		= cstmt.getString(10);
								String r_msg_cd	 	= cstmt.getString(11);
								String r_msg		= cstmt.getString(12);
								
								if(!r_s_yn.equals("Y"))
									throw new Exception(r_msg);
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(r_s_yn);
									row1.addColumnValue(r_msg_cd);
									row1.addColumnValue(r_msg);
									
									ds_result.addDataRow(row1);	
								}
								if(cstmt!=null) cstmt.close();
							}
						}
					}
						
					
					
					
					// 인원 객실 배정  (자동배정)
					if ("DS3".equals(gauceName)) {
						//GauceDataRow[] 		rows = ds1.getDataRows();
						//GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate"));	// 시작일자
						String sAccept_no	= HDUtil.nullCheckStr(req.getParameter("sAccept_no")); // 신청서번호		
						int sGoodSid		= HDUtil.nullCheckNum(req.getParameter("sGoodSid")); // 상품 SID
						//int sHotel 			= HDUtil.nullCheckNum(req.getParameter("sUpjang"));	// 호텔
						String sClass 		= HDUtil.nullCheckStr(req.getParameter("sClass")); // 반
						String sTeam		= HDUtil.nullCheckStr(req.getParameter("sTeam")); // 조
						String sAssign_YN	= HDUtil.nullCheckStr(req.getParameter("sAssign_YN")); // 미배정자		
						String sFromType	= HDUtil.nullCheckStr(req.getParameter("sFromRoomType")); // 원객실타입
						String sToType		= HDUtil.nullCheckStr(req.getParameter("sToRoomType")); // 변경객실타입
						
						//int cnt = 1;
						////StringUtil.printMsg("쿼리",arr_sql[4].toString(), this);
						cstmt = conn.prepareCall(arr_sql[4].toString());
												
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sAccept_no);
						cstmt.setInt(3, sGoodSid);
						//cstmt.setInt(4, sHotel);
						cstmt.setString(4, sClass);
						cstmt.setString(5, sTeam);
						cstmt.setString(6, sAssign_YN);
						cstmt.setString(7, sFromType);
						cstmt.setString(8, sToType);
						cstmt.setString(9, fParamEmpno);
						cstmt.setString(10, fParamIp);
						cstmt.setString(11, "3");
						cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);								
						
						/*StringUtil.printMsg("1시작일", sSDate, this);
						StringUtil.printMsg("2신청서번호", sAccept_no, this);
						StringUtil.printMsg("3상품아뒤", sGoodSid, this);
						StringUtil.printMsg("4호텔", sHotel, this);
						StringUtil.printMsg("5반", sClass, this);
						StringUtil.printMsg("6조", sTeam, this);
						StringUtil.printMsg("7미배정자", sAssign_YN, this);
						StringUtil.printMsg("8원객실타입", sFromType, this);
						StringUtil.printMsg("9변경객실타입", sToType, this);						
						StringUtil.printMsg("10empno", fParamEmpno, this);
						StringUtil.printMsg("11ip", fParamIp, this);*/
												
						cstmt.executeUpdate();
						
						String r_s_yn		= cstmt.getString(12);
						String r_msg_cd	 	= cstmt.getString(13);
						String r_msg		= cstmt.getString(14);
						
						if(!r_s_yn.equals("Y"))
							throw new Exception(r_msg);
						
						if(ds_result!=null){
							GauceDataRow row1 = ds_result.newDataRow();
							row1.addColumnValue(r_s_yn);
							row1.addColumnValue(r_msg_cd);
							row1.addColumnValue(r_msg);
							
							ds_result.addDataRow(row1);	
						}
						if(cstmt!=null) cstmt.close();
					}	

					
					// 객실 수동  배정 - 숙박기간 기준 
					if ("DS4".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();

						String sSDate 				= HDUtil.nullCheckStr(req.getParameter("sSDate"));	// 시작일자
						String sTDate 				= HDUtil.nullCheckStr(req.getParameter("sTDate"));	// 종료일자
						int sGoodSid				= HDUtil.nullCheckNum(req.getParameter("sGoodSid")); // 상품 SID
						int colNm_Rsv_Sid			= ds1.indexOfColumn("RSV_SID");
						int colNm_Room_Sid  		= ds1.indexOfColumn("ROOM_SID");
						
						//StringUtil.printMsg("시작일", sSDate, this);
						//StringUtil.printMsg("종료일", sTDate, this);
						//StringUtil.printMsg("상품아뒤", sGoodSid, this);
											
						//int cnt = 1;
						for(int i=0; i<rows.length; i++){
							
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
		
								//StringUtil.printMsg("예약sid==", rows[i].getInt(colNm_Rsv_Sid), this);
								//StringUtil.printMsg("름sid==", rows[i].getInt(colNm_Room_Sid), this);
								//StringUtil.printMsg("수동배정쿼리",arr_sql[5].toString(), this);
								cstmt = conn.prepareCall(arr_sql[5].toString());
														
								cstmt.setString(1, sSDate);
								cstmt.setString(2, sTDate);
								cstmt.setInt(3, rows[i].getInt(colNm_Rsv_Sid));
								cstmt.setInt(4, rows[i].getInt(colNm_Room_Sid));
								cstmt.setInt(5, 0);
								cstmt.setInt(6, sGoodSid);
								cstmt.setString(7, fParamEmpno);
								cstmt.setString(8, fParamIp);
								cstmt.setString(9, "3");
								cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);								
								
								cstmt.executeUpdate();
								
								String r_s_yn		= cstmt.getString(10);
								String r_msg_cd	 	= cstmt.getString(11);
								String r_msg		= cstmt.getString(12);
								
								if(!r_s_yn.equals("Y"))
									throw new Exception(r_msg);
								
								if(ds_result!=null){
									GauceDataRow row1 = ds_result.newDataRow();
									row1.addColumnValue(r_s_yn);
									row1.addColumnValue(r_msg_cd);
									row1.addColumnValue(r_msg);
									
									ds_result.addDataRow(row1);	
								}
								if(cstmt!=null) cstmt.close();
							}
						}
					}
					
					
				}
			}		
		} catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}	

	}

}
