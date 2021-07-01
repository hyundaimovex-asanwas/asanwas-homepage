package omsm.co;
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

public class m_co0010_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		    arr_sql[0].append (" SELECT HEAD_CD,DETAIL_CD,DETAIL_NAME,PRT_SEQ,USE_GB  \n");
		    arr_sql[0].append ("       ,ITEM1,ITEM2,ITEM3,ITEM4,ITEM5 \n");
		    arr_sql[0].append ("       ,REMARK \n");
		    arr_sql[0].append ("       ,CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE, NVL(DETAIL_NAME||' '||ITEM1,DETAIL_NAME) AS DTNM_ITEM1  \n");
		    arr_sql[0].append ("   FROM OMS.T_CO0030  \n");
		    arr_sql[0].append ("  WHERE HEAD_CD = ?   \n");	
		    arr_sql[0].append ("    AND USE_GB = 'T'  \n");	 
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
			String v_parm1  		= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));
	
			if(!v_parm1.equals("")){
				arr_sql[0].append ("    AND ( DETAIL_NAME LIKE ? OR ITEM1 LIKE ? )  \n");	
			}
			arr_sql[0].append ("   ORDER BY PRT_SEQ  \n");
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					
					//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());
				
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_keyword);			
					
					if(!v_parm1.equals("")){
						cstmt.setString(2,  "%"+v_parm1+"%");	
						cstmt.setString(3,  "%"+v_parm1+"%");	
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
