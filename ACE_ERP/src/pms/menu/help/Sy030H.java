package pms.menu.help;
/***********************************************************************
 * 	협력사 팝
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;

public class Sy030H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("SELECT 					 \n")
				  .append ("       T1.BP_SID, T1.BP_CD		 \n")
				  .append ("      ,T1.BP_NM, T1.BIZREGI_NO	 \n")
				  .append ("  FROM                              \n")
				  .append ("       PMS.TBC030 T1              	\n")
				  .append (" WHERE T1.USE_YN='Y'				\n")
				  .append ("   AND T1.BP_NM LIKE ?	        \n")
				  .append (" ORDER BY T1.BP_NM ASC	        \n");
				  
		
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
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
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));			

			//StringUtil.printMsg("v_keyword", v_keyword, this);

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					//StringUtil.printMsg("쿼리===", arr_sql[0].toString(), this);
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					cstmt.setString(1, "%"+v_keyword+"%");
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
