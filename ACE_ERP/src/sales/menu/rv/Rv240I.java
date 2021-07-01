package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
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

public class Rv240I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * 공통코드
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' head, '' detail, '전체' detail_nm    \n")
				  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (B.detail) > 0                  \n");		
		
		
		/*
		 * 마스터 조회
		 */
		arr_sql[1].append ("")
					.append("SELECT             						\n")			   	                                                                                                                           
					.append("       T1.ACCEPT_SID						\n")   /* 신청SID        */                                                       
					.append("      ,T1.ACCEPT_NO						\n")	/* 신청서번호     */                                                       
					.append("      ,T1.ACCEPT_DATE						\n")	/* 신청일자       */                                                       
					.append("      ,T1.DEPART_DATE						\n")	/* 출발일자       */                                                       
					.append("      ,T1.GOODS_SID						\n")	/* 상품 SID       */                                                       
					.append(" FROM SALES.TRV010 T1						\n")
					.append("WHERE 1=1               					\n")                                                                             
					.append("  AND T1.JOB_GUBUN  = '2'					\n");	/* 작업구분(2:방북신청) */   
		
		/*
		 * 차량리스트 조회
		 */
		arr_sql[2].append ("")
					.append("SELECT 					\n")                           
					.append("       T1.CAR_RSV_SID		\n")	/* 차량예약SID 		*/          
					.append("      ,T1.ACCEPT_SID		\n")	/* 신청SID     		*/         
					.append("      ,T1.CAR_SID			\n")	/* 차량 SID    		*/          
					.append("      ,T2.CAR_NM			\n")	/* 차명        		*/         
					.append("      ,T2.CAR_NO			\n")	/* 차량등록번호		*/         
					.append("      ,T1.DEPART_DATE		\n")    /* 출경일자    		*/          
					.append("      ,T1.DEPART_TIME		\n")    /* 출경시간    		*/          
					.append("      ,T1.ARRIVE_DATE		\n")    /* 입경일자    		*/          
					.append("      ,T1.ARRIVE_TIME		\n")    /* 입경시간    		*/          
					.append("      ,T1.CARGO			\n")	/* 화물        		*/        
					.append("      ,T1.DRIVE_SID		\n")	/* 운전면허SID 		*/    
					.append("	   ,T3.DRIVE_NO			\n")	
					.append("      ,T4.CUST_NM			\n")	/* 한글성명 (운전자)  	*/   
					.append("      ,T4.MANAGE_NO		\n")	/* 관리번호(주민/여권)	*/ 
					.append("      ,T1.CLIENT_SID		\n")	/* 매출처SID   		*/         
					.append("      ,T1.LONG_STAY_YN		\n")	/* 장기체류유무 : RV031  		*/         
					.append("      ,T1.CAR_DESC		\n")	/* 차량출입 참고사항   		*/         
					.append(" FROM SALES.TRV040 T1		\n") 	/* 예약정보 차량 		*/           
					.append("     ,SALES.TCU050 T2		\n") 	/* 차량정보 			*/                
					.append("     ,SALES.TCU040 T3		\n") 	/* 운전면허정보 		*/            
					.append("     ,SALES.TCU010 T4		\n") 	/* 고객정보 			*/                
					.append("WHERE	1=1 				\n")                                          
					.append("  AND T1.CAR_SID     = T2.CAR_SID		\n")     /* 차량 SID    */
					.append("  AND T1.DRIVE_SID   = T3.DRIVE_SID	\n")     /* 운전면허SID */
					.append("  AND T3.CUST_SID    = T4.CUST_SID		\n");     /* 고객SID     */
		
		/*
		 *인원리스트 조회 (GRID3) 
		 */
		arr_sql[3].append ("")
				.append("SELECT                    										\n")
				.append("      T1.ACCEPT_SID       									\n") 	/* 신청 SID         		*/
				.append("      ,T1.RSV_SID       									\n") 	/* 예약 SID         		*/       
				.append("      ,T1.CUST_SID       										\n")	/* 고객SID            	*/                       
				.append("      ,T2.CUST_NM       										\n")	/* 한글성명           		*/                       
				.append("      ,T2.MANAGE_NO        									\n")	/* 관리번호(주민/여권)		*/                       
				.append("      ,T2.CUST_TYPE        									\n")	/* 할인유형		*/                       
				.append("      ,T1.UNITY_NO AS N_CARD_NO      							\n")	/* 방북증번호 */                       
				.append("      ,T2.WORK_NO AS WORK_NO    								\n")	/* 실무번호		*/                       
				.append("      ,T1.DEPART_DATE       									\n")	/* 출경일자           		*/                       
				.append("      ,T1.DEPART_TIME       									\n")	/* 출경시간           		*/                       
				.append("      ,T1.ARRIVE_DATE       									\n")	/* 입경일자           		*/                       
				.append("      ,T1.ARRIVE_TIME       									\n")	/* 입경시간           		*/                       
				.append("      ,T1.DRIVE_YN       										\n")	/* 운전여부:SY010			*/                       
				.append("      ,SALES.FN_DETAIL_NM('SY010',T1.DRIVE_YN) AS DRIVE_YN_NM  \n")         
				.append("      ,T1.NORTH_PURPOSE       									\n") 	/* 방북목적           		*/                       
				.append("      ,T1.LONG_STAY_YN       									\n") 	/* 장기체류유무 : RV031           		*/				
				.append("      ,SALES.FN_ROOM_TYPE_CD(T3.A_ROOM_TYPE_SID) AS ROOM_TYPE_CD \n") 	/* 희망객실타입*/
				.append("      ,T3.REMARKS			AS REMARKS   						\n") 	/* 참고사항  		*/
				.append("      ,T3.N_CARD_GU		AS N_CARD_GU						\n") 	/* 방북증 소재  		*/
				.append("      ,T3.A_ROOM_TYPE_SID										\n") 	/* 희망객실타입sid	*/
				.append(" FROM SALES.TRV020 T1 JOIN SALES.TCU010 T2 ON (T1.CUST_SID = T2.CUST_SID) \n")  	/*예약정보 차량 			*/                                 
				.append("                      JOIN SALES.TCM040 T3 ON (T1.RSV_SID  = T3.RSV_SID) \n")  	/*예약정보 차량 			*/				
				.append("WHERE 1=1       												\n");                                                                 
				 
		
		/*
		 * // 신청서 , 신청서 no, 사업소 SId, 매출처 sid, 신청일자, 최종수정자 사번, 최종수정 ip, 편집상태 1(insert) 2(delete) 3(update), 메세지코드, 메세지
		 */
		
		arr_sql[4].append("CALL SALES.PR_RV240I_01(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"); 
		
		/*
		 * 차량예약SID, 사업소 SID, 신청SID, 차량SID, 운전면허SID, 출경일자 , 
		 * 출경시간, 입경일자, 입경시간, 화물, 매출처 SID, 
		 * 최종수정자사번, IP, 편집상태 1(insert) 2(delete) 3(update), 메세지드, 메세지 
		 */
		arr_sql[5].append("CALL SALES.PR_RV240I_02(?,?,?,?,?,?, ?, ?,?,?,?,?,?,?,?,?,?,?,?)");
		
		/*
		 * 예약SID,사업소 Sid, 신청SID, 고객SID, 출발일자, 출발시간, 
		 * 복귀일자, 복귀시간, 운전여부, 방북목적, 사번, 
		 * IP, 편집상태 1(insert) 2(delete) 3(update), 메세지코드, 메세지
		 */
		arr_sql[6].append("CALL SALES.PR_RV240I_03(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,? )");
	
		
		/*
		 * 마스터 삭제시 전부 삭제 
		 * 신청서 SID
		 */
		
		arr_sql[7].append("CALL SALES.PR_RV240I_04(?,?,?)");
		
		/*
		 * 출경일자 체크 
		 */
		arr_sql[8].append("SELECT SALES.FN_RSV_CLOSE_YN(?,?) DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
		
		/*
		 * 상품별 출발일자에 따른 출발일자, 출발시간, 입경일자, 입경시간 정보
		 */
		arr_sql[9].append(" SELECT DEPART_DATE    	\n")
						.append ("		,DEPART_TIME    		\n")
						.append ("		,ARRIVE_DATE    		\n")
						.append ("		,ARRIVE_TIME    		\n")
						.append ("FROM SALES.TRM220		\n")
						.append ("  WHERE 1 = 1			\n")
						.append ("		AND DEPART_DATE = ?		\n")
						.append ("		AND GOODS_SID   = ?		\n");
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if("RM014".equals(gauceName)){								//출입시간
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "RM014");
					} else if("RM015".equals(gauceName)){						//복귀시간
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "RM015");
					} else if ("SY010".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "SY010");
					} else if ("CU022".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						stmt.setString(1, "CU022");
					} else if("DS1".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[1].toString());
					} else if("DS2".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[2].toString());
					} else if("DS3".equals(gauceName)){
						stmt = conn.getGauceStatement(arr_sql[3].toString());
					}
////StringUtil.printMsg("gauceName", gauceName, this);
					if(gauceName.equals("DS1") || gauceName.equals("DS2") || gauceName.equals("DS3")){
						rs = stmt.executeQuery();		// Query 실행
						getDataSetHead(rs, ds1).flush();
					} else {
						rs = stmt.executeQuery();		// Query 실행
						getDataSet(rs, ds1).flush();
					}
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		// 마스터
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClientSid"));				// 협력업체
		int sSaupSid 		= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));			// 사업 Sid
		String sFromAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sFromAcceptDate")); 	// 신청일자 From
		String sToAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sToAcceptDate")); 		// 신청일자 To
		String sAcceptNo 		= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));					// 신청서번호  
		int sAcceptSid		= HDUtil.nullCheckNum(req.getParameter("sAcceptSid")); // 신청 SID
		
		String sDeptDate = HDUtil.nullCheckStr(req.getParameter("sDeptDate")); // 출경일자
		
		int v_goods_sid	= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));
		String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		String vResponse = HDUtil.nullCheckStr(req.getParameter("sResponse"));	//사업자 출입여부 pm = 사업자 출입
		

		//StringUtil.printMsg("조회 메소드 ", "들어오남?",this);
		
		try {
			int sCnt1 = 1;
			int sCnt2 = 1;
			int sCnt3 = 1;
			
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("카우스이름:",gauceName,this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					  
					if ("DS1".equals(gauceName)) {
	
//						if (sClientSid!=0)  /* 매출처SID */
							arr_sql[1].append("    AND  T1.CLIENT_SID  = ?					\n");	
						
//						if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate))  /* 신청일자  */
						////StringUtil.printMsg("DS1.equals(gauceName) - ", vResponse, this);
							if(vResponse.equals("pm")){	//pm 사업자 방북신청을 위해 신청일자에서 출발일자로 변경...
								arr_sql[1].append("  AND T1.DEPART_DATE BETWEEN ? AND ?		\n");   
							}
							else{
								arr_sql[1].append("  AND T1.ACCEPT_DATE BETWEEN ? AND ?		\n");	
							}
						
						if (!"".equals(sAcceptNo))  	/* 신청서번호*/ 
							arr_sql[1].append("  AND T1.ACCEPT_NO   LIKE   ?			\n");   
						
//						if (sSaupSid!=0)  	/* 사업SID */ 
						arr_sql[1].append("  AND T1.SAUP_SID =   ?			\n");   
						arr_sql[1].append("  ORDER BY T1.ACCEPT_NO ASC		\n");		
				  		 // 쿼리 실행
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
				  		// 조건
//				  		if (sClientSid!=0)  /* 매출처SID */
					  		stmt.setInt(sCnt1++, sClientSid );	
//				  		if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate)) { /* 신청일자  */   
							stmt.setString(sCnt1++, sFromAcceptDate );			// to
							stmt.setString(sCnt1++, sToAcceptDate);			// from 
//						}
				  		if (!"".equals(sAcceptNo))  	/* 신청서번호*/ 
				  			stmt.setString(sCnt1++, sAcceptNo + "%");	
				  		
//				  		if (sSaupSid!=0)  	/* 사업SID */ 
				  			stmt.setInt(sCnt1++, sSaupSid);
					} 
					//StringUtil.printMsg("arr_sql[1] - ", arr_sql[1].toString(), this);
					
					/*
					 * 차량
					 */
					if ("DS2".equals(gauceName)) {
						
//						if (sAcceptSid!=0)  
							arr_sql[2].append("		AND T1.ACCEPT_SID = ? \n");	/* 신청 SID */

						//arr_sql[2].append("ORDER BY T1.CAR_RSV_SID				\n");
						
				  		stmt = conn.getGauceStatement(arr_sql[2].toString()); 
				  		
//				  		if (sAcceptSid!=0) 
				  			stmt.setInt(sCnt2++, sAcceptSid);			 /* 신청SID     */     
					} 
					
					/*
					 * 인원
					 */
					if ("DS3".equals(gauceName)) {
						  
						//if (sAcceptSid!=0) 
							arr_sql[3].append("  AND    T1.ACCEPT_SID  = ?   \n");  /* 신청SID     */     
						arr_sql[3].append("ORDER BY T1.RSV_SID       										\n");    
				  		stmt = conn.getGauceStatement(arr_sql[3].toString()); 
				  		
				  		// 조건
				  		//if (sAcceptSid!=0) 
				  			stmt.setInt(sCnt3++, sAcceptSid);			 /* 신청SID     */     
					}
					
					// 출경일자 체크 
					if("DEPT_DATE".equals(gauceName)) {
						stmt = conn.getGauceStatement("SELECT SALES.FN_RSV_CLOSE_YN('" + sDeptDate + "',"+sClientSid+") DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
					}

					// 마감일자 체크  - 20080516 updated by 심동현.
					if("RSV_CLOSE_DATE".equals(gauceName)) {
						//StringUtil.printMsg("dkrdkr","악악악",this);
						//stmt = conn.getGauceStatement("SELECT N_RSV_CLOSE_DATE FROM SALES.TSY100 WHERE CALN_DATE='"+ sDeptDate +"'");
						stmt = conn.getGauceStatement("SELECT SALES.FN_RSV_CLOSE_YN_BIZ('" + sDeptDate + "',"+sClientSid+") AS DEPT_FLAG FROM SYSIBM.SYSDUMMY1");
					}

					if("DS_TEMP".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[9].toString());
						stmt.setString(1, v_depart_date);
						stmt.setInt(2, v_goods_sid);
					}
					
					rs = stmt.executeQuery();		// Query 실행
					
					getDataSet(rs, ds1).flush();
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		CallableStatement cstmt;

		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		GauceDataSet ds2 = req.getGauceDataSet("DS2");
		GauceDataSet ds3 = req.getGauceDataSet("DS3");
		GauceDataSet ds4 = req.getGauceDataSet("DS4");
		
		// Parameter
		int 	iAcceptSid = 0; // 신청SID
		String 	iAcceptNo = ""; // 신청 번호 
		long 	iCarRsvSid = 0; // 차량 SID
		long 	iRsvSid = 0;  	// 예약 Sid

		
		int sSaupSid = HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
		int sClientSid = HDUtil.nullCheckNum(req.getParameter("sClientSid"));	//매출처sid
		int sGoodsSid = HDUtil.nullCheckNum(req.getParameter("sGoodsSid"));	//상품sid
		

		String v_edit_status = "";
		
		try{
			res.enableFirstRow(ds4);
			
			ds4.addDataColumn(new GauceDataColumn("ACCEPT_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("ACCEPT_NO", GauceDataColumn.TB_STRING,15));
			ds4.addDataColumn(new GauceDataColumn("CAR_RSV_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("RSV_SID", GauceDataColumn.TB_STRING,10));
			ds4.addDataColumn(new GauceDataColumn("FLAG", GauceDataColumn.TB_STRING,10));
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				int colNm_AcceptSid             = ds1.indexOfColumn("ACCEPT_SID");
				int colNm_AcceptNo              = ds1.indexOfColumn("ACCEPT_NO");
				int colNm_AcceptDate            = ds1.indexOfColumn("ACCEPT_DATE");
				
				for(int i = 0; i < rows.length; i++) {
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:	//인서트
							cstmt = conn.prepareCall(arr_sql[4].toString());

							GauceDataRow gRow = ds4.newDataRow();

							cstmt.setInt(1, rows[i].getInt(colNm_AcceptSid));
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);

							cstmt.setString(2, rows[i].getString(colNm_AcceptNo));
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);

							cstmt.setInt(3, sSaupSid);

							cstmt.setInt(4, sClientSid);
							cstmt.setString(5, rows[i].getString(colNm_AcceptDate));
							cstmt.setInt(6, rows[i].getInt(ds1.indexOfColumn("GOODS_SID")));
							cstmt.setString(7, rows[i].getString(ds1.indexOfColumn("DEPART_DATE")));

							cstmt.setString(8, fParamEmpno);
							cstmt.setString(9, fParamIp);
							cstmt.setString(10, "1"); // INSERT

							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							
							// 쿼리실행
							cstmt.executeUpdate();
							
							// 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(11)))
								throw new Exception (cstmt.getString(13));
							
							// 에러코드가 없는경우
							iAcceptSid = cstmt.getBigDecimal(1).intValue(); // 프로시져를 통하여 얻은 신청서 SID
							iAcceptNo = cstmt.getString(2); // 신청서 번호 
							
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue(iAcceptNo);
							gRow.addColumnValue("0");
							gRow.addColumnValue("0");
							gRow.addColumnValue("DS1");
							
							ds4.addDataRow(gRow);
							if(cstmt!=null) 
								cstmt.close();
							
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[7].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_AcceptSid));
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();
							
							break;
					} 
				}
			} 
			
			if (ds2 != null) {
				GauceDataRow[] 	rows = ds2.getDataRows();
				
				int colNm_CarRsv_sid        = ds2.indexOfColumn("CAR_RSV_SID");  	/*1 차량예약SID 		*/
				int colNm_AcceptSid          = ds2.indexOfColumn("ACCEPT_SID");  	/*2 신청SID     		*/
				int colNm_CarSid                = ds2.indexOfColumn("CAR_SID");  		/*3 차량 SID    		*/
				int colNm_DepartDate         = ds2.indexOfColumn("DEPART_DATE");  	/*5 출경일자    		*/
				int colNm_DepartTime         = ds2.indexOfColumn("DEPART_TIME");  	/* 출경시간    		*/
				int colNm_ArriveDate           = ds2.indexOfColumn("ARRIVE_DATE"); 	/* 입경일자    		*/
				int colNm_ArriveTime           = ds2.indexOfColumn("ARRIVE_TIME"); 	/* 입경시간    		*/
				int colNm_Cargo                 = ds2.indexOfColumn("CARGO");  			/* 화물        		*/
				int colNm_DriveSid              = ds2.indexOfColumn("DRIVE_SID");  		/* 4 운전면허SID 		*/
				
				for(int i = 0; i < rows.length; i++) {

					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							GauceDataRow gRow = ds4.newDataRow();
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// 차량예약 SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);	
							
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							if (iAcceptSid > 0) {
								cstmt.setLong(3, iAcceptSid);											// 신청 SID
							} else {
								cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));											// 신청 SID
								
								iAcceptSid = rows[i].getInt(colNm_AcceptSid);
							}
							
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// 차량 SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// 운전면허 SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// 출경일자 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// 출경시간
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// 입경일자 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// 입경시간
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// 화물
							cstmt.setInt(11,sClientSid);											// 매출처SID

							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// 화물
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// 화물

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "1"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// 쿼리실행
							cstmt.executeUpdate();
							

							// 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							
							iCarRsvSid = cstmt.getBigDecimal(1).intValue(); // 차량 예약 SID
							
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue(iCarRsvSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue("DS2");
							
							ds4.addDataRow(gRow);
							if(cstmt!=null) 
								cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// 차량예약 SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);			
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));	// 신청 SID
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// 차량 SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// 운전면허 SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// 출경일자 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// 출경시간
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// 입경일자 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// 입경시간
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// 화물
							cstmt.setInt(11, sClientSid);											// 매출처SID
							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// 화물
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// 화물

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "3"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// 쿼리실행
							cstmt.executeUpdate();
							

							// 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							
							if(cstmt!=null) 
								cstmt.close();
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("DS2 Insert",arr_sql[5].toString(), this);
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_CarRsv_sid));	// 차량예약 SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);	
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							
							cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));	// 신청 SID
							cstmt.setInt(4, rows[i].getInt(colNm_CarSid));		// 차량 SID
							cstmt.setInt(5, rows[i].getInt(colNm_DriveSid));	// 운전면허 SID
							cstmt.setString(6, rows[i].getString(colNm_DepartDate));				// 출경일자 
							cstmt.setString(7, rows[i].getString(colNm_DepartTime));				// 출경시간
							cstmt.setString(8, rows[i].getString(colNm_ArriveDate));				// 입경일자 
							cstmt.setString(9, rows[i].getString(colNm_ArriveTime));				// 입경시간
							cstmt.setString(10, rows[i].getString(colNm_Cargo));						// 화물
							cstmt.setInt(11, sClientSid);											// 매출처SID
							cstmt.setString(12, rows[i].getString(ds2.indexOfColumn("LONG_STAY_YN")));						// 화물
							cstmt.setString(13, rows[i].getString(ds2.indexOfColumn("CAR_DESC")));						// 화물

							cstmt.setString(14, fParamEmpno);
							cstmt.setString(15, fParamIp);
							cstmt.setString(16, "2"); 												// INSERT
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							
							// 쿼리실행
							cstmt.executeUpdate();
							

							// 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(17))) 
								throw new Exception (cstmt.getString(19));
							 
							if(cstmt!=null) 
								cstmt.close();
							
							break;
					} 
				} 
			} 
			
			if (ds3 != null) {
				GauceDataRow[] 	rows = ds3.getDataRows();
			
				int colNm_AcceptSid             = ds3.indexOfColumn("ACCEPT_SID");			/* 신청 SID			*/
				int colNm_RsvSid                = ds3.indexOfColumn("RSV_SID");			/* 예약 SID			*/
				int colNm_CustSid               = ds3.indexOfColumn("CUST_SID");	 	/* 고객SID          	*/
				int colNm_DepartDate            = ds3.indexOfColumn("DEPART_DATE");		/* 출경일자           	*/
				int colNm_DepartTime            = ds3.indexOfColumn("DEPART_TIME");		/* 출경시간           	*/
				int colNm_ArriveDate            = ds3.indexOfColumn("ARRIVE_DATE"); 	/* 입경일자           	*/
				int colNm_ArriveTime            = ds3.indexOfColumn("ARRIVE_TIME");		/* 입경시간           	*/
				int colNm_LongStayYn            = ds3.indexOfColumn("LONG_STAY_YN");	// 장기여부
				int colNm_CustType              = ds3.indexOfColumn("CUST_TYPE");		// 할인유형
				int colNm_NcardNo          		= ds3.indexOfColumn("N_CARD_NO");	// 방북증 번호
				int colNm_NorthPurpose          = ds3.indexOfColumn("NORTH_PURPOSE");	/* 방북목적           	*/
				int colNm_DriveYn               = ds3.indexOfColumn("DRIVE_YN");		/* 운전여부:SY010    */       
				int colNm_NcardGu          		= ds3.indexOfColumn("N_CARD_GU");	// 방북증 소재
				int colNm_RoomTypeSid      		= ds3.indexOfColumn("A_ROOM_TYPE_SID");	// 희망객실 코드
				int colNm_Remarks          		= ds3.indexOfColumn("REMARKS");	// 참고사항
				
				
				for(int i = 0; i < rows.length; i++) {
					//StringUtil.printMsg("가우스잡타입", rows[i].getJobType(), this);
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//StringUtil.printMsg("가우스잡타입", "입력? 확인합시다.", this);
							cstmt = conn.prepareCall(arr_sql[6].toString());
							
							GauceDataRow gRow = ds4.newDataRow();
							
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// 예약SID
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							
							if (iAcceptSid > 0) {
								cstmt.setLong(3, iAcceptSid);											// 신청 SID
							} else {
								cstmt.setLong(3, rows[i].getInt(colNm_AcceptSid));											// 신청 SID
								
								iAcceptSid = rows[i].getInt(colNm_AcceptSid);
							}
							
							// 신청SID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// 고객 SID
							//StringUtil.printMsg("4",rows[i].getInt(colNm_CustSid) , this);
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// 출경일자
							//StringUtil.printMsg("5", rows[i].getString(colNm_DepartDate), this);
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// 출경시간
							//StringUtil.printMsg("6", rows[i].getString(colNm_DepartTime), this);
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// 입경일자
							//StringUtil.printMsg("7", rows[i].getString(colNm_ArriveDate), this);
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// 입경시간
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// 운전여부
							//StringUtil.printMsg("9", rows[i].getString(colNm_DriveYn), this);
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// 방북목적
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);							
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// 할인유형
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// 장기여부
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.매출처SID  	20071005 추가 by 심동현
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.상품SID		20071005 추가 by 심동현
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.방북증번호		20071005 추가 by 심동현
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.희망객실SID	20071005 추가 by 심동현
							
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.객실관련참고사항20071005 추가 by 심동현
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.방북증 소재 20071009 추가 by 심동현
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "1");	// INSERT
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							
							// 쿼리실행
							cstmt.executeUpdate();
							
							//		 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							iRsvSid = cstmt.getBigDecimal(1).intValue(); //예약 SID
						
							gRow.addColumnValue(iAcceptSid);
							gRow.addColumnValue("0");
							gRow.addColumnValue("0");
							gRow.addColumnValue(iRsvSid);
							gRow.addColumnValue("DS3");
							
							ds4.addDataRow(gRow);
							
							if(cstmt!=null) 
								cstmt.close();
						
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("가우스잡타입", "Update 문", this);
							cstmt = conn.prepareCall(arr_sql[6].toString());
							
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// 예약SID
							//StringUtil.printMsg("1", rows[i].getInt(colNm_RsvSid), this);
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							//StringUtil.printMsg("2", sSaupSid, this);
							cstmt.setLong(3, 0);											// 신청SID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// 고객 SID			
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// 출경일자 
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// 출경시간
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// 입경일자 
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// 입경시간
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// 운전여부
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// 방북목적
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// 할인유형
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// 장기여부
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.매출처SID  	20071005 추가 by 심동현
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.상품SID		20071005 추가 by 심동현
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.방북증번호		20071005 추가 by 심동현
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.희망객실SID	20071005 추가 by 심동현
								
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.객실관련참고사항20071005 추가 by 심동현
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.방북증 소재 20071009 추가 by 심동현
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "3");	// UPDATE
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							// 쿼리실행
							cstmt.executeUpdate();
							
							//StringUtil.printMsg("22", cstmt.getString(22), this);
							//StringUtil.printMsg("23", cstmt.getString(23), this);
							//StringUtil.printMsg("24", cstmt.getString(24), this);

							//		 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							if(cstmt!=null) 
								cstmt.close();
							
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("가우스잡타입", "삭제?", this);
							//StringUtil.printMsg("ds3 Delete",arr_sql[6].toString(), this);
							cstmt = conn.prepareCall(arr_sql[6].toString());

							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));		// 예약SID
							//StringUtil.printMsg("1", rows[i].getInt(colNm_RsvSid), this);
							cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
							cstmt.setInt(2, sSaupSid);							// 사업소 SID
							//StringUtil.printMsg("2", sSaupSid, this);
							cstmt.setLong(3, 0);											// 신청SID
							cstmt.setInt(4, rows[i].getInt(colNm_CustSid));	// 고객 SID			
							cstmt.setString(5, rows[i].getString(colNm_DepartDate));				// 출경일자 
							cstmt.setString(6, rows[i].getString(colNm_DepartTime));				// 출경시간
							cstmt.setString(7, rows[i].getString(colNm_ArriveDate));				// 입경일자 
							cstmt.setString(8, rows[i].getString(colNm_ArriveTime));				// 입경시간
							//StringUtil.printMsg("8", rows[i].getString(colNm_ArriveTime), this);
							cstmt.setString(9, rows[i].getString(colNm_DriveYn));					// 운전여부
							cstmt.setString(10, rows[i].getString(colNm_NorthPurpose));				// 방북목적
							//StringUtil.printMsg("10", rows[i].getString(colNm_NorthPurpose), this);
							cstmt.setString(11, rows[i].getString(colNm_CustType));				// 할인유형
							//StringUtil.printMsg("11", rows[i].getString(colNm_CustType), this);
							cstmt.setString(12, rows[i].getString(colNm_LongStayYn));			// 장기여부
							//StringUtil.printMsg("12", rows[i].getString(colNm_LongStayYn), this);
							cstmt.setInt(13, sClientSid);		//  -- 13.매출처SID  	20071005 추가 by 심동현
							//StringUtil.printMsg("13", sClientSid, this);
							cstmt.setInt(14, sGoodsSid);		//  14.상품SID		20071005 추가 by 심동현
							//StringUtil.printMsg("14", sGoodsSid, this);
							cstmt.setString(15, rows[i].getString(colNm_NcardNo));			// 15.방북증번호		20071005 추가 by 심동현
							//StringUtil.printMsg("15", rows[i].getString(colNm_NcardNo), this);
							//StringUtil.printMsg("16", colNm_RoomTypeSid, this);
							cstmt.setInt(16, rows[i].getInt(colNm_RoomTypeSid));		//  16.희망객실SID	20071005 추가 by 심동현
									
							//StringUtil.printMsg("16", rows[i].getInt(colNm_RoomTypeSid), this);
							cstmt.setString(17, rows[i].getString(colNm_Remarks));			// 17.객실관련참고사항20071005 추가 by 심동현
							//StringUtil.printMsg("17", rows[i].getString(colNm_Remarks), this);
							cstmt.setString(18, rows[i].getString(colNm_NcardGu));			// 18.방북증 소재 20071009 추가 by 심동현
							//StringUtil.printMsg("18", rows[i].getString(colNm_NcardGu), this);
							cstmt.setString(19, fParamEmpno);
							//StringUtil.printMsg("19",fParamEmpno , this);
							cstmt.setString(20, fParamIp);
							//StringUtil.printMsg("20",fParamIp , this);
							cstmt.setString(21, "2");	// DELETE
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
							// 쿼리실행
							cstmt.executeUpdate();
								
							//StringUtil.printMsg("22", cstmt.getString(22), this);
							//StringUtil.printMsg("23", cstmt.getString(23), this);
							//StringUtil.printMsg("24", cstmt.getString(24), this);
							
							// 쿼리실행
							cstmt.executeUpdate();
							
							
							//StringUtil.printMsg("1", cstmt.getString(22), this);
							
							//		 에러코드 가 있는경우 
							if("N".equals(cstmt.getString(22)))
								throw new Exception (cstmt.getString(24));
							
							if(cstmt!=null) cstmt.close();

							break;
					} 
				} 
			} 
			
			if (ds4 != null) 
				ds4.flush();
			
		} catch (SQLException sqle){
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}

	}

}
