package sales.menu.ac;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

public class Ac510B extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		//생성
		arr_sql[0].append("{CALL SALES.PR_AC510B_01(?, ?, ?, ?, ?, ?)}");
		
		//조회
		arr_sql[1].append("{CALL SALES.PR_AC510B_02(?, ?, ?, ?, ?, ?, ?)}");

		//저장
		arr_sql[2].append("{CALL SALES.PR_AC510B_03(?, ?, ?, ?, ?, ?, ?, ?, ?)}");

		//삭제
		arr_sql[3].append("{CALL SALES.PR_AC510B_04(?, ?, ?, ?)}");
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
		String	v_job_yymm	 	= HDUtil.nullCheckStr(req.getParameter("v_job_yymm"));		//SEASON INFO
		int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		String	v_fr_date	 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		//SEASON INFO
		String	v_to_date		= HDUtil.nullCheckStr(req.getParameter("v_to_date"));			//AGE INFO		
		int     v_goods			= HDUtil.nullCheckNum(req.getParameter("v_goods"));		//NIGHTS INFO
		String	v_accept_no		= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));			//AGE INFO		

		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[1].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setString	(2, v_job_yymm);
				cstmt.setInt	(3, v_upjang_sid);
				cstmt.setString	(4, v_fr_date);
				cstmt.setString (5, v_to_date);
				cstmt.setInt	(6, v_goods);
				cstmt.setString (7, v_accept_no);
				
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

		GauceDataSet ds1 		= req.getGauceDataSet("CREATE");
		GauceDataSet ds2 		= req.getGauceDataSet("SAVE");
		GauceDataSet ds3 		= req.getGauceDataSet("DELETE");
		GauceDataSet ds_result 	= req.getGauceDataSet("RESULT");

		String	v_job_yymm	 	= HDUtil.nullCheckStr(req.getParameter("v_job_yymm"));		//SEASON INFO
//StringUtil.printMsg("v_job_yymm", v_job_yymm, this);

		try{
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			//생성
			if(ds1!=null){
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setString(1, v_job_yymm);
				cstmt.setString(2, fParamEmpno);
				cstmt.setString(3, fParamIp);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);	//성공여부
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);	//메세지 코드
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	//메세지
				cstmt.executeUpdate();
				
				if(!cstmt.getString(4).equals("Y"))
					throw new Exception (cstmt.getString(6));

				if(ds_result!=null){
					GauceDataRow row1 = ds_result.newDataRow();
					row1.addColumnValue(cstmt.getString(4));
					row1.addColumnValue(cstmt.getString(5));
					row1.addColumnValue(cstmt.getString(6));
					ds_result.addDataRow(row1);
				}

				if(cstmt!=null) cstmt.close();
			}

			//저장
			if(ds2!=null){

				GauceDataRow[]    row  = ds2.getDataRows();
//StringUtil.printMsg("row.length", row.length, this);
				for(int i=0; i<row.length; i++){
					int v_cnt = 1;	
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(v_cnt++, row[i].getString(ds2.indexOfColumn("JOB_YYMM")));
					cstmt.setInt   (v_cnt++, row[i].getInt(ds2.indexOfColumn("RSV_SID")));

					cstmt.setInt   (v_cnt++, row[i].getInt(ds2.indexOfColumn("TOT_ROOM_AMT")));

					
					cstmt.setString(v_cnt++, fParamEmpno);
					cstmt.setString(v_cnt++, fParamIp);
					cstmt.setString(v_cnt++, "3");
					cstmt.registerOutParameter(v_cnt++, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(v_cnt++, java.sql.Types.VARCHAR);	//메세지 코드
					
					cstmt.registerOutParameter(v_cnt++, java.sql.Types.VARCHAR);	//메세지
					cstmt.executeUpdate();
					
					if(!cstmt.getString(7).equals("Y"))
						throw new Exception (cstmt.getString(9));

					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(7));
						row1.addColumnValue(cstmt.getString(8));
						row1.addColumnValue(cstmt.getString(9));
						ds_result.addDataRow(row1);
					}

					if(cstmt!=null) cstmt.close();
				}
				
				//삭제
				if(ds3!=null){
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, v_job_yymm);
					cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);	//성공여부
					cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);	//메세지 코드
					cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);	//메세지
					cstmt.executeUpdate();
					
					if(!cstmt.getString(2).equals("Y"))
						throw new Exception (cstmt.getString(4));

					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(cstmt.getString(2));
						row1.addColumnValue(cstmt.getString(3));
						row1.addColumnValue(cstmt.getString(4));
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
