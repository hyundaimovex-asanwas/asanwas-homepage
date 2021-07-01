package coopbiz.menu.df;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.*;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Df300I extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
            
        //조회
		arr_sql[0].append("{call COOPBIZ.PR_DF310I_01(?, ?, ? ) }");
		//저장
		arr_sql[1].append("{CALL COOPBIZ.PR_DF300I_02(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?) }");

		//기간조회
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		CallableStatement cstmt = null;	
		ResultSet rs = null;
		
		String[] columnName = null;

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
							cstmt = conn.prepareCall(arr_sql[0].toString());
							cstmt.setString(1, "20100101");		  	// 주문기간  
							cstmt.setString(2, "20100101");		  	// 주문기간 
							cstmt.setString(3, "2030004");	  	//주문자 사번

							rs = cstmt.executeQuery();
						//getDataSet(rs, ds1).flush();							
							getDataSetHead(rs, ds1).flush();
							
							
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
		GauceStatement stmt = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		String v_order_str_date 	= HDUtil.nullCheckStr(req.getParameter("v_order_str_date"));	//주문기간 
		String v_order_end_date 	= HDUtil.nullCheckStr(req.getParameter("v_order_end_date"));	//주문기간
		String v_user_id	   		= HDUtil.nullCheckStr(req.getParameter("v_user_id"));		//주문자 사번
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds_grid = req.getGauceDataSet(gauceName);
				if(ds_grid!=null){
					res.enableFirstRow(ds_grid);
					
					if(gauceName.equals("DEFAULT")){
						
						//조회쿼리
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_order_str_date);		  	// 주문기간  
						cstmt.setString(2, v_order_end_date);		  	// 주문기간 
						cstmt.setString(3, v_user_id);	  	//주문자 사번

						rs = cstmt.executeQuery();
						getDataSet(rs, ds_grid).flush();
					}//if(gauceName.equals("DEFAULT")){
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
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;	
		ResultSet rs = null;
		
		try{
			String v_edit_styatus = "";										//IN 편집상태     1: INSERT, 2: DELETE, 3: UPDATE
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					GauceDataRow[]    row  = ds1.getDataRows();
					StringUtil.printMsg("저장입니다.", "1111111111", this);
					
					int colNm_ORDER_SID		= 	ds1.indexOfColumn("ORDER_SID");
					int colNm_USER_ID		= 	ds1.indexOfColumn("USER_ID");
					int colNm_ITEM_SID   	=	ds1.indexOfColumn("ITEM_SID");
					int colNm_ORDER_CNT  	=	ds1.indexOfColumn("ORDER_CNT");
					int colNm_AMT_ORDER  	=	ds1.indexOfColumn("AMT_ORDER");
					int colNm_CURRENCY_CD	=	ds1.indexOfColumn("CURRENCY_CD");
					int colNm_EXCH_AMT   	=	ds1.indexOfColumn("EXCH_AMT");
					int colNm_ORDER_DATE 	=	ds1.indexOfColumn("ORDER_DATE");
					int colNm_PAY_YN     	=	ds1.indexOfColumn("PAY_YN");
					int colNm_EXCH_RATE	 	=	ds1.indexOfColumn("EXCH_RATE");
										
					//입금액 인서트 Roop.
					for(int i=0; i<row.length; i++){
						
						if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
							v_edit_styatus = "1";
						} else if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
							v_edit_styatus = "2";
						} if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
							v_edit_styatus = "3";
						}


						cstmt = conn.prepareCall(arr_sql[1].toString());
						
						cstmt.setInt(1, row[i].getInt(colNm_ORDER_SID) );
						cstmt.setString(2, row[i].getString(colNm_USER_ID));
						//StringUtil.printMsg("1===== ", row[i].getString(colNm_USER_ID), this);
						cstmt.setInt(3, row[i].getInt(colNm_ITEM_SID) );
						//StringUtil.printMsg("2===== ", row[i].getString(colNm_ITEM_SID), this);
						cstmt.setInt(4, row[i].getInt(colNm_ORDER_CNT) );
						//StringUtil.printMsg("3===== ", row[i].getString(colNm_ORDER_CNT), this);
						cstmt.setInt(5, row[i].getInt(colNm_AMT_ORDER) );
						//StringUtil.printMsg("4===== ", row[i].getString(colNm_AMT_ORDER), this);
						cstmt.setString(6, row[i].getString(colNm_CURRENCY_CD) );
						//StringUtil.printMsg("5===== ", row[i].getString(colNm_CURRENCY_CD), this);
						cstmt.setInt(7, row[i].getInt(colNm_EXCH_AMT) );
						//StringUtil.printMsg("6===== ", row[i].getString(colNm_EXCH_AMT), this);
						cstmt.setString(8, row[i].getString(colNm_ORDER_DATE) );
						//StringUtil.printMsg("7===== ", row[i].getString(colNm_ORDER_DATE), this);
						cstmt.setString(9, row[i].getString(colNm_PAY_YN) );
						//StringUtil.printMsg("8===== ", row[i].getString(colNm_PAY_YN), this);
						cstmt.setInt(10, row[i].getInt(colNm_EXCH_RATE) );
						//StringUtil.printMsg("9===== ", row[i].getString(colNm_EXCH_RATE), this);
						cstmt.setString(11, v_edit_styatus );
						cstmt.setString(12, fParamEmpno);
						//StringUtil.printMsg("10===== ", fParamEmpno, this);
						cstmt.setString(13, fParamIp);
						//StringUtil.printMsg("11===== ", fParamIp, this);
						
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();

					}//for(int i=0; i<row.length; i++){
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
	}}
