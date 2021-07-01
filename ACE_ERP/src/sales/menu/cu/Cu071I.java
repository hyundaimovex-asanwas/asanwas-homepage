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

public class Cu071I extends SuperServlet {

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		/*
		 * ������ȸ
		 * //����ó SID, �ѱۼ���, �ֹ�/���ǹ�ȣ, ��������, ��ϸ����ڵ�, ����� SID   
		 */
		arr_sql[0].append("{call SALES.PR_CU071I_01( ?, ?, ?, ? ) }");	 
		// ��û ����
		arr_sql[1].append("{call SALES.PR_CU071I_02( ?,?,?,?,?,     ?,?,?,?,?,    ?,?,?,?,?) }");
		  
		arr_sql[2].append (" SELECT										\n")
		  .append ("    CASE WHEN t2.n_educ_yn = '2' THEN 'T' ELSE 'F' END job_sel, \n")
		  .append ("	t1.cust_sid cust_sid,                   \n")
		  .append ("	t1.cust_nm cust_nm,                     \n")				  
		  .append ("	t1.manage_no manage_no,                 \n")				  
		  .append ("	t1.educ_yn educ_yn,                     \n")				  
		  .append ("	CASE WHEN t1.educ_yn = '9' THEN '�̼�' ELSE '�̱���' END educ_yn_nm, \n")				  
		  .append ("	sales.fn_saup_nm(t1.educ_saup_sid,'') educ_saup_nm, \n")				  
		  .append ("	t1.educ_dt educ_dt,                     \n")			  
		  .append ("	t2.educ_plan_dt educ_plan_dt,           \n")				  
		  .append ("	t2.saup_sid saup_sid,                   \n")			  
		  .append ("	sales.fn_saup_nm(t2.saup_sid,'') saup_nm, \n")
		  .append ("	t2.visit_object visit_object,           \n")				  
		  .append ("    t2.req_dt req_dt,                        \n")
		  .append ("    t2.n_educ_yn n_educ_yn,                 \n")
		  .append ("	t2.n_card_no n_card_no,                 \n")				  
		  .append ("	t2.educ_no educ_no,                     \n")			  				  
		  .append ("	t2.visit_fr_dt visit_fr_dt,             \n")				  
		  .append ("	t2.visit_to_dt visit_to_dt,             \n")			  
		  .append ("	t2.credit_fr_dt credit_fr_dt,           \n")				  
		  .append ("	t2.credit_to_dt credit_to_dt            \n")
		  .append (" FROM sales.tcu010 t1 LEFT OUTER JOIN       \n")
		  .append ("      sales.tcu110 t2                       \n")
		  .append (" ON t1.cust_sid = t2.cust_sid               \n")
		  .append (" AND t2.n_job_gu = '3'                      \n")
		  .append (" AND t2.req_dt BETWEEN ? AND ?              \n")
		  .append (" LEFT OUTER JOIN sales.tsy200 t3            \n")
		  .append (" ON t1.educ_saup_sid = t3.saup_sid          \n")
		  .append (" WHERE 1 = 1                                \n")
		   .append(" AND T1.CUST_GU='2'							\n")
		  .append (" AND t1.educ_yn '9'                 \n");

		arr_sql[3].append (" SELECT										\n")
		  .append ("	t1.client_dam_nm,                       \n")
		  .append ("    t1.tel_no,                              \n")
		  .append ("    t1.mobile_no,                           \n")
		  .append ("    t1.sal_dam_sid,                         \n")
		  .append ("    t2.sal_dam_cd,                          \n")
		  .append ("    t2.sal_dam_nm                           \n")
		  .append ("	FROM sales.tcu030 t1 LEFT JOIN sales.tsy410 t2 \n")
		  .append ("    ON t1.sal_dam_sid=t2.sal_dam_sid        \n")
		  .append ("    WHERE t1.use_yn = 'Y'                   \n")
		  .append ("    AND t1.client_sid = ?                   \n");
		
		arr_sql[4].append("SELECT COUNT(*) FROM SALES.TCU110 WHERE EDUD_REQ_NO = ?");
		
		/*
		 * ��Ͻ�û ���� ����
		 * ����۾�����(N_JOB_GU) : 1 ���� �� �����
		 * arr_sql[4]���� ��ϱ��������� 2�̰� count �� 0�ΰ��
		 */
		arr_sql[5].append("")
				.append("INSERT INTO SALES.TCU110	\n")	                                   
				.append("(                        	\n")                               
				.append("   N_EDUC_YN             	\n") /* ��ϱ�������:CU014     	*/  
				.append("  ,N_JOB_GU              	\n") /* ����۾�����:CU015     	*/  
				.append("  ,REQ_DT                	\n") /* ��û��                 		*/  
				.append("  ,CLIENT_SID            	\n") /* ����óSID              	*/  
				.append("  ,SAL_DAM_SID           	\n") /* ����������ڵ�[TSY410] 	*/  
				
				.append("  ,CLIENT_DAM_NM         	\n") /* ����ó�����           		*/  
				.append("  ,TEL_NO                	\n") /* ��ȭ��ȣ               		*/  
				.append("  ,MOBILE_NO             	\n") /* �ڵ�����ȣ             		*/  
				.append("  ,EDUC_PLAN_DT          	\n") /* ����������             		*/  
				.append("  ,SAUP_SID              	\n") /* �����SID              	*/  
				
				.append("  ,VISIT_OBJECT          	\n") /* �湮����               		*/  
				.append("  ,CUST_SID              	\n") /* ��SID                	*/  
				.append("  ,N_CARD_NO             	\n") /* �������ȣ             		*/  
				.append("  ,EDUC_NO               	\n") /* ��û���ι�ȣ           		*/  
				.append("  ,VISIT_FR_DT           	\n") /* �湮�Ⱓ[������]       	*/  
				
				.append("  ,VISIT_TO_DT           	\n") /* �湮�Ⱓ[������]       	*/  
				.append("  ,CREDIT_FR_DT          	\n") /* ��ȿ�Ⱓ[������]       	*/  
				.append("  ,CREDIT_TO_DT          	\n") /* ��ȿ�Ⱓ[������]       	*/  
				.append("  ,U_EMPNO               	\n") /* ���������ڻ��         		*/  
				.append("  ,U_DATE                	\n") /* ������������           		*/  
				
				.append("  ,U_IP                  	\n") /* ��������IP             	*/  
				.append(")                        	\n")                               
				.append("VALUES                   	\n")                               
				.append("(                        	\n")                               
				.append("   ?,?,?,?,?,             	\n")   
				.append("   ?,?,?,?,?,             	\n")   
				.append("   ?,?,?,?,?,             	\n")   
				.append("   ?,?,?,?,CURRENT TIMESTAMP, 	\n")
				.append("   ?  	\n")   
				.append(")                       	\n");                               

		/*
		 * ��Ͻ�û ���� ����
		 * ����۾�����(N_JOB_GU) : 1 ���� �� �����
		 * arr_sql[4]���� ��� ���������� 2�̰� count �� 1 �ΰ��
		 */
		arr_sql[6].append("UPDATE SALES.TCU110        \n")	                                                       																																																																								
				.append("SET                        \n")	                                                    																																																																								
				.append("    N_EDUC_YN        = ?	\n")	/* ��ϱ�������:CU014    	*/              																																																																								
				.append("   ,N_JOB_GU         = ?	\n")	/* ����۾�����:CU015    	*/             																																																																								
				.append("   ,REQ_DT           = ?	\n")	/* ��û��                 	*/           																																																																								
				.append("   ,CLIENT_SID       = ?	\n")	/* ����óSID            	*/               																																																																								
				.append("   ,SAL_DAM_SID      = ?	\n")	/* ����������ڵ�[TSY410] */                																																																																								
				.append("   ,CLIENT_DAM_NM    = ?	\n")	/* ����ó�����           	*/                  																																																																								
				.append("   ,TEL_NO           = ?	\n")	/* ��ȭ��ȣ               	*/            																																																																								
				.append("   ,MOBILE_NO        = ?	\n")	/* �ڵ�����ȣ             	*/              																																																																								
				.append("   ,EDUC_PLAN_DT     = ?	\n")	/* ����������             	*/                 																																																																								
				.append("   ,SAUP_SID         = ?	\n")	/* �����SID          	*/             																																																																								
				.append("   ,VISIT_OBJECT     = ?	\n")	/* �湮����               	*/                 																																																																								
				.append("   ,CUST_SID         = ?	\n")	/* ��SID              	*/             																																																																								
				.append("   ,N_CARD_NO        = ?	\n")	/* �������ȣ             	*/              																																																																								
				.append("   ,EDUC_NO          = ?	\n")	/* ��û���ι�ȣ           	*/            																																																																								
				.append("   ,VISIT_FR_DT      = ?	\n")	/* �湮�Ⱓ[������]       */                																																																																								
				.append("   ,VISIT_TO_DT      = ?	\n")	/* �湮�Ⱓ[������]       */                																																																																								
				.append("   ,CREDIT_FR_DT     = ?	\n")	/* ��ȿ�Ⱓ[������]       */                 																																																																								
				.append("   ,CREDIT_TO_DT     = ?	\n")	/* ��ȿ�Ⱓ[������]       */                 																																																																								
				.append("   ,U_EMPNO          = ?	\n")	/* ���������ڻ��         	*/            																																																																								
				.append("   ,U_DATE           = CURRENT TIMESTAMP	\n")	/* ������������           	*/           																																																																								
				.append("   ,U_IP             = ?	\n")	/* ��������IP            */         																																																																								
				.append("WHERE EDUD_REQ_NO = ?		\n");
		
		
		/*
		 * ��Ͻ�û ���� ����
		 * ����۾�����(N_JOB_GU) : 1 ���� �� �����
		 * arr_sql[4]���� ��� ���������� 1�̰� count �� 1 �ΰ��
		 */
		arr_sql[7].append(" DELETE FROM SALES.TCU110 WHERE EDUD_REQ_NO = ?");

		/*
		 * ���������� 
		 * ����۾������� ������ �����(1)�̰� �湬���������� ������(2)�̸� 
		 */
		
		arr_sql[8].append("")
				.append("UPDATE SALES.TCU010 T1                     \n")                                       
				.append("  SET                                      \n")                                       
				.append("      T1.EDUC_YN       = 2       			\n")	/* ��ϱ������� :������ '2'�� ���� 	*/  
				.append("WHERE 1 = 1                                \n")                                       
				.append("  AND T1.CUST_SID IN (SELECT CUST_SID      \n")                                       
				.append("                        FROM SALES.TCU110  \n")                                       
				.append("                    GROUP BY CUST_SID)     \n")                                       
				.append("  AND T1.CUST_SID = ?						\n");                                      

		/*
		 * ���������� 
		 * ����۾������� ������ �����(1)�̰� �湬���������� �̱���(1)�̸� 
		 */
		arr_sql[9].append("")
				.append("UPDATE SALES.TCU010 T1      				\n")                                      																																																																															
				.append("  SET                                		\n")                                     																																																																															
				.append("      T1.EDUC_YN       = 1      	 		\n")	/* ��ϱ������� :������ '1'�� ���� 	*/																																																																															
				.append("WHERE 1 = 1                                \n")                                     																																																																															
				.append("  AND T1.CUST_SID IN (SELECT CUST_SID      \n")                                     																																																																															
				.append("                        FROM SALES.TCU110  \n")                                     																																																																															
				.append("                    GROUP BY CUST_SID)     \n")                                     																																																																															
				.append("  AND T1.CUST_SID = ?                     \n");       
		


		// ��ϱ������� EDUD_PLAN_DT view���� ��ȸ�մϴ�. �̰� �����!!!!!	2008-02-28
		arr_sql[10].append("SELECT TT.CALN_DATE, TT.TITLE_NM									\n")
				   .append("FROM SALES.VTSY100 TT																						\n")
				   .append("		ORDER BY TT.CALN_DATE  FETCH  FIRST  6 ROW ONLY														\n");

	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		GauceDataSet 		ds1 		= null;
		GauceStatement 		stmt 	= null;
		ResultSet 			rs			= null;
//		ResultSetMetaData 	rsmd 		= null;
//		String[] 			columnName 	= null;
		
//		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while(it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				int codeCnt = 1;
				if (ds1 != null) {
					switch(dsType) {
					case 1:
						res.enableFirstRow(ds1);
						// � �ڵ带 ������ �ð��ΰ��� �����Ѵ� 
						if ("EDUC_PLAN_DT".equals(gauceName)) { 					// ��� �������� 
							stmt = conn.getGauceStatement(arr_sql[10].toString());
						} 
						
						rs = stmt.executeQuery();		// Query ����
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
			if(stmt!=null) stmt.close();
		}
	}	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//System.out.println("# Command : ��ȸ");

		/* DataBase */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;

		try {
			// �˻��� ����
			int	   sClientSid  	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));	// �ŷ�ó ���̵�
			String sCustNm    	= HDUtil.nullCheckStr(req.getParameter("sCustNm"));		// ���� 
			String sManageNo 	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));	// �ֹ�/���ǹ�ȣ
			String sVisitObjCd	= HDUtil.nullCheckStr(req.getParameter("sVisitObjCd"));// ��ϸ����ڵ�
			//int	   sSaupSid 	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));	// ����� SID
			//String sEducPlanDt	= HDUtil.nullCheckStr(req.getParameter("sEducPlanDt"));	// ��������
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("���콺�� - ", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DEFAULT".equals(gauceName)) {
						//��ȸ����
						cstmt = conn.prepareCall(arr_sql[0].toString()); //PR_CU080I_01
						cstmt.setInt   (1, sClientSid);		//IN ����ó SID
						cstmt.setString(2, sCustNm);		//IN �ѱۼ���
						cstmt.setString(3, sManageNo);		//IN �ֹ�/���ǹ�ȣ
						cstmt.setString(4, sVisitObjCd);	//IN ��ϸ����ڵ�
						//cstmt.setString(4, sEducPlanDt);	//IN ��������
						//cstmt.setInt   (6, sSaupSid);		//IN ����� SID
						
						rs = cstmt.executeQuery();
						
						//��������
						//cstmt = conn.prepareCall(arr_sql[1].toString());
						//cstmt.setString(1, s_manage_no);
						//cstmt.executeUpdate();					
						//StringUtil.printMsg("what? ", gauceName, this);
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
		GauceDataSet ds_result	= req.getGauceDataSet("RESULT");

		try{
			//���� ����
			String v_edit_styatus = "";	//IN ��������     1: INSERT, 2: DELETE, 3: UPDATE
			String r_s_yn		= "";	//Return Status Yn
			String r_msg_cd		= "";	//Return Message Code
			String r_msg		= ""; 	//Return message
			String sClientSid		= HDUtil.nullCheckStr(req.getParameter("sClientSid")); 		// ����ó SID
			
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_ClientSid             = ds1.indexOfColumn("CLIENT_SID");
				int colNm_EducCardSid           = ds1.indexOfColumn("EDUC_CARD_SID");
				int colNm_VisitObjectCd         = ds1.indexOfColumn("VISIT_OBJECT_CD");				
				int colNm_EducPlanDt            = ds1.indexOfColumn("EDUC_PLAN_DT");
				int colNm_ReqDt                 = ds1.indexOfColumn("REQ_DT");
				int colNm_Remarks				= ds1.indexOfColumn("REMARKS");
				int colNm_CustSid               = ds1.indexOfColumn("CUST_SID");
				int colNm_NEduc_yn              = ds1.indexOfColumn("N_EDUC_YN");	
				int colNm_NJobGu                = ds1.indexOfColumn("N_JOB_GU");
				int colNm_VisitObject           = ds1.indexOfColumn("VISIT_OBJECT");
				int colNm_SaupSid				= ds1.indexOfColumn("SAUP_SID");
				
				
				for(int i = 0; i < rows.length; i++) {
					if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT){
						v_edit_styatus = "1";
					} else if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE) {
						v_edit_styatus = "2";
					} if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE) {
						v_edit_styatus = "3";
					}

					//StringUtil.printMsg("��Ÿ�� ", v_edit_styatus, this);					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt        (1, rows[i].getInt(colNm_ClientSid));		//����óSID
					//StringUtil.printMsg("1", rows[i].getInt(colNm_ClientSid), this);
					cstmt.setInt        (2, rows[i].getInt(colNm_EducCardSid));		//���� �� ��û sid
					//StringUtil.printMsg("2", rows[i].getInt(colNm_EducCardSid) , this);
					cstmt.setString     (3, rows[i].getString(colNm_VisitObjectCd));//�����ڵ� CU016
					//StringUtil.printMsg("3",rows[i].getString(colNm_VisitObjectCd) , this);
					//StringUtil.printMsg("4",rows[i].getString(colNm_EducPlanDt) , this);
					//StringUtil.printMsg("4-1",rows[i].getString(colNm_EducPlanDt).substring(0,8) , this);
					//cstmt.setString     (4, rows[i].getString(colNm_EducPlanDt).substring(0,8));	//����������
					cstmt.setString     (4, rows[i].getString(colNm_ReqDt));		//������û��
					//StringUtil.printMsg("5",rows[i].getString(colNm_ReqDt) , this);
					cstmt.setString     (5, rows[i].getString(colNm_Remarks));		//����
					//StringUtil.printMsg("4",rows[i].getString(colNm_Remarks) , this);
					cstmt.setInt     	(6, rows[i].getInt(colNm_CustSid));			//��SID
					//StringUtil.printMsg("5",rows[i].getInt(colNm_CustSid) , this);
					//	cstmt.setString     (8, rows[i].getString(colNm_NEduc_yn));		//��ϱ������� CU014
					//StringUtil.printMsg("8",rows[i].getString(colNm_NEduc_yn) , this);
					cstmt.setString     (7, rows[i].getString(colNm_NJobGu));		//�ںϽ�û�۾����� CU015 (����/�߰�/��/����)
					//StringUtil.printMsg("6",rows[i].getString(colNm_NJobGu) , this);
					cstmt.setString     (8, rows[i].getString(colNm_VisitObject));	//��ϸ���
					//StringUtil.printMsg("7",rows[i].getString(colNm_VisitObject) , this);
					cstmt.setInt        (9, rows[i].getInt(colNm_SaupSid));	//���� : �����sid
					//StringUtil.printMsg("11",rows[i].getInt(colNm_SaupSid) , this);
					cstmt.setString     (10, fParamEmpno);							//�������
					//StringUtil.printMsg("8",fParamEmpno , this);
					cstmt.setString     (11, fParamIp);								//����ip
					//StringUtil.printMsg("9",fParamIp , this);
					cstmt.setString     (12, v_edit_styatus);						//��������
					//StringUtil.printMsg("10",v_edit_styatus , this);
					cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);

					cstmt.executeUpdate();

					r_s_yn 		= cstmt.getString(13);
					r_msg_cd 	= cstmt.getString(14);
					r_msg 		= cstmt.getString(15);
					
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
					//if(ds_result!=null) ds_result.flush();
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
