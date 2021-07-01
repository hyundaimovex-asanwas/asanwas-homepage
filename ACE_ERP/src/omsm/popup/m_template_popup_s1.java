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

public class m_template_popup_s1 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			arr_sql[0].append ("  SELECT 'F' CHK,                                                                           \n");
			arr_sql[0].append ("         B.ORDER_SID,B.ORDER_SEQ                                                             \n");	
			arr_sql[0].append ("        ,A.INOUT_GB, A.ORDER_STS, A.WORK_CD, A.INOUT_DATE, A.PURPOSE--, A.REMARK             \n");	
			arr_sql[0].append ("        ,A.APP_VENDCD, A.APP_COMPANY, A.APP_CRNO, A.APP_PERSON, A.APP_PHONE, A.APP_HP        \n");					
			arr_sql[0].append ("        ,A.SHIP_VENDCD, A.SHIP_COMPANY, A.SHIP_CRNO                                          \n");
			arr_sql[0].append ("        ,A.SHIP_PERSON, A.SHIP_PHONE, A.SHIP_HP,ORDER_GB                                     \n");	
			arr_sql[0].append ("        ,A.CREATE_ID, A.CREATE_DATE, A.UPDATE_ID, A.UPDATE_DATE                              \n");	
			arr_sql[0].append ("        ,B.CAR_KIND,B.ITEM_NAME,B.START_ADDR                                                 \n");									
			arr_sql[0].append ("        ,B.START_NAME,B.START_INFO,B.END_ADDR,B.END_NAME,B.END_INFO                          \n");
			arr_sql[0].append ("        ,B.PALLET_CNT,B.REMARK                                                               \n");	
			arr_sql[0].append ("    FROM OMS.T_OR0010 A ,OMS.T_OR0020 B                                                      \n");	
			arr_sql[0].append ("   WHERE A.ORDER_SID = B.ORDER_SID                                                           \n");	
			arr_sql[0].append ("     AND A.INOUT_GB =?                                                                     \n");
			arr_sql[0].append ("     AND A.CREATE_ID=?                                                                     \n");	
			arr_sql[0].append ("     AND B.ORDER_SID IN ( SELECT X.ORDER_SID                                               \n");	
			arr_sql[0].append ("                            FROM (  SELECT ORDER_SID ,                                     \n");	
			arr_sql[0].append ("                                           DENSE_RANK() OVER(ORDER BY ORDER_SID DESC) RANK \n");
			arr_sql[0].append ("                                      FROM OMS.T_OR0010                                    \n");	
			arr_sql[0].append ("                                     WHERE INOUT_GB =?                                     \n");
			arr_sql[0].append ("                                       AND CREATE_ID=?                                     \n");
			arr_sql[0].append ("                                  ) X                                                      \n");					
			arr_sql[0].append ("                           WHERE X.RANK <=10                                               \n");
			arr_sql[0].append ("                         )                                                                  \n");	
			arr_sql[0].append ("   ORDER BY B.ORDER_SID DESC, B.ORDER_SEQ                                                    \n");	
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));  // 반입반출 구분
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1"));    //사번
					
			//System.out.println("v_keyword::"+v_keyword);
			//System.out.println("v_parm1::"+v_parm1);
			//System.out.println("arr_sql[0].toString()::"+arr_sql[0].toString());
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				    // 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_keyword);
					cstmt.setString(2, v_parm1);
					cstmt.setString(3, v_keyword);
					cstmt.setString(4, v_parm1);
					
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
