package common;

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

public class Am210I extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//��ȸ
		arr_sql[1].append("CALL SALES.PR_AM210I_01(?,?,?)");
		//����(������ ���� ������  �μ�Ʈ�մϴ�. ������)
		arr_sql[2].append("CALL SALES.PR_AM210I_02(?,?,?,?,?,     ?,?,?,?,?       ,?,?,? )");
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
		 String sItem_cd 	= HDUtil.nullCheckStr(req.getParameter("sItem_cd"));	// ������ȣ
		 String sItem_nm 	= HDUtil.nullCheckStr(req.getParameter("sItem_nm")); 	// ǰ��
		 String sModel_nm = HDUtil.nullCheckStr(req.getParameter("sModel_nm")); // �𵨸� 
		 //StringUtil.printMsg("������ȣ",sItem_cd,this);
		 //StringUtil.printMsg("ǰ�� ",sItem_nm,this);
		 //StringUtil.printMsg("�𵨸� ",sModel_nm,this);
		
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
						cstmt.setString(1, sItem_cd);
						cstmt.setString(2, sItem_nm);
						cstmt.setString(3, sModel_nm);
						
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
				
				int colNm_Item_cd                     	= ds1.indexOfColumn("ITEM_CD");
				int colNm_Item_nm            			= ds1.indexOfColumn("ITEM_NM");
				int colNm_Model_nm               		= ds1.indexOfColumn("MODEL_NM");				
				int colNm_Send_empno            		= ds1.indexOfColumn("send_empno");
				int colNm_Send_deptnm            	= ds1.indexOfColumn("send_deptnm");
				int colNm_Send_empnmk          		= ds1.indexOfColumn("send_empnmk");
				int colNm_Send_status_cd       		= ds1.indexOfColumn("send_status_cd");
				int colNm_Receive_empno             = ds1.indexOfColumn("receive_empno");
				int colNm_Receive_deptnm            = ds1.indexOfColumn("receive_deptnm");
				int colNm_Receive_empnmk          	= ds1.indexOfColumn("receive_empnmk");
				int colNm_Receive_status_cd       	= ds1.indexOfColumn("receive_status_cd");
				int colNm_Remarks				       	= ds1.indexOfColumn("REMARKS");
				
				for(int i = 0; i < rows.length; i++) {
					//������Ʈ�ุ ó���Ѵ�.
					//StringUtil.printMsg("job=", rows[i].getJobType(), this);
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						/*
						StringUtil.printMsg("1111111111","111111111111111",this);
						StringUtil.printMsg("rows[i].getString(colNm_Item_cd)",rows[i].getString(colNm_Item_cd),this);
						StringUtil.printMsg("rows[i].getString(colNm_Item_nm)",rows[i].getString(colNm_Item_nm),this);
						StringUtil.printMsg("rows[i].getString(colNm_Model_nm)",rows[i].getString(colNm_Model_nm),this);
						StringUtil.printMsg("rows[i].getString(colNm_Send_empno)",rows[i].getString(colNm_Send_empno),this);
						StringUtil.printMsg("rows[i].getString(colNm_Send_deptnm)",rows[i].getString(colNm_Send_deptnm),this);
						StringUtil.printMsg("rows[i].getString(colNm_Send_empnmk)",rows[i].getString(colNm_Send_empnmk),this);
						StringUtil.printMsg("rows[i].getString(colNm_Receive_empno)",rows[i].getString(colNm_Receive_empno),this);
						StringUtil.printMsg("rows[i].getString(colNm_Receive_deptnm)",rows[i].getString(colNm_Receive_deptnm),this);
						StringUtil.printMsg("rows[i].getString(colNm_Receive_empnmk)",rows[i].getString(colNm_Receive_empnmk),this);
						StringUtil.printMsg("rows[i].getString(colNm_Receive_status_cd)",rows[i].getString(colNm_Receive_status_cd),this);
						StringUtil.printMsg("rows[i].getString(colNm_Send_status_cd)",rows[i].getString(colNm_Send_status_cd),this);
						StringUtil.printMsg("rows[i].getString(colNm_Remarks)",rows[i].getString(colNm_Remarks),this);
						*/
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString     (1, rows[i].getString(colNm_Item_cd));//������ȣ 
						//StringUtil.printMsg("1", rows[i].getString(colNm_Item_cd), this);
						cstmt.setString     (2, rows[i].getString(colNm_Item_nm));//ǰ��
						//StringUtil.printMsg("2",rows[i].getString(colNm_Item_nm) , this);
						cstmt.setString     (3, rows[i].getString(colNm_Model_nm));//�� �� 
						//StringUtil.printMsg("3", rows[i].getString(colNm_Model_nm), this);
						cstmt.setString     (4, rows[i].getString(colNm_Send_empno));//�������� ���
						//StringUtil.printMsg("4",rows[i].getString(colNm_Send_empno) , this);
						cstmt.setString     (5, rows[i].getString(colNm_Send_deptnm));//�������� �μ� 
						//StringUtil.printMsg("5", rows[i].getString(colNm_Send_deptnm), this);
						cstmt.setString     (6, rows[i].getString(colNm_Send_empnmk));//�������� ����
						//StringUtil.printMsg("6",rows[i].getString(colNm_Send_empnmk) , this);
						cstmt.setString     (7, rows[i].getString(colNm_Send_status_cd));//�������� ������ ���� 
						//StringUtil.printMsg("7", rows[i].getString(colNm_Send_status_cd), this);
						cstmt.setString     (8, rows[i].getString(colNm_Receive_empno));//��������� ���
						//StringUtil.printMsg("8",rows[i].getString(colNm_Receive_empno) , this);
						cstmt.setString     (9, rows[i].getString(colNm_Receive_deptnm));//��������� �μ�
						//StringUtil.printMsg("9", rows[i].getString(colNm_Receive_deptnm), this);
						cstmt.setString     (10, rows[i].getString(colNm_Receive_empnmk));//��������� ����
						//StringUtil.printMsg("10",rows[i].getString(colNm_Receive_empnmk) , this);
						cstmt.setString     (11, rows[i].getString(colNm_Receive_status_cd));//��������� ������ ���� 
						//StringUtil.printMsg("11", rows[i].getString(colNm_Receive_status_cd), this);
						cstmt.setString     (12, rows[i].getString(colNm_Remarks));//���
						//StringUtil.printMsg("12",rows[i].getString(colNm_Remarks) , this);
						cstmt.setString     (13, fParamEmpno);							//�������
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
