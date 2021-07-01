package sales.menu.help;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.Connection;

 
import oracle.jdbc.OracleTypes;

public class Cq002H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("SELECT 													\n")
				  .append ("       T1.CAR_NO                /* 차량등록번호      */ \n")
				  .append ("      ,T1.CAR_NM                /* 차명              */ \n")
				  .append ("      ,T1.CAR_SID               /* 차량 SID          */ \n")
				  .append ("  FROM                                                  \n")
				  .append ("       SALES.TCU050 T1                                  \n")
				  .append (" WHERE 1 = 1                                            \n")
				  .append ("   AND T1.CAR_NO    LIKE ?	                			\n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataBase */
		//GauceStatement stmt = null;
		ResultSet rs = null;
		CallableStatement cstmt = null;

		
		/* DataSet */
		GauceDataSet ds1 = null;
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try {
			// DataSet 생성 			
						ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
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
					
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString()); 
					cstmt.setString(1, "%"+v_keyword+"%");
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
