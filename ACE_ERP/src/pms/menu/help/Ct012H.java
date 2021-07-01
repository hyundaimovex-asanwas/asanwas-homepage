package pms.menu.help;
/***********************************************************************
 * 	현장 팝
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

public class Ct012H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append (" SELECT CT10.SITE_SID                                                                     \n")
				.append ("       ,CT12.DATE_CT                                                                      \n")
				.append ("       ,CT10.SITE_NM                                                                      \n")
				.append ("       ,CT10.ORDERER_SID                                                                  \n")
				.append ("       ,SY40.ORDERER_NM                                                                   \n")
				.append ("       ,PMS.FN_DETAIL_NM('CT013',CT12.SITE_SEQ_CT) AS SITE_SEQ_CT_CD                      \n")
				.append ("       ,PMS.FN_DETAIL_NM('CT014',CT12.SITE_SEQ_CH) AS SITE_SEQ_CH_CD                      \n")
				.append ("       ,CT12.SITE_SEQ_CT	\n")
				.append ("       ,CT12.SITE_SEQ_CH	\n")
				.append ("       ,CT12.AMT_CT_TOT                                                                   \n")
				.append ("       ,CT12.AMT_CT                                                                       \n")
				.append ("       ,CT12.AMT_CT_VAT                                                                   \n")
				.append ("       ,CT12.DATE_BEGIN                                                                   \n")
				.append ("       ,CT12.DATE_END                                                                     \n")
				.append ("   FROM PMS.TCT010  CT10 JOIN PMS.TSY040  SY40 ON (CT10.ORDERER_SID=SY40.ORDERER_SID) \n")
				.append ("                         JOIN PMS.TCT012  CT12 ON (CT10.SITE_SID = CT12.SITE_SID)     \n")
				.append (" WHERE CT10.SITE_NM LIKE ?                                                                \n")				  
				.append (" ORDER BY CT10.SITE_SID desc, CT12.SITE_SEQ_CT, CT12.SITE_SEQ_CH                               \n");
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
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					cstmt.setString(1, "%"+v_keyword+"%");

					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
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
