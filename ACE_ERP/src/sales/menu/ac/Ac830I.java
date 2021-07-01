package sales.menu.ac;

import java.sql.CallableStatement;
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

public class Ac830I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//조회
		arr_sql[0].append ("{call SALES.PR_AC830I_01(?, ?)}");

		arr_sql[3].append ("{call SALES.PR_AC820I_04(?)}");
		
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
		GauceDataSet ds2 = null;
		
		String v_fr_date 			= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
		String v_to_date 			= HDUtil.nullCheckStr(req.getParameter("v_to_date"));
		String v_pay_manage_no		= HDUtil.nullCheckStr(req.getParameter("v_pay_manage_no"));
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						cstmt = conn.prepareCall(arr_sql[0].toString()); 
						cstmt.setString(1, v_fr_date);
						cstmt.setString(2, v_to_date);
					}
					if(gauceName.equals("DS2")){
						cstmt = conn.prepareCall(arr_sql[3].toString()); 
						cstmt.setString(1, v_pay_manage_no);
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
		CallableStatement cstmt = null;
		GauceDataSet ds1 = null;
		GauceDataSet ds2 = null;
		GauceDataSet ds_result = null;
		try {
			ds1 = req.getGauceDataSet("DEFAULT");
			ds2 = req.getGauceDataSet("DEFAULT2");
			ds_result = req.getGauceDataSet("RESULT");
			
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				for(int i = 0; i < rows.length; i++) {
					cstmt = conn.prepareCall(arr_sql[1].toString());
StringUtil.printMsg("card_sid", rows[i].getInt(ds1.indexOfColumn("CARD_SID")), this);
					cstmt.setInt (1, rows[i].getInt(ds1.indexOfColumn("CARD_SID")));
					cstmt.setString (2, rows[i].getString(ds1.indexOfColumn("REQ_DATE")));
					cstmt.setString (3, fParamEmpno);
					cstmt.setString (4, fParamIp);
					cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);	//메세지
					
					cstmt.executeUpdate();
					
					if(!cstmt.getString(5).equals("Y"))
						throw new Exception (cstmt.getString(7));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(5));
						row1.addColumnValue(cstmt.getString(6));
						row1.addColumnValue(cstmt.getString(7));
						
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
