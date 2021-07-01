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

public class Ac510S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC510S_01(?,?,?,?,?,?,?)");
	
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
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// 상품SID 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// 출경일자
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 	// 출경일자
		String sJobDate 	= HDUtil.nullCheckStr(req.getParameter("sJobDate")); 	// 작업년월
		String sAcceptNo 	= HDUtil.nullCheckStr(req.getParameter("sAcceptNo")); 	// 작업년월
		int sUpjangSid 		=  HDUtil.nullCheckNum(req.getParameter("sUpjang")); // 영업장
		
		
		
		
		StringUtil.printMsg("sSaup_sid",sSaup_sid+"",this);
		StringUtil.printMsg("sGoods_sid",sGoods_sid,this);
		StringUtil.printMsg("sSDate",sSDate+"",this);
		StringUtil.printMsg("sEDate",sEDate+"",this);
		StringUtil.printMsg("sJobDate",sJobDate+"",this);
		StringUtil.printMsg("sAcceptNo",sAcceptNo+"",this);
		StringUtil.printMsg("sUpjangSid",sUpjangSid+"",this);
		
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setInt(3, sUpjangSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setInt(6, sGoods_sid);
						cstmt.setString(7, sAcceptNo);
						
						rs = cstmt.executeQuery();			
					}
									
					getDataSet(rs, ds1).flush();

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
		// TODO Auto-generated method stub

	}

}
