package omsm.or;
/***********************************************************************
 * 	OMS 공지사항
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

public class m_or0010_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
			//주문MST UPDATE 
			arr_sql[0].append ("  UPDATE OMS.T_OR0010 SET    \n");
			arr_sql[0].append ("  ORDER_STS=?    \n");
			arr_sql[0].append (" ,UPDATE_ID=?    \n");
			arr_sql[0].append (" ,UPDATE_DATE=CURRENT_TIMESTAMP \n");
			arr_sql[0].append (" WHERE ORDER_SID =? \n");

 	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		  rs	= null;
		
		conn.setAutoCommit(false);
			
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
	
		String strOrder_Sid	= HDUtil.nullCheckStr(greq.getParameter("v_order_sid"));
		String strOrder_Sts	= HDUtil.nullCheckStr(greq.getParameter("v_order_sts"));
	
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_ORDER_SID           = ds1.indexOfColumn("ORDER_SID");        //
				int colNm_ORDER_STS           = ds1.indexOfColumn("ORDER_STS");        //
				int colNm_UPDATE_ID           = ds1.indexOfColumn("UPDATE_ID");        //
				int colNm_UPDATE_DATE         = ds1.indexOfColumn("UPDATE_DATE");      //

				for(int i=0; i<rows.length; i++){
					//int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[0].toString());
							
							cstmt.setString(1, strOrder_Sts);
							cstmt.setString(2, rows[i].getString(colNm_UPDATE_ID));
							cstmt.setString(3, rows[i].getString(colNm_ORDER_SID));	
							cstmt.executeUpdate();
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						
						case GauceDataRow.TB_JOB_UPDATE:
							
						case GauceDataRow.TB_JOB_DELETE:
							
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			gos.close();	
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			conn.rollback();
			throw e;
		} finally {			
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
			
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
}
