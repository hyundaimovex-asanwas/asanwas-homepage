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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;


public class Ac630S_N extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC630S_01(?,?,?,?,?,?,?)");
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		ResultSet 			rs 			= null;
		String[] 			columnName 	= null;
		CallableStatement 	cstmt 		= null;
		PreparedStatement 	stmt 		= null;
		


		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// �����
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// ��ǰSID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// ����ó 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// �۾����
		String sAccept_no 	= HDUtil.nullCheckStr(req.getParameter("sAccept_no")); 	// ��û����ȣ
		int sSalDamSid 		= HDUtil.nullCheckNum(req.getParameter("sSalDamSid")); 	// ���������
		
		StringUtil.printMsg("�����",sSaup_sid+"",this);
		StringUtil.printMsg("����� S",sSDate,this);
		StringUtil.printMsg("��û��",sAccept_no,this);
		StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		StringUtil.printMsg("����ó",sClientSid+"",this);
		StringUtil.printMsg("���������",sSalDamSid+"",this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, sSaup_sid);
					cstmt.setInt(2, sGoods_sid);
					cstmt.setInt(3, sClientSid);
					cstmt.setString(4, sSDate);
					cstmt.setString(5, sAccept_no);
					cstmt.setString(6, fParamEmpno);
					cstmt.setInt(7, sSalDamSid);
					rs = cstmt.executeQuery();							
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

	}

}
