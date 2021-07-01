package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac620S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Default 조회
		arr_sql[0].append ("{call SALES.PR_AC620S_01(?, ?, ? )}");
		//Detail 조회
		arr_sql[1].append ("{call SALES.PR_AC620S_02(?, ?, ?, ? )}");

	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		
		String v_job_yymm 	= HDUtil.nullCheckStr(req.getParameter("v_job_yymm"));
		String sSalDamSid 	= HDUtil.nullCheckStr(req.getParameter("sSalDamSid"));
		String sClientSid 	= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
		int    sSaup_sid	= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						//StringUtil.printMsg("sSalDamSid",sSalDamSid,this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_job_yymm);
						cstmt.setInt(2,Integer.parseInt(sSalDamSid));
						cstmt.setInt(3,sSaup_sid);
					} else if(gauceName.equals("DETAIL")){
						//StringUtil.printMsg("sSalDamSid====",sSalDamSid,this);
						//StringUtil.printMsg("sClientSid====",sClientSid,this);
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_job_yymm);
						cstmt.setInt(2,Integer.parseInt(sSalDamSid));
						cstmt.setInt(3,Integer.parseInt(sClientSid));
						cstmt.setInt(4,sSaup_sid);
					} else{
						throw new Exception ("알수 없는 DataSet Name입니다.");
					}
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
				}//if(ds1!=null)the end...
			}//while(it.hasNext()) The end...
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
		    if(cstmt!=null) cstmt.close();
		}

	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
