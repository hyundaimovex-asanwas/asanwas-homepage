package pms.menu.pu;

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

public class Pu160I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU160I_01(?,?,?,?) }" );

		//TENDER ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU060I_02(?,?,?) }" );

		//DETAIL ��ȸ
		arr_sql[2].append ("{call PMS.PR_PU060I_03(?,?,?) }" );

		//Main ����
		//arr_sql[3].append ("{call PMS.PR_PU060I_04(?,?,?,?,?,   ?,?,?) }");
		
		//Tender ����
		//arr_sql[4].append ("{call PMS.PR_PU060I_05(?,?,?,?,?,   ?,?,?,?) }");

		//Detail ����
		arr_sql[5].append ("{call PMS.PR_PU060I_04(?,?,?,?,?,   ?,?,?,?,?         ,?,?) }");
		//EST ��ȸ
		arr_sql[6].append ("{call PMS.PR_PU060I_07(?,?) }" );
		//EST ����
		arr_sql[7].append ("{call PMS.PR_PU060I_08(?,?,?,?,?) }" );
	
	


   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds_default")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, 1);
						cstmt.setString(1, "19990101");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "2");
						cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	}else if(dSets[i].getName().equals("ds_est")){
					//StringUtil.printMsg("Init:::::::::","ds_est",this);
					//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_EST");
						cstmt = conn.prepareCall(arr_sql[6].toString());
						cstmt.setInt(1, 0);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_tender")){
					//StringUtil.printMsg("Init:::::::::","ds_tender",this);
					//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_TENDER");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 0);
						cstmt.setInt(2, 0);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_detail")){
					//StringUtil.printMsg("Init:::::::::","ds_detail",this);
					//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_DETAIL");
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, 1);
						cstmt.setInt(2, 1);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_default")){
						GauceDataSet ds1 = gis.read("DS_DEFAULT");
						//int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// ���� SID
						String v_fr_rqst_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_rqst_date")); 	// ��û���� ����
						String v_to_rqst_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_rqst_date")); 	// ��û���� ����
						String v_rqst_status		= HDUtil.nullCheckStr(greq.getParameter("v_rqst_status")); 	// ��û����

						/*
						StringUtil.printMsg("v_site_sid",v_site_sid,this);
						StringUtil.printMsg("v_fr_rqst_date",v_fr_rqst_date,this);
						StringUtil.printMsg("v_to_rqst_date",v_to_rqst_date,this);
						StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
						*/
						
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, v_site_sid);
						cstmt.setString(1, v_fr_rqst_date);
						cstmt.setString(2, v_to_rqst_date);
						cstmt.setString(3, v_rqst_status);
						cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}else if(dSets[i].getName().equals("ds_est")){
						//StringUtil.printMsg("select:::::::::","ds_est",this);
						GauceDataSet ds1 = gis.read("DS_EST");
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// û�� SID
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[6].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						GauceDataSet ds1 = gis.read("DS_TENDER");
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// û�� SID
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));			// ���� SID
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.setInt(2, v_est_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail")){
						GauceDataSet ds1 = gis.read("DS_DETAIL");
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				//���� SID
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));				//û�� SID
						//int v_item_sid = HDUtil.nullCheckNum(qreq.getParameter("v_item_sid"));				//ǰ�� SID
						
						//StringUtil.printMsg("v_est_sid",v_est_sid+"",this);
						//StringUtil.printMsg("v_item_sid",v_item_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_est_sid);
						cstmt.setInt(2, v_rqst_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����",this);
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");
		GauceDataSet ds2 = gis.read("DS_TENDER");		
		GauceDataSet ds3 = gis.read("DS_DETAIL");
		
			try{
				//StringUtil.printMsg("try",this);
				if (ds3 != null) {
					//StringUtil.printMsg("ds3",this);
					GauceDataRow[] 		rows = ds3.getDataRows();
					GauceDataColumn[] 	cols = ds3.getDataColumns();
							
						int colNm_CHOICE_YN		   	= ds3.indexOfColumn("CHOICE_YN");	  	// ����YN
						int colNm_EST_SID      		= ds3.indexOfColumn("EST_SID");    	   	// ���� SID
						int colNm_VEND_CD      		= ds3.indexOfColumn("VEND_CD");       	// �ŷ�ó�ڵ�
						int colNm_VEND_NM      		= ds3.indexOfColumn("VEND_NM");       	// �ŷ�ó��
						int colNm_TOT_EST_AMT      		= ds3.indexOfColumn("TOT_EST_AMT");       // �Ѱ�����
						int colNm_TOT_FN_EST_AMT      		= ds3.indexOfColumn("TOT_FN_EST_AMT");       	// �����ݾ�
						int colNm_UD_EST_AMT      		= ds3.indexOfColumn("UD_EST_AMT");       	// ������
						int colNm_DATE_CON     	 			= ds3.indexOfColumn("DATE_CON");       		// ǰ������
						int colNm_UDRATE_EST_AMT      		= ds3.indexOfColumn("UDRATE_EST_AMT");       	// ��������
						
										
						
						//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);
		
						for(int i=0; i<rows.length; i++){
							
									int j=1;
									switch(rows[i].getJobType()){
											case GauceDataRow.TB_JOB_INSERT:
												//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
												cstmt = conn.prepareCall(arr_sql[5].toString());
											
												cstmt.setString(1, rows[i].getString(colNm_CHOICE_YN));
												cstmt.setInt(2, rows[i].getInt(colNm_EST_SID));	
												cstmt.setString(3, rows[i].getString(colNm_VEND_CD));	
												cstmt.setString(4, rows[i].getString(colNm_VEND_NM));
												cstmt.setString(5, rows[i].getString(colNm_TOT_EST_AMT));
												cstmt.setString(6, rows[i].getString(colNm_TOT_FN_EST_AMT));
												cstmt.setString(7, rows[i].getString(colNm_UD_EST_AMT));
												cstmt.setString(8, rows[i].getString(colNm_DATE_CON));
												cstmt.setString(9, rows[i].getString(colNm_UDRATE_EST_AMT));
												cstmt.setString(10, iParamEmpno);
												cstmt.setString(11, iParamIp);
												cstmt.setString(12, "1");
															
												cstmt.executeUpdate();
												
												if(cstmt!=null) cstmt.close();						
												break;
											case GauceDataRow.TB_JOB_UPDATE:
													
												//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
												cstmt = conn.prepareCall(arr_sql[5].toString());
											
												cstmt.setString(1, rows[i].getString(colNm_CHOICE_YN));
												cstmt.setInt(2, rows[i].getInt(colNm_EST_SID));	
												cstmt.setString(3, rows[i].getString(colNm_VEND_CD));	
												cstmt.setString(4, rows[i].getString(colNm_VEND_NM));
												cstmt.setString(5, rows[i].getString(colNm_TOT_EST_AMT));
												cstmt.setString(6, rows[i].getString(colNm_TOT_FN_EST_AMT));
												cstmt.setString(7, rows[i].getString(colNm_UD_EST_AMT));
												cstmt.setString(8, rows[i].getString(colNm_DATE_CON));
												cstmt.setString(9, rows[i].getString(colNm_UDRATE_EST_AMT));
												cstmt.setString(10, iParamEmpno);
												cstmt.setString(11, iParamIp);
												cstmt.setString(12, "3");
								
												cstmt.executeUpdate();
												
												if(cstmt!=null) cstmt.close();	
												break;
											case GauceDataRow.TB_JOB_DELETE:
												//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
												cstmt = conn.prepareCall(arr_sql[5].toString());
											
												cstmt.setString(1, rows[i].getString(colNm_CHOICE_YN));
												cstmt.setInt(2, rows[i].getInt(colNm_EST_SID));	
												cstmt.setString(3, rows[i].getString(colNm_VEND_CD));	
												cstmt.setString(4, rows[i].getString(colNm_VEND_NM));
												cstmt.setString(5, rows[i].getString(colNm_TOT_EST_AMT));
												cstmt.setString(6, rows[i].getString(colNm_TOT_FN_EST_AMT));
												cstmt.setString(7, rows[i].getString(colNm_UD_EST_AMT));
												cstmt.setString(8, rows[i].getString(colNm_DATE_CON));
												cstmt.setString(9, rows[i].getString(colNm_UDRATE_EST_AMT));
												cstmt.setString(10, iParamEmpno);
												cstmt.setString(11, iParamIp);
												cstmt.setString(12, "2");
										
												if(cstmt!=null) cstmt.close();	
												break;						
									}
						}
					}	//if (ds3 != null) {
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