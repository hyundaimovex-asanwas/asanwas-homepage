package sales.menu.help;


import javax.servlet.ServletException;
import sales.common.*;
import sales.common.HDUtil;
import sales.common.StringUtil;

import java.sql.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import oracle.jdbc.OracleTypes;

public class Rv001H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT R1.ACCEPT_SID,														\n")
				  .append ("	   R1.ACCEPT_NO,                                         /* 신청서 번호 */	\n")
				  .append ("       SUBSTR(R1.DEPART_DATE, 5, 2) || '/'                                  \n")
				  .append ("       || SUBSTR(R1.DEPART_DATE, 7, 2) || ' '                               \n")
				  .append ("       || SALES.FN_GOODS_NM(R1.GOODS_SID, '') AS GOODS_NM,   /* 상품명      	*/	\n")
				  .append ("       R1.DEPART_DATE,                                       /* 출발일자    */	\n")
				  .append ("       R2.DEPART_TIME,                                       /* 출발시간    */	\n")
				  .append ("       R2.NIGHTS,			                                 /* 박수           */	\n")
				  .append ("       R1.GOODS_SID,                                         /* 상품SID  */ 	\n")
				  .append ("       R2.ARRIVE_DATE,                                       /* 복귀일자    */	\n")
				  .append ("       R2.ARRIVE_TIME,                                       /* 복귀시간    */    	\n")
				  .append ("       R1.CLIENT_SID,										 /* 매출처 SID  */      \n")
				  .append ("       C1.CLIENT_CD,										 /* 매출처 코드 */      \n")
				  .append ("       C1.CLIENT_NM											 /* 매출처 명   */  	\n")
				  .append ("FROM   SALES.TRV010 R1 JOIN SALES.TRM220 R2                                       	\n")
				  .append ("	   ON R2.GOODS_SID   =  R1.GOODS_SID                                            \n")
				  .append ("	   JOIN SALES.TCU030 C1                                                         \n")
				  .append ("	   ON R1.CLIENT_SID = C1.CLIENT_SID                                             \n")
				  .append ("WHERE  R1.DEPART_DATE BETWEEN ? AND ?											\n")
				  .append ("  AND  R2.DEPART_DATE =  R1.DEPART_DATE			                             	\n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		try{
			String v_client_cd    = HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));
			String v_depart_date1 = HDUtil.nullCheckStr(greq.getParameter("v_depart_date1"));
			String v_depart_date2 = HDUtil.nullCheckStr(greq.getParameter("v_depart_date2"));
			
			if(!v_client_cd.equals(""))
				arr_sql[0].append ("  AND C1.CLIENT_CD = ?		\n");

//StringUtil.printMsg("arr_sql[0].toString()", arr_sql[0].toString(), this);
//StringUtil.printMsg("v_depart_date1", v_depart_date1, this);
//StringUtil.printMsg("v_depart_date2", v_depart_date2, this);
//StringUtil.printMsg("v_client_cd", v_client_cd, this);

			ds1 = new GauceDataSet();
			cstmt = conn.prepareCall(arr_sql[0].toString());
			cstmt.setString(1, v_depart_date1);
			cstmt.setString(2, v_depart_date2);
			
			if(!v_client_cd.equals(""))
				cstmt.setString(3, v_client_cd);
			
			rs = cstmt.executeQuery(); // DataSet set
			gos.write(getDataSet(rs, ds1));
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
