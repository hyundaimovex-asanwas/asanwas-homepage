package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv310I extends SuperServlet {

	private static final long serialVersionUID = 1L;

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
		arr_sql[0].append("{call SALES.PR_RV310I_01( ?,?,?,?,?,   ?,?,?,?,?,  ? ) }");

		//��ǰ�� ���� ���� ������ �Ա�����(TRV200)�� �Է��Ѵ�.
		arr_sql[2].append ("INSERT INTO SALES.TRV200 														\n")
				  .append ("(PAY_SID, RSV_SID, ACCEPT_DATE, PLAN_PAY_DATE, PAY_DATE,	PAY_AMT, CLIENT_SID,			\n") 
				  .append (" PAY_YN, PAY_CD, PAY_MANAGE_NO, OPTION_YN, UPJANG_SID, U_EMPNO, U_DATE, U_IP)	\n")
				  .append ("VALUES (sales.sws_trv200_id.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP, ?)				\n");

		//�Ⱓ��ȸ
		arr_sql[3].append ("SELECT SALES.FN_TO_DAY('$1', '$2') DAY_CNT FROM SYSIBM.SYSDUMMY1");
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));				// ����
		int v_orderer_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_orderer_sid"));			// ����ó
		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		//StringUtil.printMsg("v_orderer_sid",v_orderer_sid,this);
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		
		int    v_cnt 			= 1;
		int    v_client_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_client_sid"));	//�븮�� SID
		int    v_goods_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_goods_sid"));		//��ǰ SID
		String v_depart_date1 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date1"));	//�������1
		String v_depart_date2 	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date2"));	//�������2
		String v_accept_no   	= HDUtil.nullCheckStr(greq.getParameter("v_accept_no"));		//��û����ȣ
		String v_cust_nm	   	= HDUtil.nullCheckStr(greq.getParameter("v_cust_nm"));		//����
		String v_pay_gubn	 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_gubn"));		//Option, �������
		String v_cancel_yn		= HDUtil.nullCheckStr(greq.getParameter("v_cancel_yn"));		//����ڿ���
		int    v_saup_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_saup_sid"));		//��� SID
		int v_bound_seq 		= HDUtil.nullCheckNum(greq.getParameter("v_bound_seq"));			// ��ǰ����.
		int v_pay_seq	 		= HDUtil.nullCheckNum(greq.getParameter("v_pay_seq"));			// ��������.
		StringUtil.printMsg("v_client_sid",v_client_sid,this);
		StringUtil.printMsg("v_goods_sid",v_goods_sid,this);
		StringUtil.printMsg("v_depart_date1",v_depart_date1+"",this);
		StringUtil.printMsg("v_accept_no",v_accept_no,this);
		StringUtil.printMsg("v_cust_nm",v_cust_nm,this);
		StringUtil.printMsg("v_pay_gubn",v_pay_gubn,this);
		StringUtil.printMsg("v_cancel_yn",v_cancel_yn,this);
		StringUtil.printMsg("v_saup_sid",v_saup_sid,this);
		StringUtil.printMsg("v_bound_seq",v_bound_seq,this);
		StringUtil.printMsg("v_pay_seq",v_pay_seq,this);
		
		try{
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O: DEFAULT=ds1
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DEFAULT");

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
					cstmt.registerOutParameter(11, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(11);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
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
            }
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		StringUtil.printMsg("# Command","����",this);
		
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet //I:DEFAULT=ds1 */
		GauceDataSet ds1 = gis.read("DEFAULT");	//20140121


		try{		
			String v_pay_manage_no 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_manage_no"));	//����������ȣ
			String v_client_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_client_cd"));		//�븮���ڵ�
			String v_accept_date 	= HDUtil.nullCheckStr(greq.getParameter("v_accept_date"));	//��û����
			String v_pay_date 		= HDUtil.nullCheckStr(greq.getParameter("v_pay_date"));		//�Ա�����
			String v_plan_pay_date 	= HDUtil.nullCheckStr(greq.getParameter("v_plan_pay_date"));	//�Աݿ�������(==�����Ա�����)
			String v_pay_cd		 	= HDUtil.nullCheckStr(greq.getParameter("v_pay_cd"));		//�Աݱ���
			//StringUtil.printMsg("����:�����Ա�����", v_plan_pay_date, this);

			if(v_accept_date.equals(""))
				v_accept_date = v_pay_date;	//
			
			if(v_plan_pay_date.equals(""))
				v_plan_pay_date = v_pay_date;
			
			if(v_pay_cd.equals("080"))	//�����Ա��ڵ��
				v_pay_date = v_plan_pay_date;

			if(ds1!=null){
				GauceDataRow[]    row  = ds1.getDataRows();
				
				//�Աݾ� �μ�Ʈ Roop.
				for(int i=0; i<row.length; i++){
					
					StringUtil.printMsg(" row[i].getString(1)",  row[i].getString(1), this);
					StringUtil.printMsg(" row[i].getInt(2)",  row[i].getString(2), this);
					StringUtil.printMsg(" row[i].getInt(3)",  row[i].getString(3), this);
					StringUtil.printMsg(" row[i].getInt(4)",  row[i].getString(4), this);
					StringUtil.printMsg(" row[i].getInt(5)",  row[i].getString(5), this);
					StringUtil.printMsg(" row[i].getInt(6)",  row[i].getString(6), this);
					StringUtil.printMsg(" row[i].getInt(7)",  row[i].getString(7), this);
					StringUtil.printMsg(" row[i].getInt(8)",  row[i].getString(8), this);
					StringUtil.printMsg(" row[i].getInt(9)",  row[i].getString(9), this);
					StringUtil.printMsg(" row[i].getInt(10)",  row[i].getString(10), this);
					StringUtil.printMsg(" row[i].getInt(11)",  row[i].getString(11), this);
					StringUtil.printMsg(" row[i].getInt(12)",  row[i].getString(12), this);
					StringUtil.printMsg(" row[i].getInt(13)",  row[i].getString(13), this);
					StringUtil.printMsg(" row[i].getInt(14)",  row[i].getString(14), this);
					StringUtil.printMsg(" row[i].getInt(15)",  row[i].getString(15), this);
					StringUtil.printMsg(" row[i].getInt(16)",  row[i].getString(16), this);
					StringUtil.printMsg(" row[i].getInt(17)",  row[i].getString(17), this);
					StringUtil.printMsg(" row[i].getInt(18)",  row[i].getString(18), this);
					StringUtil.printMsg(" row[i].getInt(19)",  row[i].getString(19), this);
					StringUtil.printMsg(" row[i].getInt(20)",  row[i].getString(20), this);
					StringUtil.printMsg(" row[i].getInt(21)",  row[i].getString(21), this);
					StringUtil.printMsg(" row[i].getInt(22)",  row[i].getString(22), this);
					StringUtil.printMsg(" row[i].getInt(23)",  row[i].getString(23), this);
					
						
						
					//�׸����� ���� �÷��� �����Ǿ� ���� ������ �μ�Ʈ���� �ʵ��� ���� �߰�[2008-01-17]
					if( (row[i].getString(ds1.indexOfColumn("JOB_SEL")).equals("T")) || (row[i].getString(ds1.indexOfColumn("JOB_SEL2")).equals("T"))		){
						cstmt = conn.prepareCall(arr_sql[2].toString());
						StringUtil.printMsg(" sql", arr_sql[2].toString(), this);
						cstmt.setInt   (1, row[i].getInt(19));
						cstmt.setString(2, v_accept_date);
						cstmt.setString(3, v_plan_pay_date);
						cstmt.setString(4, v_pay_date);
						cstmt.setInt   (5, row[i].getInt(17));
						cstmt.setString(6, row[i].getString(ds1.indexOfColumn("CLIENT_SID")));
						if(v_pay_cd.equals("020")){
							cstmt.setString(7, "N");
						} else
							cstmt.setString(7, "Y");
						cstmt.setString(8, v_pay_cd);
						cstmt.setString(9, v_pay_manage_no);
						cstmt.setString(10, row[i].getString(20));
						cstmt.setInt	  (11, row[i].getInt(21));
						cstmt.setString(12, fParamEmpno);
						cstmt.setString(13, fParamIp);
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();
					}
				}//for(int i=0; i<row.length; i++){
			}
			gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {

			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
