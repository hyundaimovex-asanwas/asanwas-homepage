package sales.menu.help;
/**********************************************************************************
 * 고객정보 팝업 
 **********************************************************************************/
import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import oracle.jdbc.OracleTypes;

public class Cu003H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		arr_sql[0].append ("SELECT  									\n")
				  .append ("	T1.DRIVE_NO,                            \n")
				  .append ("	T1.CUST_SID,                            \n")
				  .append ("	T2.CUST_NM,                             \n")
				  .append ("	T2.MANAGE_NO                            \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TCU040 T1 , SALES.TCU010 T2       \n")
				  .append ("WHERE T1.CUST_SID=T2.CUST_SID               \n");
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/

		// 검색시 조건
		String CustSid		= HDUtil.nullCheckStr(greq.getParameter("CustSid"));
		String keyWord		= HDUtil.nullCheckStr(greq.getParameter("keyWord"));			
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = new GauceDataSet("DEFAULT");
					
					if(ds1!=null){
						
						if (!"".equals(keyWord)) 
							arr_sql[0].append( " AND (T1.DRIVE_NO LIKE ? OR T2.CUST_NM LIKE ?)");

						//System.out.println("arr_sql[0].toString() : " + arr_sql[0].toString());
						//쿼리 실행
						cstmt = conn.prepareCall(arr_sql[0].toString());
		
						if (!"".equals(keyWord)) {
							cstmt.setString(sCnt1++, "%"+keyWord+"%");
							cstmt.setString(sCnt1++, "%"+keyWord+"%");
						}
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1));
					}
					break;
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
			if(cstmt!=null) cstmt.close();
		}
	}
}
