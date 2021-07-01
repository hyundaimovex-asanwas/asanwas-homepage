package sales.menu.rv;

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

public class Rv340I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//��ȸ
		arr_sql[1].append("CALL SALES.PR_RV340I_01(?,?,?,?,?,?,?)");
		//����(��ü�ݾ��� �μ�Ʈ�մϴ�. ������)
		arr_sql[2].append("CALL SALES.PR_RV340I_02(?,?,?,?,?,?,? )");
	
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
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
		 
		
		
		
		//StringUtil.printMsg("�����",sSaup_sid+"",this);
		//StringUtil.printMsg("����� S",sSDate,this);
		//StringUtil.printMsg("����� E",sEDate,this);
		//StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		//StringUtil.printMsg("����ó",sClientSid+"",this);
		//StringUtil.printMsg("��汸��",v_out_gubn+"",this);
		//StringUtil.printMsg("������",sCustGu+"",this);
		
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
				
				int colNm_Rsv_sid                       = ds1.indexOfColumn("RSV_SID");
				int colNm_PayManageNo            = ds1.indexOfColumn("PAY_MANAGE_NO");
				int colNm_SaleAmt                		= ds1.indexOfColumn("SALE_AMT_TEMP");				
				
				int colNm_D_RSV_SID               	= ds1.indexOfColumn("D_RSV_SID");
				int colNm_D_PAY_AMT           		= ds1.indexOfColumn("D_PAY_AMT");
				
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
						cstmt.setString     (4, fParamEmpno);							//�������
						cstmt.setString     (5, fParamIp);								//����ip
						cstmt.setInt        (6, rows[i].getInt(colNm_D_RSV_SID));		//�޴»�� ����SID
						//StringUtil.printMsg("6",rows[i].getInt(colNm_D_RSV_SID) , this);
						cstmt.setInt        (7, rows[i].getInt(colNm_D_PAY_AMT));		// ��ü �� �ݾ�
						//StringUtil.printMsg("7",rows[i].getInt(colNm_D_PAY_AMT) , this);
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
