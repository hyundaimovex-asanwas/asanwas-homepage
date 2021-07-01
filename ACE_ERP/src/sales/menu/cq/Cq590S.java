package sales.menu.cq;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Cq590S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ590S_01(?,?,?,?)"); // ����
		
		
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
		CallableStatement 	cstmt 		= null;
		
		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// �����
		int sGood_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoodSid")); 	// ��ǰ 
		String sDepatrDate 	= HDUtil.nullCheckStr(req.getParameter("sDepartDate")); 	// �������
		String sDepartTime	= HDUtil.nullCheckStr(req.getParameter("sDepartTime")); // ���ð�
		StringUtil.printMsg("=============================== ��ȸ PARAM =========================",this);
		StringUtil.printMsg("�����", sSaup_sid,this);
		StringUtil.printMsg("��ǰ",sGood_sid ,this);
		StringUtil.printMsg("�������",sDepatrDate ,this);
		StringUtil.printMsg("���ð�", sDepartTime,this);
		
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setInt(1, sSaup_sid);
							cstmt.setInt(2, sGood_sid);
							cstmt.setString(3, sDepatrDate);
							cstmt.setString(4, sDepartTime);
							rs = cstmt.executeQuery();		
							getDataSet(rs, ds1).flush();
							break;
						case 2:
							break;
						case 3:
							break;
					}
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
			if(cstmt!=null) cstmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}
}
