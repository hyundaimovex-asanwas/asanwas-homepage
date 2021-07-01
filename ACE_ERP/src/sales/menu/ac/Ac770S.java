package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Ac770S extends SuperServlet {
	 
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC770S_01(?,?,?)"); // 조회
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
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String sFr_date 	= HDUtil.nullCheckStr(req.getParameter("sFr_date"));	// 시작일자
		String sTo_date 	= HDUtil.nullCheckStr(req.getParameter("sTo_date")); 	// 종료일자
		String sVendCd		= HDUtil.nullCheckStr(req.getParameter("sVendCd"));		//거래처코드
		StringUtil.printMsg("시작일자",sFr_date+"",this);
		StringUtil.printMsg("종료일자",sTo_date+"",this);
		StringUtil.printMsg("거래처",sVendCd+"",this);
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setString(1,sFr_date);
							cstmt.setString(2,sTo_date);
							cstmt.setString(3,sVendCd);
							rs = cstmt.executeQuery();							
							
							getDataSet(rs, ds1).flush();
							break;
						case 2:
							break;
						case 3:
							break;
					}
				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		

	}
}
