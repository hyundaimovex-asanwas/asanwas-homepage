package coopbiz.menu.df;

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

import sales.common.*;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Df310I extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
		 
		arr_sql[0].append("{call COOPBIZ.PR_DF310I_01(?, ?, ? ) }");

		//입금 업데이트
		arr_sql[1].append ("UPDATE COOPBIZ.ORDER_TEMP	\n")
				  .append ("   SET  PAY_YN = 'Y'	\n") 
				  .append ("       ,PAY_MANAGE_NO = ? \n")
				  .append (" WHERE ORDER_SID= ? 	\n");

		//기간조회
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

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
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		
		String v_pay_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_pay_manage_no"));	//결제관리번호
		
		//StringUtil.printMsg("v_pay_manage_no",v_pay_manage_no,this);
			
		try{
			ds1 = req.getGauceDataSet("DS1");
			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
					
				//StringUtil.printMsg("rows",row.length,this);
				//입금액 인서트 Roop.
				for(int i=0; i<row.length; i++){
				
					//그리드의 선택 컬럼이 지정되면 입금 완
					if( (row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")) ){
						stmt = conn.getGauceStatement(arr_sql[1].toString());
		
						stmt.setString(1,v_pay_manage_no);                                                    
						stmt.setInt(2, row[i].getInt(ds1.indexOfColumn("ORDER_SID"))  );                                           
						
						stmt.executeUpdate();
						if(stmt!=null) stmt.close();
					}
				}//for(int i=0; i<row.length; i++){
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
	
}
