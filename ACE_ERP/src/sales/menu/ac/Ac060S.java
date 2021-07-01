package sales.menu.ac;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac060S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC060S_01(?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[2].append("CALL SALES.PR_AC060S_02(?, ?, ?, ?, ?, ?, ?, ?)");
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));		// 사업소
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));		// 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));		// 매출처 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 			// 입금일자 시작
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 			// 입금일자 종료 
		String sPay_cd		= HDUtil.nullCheckStr(req.getParameter("sPay_cd")); 		// 입금형태
		
		String sPayDate 	= HDUtil.nullCheckStr(req.getParameter("sPayDate")); 		// 입금일
		String sPayCd 		= HDUtil.nullCheckStr(req.getParameter("sPayCd")); 			// 입금구분
		
		String v_out_gubn	= HDUtil.nullCheckStr(req.getParameter("v_out_gubn"));// 출경구분
		
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); // 고객구분 
		
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						
						
						
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setString(6, sPay_cd);
						cstmt.setString(7, v_out_gubn);
						cstmt.setString(8, sCustGu);
						
						rs = cstmt.executeQuery();	
						
						getDataSet(rs, ds1).flush();
					
					} 
					
					if ("DS2".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setString(6, sPay_cd);
						cstmt.setString(7, v_out_gubn);
						cstmt.setString(8, sCustGu);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					} 
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
