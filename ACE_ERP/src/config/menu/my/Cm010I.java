package config.menu.my;
//	si110i
//	si110i_h1 사용

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cm010I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//work Master 저장
		arr_sql[0].append ("{call COMMON.PR_CMU010I_01(?,?) }" );
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("저장~!","",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_wm= gis.read("DS_WM");
		try{
			if (ds_wm != null) {
				GauceDataRow[] 		rows = ds_wm.getDataRows();
				int colNm_a1	= ds_wm.indexOfColumn("a1");
				int colNm_a2	= ds_wm.indexOfColumn("a2");
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				for(int i=0; i<rows.length; i++){
					//StringUtil.printMsg("ds_wm "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					/*StringUtil.printMsg("colNm_dwr_sid",rows[i].getInt(colNm_dwr_sid),this);
					StringUtil.printMsg("colNm_site_sid",rows[i].getInt(colNm_site_sid),this);
					*/
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, rows[i].getString(colNm_a1) );
					cstmt.setString(2, rows[i].getString(colNm_a2) );
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}

			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}        
	}
}