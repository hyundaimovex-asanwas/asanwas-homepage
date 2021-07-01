package sales.menu.help;
//입경자 체류 검색의 경우, 오늘=입경일자인 사람도 검색되도록 조건 수정.
// 미리 수정하는 경우가 현실적으로 적음.. 2010-10-29 심동

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

public class Cq003H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//출경전 출경자 체류변경
		arr_sql[0].append ("SELECT 																							\n")
				  .append ("        RTRIM(SALES.FN_DETAIL_NM('RV017',T2.CLASS))  AS CLASS         /* 반         */          \n")
				  .append ("       ,T2.TEAMS                                     AS TEAMS         /* 조         */          \n")
				  .append ("       ,T3.CUST_NM                                   AS CUST_NM       /* 성명       */          \n")
				  .append ("       ,T2.CUST_GU                                   AS CUST_GU       /* 고객구분_CU001  */     \n")
				  .append ("       ,T2.ARRIVE_DATE                               AS ARRIVE_DATE   /* 입경일자   */          \n")
				  .append ("       ,T2.ARRIVE_TIME                               AS ARRIVE_TIME   /* 입경시간   */          \n")
				  .append ("	   ,T2.DEPART_DATE                               AS DEPART_DATE   /* 출경일자   */          \n")
				  .append ("	   ,T2.DEPART_TIME                               AS DEPART_TIME   /* 출경시간   */          \n")
				  .append ("	   ,T1.GOODS_SID                                 AS GOODS_SID     /* 상품 SID   */          \n")
				  .append ("       ,T4.GOODS_NM                                  AS GOODS_NM      /* 상품명     */          \n")
				  .append ("       ,T2.RSV_SID                                   AS RSV_SID       /* 예약SID    */          \n")
				  .append ("       ,0                                            AS INOUT_SID     /* 출입경번호 */          \n")
				  .append ("	   ,T3.MANAGE_NO								 AS MANAGE_NO	  /* 주민여권번호 */			\n")
				  .append ("   FROM                                                                                         \n")
				  .append ("        SALES.TRV010 T1                                                                         \n")
				  .append ("       ,SALES.TRV020 T2                                                                         \n")
				  .append ("       ,SALES.TCU010 T3                                                                         \n")
				  .append ("       ,SALES.TRM200 T4                                                                         \n")
				  .append ("  WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID                                                          \n")
				  .append ("    AND T2.CUST_SID    = T3.CUST_SID                                                            \n")
				  .append ("    AND T1.GOODS_SID   = T4.GOODS_SID                                                           \n")
				  .append ("    AND T2.STATUS_CD   IN ('RR','RA')              	                                            \n")
				  .append ("    AND (T1.SAUP_SID   = CASE WHEN $1 = 0  THEN T1.SAUP_SID  ELSE $1    END)                    \n")
				  .append ("    AND T2.DEPART_DATE = ?                                                                      \n")
				  //.append ("    AND T1.GOODS_SID   = ?                                                                      \n")
				  .append ("    AND ((T3.CUST_NM         LIKE  ? )                                                    		\n")
				  .append ("    OR  (T3.MANAGE_NO       LIKE  ? ))                                                   		\n")
				  .append ("   ORDER BY T2.CLASS                                                                            \n")
				  .append ("           ,T2.TEAMS                                                                            \n")
				  .append ("           ,T3.CUST_NM                                                                          \n");

		//입경자 체류변경
		arr_sql[1].append ("SELECT 																							\n")
				  .append ("        RTRIM(SALES.FN_DETAIL_NM('RV017',T1.CLASS))  AS CLASS         /* 반         */          \n")
				  .append ("       ,T1.TEAMS                                     AS TEAMS         /* 조         */          \n")
				  .append ("       ,T2.CUST_NM                                   AS CUST_NM       /* 성명       */          \n")
				  .append ("       ,T1.CUST_GU                                   AS CUST_GU       /* 고객구분_CU001  */     \n")
				  .append ("       ,T1.ARRIVE_DATE                               AS ARRIVE_DATE   /* 입경일자   */          \n")
				  .append ("       ,T1.ARRIVE_TIME                               AS ARRIVE_TIME   /* 입경시간   */          \n")
				  .append ("	   ,T1.DEPART_DATE                               AS DEPART_DATE   /* 출경일자   */          \n")
				  .append ("	   ,T1.DEPART_TIME                               AS DEPART_TIME   /* 출경시간   */          \n")
				  .append ("	   ,T1.GOODS_SID                                 AS GOODS_SID     /* 상품 SID   */          \n")
				  .append ("       ,T3.GOODS_NM                                  AS GOODS_NM      /* 상품명     */          \n")
				  .append ("       ,T1.RSV_SID                                   AS RSV_SID       /* 예약SID    */          \n")
				  .append ("       ,T1.INOUT_SID                                 AS INOUT_SID     /* 출입경번호 */          \n")
				  .append ("	   ,T2.MANAGE_NO								 AS MANAGE_NO	  /* 주민여권번호 */		\n")
				  .append ("   FROM SALES.TCQ010 T1 JOIN SALES.TCU010 T2 ON (T1.CUST_SID    = T2.CUST_SID)					\n")
				  .append ("                        JOIN SALES.TRM200 T3 ON (T1.GOODS_SID   = T3.GOODS_SID)                 \n")
				  .append ("  WHERE T1.STATUS_CD   =  'DP'                                                  		        \n")
				  .append ("    AND T1.SAUP_SID    = ?														                \n")
				  .append ("	AND  ? >= T1.DEPART_DATE			\n")
				  .append ("	AND  ? <= T1.ARRIVE_DATE			\n")
				  .append ("    AND ((T2.CUST_NM         LIKE  ? )                                                  		\n")
				  .append ("      OR  (T2.MANAGE_NO      LIKE  ? ))                                                   		\n")
				  .append ("   ORDER BY T1.CLASS                                                                            \n")
				  .append ("           ,T1.TEAMS                                                                            \n")
				  .append ("           ,T2.CUST_NM                                                                          \n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		GauceDataSet 		ds1 	= null;
		
		try{
			int 	v_saup_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));
			int 	v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));
			String 	v_trn_gu	 		= HDUtil.nullCheckStr(greq.getParameter("v_trn_gu"));
			String 	v_depart_date 		= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));
			String 	v_keyword		 	= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			ds1 = new GauceDataSet();
			if(ds1!=null){
				if(v_trn_gu.equals("1")) {
					//StringUtil.printMsg("arr_sql[0].toString()", StringUtil.strReplace(arr_sql[0].toString(), "$1", v_saup_sid+""), this);
					cstmt = conn.prepareCall(StringUtil.strReplace(arr_sql[0].toString(), "$1", v_saup_sid+""));
					cstmt.setString (1, v_depart_date);
					cstmt.setString (2, v_keyword+"%");
					cstmt.setString (3, v_keyword+"%");
				} else {
					//StringUtil.printMsg("arr_sql[1].toString()", StringUtil.strReplace(arr_sql[1].toString(), "$1", v_saup_sid+""), this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt    (1, v_saup_sid);
					cstmt.setString (2, v_depart_date);
					cstmt.setString (3, v_depart_date);
					cstmt.setString (4, v_keyword+"%");
					cstmt.setString (5, v_keyword+"%");
					/*
					StringUtil.printMsg("1===", v_saup_sid, this);					
					StringUtil.printMsg("2===", v_depart_date, this);
					StringUtil.printMsg("3===", v_keyword, this);
					*/
				}
				rs = cstmt.executeQuery(); // DataSet set
				gos.write(getDataSet(rs, ds1));
			}
		} catch (SQLException sqle){
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}