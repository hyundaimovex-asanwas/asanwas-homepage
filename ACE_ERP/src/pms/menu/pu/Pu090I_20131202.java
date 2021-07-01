package pms.menu.pu;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

public class Pu090I_20131202 extends SuperServlet {

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU090I_01(?,?,?) }" );

		//TENDER ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU090I_02(?,?) }" );

		//DETAIL ��ȸ
		arr_sql[2].append ("{call PMS.PR_PU090I_03(?,?) }" );

		//Main ����
		//arr_sql[3].append ("{call PMS.PR_PU090I_04(?,?,?,?,?,   ?,?,?) }");
		
		//Tender ����
		//arr_sql[4].append ("{call PMS.PR_PU090I_05(?,?,?,?,?,   ?,?,?,?) }");

		//Detail ����
		arr_sql[5].append ("{call PMS.PR_PU090I_04(?,?,?,?,?,   ?,?,?,?,?,     ?,?,?,?,?,      ?,?,?,?,?,      ?,?,?,?,?        ,?,?,?,?,?) }");
	
	


   }

	//init method
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_fr_bid_date",v_fr_bid_date,this);
		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){
						//StringUtil.printMsg("DS DS_DEFAULT","����ȸ",this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, 1);
						cstmt.setString(1, "19990101");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "2");
					} else if(gauceName.equals("DS_TENDER")){
						//StringUtil.printMsg("DS DS_TENDER","����ȸ",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 9999999);
						cstmt.setInt(2, 9999999);
					}else if(gauceName.equals("DS_DETAIL")){
					//StringUtil.printMsg("DS DS_TENDER","����ȸ",this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 1);
					cstmt.setString(2, "1");
					}

					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
					
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
	
	//select method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);

					if(gauceName.equals("DS_DEFAULT")){
						//int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// ���� SID
						String v_fr_con_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_con_date")); 	// ǰ������ ����
						String v_to_con_date	= HDUtil.nullCheckStr(req.getParameter("v_to_con_date")); 	// ǰ������ ����
						String v_rqst_status		= HDUtil.nullCheckStr(req.getParameter("v_rqst_status")); 	// ��û����

						/*
						StringUtil.printMsg("v_site_sid",v_site_sid,this);
						StringUtil.printMsg("v_fr_con_date",v_fr_con_date,this);
						StringUtil.printMsg("v_to_con_date",v_to_con_date,this);
						StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
						*/
						
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, v_site_sid);
						cstmt.setString(1, v_fr_con_date);
						cstmt.setString(2, v_to_con_date);
						cstmt.setString(3, v_rqst_status);
					} else if(gauceName.equals("DS_TENDER")){
						int v_rqst_sid = HDUtil.nullCheckNum(req.getParameter("v_rqst_sid"));			// û�� SID
						int v_est_sid = HDUtil.nullCheckNum(req.getParameter("v_est_sid"));				// ���� SID
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.setInt(2, v_est_sid);
					} else if(gauceName.equals("DS_DETAIL")){
						int v_est_sid = HDUtil.nullCheckNum(req.getParameter("v_est_sid"));				//���� SID
						String v_vend_cd 	= HDUtil.nullCheckStr(req.getParameter("v_vend_cd")); 	// �ŷ�ó�ڵ�
						
						//StringUtil.printMsg("v_est_sid",v_est_sid+"",this);
						//StringUtil.printMsg("v_item_sid",v_item_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_est_sid);
						cstmt.setString(2, v_vend_cd);
					}
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
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
	
	//apply method
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		//GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
			
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
					
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS_DEFAULT");
		GauceDataSet ds2 = req.getGauceDataSet("DS_TENDER");
		GauceDataSet ds3 = req.getGauceDataSet("DS_DETAIL");
					
//		int fSiteSid = 0;
		try{
			if (ds1 != null) {
				//StringUtil.printMsg("ds1","ds1",this);
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
			
				int colNm_CON_STATUS      		= ds1.indexOfColumn("CON_STATUS");    	//��������    
				int colNm_DATE_CON     		 		= ds1.indexOfColumn("DATE_CON");       		// ǰ������  
				int colNm_CON_NO      				= ds1.indexOfColumn("CON_NO");       			// ǰ�ǹ�ȣ    
				int colNm_CON_SID      				= ds1.indexOfColumn("CON_SID");       		// ǰ��SID    
				int colNm_EST_SID      				= ds1.indexOfColumn("EST_SID");       			// ����SID    
				int colNm_RQST_DATE      			= ds1.indexOfColumn("RQST_DATE");       	// û������      
				int colNm_RQST_NO      				= ds1.indexOfColumn("RQST_NO");    	   		// û����ȣ    
				int colNm_RQST_SID      				= ds1.indexOfColumn("RQST_SID");       		// û��SID  
				//int colNm_DG_SUM_AMT				= ds1.indexOfColumn("DG_SUM_AMT");  		// ���޾�
				//int colNm_YS_SUM_AMT				= ds1.indexOfColumn("YS_SUM_AMT");  		// �����
				int colNm_SITE_CD      				= ds1.indexOfColumn("SITE_CD");       			// �����ڵ�    
				int colNm_PU_EMPNO      			= ds1.indexOfColumn("PU_EMPNO");       	// �������ڻ��    
				int colNm_SITE_NM      				= ds1.indexOfColumn("SITE_NM");       		// �����    
				int colNm_SITE_SID      				= ds1.indexOfColumn("SITE_SID");       		// ����SID      
				int colNm_RQST_USE      			= ds1.indexOfColumn("RQST_USE");       		// ���ó 
				int colNm_DATE_DDL      				= ds1.indexOfColumn("DATE_DDL");       		// ��������   
				int colNm_PUT_WH      				= ds1.indexOfColumn("PUT_WH");       			// ����â��   
				int colNm_TERMS_TRANS      		= ds1.indexOfColumn("TERMS_TRANS");      // �ε�����
				int colNm_WAY_CHK      				= ds1.indexOfColumn("WAY_CHK");       		// �˻���
				int colNm_TERMS_PAY      			= ds1.indexOfColumn("TERMS_PAY");       	// ��������
				int colNm_BUR_TRANS      			= ds1.indexOfColumn("BUR_TRANS");       	// ��ݺ�δ�
				int colNm_OSV_PVR      				= ds1.indexOfColumn("OSV_PVR");       		// �������ؼ�����
				int colNm_CON_NOTE      			= ds1.indexOfColumn("CON_NOTE");       		// Ư�����
				int colNm_PREPAY_AMT_RATE    = ds1.indexOfColumn("PREPAY_AMT_RATE");       			// ���ޱ���   
				int colNm_PREPAY_AMT      		= ds1.indexOfColumn("PREPAY_AMT");     	 // ���ޱ�
				int colNm_CH_RATE      				= ds1.indexOfColumn("CH_RATE");       		// ������ຸ������
				int colNm_CH_AMT      				= ds1.indexOfColumn("CH_AMT");       			// ������ຸ����
				int colNm_DB_RATE      				= ds1.indexOfColumn("DB_RATE");       		// ���ں�����������
				int colNm_DB_AMT      				= ds1.indexOfColumn("DB_AMT");       			// ���ں���������
				int colNm_TERM_GRN      			= ds1.indexOfColumn("TERM_GRN");      		// �����Ⱓ
				int colNm_TOT_FN_EST_AMT  	= ds1.indexOfColumn("TOT_FN_EST_AMT");    		// �����ݾ�
				int colNm_BON_EMPNO      		= ds1.indexOfColumn("BON_EMPNO");      		// ���ֺ������ڻ��
				int colNm_BON_EMPNM  			= ds1.indexOfColumn("BON_EMPNM");    		// ���ֺ������ڼ���
				
								
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					
							int j=1;
							switch(rows[i].getJobType()){
									case GauceDataRow.TB_JOB_INSERT:
										
										/*
										StringUtil.printMsg("call","PMS.PR_INSERT",this);
										StringUtil.printMsg("colNm_RQST_STATUS",rows[i].getString(colNm_RQST_STATUS),this);
										StringUtil.printMsg("colNm_DATE_CON",rows[i].getString(colNm_DATE_CON),this);
										StringUtil.printMsg("colNm_NO_CON",rows[i].getString(colNm_NO_CON),this);
										StringUtil.printMsg("colNm_CON_SID",rows[i].getString(colNm_CON_SID),this);
										StringUtil.printMsg("colNm_EST_SID",rows[i].getString(colNm_EST_SID),this);
										StringUtil.printMsg("colNm_RQST_DATE",rows[i].getString(colNm_RQST_DATE),this);
										StringUtil.printMsg("colNm_RQST_NO",rows[i].getString(colNm_RQST_NO),this);
										StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
										StringUtil.printMsg("colNm_SITE_CD",rows[i].getString(colNm_SITE_CD),this);
										StringUtil.printMsg("colNm_PU_EMPNO",rows[i].getString(colNm_PU_EMPNO),this);
										StringUtil.printMsg("colNm_SITE_NM",rows[i].getString(colNm_SITE_NM),this);
										StringUtil.printMsg("colNm_SITE_SID",rows[i].getString(colNm_SITE_SID),this);
										StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
										StringUtil.printMsg("colNm_DATE_DDL",rows[i].getString(colNm_DATE_DDL),this);
										StringUtil.printMsg("colNm_PUT_WH",rows[i].getString(colNm_PUT_WH),this);
										StringUtil.printMsg("colNm_TERMS_TRANS",rows[i].getString(colNm_TERMS_TRANS),this);
										StringUtil.printMsg("colNm_WAY_CHK",rows[i].getString(colNm_WAY_CHK),this);
										StringUtil.printMsg("colNm_TERMS_PAY",rows[i].getString(colNm_TERMS_PAY),this);
										StringUtil.printMsg("colNm_BUR_TRANS",rows[i].getString(colNm_BUR_TRANS),this);
										StringUtil.printMsg("colNm_OSV_PVR",rows[i].getString(colNm_OSV_PVR),this);
										StringUtil.printMsg("colNm_CON_NOTE",rows[i].getString(colNm_CON_NOTE),this);
										*/
										
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setString(1, rows[i].getString(colNm_CON_STATUS));	
										cstmt.setString(2, rows[i].getString(colNm_DATE_CON));
										cstmt.setString(3, rows[i].getString(colNm_CON_NO));
										cstmt.setInt(4, rows[i].getInt(colNm_CON_SID));	
										cstmt.setInt(5, rows[i].getInt(colNm_EST_SID));
										cstmt.setString(6, rows[i].getString(colNm_RQST_DATE));
										cstmt.setString(7, rows[i].getString(colNm_RQST_NO));
										cstmt.setInt(8, rows[i].getInt(colNm_RQST_SID));
										//cstmt.setInt(9, rows[i].getInt(colNm_DG_SUM_AMT));
										//cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
										cstmt.setString(9, rows[i].getString(colNm_SITE_CD));	
										cstmt.setString(10, rows[i].getString(colNm_PU_EMPNO));
										cstmt.setString(11, rows[i].getString(colNm_SITE_NM));
										cstmt.setInt(12, rows[i].getInt(colNm_SITE_SID));
										cstmt.setString(13, rows[i].getString(colNm_RQST_USE));
										cstmt.setString(14, rows[i].getString(colNm_DATE_DDL));
										cstmt.setString(15, rows[i].getString(colNm_PUT_WH));
										cstmt.setString(16, rows[i].getString(colNm_TERMS_TRANS));
										cstmt.setString(17, rows[i].getString(colNm_WAY_CHK));
										cstmt.setString(18, rows[i].getString(colNm_TERMS_PAY));	
										cstmt.setString(19, rows[i].getString(colNm_BUR_TRANS));
										cstmt.setString(20, rows[i].getString(colNm_OSV_PVR));
										cstmt.setString(21, rows[i].getString(colNm_CON_NOTE));
										cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT_RATE));	
										//cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT));
										cstmt.setInt(23, rows[i].getInt(colNm_CH_RATE));	
										//cstmt.setInt(23, rows[i].getInt(colNm_CH_AMT));
										cstmt.setInt(24, rows[i].getInt(colNm_DB_RATE));	
										//cstmt.setInt(24, rows[i].getInt(colNm_DB_AMT));
										cstmt.setString(25, rows[i].getString(colNm_TERM_GRN));
										cstmt.setString(26, rows[i].getString(colNm_BON_EMPNO));
										cstmt.setString(27, rows[i].getString(colNm_BON_EMPNM));
										cstmt.setString(28, iParamEmpno);
										cstmt.setString(29, iParamIp);
										cstmt.setString(30, "1");
													
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();						
										break;
									case GauceDataRow.TB_JOB_UPDATE:
										
										/*	
										StringUtil.printMsg("call","PMS.PR_UPDATE",this);
										StringUtil.printMsg("colNm_CON_STATUS",rows[i].getString(colNm_CON_STATUS),this);
										StringUtil.printMsg("colNm_DATE_CON",rows[i].getString(colNm_DATE_CON),this);
										StringUtil.printMsg("colNm_NO_CON",rows[i].getString(colNm_CON_NO),this);
										StringUtil.printMsg("colNm_CON_SID",rows[i].getString(colNm_CON_SID),this);
										StringUtil.printMsg("colNm_EST_SID",rows[i].getString(colNm_EST_SID),this);
										StringUtil.printMsg("colNm_RQST_DATE",rows[i].getString(colNm_RQST_DATE),this);
										StringUtil.printMsg("colNm_RQST_NO",rows[i].getString(colNm_RQST_NO),this);
										StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
										StringUtil.printMsg("colNm_SITE_CD",rows[i].getString(colNm_SITE_CD),this);
										StringUtil.printMsg("colNm_PU_EMPNO",rows[i].getString(colNm_PU_EMPNO),this);
										StringUtil.printMsg("colNm_SITE_NM",rows[i].getString(colNm_SITE_NM),this);
										StringUtil.printMsg("colNm_SITE_SID",rows[i].getString(colNm_SITE_SID),this);
										StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
										StringUtil.printMsg("colNm_DATE_DDL",rows[i].getString(colNm_DATE_DDL),this);
										StringUtil.printMsg("colNm_PUT_WH",rows[i].getString(colNm_PUT_WH),this);
										StringUtil.printMsg("colNm_TERMS_TRANS",rows[i].getString(colNm_TERMS_TRANS),this);
										StringUtil.printMsg("colNm_WAY_CHK",rows[i].getString(colNm_WAY_CHK),this);
										StringUtil.printMsg("colNm_TERMS_PAY",rows[i].getString(colNm_TERMS_PAY),this);
										StringUtil.printMsg("colNm_BUR_TRANS",rows[i].getString(colNm_BUR_TRANS),this);
										StringUtil.printMsg("colNm_OSV_PVR",rows[i].getString(colNm_OSV_PVR),this);
										StringUtil.printMsg("colNm_CON_NOTE",rows[i].getString(colNm_CON_NOTE),this);
										StringUtil.printMsg("colNm_PREPAY_AMT_RATE",rows[i].getString(colNm_PREPAY_AMT_RATE),this);
										StringUtil.printMsg("colNm_PREPAY_AMT",rows[i].getString(colNm_PREPAY_AMT),this);
										StringUtil.printMsg("colNm_CH_RATE",rows[i].getString(colNm_CH_RATE),this);
										StringUtil.printMsg("colNm_CH_AMT",rows[i].getString(colNm_CH_AMT),this);
										StringUtil.printMsg("colNm_DB_RATE",rows[i].getString(colNm_DB_RATE),this);
										StringUtil.printMsg("colNm_DB_AMT",rows[i].getString(colNm_DB_AMT),this);
										StringUtil.printMsg("colNm_TERM_GRN",rows[i].getString(colNm_TERM_GRN),this);
										StringUtil.printMsg("colNm_TOT_FN_EST_AMT",rows[i].getString(colNm_TOT_FN_EST_AMT),this);
										*/
																							
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setString(1, rows[i].getString(colNm_CON_STATUS));	
										cstmt.setString(2, rows[i].getString(colNm_DATE_CON));
										cstmt.setString(3, rows[i].getString(colNm_CON_NO));
										cstmt.setInt(4, rows[i].getInt(colNm_CON_SID));	
										cstmt.setInt(5, rows[i].getInt(colNm_EST_SID));
										cstmt.setString(6, rows[i].getString(colNm_RQST_DATE));
										cstmt.setString(7, rows[i].getString(colNm_RQST_NO));
										cstmt.setInt(8, rows[i].getInt(colNm_RQST_SID));
										//cstmt.setInt(9, rows[i].getInt(colNm_DG_SUM_AMT));
										//cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
										cstmt.setString(9, rows[i].getString(colNm_SITE_CD));	
										cstmt.setString(10, rows[i].getString(colNm_PU_EMPNO));
										cstmt.setString(11, rows[i].getString(colNm_SITE_NM));
										cstmt.setInt(12, rows[i].getInt(colNm_SITE_SID));
										cstmt.setString(13, rows[i].getString(colNm_RQST_USE));
										cstmt.setString(14, rows[i].getString(colNm_DATE_DDL));
										cstmt.setString(15, rows[i].getString(colNm_PUT_WH));
										cstmt.setString(16, rows[i].getString(colNm_TERMS_TRANS));
										cstmt.setString(17, rows[i].getString(colNm_WAY_CHK));
										cstmt.setString(18, rows[i].getString(colNm_TERMS_PAY));	
										cstmt.setString(19, rows[i].getString(colNm_BUR_TRANS));
										cstmt.setString(20, rows[i].getString(colNm_OSV_PVR));
										cstmt.setString(21, rows[i].getString(colNm_CON_NOTE));
										cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT_RATE));	
										//cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT));
										cstmt.setInt(23, rows[i].getInt(colNm_CH_RATE));	
										//cstmt.setInt(23, rows[i].getInt(colNm_CH_AMT));
										cstmt.setInt(24, rows[i].getInt(colNm_DB_RATE));	
										//cstmt.setInt(24, rows[i].getInt(colNm_DB_AMT));
										cstmt.setString(25, rows[i].getString(colNm_TERM_GRN));
										cstmt.setString(26, rows[i].getString(colNm_BON_EMPNO));
										cstmt.setString(27, rows[i].getString(colNm_BON_EMPNM));
										cstmt.setString(28, iParamEmpno);
										cstmt.setString(29, iParamIp);
										cstmt.setString(30, "3");
										
				
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();	
										break;
									case GauceDataRow.TB_JOB_DELETE:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
										cstmt = conn.prepareCall(arr_sql[5].toString());
									
										cstmt.setString(1, rows[i].getString(colNm_CON_STATUS));	
										cstmt.setString(2, rows[i].getString(colNm_DATE_CON));
										cstmt.setString(3, rows[i].getString(colNm_CON_NO));
										cstmt.setInt(4, rows[i].getInt(colNm_CON_SID));	
										cstmt.setInt(5, rows[i].getInt(colNm_EST_SID));
										cstmt.setString(6, rows[i].getString(colNm_RQST_DATE));
										cstmt.setString(7, rows[i].getString(colNm_RQST_NO));
										cstmt.setInt(8, rows[i].getInt(colNm_RQST_SID));
										//cstmt.setInt(9, rows[i].getInt(colNm_DG_SUM_AMT));
										//cstmt.setInt(10, rows[i].getInt(colNm_YS_SUM_AMT));
										cstmt.setString(9, rows[i].getString(colNm_SITE_CD));	
										cstmt.setString(10, rows[i].getString(colNm_PU_EMPNO));
										cstmt.setString(11, rows[i].getString(colNm_SITE_NM));
										cstmt.setInt(12, rows[i].getInt(colNm_SITE_SID));
										cstmt.setString(13, rows[i].getString(colNm_RQST_USE));
										cstmt.setString(14, rows[i].getString(colNm_DATE_DDL));
										cstmt.setString(15, rows[i].getString(colNm_PUT_WH));
										cstmt.setString(16, rows[i].getString(colNm_TERMS_TRANS));
										cstmt.setString(17, rows[i].getString(colNm_WAY_CHK));
										cstmt.setString(18, rows[i].getString(colNm_TERMS_PAY));	
										cstmt.setString(19, rows[i].getString(colNm_BUR_TRANS));
										cstmt.setString(20, rows[i].getString(colNm_OSV_PVR));
										cstmt.setString(21, rows[i].getString(colNm_CON_NOTE));
										cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT_RATE));	
										//cstmt.setInt(22, rows[i].getInt(colNm_PREPAY_AMT));
										cstmt.setInt(23, rows[i].getInt(colNm_CH_RATE));	
										//cstmt.setInt(23, rows[i].getInt(colNm_CH_AMT));
										cstmt.setInt(24, rows[i].getInt(colNm_DB_RATE));	
										//cstmt.setInt(24, rows[i].getInt(colNm_DB_AMT));
										cstmt.setString(25, rows[i].getString(colNm_TERM_GRN));
										cstmt.setString(26, rows[i].getString(colNm_BON_EMPNO));
										cstmt.setString(27, rows[i].getString(colNm_BON_EMPNM));
										cstmt.setString(28, iParamEmpno);
										cstmt.setString(29, iParamIp);
										cstmt.setString(30, "2");
										
												
										if(cstmt!=null) cstmt.close();	
										break;						
							}
				}
			}	//if (ds1 != null) {
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
			// if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}