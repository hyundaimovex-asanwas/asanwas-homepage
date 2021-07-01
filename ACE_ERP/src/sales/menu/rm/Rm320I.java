package sales.menu.rm;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rm320I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Default 조회
		arr_sql[1].append ("{call SALES.PR_RM320I_01(?, ?, ?, ?, ?, ?)}");
		arr_sql[2].append ("{call SALES.PR_RM320I_02(?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		
		int v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		String v_req_date 	= HDUtil.nullCheckStr(req.getParameter("v_req_date"));
		String v_req_date2	= HDUtil.nullCheckStr(req.getParameter("v_req_date2"));
		String v_req_date3	= HDUtil.nullCheckStr(req.getParameter("v_req_date3"));
		String v_req_date4	= HDUtil.nullCheckStr(req.getParameter("v_req_date4"));
		
		try{
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(!v_req_date.equals("") || !v_req_date2.equals("")){
				StringUtil.printMsg("v_upjang_sid",v_upjang_sid,this);
				StringUtil.printMsg("v_req_date",v_req_date,this);
				StringUtil.printMsg("v_req_date2",v_req_date2,this);
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setInt(1,v_upjang_sid);
				cstmt.setString(2, v_req_date);
				cstmt.setString(3, v_req_date2);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				
				cstmt.executeUpdate();
				
		
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			if(!v_req_date3.equals("") || !v_req_date4.equals("")){
				cstmt = conn.prepareCall(arr_sql[2].toString());
				StringUtil.printMsg("v_req_date3",v_req_date3,this);
				StringUtil.printMsg("v_req_date4",v_req_date4,this);
				cstmt.setString(1, v_req_date3);
				cstmt.setString(2, v_req_date4);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				
				cstmt.executeUpdate();
				
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
			if(ds_result!=null) ds_result.flush();
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

}
