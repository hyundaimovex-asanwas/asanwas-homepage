package sales.menu.cu;

import java.sql.CallableStatement;
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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;


public class Cu071S extends SuperServlet {

	
	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		// ��ȸ
		arr_sql[0].append ("{call SALES.PR_CU071S_01(?, ?, ?, ? )}");
		//	IN  pEDUC_PLAN_DT		 VARCHAR(8)     -- 01.��������
		// ,IN  pSAUP_SID  			 NUMERIC(2)     -- 02.����� SID
		// ,IN  pVISIT_OBJECT_CD	 VARCHAR(2)	    -- 03.��ϸ����ڵ�
		// ,IN 	pN_JOB_GU		 	 VARCHAR(1)	 	-- 04.�ںϽ�û�۾����� CU015 (����/�߰�/��/����)
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}
    
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		
		//StringUtil.printMsg("DS TYPE","�� ��ȸ",this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement 	cstmt 	= null;
		ResultSet rs = null;
		String[] columnName = null;

		try {
			// �˻��� ����
			String  sReqDt 	= HDUtil.nullCheckStr(req.getParameter("sReqDt"));
			int 	sSaupSid	 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
			String  sVisitObjCd  = HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));
			String  sNJobGu			= HDUtil.nullCheckStr(req.getParameter("sNJobGu"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							cstmt = conn.prepareCall(arr_sql[0].toString());
							//StringUtil.printMsg("query",arr_sql[0].toString(),this);
							cstmt.setString(1, sReqDt);		
							cstmt.setInt   (2, sSaupSid);
							cstmt.setString(3, sVisitObjCd);
							cstmt.setString(4, sNJobGu);		
							rs = cstmt.executeQuery();		// Query ����
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
			if(cstmt!=null) cstmt.close();
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
