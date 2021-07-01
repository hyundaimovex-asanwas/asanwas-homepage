package sales.menu.rv;


import java.sql.CallableStatement;
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
import sales.common.StringUtil;
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

public class Rv420I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//사업소
		arr_sql[0].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//	출경시간	
		arr_sql[1].append ("SELECT ''                 AS DEPART_TIME,				\n")
					.append ("		'전체'             AS DEPART_TIME_NM				\n")
					.append ("FROM SYSIBM.SYSDUMMY1				\n")
					.append ("UNION ALL				\n")
					.append ("SELECT DETAIL,				\n")
					.append ("		DETAIL_NM				\n")
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD  = 'RM014'				\n")
					.append ("	AND ITEM1 = 'Y'					\n");
		
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM SYSIBM.SYSDUMMY1					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");
		
		//고객구분
		arr_sql[3].append ("SELECT										\n")
					.append ("	'' DETAIL, '전체' DETAIL_NM    \n")
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		
		//취소코드
		arr_sql[4].append ("SELECT DETAIL        AS    CANCEL_CD,			\n")
					.append ("		DETAIL_NM     AS    CANCEL_NM			\n")
					.append ("FROM SALES.TSY010			\n")
					.append ("WHERE HEAD  = 'RV005'			\n")
					.append ("	AND ITEM1 = 'Y'					\n");
   }

    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		System.out.println("# Command : 선조회");

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sUpjangSid	= HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));
		

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
								System.out.println(arr_sql[1].toString());
								stmt = conn.getGauceStatement(arr_sql[1].toString());
							} 							
							if(gauceName.equals("DS4")){
								System.out.println(arr_sql[2].toString());
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								stmt.setString(1, sSaupSid);								
							} 												
							if(gauceName.equals("DS5")){
								System.out.println(arr_sql[3].toString());
								stmt = conn.getGauceStatement(arr_sql[3].toString());
							} 												
							if(gauceName.equals("DS6")){
								System.out.println(arr_sql[4].toString());
								stmt = conn.getGauceStatement(arr_sql[4].toString());
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
						                v_rowcnt++ ;
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
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
			String 	sAcceptNo	= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
			String 	sCustGu	= HDUtil.nullCheckStr(req.getParameter("sCustGu"));
			String 	sSRejectYn	= HDUtil.nullCheckStr(req.getParameter("sSRejectYn"));
			String 	sNRejectYn	= HDUtil.nullCheckStr(req.getParameter("sNRejectYn"));
			String 	sCustNm	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));
			
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
							
							System.out.println("call SALES.PR_RV420I_01");
							cstmt = conn.prepareCall("{call SALES.PR_RV420I_01(?, ?, ?, ?, ?, ?, ?, ?, ?) }");
							
							cstmt.setString(1, sBgnDate);
							cstmt.setString(2, sDepartTime);
							cstmt.setInt(3, Integer.parseInt(sSaupSid));
							cstmt.setInt(4, Integer.parseInt(sGoodsSid));
							cstmt.setString(5, sAcceptNo);
							cstmt.setString(6, sCustGu);
							cstmt.setString(7, sSRejectYn);
							cstmt.setString(8, sNRejectYn);
							cstmt.setString(9, sCustNm);							
							rs = cstmt.executeQuery();							
							
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
							if(cstmt!=null) cstmt.close();
		
							System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
							break;
					}
				}
				ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.				
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
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
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;	
		boolean fail=false;				

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				
				int colNm_SouthPermitYn                = inputDs.indexOfColumn("SOUTH_PERMIT_YN");
				int colNm_NorthPermitYn                = inputDs.indexOfColumn("NORTH_PERMIT_YN");
				int colNm_CancelCd              = inputDs.indexOfColumn("CANCEL_CD");
				int colNm_AcceptNo              = inputDs.indexOfColumn("ACCEPT_NO");
				int colNm_CustNm                = inputDs.indexOfColumn("CUST_NM");
				int colNm_ManageNo              = inputDs.indexOfColumn("MANAGE_NO");
				int colNm_EducDt                = inputDs.indexOfColumn("EDUC_DT");
				int colNm_TelNo                 = inputDs.indexOfColumn("TEL_NO");
				int colNm_RoomType_cd           = inputDs.indexOfColumn("ROOM_TYPE_CD");
				int colNm_CompanyNm             = inputDs.indexOfColumn("COMPANY_NM");
				int colNm_Positions             = inputDs.indexOfColumn("POSITIONS");
				int colNm_RsvSid                = inputDs.indexOfColumn("RSV_SID");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				inner : {
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall("{call SALES.PR_RV420I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
						
							cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
							if ( rows[i].getString(colNm_SouthPermitYn).equals("T") )
								cstmt.setString(2, "Y");							
							else
								cstmt.setString(2, "N");	
							if ( rows[i].getString(colNm_NorthPermitYn).equals("T") )
								cstmt.setString(3, "Y");							
							else
								cstmt.setString(3, "N");						
							cstmt.setString(4, rows[i].getString(colNm_CancelCd));
							cstmt.setString(5, iParamEmpno);
							cstmt.setString(6, iParamIp);
							cstmt.setString(7, "3");
							cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 						
		
							cstmt.executeUpdate();
							
							//메시지처리
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(10));
									msgDS.addDataRow(row);
								}
							} else {
								StringUtil.printMsg("실패메시지",cstmt.getString(10),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();
								row.addColumnValue(cstmt.getString(10));							
								msgDS.addDataRow(row);
								fail = true;
								break inner;						
							}  	
							
							if(cstmt!=null) cstmt.close();
							break;
						}
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();
			if(cstmt!=null) cstmt.close();			
			if( fail == true ) throw new Exception("");			
		}
	}

}
