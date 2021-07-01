package sales.menu.help;
/**********************************************************************************
 * 매출처 팝업 
 **********************************************************************************/

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
import sales.common.SuperServlet;

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

public class Rm002H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		arr_sql[0].append ("SELECT goods_sid, goods_cd, goods_nm		\n")
				  .append ("FROM SALES.TRM200 							\n")
				  .append ("WHERE 1=1 AND USE_YN='Y'					\n");

		arr_sql[1].append ("SELECT 0 goods_sid, '' goods_cd, '전체' goods_nm	\n")
				  .append ("FROM DUAL								\n")
				  .append ("UNION ALL											\n")
				  .append ("SELECT goods_sid, goods_cd, goods_nm				\n")
				  .append ("FROM SALES.TRM200 									\n")
				  .append ("WHERE 1=1 AND USE_YN='Y'							\n");
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
		
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			GauceInputStream gis = greq.getGauceInputStream();
	        GauceOutputStream gos = gres.getGauceOutputStream();
			
			String keyWord		= HDUtil.nullCheckStr(greq.getParameter("keyWord"));			
			String GoodsSid		= HDUtil.nullCheckStr(greq.getParameter("GoodsSid"));
			int dsType 			= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			int sCnt = 1;

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					if (!"".equals(GoodsSid)) {
						arr_sql[0].append (" AND goods_sid = ?\n");
					}
					if (!"".equals(keyWord)) {
						arr_sql[0].append (" AND (goods_cd LIKE ? OR goods_nm LIKE ?)\n");
					}

					// 쿼리 실행
					//System.out.println(arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
					 
					if (!"".equals(GoodsSid)){
						cstmt.setString(sCnt++, GoodsSid);
					}
					if (!"".equals(keyWord)) {
						cstmt.setString(sCnt++, "%"+keyWord+"%");
						cstmt.setString(sCnt++, "%"+keyWord+"%");
					}
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
				case 2:
					if (!"".equals(GoodsSid)) {
						arr_sql[1].append (" AND goods_sid = ?\n");
					}
					if (!"".equals(keyWord)) {
						arr_sql[1].append (" AND (goods_cd LIKE ? OR goods_nm LIKE ?)\n");
					}

					//StringUtil.printMsg("arr_sql[1].toString()", arr_sql[1].toString(), this);

					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[1].toString());
					if (!"".equals(GoodsSid)){
						cstmt.setString(sCnt++, GoodsSid);
					}
					if (!"".equals(keyWord)) {
						cstmt.setString(sCnt++, "%"+keyWord+"%");
						cstmt.setString(sCnt++, "%"+keyWord+"%");
					}
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
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
