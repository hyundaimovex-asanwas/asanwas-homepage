package sales.menu.ac;

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

public class Ac130I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//��ȸ
		arr_sql[1].append("CALL SALES.PR_AC130I_01(?,?,?,?,?, ?,?,?,?)");
		//����(����� �μ�Ʈ�մϴ�. ������)
		arr_sql[2].append("CALL SALES.PR_AC130I_02(?,?,?,?,?, ? )");
	
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
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
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 1 �����
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));	// 2 ��ǰSID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 3 ����ó 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 		// 4 ������� ����
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 		// 5 ������� �� 
		String v_out_gubn	= HDUtil.nullCheckStr(req.getParameter("v_out_gubn"));	// 6 ��汸��
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); 	// 7 ������ 
		String sPayDate 	= HDUtil.nullCheckStr(req.getParameter("sPayDate")); 	// 8 ���� ��������
		String v_wrk_gubn	= HDUtil.nullCheckStr(req.getParameter("v_wrk_gubn"));	// 9 �۾����� (1:����, 2:�ܻ����) 
		
		
		
		//StringUtil.printMsg("�����",sSaup_sid+"",this);
		//StringUtil.printMsg("����� S",sSDate,this);
		//StringUtil.printMsg("����� E",sEDate,this);
		//StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		//StringUtil.printMsg("����ó",sClientSid+"",this);
		//StringUtil.printMsg("��汸��",v_out_gubn+"",this);
		//StringUtil.printMsg("������",sCustGu+"",this);
		//StringUtil.printMsg("���� ��������",sPayDate+"",this);
		//StringUtil.printMsg("�۾�����",v_wrk_gubn+"",this);
		
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
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setString(6, v_out_gubn);
						cstmt.setString(7, sCustGu);
						cstmt.setString(8, sPayDate);
						cstmt.setString(9, v_wrk_gubn);
						
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

		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;
		//StringUtil.printMsg("�Է�",this);
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DS1");	

		try{
			//���� ����
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_Rsv_sid               = ds1.indexOfColumn("RSV_SID");
				int colNm_PayManageNo           = ds1.indexOfColumn("PAY_MANAGE_NO");
				int colNm_SaleAmt               = ds1.indexOfColumn("SALE_AMT_TEMP");				
				int colNm_AgencyAmt				= ds1.indexOfColumn("AGENCY_AMT");
				for(int i = 0; i < rows.length; i++) {
					//������Ʈ�ุ ó���Ѵ�.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt        (1, rows[i].getInt(colNm_Rsv_sid));		//����SID 
						//StringUtil.printMsg("1", rows[i].getInt(colNm_Rsv_sid), this);
						cstmt.setString     (2, rows[i].getString(colNm_PayManageNo));//����������ȣ
						//StringUtil.printMsg("2",rows[i].getString(colNm_PayManageNo) , this);
						cstmt.setInt     	(3, rows[i].getInt(colNm_SaleAmt));			//���꿹����
						//StringUtil.printMsg("3",rows[i].getInt(colNm_SaleAmt) , this);
						cstmt.setInt     	(4, rows[i].getInt(colNm_AgencyAmt));			//���꿹����
						cstmt.setString     (5, fParamEmpno);							//�������
						cstmt.setString     (6, fParamIp);								//����ip
					
						cstmt.executeUpdate();
					} //if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
				};//for(int i=0; i<row.length; i++){
	
			}; //if
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		};//try{	






	}

}
