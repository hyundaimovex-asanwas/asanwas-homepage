package sales.menu.help;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Connection; 

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import oracle.jdbc.OracleTypes;

public class Cq001H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append ("SELECT 																									\n")
				  .append ("       T3.CUST_NM                                     AS CUST_NM     /* 성명     */                     \n")
				  .append ("      ,SUBSTR(T3.REGI_NO,1,6)||'-'||SUBSTR(T3.REGI_NO,7,7)                                              \n")
				  .append ("                                                      AS REGI_NO     /* 주민등록번호 */                 \n")
				  .append ("      ,T2.CUST_SID                                    AS CUST_SID    /* 고객 SID */                     \n")
				  .append ("  FROM SALES.TRV010 T1                                                                                  \n")
				  .append ("      ,SALES.TRV020 T2                                                                                  \n")
				  .append ("      ,SALES.TCU010 T3                                                                                  \n")
				  .append (" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID                                                                   \n")
				  .append ("   AND T2.CUST_SID    = T3.CUST_SID                                                                     \n")
				  .append ("   AND T2.STATUS_CD   IN ('RR' , 'DP' ,'AR')   /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */   \n")
				  .append ("   AND T1.JOB_GUBUN   = '3'                                                                             \n")
				  .append ("   AND (T1.SAUP_SID   = CASE WHEN $1   = 0  THEN T1.SAUP_SID   ELSE $1   END)  /* 사업소   */     		\n")
				  .append ("   AND (T1.GOODS_SID  = CASE WHEN $2  = 0  THEN T1.GOODS_SID  ELSE $2  END)  /* 상품SID   */    		\n")
				  .append ("   AND T2.DEPART_DATE = ?        /* 출경일자 */                                                        	\n")
				  .append ("   AND T2.DEPART_TIME = ?        /* 출경시간 */                                                        	\n")
				  .append ("   AND T3.SAUP_GU     = ?                                                                               \n")
				  .append ("ORDER BY T3.CUST_NM                                                                                     \n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}

	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		/* DataSet */
		GauceDataSet ds1 = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			int v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
			int v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));
			String v_saup_gu		= HDUtil.nullCheckStr(greq.getParameter("v_saup_gu"));			
			String v_depart_date	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));
			String v_depart_time	= HDUtil.nullCheckStr(greq.getParameter("v_depart_time"));

			switch(dsType) {
			case 1: //detail이 공백이 아닌 공통코드 검색
				// 쿼리 실행
				String temp_sql = new String();
				temp_sql = StringUtil.strReplace(arr_sql[0].toString(), "$1", v_saup_sid+"");
				temp_sql = StringUtil.strReplace(temp_sql, "$2", v_goods_sid+"");
			
				cstmt = conn.prepareCall(temp_sql); 
				cstmt.setString(1, v_depart_date);
				cstmt.setString(2, v_depart_time);
				cstmt.setString(3, v_saup_gu);
				
				rs = cstmt.executeQuery(); // DataSet set
				gos.write(getDataSet(rs, ds1));
				break;
				}
			gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}	
	}
}
