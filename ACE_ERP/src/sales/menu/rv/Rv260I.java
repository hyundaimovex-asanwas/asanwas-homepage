package sales.menu.rv;

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

public class Rv260I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Default 조회
		arr_sql[0].append ("{call SALES.PR_RV260I_01(?, ?, ?, ?, ?, ?, ?)}");
		
		//Option Master 조회
		arr_sql[1].append ("{call SALES.PR_RV260I_02(?, ?, ?)}");
		
		//Option Detail 조회
		arr_sql[2].append ("{call SALES.PR_RV260I_03(?)}");
		
		//Option 저장
		arr_sql[3].append ("{call SALES.PR_RV260I_04(?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?, ?, ?, ?, ?,  ?)}");
		//arr_sql[3].append ("{call SALES.PR_RV260I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
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
		
		int v_saup_sid 		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		int v_goods_sid 	= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));
		int v_client_sid 	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));
		String v_accept_no 	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));
		String v_fr_depart_date = HDUtil.nullCheckStr(req.getParameter("v_fr_depart_date"));
		String v_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_manage_no"));
		String v_cust_nm 	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));
		String v_depart_date 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		
		int v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		int v_rsv_sid 		= HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("왜!!!!:::" , gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, v_saup_sid);
						cstmt.setInt(2, v_goods_sid);
						cstmt.setInt(3, v_client_sid);
						cstmt.setString(4, v_accept_no);
						cstmt.setString(5, v_fr_depart_date);
						cstmt.setString(6, v_manage_no);
						cstmt.setString(7, v_cust_nm);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_upjang_sid);
						cstmt.setString(2, v_depart_date);
						cstmt.setInt(3, v_rsv_sid);
						StringUtil.printMsg("v_upjang_sid:::" , v_upjang_sid, this);
						StringUtil.printMsg("v_depart_date:::" , v_depart_date, this);
						StringUtil.printMsg("v_rsv_sid:::" , v_rsv_sid, this);
						
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();						
					} else if(gauceName.equals("DETAIL")){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_rsv_sid);
						rs = cstmt.executeQuery();
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
		    if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		
		int v_rsv_sid 		= HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));
		String v_depart_date = HDUtil.nullCheckStr(req.getParameter("v_depart_date"));
		String v_rsv_pay_yn = "";
		String v_job_status = "";
    	
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = null;
		try {
			ds1 = req.getGauceDataSet("DETAIL");
			ds_result = req.getGauceDataSet("RESULT");
			
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("KEY_SEQ", GauceDataColumn.TB_NUMBER));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				
				for(int i = 0; i < rows.length; i++) {
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					if(rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
						v_job_status = "1";
					else if(rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
						v_job_status = "2";
					else if(rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
						v_job_status = "3";
					else v_job_status = "0";
					
					v_rsv_pay_yn = rows[i].getString(ds1.indexOfColumn("RSV_PAY_YN"));
					if(v_rsv_pay_yn.equals("T")) {
						v_rsv_pay_yn = "Y";
					}else{
						v_rsv_pay_yn = "N";
					} ;

					cstmt.setInt	(1, v_rsv_sid);
					cstmt.setInt    (2, rows[i].getInt(ds1.indexOfColumn("MENU_SID")));
					cstmt.setString (3, v_depart_date);
					cstmt.setInt    (4, rows[i].getInt(ds1.indexOfColumn("KEY_SEQ")));
					cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);	//KEY_SEQ
					cstmt.setString (5, v_rsv_pay_yn);
					cstmt.setInt    (6, rows[i].getInt(ds1.indexOfColumn("UNIT_AMT")));
					cstmt.setInt    (7, rows[i].getInt(ds1.indexOfColumn("SALE_QTY")));
					cstmt.setString (8, rows[i].getString(ds1.indexOfColumn("CURRENCY_CD")));	//pCURRENCY_CD
					cstmt.setInt (9, rows[i].getInt(ds1.indexOfColumn("EXCH_AMT")));//pEXCH_AMT	단가
					cstmt.setString (10, rows[i].getString(ds1.indexOfColumn("REMARKS")));
					cstmt.setString (11, fParamEmpno);
					cstmt.setString (12, fParamIp);
					cstmt.setString (13, v_job_status);
										
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지

					//StringUtil.printMsg("v_rsv_sid:::" , v_rsv_sid, this); 
					//StringUtil.printMsg("MENU_SID:::" , rows[i].getInt(ds1.indexOfColumn("MENU_SID")), this);
					//StringUtil.printMsg("v_depart_date:::" , v_depart_date, this);
					//StringUtil.printMsg("KEY_SEQ:::" , rows[i].getInt(ds1.indexOfColumn("KEY_SEQ")), this);
					//StringUtil.printMsg("v_rsv_pay_yn:::" , v_rsv_pay_yn, this);
					//StringUtil.printMsg("UNIT_AMT:::" , rows[i].getInt(ds1.indexOfColumn("UNIT_AMT")), this);
					//StringUtil.printMsg("SALE_QTY:::" , rows[i].getInt(ds1.indexOfColumn("SALE_QTY")), this);
					//StringUtil.printMsg("CURRENCY_NM:::" , rows[i].getInt(ds1.indexOfColumn("CURRENCY_NM")), this);
					//StringUtil.printMsg("REMARKS:::" , rows[i].getString(ds1.indexOfColumn("REMARKS")), this);
					//StringUtil.printMsg("fParamEmpno:::" , fParamEmpno, this);
					//StringUtil.printMsg("fParamIp:::" , fParamIp, this);
					//StringUtil.printMsg("v_job_status:::" , v_job_status, this);

					cstmt.executeUpdate();
					
					//if(!cstmt.getString(12).equals("Y"))
					if(!cstmt.getString(14).equals("Y"))					
						throw new Exception (cstmt.getString(16));
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getBigDecimal(4).intValue());
/*					row1.addColumnValue(cstmt.getString(12));
						row1.addColumnValue(cstmt.getString(13));
						row1.addColumnValue(cstmt.getString(14));
*/
						row1.addColumnValue(cstmt.getString(14));
						row1.addColumnValue(cstmt.getString(15));
						row1.addColumnValue(cstmt.getString(16));

						
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
