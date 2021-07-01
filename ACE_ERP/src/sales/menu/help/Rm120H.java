package sales.menu.help;

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



public class Rm120H extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		//  조회 
		arr_sql[0].append("{call SALES.PR_RM120S_02(?, ?, ?, ?, ?) }"); //상태, 룸SID, 이용시작일자, 이용종료일자

		//  저장 (추가/삭제)
		//'20080224','20101231','OO',0, 423  ,0,'판매자제','2030004','172.16.1.23','1',NULL,NULL,NULL
		//투숙시작, 투숙종료, 상태, 예약번호,룸SID,순번SEQ,참고,수정사번,수정IP,편집상태,성공Y/N,메세지코드,메세지
		arr_sql[1].append("{CALL SALES.PR_RV740I_04 (?, ?, ?, ?, ?, ?, ? ,?, ?, ?, ?, ?, ?)}");
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

		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
	
		/* 검색시 필요한 조건 */
		
		String	sRoomStatus = HDUtil.nullCheckStr(greq.getParameter("sRoomStatus")); // 방상태 
		int 	sRoomSid	= HDUtil.nullCheckNum(greq.getParameter("sRoomSid")); 	// 방sid
		String	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate")); 	// 사용시작일자 
		String	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate")); 	// 사용종료일
		
		
		try {
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sRoomStatus);
					cstmt.setInt(2, sRoomSid);
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sEndDate);
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            }
            
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 		= gis.read("DS1");
		GauceDataSet ds_result 	= gis.read("RESULT");
		
		try{
			//내부 변수
			String v_edit_styatus = "";	//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
			String v_send_id 	= "";
			String r_s_yn		= "";	//Return Status Yn
			String r_msg_cd		= "";	//Return Message Code
			String r_msg		= ""; 	//Return message
			
					
			if(ds_result!=null){
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			GauceDataRow[] 		rows = ds1.getDataRows();
				
			int colNm_BGN_DATE	 		= ds1.indexOfColumn("BGN_DATE");	//'고장 시작' 
			int colNm_END_DATE	 		= ds1.indexOfColumn("END_DATE");    //'고장 종료' 
			int colNm_REMARKS	   		= ds1.indexOfColumn("REMARKS");     //'사유'			
			int colNm_EMP_NM	 		= ds1.indexOfColumn("EMP_NM");      //'등록자'		
			int colNm_ROOM_SID	 		= ds1.indexOfColumn("ROOM_SID");    //'룸SID'		  
			int colNm_KEY_SEQ	   		= ds1.indexOfColumn("KEY_SEQ");     //'키'				
			int colNm_ROOM_STATUS		= ds1.indexOfColumn("ROOM_STATUS"); //'상태'			
			
			//StringUtil.printMsg("로우즈",rows.length, this);
			for(int i=0; i<rows.length; i++){
				if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
					v_edit_styatus = "1";
				} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
					v_edit_styatus = "2";
				} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
					v_edit_styatus = "3";
				}
				//StringUtil.printMsg("for문 안","", this);
				
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setString        (1, rows[i].getString(colNm_BGN_DATE));		//사용시작일자
				//StringUtil.printMsg("1::::::::::::", rows[i].getString(colNm_BGN_DATE), this);
				cstmt.setString        (2, rows[i].getString(colNm_END_DATE));		//사용종료일자
				//StringUtil.printMsg("2::::::::::::", rows[i].getString(colNm_END_DATE), this);
				cstmt.setString     (3, rows[i].getString(colNm_ROOM_STATUS));	//객실상태 : 'OO'임..
				//StringUtil.printMsg("3::::::::::::", rows[i].getString(colNm_ROOM_STATUS), this);
				cstmt.setInt        (4, 0);										//RSV_SID : 무관함.
				cstmt.setInt        (5, rows[i].getInt(colNm_ROOM_SID));		//객실sid
				//StringUtil.printMsg("5::::::::::::", rows[i].getInt(colNm_ROOM_SID), this);
				cstmt.setInt        (6, rows[i].getInt(colNm_KEY_SEQ));			//key_seq
				//StringUtil.printMsg("6::::::::::::", rows[i].getInt(colNm_KEY_SEQ), this);
				cstmt.setString     (7, rows[i].getString(colNm_REMARKS));		//참고사항(고장사유)
				cstmt.setString     (8, fParamEmpno);							//수정사번
				cstmt.setString     (9, fParamIp);								//수정ip
				cstmt.setString     (10, v_edit_styatus);						//편집상태
				//StringUtil.printMsg("10::::::::::::", v_edit_styatus, this);
				cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);

				cstmt.executeUpdate();

				r_s_yn 		= cstmt.getString(11);
				r_msg_cd 	= cstmt.getString(12);
				r_msg 		= cstmt.getString(13);

				if(!r_s_yn.equals("Y")){
					throw new Exception (r_msg);
				}
				
				if(ds_result!=null){
					ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
					ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
					ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
					ds_result.heap();			
				}
				
				if(ds_result!=null) gos.write(ds_result);
							
			};//for(int i=0; i<row.length; i++){
	
			
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{		
		
	};//public void apply

}


