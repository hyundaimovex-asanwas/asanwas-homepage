package pms.menu.help;
/***********************************************************************
 * 	협력사 팝
************************************************************************/

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Sy030H_01 extends SuperServlet {
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("SELECT 					 \n")
				  .append ("       T1.VEND_CD, T1.VEND_NM		 \n")
				  .append ("  FROM                              \n")
				  .append ("       ACCOUNT.GCZM_VENDER T1              	\n")
				  .append (" WHERE 1=1				\n")
				  .append ("   AND T1.VEND_NM LIKE ?	        \n");
				  
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			res.enableFirstRow(ds1);
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			int dsType 				= HDUtil.nullCheckNum(req.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(req.getParameter("v_keyword"));			

			StringUtil.printMsg("v_keyword", v_keyword, this);

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					// 쿼리 실행
					stmt = conn.getGauceStatement(arr_sql[0].toString()); 
					stmt.setString(1, "%"+v_keyword+"%");
					
					rs = stmt.executeQuery(); // DataSet set
					getDataSet(rs, ds1).flush();
					break;
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
}
