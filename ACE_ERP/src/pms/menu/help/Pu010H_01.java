package pms.menu.help;
/***********************************************************************
 * 	현장 팝
************************************************************************/

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;


import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Pu010H_01 extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		String iParamEmpno = fParamEmpno;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		/*arr_sql[0].append ("SELECT 					 \n")
				  .append ("       T1.PU_SITE_CD,T1.PU_SITE_NM		 \n")
				  .append ("      ,T1.PU_EMPNO		 \n")
				  .append ("      ,T1.PU_EMPNM		 \n")
				  .append ("      ,T1.SITE_SID		 \n")
				  .append ("  FROM                      \n")
				  .append ("       PMS.TSY110 T1        \n")
				  .append (" WHERE 1=1 					\n")
				  .append ("   AND T1.PU_SITE_NM LIKE ?	\n")
				  .append ("   ORDER BY T1.PU_SITE_NM	ASC \n");*/
		arr_sql[0].append (" SELECT CT10.SITE_SID \n")
				.append (", CT10.PU_SITE_CD \n") //구매.4자리 코드
				.append (", CT10.SITE_NM, CT10.SITE_NM_S \n")
				.append (", CT10.SITE_TEL, CT10.SITE_FAX \n")
				.append (", CT13.COST_CD \n") //--회계.원가코드
				.append (", CT13.SEQ \n") //-- 담당자 순번
				.append (", CT13.EMPNO , COMMON.FN_LOGIN_NM(CT13.EMPNO) AS EMPNM \n") //--사원명
				.append (", CT13.EMPMAIL, CT13.EMPROLE \n")
				//.append (", PMS.FN_DETAIL_NM('', CT13.EMPROLE) AS EMPROLE
				.append ("FROM pms.tct010 CT10 JOIN pms.tct013 CT13 ON (CT10.site_sid = CT13.site_sid) \n")
				.append ("WHERE CT13.EMPNO = '"+ iParamEmpno +"' \n")
				.append ("AND CT10.SITE_NM LIKE ? \n")
				.append ("ORDER BY CT10.SITE_NM, CT13.SEQ  ASC \n");
		
		
				  
		
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
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환

			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));

			
			switch(dsType) {
			case 1:
				
				// 쿼리 실행
				cstmt = conn.prepareCall(arr_sql[0].toString());  
				cstmt.setString(1, "%"+v_keyword+"%");
				
				rs = cstmt.executeQuery(); // DataSet set
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