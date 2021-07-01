package sales.menu.rm;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
 
import oracle.jdbc.OracleTypes;

public class Rm040S extends SuperServlet {

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
					.append ("	0 UPJANG_SID, '전체' UPJANG_NM    \n")
					.append ("FROM DUAL                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT											\n")		
		  			.append ("	UPJANG_SID,     \n")
		  			.append ("	UPJANG_NM     \n")		  			
		  			.append ("FROM SALES.TRM010                       \n")
		  			.append ("WHERE UPJANG_TYPE='10'               \n");	

		//객실타입
		arr_sql[2].append ("SELECT													\n")
					.append ("	''		HEAD,												\n")
					.append ("	''		DETAIL,												\n")
					.append ("	'전체'	DETAIL_NM										\n")
					.append ("FROM DUAL                       \n")
				    .append ("UNION ALL                                   \n")
				    .append ("SELECT										\n" )
				    .append (" 			HEAD,DETAIL,DETAIL_NM				\n"	 )
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='SY011'											\n");
		
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
		arr_sql[4].append("SELECT 												\n")
					.append("       T3.UPJANG_CD                 /* 업장코드       */						\n")
					.append("      ,T3.UPJANG_NM                 /* 업장명         */						\n")
					.append("      ,T1.FLOORS                    /* 객실층         */						\n")
					.append("      ,T1.ROOM_NO                   /* 객실번호       */						\n")
					.append("      ,T2.ROOM_TYPE_CD              /* 객실타입        */						\n")
					.append("      ,T2.ROOM_TYPE_NM              /* 객실타입명      */						\n")
					.append("      ,SALES.FN_DETAIL_NM ( 'RM002',T1.ROOM_VIEW_CD) AS ROOM_VIEW_NM   /* 객실전망:RM002 */		\n")
					.append("      ,SALES.FN_DETAIL_NM ( 'RM004',T1.ROOM_STATUS)   AS ROOM_STATE_NM  /* 객실상태:RM004 */		\n")
					.append("      ,T1.BGN_DATE                  /* 시작일자       */						\n")
					.append("      ,T1.END_DATE                  /* 종료일자       */						\n")
					.append("      ,SALES.FN_DETAIL_NM ( 'SY011',T1.USE_YN)       AS USE_YN_NM      /* 사용여부:SY011 */		\n")
					.append("  FROM 												\n")
					.append("       SALES.TRM040 T1											\n")
					.append("      ,SALES.TRM030 T2											\n")
					.append("      ,SALES.TRM010 T3											\n")
					.append(" WHERE 1 = 1												\n")
					.append("   AND T1.ROOM_TYPE_SID = T2.ROOM_TYPE_SID      /* 객실타입 SID    */					\n")
					.append("   AND T1.UPJANG_SID    = T3.UPJANG_SID         /* 업장     SID    */					\n");
		
		//객실정보 입력
		arr_sql[5].append ("INSERT INTO SALES.TRM040							\n")
					.append ("(				ROOM_SID, 							\n")
					.append ("				ROOM_NO, 							\n")
					.append ("				BGN_DATE, 							\n")
					.append ("				END_DATE, 							\n")
					.append ("				ROOM_VIEW_CD, 							\n")
					.append ("				FLOORS, 							\n")
					.append ("				USE_YN, 							\n")					
					.append ("				UPJANG_SID, 							\n")
					.append ("				ROOM_TYPE_SID, 							\n")
					.append ("				U_EMPNO, 							\n")
					.append ("				U_IP			)							\n")
					.append ("VALUES ((SELECT COALESCE(MAX(ROOM_SID), 0) + 1 FROM SALES.TRM040), ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )		\n");
		
		//객실정보 수정
		arr_sql[6].append ("UPDATE SALES.TRM040						\n")
					.append ("	SET 	ROOM_NO        = ?,						\n")
					.append ("			BGN_DATE       = ?,						\n")
					.append ("			END_DATE       = ?,						\n")
					.append ("			ROOM_VIEW_CD   = ?,						\n")
					.append ("			FLOORS         = ?,						\n")
					.append ("			USE_YN         = ?,						\n")
					.append ("			U_EMPNO        = ?,						\n")
					.append ("			U_DATE         = CURRENT TIMESTAMP,						\n")
					.append ("			U_IP           = ?						\n")
					.append ("WHERE ROOM_SID       = ?							\n");
		
		//객실정보 삭제
		arr_sql[7].append ("DELETE FROM SALES.TRM040 WHERE ROOM_SID = ?			\n");	
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//System.out.println("# Command : 선조회");

    	/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));
		String sHead = HDUtil.nullCheckStr(greq.getParameter("sHead"));		
		
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput();
		    
		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds2")){
		   			GauceDataSet ds1 = gis.read("DS2");
		   			cstmt = conn.prepareCall(arr_sql[0].toString());
		   			//System.out.println("# Query ds3 : " + arr_sql[3].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
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
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				} 	
				if(dSets[i].getName().equals("ds5") & dsType==2){
		   			GauceDataSet ds1 = gis.read("DS4");
		   			//System.out.println(arr_sql[2].toString());
		   			cstmt = conn.prepareCall(arr_sql[2].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				} 												
				if(dSets[i].getName().equals("ds4") & dsType==1){
		   			GauceDataSet ds1 = gis.read("DS4");
		   			//System.out.println(arr_sql[2].toString());
		   			cstmt = conn.prepareCall(arr_sql[2].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				}
				if(dSets[i].getName().equals("ds5") & dsType==1){
		   			GauceDataSet ds1 = gis.read("DS5");
		   			cstmt = conn.prepareCall(arr_sql[3].toString());
		   			rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				} 
		    }
	     	gos.close();
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
								
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));
			String 	sRoomTypeSid	= HDUtil.nullCheckStr(req.getParameter("sRoomTypeSid"));
			String 	sDate = HDUtil.nullCheckStr(req.getParameter("sDate"));
			System.out.println("sUpjangSid="+sUpjangSid);
			System.out.println("sRoomTypeSid="+sRoomTypeSid);
			System.out.println("sDate="+sDate);
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid)) 
								arr_sql[4].append (" AND T1.UPJANG_SID = ? \n");
							if (!"".equals(sRoomTypeSid) && !"".equals(sRoomTypeSid))							
								arr_sql[4].append (" AND T1.USE_YN = ? \n");
							if (!"".equals(sDate) && !"".equals(sDate))
								arr_sql[4].append (" AND ? BETWEEN T1.BGN_DATE AND T1.END_DATE \n" );
							System.out.println(arr_sql[4].toString());
							stmt = conn.getGauceStatement(arr_sql[4].toString());
							if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid))
								stmt.setString(sCnt1++, sUpjangSid);
							if (!"".equals(sRoomTypeSid) && !"".equals(sRoomTypeSid))
								stmt.setString(sCnt1++, sRoomTypeSid);
							if (!"".equals(sDate) && !"".equals(sDate))
								stmt.setString(sCnt1++, sDate);	
							rs = stmt.executeQuery(); // DataSet set
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
							}
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
								ds1.addDataRow(row);
							}//End of while
							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();
		
							//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
							break;
					}
				}
			}
			ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DS1");
		GauceStatement stmt = null;

		String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));
		String 	sRoomTypeSid	= HDUtil.nullCheckStr(req.getParameter("sRoomTypeSid"));
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = "tGeryon";
		String iParamIp = "100.200.1.130";
		try{
			if(inputDs!=null){

				int colNm_UpjangSid               = inputDs.indexOfColumn("UPJANG_SID");
				int colNm_RoomTypeSid                = inputDs.indexOfColumn("ROOM_TYPE_SID");
				int colNm_RoomSid                = inputDs.indexOfColumn("ROOM_SID");
				int colNm_RoomNo                = inputDs.indexOfColumn("ROOM_NO");
				int colNm_BgnDate               = inputDs.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = inputDs.indexOfColumn("END_DATE");
				int colNm_RoomView_cd           = inputDs.indexOfColumn("ROOM_VIEW_CD");
				int colNm_RoomView_nm           = inputDs.indexOfColumn("ROOM_VIEW_NM");
				int colNm_Floors                = inputDs.indexOfColumn("FLOORS");
				int colNm_UseYn                 = inputDs.indexOfColumn("USE_YN");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//System.out.println(arr_sql[5].toString());						
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_RoomNo);
						stmt.bindColumn(j++, colNm_BgnDate);
						stmt.bindColumn(j++, colNm_EndDate);
						stmt.bindColumn(j++, colNm_RoomView_cd);
						stmt.bindColumn(j++, colNm_Floors);
						if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							stmt.setString(j++, "Y");
						} else {
							stmt.setString(j++, "N");							
						}
						stmt.bindColumn(j++, colNm_UpjangSid);
						stmt.bindColumn(j++, colNm_RoomTypeSid);
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamIp);						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						//System.out.println(arr_sql[6].toString());						
						stmt = conn.getGauceStatement(arr_sql[6].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_RoomNo);
						stmt.bindColumn(j++, colNm_BgnDate);
						stmt.bindColumn(j++, colNm_EndDate);
						stmt.bindColumn(j++, colNm_RoomView_cd);
						stmt.bindColumn(j++, colNm_Floors);
						if ( rows[i].getColumnValue(colNm_UseYn).equals("T") ) {
							stmt.setString(j++, "Y");
						} else {
							stmt.setString(j++, "N");							
						}						
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamIp);		
						stmt.bindColumn(j++, colNm_RoomSid);						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//System.out.println(arr_sql[7].toString());						
						stmt = conn.getGauceStatement(arr_sql[7].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_RoomSid);
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;						
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			if(stmt!=null) stmt.close();
		}
	}

}
