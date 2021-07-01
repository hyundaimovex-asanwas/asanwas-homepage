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

public class Ac060S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC060S_01(?, ?, ?, ?, ?, ?, ?, ?)");
		
		arr_sql[2].append("CALL SALES.PR_AC060S_02(?, ?, ?, ?, ?, ?, ?, ?)");
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
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));		// �����
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));		// ��ǰSID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));		// ����ó 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 			// �Ա����� ����
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 			// �Ա����� ���� 
		String sPay_cd		= HDUtil.nullCheckStr(req.getParameter("sPay_cd")); 		// �Ա�����
		
		String sPayDate 	= HDUtil.nullCheckStr(req.getParameter("sPayDate")); 		// �Ա���
		String sPayCd 		= HDUtil.nullCheckStr(req.getParameter("sPayCd")); 			// �Աݱ���
		
		String v_out_gubn	= HDUtil.nullCheckStr(req.getParameter("v_out_gubn"));// ��汸��
		
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); // ������ 
		
		
		try {
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
						cstmt.setString(6, sPay_cd);
						cstmt.setString(7, v_out_gubn);
						cstmt.setString(8, sCustGu);
						
						rs = cstmt.executeQuery();	
						
						getDataSet(rs, ds1).flush();
					
					} 
					
					if ("DS2".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
						cstmt.setString(6, sPay_cd);
						cstmt.setString(7, v_out_gubn);
						cstmt.setString(8, sCustGu);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					} 
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
