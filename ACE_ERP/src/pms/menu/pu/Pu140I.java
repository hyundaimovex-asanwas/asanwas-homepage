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

public class Pu140I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU140I_01(?,?,?,?) }" );

		//TENDER ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU040I_02(?,?,?) }" );

		//Main ����
		arr_sql[2].append ("{call PMS.PR_PU040I_03(?,?,?,?,?,   ?,?,?) }");
		
		//Tender ����
		arr_sql[3].append ("{call PMS.PR_PU040I_04(?,?,?,?,?,   ?,?,?,?,?) }");

		//Detail ����
			arr_sql[6].append ("{call PMS.PR_PU040I_06(?,?,?,?,?,   ?,?,?) }");
	
		//DETAIL ��ȸ
		arr_sql[4].append ("{call PMS.PR_PU040I_05(?,?,?) }" );
		//EST ��ȸ
		arr_sql[5].append ("{call PMS.PR_PU040I_07(?,?) }" );
		//EST ����
		arr_sql[7].append ("{call PMS.PR_PU040I_08(?,?,?,?,?            ,?,?,?) }" );

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
				//		cstmt.setInt(1, 1);
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
						cstmt = conn.prepareCall(arr_sql[5].toString());
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
					//StringUtil.printMsg("DS DS_TENDER","����ȸ",this);
					cstmt = conn.prepareCall(arr_sql[4].toString());
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
					//	int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// ���� SID
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
						cstmt = conn.prepareCall(arr_sql[5].toString());
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
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// û�� SID
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				//���� SID
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.setInt(2, v_est_sid);
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
		GauceDataSet ds4 = gis.read("DS_EST");
					
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				int colNm_RQST_SID       	= ds1.indexOfColumn("RQST_SID"); 		//û��SID
				int colNm_EST_EMPNO      	= ds1.indexOfColumn("EST_EMPNO");		//��������ڻ��
				int colNm_DATE_TO        	= ds1.indexOfColumn("DATE_TO"); 			//������������
				int colNm_EST_MEMO        	= ds1.indexOfColumn("EST_MEMO"); 		//����Ư�����
				
					
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();		
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
						case GauceDataRow.TB_JOB_DELETE:
							//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
								
							
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
					
			
				int colNm_USE_YN		      	= ds2.indexOfColumn("USE_YN");	  	     	// û�� SID
				int colNm_EST_SID      		= ds2.indexOfColumn("EST_SID");    	   	// ���� SID
				int colNm_RQST_SID      		= ds2.indexOfColumn("RQST_SID");       	// û�� SID
				int colNm_ITEM_SID      		= ds2.indexOfColumn("ITEM_SID");       	// ǰ�� SID
				int colNm_RQST_CNT      	= ds2.indexOfColumn("RQST_CNT");  		// ����
				int colNm_RQST_NOTE		= ds2.indexOfColumn("RQST_NOTE");		// û��ǰ�񺰺��
				int colNm_EST_ITEM_NOTE		= ds2.indexOfColumn("EST_ITEM_NOTE");		// ����ǰ�񺰺��
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					
					if((rows[i].getString(ds2.indexOfColumn("USE_YN")).equals("T"))){
					
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
										cstmt = conn.prepareCall(arr_sql[3].toString());
									
										cstmt.setString(1, rows[i].getString(colNm_USE_YN));
										cstmt.setInt(2, rows[i].getInt(colNm_EST_SID));
										cstmt.setInt(3, rows[i].getInt(colNm_RQST_SID));
										cstmt.setInt(4, rows[i].getInt(colNm_ITEM_SID));
										cstmt.setInt(5, rows[i].getInt(colNm_RQST_CNT));	
										cstmt.setString(6, rows[i].getString(colNm_RQST_NOTE));	
										cstmt.setString(7, rows[i].getString(colNm_EST_ITEM_NOTE));
										cstmt.setString(8, iParamEmpno);
										cstmt.setString(9, iParamIp);
										cstmt.setString(10, "1");
													
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();						
					}
				}
			}	//if (ds2 != null) {
			if (ds4 != null) {
	//			StringUtil.printMsg("ds4","ds4",this);
				GauceDataRow[] 		rows = ds4.getDataRows();
				GauceDataColumn[] 	cols = ds4.getDataColumns();
					
				int colNm_EST_SID      		= ds4.indexOfColumn("EST_SID");    	   	// ���� SID
				int colNm_RQST_SID      		= ds4.indexOfColumn("RQST_SID");       	// û�� SID
				int colNm_EST_EMPNO  		= ds4.indexOfColumn("EST_EMPNO");    	// ��������ڻ��
				int colNm_DATE_TO      		= ds4.indexOfColumn("DATE_TO");       	// ����������������
				int colNm_EST_MEMO    		= ds4.indexOfColumn("EST_MEMO");     	// ����Ư�����
				
	//			StringUtil.printMsg("colNm_EST_SID",colNm_EST_SID,this);
	//			StringUtil.printMsg("colNm_RQST_SID",colNm_RQST_SID,this);

				for(int i=0; i<rows.length; i++){
							int j=1;
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
										cstmt = conn.prepareCall(arr_sql[7].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_RQST_SID));
										cstmt.setString(3, rows[i].getString(colNm_EST_EMPNO));
										cstmt.setString(4, rows[i].getString(colNm_DATE_TO));
										cstmt.setString(5, rows[i].getString(colNm_EST_MEMO));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "1");
													
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();						
										break;
									case GauceDataRow.TB_JOB_UPDATE:
											
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
										cstmt = conn.prepareCall(arr_sql[7].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_RQST_SID));
										cstmt.setString(3, rows[i].getString(colNm_EST_EMPNO));
										cstmt.setString(4, rows[i].getString(colNm_DATE_TO));
										cstmt.setString(5, rows[i].getString(colNm_EST_MEMO));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "1");
										
				
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();	
										break;
									case GauceDataRow.TB_JOB_DELETE:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
										cstmt = conn.prepareCall(arr_sql[7].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setInt(2, rows[i].getInt(colNm_RQST_SID));
										cstmt.setString(3, rows[i].getString(colNm_EST_EMPNO));
										cstmt.setString(4, rows[i].getString(colNm_DATE_TO));
										cstmt.setString(5, rows[i].getString(colNm_EST_MEMO));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "2");
										
										if(cstmt!=null) cstmt.close();	
										break;			
							}//switch(rows[i].getJobType()){
						}
			}
			if (ds3 != null) {
				//StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
					
			
				int colNm_EST_SID      		= ds3.indexOfColumn("EST_SID");    	   	// ���� SID
				int colNm_VEND_CD      		= ds3.indexOfColumn("VEND_CD");       	// �ŷ�ó�ڵ�
				int colNm_VEND_NM      		= ds3.indexOfColumn("VEND_NM");       	// �ŷ�ó��
				int colNm_VEND_ID      		= ds3.indexOfColumn("VEND_ID");       		// ����ڹ�ȣ
				int colNm_VD_DIRECT			= ds3.indexOfColumn("VD_DIRECT");		// ��ǥ
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					
							int j=1;
							switch(rows[i].getJobType()){
									case GauceDataRow.TB_JOB_INSERT:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
										cstmt = conn.prepareCall(arr_sql[6].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setString(2, rows[i].getString(colNm_VEND_CD));	
										cstmt.setString(3, rows[i].getString(colNm_VEND_NM));
										cstmt.setString(4, rows[i].getString(colNm_VEND_ID));
										cstmt.setString(5, rows[i].getString(colNm_VD_DIRECT));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "1");
													
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();						
										break;
									case GauceDataRow.TB_JOB_UPDATE:
											
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
										cstmt = conn.prepareCall(arr_sql[6].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setString(2, rows[i].getString(colNm_VEND_CD));	
										cstmt.setString(3, rows[i].getString(colNm_VEND_NM));
										cstmt.setString(4, rows[i].getString(colNm_VEND_ID));
										cstmt.setString(5, rows[i].getString(colNm_VD_DIRECT));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "3");
				
										cstmt.executeUpdate();
										
										if(cstmt!=null) cstmt.close();	
										break;
									case GauceDataRow.TB_JOB_DELETE:
										//StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
										cstmt = conn.prepareCall(arr_sql[6].toString());
									
										cstmt.setInt(1, rows[i].getInt(colNm_EST_SID));	
										cstmt.setString(2, rows[i].getString(colNm_VEND_CD));	
										cstmt.setString(3, rows[i].getString(colNm_VEND_NM));
										cstmt.setString(4, rows[i].getString(colNm_VEND_ID));
										cstmt.setString(5, rows[i].getString(colNm_VD_DIRECT));
										cstmt.setString(6, iParamEmpno);
										cstmt.setString(7, iParamIp);
										cstmt.setString(8, "2");
										
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