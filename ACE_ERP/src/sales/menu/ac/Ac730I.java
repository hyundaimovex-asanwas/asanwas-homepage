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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac730I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//Master 조회
		arr_sql[0].append ("{CALL SALES.PR_AC730I_01(?, ?, ?)}");
		
		//Master 저장
		arr_sql[1].append ("{CALL SALES.PR_AC730I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		
		String v_fr_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));
		String v_vend_cd 	= HDUtil.nullCheckStr(req.getParameter("v_vend_cd"));
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_fr_date);
						cstmt.setString(2, v_to_date);
						cstmt.setString(3, v_vend_cd);
					} else
						throw new Exception ("알수 없는 DataSet Name입니다.");
					
					rs = cstmt.executeQuery();
					getDataSetHead(rs, ds1).flush();
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

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		
		String v_fr_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String v_to_date 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));
		String v_vend_cd 	= HDUtil.nullCheckStr(req.getParameter("v_vend_cd"));
		
		String v_bank_acc_no 	= HDUtil.nullCheckStr(req.getParameter("v_bank_acc_no"));
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, v_fr_date);
						cstmt.setString(2, v_to_date);
						cstmt.setString(3, v_vend_cd);
						rs = cstmt.executeQuery();
					} else
						throw new Exception ("알수 없는 DataSet Name입니다.");
					
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
		CallableStatement cstmt = null;
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = null;
		
		try {
			ds_result = req.getGauceDataSet("RESULT");
			String v_edit_status = "";
			
			ds1 = req.getGauceDataSet("MASTER");

			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("BILL_NO", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				for(int i = 0; i < rows.length; i++) {
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = "1";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = "2";
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = "3";
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString (1, rows[i].getString(ds1.indexOfColumn("BILL_NO")));
					cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
					cstmt.setString (2, rows[i].getString(ds1.indexOfColumn("BILL_DATE")));
					cstmt.setString	(3, rows[i].getString(ds1.indexOfColumn("VEND_CD")));
					cstmt.setString	(4, rows[i].getString(ds1.indexOfColumn("BILL_GU")));
					cstmt.setString	(5, rows[i].getString(ds1.indexOfColumn("BANCOD")));
					cstmt.setString	(6, rows[i].getString(ds1.indexOfColumn("BANK_ACC_NO")));
					cstmt.setString	(7, rows[i].getString(ds1.indexOfColumn("PAY_MANAGE_NO")));
					cstmt.setInt	(8, rows[i].getInt(ds1.indexOfColumn("BILL_AMT")));
					cstmt.setString (9, rows[i].getString(ds1.indexOfColumn("BILL_EMPNO")));
					cstmt.setString (10, fParamEmpno);
					cstmt.setString (11, fParamIp);
					cstmt.setString (12, v_edit_status);
					cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					if(!cstmt.getString(13).equals("Y"))
						throw new Exception (cstmt.getString(15));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(1));
						row1.addColumnValue(cstmt.getString(13));
						row1.addColumnValue(cstmt.getString(14));
						row1.addColumnValue(cstmt.getString(15));
						
						ds_result.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
			}
			
			if(ds_result!=null) ds_result.flush();
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(cstmt!=null) cstmt.close();
		}
	}
}
