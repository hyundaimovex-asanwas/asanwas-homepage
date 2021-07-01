package sales.menu.rm;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Rm050S extends SuperServlet {

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
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
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
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
				    .append ("UNION ALL                                   \n")
				    .append ("SELECT													\n")
					.append ("			HEAD,												\n")
					.append ("			DETAIL,												\n")
					.append ("			DETAIL_NM										\n")
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='RV016'											\n");
	
		
		//전망코드
		arr_sql[3].append ("SELECT													\n")
					.append ("	''		HEAD,												\n")
					.append ("	''		DETAIL,												\n")
					.append ("	'전체'	DETAIL_NM										\n")
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
				    .append ("UNION ALL                                   \n")
					.append ("SELECT													\n")
					.append ("			HEAD,												\n")
					.append ("			DETAIL,												\n")
					.append ("			DETAIL_NM										\n")
					.append ("FROM															\n")
					.append ("SALES.TSY010												\n")
					.append ("WHERE 1=1													\n")
					.append ("		AND LENGTH(RTRIM(DETAIL)) > 0			\n")
					.append ("		AND HEAD='RM009'											\n");
		
		//객실정보 조회
		arr_sql[4].append("SELECT 																		\n")
					.append("       T1.ROOM_SID                  /* 객실 SID       */						\n")
					.append("      ,T2.ROOM_NO                   /* 객실번호       */						\n")
					.append("      ,T3.UPJANG_NM                 /* 업장명         */							\n")
					.append("      ,T1.BGN_DATE                  /* 고장시작일자   */						\n")
					.append("      ,T1.END_DATE                  /* 고장종료일자   */						\n")
					.append("      ,T1.REQ_EMPNO                 /* 의뢰자사번     */						\n")
					.append("      ,SALES.FN_HIPERSON_NM(T1.REQ_EMPNO) AS HIPERSON_CD					\n")
					.append("      ,T1.WRONG_TYPE                /* 고장종류:RM009 */						\n")
					.append("      ,SALES.FN_DETAIL_NM ( 'RM009',T1.WRONG_TYPE) AS WRONG_TYPE_NM		\n")
					.append("      ,T1.WRONG_DESC                /* 고장내용       */						\n")
					.append("      ,T1.PROC_STATE                /* 처리상태:RM016 */						\n")
					.append("      ,SALES.FN_DETAIL_NM ( 'RM016',T1.PROC_STATE) AS PROC_STATE_NM		\n")
					.append("      ,T1.PROC_DATE                 /* 처리일자       */						\n")
					.append("      ,T1.RECEIPT_EMPNO             /* 접수자사번     */						\n")
					.append("      ,SALES.FN_HIPERSON_NM(T1.RECEIPT_EMPNO) AS RECEIPT_EMPNO_NM			\n")
					.append("      ,T1.RECEIPT_DATE              /* 접수일자       */						\n")
					.append("      ,T1.PROC_EMPNO                /* 처리담당자     */						\n")
					.append("      ,SALES.FN_HIPERSON_NM(T1.PROC_EMPNO) AS PROC_EMPNO_NM				\n")
					.append("      ,T1.PROC_DESC                 /* 처리내용       */						\n")
					.append("      ,T1.U_EMPNO                   /* 최종수정자사번 */						\n")
					.append("      ,T1.U_DATE                    /* 최종수정일자   */						\n")
					.append("      ,T1.U_IP                      /* 최종수정IP     */						\n")
					.append("  FROM 																	\n")
					.append("       SALES.TRM060 T1														\n")
					.append("      ,SALES.TRM040 T2														\n")
					.append("      ,SALES.TRM010 T3														\n")
					.append(" WHERE 1 = 1																\n")
					.append("   AND T1.ROOM_SID      = T2.ROOM_SID										\n")
					.append("   AND T2.UPJANG_SID    = T3.UPJANG_SID									\n");
		
		//객실정보 입력
		arr_sql[5].append ("INSERT INTO SALES.TRM060							\n")
					.append ("				BGN_DATE, 							\n")
					.append ("				END_DATE, 							\n")
					.append ("				REQ_EMPNO, 							\n")
					.append ("				WRONG_TYPE, 							\n")
					.append ("				WRONG_DESC, 							\n")					
					.append ("				RECEIPT_EMPNO, 							\n")
					.append ("				RECEIPT_DATE, 							\n")
					.append ("				RROC_STATE, 							\n")
					.append ("				PROC_DATE, 							\n")
					.append ("				PROC_EMPNO, 							\n")
					.append ("				PROC_DESC, 							\n")
					.append ("				U_EMPNO, 							\n")
					.append ("				U_DATE, 							\n")
					.append ("				U_IP			)							\n")
					.append ("VALUES (?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, '1', ?, ?, ?, ?,CURRENT TIMESTAMP, ? )		\n");
		
		//객실정보 수정
		arr_sql[6].append ("UPDATE SALES.TRM060						\n")
					.append ("	SET 	BGN_DATE        = ?,						\n")
					.append ("			END_DATE       = ?,						\n")
					.append ("			REQ_EMPNO  = ?,						\n")
					.append ("			WRONG_TYPE   = ?,						\n")
					.append ("			WRONG_DESC   = ?,						\n")
					.append ("			RECEIPT_EMPNO   = ?,						\n")
					.append ("			RECEIPT_DATE   = ?,						\n")
					.append ("			PROC_STATE         = ?,						\n")
					.append ("			PROC_DATE         = ?,						\n")
					.append ("			PROC_EMPNO         = ?,						\n")
					.append ("			PROC_DESC         = ?,						\n")
					.append ("			U_EMPNO        = ?,						\n")
					.append ("			U_DATE         = CURRENT TIMESTAMP,						\n")
					.append ("			U_IP           = ?						\n")
					.append ("WHERE ROOM_SID       = ?							\n");
		
		//객실정보 삭제
		arr_sql[7].append ("DELETE FROM SALES.TRM040 WHERE ROOM_SID = ?			\n");	
		
		
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		System.out.println("# Command : 선조회");

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String sHead = HDUtil.nullCheckStr(req.getParameter("sHead"));		
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){
								System.out.println(arr_sql[0].toString());
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							} 							
							if(gauceName.equals("DS3")){
								if (!"".equals(sSaupSid) && !"0".equals(sSaupSid)) {
									arr_sql[1].append("AND saup_sid= ? 			\n");
									arr_sql[1].append("ORDER BY  upjang_sid 	\n");
								}
									
								System.out.println(arr_sql[1].toString());
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								
								if (!"".equals(sSaupSid) && !"0".equals(sSaupSid))
									stmt.setString(1, sSaupSid);								
							} 							
							if(gauceName.equals("DS4")){
								System.out.println(arr_sql[2].toString());
								stmt = conn.getGauceStatement(arr_sql[2].toString());
							} 												
							if(gauceName.equals("DS5")){
								System.out.println(arr_sql[3].toString());
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} 																			
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
							ds1.flush();
							break;
					}
				}
			}
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
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		System.out.println("# Command : 조회");

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));
			String 	sFrDate	= HDUtil.nullCheckStr(req.getParameter("sFrDate"));
			String 	sToDate	= HDUtil.nullCheckStr(req.getParameter("sToDate"));
			String  sWrongType = HDUtil.nullCheckStr(req.getParameter("sWrongType"));
			String  sProcState = HDUtil.nullCheckStr(req.getParameter("sProcState"));

			System.out.println("sUpjangSid="+sUpjangSid);
			System.out.println("sFrDate="+sFrDate);
			System.out.println("sToDate="+sToDate);
			System.out.println("sWrongType="+sWrongType);
			System.out.println("sProcState="+sProcState);
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
								arr_sql[4].append (" AND T3.UPJANG_SID = ? \n");
							if (!"".equals(sFrDate) && !"0".equals(sToDate))							
								arr_sql[4].append (" AND (T1.RECEIPT_DATE BETWEEN "+sFrDate+" AND "+sToDate+") \n");
							if (!"".equals(sWrongType) && !"0".equals(sWrongType))
								arr_sql[4].append (" AND T1.WRONG_TYPE = ? \n");
							if (!"".equals(sProcState) && !"0".equals(sProcState)){
								arr_sql[4].append (" AND T1.PROC_STATE = ? \n" );
							}
								arr_sql[4].append (" ORDER BY T3.UPJANG_NM, T2.ROOM_NO" );
							System.out.println(arr_sql[4].toString());
							stmt = conn.getGauceStatement(arr_sql[4].toString());
							if (!"".equals(sUpjangSid) && !"0".equals(sUpjangSid))
								stmt.setString(sCnt1++, sUpjangSid);
							if (!"".equals(sWrongType) && !"0".equals(sWrongType))
								stmt.setString(sCnt1++, sWrongType);
							if (!"".equals(sProcState) && !"0".equals(sProcState))
								stmt.setString(sCnt1++, sProcState);
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
		
							System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
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

				int colNm_UpjangSid             = inputDs.indexOfColumn("UPJANG_SID");
				int colNm_RoomSid               = inputDs.indexOfColumn("ROOM_SID");
				int colNm_RoomNo                = inputDs.indexOfColumn("ROOM_NO");
				int colNm_UpjangNm              = inputDs.indexOfColumn("UPJANG_NM");
				int colNm_BgnDate               = inputDs.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = inputDs.indexOfColumn("END_DATE");
				int colNm_ReqEmpno              = inputDs.indexOfColumn("REQ_EMPNO");
				int colNm_HipersonCd            = inputDs.indexOfColumn("HEPERSON_CD");
				int colNm_WrongType             = inputDs.indexOfColumn("WRONG_TYPE");
				int colNm_WrongType_nm          = inputDs.indexOfColumn("WRONG_TYPE_NM");
				int colNm_WrongDesc             = inputDs.indexOfColumn("WRONG_DESC");
				int colNm_ProcState             = inputDs.indexOfColumn("PROC_STATE");
				int colNm_ProcState_nm          = inputDs.indexOfColumn("PROC_STATE_NM");
				int colNm_ProcDate              = inputDs.indexOfColumn("PROC_DATE");
				int colNm_ReceiptEmpno          = inputDs.indexOfColumn("RECEIPT_EMPNO");
				int colNm_ReceiptEmpnoNm        = inputDs.indexOfColumn("RECEIPT_EMPNO_NM");
				int colNm_ReceiptDate           = inputDs.indexOfColumn("RECEIPT_DATE");
				int colNm_ProcEmpno             = inputDs.indexOfColumn("PROC_EMPNO");
				int colNm_ProcEmpnoNm           = inputDs.indexOfColumn("PROC_EMPNO_NM");
				int colNm_ProcDesc              = inputDs.indexOfColumn("PROC_DESC");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						System.out.println(arr_sql[5].toString());						
						stmt = conn.getGauceStatement(arr_sql[5].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_BgnDate);
						stmt.bindColumn(j++, colNm_EndDate);
						stmt.bindColumn(j++, colNm_ReqEmpno);
						stmt.bindColumn(j++, colNm_WrongType);
						stmt.bindColumn(j++, colNm_WrongDesc);
						stmt.setString(j++, iParamEmpno);		//접수자 사번
						
						stmt.bindColumn(j++, colNm_ProcState);
						stmt.bindColumn(j++, colNm_ProcDate);
						stmt.bindColumn(j++, colNm_ProcEmpno);
						stmt.bindColumn(j++, colNm_ProcDesc);
	
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamIp);						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
						//객실정보 수정
					case GauceDataRow.TB_JOB_UPDATE:
						System.out.println(arr_sql[6].toString());						
						stmt = conn.getGauceStatement(arr_sql[6].toString());
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(j++, colNm_RoomSid);
						stmt.bindColumn(j++, colNm_RoomNo);
						stmt.bindColumn(j++, colNm_BgnDate);
						stmt.bindColumn(j++, colNm_EndDate);
						stmt.bindColumn(j++, colNm_ReqEmpno);
						stmt.bindColumn(j++, colNm_HipersonCd);
						stmt.bindColumn(j++, colNm_WrongType);
						stmt.bindColumn(j++, colNm_WrongType_nm);
						stmt.bindColumn(j++, colNm_WrongDesc);
						stmt.bindColumn(j++, colNm_ProcState);
						stmt.bindColumn(j++, colNm_ProcState_nm);
						stmt.bindColumn(j++, colNm_ProcDate);
						stmt.bindColumn(j++, colNm_ReceiptEmpno);
						stmt.bindColumn(j++, colNm_ReceiptEmpnoNm);
						stmt.bindColumn(j++, colNm_ReceiptDate);
						stmt.bindColumn(j++, colNm_ProcEmpno);
						stmt.bindColumn(j++, colNm_ProcEmpnoNm);
						stmt.bindColumn(j++, colNm_ProcDesc);
						stmt.setString(j++, iParamEmpno);
						stmt.setString(j++, iParamIp);		
						stmt.bindColumn(j++, colNm_RoomSid);						
						
						stmt.execute();
						if(stmt!=null) stmt.close();
						break;
					case GauceDataRow.TB_JOB_DELETE:
						System.out.println(arr_sql[7].toString());						
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
