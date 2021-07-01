package sales.menu.help;

import java.sql.*;

import javax.servlet.ServletException;
import sales.common.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pm001H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT  CLIENT_SID 	AS CLIENT_SID			\n")
				  .append ("       ,CLIENT_NM	AS CLIENT_NM			\n")
				  .append ("       ,CLIENT_CD	AS CLIENT_CD			\n")
				  .append ("  FROM SALES.TCU030							\n")
				  .append (" WHERE USE_YN='Y'  AND 						\n")
				  //.append ("     VEND_TYPE > 0 AND 						\n")				  
				  .append (" 	(CLIENT_CD LIKE ? OR CLIENT_NM LIKE ? OR VEND_ID LIKE ? )	\n");
		
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 

			// 검색시 조건
			String  s_Head		= HDUtil.nullCheckStr(greq.getParameter("s_Head"));
			String	s_Detail	= HDUtil.nullCheckStr(greq.getParameter("s_Detail"));
			int sCnt1 = 1;
			// 쿼리 실행
			cstmt = conn.prepareCall(arr_sql[0].toString());
				//System.out.println(arr_sql[0].toString());
				if (!"".equals(s_Detail)){
					cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					cstmt.setString(sCnt1++, "%" + s_Detail + "%");
					cstmt.setString(sCnt1++, "%" + s_Detail + "%");
				}
				
				rs = cstmt.executeQuery(); // DataSet set
				gos.write(getDataSet(rs, ds1));
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}

}
