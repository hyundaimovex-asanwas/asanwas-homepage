package sales.menu.help;
/**********************************************************************************
 * 매출처 팝업 
 **********************************************************************************/

import javax.servlet.ServletException;
import sales.common.*;

import java.sql.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Cu005H extends SuperServlet {
	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT GROUP_SID, GROUP_CD, GROUP_NM	\n")
				  .append ("  FROM SALES.TCU020                     \n")
				  .append (" WHERE USE_YN='Y'                       \n");
	}
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)
		throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 

			String keyWord		= HDUtil.nullCheckStr(req.getParameter("keyWord"));			
			String gubun 		= HDUtil.nullCheckStr(req.getParameter("gubun"));
			
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					res.enableFirstRow(ds1);
//StringUtil.printMsg("gubun", gubun, this);
//StringUtil.printMsg("keyWord", keyWord, this);
//					if (!"".equals(gubun)) 
//						arr_sql[0].append (" AND client_gu = '" +  gubun  + "'");
//사업자도 취소요청관리를 위해 대리점 헬프에서 가능하도록 수정 2007-02-09					
					if (!"".equals(keyWord)){
						arr_sql[0].append (" AND (GROUP_CD LIKE '%"+keyWord.trim()+"%' " + "  OR GROUP_NM LIKE '%"+keyWord.trim() + "%') ");}
					
						arr_sql[0].append("order by GROUP_NM");
					
					
					// 쿼리 실행
//					StringUtil.printMsg("쿼리",arr_sql[0].toString(),this);
					stmt = conn.getGauceStatement(arr_sql[0].toString()); 
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();
					break;
			}
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

}
