package omsm.popup;
/***********************************************************************
 * 	OMS 공지사항
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

public class m_or04_popup_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT WORK_CD, CUR_DATE, CUR_DAY, HOL_YN, INOUT_DATE, HOL_GB, REMARK, STAR_CHK  \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0010    \n");
		    arr_sql[0].append ("  WHERE WORK_CD = ?     \n");	
		    arr_sql[0].append ("    AND CUR_DATE LIKE ? \n");	
		    arr_sql[0].append ("  ORDER BY CUR_DATE     \n");	
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
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
					
			//System.out.println("v_keyword::"+v_keyword);
			//System.out.println("v_parm1::"+v_parm1);
			//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				    // 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_keyword);			
					cstmt.setString(2,"%"+v_parm1+"%");
					rs = cstmt.executeQuery();     //DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
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
