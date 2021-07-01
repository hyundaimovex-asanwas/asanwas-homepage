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

public class Rv002H extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		arr_sql[0].append ("SELECT CU03.CLIENT_NM, 									\n")
				  .append ("    T1.CAR_SID||'' CAR_SID,                           	\n")
				  .append ("    T1.CAR_NO,                                       	\n")
				  .append ("    T1.CAR_NM,                                         	\n")
				  //.append ("    T1.CAR_TYPE,                                        \n")
				  .append ("    SALES.FN_DETAIL_NM('CU026', T1.TT_CAR_TYPE) AS CAR_TYPE \n")
				  .append ("FROM                                                    \n")
				  .append ("	SALES.TCU050 T1 JOIN SALES.TCU030 CU03 ON (T1.CLIENT_SID = CU03.CLIENT_SID) \n");
		
		
				  //.append ("WHERE 1=1                                               \n");	//2018-08-21 sdh
				  
/*				  .append ("    T1.CAR_SID||'' CAR_SID,                           	\n")
				  .append ("    T1.CAR_NO,                                       	\n")
				  .append ("    T1.CAR_NM,                                         	\n")
				  .append ("    T3.CUST_NM,                       					\n")
				  .append ("    T1.DRIVE_NO,                                        \n")
				  .append ("    T1.DRIVE_NO,                                        \n")
				  .append ("    T3.MANAGE_NO                                        \n")
				  .append ("FROM                                                    \n")
				  .append ("	SALES.TCU050 T1, SALES.TCU040 T2, SALES.TCU010 T3  	\n")
				  .append ("WHERE 1=1                                               \n")
				  .append ("	AND T1.DRIVE_NO = T2.DRIVE_NO                       \n")
				  .append ("	AND T2.CUST_SID = T3.CUST_SID                    	\n")*/				  
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
		
  
		// 검색시 조건
		String sClientSid	= HDUtil.nullCheckStr(greq.getParameter("sClientSid"));
		String sCarNo		= HDUtil.nullCheckStr(greq.getParameter("sCarNo"));
		int dsType			= HDUtil.nullCheckNum(greq.getParameter("dsType"));
		//StringUtil.printMsg("sCarNo", sCarNo+"", this);
		//StringUtil.printMsg("client_sid", sClientSid+"", this);
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
						/*if (!"".equals(sClientSid)) {
							arr_sql[0].append( " AND T1.CLIENT_SID = ?");
						}*/
						if (!"".equals(sCarNo)) {
							arr_sql[0].append( " WHERE T1.CAR_NO LIKE ?");
						}
						
						//쿼리 실행
						//StringUtil.printMsg("qry", arr_sql[0].toString()+"", this);						
						cstmt = conn.prepareCall(arr_sql[0].toString()); 
		
						/*if (!"".equals(sClientSid)) {
							cstmt.setInt(sCnt1++, Integer.parseInt(sClientSid));
						}*/
						if (!"".equals(sCarNo)) {
							cstmt.setString(sCnt1++, "%"+sCarNo+"%");
						}
						rs = cstmt.executeQuery(); 
						gos.write(getDataSet(rs, ds1));// DataSet set
					}
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
