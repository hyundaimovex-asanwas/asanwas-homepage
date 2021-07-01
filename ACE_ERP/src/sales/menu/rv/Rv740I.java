package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;


public class Rv740I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//평면도 객실상태 조회
		arr_sql[0].append("{call SALES.PR_RV740I_01 (?, ?, ?, ? ) }");
		
		// 평면도 객실 상태 변경 
		arr_sql[2].append("{call SALES.PR_RV740I_04 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");		
		//CALL SALES.PR_RV740I_04 ('20061001','20061002','IV',0,487,0,'','2030004','172.16.1.23','3',NULL,NULL,NULL);		
		
		
		// 객실 수동  배정- 상품숙박일 기준 
		arr_sql[3].append("{call SALES.PR_RV740I_05 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
		//CALL SALES.PR_RV740I_05 ('20061001','20061002',1973897, 488, 0, 28, '2030004','172.16.1.23','3',NULL,NULL,NULL);
		
		
		// 자동배정
		arr_sql[4].append("{call SALES.PR_RV740I_07 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		// 객실 수동  배정- 숙박기간 기준
		arr_sql[5].append("{call SALES.PR_RV740I_06 (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");

		// 객실상태 요약 조회
		arr_sql[6].append("{call SALES.PR_RV740I_02 (?, ?, ?,? ) }");		

		  // 고객정보 조회
		arr_sql[7].append("{call SALES.PR_RV740I_03 (?,?,?,?,?,   ?,?, ? ) }");

	}
 
	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String[] columnName = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
			/* 검색시 필요한 조건 */
			String sSDate 		= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// 일자
			String sTDate 		= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// 일자 
			int sHotel 			= HDUtil.nullCheckNum(greq.getParameter("sUpjang"));	// 호텔 
			String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("sAccept_no")); // 신청서번호		
			int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // 상품 SID
			String sClass 		= HDUtil.nullCheckStr(greq.getParameter("sClass")); // 반
			String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam")); // 조 
			String sAssign_YN	= HDUtil.nullCheckStr(greq.getParameter("sAssign_YN")); // 미배정자
			String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel")); // 고객구분
			
			/*StringUtil.printMsg("sSDATE - ", sSDate, this);
			StringUtil.printMsg("sTDATE - ", sTDate, this);
			StringUtil.printMsg("HOTEL - ", sHotel, this);
			StringUtil.printMsg("Accept_no - ", sAccept_no, this);
			StringUtil.printMsg("GoodSid - ", sGoodSid, this);
			StringUtil.printMsg("Class - ", sClass, this);
			StringUtil.printMsg("Team - ", sTeam, this);		
			StringUtil.printMsg("sAssign_YN - ", sAssign_YN, this);*/		
			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//StringUtil.printMsg("객실상태조회 쿼리",arr_sql[0].toString(), this);
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, sHotel);	//IN    pUPJANG_SID  NUMERIC(10),  -- 영업장 SID
					cstmt.setString(2, sSDate);	//IN    pBGN_DATE    VARCHAR(8),   -- 시작일자
					cstmt.setString(3, sTDate);	//IN    pEND_DATE    VARCHAR(8)   -- 종료일자
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            	if(dSets[i].getName().equals("ds2")){	//하단 고객정보 그리드
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[7].toString());
					cstmt.setString(1, sSDate);		// 시작일자
					cstmt.setString(2, sAccept_no);	// 신청서번호						
					cstmt.setInt   (3, sGoodSid);	// 상품 SID
					cstmt.setString(4, sClass);		// 반
					cstmt.setString(5, sTeam);		// 조
					cstmt.setString(6, sAssign_YN);	// 미배정
					cstmt.setString(7, sJobsel);	// 고객국분						
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            	if(dSets[i].getName().equals("ds3")){	//요약정보 조회
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[6].toString());
					cstmt.setInt(1, sHotel);	//IN    pUPJANG_SID  NUMERIC(10),  -- 영업장 SID
					cstmt.setString(2, sSDate);	//IN    pBGN_DATE    VARCHAR(8),   -- 시작일자
					cstmt.setString(3, sTDate);	//IN    pEND_DATE    VARCHAR(8)   -- 종료일자
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}

            }

		}catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
	//		res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(conn!=null) conn.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE","업데이트",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet ds3 = gis.read("DS3");
		GauceDataSet ds4 = gis.read("DS4");
		GauceDataSet ds_result = gis.read("RESULT");
		try {
			//객실 상태 저장 JSP(I:DS1=ds1,O:RESULT=ds_result
			//객실 수동배정 (상품 숙박일 기준)	JSP(I:DS2=ds2,O:RESULT=ds_result
			//객실 수동배정 (숙박기간 기준)		JSP(I:DS4=ds2,O:RESULT=ds_result
			//자동배정							JSP(I:DS3=ds2,O:RESULT=ds_result
			
			
			//메시지처리
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}


			// 평면도 상태 변경			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				//CALL SALES.PR_RV740I_04 ('20061001','20061002','IV',0,487,0,'','2030004','172.16.1.23','3',NULL,NULL,NULL);
				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// 시작일자
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// 종료일자
				int colNm_Room_Status		= ds1.indexOfColumn("ROOM_STATUS");
				int colNm_Room_Sid  		= ds1.indexOfColumn("ROOM_SID");

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
							ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
							ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
							ds_result.heap();								
						}
						if(cstmt!=null) cstmt.close();
					}
				}
			}
					
			// 객실 수동  배정 - 상품숙박일 기준			
			if (ds2 != null) {
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// 시작일자
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// 종료일자
				int sGoodSid				= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // 상품 SID
				int colNm_Rsv_Sid			= ds2.indexOfColumn("RSV_SID");
				int colNm_Room_Sid  		= ds2.indexOfColumn("ROOM_SID");
				//StringUtil.printMsg("시작일", sSDate, this);
				//StringUtil.printMsg("종료일", sTDate, this);
				//StringUtil.printMsg("상품아뒤", sGoodSid, this);				
				
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
							ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
							ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
							ds_result.heap();			
						}
						if(cstmt!=null) cstmt.close();
					}
				}				
			}
			
			// 인원 객실 배정  (자동배정)
			if (ds3 != null) {
				String sSDate 		= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// 시작일자
				String sAccept_no	= HDUtil.nullCheckStr(greq.getParameter("sAccept_no")); // 신청서번호		
				int sGoodSid		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // 상품 SID
				//int sHotel 			= HDUtil.nullCheckNum(req.getParameter("sUpjang"));	// 호텔
				String sClass 		= HDUtil.nullCheckStr(greq.getParameter("sClass")); // 반
				String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam")); // 조
				String sAssign_YN	= HDUtil.nullCheckStr(greq.getParameter("sAssign_YN")); // 미배정자		
				String sFromType	= HDUtil.nullCheckStr(greq.getParameter("sFromRoomType")); // 원객실타입
				String sToType		= HDUtil.nullCheckStr(greq.getParameter("sToRoomType")); // 변경객실타입
				
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
					ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
					ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
					ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
					ds_result.heap();
				}
				if(cstmt!=null) cstmt.close();				
			}

			// 객실 수동  배정 - 숙박기간 기준 
			if (ds4 != null) {
				GauceDataRow[] 		rows = ds4.getDataRows();
				GauceDataColumn[] 	cols = ds4.getDataColumns();

				String sSDate 				= HDUtil.nullCheckStr(greq.getParameter("sSDate"));	// 시작일자
				String sTDate 				= HDUtil.nullCheckStr(greq.getParameter("sTDate"));	// 종료일자
				int sGoodSid				= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); // 상품 SID
				int colNm_Rsv_Sid			= ds4.indexOfColumn("RSV_SID");
				int colNm_Room_Sid  		= ds4.indexOfColumn("ROOM_SID");
			
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
							ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
							ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
							ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
							ds_result.heap();	
						}
						if(cstmt!=null) cstmt.close();
					}
				}
			
			}
			
			if(ds_result!=null) gos.write(ds_result);
			gos.close();		
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	

	}

}
