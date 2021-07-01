package pms.menu.ct;

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

public class Ct013I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//	DS1 ��ȸ : ����ں� ��� ����
				arr_sql[1].append ("{call PMS.PR_CT013I_01(?,?)}");
   }

	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		//StringUtil.printMsg("v_orderer_nm",v_orderer_nm,this);
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds_site_emp")){
					GauceDataSet ds1 = gis.read("DS_SITE_EMP");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, fParamEmpno);
					StringUtil.printMsg(" �α��� ����� ", fParamEmpno,this);		
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 999999999);
					cstmt.setInt(2, 999999999);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}				
            	if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, 999999999);
					cstmt.setInt(2, 999999999);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}				

			}
		}catch (SQLException sqle){
		} catch (Exception e){
		} finally {
		}
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

		try {
            
            //String paramDEPTNO = greq.getParameter("goods_cd");	//�׽�Ʈ �Ķ����
            //int tree_idx = HDUtil.nullCheckNum(greq.getParameter("tree_idx"));
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			//String menu_nm = "";
			//String full_dir_nm = "";
			
            for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds_site_emp")){
					GauceDataSet ds1 = gis.read("DS_SITE_EMP");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, fParamEmpno);
					StringUtil.printMsg(" �α��� ����� ", fParamEmpno,this);		

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setInt(2, v_orderer_sid);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}            	
            	if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setInt(2, v_orderer_sid);
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
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	���� gis.read�� �������� ��.
		 * 
		 * */
	
		StringUtil.printMsg("# Command","����",this);
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet ds3 = gis.read("DS3");
		
		int fSiteSid = 0;
	
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_SiteNm	  		        = ds1.indexOfColumn("site_nm");
				int colNm_OrdererNm                 = ds1.indexOfColumn("orderer_nm");
				int colNm_SiteSid  		            = ds1.indexOfColumn("site_sid");
				int colNm_SiteJoint              	= ds1.indexOfColumn("site_joint");
				int colNm_SiteMain              	= ds1.indexOfColumn("site_main");
				int colNm_SiteAttr1                	= ds1.indexOfColumn("site_attr1");
				int colNm_SiteAttr2                 = ds1.indexOfColumn("site_attr2");
				int colNm_OrdererSid                = ds1.indexOfColumn("orderer_sid");
				
				//StringUtil.printMsg("colNm_SiteNm",colNm_SiteNm,this);
				//StringUtil.printMsg("colNm_OrdererNm",colNm_OrdererNm,this);
				//StringUtil.printMsg("colNm_SiteSid",colNm_SiteSid,this);	
				//StringUtil.printMsg("colNm_SiteJoint",colNm_SiteJoint,this);
				//StringUtil.printMsg("colNm_SiteMain",colNm_SiteMain,this);
				//StringUtil.printMsg("colNm_SiteAttr1",colNm_SiteAttr1,this);
				//StringUtil.printMsg("colNm_SiteAttr2",colNm_SiteAttr2,this);
				//StringUtil.printMsg("colNm_OrdererSid",colNm_OrdererSid,this);
				
				for(int i=0; i<rows.length; i++){
			
					int j=1;
					
					StringUtil.printMsg("ds1�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					switch(rows[i].getJobType()){
			
					case GauceDataRow.TB_JOB_INSERT:
						StringUtil.printMsg("call","PMS.PR_CT010i_04-INSERT",this);
						/*
						StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
						StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
						StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
						StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
						StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
						StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
						StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
						*/
								
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_04(?,?,?,?,?   ,?,?,?,?,?,   ?) }");
			
						cstmt.setString(1, rows[i].getString(colNm_SiteNm));
						cstmt.setString(2, rows[i].getString(colNm_OrdererNm));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, rows[i].getString(colNm_SiteJoint));						
						cstmt.setString(5, rows[i].getString(colNm_SiteMain));
						cstmt.setString(6, rows[i].getString(colNm_SiteAttr1));
						cstmt.setString(7, rows[i].getString(colNm_SiteAttr2));
						cstmt.setInt(8, rows[i].getInt(colNm_OrdererSid));
						cstmt.setString(9, iParamEmpno);
						cstmt.setString(10, iParamIp);
						cstmt.setString(11, "1");
						
						cstmt.executeUpdate();
			
						if(cstmt!=null) cstmt.close();		
						
						cstmt = conn.prepareCall(arr_sql[13].toString());
			
						cstmt.setString(1, rows[i].getColumnValue(colNm_SiteNm)+"");
						rs = cstmt.executeQuery();

						if(rs.next()) {
							fSiteSid = rs.getInt(1);
						}
						rs.close();
						cstmt.close();				
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","PMS.PR_CT010i_04-UPDATE",this);
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_04(?,?,?,?,?   ,?,?,?,?,?,   ?) }");
						
						////StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						
						cstmt.setString(1, rows[i].getString(colNm_SiteNm));
						cstmt.setString(2, rows[i].getString(colNm_OrdererNm));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, rows[i].getString(colNm_SiteJoint));						
						cstmt.setString(5, rows[i].getString(colNm_SiteMain));
						cstmt.setString(6, rows[i].getString(colNm_SiteAttr1));
						cstmt.setString(7, rows[i].getString(colNm_SiteAttr2));
						cstmt.setInt(8, rows[i].getInt(colNm_OrdererSid));
						cstmt.setString(9, iParamEmpno);
						cstmt.setString(10, iParamIp);
						cstmt.setString(11, "3");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						StringUtil.printMsg("call","PMS.PR_CT010i_04-DELETE",this);
						//StringUtil.printMsg("colNm_SiteNm",rows[i].getString(colNm_SiteNm),this);
						//StringUtil.printMsg("colNm_OrdererNm",rows[i].getString(colNm_OrdererNm),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						//StringUtil.printMsg("colNm_SiteJoint",rows[i].getString(colNm_SiteJoint),this);
						//StringUtil.printMsg("colNm_SiteMain",rows[i].getString(colNm_SiteMain),this);
						//StringUtil.printMsg("colNm_SiteAttr1",rows[i].getString(colNm_SiteAttr1),this);
						//StringUtil.printMsg("colNm_SiteAttr2",rows[i].getString(colNm_SiteAttr2),this);
						//StringUtil.printMsg("colNm_OrdererSid",rows[i].getString(colNm_OrdererSid),this);
						
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_04(?,?,?,?,?   ,?,?,?,?,?,   ?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_SiteNm));
						cstmt.setString(2, rows[i].getString(colNm_OrdererNm));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, rows[i].getString(colNm_SiteJoint));						
						cstmt.setString(5, rows[i].getString(colNm_SiteMain));
						cstmt.setString(6, rows[i].getString(colNm_SiteAttr1));
						cstmt.setString(7, rows[i].getString(colNm_SiteAttr2));
						cstmt.setInt(8, rows[i].getInt(colNm_OrdererSid));
						cstmt.setString(9, iParamEmpno);
						cstmt.setString(10, iParamIp);
						cstmt.setString(11, "2");
							
						cstmt.executeUpdate();
							
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
			}
			if (ds2 != null) {
				StringUtil.printMsg("ds2","ds2",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
				GauceDataColumn[] 	cols = ds2.getDataColumns();
				
				int colNm_CoopSid	  		        = ds2.indexOfColumn("coop_sid");
				int colNm_SiteRate  	            = ds2.indexOfColumn("site_rate");
				int colNm_SiteSid  		            = ds2.indexOfColumn("site_sid");
				
				//StringUtil.printMsg("colNm_CoopSid",colNm_CoopSid,this);
				//StringUtil.printMsg("colNm_SiteRate",colNm_SiteRate,this);
				//StringUtil.printMsg("colNm_SiteSid",colNm_SiteSid,this);
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					
					case GauceDataRow.TB_JOB_INSERT:
						StringUtil.printMsg("call","PMS.PR_CT010i_05-INSERT",this);
						//StringUtil.printMsg("colNm_CoopSid",rows[i].getInt(colNm_CoopSid),this);
						//StringUtil.printMsg("colNm_SiteRate",rows[i].getInt(colNm_SiteRate),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getInt(colNm_SiteSid),this);
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_05(?,?,?,?,?   ,?) }");
						
						cstmt.setInt(1, rows[i].getInt(colNm_CoopSid));
						cstmt.setInt(2, rows[i].getInt(colNm_SiteRate));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "1");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//���ν��� �����ؾ� �մϴ�. - �̷��� ������Ʈ�� ����� �� ���� ������..~
						StringUtil.printMsg("call","PMS.PR_CT010i_05-UPDATE",this);
						//StringUtil.printMsg("colNm_CoopSid",rows[i].getString(colNm_CoopSid),this);
						//StringUtil.printMsg("colNm_SiteRate",rows[i].getString(colNm_SiteRate),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_05(?,?,?,?,?   ,?) }");
						
						cstmt.setInt(1, rows[i].getInt(colNm_CoopSid));
						cstmt.setInt(2, rows[i].getInt(colNm_SiteRate));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "3");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						StringUtil.printMsg("call","PMS.PR_CT010i_05-DELETE",this);
						//StringUtil.printMsg("colNm_CoopSid",rows[i].getString(colNm_CoopSid),this);
						//StringUtil.printMsg("colNm_SiteRate",rows[i].getString(colNm_SiteRate),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_05(?,?,?,?,?   ,?) }");
						
						cstmt.setInt(1, rows[i].getInt(colNm_CoopSid));
						cstmt.setInt(2, rows[i].getInt(colNm_SiteRate));
						cstmt.setInt(3, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(4, iParamEmpno);
						cstmt.setString(5, iParamIp);
						cstmt.setString(6, "2");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				//if(ds_result!=null) ds_result.flush();
			}
			if (ds3 != null) {
				StringUtil.printMsg("ds3","ds3",this);
				GauceDataRow[] 		rows = ds3.getDataRows();
				GauceDataColumn[] 	cols = ds3.getDataColumns();
				
				int colNm_SiteSeqCt	  		        = ds3.indexOfColumn("site_seq_ct");
				int colNm_SiteSeqCh	                = ds3.indexOfColumn("site_seq_ch");
				int colNm_SiteStatus  		        = ds3.indexOfColumn("site_status");
				int colNm_DateCt 		            = ds3.indexOfColumn("date_ct");
				int colNm_DateBegin	              	= ds3.indexOfColumn("date_begin");
				int colNm_DateEnd       	        = ds3.indexOfColumn("date_end");
				int colNm_AmtCt                		= ds3.indexOfColumn("amt_ct");
				int colNm_AmtCtVat	  			    = ds3.indexOfColumn("amt_ct_vat");
				int colNm_AmtCtTot          	    = ds3.indexOfColumn("amt_ct_tot");
				int colNm_Remarks	     	        = ds3.indexOfColumn("remarks");
				int colNm_DateMade		            = ds3.indexOfColumn("date_made");
				int colNm_SiteEno 	       		    = ds3.indexOfColumn("site_eno");
				int colNm_RateAc	            	= ds3.indexOfColumn("rate_ac");
				int colNm_SiteSid                	= ds3.indexOfColumn("site_sid");
				/*
				//StringUtil.printMsg("colNm_SiteSeqCt",colNm_SiteSeqCt,this);
				//StringUtil.printMsg("colNm_SiteSeqCh",colNm_SiteSeqCh,this);
				//StringUtil.printMsg("colNm_SiteStatus",colNm_SiteStatus,this);
				//StringUtil.printMsg("colNm_DateCt",colNm_DateCt,this);
				//StringUtil.printMsg("colNm_DateBegin",colNm_DateBegin,this);
				//StringUtil.printMsg("colNm_DateEnd",colNm_DateEnd,this);
				//StringUtil.printMsg("colNm_AmtCtTot",colNm_AmtCtTot,this);
				//StringUtil.printMsg("colNm_AmtCt",colNm_AmtCt,this);
				//StringUtil.printMsg("colNm_AmtCtVat",colNm_AmtCtVat,this);
				//StringUtil.printMsg("colNm_Remarks",colNm_Remarks,this);
				//StringUtil.printMsg("colNm_DateMade",colNm_DateMade,this);
				//StringUtil.printMsg("colNm_SiteEno",colNm_SiteEno,this);
				//StringUtil.printMsg("colNm_RateAc",colNm_RateAc,this);
				//StringUtil.printMsg("colNm_SiteSid",colNm_SiteSid,this);
				*/
				//�޽���ó��
				//res.enableFirstRow(msgDS);
				//msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
							
				for(int i=0; i<rows.length; i++){
					int j=1;
					
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						
						StringUtil.printMsg("call","PMS.PR_CT010i_06-INSERT",this);
						StringUtil.printMsg("colNm_SiteSeqCt",rows[i].getString(colNm_SiteSeqCt),this);
						StringUtil.printMsg("colNm_SiteSeqCh",rows[i].getString(colNm_SiteSeqCh),this);
						StringUtil.printMsg("colNm_SiteStatus",rows[i].getString(colNm_SiteStatus),this);
						StringUtil.printMsg("colNm_DateCt",rows[i].getString(colNm_DateCt),this);
						StringUtil.printMsg("colNm_DateBegin",rows[i].getString(colNm_DateBegin),this);
						StringUtil.printMsg("colNm_DateEnd",rows[i].getString(colNm_DateEnd),this);
						StringUtil.printMsg("colNm_AmtCtTot",rows[i].getString(colNm_AmtCtTot),this);
						StringUtil.printMsg("colNm_AmtCt",rows[i].getString(colNm_AmtCt),this);
						StringUtil.printMsg("colNm_AmtCtVat",rows[i].getString(colNm_AmtCtVat),this);
						StringUtil.printMsg("colNm_Remarks",rows[i].getString(colNm_Remarks),this);
						StringUtil.printMsg("colNm_DateMade",rows[i].getString(colNm_DateMade),this);
						StringUtil.printMsg("colNm_SiteEno",rows[i].getString(colNm_SiteEno),this);
						StringUtil.printMsg("colNm_RateAc",rows[i].getString(colNm_RateAc),this);
						StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?        ,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_SiteSeqCt));
						cstmt.setString(2, rows[i].getString(colNm_SiteSeqCh));
						cstmt.setString(3, rows[i].getString(colNm_SiteStatus));
						cstmt.setString(4, rows[i].getString(colNm_DateCt));
						cstmt.setString(5, rows[i].getString(colNm_DateBegin));
						cstmt.setString(6, rows[i].getString(colNm_DateEnd));
						cstmt.setLong(7, rows[i].getLong(colNm_AmtCt));
						cstmt.setLong(8, rows[i].getLong(colNm_AmtCtVat));
						cstmt.setLong(9, rows[i].getLong(colNm_AmtCtTot));
						cstmt.setString(10, rows[i].getString(colNm_Remarks));						
						cstmt.setString(11, rows[i].getString(colNm_DateMade));
						cstmt.setString(12, rows[i].getString(colNm_SiteEno));
						cstmt.setInt(13, rows[i].getInt(colNm_RateAc));
						cstmt.setInt(14, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "1");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						StringUtil.printMsg("call","PMS.PR_CT010i_06-UPDATE",this);
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?        ,?,?) }");
						/*
						StringUtil.printMsg("colNm_SiteSeqCt",rows[i].getString(colNm_SiteSeqCt),this);
						StringUtil.printMsg("colNm_SiteSeqCh",rows[i].getString(colNm_SiteSeqCh),this);
						StringUtil.printMsg("colNm_SiteStatus",rows[i].getString(colNm_SiteStatus),this);
						StringUtil.printMsg("colNm_DateCt",rows[i].getString(colNm_DateCt),this);
						StringUtil.printMsg("colNm_DateBegin",rows[i].getString(colNm_DateBegin),this);
						StringUtil.printMsg("colNm_DateEnd",rows[i].getString(colNm_DateEnd),this);
						StringUtil.printMsg("colNm_AmtCtTot",rows[i].getString(colNm_AmtCtTot),this);
						StringUtil.printMsg("colNm_AmtCt",rows[i].getString(colNm_AmtCt),this);
						StringUtil.printMsg("colNm_AmtCtVat",rows[i].getString(colNm_AmtCtVat),this);
						StringUtil.printMsg("colNm_Remarks",rows[i].getString(colNm_Remarks),this);
						StringUtil.printMsg("colNm_DateMade",rows[i].getString(colNm_DateMade),this);
						StringUtil.printMsg("colNm_SiteEno",rows[i].getString(colNm_SiteEno),this);
						StringUtil.printMsg("colNm_RateAc",rows[i].getString(colNm_RateAc),this);
						StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						*/
						
						cstmt.setString(1, rows[i].getString(colNm_SiteSeqCt));
						cstmt.setString(2, rows[i].getString(colNm_SiteSeqCh));
						cstmt.setString(3, rows[i].getString(colNm_SiteStatus));
						cstmt.setString(4, rows[i].getString(colNm_DateCt));
						cstmt.setString(5, rows[i].getString(colNm_DateBegin));
						cstmt.setString(6, rows[i].getString(colNm_DateEnd));
						cstmt.setLong(7, rows[i].getLong(colNm_AmtCt));
						cstmt.setLong(8, rows[i].getLong(colNm_AmtCtVat));
						cstmt.setLong(9, rows[i].getLong(colNm_AmtCtTot));
						cstmt.setString(10, rows[i].getString(colNm_Remarks));						
						cstmt.setString(11, rows[i].getString(colNm_DateMade));
						cstmt.setString(12, rows[i].getString(colNm_SiteEno));
						cstmt.setInt(13, rows[i].getInt(colNm_RateAc));
						cstmt.setInt(14, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "3");
													
						cstmt.executeUpdate();
							
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_DELETE:
								
						StringUtil.printMsg("call","PMS.PR_CT010i_06-DELETE",this);
						//StringUtil.printMsg("colNm_SiteSeqCt",rows[i].getString(colNm_SiteSeqCt),this);
						//StringUtil.printMsg("colNm_SiteSeqCh",rows[i].getString(colNm_SiteSeqCh),this);
						//StringUtil.printMsg("colNm_SiteStatus",rows[i].getString(colNm_SiteStatus),this);
						//StringUtil.printMsg("colNm_DateCt",rows[i].getString(colNm_DateCt),this);
						//StringUtil.printMsg("colNm_DateBegin",rows[i].getString(colNm_DateBegin),this);
						//StringUtil.printMsg("colNm_DateEnd",rows[i].getString(colNm_DateEnd),this);
						//StringUtil.printMsg("colNm_AmtCtTot",rows[i].getString(colNm_AmtCtTot),this);
						//StringUtil.printMsg("colNm_AmtCt",rows[i].getString(colNm_AmtCt),this);
						//StringUtil.printMsg("colNm_AmtCtVat",rows[i].getString(colNm_AmtCtVat),this);
						//StringUtil.printMsg("colNm_Remarks",rows[i].getString(colNm_Remarks),this);
						//StringUtil.printMsg("colNm_DateMade",rows[i].getString(colNm_DateMade),this);
						//StringUtil.printMsg("colNm_SiteEno",rows[i].getString(colNm_SiteEno),this);
						//StringUtil.printMsg("colNm_RateAc",rows[i].getString(colNm_RateAc),this);
						//StringUtil.printMsg("colNm_SiteSid",rows[i].getString(colNm_SiteSid),this);
						
						cstmt = conn.prepareCall("{call PMS.PR_CT010i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?        ,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_SiteSeqCt));
						cstmt.setString(2, rows[i].getString(colNm_SiteSeqCh));
						cstmt.setString(3, rows[i].getString(colNm_SiteStatus));
						cstmt.setString(4, rows[i].getString(colNm_DateCt));
						cstmt.setString(5, rows[i].getString(colNm_DateBegin));
						cstmt.setString(6, rows[i].getString(colNm_DateEnd));
						cstmt.setLong(7, rows[i].getLong(colNm_AmtCt));
						cstmt.setLong(8, rows[i].getLong(colNm_AmtCtVat));
						cstmt.setLong(9, rows[i].getLong(colNm_AmtCtTot));
						cstmt.setString(10, rows[i].getString(colNm_Remarks));						
						cstmt.setString(11, rows[i].getString(colNm_DateMade));
						cstmt.setString(12, rows[i].getString(colNm_SiteEno));
						cstmt.setInt(13, rows[i].getInt(colNm_RateAc));
						cstmt.setInt(14, rows[i].getInt(colNm_SiteSid));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "2");
						
						cstmt.executeUpdate();
						
						if(cstmt!=null) cstmt.close();						
						break;	
					}
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