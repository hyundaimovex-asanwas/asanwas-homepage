package pms.menu.help;
/***********************************************************************
 * 	작업 등록 / 디테일2 : 주요 장비 조회
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;

public class Si110H_02 extends SuperServlet {

	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++){
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[0].append ("{call PMS.PR_SI110I_33(?) }" );
	
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
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
            
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			int v_site_sid		= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			

//StringUtil.printMsg("v_keyword", v_keyword, this);
			cstmt = conn.prepareCall(arr_sql[0].toString());
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
			cstmt.executeQuery();
			rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 					
			gos.write(getDataSet(rs, ds1));
			
			
			
		} catch (SQLException sqle){
			//gres.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
}
