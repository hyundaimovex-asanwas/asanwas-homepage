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

public class Cu002H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		arr_sql[0].append ("SELECT 													\n")
				  .append ("    T1.CUST_SID||'' CUST_SID,                           \n")
				  .append ("    T1.MANAGE_NO,                                       \n")
				  .append ("    T1.CUST_NM,                                         \n")
				  .append ("    T2.CLIENT_CD || '' CLIENT_CD,                       \n")
				  .append ("    T2.CLIENT_NM                                        \n")
				  .append ("FROM                                                    \n")
				  .append ("	SALES.TCU010 T1 LEFT OUTER JOIN SALES.TCU030 T2     \n")
				  .append (" 	ON T1.CLIENT_SID = T2.CLIENT_SID                    \n")
				  .append ("WHERE 1=1                                               \n");
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataBase */
		//GauceStatement stmt = null;
		ResultSet rs = null;
		CallableStatement cstmt = null;

		
		/* DataSet */
		GauceDataSet ds1 = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

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
						
						if (!"".equals(CustSid)) {
							arr_sql[0].append( " AND T1.CUST_SID = ?");
						}
						
						if (!"".equals(keyWord)) {
							arr_sql[0].append( " AND (T1.MANAGE_NO LIKE ? OR T1.CUST_NM LIKE ?)");
						}
						/*
						System.out.println(CustSid);
						System.out.println(keyWord);
						System.out.println("arr_sql[0].toString() : " + arr_sql[0].toString());
						*/
						//쿼리 실행
						cstmt = conn.prepareCall(arr_sql[0].toString());
		
						if (!"".equals(CustSid)) {
							cstmt.setInt(sCnt1++, Integer.parseInt(CustSid));
						}			
						
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
