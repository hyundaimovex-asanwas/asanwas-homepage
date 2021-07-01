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

public class Ac020S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC020S_01(?,?,?,?,?,?,?,?)");
	
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
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// �����
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// ��ǰSID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// ����ó 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// �������
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 	// ���ð� 
		//String sUpjangSid 	=  HDUtil.nullCheckStr(req.getParameter("sUpjangSid")); // ������
		String v_status			= HDUtil.nullCheckStr(req.getParameter("v_status")); 			// �������
		String sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu")); // �������� 
		int sSalDamSid    = HDUtil.nullCheckNum(req.getParameter("sSalDamSid"));//���������
		
		/*
		StringUtil.printMsg("�����",sSaup_sid+"",this);
		StringUtil.printMsg("����� S",sSDate,this);
		StringUtil.printMsg("����� E",sEDate,this);
		StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		StringUtil.printMsg("����ó",sClientSid+"",this);
		StringUtil.printMsg("��ǰSID",sGoods_sid+"",this);
		StringUtil.printMsg("����ó",sClientSid+"",this);
		*/		
		
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
						
						cstmt.setString(6, v_status);
						cstmt.setString(7, sCustGu);
						cstmt.setInt(8, sSalDamSid);
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

	}

}