package omsm.popup;
/***********************************************************************
 * 	OMS FAQ 팝업상세
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

public class m_or03_popup_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT B.COMPANY, B.CR_NO, A.USER_NAME, A.PHONE, A.HP, B.VEND_CD, \n");
		    arr_sql[0].append ("        CASE WHEN SUBSTR(A.PHONE,1,2)='02'  AND  LENGTH(A.PHONE)=9  THEN 1    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)='02'  AND  LENGTH(A.PHONE)=10 THEN 2   \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)!='02' AND  LENGTH(A.PHONE)=10 THEN 3    \n");
		    arr_sql[0].append ("             WHEN SUBSTR(A.PHONE,1,2)!='02' AND  LENGTH(A.PHONE)=11 THEN 4   \n");
		    arr_sql[0].append ("             ELSE 9 END AS MASK_GB \n");
		    arr_sql[0].append ("        FROM OMS.T_CO0050 A, OMS.T_CO0060 B \n");
		    arr_sql[0].append ("  WHERE A.CR_NO = B.CR_NO \n");	
		    
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
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					if(!v_keyword.equals("")){
						arr_sql[0].append ("    AND (B.COMPANY LIKE ? OR B.CR_NO LIKE ? OR A.USER_NAME LIKE ?) \n");
					}
					
					System.out.println(v_keyword+"v_keyword"+arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
					if(!v_keyword.equals("")){
						cstmt.setString(1, "%"+v_keyword+"%");
						cstmt.setString(2, "%"+v_keyword+"%");
						cstmt.setString(3, "%"+v_keyword+"%");
					}
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
