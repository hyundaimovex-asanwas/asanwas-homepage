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

public class Pu020I_20131126 extends SuperServlet {

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU020I_01(?,?,?) }" );

		//������ ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU020I_02(?) }" );

		//Main ����
		arr_sql[2].append ("{call PMS.PR_PU020I_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?) }");
		//Detail ����
		arr_sql[3].append ("{call PMS.PR_PU020I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?) }");

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
						cstmt.setString(1, "19990101");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "2");
					} else if(gauceName.equals("DS_TENDER")){
						//StringUtil.printMsg("DS DS_TENDER","����ȸ",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 0);
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
						String v_fr_rqst_date 	= HDUtil.nullCheckStr(req.getParameter("v_fr_rqst_date")); 	// ��û���� ����
						String v_to_rqst_date	= HDUtil.nullCheckStr(req.getParameter("v_to_rqst_date")); 	// ��û���� ����
						String v_rqst_status		= HDUtil.nullCheckStr(req.getParameter("v_rqst_status")); 	// ��û����

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
					} else if(gauceName.equals("DS_TENDER")){
						int v_rqst_sid = HDUtil.nullCheckNum(req.getParameter("v_rqst_sid"));			// ���� SID
						StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
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
					
//		int fSiteSid = 0;
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
					
				int colNm_RQST_STATUS    = ds1.indexOfColumn("RQST_STATUS");	//û������
				int colNm_AC_DATE        		= ds1.indexOfColumn("AC_DATE"); 			//��������
				int colNm_RQST_DATE        = ds1.indexOfColumn("RQST_DATE"); 		//û������
				//int colNm_RQST_NO      		= ds1.indexOfColumn("RQST_NO");  		// û����ȣ
				int colNm_RQST_SID       	= ds1.indexOfColumn("RQST_SID"); 		//û��SID
				int colNm_SITE_CD    			= ds1.indexOfColumn("SITE_CD"); 			//�����ڵ�
				int colNm_PU_EMPNO	    	= ds1.indexOfColumn("PU_EMPNO"); 		//�������ڻ��
				int colNm_SITE_NM     		= ds1.indexOfColumn("SITE_NM");    		//�����
				int colNm_SITE_SID       		= ds1.indexOfColumn("SITE_SID");     		//����SID
				int colNm_RQST_USE        	= ds1.indexOfColumn("RQST_USE");  		//���ó
				int colNm_RQST_SEQ    		= ds1.indexOfColumn("RQST_SEQ");		//��ü����	
				int colNm_RQSTAC_MEMO 	= ds1.indexOfColumn("RQSTAC_MEMO"); //����Ư�����
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
							cstmt.setString(2, rows[i].getString(colNm_AC_DATE));
							cstmt.setString(3, rows[i].getString(colNm_RQST_DATE));
							cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
							cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
							cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
							cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
							cstmt.setString(10, rows[i].getString(colNm_RQST_SEQ));
							cstmt.setString(11, rows[i].getString(colNm_RQSTAC_MEMO));							
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "1");
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
							cstmt.setString(2, rows[i].getString(colNm_AC_DATE));
							cstmt.setString(3, rows[i].getString(colNm_RQST_DATE));
							cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
							cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
							cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
							cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
							cstmt.setString(10, rows[i].getString(colNm_RQST_SEQ));
							cstmt.setString(11, rows[i].getString(colNm_RQSTAC_MEMO));							
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "3");
							
							
					
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
							cstmt.setString(2, rows[i].getString(colNm_AC_DATE));
							cstmt.setString(3, rows[i].getString(colNm_RQST_DATE));
							cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
							cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
							cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
							cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
							cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
							cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
							cstmt.setString(10, rows[i].getString(colNm_RQST_SEQ));
							cstmt.setString(11, rows[i].getString(colNm_RQSTAC_MEMO));							
							cstmt.setString(12, iParamEmpno);
							cstmt.setString(13, iParamIp);
							cstmt.setString(14, "2");
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
					}//switch(rows[i].getJobType()){
				}
			}//if (ds1 != null) {
			
			if (ds2 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
					
			
				int colNm_RQST_SID	      	= ds2.indexOfColumn("RQST_SID");	       	// û�� SID
				int colNm_ITEM_SID      		= ds2.indexOfColumn("ITEM_SID");       	// ǰ�� SID
				int colNm_ITEM_NM        		= ds2.indexOfColumn("ITEM_NM");  			// ǰ��
				int colNm_ITEM_SIZE			= ds2.indexOfColumn("ITEM_SIZE");			// �԰�
				int colNm_ITEM_UNIT			= ds2.indexOfColumn("ITEM_UNIT");			// ����
				int colNm_RQST_CNT  		= ds2.indexOfColumn("RQST_CNT");    	// ����
				int colNm_RQST_USE      	= ds2.indexOfColumn("RQST_USE");       	// �뵵
				int colNm_DATE_USE 			= ds2.indexOfColumn("DATE_USE");   		// �ҿ���
				int colNm_RQST_NOTE 		= ds2.indexOfColumn("RQST_NOTE");   	// û�����
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setString(7, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(8, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(9, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(10, iParamEmpno);
						cstmt.setString(11, iParamIp);
						cstmt.setString(12, "1");
									
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
							
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setString(7, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(8, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(9, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(10, iParamEmpno);
						cstmt.setString(11, iParamIp);
						cstmt.setString(12, "3");

						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setString(7, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(8, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(9, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(10, iParamEmpno);
						cstmt.setString(11, iParamIp);
						cstmt.setString(12, "2");
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}	//if (ds2 != null) {
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
//				if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			//if( fail == true ) throw new Exception("");			
		}
	}
}