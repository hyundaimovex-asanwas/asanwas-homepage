package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
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

import sales.common.*;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv310I_01 extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
		/*
		 * ���� ���� ��� ���� ��ȸ
		 *    IN  pCLIENT_SID          NUMERIC(10)   -- ����ó SID.
		 *   ,IN  pPAY_GUBN            VARCHAR(1)    -- ��ݱ���. ����=N, �ɼ�=Y
		 *   ,IN  pCANCEL_YN           VARCHAR(2)    -- ����� ���� ����. ����='RC'
		 *   ,IN  pSAUP_SID  			 NUMERIC(2)    -- ����� SID.
		 *   ,IN  pGOODS_SID  		 NUMERIC(2)    -- ��ǰ SID.
		 *   ,IN  pDEPART_DATE 		 VARCHAR(8)    -- �������
		 *   ,IN  pACCEPT_NO           VARCHAR(14)   -- �ֹ�/���ǹ�ȣ
		 *   ,IN  pCUST_NM             VARCHAR(30)   -- �ѱۼ���
		 */
		arr_sql[0].append("{call SALES.PR_RV310I_01_01( ?, ?, ?, ?, ?,   ?, ?, ?,?,? ) }");

		//��ǰ�� ���� ���� ������ �Ա�����(TRV200)�� �Է��Ѵ�.
		arr_sql[2].append ("INSERT INTO SALES.TRV200 														\n")
				  .append ("(RSV_SID, ACCEPT_DATE, PLAN_PAY_DATE, PAY_DATE,	PAY_AMT, CLIENT_SID,			\n") 
				  .append (" PAY_YN, PAY_CD, PAY_MANAGE_NO, OPTION_YN, UPJANG_SID, U_EMPNO, U_DATE, U_IP)	\n")
				  .append ("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP, ?)				\n");

		//�Ⱓ��ȸ
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		GauceStatement stmt = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));	//�븮�� SID
		int    v_goods_sid 		= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));		//��ǰ SID
		String v_depart_date1 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date1"));	//�������1
		String v_depart_date2 	= HDUtil.nullCheckStr(req.getParameter("v_depart_date2"));	//�������2
		String v_accept_no   	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));		//��û����ȣ
		String v_cust_nm	   	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));		//����
		String v_pay_gubn	 	= HDUtil.nullCheckStr(req.getParameter("v_pay_gubn"));		//Option, �������
		String v_cancel_yn		= HDUtil.nullCheckStr(req.getParameter("v_cancel_yn"));		//����ڿ���
		int    v_saup_sid 		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));		//��� SID
		int v_bound_seq 	= HDUtil.nullCheckNum(req.getParameter("v_bound_seq"));			// ��ǰ����.
		int v_pay_seq	 	= HDUtil.nullCheckNum(req.getParameter("v_pay_seq"));			// ��������.
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds_grid = req.getGauceDataSet(gauceName);
				if(ds_grid!=null){
					res.enableFirstRow(ds_grid);
					
					if(gauceName.equals("DEFAULT")){
						/* ��¥ �Ⱓ �˻��ϴ� �κ�.. ���⼱ �Ⱦ����� ���ܵд�. 2008-05-10
						String temp_sql = arr_sql[3].toString();
						temp_sql = StringUtil.strReplace(temp_sql, "$1", v_depart_date1);
						temp_sql = StringUtil.strReplace(temp_sql, "$2", v_depart_date2);
						
						stmt = conn.getGauceStatement(temp_sql);
						rs = stmt.executeQuery();
						if(rs.next()){
							if(rs.getInt("DAY_CNT")>3){
								res.writeException("ERROR", "0000", "�Ⱓ�� 3���̳��� �Ͻñ� �ٶ��ϴ�.");
								break;
							}
						} else {
							res.writeException("ERROR", "0000", "�Ⱓ���� ���ڸ� ����ϴ��� ������ �߻��߽��ϴ�.");
							break;
						}
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();*/
						
						//��ȸ����
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt   (1, v_client_sid);   	//pCLIENT_SID  ����ó SID.                
						cstmt.setString(2, v_pay_gubn);		  	//pPAY_GUBN    ��ݱ���. ����=N, �ɼ�=Y   
						cstmt.setString(3, v_cancel_yn);	  	//pCANCEL_YN   ����� ���� ����. ����='RC'
						cstmt.setInt   (4, v_saup_sid);		  	//pSAUP_SID  	 ����� SID.                
						cstmt.setInt   (5, v_goods_sid);	  	//pGOODS_SID   ��ǰ SID.                  
						cstmt.setString(6, v_depart_date1); 	//pDEPART_DATE �������                   
						cstmt.setString(7, v_accept_no);		//pACCEPT_NO   �ֹ�/���ǹ�ȣ              
						cstmt.setString(8, v_cust_nm);		 	//pCUST_NM     �ѱۼ���                   			
						cstmt.setInt(9, v_bound_seq);
						cstmt.setInt(10, v_pay_seq);

						rs = cstmt.executeQuery();
						getDataSet(rs, ds_grid).flush();
					}//if(gauceName.equals("DEFAULT")){
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
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		String v_pay_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_pay_manage_no"));	//���������ȣ
		String v_client_cd 		= HDUtil.nullCheckStr(req.getParameter("v_client_cd"));		//�븮���ڵ�
		String v_accept_date 	= HDUtil.nullCheckStr(req.getParameter("v_accept_date"));	//��û����
		String v_pay_date 		= HDUtil.nullCheckStr(req.getParameter("v_pay_date"));		//�Ա�����
		String v_plan_pay_date 	= HDUtil.nullCheckStr(req.getParameter("v_plan_pay_date"));	//�Աݿ�������(==�����Ա�����)
		String v_pay_cd		 	= HDUtil.nullCheckStr(req.getParameter("v_pay_cd"));		//�Աݱ���
		

		//StringUtil.printMsg("����:�����Ա�����", v_plan_pay_date, this);
		
		
		if(v_accept_date.equals(""))
			v_accept_date = v_pay_date;
		
		if(v_plan_pay_date.equals(""))
			v_plan_pay_date = v_pay_date;
		
		if(v_pay_cd.equals("080"))	//�����Ա��ڵ��
			v_pay_date = v_plan_pay_date;
		

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					GauceDataRow[]    row  = ds1.getDataRows();
					
					//�Աݾ� �μ�Ʈ Roop.
					for(int i=0; i<row.length; i++){
						
						//�׸����� ���� �÷��� �����Ǿ� ���� ������ �μ�Ʈ���� �ʵ��� ���� �߰�[2008-01-17]
						if(row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")	){
							stmt = conn.getGauceStatement(arr_sql[2].toString());
							stmt.setInt   (1, row[i].getInt(18));
							stmt.setString(2, v_accept_date);
							stmt.setString(3, v_plan_pay_date);
							stmt.setString(4, v_pay_date);
							stmt.setInt   (5, row[i].getInt(16));
							stmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
							if(v_pay_cd.equals("020")){
								stmt.setString(7, "N");
							} else
								stmt.setString(7, "Y");
							stmt.setString(8, v_pay_cd);
							stmt.setString(9, v_pay_manage_no);
							stmt.setString(10, row[i].getString(19));
							stmt.setInt	  (11, row[i].getInt(20));
							stmt.setString(12, fParamEmpno);
							stmt.setString(13, fParamIp);
							stmt.executeUpdate();
							if(stmt!=null) stmt.close();
						}
						
						if(row[i].getString(ds1.indexOfColumn("JOB_SEL2")).equals("T")	){
								stmt = conn.getGauceStatement(arr_sql[2].toString());
								stmt.setInt   (1, row[i].getInt(18));
								stmt.setString(2, v_accept_date);
								stmt.setString(3, v_plan_pay_date);
								stmt.setString(4, v_pay_date);
								stmt.setInt   (5, row[i].getInt(16));
								stmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
								if(v_pay_cd.equals("020")){
									stmt.setString(7, "N");
								} else
									stmt.setString(7, "Y");
								stmt.setString(8, v_pay_cd);
								stmt.setString(9, v_pay_manage_no);
								stmt.setString(10, row[i].getString(19));
								stmt.setInt	  (11, row[i].getInt(20));
								stmt.setString(12, fParamEmpno);
								stmt.setString(13, fParamIp);
								stmt.executeUpdate();
								if(stmt!=null) stmt.close();
						}
					}//for(int i=0; i<row.length; i++){
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
	}}
