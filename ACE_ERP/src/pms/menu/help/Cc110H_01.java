package pms.menu.help;
/***********************************************************************
 * 	작업 등록 / 디테일1 : 외주 협력사 + 공종 조회
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

public class Cc110H_01 extends SuperServlet {

	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++){
			arr_sql[i] = new StringBuffer();
		}
	        //예산실적구분설정 : 홈>회계>회계관리>기준정보관리>업체코드관리 ACCOUNT.BGTMATCH (PK(BGTDPT,BGTFRYM))
		// 프로젝트 코드의 조회 : 프로젝트 종료(회계상 마감) 구분이 없네

		arr_sql[0].append ("{call PMS.PR_CC110H_01(?,?) }" );
	
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
            
			int dsType 			= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));			

//StringUtil.printMsg("v_keyword", v_keyword, this);
			cstmt = conn.prepareCall(arr_sql[0].toString());
			cstmt.setString(1, v_keyword);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
			cstmt.executeQuery();
			rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
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
