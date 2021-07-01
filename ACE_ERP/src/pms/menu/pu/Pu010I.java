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

public class Pu010I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU010I_01(?,?,?,?,?   ,?) }" );

		//Detail ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU010I_02(?,?) }" );

		//Main ����
		arr_sql[2].append ("{call PMS.PR_PU010I_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?            ,?) }");
		//Detail ����
		arr_sql[3].append ("{call PMS.PR_PU010I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?  ,?,?,?) }");

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
			   		//StringUtil.printMsg("O:DS_DEFAULT TYPE","����ȸ",this);
		   			GauceDataSet ds1 = gis.read("DS_DEFAULT");
		   			cstmt = conn.prepareCall(arr_sql[0].toString());
		   			cstmt.setString(1, "6080001");
					cstmt.setInt(2,209);
					cstmt.setString(3, "20111111");
					cstmt.setString(4, "20131111");
					cstmt.setString(5, "2");
					// ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 			
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
			   	}
				if(dSets[i].getName().equals("ds_tender")){
					//StringUtil.printMsg("DS_TENDER TYPE","����ȸ",this);
					GauceDataSet ds1 = gis.read("DS_TENDER");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
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
						String sNowEmpno		= HDUtil.nullCheckStr(greq.getParameter("v_empno"));			// �α���
						int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// ���� SID
						String v_fr_rqst_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_rqst_date")); 	// ��û���� ����
						String v_to_rqst_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_rqst_date")); 	// ��û���� ����
						String v_rqst_status	= HDUtil.nullCheckStr(greq.getParameter("v_rqst_status")); 		// ��û����
						/*
						StringUtil.printMsg("sNowEmpno",sNowEmpno,this);
						StringUtil.printMsg("v_site_sid",v_site_sid,this);
						StringUtil.printMsg("v_fr_rqst_date",v_fr_rqst_date,this);
						StringUtil.printMsg("v_to_rqst_date",v_to_rqst_date,this);
						StringUtil.printMsg("v_rqst_status",v_rqst_status,this);
						*/
						
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, sNowEmpno);	
						cstmt.setInt(2, v_site_sid);
						cstmt.setString(3, v_fr_rqst_date);
						cstmt.setString(4, v_to_rqst_date);
						cstmt.setString(5, v_rqst_status);
						cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 			
						//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
						//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// ���� SID
						GauceDataSet ds1 = gis.read("DS_TENDER");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
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
		GauceDataSet rqstNoDS = gis.read("rqstNoDS");
					
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				int colNm_RQST_STATUS    	= ds1.indexOfColumn("RQST_STATUS");	//û������
				int colNm_RQST_DATE        	= ds1.indexOfColumn("RQST_DATE"); 		//û������
				int colNm_RQST_NO      		= ds1.indexOfColumn("RQST_NO");  		// û����ȣ
				int colNm_RQST_SID       	= ds1.indexOfColumn("RQST_SID"); 		//û��SID
				int colNm_SITE_CD    		= ds1.indexOfColumn("SITE_CD"); 			//�����ڵ�
				int colNm_PU_EMPNO	    	= ds1.indexOfColumn("PU_EMPNO"); 		//�������ڻ��
				int colNm_SITE_NM     		= ds1.indexOfColumn("SITE_NM");    		//�����
				int colNm_SITE_SID       	= ds1.indexOfColumn("SITE_SID");     		//����SID
				int colNm_RQST_USE        	= ds1.indexOfColumn("RQST_USE");  		//���ó
				int colNm_RQST_MEMO 		= ds1.indexOfColumn("RQST_MEMO");  	// û��Ư�̻���
				int colNm_PUT_WH    		= ds1.indexOfColumn("PUT_WH"); 			//����â��
				
				String v_sys_file 	= HDUtil.nullCheckStr(greq.getParameter("sSysFile")); 	// ÷������system
				String v_real_file	= HDUtil.nullCheckStr(greq.getParameter("sRealFile")); 	// ÷������real
					
				//res.enableFirstRow(rqstNoDS);
			    //rqstNoDS.addDataColumn(new GauceDataColumn("RQST_NO", GauceDataColumn.TB_STRING));

				for(int i=0; i<rows.length; i++){
					int j=1;
					//StringUtil.printMsg("ds2�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
						/*
						StringUtil.printMsg("call","PMS.PR_PU010i_04-INSERT",this);
						StringUtil.printMsg("colNm_RQST_STATUS",rows[i].getString(colNm_RQST_STATUS),this);
						StringUtil.printMsg("colNm_RQST_DATE",rows[i].getString(colNm_RQST_DATE),this);
						StringUtil.printMsg("colNm_RQST_NO",rows[i].getString(colNm_RQST_NO),this);
						StringUtil.printMsg("colNm_RQST_SID",rows[i].getString(colNm_RQST_SID),this);
						StringUtil.printMsg("colNm_SITE_CD",rows[i].getString(colNm_SITE_CD),this);
						StringUtil.printMsg("colNm_PU_EMPNO",rows[i].getString(colNm_PU_EMPNO),this);
						StringUtil.printMsg("colNm_SITE_NM",rows[i].getString(colNm_SITE_NM),this);
						StringUtil.printMsg("colNm_SITE_SID",rows[i].getString(colNm_SITE_SID),this);
						StringUtil.printMsg("colNm_RQST_USE",rows[i].getString(colNm_RQST_USE),this);
						StringUtil.printMsg("colNm_RQST_MEMO",rows[i].getString(colNm_RQST_MEMO),this);
						StringUtil.printMsg("colNm_PUT_WH",rows[i].getString(colNm_PUT_WH),this);
						StringUtil.printMsg("v_sys_file",v_sys_file,this);
						StringUtil.printMsg("v_real_file",v_real_file,this);
						*/
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
						cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
						cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
						cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
						cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
						cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
						cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
						cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
						cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
						cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
						cstmt.setString(12, v_real_file);
						cstmt.setString(13, v_sys_file);
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "1");
							
						cstmt.executeUpdate();
				
						if(cstmt!=null) cstmt.close();		
						break;
						
						case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
								
						cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
						cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
						cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
						cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
						cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
						cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
						cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
						cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
						cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
						cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
						cstmt.setString(12, v_real_file);
						cstmt.setString(13, v_sys_file);
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "3");
					
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
						break;
				
						case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
								
						cstmt.setString(1, rows[i].getString(colNm_RQST_STATUS));
						cstmt.setString(2, rows[i].getString(colNm_RQST_DATE));
						cstmt.setString(3, rows[i].getString(colNm_RQST_NO));
						cstmt.setInt(4, rows[i].getInt(colNm_RQST_SID));
						cstmt.setString(5, rows[i].getString(colNm_SITE_CD));
						cstmt.setString(6, rows[i].getString(colNm_PU_EMPNO));
						cstmt.setString(7, rows[i].getString(colNm_SITE_NM));
						cstmt.setInt(8, rows[i].getInt(colNm_SITE_SID));
						cstmt.setString(9, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(10, rows[i].getString(colNm_RQST_MEMO));
						cstmt.setString(11, rows[i].getString(colNm_PUT_WH));
						cstmt.setString(12, v_real_file);
						cstmt.setString(13, v_sys_file);
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "2");
						
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
				int colNm_ITEM_SID      	= ds2.indexOfColumn("ITEM_SID");       	// ǰ�� SID
				int colNm_ITEM_NM        	= ds2.indexOfColumn("ITEM_NM");  			// ǰ��
				int colNm_ITEM_SIZE			= ds2.indexOfColumn("ITEM_SIZE");			// �԰�
				int colNm_ITEM_UNIT			= ds2.indexOfColumn("ITEM_UNIT");			// ����
				int colNm_RQST_CNT  		= ds2.indexOfColumn("RQST_CNT");    	// ����
				int colNm_DG_AMT  			= ds2.indexOfColumn("DG_AMT");    	// ���޴ܰ�
				int colNm_DG_SUM_AMT  		= ds2.indexOfColumn("DG_SUM_AMT");    	// ���޾�
				int colNm_YS_AMT  			= ds2.indexOfColumn("YS_AMT");    	// ����ܰ�
				int colNm_YS_SUM_AMT  		= ds2.indexOfColumn("YS_SUM_AMT");    	// �����
				int colNm_RQST_USE      	= ds2.indexOfColumn("RQST_USE");       	// �뵵
				int colNm_DATE_USE 			= ds2.indexOfColumn("DATE_USE");   		// �ҿ���
				int colNm_RQST_NOTE 		= ds2.indexOfColumn("RQST_NOTE");   	// û�����
				int colNm_DG_CNT  			= ds2.indexOfColumn("DG_CNT");    	// ���޼���
				int colNm_ITEM_SEQ 			= ds2.indexOfColumn("ITEM_SEQ");   	// ǰ�� ����
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
						/*
						//StringUtil.printMsg("call","PMS.PR_CT010i_04-INSERT",this);
						//StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
						//StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						//StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
						//StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
						//StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
						//StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
						//StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
						*/
						//StringUtil.printMsg("colNm_DG_CNT",rows[i].getInt(colNm_DG_CNT),this);
						//StringUtil.printMsg("colNm_ITEM_SEQ",rows[i].getInt(colNm_ITEM_SEQ),this);
						
						cstmt = conn.prepareCall(arr_sql[3].toString());
					
						cstmt.setInt(1, rows[i].getInt(colNm_RQST_SID));
						cstmt.setInt(2, rows[i].getInt(colNm_ITEM_SID));
						cstmt.setString(3, rows[i].getString(colNm_ITEM_NM));
						cstmt.setString(4, rows[i].getString(colNm_ITEM_SIZE));
						cstmt.setString(5, rows[i].getString(colNm_ITEM_UNIT));	
						cstmt.setInt(6, rows[i].getInt(colNm_RQST_CNT));	
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "1");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));
						
									
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
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "3");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));
						
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
						cstmt.setLong(7, rows[i].getLong(colNm_DG_AMT));
						cstmt.setLong(8, rows[i].getLong(colNm_DG_SUM_AMT));
						cstmt.setLong(9, rows[i].getLong(colNm_YS_AMT));
						cstmt.setLong(10, rows[i].getLong(colNm_YS_SUM_AMT));
						cstmt.setString(11, rows[i].getString(colNm_RQST_USE));
						cstmt.setString(12, rows[i].getString(colNm_DATE_USE));	
						cstmt.setString(13, rows[i].getString(colNm_RQST_NOTE));	
						cstmt.setString(14, iParamEmpno);
						cstmt.setString(15, iParamIp);
						cstmt.setString(16, "2");
						cstmt.setInt(17, rows[i].getInt(colNm_DG_CNT));
						cstmt.setInt(18, rows[i].getInt(colNm_ITEM_SEQ));				
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}	//if (ds2 != null) {
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