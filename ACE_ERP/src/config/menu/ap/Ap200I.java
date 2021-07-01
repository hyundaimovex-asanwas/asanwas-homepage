package config.menu.ap;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.Connection; 
import oracle.jdbc.OracleTypes;

public class Ap200I extends SuperServlet {
	
	/**
	 * 2014-06-27 	���� �Űܼ� �ϰ� �ֽ��ϴ�.
	 * ���ڰ��� ���缱 ���� �޼ҵ�� ��Ƹ�� 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//���ڰ��� - ���縶���� ����
		arr_sql[0].append ("{call COMMON.PR_AP200I_01(?,?,?,?,?, ?,?,?,?,?, ? ) }" );
		//���ڰ��� - ��������� ����
		arr_sql[1].append ("{call COMMON.PR_AP200I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?,  ?) }");
		
		//���ڰ��� - ���缱 ��ȸ
		arr_sql[2].append ("{call COMMON.PR_AP200I_03(?,?,?,?,? ) }" );
		//���繮�� ����/�ݼ� ó���� �ش� ������� ������Ʈ
		arr_sql[3].append("{call COMMON.PR_AP200I_04 (?,?,?,?,?,  ?,?,?)  }");
		
	}
 
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			int v_dwr_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid
			int v_ap_m_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid"));			// v_ap_m_sid
			//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);			
		
		 try {
				for(int i=0; i<dSets.length;i++){
	            	if(dSets[i].getName().equals("ds_apline")){	//���ڰ��� - ����ȭ�� ��ȸ
						GauceDataSet ds1 = gis.read("DS_APLINE");
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_dwr_sid);
						cstmt.setString(2, "40");	// ����
						cstmt.setString(3, "400");	// �۾��Ϻ�
						cstmt.setInt(4, v_ap_m_sid);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 					
						gos.write(getDataSet(rs, ds1));
	            	}
				}
				gos.close();
			}catch (SQLException sqle){
				//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
				throw sqle;
			} catch (Exception e){
				//res.writeException("ERROR", "", e.toString());
				throw e;
			} finally {
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
		}

	//	���� method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds_apline = gis.read("DS_APLINE");
				
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		//StringUtil.printMsg("���ڰ��� �׼� ���� ��/ DS TYPE====",dsType,this);
		try{
			if (ds_apline != null) {
				
				if (dsType==1){	// ���ڰ��� ��Ž�
						//StringUtil.printMsg("���� �޼��� Ȯ��==", "?",this);
						int v_dwr_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid
						int v_ap_m_sid	= 0 ;	
						String v_fin_yn ="N";
						
						//���� ���� ������
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, v_dwr_sid );
						cstmt.setString(2, "40" );
						cstmt.setString(3, "400");
						cstmt.setString(4, "1" );
						cstmt.setString(5, iParamEmpno );
						cstmt.setString(6, iParamIp );
						cstmt.setInt(7, 2	);	//���콺 �� JobType : 2=insert, 3=update, 4=delete
						cstmt.registerOutParameter(8,  java.sql.Types.INTEGER);	//pAP_M_SID ���� ������ SID ����
						cstmt.registerOutParameter(9,  java.sql.Types.VARCHAR);	//9����Y/N
						cstmt.registerOutParameter(10,  java.sql.Types.VARCHAR);	//10�޼��� �ڵ�
						cstmt.registerOutParameter(11,  java.sql.Types.VARCHAR);	//11�޼���
						cstmt.executeUpdate();
						
						//���� �� ó��
						//StringUtil.printMsg("���Ϲ��� AP_M_SID==", cstmt.getInt(8) ,this);
						v_ap_m_sid = cstmt.getInt(8);
					
						if(cstmt!=null) cstmt.close();	
						
						
						GauceDataRow[] 		rows = ds_apline.getDataRows();
						int colNm_seq    		= ds_apline.indexOfColumn("seq");
						int colNm_ap_type		= ds_apline.indexOfColumn("ap_type");                    
						int colNm_ap_status_d	= ds_apline.indexOfColumn("ap_status_d");
						int colNm_eno_no    	= ds_apline.indexOfColumn("eno_no");   
						int colNm_job_nm   		= ds_apline.indexOfColumn("job_nm");           
						int colNm_dpt_nm   		= ds_apline.indexOfColumn("dpt_nm");        
						int colNm_ap_desc     	= ds_apline.indexOfColumn("ap_desc");

						
						//StringUtil.printMsg("���缱 �� ? ",rows.length,this);
						for(int i=0; i<rows.length; i++){
					
							//StringUtil.printMsg("ds_apline "+i+"�� �۾�===",rows[i].getJobType(),this);
							// ���콺 �� JobType : 2=insert, 3=update, 4=delete
							// ���� �������� ���
							if(rows[i].getInt(colNm_seq)==rows.length){
								v_fin_yn = "Y";
							}else{
								v_fin_yn = "N";
							}
							
							/*
							StringUtil.printMsg("colNm_seq",rows[i].getString(colNm_seq),this);
							StringUtil.printMsg("v_fin_yn",v_fin_yn,this);
							StringUtil.printMsg("colNm_ap_type",rows[i].getString(colNm_ap_type),this);
							StringUtil.printMsg("colNm_ap_status_d",rows[i].getString(colNm_ap_status_d),this);
							StringUtil.printMsg("colNm_eno_no",rows[i].getString(colNm_eno_no),this);
							StringUtil.printMsg("colNm_job_nm",rows[i].getString(colNm_job_nm),this);
							StringUtil.printMsg("colNm_dpt_nm",rows[i].getString(colNm_dpt_nm),this);
							StringUtil.printMsg("colNm_ap_desc",rows[i].getString(colNm_ap_desc),this);
							StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
							StringUtil.printMsg("iParamIp",iParamIp,this);
							*/

							
							// ���� ������
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setInt(1, v_ap_m_sid );//
							cstmt.setString(2, "1");	//AP_GU �� ���� 1(����) �� �ְ� �ִ�.
							cstmt.setInt(3, rows[i].getInt(colNm_seq) );
							cstmt.setString(4, rows[i].getString(colNm_ap_type));
							cstmt.setString(5, rows[i].getString(colNm_ap_status_d));
							cstmt.setString(6, rows[i].getString(colNm_eno_no));
							cstmt.setString(7, rows[i].getString(colNm_job_nm));	//������
							cstmt.setString(8, rows[i].getString(colNm_dpt_nm));	//�Ҽ�
							cstmt.setString(9, rows[i].getString(colNm_ap_desc));
							cstmt.setString(10, v_fin_yn );	//���� ������ ����
							cstmt.setString(11, iParamEmpno );
							cstmt.setString(12, iParamIp );
							cstmt.setInt(13, rows[i].getJobType()	);	// ���缱�� �μ�Ʈ(2)�� �ð���
							cstmt.registerOutParameter(14,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15,  java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16,  java.sql.Types.VARCHAR);
							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
						}
				}
				if (dsType==2){	// ���ڰ��� �ݷ���
					StringUtil.printMsg("�ݷ� Ŭ��==", "-------------",this);

					int v_ap_m_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid"));			// DWR_sid
					
					GauceDataRow[] 		rows = ds_apline.getDataRows();
					int colNm_eno_no    	= ds_apline.indexOfColumn("eno_no");   
					int colNm_ap_desc     	= ds_apline.indexOfColumn("ap_desc");
					String ap_desc = "";
					
					for(int i=0; i<rows.length; i++){
						if(rows[i].getString(colNm_eno_no).equals(iParamEmpno)){	//�������� �ǰ��� ��츸
							ap_desc = rows[i].getString(colNm_ap_desc);
						}else{
							ap_desc = "";
						}
					}	

					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_ap_m_sid );		// ���縶���� SID
					cstmt.setString(2, iParamEmpno );	// ������
					cstmt.setString(3, iParamIp);		// ������ IP
					cstmt.setString(4, "N");		// ���� ����=Y, �ݼ�=N
					cstmt.setString(5, ap_desc);		// ���� �ǰ�
					cstmt.registerOutParameter(6,  java.sql.Types.VARCHAR);	//5����Y/N
					cstmt.registerOutParameter(7,  java.sql.Types.VARCHAR);	//6�޼��� �ڵ�
					cstmt.registerOutParameter(8,  java.sql.Types.VARCHAR);	//7�޼���
					cstmt.executeUpdate();
					
					//���� �� ó��
					//StringUtil.printMsg("���Ϲ��� AP_M_SID==", cstmt.getInt(8) ,this);
					//v_ap_m_sid = cstmt.getInt(8);
				
					if(cstmt!=null) cstmt.close();
				}
				if (dsType==3){	// ���ڰ��� ���ν�
					//StringUtil.printMsg("���� Ŭ��==", "-------------",this);

					int v_ap_m_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid"));			// DWR_sid
					                    
					
					//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);
					//StringUtil.printMsg("ap_m_sid", v_ap_m_sid,this);
					//StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					//StringUtil.printMsg("iParamIp",iParamIp,this);
					GauceDataRow[] 		rows = ds_apline.getDataRows();
					int colNm_eno_no    	= ds_apline.indexOfColumn("eno_no");   
					int colNm_ap_desc     	= ds_apline.indexOfColumn("ap_desc");
					String ap_desc = "";
					
					for(int i=0; i<rows.length; i++){
						if(rows[i].getString(colNm_eno_no).equals(iParamEmpno)){	//�������� �ǰ��� ��츸
							ap_desc = rows[i].getString(colNm_ap_desc);
						}else{
							ap_desc = "";
						}
					}	

					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_ap_m_sid );		// ���縶���� SID
					cstmt.setString(2, iParamEmpno );	// ������
					cstmt.setString(3, iParamIp);		// ������ IP
					cstmt.setString(4, "Y");		// ���� ����=Y, �ݼ�=N
					cstmt.setString(5, ap_desc);		// ���� �ǰ�
					cstmt.registerOutParameter(6,  java.sql.Types.VARCHAR);	//5����Y/N
					cstmt.registerOutParameter(7,  java.sql.Types.VARCHAR);	//6�޼��� �ڵ�
					cstmt.registerOutParameter(8,  java.sql.Types.VARCHAR);	//7�޼���
					cstmt.executeUpdate();
					
					//���� �� ó��
					//StringUtil.printMsg("���Ϲ��� AP_M_SID==", cstmt.getInt(8) ,this);
					//v_ap_m_sid = cstmt.getInt(8);
				
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}

}
