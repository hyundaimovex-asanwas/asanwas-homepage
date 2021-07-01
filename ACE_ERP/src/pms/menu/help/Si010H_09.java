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

public class Si010H_09 extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
			arr_sql[0].append ("  SELECT A.DCSTR_SID, A.CSTR_CD, A.CSTR_NM,  A.DCSTR_SEQ         \n")
				      .append ("    FROM PMS.TSY060 A     \n")
					  .append ("   WHERE 1=1                       \n")
					  .append ("     AND A.POP_CHK = 1     \n")
                      .append ("     AND A.COST_CD = ?     \n")
                      .append ("     AND( CSTR_CD LIKE ?    \n") 
					  .append ("        OR CSTR_NM LIKE ? )    \n") ;
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
			String v_cost_cd		= HDUtil.nullCheckStr(greq.getParameter("v_cost_cd"));	
	
			//StringUtil.printMsg("v_keyword", v_keyword, this);
			//StringUtil.printMsg("v_cost_cd", v_cost_cd, this);

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());  
					cstmt.setString(1, ""+v_cost_cd+"");
					cstmt.setString(2, "%"+v_keyword+"%");
					cstmt.setString(3, "%"+v_keyword+"%");
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
				
			}
			gos.close();
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
}
