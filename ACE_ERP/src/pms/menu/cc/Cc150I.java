package pms.menu.cc;

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

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;


public class Cc150I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	
	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		
		//card use list ��ȸ
		arr_sql[0].append ("{call PMS.PR_CC150I_01(?,?,?,?,?,?) }" );
		
		
		//card use list detail ��ȸ - ��������
		//arr_sql[1].append ("{call PMS.PR_CC110I_02(?,?) }" );
		
		
		//card use list ���λ�� 
		//arr_sql[2].append ("{call PMS.PR_CC110I_03(?,?) }" );
		
		
		//card use list detail ���� - �������� 
		//arr_sql[3].append ("{call PMS.PR_CC110I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?) }" );
		
		
		//card use list //�ŷ� �� �ݾ�, �������� ����
		//arr_sql[4].append ("{call PMS.PR_CC110I_05(?,?,?,?,?) }" );
		
		
		//card use list //�ϰ�����
		//arr_sql[5].append ("{call PMS.PR_CC110I_06(?,?,?,?,?,   ?,?,?,?) }" );

		
	}

	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		
		//StringUtil.printMsg("�ʱ�ȭ~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		
		
		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            
            //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            
            for(int i=0; i<dSets.length;i++){
            	
            	
				if(dSets[i].getName().equals("ds_cul")){
					
					
					GauceDataSet ds1 = gis.read("DS_CUL");
					
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					
					cstmt.setString(1, "19991201");
					cstmt.setString(2, "19991201");
					cstmt.setString(3, "");
					cstmt.setString(4, "");
					cstmt.setString(5, "");
					cstmt.setString(6, "");
					cstmt.setString(7, "");
					cstmt.setString(8, "");
					
					cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(9);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
            	}
				
            	
            }
            
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}

	}	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_mgr_no 		= HDUtil.nullCheckStr(greq.getParameter("v_mgr_no"));			//ó���� ���
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//��ȸ�Ⱓ
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//��ȸ�Ⱓ
		String v_ccstat			= HDUtil.nullCheckStr(greq.getParameter("v_ccstat"));			// ó�� ����
		String v_card_num 		= HDUtil.nullCheckStr(greq.getParameter("v_card_num"));			// ī���ȣ

		/*
		StringUtil.printMsg("v_mgr_no",v_mgr_no,this);
		StringUtil.printMsg("v_frdt",v_frdt,this);
		StringUtil.printMsg("v_todt",v_todt,this);
		StringUtil.printMsg("v_ccstat",v_ccstat,this);
		StringUtil.printMsg("v_card_num",v_card_num,this);
		*/
		
		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            
            //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            
            for(int i=0; i<dSets.length;i++){
            	
	
            	
				if(dSets[i].getName().equals("ds_cul")){
					
					GauceDataSet ds1 = gis.read("DS_CUL");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					
					cstmt.setString(1, v_frdt);
					cstmt.setString(2, v_todt);
					cstmt.setString(3, v_mgr_no);
					cstmt.setString(4, v_card_num);
					cstmt.setString(5, v_ccstat);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
					
            	}

            }
            
		}catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		//StringUtil.printMsg("����~!","",this);
		
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
		
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
        GauceDataSet ds_cul		= gis.read("DS_CUL");		//�ŷ� �� �ݾ�, ��������
        GauceDataSet ds_culd	= gis.read("DS_CULD");		//����|�ͼ� ���� 
        GauceDataSet ds_cul_use	= gis.read("DS_CUL_USE");	//���λ�� ������Ʈ
        GauceDataSet ds_cult	= gis.read("DS_CULT");		//�ϰ����� ������Ʈ
        
        
        int	v_acquire_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_acquire_sid"));		// ����sid
        
        
		try{
			
			if (ds_cul != null) {
				
				GauceDataRow[] 		rows = ds_cul.getDataRows();
				
				int colNm_acquire_sid   = ds_cul.indexOfColumn("acquire_sid");	//�ŷ�sid
				int colNm_amt_net		= ds_cul.indexOfColumn("amt_net");	//���ް���
				int colNm_amt_tax		= ds_cul.indexOfColumn("amt_tax");  //�ΰ���  
				int colNm_amt_svc		= ds_cul.indexOfColumn("amt_svc");	//�����(�鼼��)
				int colNm_ddyn			= ds_cul.indexOfColumn("ddyn");		//��������(T|F)
				
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				
				for(int i=0; i<rows.length; i++){
					
					//StringUtil.printMsg("ds_wd "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete

					/*
					StringUtil.printMsg("colNm_acquire_sid",rows[i].getInt(colNm_acquire_sid),this);
					StringUtil.printMsg("colNm_amt_net",rows[i].getInt(colNm_amt_net),this);
					StringUtil.printMsg("colNm_amt_tax",rows[i].getInt(colNm_amt_tax),this);
					StringUtil.printMsg("colNm_amt_svc",rows[i].getInt(colNm_amt_svc),this);
					StringUtil.printMsg("colNm_ddyn",rows[i].getString(colNm_ddyn),this);
					*/
					
					//StringUtil.printMsg("iParamIp",iParamIp,this);
					
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setInt(1, rows[i].getInt(colNm_acquire_sid) );
					cstmt.setInt(2, rows[i].getInt(colNm_amt_net) );
					cstmt.setInt(3, rows[i].getInt(colNm_amt_tax) );
					cstmt.setInt(4, rows[i].getInt(colNm_amt_svc) );
					cstmt.setString(5, rows[i].getString(colNm_ddyn));
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
				}
				
			}
			
			

			if (ds_cul_use != null) {
				
				StringUtil.printMsg("v_acquire_sid",v_acquire_sid+"",this);
				
				cstmt = conn.prepareCall(arr_sql[2].toString());
				
				cstmt.setInt(1, v_acquire_sid );
				cstmt.setString(2, iParamEmpno);
				
				cstmt.executeUpdate();
				if(cstmt!=null) cstmt.close();		
				
			}
			
			
			
			if (ds_culd != null) {
				
				GauceDataRow[] 		rows = ds_culd.getDataRows();
				
				int colNm_acquire_sid  	= ds_culd.indexOfColumn("acquire_sid");
				int colNm_atcodenm      = ds_culd.indexOfColumn("atcodenm");
				int colNm_atcode		= ds_culd.indexOfColumn("atcode");                    
				int colNm_remark		= ds_culd.indexOfColumn("remark");
				int colNm_fsamt			= ds_culd.indexOfColumn("fsamt");   
				int colNm_pl_dept_nm	= ds_culd.indexOfColumn("pl_dept_nm");           
				int colNm_pl_dept		= ds_culd.indexOfColumn("pl_dept");        
				int colNm_pl_dept_div  	= ds_culd.indexOfColumn("pl_dept_div");      
				int colNm_refcdnm	  	= ds_culd.indexOfColumn("refcdnm");
				int colNm_refcd		  	= ds_culd.indexOfColumn("refcd");
				int colNm_groupnm		= ds_culd.indexOfColumn("group_nm");
								
				
				for(int i=0; i<rows.length; i++){
			
					
					//StringUtil.printMsg("ds_culd "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					/*
					StringUtil.printMsg("colNm_acquire_sid",rows[i].getInt(colNm_acquire_sid),this);
					StringUtil.printMsg("colNm_atcodenm",rows[i].getString(colNm_atcodenm),this);
					StringUtil.printMsg("colNm_atcode",rows[i].getString(colNm_atcode),this);
					StringUtil.printMsg("colNm_remark",rows[i].getString(colNm_remark),this);
					StringUtil.printMsg("colNm_fsamt",rows[i].getInt(colNm_fsamt),this);
					StringUtil.printMsg("colNm_pl_dept_nm",rows[i].getString(colNm_pl_dept_nm),this);
					StringUtil.printMsg("colNm_pl_dept",rows[i].getString(colNm_pl_dept),this);
					StringUtil.printMsg("colNm_pl_dept_div",rows[i].getString(colNm_pl_dept_div),this);
					StringUtil.printMsg("colNm_refcdnm",rows[i].getString(colNm_refcdnm),this);
					StringUtil.printMsg("colNm_refcd",rows[i].getString(colNm_refcd),this);
					StringUtil.printMsg("colNm_groupnm",rows[i].getString(colNm_groupnm),this);
					*/
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					cstmt.setInt(1, rows[i].getInt(colNm_acquire_sid) );
					cstmt.setString(2, rows[i].getString(colNm_atcodenm) );
					cstmt.setString(3, rows[i].getString(colNm_atcode));
					cstmt.setString(4, rows[i].getString(colNm_remark) );
					cstmt.setInt(5, rows[i].getInt(colNm_fsamt) );
					cstmt.setString(6, rows[i].getString(colNm_pl_dept_nm) );
					cstmt.setString(7, rows[i].getString(colNm_pl_dept) );
					cstmt.setString(8, rows[i].getString(colNm_pl_dept_div));	
					cstmt.setString(9, rows[i].getString(colNm_refcdnm) );
					cstmt.setString(10, rows[i].getString(colNm_refcd) );
					cstmt.setString(11, rows[i].getString(colNm_groupnm).trim() ); //2019.06.13 ó�� �׷�� �� ������ ������ ���� ��쿡 ��ǥ ���� �ȵǴ� ���� �ذ�!
					cstmt.setInt(12, rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.setString(13, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
				}
				
			}
			
			
			
			if (ds_cult!= null) {
				
				String v_mgr_no 		= HDUtil.nullCheckStr(greq.getParameter("v_mgr_no"));				//ó���� ���
				String v_mgr_deptcd 	= HDUtil.nullCheckStr(greq.getParameter("v_mgr_deptcd"));			//ó���� erp�α� �μ�
				
				GauceDataRow[] 		rows = ds_cult.getDataRows();
				
				int colNm_acquire_sid   = ds_cult.indexOfColumn("acquire_sid");		//�ŷ�sid
				int colNm_vend_cd		= ds_cult.indexOfColumn("vend_cd");			//�ƻ� �ŷ�ó ����
				int colNm_approve_date	= ds_cult.indexOfColumn("approve_date");	//�ŷ�����
				int colNm_amt_net		= ds_cult.indexOfColumn("amt_net");			//���ް���
				int colNm_amt_tax		= ds_cult.indexOfColumn("amt_tax");  		//�ΰ���  
				int colNm_card_num		= ds_cult.indexOfColumn("card_num");		//ī���ȣ
				int colNm_cadiv			= ds_cult.indexOfColumn("cadiv");			//ī��� ����
				
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				
				for(int i=0; i<rows.length; i++){
					
					//StringUtil.printMsg("ds_cult "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					
					/*
					StringUtil.printMsg("colNm_acquire_sid",rows[i].getInt(colNm_acquire_sid),this);
					StringUtil.printMsg("v_mgr_no", v_mgr_no ,this);
					StringUtil.printMsg("v_mgr_deptcd", v_mgr_deptcd ,this);
					StringUtil.printMsg("colNm_vend_cd",rows[i].getString(colNm_vend_cd),this);
					StringUtil.printMsg("colNm_approve_date",rows[i].getString(colNm_approve_date),this);
					StringUtil.printMsg("colNm_amt_net",rows[i].getInt(colNm_amt_net),this);
					StringUtil.printMsg("colNm_amt_tax",rows[i].getInt(colNm_amt_tax),this);
					StringUtil.printMsg("colNm_card_num",rows[i].getString(colNm_card_num),this);
					StringUtil.printMsg("colNm_cadiv",rows[i].getString(colNm_cadiv),this);
					*/

					
					cstmt = conn.prepareCall(arr_sql[5].toString());
					
					cstmt.setInt(1, rows[i].getInt(colNm_acquire_sid) );
					cstmt.setString(2, v_mgr_no);
					cstmt.setString(3, v_mgr_deptcd);
					cstmt.setString(4, rows[i].getString(colNm_vend_cd));
					cstmt.setString(5, rows[i].getString(colNm_approve_date));
					cstmt.setInt(6, rows[i].getInt(colNm_amt_net) );
					cstmt.setInt(7, rows[i].getInt(colNm_amt_tax) );
					cstmt.setString(8, rows[i].getString(colNm_card_num));
					cstmt.setString(9, rows[i].getString(colNm_cadiv));
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
					
				}
				
			}
			
			gos.close();
			
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}        
		
	}
	
}

