package sales.menu.rm;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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
import sales.common.HDConstant;

public class Rm040I extends SuperServlet {

    /**
	 * [20170307] 영업장 조회 조건에서 '전체' 주석처리.. 지역조건을 가져오지 않으므로 무조건 1개 영업장은 선택되자^^
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//사업소
		arr_sql[0].append ("SELECT										\n")
		  			.append ("	SAUP_SID,     \n")
		  			.append ("	SAUP_NM     \n")		  			
		  			.append ("FROM SALES.TSY200                       \n")
		  			.append ("ORDER BY SAUP_SID                        \n");
		
		//영업장
		arr_sql[1].append ("SELECT										\n")
					//.append ("	0 UPJANG_SID, '전체' UPJANG_NM    \n")
					//.append ("FROM DUAL                       \n")
					//.append ("UNION ALL                                   \n")		
					//.append ("SELECT											\n")		
		  			.append ("	UPJANG_SID,     \n")
		  			.append ("	UPJANG_NM     \n")		  			
		  			.append ("FROM SALES.TRM010                       \n")
		  			.append ("WHERE USE_YN='Y' AND UPJANG_TYPE='10'               \n");	

		//객실타입
		arr_sql[2].append ("SELECT										\n")
					.append ("	0 ROOM_TYPE_SID, '전체' ROOM_TYPE_CD, 0 DISPLAY_SEQ    \n")
		  			.append ("FROM DUAL                       \n")
		  			.append ("UNION ALL                                   \n")		
		  			.append ("SELECT 															\n")                                    
					.append ("		ROOM_TYPE_SID,                       															\n")                
					.append ("		ROOM_TYPE_CD,                                      											\n")
					.append ("		DISPLAY_SEQ                                      											\n")					
					.append ("FROM SALES.TRM030															\n")
					.append ("WHERE USE_YN='Y'															\n");
	
		//전망코드
		arr_sql[3].append ("SELECT													\n")
					.append ("			HEAD,												\n")
					.append ("			DETAIL,												\n")
					.append ("			DETAIL_NM										\n")
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='RM002'											\n");
		
		//객실정보 조회
		arr_sql[4].append ("SELECT UPJANG_SID,															\n")
					.append ("			SALES.FN_UPJANG_NM(UPJANG_SID, '') AS UPJANG_NM,			\n")
					.append ("			DONG_SID,			\n")					
					.append ("			ROOM_TYPE_SID,			\n")
					.append ("			ROOM_SID,			\n")
					.append ("			SALES.FN_ROOM_TYPE_CD(ROOM_TYPE_SID) AS ROOM_TYPE_CD,			\n")
					.append ("			SALES.FN_ROOM_TYPE_NM(ROOM_TYPE_SID,'') AS ROOM_TYPE_NM,			\n")					
					.append ("			ROOM_NO,			\n")				
					.append ("			BGN_DATE,			\n")					
					.append ("			END_DATE,			\n")
					.append ("			ROOM_VIEW_CD,			\n")
					.append ("			SALES.FN_DETAIL_NM('RM002', ROOM_VIEW_CD) AS ROOM_VIEW_NM,			\n")
					.append ("			FLOORS,			\n")
					.append ("			CASE WHEN USE_YN='Y' THEN 'T' ELSE 'F' END USE_YN,			\n")
					.append ("			REMARKS,			\n")
					.append ("			PLAN_IDX			\n")
					.append ("FROM SALES.TRM040			\n")
					.append ("WHERE 1=1							\n");
		
		//객실정보 입력
		arr_sql[5].append ("INSERT INTO SALES.TRM040							\n")
					.append ("(				ROOM_NO, 							\n")
					.append ("				BGN_DATE, 							\n")
					.append ("				END_DATE, 							\n")
					.append ("				ROOM_VIEW_CD, 							\n")
					.append ("				FLOORS, 							\n")
					.append ("				USE_YN, 							\n")					
					.append ("				UPJANG_SID, 							\n")
					.append ("				ROOM_TYPE_SID, 							\n")
					.append ("				DONG_SID, 							\n")
					.append ("				REMARKS, 							\n")					
					.append ("				U_EMPNO, 							\n")
					.append ("				U_IP			)							\n")
					.append ("VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )		\n");
		
		//객실정보 수정
		arr_sql[6].append ("UPDATE SALES.TRM040						\n")
					.append ("	SET 	ROOM_NO        = ?,						\n")
					.append ("			BGN_DATE       = ?,						\n")
					.append ("			END_DATE       = ?,						\n")
					.append ("			ROOM_VIEW_CD   = ?,						\n")
					.append ("			FLOORS         = ?,						\n")
					.append ("			USE_YN         = ?,						\n")
					.append ("			REMARKS		= ?, 						\n")					
					.append ("			U_EMPNO        = ?,						\n")
					.append ("			U_DATE         = SYSTIMESTAMP,			\n")
					.append ("			U_IP           = ?,						\n")
					.append ("			PLAN_IDX           = ?					\n")
					.append ("WHERE ROOM_SID       = ?							\n");
		
		//객실정보 삭제
		arr_sql[7].append ("DELETE FROM SALES.TRM040 WHERE ROOM_SID = ?			\n");	
		
		//동정보
		arr_sql[8].append ("SELECT										\n")
					.append ("	0 DONG_SID, '' DONG_CD, '전체' DONG_NM    \n")
					.append ("FROM DUAL                       \n")
		  			.append ("UNION ALL                                   \n")					
		        	.append ("SELECT										\n")
		  			.append ("	DONG_SID,     \n")
		  			.append ("	DONG_CD,     \n")		  			
		  			.append ("	DONG_NM     \n")		  			
		  			.append ("FROM SALES.TRM020                       \n")
					.append ("WHERE 1=1                       \n");		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String sUpjangSid = HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));		
		String sHead = HDUtil.nullCheckStr(greq.getParameter("sHead"));		
		StringUtil.printMsg(" sUpjangSid",sUpjangSid, this);		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
    			//DS2=ds2 DS3=ds3 DS5=ds5,O:DS_DONG=ds_dong
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					if (!"".equals(sSaupSid) && !"0".equals(sSaupSid)) {
						arr_sql[1].append("AND saup_sid= ? 			\n");
						arr_sql[1].append("ORDER BY  upjang_sid 	\n");
					}
					cstmt = conn.prepareCall(arr_sql[1].toString());
					if (!"".equals(sSaupSid) && !"0".equals(sSaupSid))
						cstmt.setString(1, sSaupSid);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds4")){
					GauceDataSet ds1 = gis.read("DS4");
					if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
						arr_sql[2].append("AND UPJANG_SID = ?										\n");
					arr_sql[2].append ("ORDER BY DISPLAY_SEQ													\n");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					//StringUtil.printMsg("객실타입 부르는 쿼리== ",arr_sql[2].toString(),this);	
					if ( !sUpjangSid.equals("") && !sUpjangSid.equals("0") )
						cstmt.setInt(1, Integer.parseInt(sUpjangSid) );					
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds5")){
					GauceDataSet ds1 = gis.read("DS5");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_dong")){
					GauceDataSet ds1 = gis.read("DS_DONG");
					if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid)) {
						arr_sql[8].append("AND UPJANG_SID = ? 			\n");
					}
					arr_sql[8].append ("ORDER BY DONG_SID													\n");									
					cstmt = conn.prepareCall(arr_sql[8].toString());
					if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid))
						cstmt.setString(1, sUpjangSid);	
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            }
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	
	}	
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("# Command","조회",this);		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		try {
			// 검색시 조건
			String 	sUpjangSid		= HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));
			String 	sRoomTypeSid	= HDUtil.nullCheckStr(greq.getParameter("sRoomTypeSid"));
			
			
			StringUtil.printMsg(" sUpjangSid 값===",sUpjangSid,this);
			StringUtil.printMsg(" sRoomTypeSid 값==",sRoomTypeSid,this);
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid)) 
						arr_sql[4].append (" AND UPJANG_SID = ? \n");
					if (!"".equals(sRoomTypeSid) && !"0".equals(sRoomTypeSid))							
						arr_sql[4].append (" AND ROOM_TYPE_SID = ? \n");
					arr_sql[4].append (" ORDER BY UPJANG_SID, DONG_SID, ROOM_TYPE_SID, TO_NUMBER(ROOM_NO) \n");
					//StringUtil.printMsg("메인 결과 조회 쿼리== ",arr_sql[4].toString(),this);	
					cstmt = conn.prepareCall(arr_sql[4].toString());
					if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid))
						cstmt.setString(1, sUpjangSid);
					if (!"".equals(sRoomTypeSid) && !"0".equals(sRoomTypeSid))
						cstmt.setString(2, sRoomTypeSid);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            }
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
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
        
		String 	sUpjangSid	= HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));
		String 	sRoomTypeSid	= HDUtil.nullCheckStr(greq.getParameter("sRoomTypeSid"));
		/* DataSet */
		GauceDataSet inputDs = gis.read("DS1");
		try{
			if(inputDs!=null){

				int colNm_UpjangSid             = inputDs.indexOfColumn("UPJANG_SID");
				int colNm_RoomTypeSid           = inputDs.indexOfColumn("ROOM_TYPE_SID");
				int colNm_RoomSid               = inputDs.indexOfColumn("ROOM_SID");
				int colNm_RoomNo                = inputDs.indexOfColumn("ROOM_NO");
				int colNm_BgnDate               = inputDs.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = inputDs.indexOfColumn("END_DATE");
				int colNm_RoomView_cd           = inputDs.indexOfColumn("ROOM_VIEW_CD");
				int colNm_RoomView_nm           = inputDs.indexOfColumn("ROOM_VIEW_NM");
				int colNm_Floors                = inputDs.indexOfColumn("FLOORS");
				int colNm_UseYn                 = inputDs.indexOfColumn("USE_YN");
				int colNm_DongSid               = inputDs.indexOfColumn("DONG_SID");
				int colNm_Remarks               = inputDs.indexOfColumn("REMARKS");				
				int colNm_Plan_idx              = inputDs.indexOfColumn("PLAN_IDX");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("arr_sql[5]",arr_sql[5].toString(),this);		
						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_RoomNo));
						cstmt.setString(2, rows[i].getString(colNm_BgnDate));
						cstmt.setString(3, rows[i].getString(colNm_EndDate));
						cstmt.setString(4, rows[i].getString(colNm_RoomView_cd));
						cstmt.setString(5, rows[i].getString(colNm_Floors));
						if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							cstmt.setString(6, "Y");
						} else {
							cstmt.setString(6, "N");
						}
						cstmt.setInt(7, rows[i].getInt(colNm_UpjangSid));
						cstmt.setInt(8, rows[i].getInt(colNm_RoomTypeSid));
						cstmt.setInt(9, rows[i].getInt(colNm_DongSid));
						cstmt.setString(10, rows[i].getString(colNm_Remarks));
						cstmt.setString(11, fParamEmpno);
						cstmt.setString(12, fParamIp);
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("arr_sql[6]",arr_sql[6].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[6].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_RoomNo));
						cstmt.setString(2, rows[i].getString(colNm_BgnDate));
						cstmt.setString(3, rows[i].getString(colNm_EndDate));
						cstmt.setString(4, rows[i].getString(colNm_RoomView_cd));
						cstmt.setString(5, rows[i].getString(colNm_Floors));
						if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							cstmt.setString(6, "Y");
						} else {
							cstmt.setString(6, "N");
						}
						cstmt.setString(7, rows[i].getString(colNm_Remarks));
						cstmt.setString(8, fParamEmpno);
						cstmt.setString(9, fParamIp);
						cstmt.setInt(10, rows[i].getInt(colNm_Plan_idx));
						cstmt.setInt(11, rows[i].getInt(colNm_RoomSid));
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("arr_sql[7]",arr_sql[7].toString(),this);						
						cstmt = conn.prepareCall(arr_sql[7].toString());
						cstmt.setInt(1, rows[i].getInt(colNm_RoomSid));
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
						break;						
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(stmt!=null) stmt.close();
		}
	}

}
