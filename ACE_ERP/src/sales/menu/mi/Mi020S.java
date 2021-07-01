package sales.menu.mi;

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

public class Mi020S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_MI020S_01(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
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
		
		int 	sSaup_Sid		= HDUtil.nullCheckNum(req.getParameter("sSaup_Sid"));
		String 	sFr_Depart_Date	= HDUtil.nullCheckStr(req.getParameter("sFr_Depart_Date"));
		String 	sTo_Depart_Date	= HDUtil.nullCheckStr(req.getParameter("sTo_Depart_Date"));
		int 	sGoods_Sid		= HDUtil.nullCheckNum(req.getParameter("sGoods_Sid"));
		int 	sNorth_Cnt		= HDUtil.nullCheckNum(req.getParameter("sNorth_Cnt"));
		String 	sCust_Nm		= HDUtil.nullCheckStr(req.getParameter("sCust_Nm"));
		String 	sManage_No		= HDUtil.nullCheckStr(req.getParameter("sManage_No"));
		String 	sSex			= HDUtil.nullCheckStr(req.getParameter("sSex"));
		String 	sAge_Cd			= HDUtil.nullCheckStr(req.getParameter("sAge_Cd"));
		String 	sJob_Cd			= HDUtil.nullCheckStr(req.getParameter("sJob_Cd"));
		String 	sCust_Gu		= HDUtil.nullCheckStr(req.getParameter("sCust_Gu"));
		String 	sSaup_Gu		= HDUtil.nullCheckStr(req.getParameter("sSaup_Gu"));
		String 	sCountry_Gu		= HDUtil.nullCheckStr(req.getParameter("sCountry_Gu"));
		String 	sArea_Cd		= HDUtil.nullCheckStr(req.getParameter("sArea_Cd"));
		String 	sCountry_Cd		= HDUtil.nullCheckStr(req.getParameter("sCountry_Cd"));

		StringUtil.printMsg("sSaup_Sid			",sSaup_Sid, this);
		StringUtil.printMsg("sFr_Depart_Date	",sFr_Depart_Date, this);
		StringUtil.printMsg("sTo_Depart_Date	",sTo_Depart_Date, this);
		StringUtil.printMsg("sGoods_Sid			",sGoods_Sid, this);
		StringUtil.printMsg("sNorth_Cnt			",sNorth_Cnt, this);
		StringUtil.printMsg("sCust_Nm			",sCust_Nm, this);
		StringUtil.printMsg("sManage_No			",sManage_No, this);
		StringUtil.printMsg("sSex				",sSex, this);
		StringUtil.printMsg("sAge_Cd			",sAge_Cd, this);
		StringUtil.printMsg("sJob_Cd			",sJob_Cd, this);
		StringUtil.printMsg("sSaup_Gu			",sSaup_Gu, this);
		StringUtil.printMsg("sCountry_Gu		",sCountry_Gu, this);
		StringUtil.printMsg("sArea_Cd			",sArea_Cd, this);
		StringUtil.printMsg("sCountry_Cd		",sCountry_Cd, this);


		
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
						cstmt.setInt(1,sSaup_Sid);
						cstmt.setString(2, sFr_Depart_Date);
						cstmt.setString(3, sTo_Depart_Date);
						cstmt.setInt(4, sGoods_Sid);
						cstmt.setInt(5, sNorth_Cnt);
						
						cstmt.setString(6, sCust_Nm);
						cstmt.setString(7, sManage_No);
						cstmt.setString(8, sSex);
						cstmt.setString(9, sAge_Cd);
						cstmt.setString(10, sCust_Gu);
						
						
						cstmt.setString(11, sSaup_Gu);
						cstmt.setString(12, sArea_Cd);
						cstmt.setString(13, sJob_Cd);
						cstmt.setString(14, sCountry_Gu);
						cstmt.setString(15, sCountry_Cd);
						
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
