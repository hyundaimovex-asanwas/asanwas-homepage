package sales.menu.rm;

import java.sql.*;
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

public class Rm610I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		//��ȸ
		arr_sql[0].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");

		//��ȸ
		arr_sql[1].append ("{call SALES.PR_RM610I_01(?, ?, ?, ?, ?, ?)}");
		

		//����
		arr_sql[2].append ("{call SALES.PR_RM610I_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 	= null;
		PreparedStatement 	stmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		
		try{
			int 	v_client_sid		= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));
			int 	v_goods_sid			= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));
			String 	v_block_no	 		= HDUtil.nullCheckStr(req.getParameter("v_block_no"));
			String 	v_fr_date	 		= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));
			String 	v_to_date	 		= HDUtil.nullCheckStr(req.getParameter("v_to_date"));
			String 	v_job_sel		 	= HDUtil.nullCheckStr(req.getParameter("v_job_sel"));
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						String temp_sql = arr_sql[0].toString();
						temp_sql = StringUtil.strReplace(temp_sql, "$1", v_fr_date);
						temp_sql = StringUtil.strReplace(temp_sql, "$2", v_to_date);
						
						stmt = conn.getGauceStatement(temp_sql);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>31){
								res.writeException("ERROR", "0000", "�Ⱓ�� �Ѵ��̳��� �Ͻñ� �ٶ��ϴ�.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "�Ⱓ���� ���ڸ� ����ϴ��� ������ �߻��߽��ϴ�.");
							break;
						}
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt	(1, v_client_sid);
						cstmt.setInt	(2, v_goods_sid);
						cstmt.setString (3, v_fr_date);
						cstmt.setString (4, v_to_date);
						cstmt.setString (5, v_block_no);
						cstmt.setString (6, v_job_sel);
						
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
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

		CallableStatement 	cstmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		GauceDataSet 		ds_result 	= null;
		
		String v_edit_status = "";
		
		String r_s_yn = "";
		String r_msg_cd = "";
		String r_msg = "";
		
		try{
			String v_pay_cd		 	= HDUtil.nullCheckStr(req.getParameter("v_pay_cd"));		//�Աݱ���
			String v_pay_date		= HDUtil.nullCheckStr(req.getParameter("v_pay_date"));		//�Ա�����
			String v_pay_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_pay_manage_no"));	//���������ȣ
			String v_plan_pay_date 	= HDUtil.nullCheckStr(req.getParameter("v_plan_pay_date"));	//�Աݿ�������

			ds1 = req.getGauceDataSet("DEFAULT");
			ds_result = req.getGauceDataSet("RESULT");
			if(ds1!=null){
				if(ds_result!=null){
					res.enableFirstRow(ds_result);
					ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
					ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
				}
				
				GauceDataRow[] row = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				/*for(int j=0; j<cols.length; j++){
					if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
						StringUtil.printMsg("TB_NUMBER", j + " " + cols[j].getColName(), this);
					else if(cols[j].getColType()== GauceDataColumn.TB_INT )
						StringUtil.printMsg("TB_INT", j + " " + cols[j].getColName(), this);
					else if(cols[j].getColType()== GauceDataColumn.TB_STRING  )
						StringUtil.printMsg("TB_STRING", j + " " + cols[j].getColName(), this);
				}*/
				
				for(int i=0; i<row.length; i++){
					if(row[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
						v_edit_status = 1+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
						v_edit_status = 2+"";
					if(row[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
						v_edit_status = 3+"";
					
					cstmt = conn.prepareCall(arr_sql[2].toString());

					cstmt.setInt(1, row[i].getInt(16));			//��ϰ��� SID
					cstmt.registerOutParameter(1, java.sql.Types.DECIMAL);//��ϰ��� SID
					cstmt.setInt(2, row[i].getInt(17));			//���κ�� SID
					cstmt.setInt(3, row[i].getInt(18));			//��� SID
//StringUtil.printMsg("row[i].getString(1)", row[i].getString(1), this);
					cstmt.setString(4, row[i].getString(1));	//��û����
					cstmt.setString(5, v_plan_pay_date);		//�Աݰ濹������
					cstmt.setString(6, v_pay_date);				//��������
					cstmt.setInt(7, row[i].getInt(15));			//����ݾ�
					if(v_pay_cd.equals("020")){	
						cstmt.setString(8, "N");					//���翩��(������¸� N)
					} else { 					
						cstmt.setString(8, "Y");					//���翩��(�ٸ� ���̸� Y)
					}				

					cstmt.setString(9, v_pay_cd);				//�Աݰ����ڵ�
					cstmt.setString(10, v_pay_manage_no);		//���������ȣ
					cstmt.setInt(11, row[i].getInt(21));		//����ó SID
					cstmt.setInt(12, row[i].getInt(19));		//����SID
					cstmt.setString(13, fParamEmpno);
					cstmt.setString(14, fParamIp);
					cstmt.setString(15, v_edit_status);
					cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//��������
					cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//�޼��� �ڵ�
					cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);	//�޼���
					
					cstmt.executeUpdate();
					
					r_s_yn 		= cstmt.getString(16);
					r_msg_cd 	= cstmt.getString(17);
					r_msg 		= cstmt.getString(18);
//StringUtil.printMsg("r_s_yn", r_s_yn, this);
//StringUtil.printMsg("r_msg_cd", r_msg_cd, this);
//StringUtil.printMsg("r_msg", r_msg, this);
					if(r_s_yn.equals("N")){
						throw new Exception(r_msg);
					}
					
					if(ds_result!=null){
						GauceDataRow row1 = ds_result.newDataRow();
						row1.addColumnValue(r_s_yn);
						row1.addColumnValue(r_msg_cd);
						row1.addColumnValue(r_msg);
						
						ds_result.addDataRow(row1);
					}
					if(cstmt!=null) cstmt.close();
				}
				if(ds_result!=null)
					ds_result.flush();
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

}
