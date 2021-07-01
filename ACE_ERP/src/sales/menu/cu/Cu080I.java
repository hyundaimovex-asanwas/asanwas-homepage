package sales.menu.cu;


import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.CallableStatement;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
//import sun.nio.cs.ext.SJIS;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Cu080I extends SuperServlet {

    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * ������ȸ
		 * //����ó SID,�ѱۼ���,�ֹ�/���ǹ�ȣ, ��������, ��ϸ����ڵ�, ����� SID, ����� ���ι�ȣ, ��ϱ�����û��ȣ   
		 */
		arr_sql[0].append("{call SALES.PR_CU080I_01( ?, ?, ?, ?, ?,   ?, ?, ? ) }");	 
		 
		arr_sql[1].append("{call SALES.PR_CU080I_02( ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?) }");
		
    }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	}	
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//StringUtil.printMsg("# Command : ��ȸ","", this);

		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		// �˻��� ����
		int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// �ŷ�ó ���̵�
		String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// ���� 
		String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// �ֹ�/���ǹ�ȣ
		String sEducPlanDt	= HDUtil.nullCheckStr(req.getParameter("sEducPlanDt"));	// ��������
		String sVisitObjCd	= HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));// ��ϸ����ڵ�
		int	   sSaupSid 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));	// ����� SID
		String sEducNo    	= HDUtil.nullCheckStr(req.getParameter("sEducNo"));	// ����� ���ι�ȣ
		String sEducReqNo   = HDUtil.nullCheckStr(req.getParameter("sEducReqNo"));		// ��ϱ�����û��ȣ
		//String sNcardNo    	= HDUtil.nullCheckStr(req.getParameter("sNcardNo"));	// �˻�����: �������ȣ
		//String 	sNJobGu = HDUtil.nullCheckStr(req.getParameter("sNJobGu"));

		try {
/*			//StringUtil.printMsg("����۾�����", sNJobGu, this);
			//StringUtil.printMsg("�����SID", sNJobGu, this);
			//StringUtil.printMsg("������������", sNJobGu, this);
			//StringUtil.printMsg("����", sNJobGu, this);
			//StringUtil.printMsg("������ȣ", sNJobGu, this);*/
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

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
						cstmt.setInt   (1, sClientSid);		//IN 
						cstmt.setString(2, sCustNm);		//IN
						cstmt.setString(3, sManageNo);		//IN
						cstmt.setString(4, sEducPlanDt);		//IN
						cstmt.setString(5, sVisitObjCd);		//IN
						cstmt.setInt   (6, sSaupSid);		//IN 
						cstmt.setString(7, sEducNo);		//IN
						cstmt.setString(8, sEducReqNo);		//IN						
						
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
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  
		throws ServletException, Exception {
		
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 		= null;
		ResultSet 			rs 			= null;

		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1		= req.getGauceDataSet("DS1");	
		GauceDataSet ds_result	= req.getGauceDataSet("RESULT");
		
		/*
		 * ��������
		 */
		int fVCnt = 0; //��� ��û ���� Ȯ�ο� ī��Ʈ ���� 
		
		try{
			//���� ����
			String v_edit_styatus = "";	//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
			String r_s_yn		= "";	//Return Status Yn
			String r_msg_cd		= "";	//Return Message Code
			String r_msg		= ""; 	//Return message
						
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				// DS �÷� ����
				int colNm_EDUC_CARD_SID	     = ds1.indexOfColumn("EDUC_CARD_SID");    // 01.���� �� ��û sid 
				int colNm_CUST_SID		     = ds1.indexOfColumn("CUST_SID");         // 02.�� sid         
				int colNm_EDUC_REQ_NO        = ds1.indexOfColumn("EDUC_REQ_NO");      // 03.��ϱ�����û��ȣ 
				int colNm_N_EDUC_YN		     = ds1.indexOfColumn("N_EDUC_YN");        // 04.��������         
				int colNm_EDUC_NO		     = ds1.indexOfColumn("EDUC_NO");          // 05.��û���ι�ȣ     
				int colNm_N_CARD_YN		     = ds1.indexOfColumn("N_CARD_YN");        // 06.�߱޻���         
				int colNm_N_CARD_NO		     = ds1.indexOfColumn("N_CARD_NO");        // 07.������ȣ       
				int colNm_VISIT_OBJECT_CD    = ds1.indexOfColumn("VISIT_OBJECT_CD");  // 08.��������CU016    
				int colNm_VISIT_OBJECT	     = ds1.indexOfColumn("VISIT_OBJECT");     // 09.��ϸ���         
				int colNm_VISIT_FR_DT	     = ds1.indexOfColumn("VISIT_FR_DT");      // 10. �湮�Ⱓ[������]
				int colNm_VISIT_TO_DT	     = ds1.indexOfColumn("VISIT_TO_DT");      // 11. �湮�Ⱓ[������]
				int colNm_CREDIT_FR_DT	     = ds1.indexOfColumn("CREDIT_FR_DT");     // 12. ��ȿ�Ⱓ[������]
				int colNm_CREDIT_TO_DT	     = ds1.indexOfColumn("CREDIT_TO_DT");     // 13. ��ȿ�Ⱓ[������]
				
				for(int i = 0; i < rows.length; i++) {

					switch(rows[i].getJobType()){
				
						case GauceDataRow.TB_JOB_INSERT:
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							/*
							 * [��Ͻ�û ���� ����] ��ϱ������� �ڵ尡 9�̸� 
							 */

							cstmt = conn.prepareCall(arr_sql[1].toString()); //PR_CU080I_02
							cstmt.setInt        (1, rows[i].getInt(colNm_EDUC_CARD_SID));     // 01.���� �� ��û sid 
							cstmt.setInt        (2, rows[i].getInt(colNm_CUST_SID));	        // 02.�� sid         
							cstmt.setString     (3, rows[i].getString(colNm_EDUC_REQ_NO));// 03.��ϱ�����û��ȣ 
							cstmt.setString     (4, rows[i].getString(colNm_N_EDUC_YN));// 04.��������         
							cstmt.setString     (5, rows[i].getString(colNm_EDUC_NO));// 05.��û���ι�ȣ     
							cstmt.setString     (6, rows[i].getString(colNm_N_CARD_YN));// 06.�߱޻���         
							cstmt.setString     (7, rows[i].getString(colNm_N_CARD_NO));// 07.������ȣ       
							cstmt.setString     (8, rows[i].getString(colNm_VISIT_OBJECT_CD));// 08.��������CU016    
							cstmt.setString     (9, rows[i].getString(colNm_VISIT_OBJECT));// 09.��ϸ���         
							cstmt.setString     (10,rows[i].getString(colNm_VISIT_FR_DT));// 10. �湮�Ⱓ[������]
							cstmt.setString     (11,rows[i].getString(colNm_VISIT_TO_DT));// 11. �湮�Ⱓ[������]
							cstmt.setString     (12,rows[i].getString(colNm_CREDIT_FR_DT));// 12. ��ȿ�Ⱓ[������]
							cstmt.setString     (13,rows[i].getString(colNm_CREDIT_TO_DT));// 13. ��ȿ�Ⱓ[������]
							cstmt.setString     (14, fParamEmpno);							//�������
							cstmt.setString     (15, fParamIp);								//����ip
							cstmt.setString     (16, "3");						//��������
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
		
							cstmt.executeUpdate();
		
							r_s_yn 		= cstmt.getString(17);
							r_msg_cd 	= cstmt.getString(18);
							r_msg 		= cstmt.getString(19);
							
							if(!r_s_yn.equals("Y")){
								throw new Exception (r_msg);
							}
						
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
							
								ds_result.addDataRow(row1);
							}

							
							break;
						case GauceDataRow.TB_JOB_DELETE:
							break;
					}
				
				}
			} 

		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

}
