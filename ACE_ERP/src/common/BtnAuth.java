package common;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;



public class BtnAuth extends SuperServlet {
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
					arr_sql[i] = new StringBuffer();
		
				// TODO Auto-generated method stub
				arr_sql[0].append ("SELECT USERID, PGM_IDX, BTN_AUTH				 	    \n")
						  .append ("FROM   COMMON.MENU_AUTH             \n")
						  .append ("WHERE 1=1                           \n");

				
		
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		GauceDataSet ds1 = null;
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			ds1 = new GauceDataSet(); // Dataset TSY410

			// 검색시 조건
			String  s_id		= HDUtil.nullCheckStr(greq.getParameter("userid"));
			int  	s_idx		= HDUtil.nullCheckNum(greq.getParameter("tree_idx"));
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					arr_sql[0].append (" AND USERID  = ? \n");
					arr_sql[0].append (" AND PGM_IDX = ? \n");

					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, s_id);
					cstmt.setInt(2, s_idx);
										
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
					break;
			}
			gos.close();
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
			// TODO Auto-generated method stub
	}
}