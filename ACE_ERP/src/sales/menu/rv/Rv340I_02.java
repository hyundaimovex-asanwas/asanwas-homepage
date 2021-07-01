package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv340I_02 extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

			//조회
			arr_sql[0].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");

			//입금조회(계좌조회)
			arr_sql[1].append (" {call SALES.PR_RV340i_01 (?, ?, ?)}");
		
			arr_sql[2].append (" {call SALES.PR_RV340i_02 (?, ?, ?)}");
			 /* 
			 
			// 입금조회(신용카드)
			arr_sql[2].append (" {call SALES.PR_RV330S_02(?,?,?,?,?)} ");

			// 입금조회(기타대체 입금)
			arr_sql[3].append (" {call SALES.PR_RV330S_04(?,?)} ");		
			
			// 입금조회(무통장)
			arr_sql[4].append (" {call SALES.PR_RV330S_05(?,?,?,?)} ");		
			
			
			//수정 요			
			//저장 : 대체액 저장 : rsv_sid, pay_date, pay_manage_no, upjang_sid, client_sid, 17개
			arr_sql[5].append ("{call SALES.PR_RM620I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
			*/
			
			
	}

/*
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 	= null;
		PreparedStatement 	stmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		
		
		//StringUtil.printMsg("select Method==", "ㅋㅋㅋ111111", this);		
	
		try{
			//6개 파라미터를 받아와서
			String 	v_fr_date	 		= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		//출발일자
			String 	v_to_date	 		= HDUtil.nullCheckStr(req.getParameter("v_to_date"));		//도착일자
			String 	v_manage_no		= HDUtil.nullCheckStr(req.getParameter("v_manage_no"));	//주민등록번호
			
			
			//6개 파마리터를 로그에 찍어보고...
			StringUtil.printMsg("22222v_fr_date==", v_fr_date, this);
			StringUtil.printMsg("22222v_to_date==",v_to_date, this);
			StringUtil.printMsg("22222v_manage_no==", v_manage_no, this);
			
			
			//StringUtil.printMsg("와섭 조회", "what's up?", this);
			
			 Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				StringUtil.printMsg("어떤 데이터셋?", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER")){
						String temp_sql = arr_sql[0].toString();
						temp_sql = StringUtil.strReplace(temp_sql, "$1", v_fr_date);
						temp_sql = StringUtil.strReplace(temp_sql, "$2", v_to_date);
						
						stmt = conn.getGauceStatement(temp_sql);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>31){
								res.writeException("ERROR", "0000", "기간을 한달이내로 하시길 바랍니다.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "기간내의 일자를 계산하는중 오류가 발생했습니다.");
							break;
						}
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();
						
			
			
												
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString (1, v_fr_date);
						cstmt.setString (2, v_to_date);
						cstmt.setString	(3, v_manage_no);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
						
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
					} 
				  
				}
			}
		}
		
		 catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
*/	  
	  
	

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 	= null;
		PreparedStatement 	stmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		
		try{
			//6개 파라미터를 받아와서
			String 	v_fr_date2	 		= HDUtil.nullCheckStr(req.getParameter("v_fr_date2"));		//출발일자
			String 	v_to_date2	 		= HDUtil.nullCheckStr(req.getParameter("v_to_date2"));		//도착일자
			String 	v_manage_no2		= HDUtil.nullCheckStr(req.getParameter("v_manage_no2"));	//주민등록번호
			
			
			//6개 파마리터를 로그에 찍어보고...
			StringUtil.printMsg("22222_v_fr_date2==", v_fr_date2, this);
			StringUtil.printMsg("22222_v_to_date2==",v_to_date2, this);
			StringUtil.printMsg("22222_v_manage_no2==", v_manage_no2, this);
			
			
			//StringUtil.printMsg("와섭 조회", "what's up?", this);
			
			 Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				StringUtil.printMsg("어떤 데이터셋?", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER2")){
						String temp_sql2 = arr_sql[0].toString();
						temp_sql2 = StringUtil.strReplace(temp_sql2, "$1", v_fr_date2);
						temp_sql2 = StringUtil.strReplace(temp_sql2, "$2", v_to_date2);
						
						stmt = conn.getGauceStatement(temp_sql2);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>31){
								res.writeException("ERROR", "0000", "기간을 한달이내로 하시길 바랍니다.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "기간내의 일자를 계산하는중 오류가 발생했습니다.");
							break;
						}
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();
						
			
			
												
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString (1, v_fr_date2);
						cstmt.setString (2, v_to_date2);
						cstmt.setString	(3, v_manage_no2);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
						
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
					} 
				  
				}
			}
		}
		
		 catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	     
	
	
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
	throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}
	
	

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

		CallableStatement 	cstmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		GauceDataSet 		msgDS 	= null;
		
		String v_edit_status = "";
		
		String r_s_yn = "";
		String r_msg_cd = "";
		String r_msg = "";

		
		//StringUtil.printMsg("와섭? 저장", "what's up?", this);
		try{
			ds1 = req.getGauceDataSet("DETAIL");
			msgDS = req.getGauceDataSet("msgDS");
			if(ds1!=null){
				if(msgDS!=null){
					res.enableFirstRow(msgDS);
					msgDS.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					msgDS.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					msgDS.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();

				int colNm_RSV_SID					= ds1.indexOfColumn("RSV_SID");
				int colNm_BLOCK_SID     			= ds1.indexOfColumn("BLOCK_SID");
				int colNm_PAY_DATE      			= ds1.indexOfColumn("PAY_DATE");
				int colNm_PAY_AMT       			= ds1.indexOfColumn("PAY_AMT");
				int colNm_PAY_CD        			= ds1.indexOfColumn("PAY_CD");
				int colNm_PAY_MANAGE_NO 			= ds1.indexOfColumn("PAY_MANAGE_NO");
				int colNm_CLIENT_SID    			= ds1.indexOfColumn("CLIENT_SID");
				int colNm_UPJANG_SID    			= ds1.indexOfColumn("UPJANG_SID");

				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = 1+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = 2+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = 3+"";
					
					cstmt = conn.prepareCall(arr_sql[4].toString());

					cstmt.setInt(1, row[i].getInt(colNm_RSV_SID));				//예약 SID
					//StringUtil.printMsg("1", row[i].getInt(colNm_RSV_SID), this);
					cstmt.setInt(2, row[i].getInt(colNm_BLOCK_SID));			//블록 SID
					//StringUtil.printMsg("2", row[i].getInt(colNm_BLOCK_SID), this);
					cstmt.setString(3, row[i].getString(colNm_PAY_DATE));	//신청일자
					//StringUtil.printMsg("3", row[i].getString(colNm_PAY_DATE), this);
					cstmt.setString(4, row[i].getString(colNm_PAY_DATE));	//입금경예정일자
					//StringUtil.printMsg("4", row[i].getString(colNm_PAY_DATE), this);
					cstmt.setString(5, row[i].getString(colNm_PAY_DATE));		//결재일자
					//StringUtil.printMsg("5", row[i].getString(colNm_PAY_DATE), this);
					cstmt.setInt(6, row[i].getInt(colNm_PAY_AMT));				//대체금액
					//StringUtil.printMsg("6", row[i].getInt(colNm_PAY_AMT), this);
					cstmt.setString(7, "Y");									//결재여부(다른 것이면 Y)
					cstmt.setString(8, "100");									//입금결재코드 : 보증급="100"
					cstmt.setString(9, row[i].getString(colNm_PAY_MANAGE_NO) );	//결제관리번호
					//StringUtil.printMsg("9", row[i].getString(colNm_PAY_MANAGE_NO), this);
					cstmt.setInt(10, row[i].getInt(colNm_CLIENT_SID));		//매출처 SID
					//StringUtil.printMsg("10", row[i].getInt(colNm_CLIENT_SID), this);
					cstmt.setInt(11, row[i].getInt(colNm_UPJANG_SID));		//업장SID
					//StringUtil.printMsg("11", row[i].getInt(colNm_UPJANG_SID), this);
					cstmt.setString(12, fParamEmpno);
					cstmt.setString(13, fParamIp);
					cstmt.setString(14, v_edit_status);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					r_s_yn 		= cstmt.getString(15);
					r_msg_cd 	= cstmt.getString(16);
					r_msg 		= cstmt.getString(17);
//StringUtil.printMsg("r_s_yn", r_s_yn, this);
//StringUtil.printMsg("r_msg_cd", r_msg_cd, this);
//StringUtil.printMsg("r_msg", r_msg, this);
					if(r_s_yn.equals("N")){
						throw new Exception(r_msg);
					}
					
					if(msgDS!=null){
						GauceDataRow row1 = msgDS.newDataRow();
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						msgDS.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
				if(msgDS!=null)
					msgDS.flush();
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
			}
			catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
			}
			 finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
			}
		}
	}



