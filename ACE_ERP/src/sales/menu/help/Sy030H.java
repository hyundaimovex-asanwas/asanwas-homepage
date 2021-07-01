package sales.menu.help;

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

public class Sy030H extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	// 조회 method
	 public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		 /* DataBase */
		//GauceStatement stmt = null;
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		
		/* DataSet */
		GauceDataSet ds1 = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			// 검색시 조건
			String  sEmpno		= HDUtil.nullCheckStr(greq.getParameter("sEmpno"));			
			//String  sEmpnmk		= HDUtil.nullCheckStr(req.getParameter("sEmpnmk"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//첫번째,두번째 그리드
			//detail이 공백이 아닌 경우 dsType=1, 공백인 경우 dsType=2

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					int sCnt1 = 1;
					// 모든 사원정보 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT UID, UNAME " 									
							+ "\n\t"+  "  FROM SALES.VUSER "
							+ "\n\t" + "WHERE (UID = '"+sEmpno.trim()+"' OR UNAME LIKE '"+sEmpno.trim()+"%')"
							+ "\n\t" + "GROUP BY  UID, UNAME"
							+ "\n\t" + "ORDER BY UNAME";
					query += whereQuery;
					//System.out.println("# Command4 : 조회");
					//System.out.println(query);

					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("UID",  GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("UNAME",         GauceDataColumn.TB_STRING, 50));
					
					// 쿼리 실행
					cstmt = conn.prepareCall(query); 
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
					break;
	
			}
		//gos.close();
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
	}
}