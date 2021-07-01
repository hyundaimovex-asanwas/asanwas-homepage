package sales.menu.ml;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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
import sales.common.SuperServlet;
import sales.common.StringUtil;

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

public class Ml150I extends SuperServlet {

	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
	public void makeSql(){
		//StringUtil.printMsg("# Command","sql 생성",this);    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
		//	Master 조회
		//	arr_sql[1].append ("{call SALES.PR_RV270I_03(?, ?, ?,?)}");
		//	Detail 조회
		//		arr_sql[2].append ("{call SALES.PR_RV270I_04(?,?)}");
		//	이용일자 조회
		//		arr_sql[3].append ("{call SALES.PR_RV270I_05(?)}");
		//	요청등록_서비스(trv030) 저장
			  arr_sql[4].append ("{call SALES.PR_ML150I_05(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?)}");
				
				  
   }
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
//		StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		String 	sEmpNo	= HDUtil.nullCheckStr(req.getParameter("sEmpNo"));
		String 	sUserNm	= HDUtil.nullCheckStr(req.getParameter("sUserNm"));			
		String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
		String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));
		String 	sOrderNo	= HDUtil.nullCheckStr(req.getParameter("sOrderNo"));
		String 	sCate1		= HDUtil.nullCheckStr(req.getParameter("sCate1"));
		/*
		StringUtil.printMsg("sEmpNo:::" ,sEmpNo, this);
		StringUtil.printMsg("sUserNm:::" , sUserNm, this);
		StringUtil.printMsg("sBgnDate:::" , sBgnDate, this);
		StringUtil.printMsg("sEndDate:::" , sEndDate, this);
		StringUtil.printMsg("sOrderNo:::" , sOrderNo, this);
		StringUtil.printMsg("sCate1:::" , sCate1, this);
		*/
		try {
			Iterator it = req.getGauceDataSetKeys();
			// 검색시 조건
			// dataset 구분 param
			while(it.hasNext()){
					String gauceName = (String)it.next();
					ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
							//StringUtil.printMsg("DEFAULT:::" , "DEFAULT", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_01(?,?,?,?,?) }");
							cstmt.setString(1, sEmpNo);
							cstmt.setString(2, sUserNm);
							cstmt.setString(3, "20100101");
							cstmt.setString(4, "20100101");
							cstmt.setString(5, sOrderNo);
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					
					} else if(gauceName.equals("MASTER")){	
							//StringUtil.printMsg("DS_MASTER:::" , "DS_MASTER", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_02(?) }");
							cstmt.setString(1, sCate1);
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("DETAIL")){
							//StringUtil.printMsg("DETAIL:::" , "DETAIL", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_03(?,?,?,?,?) }");
							cstmt.setString(1, sEmpNo);
							cstmt.setString(2, sUserNm);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate);
							cstmt.setString(5, sOrderNo);
								
							rs = cstmt.executeQuery();
							getDataSet(rs, ds1).flush();						
					} else{
						throw new Exception ("알수 없는 DataSet Name입니다.");
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
			//if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();			
		}
	}	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","조회",this);		
		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		
		String 	sEmpNo	= HDUtil.nullCheckStr(req.getParameter("sEmpNo"));
		String 	sUserNm	= HDUtil.nullCheckStr(req.getParameter("sUserNm"));			
		String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
		String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));
		String 	sOrderNo	= HDUtil.nullCheckStr(req.getParameter("sOrderNo"));
		String 	sCate1		= HDUtil.nullCheckStr(req.getParameter("sCate1"));
		String 	sOrderDate	= HDUtil.nullCheckStr(req.getParameter("sOrderDate"));
		/*
		StringUtil.printMsg("sEmpNo:::" ,sEmpNo, this);
		StringUtil.printMsg("sUserNm:::" , sUserNm, this);
		StringUtil.printMsg("sBgnDate:::" , sBgnDate, this);
		StringUtil.printMsg("sEndDate:::" , sEndDate, this);
		StringUtil.printMsg("sOrderNo:::" , sOrderNo, this);
		StringUtil.printMsg("sCate1:::" , sCate1, this);
		StringUtil.printMsg("sOrderDate:::" , sOrderDate, this);
		*/
		try {
			Iterator it = req.getGauceDataSetKeys();
			// 검색시 조건
			// dataset 구분 param
			while(it.hasNext()){
					String gauceName = (String)it.next();
					ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
							//StringUtil.printMsg("DEFAULT:::" , "DEFAULT", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_01(?,?,?,?,?) }");
							cstmt.setString(1, sEmpNo);
							cstmt.setString(2, sUserNm);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate);
							cstmt.setString(5, sOrderNo);
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					
					} else if(gauceName.equals("MASTER")){	
							//StringUtil.printMsg("DS_MASTER:::" , "DS_MASTER", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_02(?) }");
							cstmt.setString(1, sCate1);
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("DETAIL")){
							//StringUtil.printMsg("DETAIL:::" , "DETAIL", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_03(?,?,?,?,?) }");
							cstmt.setString(1, sEmpNo);
							cstmt.setString(2, sUserNm);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate);
							cstmt.setString(5, sOrderNo);
								
							rs = cstmt.executeQuery();
							getDataSet(rs, ds1).flush();	
					} else if(gauceName.equals("DETAIL2")){
							//StringUtil.printMsg("DETAIL2:::" , "DETAIL2", this);
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_06(?,?) }");
							cstmt.setString(1, sOrderNo);
							cstmt.setString(2, sOrderDate);
							
							rs = cstmt.executeQuery();
							getDataSet(rs, ds1).flush();						
					}else if(gauceName.equals("DEFAULT2")){
					//StringUtil.printMsg("DETAIL2:::" , "DETAIL2", this);
					cstmt = conn.prepareCall("{call SALES.PR_ML150I_07(?,?) }");
					cstmt.setString(1, sOrderNo);
					cstmt.setString(2, sOrderDate);
							
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();	 
					}else{
						throw new Exception ("알수 없는 DataSet Name입니다.");
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
			//if(stmt!=null) stmt.close();
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
		//StringUtil.printMsg("# Command","저장",this);
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = null;
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;		
		String reqNo="";
		ResultSet rs = null;
		boolean fail=false;
		
		String 	sRsvPayYn = "";
		String 	sJobStatus = "";
				
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;

		// tml200 제어.
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				//StringUtil.printMsg("gauceName::::::::::::::::::::::::::::",gauceName,this);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						int colNm_OrderDate              = ds1.indexOfColumn("ORDER_DATE");
						int colNm_OrderNo               = ds1.indexOfColumn("ORDER_NO");
						int colNm_UserNm            = ds1.indexOfColumn("USER_NM");
						int colNm_OrdererCompany            = ds1.indexOfColumn("ORDERER_COMPANY");				
						int colNm_Remarks              = ds1.indexOfColumn("REMARKS");
						int colNm_OrderSid              = ds1.indexOfColumn("ORDER_SID");
						
						
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				
				//블록번호
				res.enableFirstRow(reqNoDS);
				reqNoDS.addDataColumn(new GauceDataColumn("order_no", GauceDataColumn.TB_STRING));

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						/*
						StringUtil.printMsg("call","SALES.PR_ML150I_04-INSERT",this);
						StringUtil.printMsg("colNm_OrderSid",rows[i].getString(colNm_OrderSid),this);
						StringUtil.printMsg("colNm_OrderDate",rows[i].getString(colNm_OrderDate),this);
						StringUtil.printMsg("colNm_OrderNo",rows[i].getString(colNm_OrderNo),this);
						StringUtil.printMsg("colNm_UserNm",rows[i].getString(colNm_UserNm),this);
						StringUtil.printMsg("colNm_OrdererCompany",rows[i].getString(colNm_OrdererCompany),this);
						StringUtil.printMsg("colNm_Remarks",rows[i].getString(colNm_Remarks),this);
						*/
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);
						
						cstmt = conn.prepareCall("{call SALES.PR_ML150I_04(?,?,?,?,?,   ?,?,?,?,?,        ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_OrderNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_OrderDate));
						cstmt.setString(3, rows[i].getString(colNm_UserNm));						
						cstmt.setString(4, rows[i].getString(colNm_OrdererCompany));
						cstmt.setString(5, rows[i].getString(colNm_Remarks));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, "1");
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.setInt(11, rows[i].getInt(colNm_OrderSid));	
						
						cstmt.executeUpdate();
						
						//order_sid = cstmt.getBigDecimal(11).intValue();
						
						GauceDataRow row = reqNoDS.newDataRow();
						row.addColumnValue(cstmt.getString(1));						
						reqNoDS.addDataRow(row);
						
						//메시지처리
						if (!cstmt.getString(8).equals("Y") ) 
							throw new Exception(cstmt.getString(17));
						
						if (cstmt.getString(8).equals("Y") ) {
							if ( !cstmt.getString(9).equals("0000") ) {
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(10));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","SALES.PR_ML150I_04-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_ML150I_04(?,?,?,?,?,   ?,?,?,?,?,        ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_OrderNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_OrderDate));
						cstmt.setString(3, rows[i].getString(colNm_UserNm));						
						cstmt.setString(4, rows[i].getString(colNm_OrdererCompany));
						cstmt.setString(5, rows[i].getString(colNm_Remarks));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, "3");
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.setInt(11, rows[i].getInt(colNm_OrderSid));
						
						cstmt.executeUpdate();
						
						//메시지처리
							if (!cstmt.getString(8).equals("Y") ) 
								throw new Exception(cstmt.getString(17));
						
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									GauceDataRow row2 = msgDS.newDataRow();									
									row2.addColumnValue(cstmt.getString(10));
									msgDS.addDataRow(row2);
								}
							}  
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
					//StringUtil.printMsg("call","SALES.PR_ML150I_04-DELETE",this);
					/*
					StringUtil.printMsg("call","SALES.PR_RV270i_06-DELETE",this);
					StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
					StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
					StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
					StringUtil.printMsg("colNm_AcceptTime",rows[i].getString(colNm_AcceptTime),this);
					StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
					StringUtil.printMsg("colNm_ClientDam_nm",rows[i].getString(colNm_ClientDam_nm),this);
					StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
					StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
					StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
					StringUtil.printMsg("colNm_AcceptNo",rows[i].getString(colNm_AcceptNo),this);
					StringUtil.printMsg("colNm_RsvSid",rows[i].getString(colNm_RsvSid),this);
					StringUtil.printMsg("colNm_CustSid",rows[i].getString(colNm_CustSid),this);
					StringUtil.printMsg("colNm_CustNm",rows[i].getString(colNm_CustNm),this);
					StringUtil.printMsg("colNm_ManageNo",rows[i].getString(colNm_ManageNo),this);
						*/					
						
						cstmt = conn.prepareCall("{call SALES.PR_ML150I_04(?,?,?,?,?,   ?,?,?,?,?,        ?  ) }");
						
						cstmt.setString(1, rows[i].getString(colNm_OrderNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_OrderDate));
						cstmt.setString(3, rows[i].getString(colNm_UserNm));						
						cstmt.setString(4, rows[i].getString(colNm_OrdererCompany));
						cstmt.setString(5, rows[i].getString(colNm_Remarks));
						cstmt.setString(6, iParamEmpno);
						cstmt.setString(7, "2");
						cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
						cstmt.setInt(11, rows[i].getInt(colNm_OrderSid));
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (!cstmt.getString(8).equals("Y") ) 
							throw new Exception(cstmt.getString(17));
						
						if (cstmt.getString(8).equals("Y") ) {
							if ( !cstmt.getString(9).equals("0000") ) {
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(10));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				reqNoDS.flush();
				
				//tml210 제어.
			}else if(gauceName.equals("DETAIL")){
					int colNm_OrderSid              = ds1.indexOfColumn("ORDER_SID");
					int colNm_OrderSeq              = ds1.indexOfColumn("ORDER_SEQ");
					int colNm_ItemSid              = ds1.indexOfColumn("ITEM_SID");
					int colNm_ItemNm              = ds1.indexOfColumn("ITEM_NM");
					int colNm_AmtUsed            = ds1.indexOfColumn("AMT_USED");
					int colNm_AmtCurrCd         = ds1.indexOfColumn("AMT_CURR_CD");				
					int colNm_ExchRate           = ds1.indexOfColumn("EXCH_RATE");
					int colNm_OrderCnt            = ds1.indexOfColumn("ORDER_CNT");				
					int colNm_SumAmt             = ds1.indexOfColumn("SUM_AMT");
								
					GauceDataRow[] 		rows = ds1.getDataRows();
					GauceDataColumn[] 	cols = ds1.getDataColumns();
								
					//메시지처리
					res.enableFirstRow(msgDS);
					msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
								
					//블록번호
					//res.enableFirstRow(reqNoDS);
					//reqNoDS.addDataColumn(new GauceDataColumn("req_no", GauceDataColumn.TB_STRING));
				
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
										
							/*
							StringUtil.printMsg("call","SALES.PR_ML150I_05-INSERT",this);
							StringUtil.printMsg("colNm_OrderSid",rows[i].getString(colNm_OrderSid),this);
							StringUtil.printMsg("colNm_OrderSeq",rows[i].getString(colNm_OrderSeq),this);
							StringUtil.printMsg("colNm_ItemSid",rows[i].getString(colNm_ItemSid),this);
							StringUtil.printMsg("colNm_ItemNm",rows[i].getString(colNm_ItemNm),this);
							StringUtil.printMsg("colNm_AmtUsed",rows[i].getString(colNm_AmtUsed),this);
							StringUtil.printMsg("colNm_AmtCurrCd",rows[i].getString(colNm_AmtCurrCd),this);
							StringUtil.printMsg("colNm_ExchRate",rows[i].getString(colNm_ExchRate),this);
							StringUtil.printMsg("colNm_OrderCnt",rows[i].getString(colNm_OrderCnt),this);
							StringUtil.printMsg("colNm_SumAmt",rows[i].getString(colNm_SumAmt),this);
							*/
							//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);
										
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_05(?,?,?,?,?,   ?,?,?,?,?      ,?,?,?,?,?) }");
										
							cstmt.setInt(1, rows[i].getInt(colNm_ItemSid));										
							cstmt.setString(2, rows[i].getString(colNm_ItemNm));
							cstmt.setInt(3, rows[i].getInt(colNm_AmtUsed));
							cstmt.setString(4, rows[i].getString(colNm_AmtCurrCd));
							cstmt.setInt(5, rows[i].getInt(colNm_ExchRate));
							cstmt.setInt(6, rows[i].getInt(colNm_OrderCnt));
							cstmt.setString(7, "1");
							cstmt.setString(8, iParamEmpno);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);						
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.setInt(12, i+1);										
							cstmt.setInt(13, rows[i].getInt(colNm_OrderSid));
							cstmt.setInt(14, rows[i].getInt(colNm_SumAmt));
							cstmt.setInt(15, rows[i].getInt(colNm_OrderSeq));
							cstmt.executeUpdate();
										
							//GauceDataRow row = reqNoDS.newDataRow();
							//row.addColumnValue(cstmt.getString(1));						
							//reqNoDS.addDataRow(row);
										
							//메시지처리
							if (!cstmt.getString(9).equals("Y") ) 
								throw new Exception(cstmt.getString(11));
										
							if (cstmt.getString(9).equals("Y") ) {
								if ( !cstmt.getString(10).equals("0000") ) {
									GauceDataRow row2 = msgDS.newDataRow();									
									row2.addColumnValue(cstmt.getString(11));
									msgDS.addDataRow(row2);
								}
							}  
										
							if(cstmt!=null) cstmt.close();						
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							/*
							StringUtil.printMsg("call","SALES.PR_ML150I_05-UPDATE",this);
							StringUtil.printMsg("colNm_OrderSid",rows[i].getString(colNm_OrderSid),this);
							StringUtil.printMsg("colNm_OrderSeq",rows[i].getString(colNm_OrderSeq),this);
							StringUtil.printMsg("colNm_ItemSid",rows[i].getString(colNm_ItemSid),this);
							StringUtil.printMsg("colNm_ItemNm",rows[i].getString(colNm_ItemNm),this);
							StringUtil.printMsg("colNm_AmtUsed",rows[i].getString(colNm_AmtUsed),this);
							StringUtil.printMsg("colNm_AmtCurrCd",rows[i].getString(colNm_AmtCurrCd),this);
							StringUtil.printMsg("colNm_ExchRate",rows[i].getString(colNm_ExchRate),this);
							StringUtil.printMsg("colNm_OrderCnt",rows[i].getString(colNm_OrderCnt),this);
							StringUtil.printMsg("colNm_SumAmt",rows[i].getString(colNm_SumAmt),this);
							*/		
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_05(?,?,?,?,?,   ?,?,?,?,?      ,?,?,?,?,?) }");
										
							cstmt.setInt(1, rows[i].getInt(colNm_ItemSid));										
							cstmt.setString(2, rows[i].getString(colNm_ItemNm));
							cstmt.setInt(3, rows[i].getInt(colNm_AmtUsed));
							cstmt.setString(4, rows[i].getString(colNm_AmtCurrCd));
							cstmt.setInt(5, rows[i].getInt(colNm_ExchRate));
							cstmt.setInt(6, rows[i].getInt(colNm_OrderCnt));
							cstmt.setString(7, "3");
							cstmt.setString(8, iParamEmpno);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);						
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.setInt(12, i+1);
							cstmt.setInt(13, rows[i].getInt(colNm_OrderSid));
							cstmt.setInt(14, rows[i].getInt(colNm_SumAmt));
							cstmt.setInt(15, rows[i].getInt(colNm_OrderSeq));
											
							cstmt.executeUpdate();
											
							
											
							//메시지처리
							if (!cstmt.getString(9).equals("Y") ) 
								throw new Exception(cstmt.getString(11));
											
							if (cstmt.getString(9).equals("Y") ) {
								if ( !cstmt.getString(10).equals("0000") ) {
									GauceDataRow row2 = msgDS.newDataRow();									
									row2.addColumnValue(cstmt.getString(11));
									msgDS.addDataRow(row2);
								}
							}  
										
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
						
						//StringUtil.printMsg("call","SALES.PR_RV270i_06-DELETE",this);
										
										
							cstmt = conn.prepareCall("{call SALES.PR_ML150I_05(?,?,?,?,?,   ?,?,?,?,?      ,?,?,?,?,?) }");
										
							cstmt.setInt(1, rows[i].getInt(colNm_ItemSid));										
							cstmt.setString(2, rows[i].getString(colNm_ItemNm));
							cstmt.setInt(3, rows[i].getInt(colNm_AmtUsed));
							cstmt.setString(4, rows[i].getString(colNm_AmtCurrCd));
							cstmt.setInt(5, rows[i].getInt(colNm_ExchRate));
							cstmt.setInt(6, rows[i].getInt(colNm_OrderCnt));
							cstmt.setString(7, "2");
							cstmt.setString(8, iParamEmpno);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);						
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
							cstmt.setInt(12, i+1);
							cstmt.setInt(13, rows[i].getInt(colNm_OrderSid));
							cstmt.setInt(14, rows[i].getInt(colNm_SumAmt));
							cstmt.setInt(15, rows[i].getInt(colNm_OrderSeq));																		
							cstmt.executeUpdate();
											
							//메시지처리
							if (!cstmt.getString(9).equals("Y") ) 
								throw new Exception(cstmt.getString(11));
											
							if (cstmt.getString(9).equals("Y") ) {
								if ( !cstmt.getString(10).equals("0000") ) {
									GauceDataRow row2 = msgDS.newDataRow();									
									row2.addColumnValue(cstmt.getString(11));
									msgDS.addDataRow(row2);
								}
							}  
										
							if(cstmt!=null) cstmt.close();	
							break;						
						}
					}
					
				}
			}
		}reqNoDS.flush();
	} catch (SQLException sqle){
		throw sqle;
	} catch (Exception e) {
		throw e;
	} finally {
		msgDS.flush();
		if(rs!=null) rs.close();
		if(stmt!=null) stmt.close();			
		if(cstmt!=null) cstmt.close();
		if( fail == true ) throw new Exception("");			
	}
}
}