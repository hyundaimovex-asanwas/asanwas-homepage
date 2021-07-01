package sales.menu.ac;

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

public class Ac760B extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Default 조회
		arr_sql[1].append ("{call SALES.PR_AC760B_01(?, ?, ?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		
		//청구일자
		String v_req_date 	= HDUtil.nullCheckStr(req.getParameter("v_req_date"));
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_req_date);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1, v_req_date);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("DATE")){
						stmt = conn.prepareStatement(arr_sql[0].toString());
						stmt.setString(1, v_req_date);
						rs = stmt.executeQuery();
						getDataSet(rs, ds1).flush();
					} else{
						throw new Exception ("알수 없는 DataSet Name입니다.");
					}
					
				}//if(ds1!=null)the end...
			}//while(it.hasNext()) The end...
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
		    if(stmt!=null) stmt.close();
		    if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;

		GauceDataSet ds_result = req.getGauceDataSet("RESULT");

		String v_req_date 	= HDUtil.nullCheckStr(req.getParameter("v_req_date"));
		String v_req_date2	= HDUtil.nullCheckStr(req.getParameter("v_req_date2"));
		System.out.println(v_req_date);
		System.out.println("v_req_date2"+v_req_date2);
		try{
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("WORK_DATE", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(!v_req_date.equals("")){
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setString(1, v_req_date);
				cstmt.setString(2, v_req_date2);
				cstmt.setString(3, fParamEmpno);
				cstmt.setString(4, fParamIp);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				
				cstmt.executeUpdate();
				
				String r_s_yn		= cstmt.getString(5);
				String r_msg_cd	 	= cstmt.getString(6);
				String r_msg		= cstmt.getString(7);
				
				if(!r_s_yn.equals("Y"))
					throw new Exception ("");
				if(cstmt!=null) cstmt.close();
				
				

				if(ds_result!=null){
					GauceDataRow row1 = ds_result.newDataRow();
					row1.addColumnValue(r_s_yn);
					row1.addColumnValue(r_msg_cd);
					row1.addColumnValue(r_msg);
					
					ds_result.addDataRow(row1);
				}
				
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
