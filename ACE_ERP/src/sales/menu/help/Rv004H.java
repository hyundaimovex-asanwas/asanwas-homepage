package sales.menu.help;
/**********************************************************************************
 * 고객정보 팝업 
 **********************************************************************************/

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

public class Rv004H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[0].append("Select 			            																	         \n")
				.append("    T1.CUST_SID||'' AS CUST_SID,                            			\n")
				.append("    T1.CUST_NM,                                             			\n")
				.append("    T1.MANAGE_NO,                                           			\n")
				.append("    T1.CUST_TYPE,                                           			\n")
				.append("    T2.WORK_NO,                                             			\n")
				.append("    T3.N_CARD_NO     													\n")
				.append("FROM                 													\n")
				.append("	SALES.TCU010 T1 JOIN SALES.TCM010 T2 ON (T1.CUST_SID=T2.CUST_SID)	\n")
				.append("	     LEFT OUTER JOIN SALES.TCU072 T3 ON (T1.CUST_SID=T3.CUST_SID)	\n")
				.append("WHERE T1.CUST_GU='2'		                             				\n")
				.append("	AND T1.CLIENT_SID = ?\n");
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/
  
		// 검색시 조건
		String sClientSid		= HDUtil.nullCheckStr(greq.getParameter("sClientSid"));
		String sKeyWord			= HDUtil.nullCheckStr(greq.getParameter("sKeyWord"));
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		//StringUtil.printMsg("DSTYPE", dsType+"", this);
		try{
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = new GauceDataSet("DS1");
					
					if(ds1!=null){
						if (!"".equals(sKeyWord)) {
							 arr_sql[0].append(" AND (T1.CUST_NM LIKE ? OR T1.MANAGE_NO LIKE ?) \n");
						}
						arr_sql[0].append(" ORDER BY T1.CUST_NM \n");
						
						//쿼리 실행
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//StringUtil.printMsg("인원정보쿼리 ", arr_sql[0].toString(), this);
						cstmt.setString(sCnt1++,sClientSid);
						
						if (!"".equals(sKeyWord)) {
							cstmt.setString(sCnt1++, sKeyWord + "%");
							cstmt.setString(sCnt1++, sKeyWord + "%");
						}
						//StringUtil.printMsg("DSTYPE", arr_sql[0].toString(), this);
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
					}
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
}