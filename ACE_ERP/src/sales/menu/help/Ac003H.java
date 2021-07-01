package sales.menu.help;

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
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Ac003H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//계좌번호 조회
		arr_sql[0].append ("SELECT  T1.BNKNUM     	/* 계좌번호 */	\n")
				  .append ("	   ,T1.BANCOD     	/* 은행코드 */	\n")
				  .append ("       ,T1.BNKNAM     	/* 은행지점 */	\n")
				  .append ("       ,T1.ACCTNONM   	/* 계좌명  	*/	\n")
				  .append ("  FROM ACCOUNT.BANKACC  T1				\n")
				  .append ("      ,ACCOUNT.BANKCODE T2				\n")
				  .append (" WHERE T1.BANCOD = T2.BANCOD			\n")
				  .append ("   AND T1.BNKNUM LIKE ?					\n")
				  .append ("ORDER BY T1.BNKNUM, T1.BANCOD			\n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		GauceDataSet ds1 = null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        ds1 = new GauceDataSet(); 

		try {
			String v_bank_acc_no 	= HDUtil.nullCheckStr(greq.getParameter("v_bank_acc_no"));			
            GauceDataSet[] dSets = gis.readAllOutput(); 
            
			cstmt = conn.prepareCall(arr_sql[0].toString());
			cstmt.setString(1, v_bank_acc_no + "%");
			rs = cstmt.executeQuery();
			
			gos.write(getDataSet(rs, ds1));
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
		    if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		// TODO Auto-generated method stub

	}

}
