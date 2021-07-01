package sales.menu.rv;

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

public class Rv250I extends SuperServlet {

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
					.append(" FROM SALES.TRV040 T1		\n") 	/* 예약정보 차량 		*/           
					.append("     ,SALES.TCU050 T2		\n") 	/* 차량정보 			*/                
					.append("     ,SALES.TCU040 T3		\n") 	/* 운전면허정보 		*/            
					.append("     ,SALES.TCU010 T4		\n") 	/* 고객정보 			*/                
					.append("WHERE	1=1 				\n")                                          
					.append("  AND T1.CAR_SID     = T2.CAR_SID		\n")     /* 차량 SID    */
					.append("  AND T1.DRIVE_SID   = T3.DRIVE_SID	\n")     /* 운전면허SID */
					.append("  AND T3.CUST_SID    = T4.CUST_SID		\n");     /* 고객SID     */
					
		
		/*
		 *화물리스트 조회 
		 */
		arr_sql[3].append ("")
				.append("SELECT                    			\n")
				.append("      	T1.CAR_RSV_SID       		\n") 	
				.append("      ,T1.KEY_SEQ       			\n") 	       
				.append("       ,T1.CARGO_NAME       		\n")	                       
				.append("      ,T1.CARGO_SIZE       		\n")	                       
				.append("      ,T1.CARGO_UNIT        		\n")	                       
				.append("      ,T1.CARGO_WEIGHT       		\n")	                       
				.append("      ,T1.CARGO_QTY       			\n")	                       
				.append("      ,T1.CARGO_PRICE       		\n")	                       
				.append("      ,T1.CARGO_AMT       			\n")	                       
				.append("FROM SALES.TRV050 T1       		\n")  	                                 
				.append("WHERE 1=1       					\n")                                                                 
				.append("  AND T1.CAR_RSV_SID = ? 			\n");	
				 
		
		/*
		 * 화물리스트 등록
		 */
		
		arr_sql[4].append("")
				  .append("INSERT INTO SALES.TRV050 ")
				  .append("		( "	)
				  .append("      CAR_RSV_SID       										\n") 
				  .append("		 ,KEY_SEQ												\n")
				  .append("      ,CARGO_NAME       										\n")	                       
				  .append("      ,CARGO_SIZE       										\n")	                       
				  .append("      ,CARGO_UNIT        									\n")
				  
				  .append("      ,CARGO_WEIGHT       									\n")	                       
				  .append("      ,CARGO_QTY       										\n")	                       
				  .append("      ,CARGO_PRICE       									\n")	                       
				  .append("      ,CARGO_AMT       										\n")
				  .append(" 	 ,U_EMPNO												\n")

				  .append("	     ,U_DATE 												\n")
				  .append("	     ,U_IP  												\n")
				  .append("		)														\n")
				  .append("VALUES (")
				  .append(" 		?,(SELECT COALESCE(MAX(KEY_SEQ), 0)+1 FROM SALES.TRV050 WHERE CAR_RSV_SID=?),?,?,?," +
						   "		?,?,?,?,?," +
						   "		CURRENT TIMESTAMP,?" +
						   ")");
		
	
		
		arr_sql[5].append("")
				  .append("UPDATE SALES.TRV050			\n")
				  .append("	SET								\n")
				  .append("		CARGO_NAME = ?				\n")
				  .append("		,CARGO_SIZE = ?				\n")
				  .append("		,CARGO_UNIT = ?				\n")
				  .append("		,CARGO_WEIGHT = ?			\n")
				  .append("		,CARGO_QTY = ?				\n")
				  .append("		,CARGO_PRICE = ?				\n")
				  .append("		,CARGO_AMT = ? 				\n")
				  .append("		,U_EMPNO = ?					\n")
				  .append("		,U_DATE = CURRENT TIMESTAMP	\n")
				  .append("		,U_IP = ?					\n")
				  .append("WHERE 1=1 						\n")
				  .append("	AND CAR_RSV_SID=? AND KEY_SEQ = ?	\n");
		
		arr_sql[6].append("")
				  .append("DELETE FROM SALES.TRV050 WHERE CAR_RSV_SID= ? AND KEY_SEQ = ?");
				  
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		System.out.println("# Command : 선조회");

		
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
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
							}

							rs = stmt.executeQuery();		// Query 실행
							getDataSet(rs, ds1).flush();
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
		String sClientSid 		= HDUtil.nullCheckStr(req.getParameter("sClientSid"));				// 협력업체
		String sSaupSid 		= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));			// 사업 Sid
		String sFromAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sFromAcceptDate")); 	// 신청일자 From
		String sToAcceptDate 	= HDUtil.nullCheckStr(req.getParameter("sToAcceptDate")); 		// 신청일자 To
		String sAcceptNo 		= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));					// 신청서번호  
		String sAcceptSid		= HDUtil.nullCheckStr(req.getParameter("sAcceptSid")); // 신청 SID
		int sCarRsvSid 			= HDUtil.nullCheckNum(req.getParameter("sCarRsvSid"));
		
		StringUtil.printMsg("협력업체",sClientSid,this);
		StringUtil.printMsg("신청일자 To ",sToAcceptDate,this);
		StringUtil.printMsg("신청일자 From ",sFromAcceptDate,this);
		StringUtil.printMsg("신청서번호 ", sAcceptNo, this);
		StringUtil.printMsg("신청서번호 ", sAcceptSid, this);
		StringUtil.printMsg("사업소 ", sSaupSid, this);
		
		try {
			int sCnt1 = 1;
			int sCnt2 = 1;
			int sCnt3 = 1;
			
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					  
					if ("DS1".equals(gauceName)) {
	
						if (!"".equals(sClientSid)) { /* 매출처SID */
							arr_sql[1].append("    AND  T1.CLIENT_SID  = ?					\n");	
						}
						
						if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate)) { /* 신청일자  */   
							arr_sql[1].append("  AND T1.ACCEPT_DATE BETWEEN ? AND ?		\n");	 
						}
						
						if (!"".equals(sAcceptNo)) { 	/* 신청서번호*/ 
							arr_sql[1].append("  AND T1.ACCEPT_NO   LIKE   ?			\n");   
						}
						
						if (!"".equals(sSaupSid)) { 	/* 사업SID */ 
							arr_sql[1].append("  AND T1.SAUP_SID =   ?			\n");   
						}
						
		
				  		 // 쿼리 실행
				  		 
				  		StringUtil.printMsg("QUERY",arr_sql[1].toString(),this);
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
				  		// 조건
				  		if (!"".equals(sClientSid)) { /* 매출처SID */
					  		stmt.setString(sCnt1++, sClientSid );	
					  		 
						}
				  		if (!"".equals(sToAcceptDate) && !"".equals(sFromAcceptDate)) { /* 신청일자  */   
							stmt.setString(sCnt1++, sFromAcceptDate );			// to
							stmt.setString(sCnt1++, sToAcceptDate);			// from 
						}
				  		if (!"".equals(sAcceptNo)) { 	/* 신청서번호*/ 
				  			stmt.setString(sCnt1++, sAcceptNo + "%");	
						}
				  		
				  		if (!"".equals(sSaupSid)) { 	/* 사업SID */ 
				  			stmt.setInt(sCnt1++, Integer.parseInt(sSaupSid));
				  		}
					} 
					
					/*
					 * 차량
					 */
					
					if ("DS2".equals(gauceName)) {
						
						if (!"".equals(sAcceptSid)) { 
							arr_sql[2].append("		AND T1.ACCEPT_SID = ? \n");	/* 신청 SID */
						} 
				  		 // 쿼리 실행
					
						arr_sql[2].append("ORDER BY T1.CAR_RSV_SID				\n");
						
						StringUtil.printMsg("QUERY DS2",arr_sql[2].toString(),this);
				  		stmt = conn.getGauceStatement(arr_sql[2].toString()); 
				  		
				  		// 조건
				  		
				  		if (!"".equals(sAcceptSid)) { 
				  			stmt.setInt(sCnt2++, Integer.parseInt(sAcceptSid));			 /* 신청SID     */     
						} 
					} 
					
					/*
					 * 화물
					 */
				
					if ("DS3".equals(gauceName)) {
				  		StringUtil.printMsg("QUERY DS3",arr_sql[3].toString(),this);
				  		stmt = conn.getGauceStatement(arr_sql[3].toString()); 
				  		StringUtil.printMsg("=====================================",this);
				  		// 조건
				  		if (!"".equals(sAcceptSid)) {
				  			stmt.setInt(sCnt3++, sCarRsvSid);			 /* 신청SID     */     
						}
					}
					
					rs = stmt.executeQuery();		// Query 실행
					
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
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		if (iParamIp.length() > 13) {
			 iParamIp = "RV250I IP".substring(0,13);	
		}
		
		/* DataSet */
		GauceDataSet ds3 = req.getGauceDataSet("DS3");
		
		
		try{
			
			if (ds3 != null) {
				GauceDataRow[] 	rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
			
				int colNm_CarRsv_sid            = ds3.indexOfColumn("CAR_RSV_SID"); 	/* 차량예약 SID	*/
				int colNm_KeySeq                = ds3.indexOfColumn("KEY_SEQ");			/* 순번			*/
				int colNm_CargoName             = ds3.indexOfColumn("CARGO_NAME");	 	/* 화물품명		*/ 
				int colNm_CargoSize             = ds3.indexOfColumn("CARGO_SIZE");		/* 화물규격		*/
				int colNm_CargoUnit             = ds3.indexOfColumn("CARGO_UNIT");		/* 화물단위		*/
				int colNm_CargoWeight           = ds3.indexOfColumn("CARGO_WEIGHT"); 	/* 화물중량		*/
				int colNm_CargoQty              = ds3.indexOfColumn("CARGO_QTY"); 		/* 화물수량		*/
				int colNm_CargoPrice            = ds3.indexOfColumn("CARGO_PRICE"); 	/* 화물단가		*/
				int colNm_CargoAmt              = ds3.indexOfColumn("CARGO_AMT"); 		/* 화물금액		*/
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							
							StringUtil.printMsg(arr_sql[4].toString(),this);
							stmt = conn.getGauceStatement(arr_sql[4].toString());
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(iCnt++, colNm_CarRsv_sid);
							stmt.bindColumn(iCnt++, colNm_CarRsv_sid);
							stmt.bindColumn(iCnt++, colNm_CargoName);
							stmt.bindColumn(iCnt++, colNm_CargoSize);
							stmt.bindColumn(iCnt++, colNm_CargoUnit);
							stmt.bindColumn(iCnt++, colNm_CargoWeight);
							stmt.bindColumn(iCnt++, colNm_CargoQty);
							stmt.bindColumn(iCnt++, colNm_CargoPrice);
							stmt.bindColumn(iCnt++, colNm_CargoAmt);
							stmt.setString(iCnt++, iParamEmpno);
							stmt.setString(iCnt++, iParamIp);
							
							// 쿼리실행
							stmt.executeUpdate();
							
							stmt.close();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							StringUtil.printMsg(arr_sql[5].toString(),this);
							stmt = conn.getGauceStatement(arr_sql[5].toString());
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_CargoName);
							stmt.bindColumn(uCnt++, colNm_CargoSize);
							stmt.bindColumn(uCnt++, colNm_CargoUnit);
							stmt.bindColumn(uCnt++, colNm_CargoWeight);
							stmt.bindColumn(uCnt++, colNm_CargoQty);
							stmt.bindColumn(uCnt++, colNm_CargoPrice);
							stmt.bindColumn(uCnt++, colNm_CargoAmt);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.setString(uCnt++, iParamIp);
							stmt.bindColumn(uCnt++, colNm_CarRsv_sid);
							stmt.bindColumn(uCnt++, colNm_KeySeq);
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							
							stmt.close();
							
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[6].toString());
							
							stmt.setGauceDataRow(rows[i]);
							
							
							stmt.bindColumn(dCnt++, colNm_CarRsv_sid);
							stmt.bindColumn(dCnt++, colNm_KeySeq);
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							
							stmt.close();
							
							break;
					} 
				} 
			} 
			
			
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}

	}

}
