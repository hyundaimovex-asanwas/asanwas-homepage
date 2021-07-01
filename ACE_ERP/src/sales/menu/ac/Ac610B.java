package sales.menu.ac;


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

public class Ac610B extends SuperServlet {

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
		
		//상품
		arr_sql[1].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM SYSIBM.SYSDUMMY1					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");
   }

    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
		String 	sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));
		String 	sClass	= HDUtil.nullCheckStr(req.getParameter("sClass"));	

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[0].toString());
							} 
							if(gauceName.equals("DS3")){
								//StringUtil.printMsg("arr_sql[1]",arr_sql[1].toString(),this);								
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, sSaupSid);
							} 							
								rs = stmt.executeQuery(); // DataSet set
								getDataSet(rs, ds1).flush();
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
		//StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
			String 	sClientSid	= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
			String 	sJobYymm	= HDUtil.nullCheckStr(req.getParameter("sJobYymm"));
			String 	sAcceptNo	= HDUtil.nullCheckStr(req.getParameter("sAcceptNo"));
			String 	sSalDamSid	= HDUtil.nullCheckStr(req.getParameter("sSalDamSid"));
			
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
							
							//StringUtil.printMsg("call SALES.PR_AC610B_01","call SALES.PR_AC610B_01",this);
							//StringUtil.printMsg("sSalDamSid",sSalDamSid,this);
							cstmt = conn.prepareCall("{call SALES.PR_AC610B_02(?, ?, ?, ?, ?, ?) }");							
							cstmt.setInt(1, Integer.parseInt(sSaupSid));
							cstmt.setInt(2, Integer.parseInt(sGoodsSid));
							cstmt.setInt(3, Integer.parseInt(sClientSid));
							cstmt.setString(4, sJobYymm);
							cstmt.setString(5, sAcceptNo); 
							cstmt.setInt(6, Integer.parseInt(sSalDamSid));
						
							rs = cstmt.executeQuery(); 							
							
							rsmd = rs.getMetaData();
							getDataSet(rs, ds1).flush();
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
		GauceDataSet inputDs2 = req.getGauceDataSet("DSCREATE");		
		CallableStatement cstmt = null;		
		GauceDataSet ds9 = req.getGauceDataSet("DS9");
		boolean fail=false;			
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				
				int colNm_ClientCd              = inputDs.indexOfColumn("CLIENT_CD");
				int colNm_ClientNm              = inputDs.indexOfColumn("CLIENT_NM");
				int colNm_DepartDate            = inputDs.indexOfColumn("DEPART_DATE");
				int colNm_GoodsNm               = inputDs.indexOfColumn("GOODS_NM");
				int colNm_AcceptNo              = inputDs.indexOfColumn("ACCEPT_NO");
				int colNm_TourAmt               = inputDs.indexOfColumn("TOUR_AMT");
				int colNm_PayAmt                = inputDs.indexOfColumn("PAY_AMT");
				int colNm_CommRate              = inputDs.indexOfColumn("COMM_RATE");
				int colNm_CommAmt               = inputDs.indexOfColumn("COMM_AMT");
				int colNm_ContAmt               = inputDs.indexOfColumn("CONT_AMT");
				int colNm_SaleAmt               = inputDs.indexOfColumn("SALE_AMT");
				int colNm_TaxAmt                = inputDs.indexOfColumn("TAX_AMT");
				int colNm_TotAmt                = inputDs.indexOfColumn("TOT_AMT");
				int colNm_Fsnbr                 = inputDs.indexOfColumn("COMM_CD");
				int colNm_JobYymm               = inputDs.indexOfColumn("JOB_YYMM");
				int colNm_AcceptSid             = inputDs.indexOfColumn("ACCEPT_SID");
				int colNm_SalDamSid				= inputDs.indexOfColumn("SAL_DAM_SID");
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(ds9);
				ds9.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));						
				
				inner : {
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call SALES.PR_AC610B_03","call SALES.PR_AC610B_03",this);						
							cstmt = conn.prepareCall("{call SALES.PR_AC610B_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
							
							cstmt.setString(1, rows[i].getString(colNm_JobYymm));
							cstmt.setInt(2, rows[i].getInt(colNm_AcceptSid));
							cstmt.setInt(3, rows[i].getInt(colNm_TourAmt));
							cstmt.setInt(4, rows[i].getInt(colNm_PayAmt));
							cstmt.setInt(5, rows[i].getInt(colNm_CommRate));
							cstmt.setInt(6, rows[i].getInt(colNm_CommAmt));
							cstmt.setInt(7, rows[i].getInt(colNm_ContAmt));
							cstmt.setInt(8, rows[i].getInt(colNm_SaleAmt));
							cstmt.setInt(9, rows[i].getInt(colNm_TaxAmt));
							cstmt.setInt(10, rows[i].getInt(colNm_TotAmt));
							cstmt.setString(11, rows[i].getString(colNm_Fsnbr));
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
	
							//메시지처리
							if (cstmt.getString(14).equals("Y") ) {
								if ( !cstmt.getString(15).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(16),this);
									GauceDataRow row2 = ds9.newDataRow();									
									row2.addColumnValue(cstmt.getString(15));
									ds9.addDataRow(row2);
								}
							} else {
								//StringUtil.printMsg("실패메시지",cstmt.getString(16),this);								
								conn.rollback();
								GauceDataRow row2 = ds9.newDataRow();								
								row2.addColumnValue(cstmt.getString(16));
								ds9.addDataRow(row2);
								fail = true;
								break inner;						
							} 
							
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call SALES.PR_AC610B_04","call SALES.PR_AC610B_04",this);						
							cstmt = conn.prepareCall("{call SALES.PR_AC610B_04(?, ?, ?, ?) }");						
							
							cstmt.setString(1, rows[i].getString(colNm_JobYymm));
							cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							
							cstmt.executeUpdate();
	
							//메시지처리
							if (cstmt.getString(2).equals("Y") ) {
								if ( !cstmt.getString(3).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(4),this);
									GauceDataRow row2 = ds9.newDataRow();									
									row2.addColumnValue(cstmt.getString(4));
									ds9.addDataRow(row2);
								}
							} else {
								//StringUtil.printMsg("실패메시지",cstmt.getString(4),this);								
								conn.rollback();
								GauceDataRow row2 = ds9.newDataRow();								
								row2.addColumnValue(cstmt.getString(4));
								ds9.addDataRow(row2);
								fail = true;
								break inner;						
							} 
							
							if(cstmt!=null) cstmt.close();
							break;						
						}
					}
				}
			}
			if(inputDs2!=null){
				String 	sJobYymm	= HDUtil.nullCheckStr(req.getParameter("sJobYymm"));
				String 	sSalDamSid	= HDUtil.nullCheckStr(req.getParameter("sSalDamSid"));
				
				res.enableFirstRow(ds9);
				ds9.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				GauceDataRow row = ds9.newDataRow();						

				int j=1;
				//StringUtil.printMsg("call SALES.PR_AC610B_01","call SALES.PR_AC610B_01",this);						
				cstmt = conn.prepareCall("{call SALES.PR_AC610B_01(?, ?, ?, ?, ?, ?, ?) }");						
						
				cstmt.setString(1, sJobYymm);
				cstmt.setInt(2, Integer.parseInt(sSalDamSid));
				cstmt.setString(3, iParamEmpno);
				cstmt.setString(4, iParamIp);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
						
				cstmt.executeUpdate();

				//메시지처리
				if (cstmt.getString(5).equals("Y") ) {
					if ( !cstmt.getString(6).equals("0000") ) {
						//StringUtil.printMsg("성공메시지",cstmt.getString(7),this);
						GauceDataRow row2 = ds9.newDataRow();									
						row2.addColumnValue(cstmt.getString(7));
						ds9.addDataRow(row2);
					}
				} else {
					//StringUtil.printMsg("실패메시지",cstmt.getString(7),this);								
					conn.rollback();
					GauceDataRow row2 = ds9.newDataRow();								
					row2.addColumnValue(cstmt.getString(7));
					ds9.addDataRow(row2);
					fail = true;
				} 
				
				if(cstmt!=null) cstmt.close();
			}			
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			ds9.flush();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}

}
