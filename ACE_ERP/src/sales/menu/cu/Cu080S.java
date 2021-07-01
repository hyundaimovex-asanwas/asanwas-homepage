package sales.menu.cu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;


public class Cu080S extends SuperServlet {

    public void makeSql(){
//		for(int i=0; i<arr_sql.length; i++)
//			arr_sql[i] = new StringBuffer();
   	
		//SELECT DATA
		arr_sql[0].append("{call SALES.PR_CU080S_01(?, ?, ?, ?, ? ) }");	//����ó SID,�ѱۼ���,�ֹ�/���ǹ�ȣ,����� ���ι�ȣ 

		//UPDATE DATA
//		arr_sql[1].append("{call SALES.PR_RV201S_02 (? ) }");
    	
    }
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}	
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//System.out.println("# Command : ��ȸ");

		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		CallableStatement cstmt = null;		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		/*
		 * �˻��� �ʿ��� ����
		 */
		int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// �˻�����: �ŷ�ó ���̵� 
		String sEducNo    	= HDUtil.nullCheckStr(req.getParameter("sEducNo"));		// �˻�����: ����� ���ι�ȣ
		String sNcardNo    	= HDUtil.nullCheckStr(req.getParameter("sNcardNo"));	// �˻�����: �������ȣ
		String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// �˻�����: ����
		String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// �˻�����: �ֹ�/���ǹ�ȣ

		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				//StringUtil.printMsg("���콺�� - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//��ȸ����
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, sClientSid);		//IN 
						cstmt.setString(2, sCustNm);		//IN
						cstmt.setString(3, sManageNo);		//IN
						cstmt.setString(4, sEducNo);		//IN
						cstmt.setString(5, sNcardNo);		//IN
						
						
						rs = cstmt.executeQuery();
						
						//��������
						//cstmt = conn.prepareCall(arr_sql[1].toString());
						//cstmt.setString(1, s_manage_no);

						//cstmt.executeUpdate();						
					}
					getDataSet(rs, ds1).flush();

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
		}
	}

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}

}
