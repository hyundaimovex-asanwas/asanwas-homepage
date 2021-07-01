package sales.menu.help;
/**********************************************************************************
 * 매출처 팝업 
 **********************************************************************************/

import javax.servlet.ServletException;
import sales.common.*;
import sales.common.HDUtil;
import sales.common.StringUtil;

import java.sql.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import oracle.jdbc.OracleTypes;

public class Cu001H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT CLIENT_SID, CLIENT_CD, CLIENT_NM	\n")
				  .append ("  FROM SALES.TCU030                     \n")
				  .append (" WHERE USE_YN='Y'                       \n");
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		/* DataSet */
		GauceDataSet ds1 = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
			String keyWord		= HDUtil.nullCheckStr(greq.getParameter("keyWord"));			
			String gubun 		= HDUtil.nullCheckStr(greq.getParameter("gubun"));

			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					if (!"".equals(keyWord)){
						arr_sql[0].append (" AND (client_cd LIKE '%"+keyWord.trim()+"%' " + "  OR client_nm LIKE '%"+keyWord.trim() + "%') ");}
						arr_sql[0].append("order by client_nm");
						// 쿼리 실행
	//					StringUtil.printMsg("쿼리",arr_sql[0].toString(),this);
						cstmt = conn.prepareCall(arr_sql[0].toString()); 
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1));
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
						break;
					}
				gos.close();
			} catch (SQLException sqle){
				//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
				throw sqle;
			} catch (Exception e) {
				//gres..writeException("ERROR", "", e.toString());
				throw e;
			} finally {
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
		}


	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

}
