package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Ac500I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[0].append("{CALL SALES.PR_AC500I_01(?, ?, ?, ?, ?, ?, ?)}");
		
		arr_sql[1].append("{CALL SALES.PR_AC500I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet 		  rs 	= null;
		GauceDataSet 	  ds1 	= null; 

		int 	v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		String	v_season	 	= HDUtil.nullCheckStr(req.getParameter("v_season"));		//SEASON INFO
		int     v_room		 	= HDUtil.nullCheckNum(req.getParameter("v_room"));	//ROOM INFO
		String	v_cust_gu	 	= HDUtil.nullCheckStr(req.getParameter("v_cust_gu"));		//SEASON INFO
		String	v_age			= HDUtil.nullCheckStr(req.getParameter("v_age"));			//AGE INFO		
		int     v_goods			= HDUtil.nullCheckNum(req.getParameter("v_goods"));		//NIGHTS INFO

//StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
//StringUtil.printMsg("v_upjang_sid", v_upjang_sid, this);
//StringUtil.printMsg("v_season", v_season, this);
//StringUtil.printMsg("v_room", v_room, this);
//StringUtil.printMsg("v_cust_gu", v_cust_gu, this);
//StringUtil.printMsg("v_age", v_age, this);
//StringUtil.printMsg("v_goods", v_goods, this);
		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setInt	(2, v_upjang_sid);
				cstmt.setString (3, v_season);
				cstmt.setInt	(4, v_room);
				cstmt.setString (5, v_cust_gu);
				cstmt.setString (6, v_age);
				cstmt.setInt	(7, v_goods);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds1).flush();
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
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

		GauceDataSet ds1 		= req.getGauceDataSet("MASTER");
		GauceDataSet ds_result 	= req.getGauceDataSet("RESULT");
		
		String v_edit_status = "";
		try{
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("BASE_ROOM_SID", GauceDataColumn.TB_NUMBER));
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}

			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
				
				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = "1";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = "2";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = "3";
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt   (1, row[i].getInt(ds1.indexOfColumn("BASE_ROOM_SID")));
					cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);
					cstmt.setInt   (2, row[i].getInt(ds1.indexOfColumn("SAUP_SID")));
					cstmt.setInt   (3, row[i].getInt(ds1.indexOfColumn("ROOM_TYPE_SID")));
					cstmt.setInt   (4, row[i].getInt(ds1.indexOfColumn("UPJANG_SID")));
					cstmt.setInt   (5, row[i].getInt(ds1.indexOfColumn("GOODS_SID")));
					
					cstmt.setString(6, row[i].getString(ds1.indexOfColumn("SEASON_CD")));
					cstmt.setString(7, row[i].getString(ds1.indexOfColumn("CUST_GU")));
					cstmt.setString(8, row[i].getString(ds1.indexOfColumn("AGE_CD")));
					cstmt.setString(9, row[i].getString(ds1.indexOfColumn("CUST_TYPE")));
					cstmt.setString(10, row[i].getString(ds1.indexOfColumn("METHOD_GU")));
					
					cstmt.setInt   (11, row[i].getInt(ds1.indexOfColumn("TOUR_BASE_AMT")));
					cstmt.setInt   (12, row[i].getInt(ds1.indexOfColumn("BASE_ROOM_AMT")));
					cstmt.setString(13, row[i].getString(ds1.indexOfColumn("STATUS_CD")));
					cstmt.setString(14, row[i].getString(ds1.indexOfColumn("FR_DATE")));
					cstmt.setString(15, row[i].getString(ds1.indexOfColumn("TO_DATE")));
					
					cstmt.setString(16, row[i].getString(ds1.indexOfColumn("BGN_PERSONS")));
					cstmt.setString(17, row[i].getString(ds1.indexOfColumn("END_PERSONS")));
					
					cstmt.setString(18, row[i].getString(ds1.indexOfColumn("USE_YN")));
					cstmt.setString(19, fParamEmpno);
					cstmt.setString(20, fParamIp);
					cstmt.setString(21, v_edit_status);
					cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);	//메세지
					cstmt.executeUpdate();
					
StringUtil.printMsg("cstmt.getBigDecimal(1).intValue()", cstmt.getBigDecimal(1).intValue(), this);
//StringUtil.printMsg("cstmt.getString(20)", cstmt.getString(20), this);
//StringUtil.printMsg("cstmt.getString(21)", cstmt.getString(21), this);
//StringUtil.printMsg("cstmt.getString(22)", cstmt.getString(22), this);

					if(!cstmt.getString(22).equals("Y"))
						throw new Exception (cstmt.getString(24));

					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getBigDecimal(1).intValue());
						row1.addColumnValue(cstmt.getString(22));
						row1.addColumnValue(cstmt.getString(23));
						row1.addColumnValue(cstmt.getString(24));
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
