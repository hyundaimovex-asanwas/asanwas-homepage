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

public class Pu080S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU080S_01(?,?,?,?,?,	?,?,?) }" );

		//TENDER ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU080I_02(?,?,?) }" );

		//DETAIL ��ȸ
		arr_sql[2].append ("{call PMS.PR_PU080S_03(?,?,?) }" );
		//	DETAIL �˼����ں� ��ȸ
		arr_sql[3].append ("{call PMS.PR_PU080S_04(?,?,?,?,?) }" );
		
		//Print��ȸ
		arr_sql[4].append ("{call PMS.PR_PU080S_05(?,?,?) }");
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
		    int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

		    for(int i=0; i<dSets.length;i++){
			   	if(dSets[i].getName().equals("ds_default")){
			   		//StringUtil.printMsg("Init:::::::::","ds_default",this);
			   		//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
		   			GauceDataSet ds1 = gis.read("DS_DEFAULT");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						//cstmt.setInt(1, 1);
						cstmt.setString(1, "19990101");
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "19990101");
						cstmt.setString(5, "2");
						cstmt.setString(6, "1");
						cstmt.setInt(7, 1);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_tender")){
					//StringUtil.printMsg("Init:::::::::","ds_tender",this);
					//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_TENDER");
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, 9999999);
						cstmt.setInt(2, 9999999);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
			   	} else if(dSets[i].getName().equals("ds_detail")  & dsType==1){
					//StringUtil.printMsg("Init:::::::::","ds_detail",this);
					//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
					GauceDataSet ds1 = gis.read("DS_DETAIL");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 0);
					cstmt.setString(2, "91");
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
					gos.write(getDataSet(rs, ds1));
				}
		    }
	     	//gos.close();
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
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_default")){
						GauceDataSet ds1 = gis.read("DS_DEFAULT");
						//int v_site_sid 			= HDUtil.nullCheckNum(req.getParameter("v_site_sid"));			// ���� SID
						String v_fr_con_date 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_con_date")); 	// ǰ������ ����
						String v_to_con_date	= HDUtil.nullCheckStr(greq.getParameter("v_to_con_date")); 	// ǰ������ ����
						String v_fr_date_cgc 	= HDUtil.nullCheckStr(greq.getParameter("v_fr_date_cgc")); 	// �˼����� ����
						String v_to_date_cgc	= HDUtil.nullCheckStr(greq.getParameter("v_to_date_cgc")); 	// �˼����� ����
						String v_rqst_status		= HDUtil.nullCheckStr(greq.getParameter("v_rqst_status")); 	// ��û����
						String sRqstNo			= HDUtil.nullCheckStr(greq.getParameter("v_rqst_no"));			// û����ȣ
						int v_site_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// ���� SID

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
						cstmt.setString(3, v_fr_date_cgc);
						cstmt.setString(4, v_to_date_cgc);
						cstmt.setString(5, v_rqst_status);
						cstmt.setString(6, sRqstNo);
						cstmt.setInt(7, v_site_sid);
						cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						GauceDataSet ds1 = gis.read("DS_TENDER");
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// û�� SID
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				// ���� SID
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rqst_sid);
						cstmt.setInt(2, v_est_sid);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail") && dsType==1 && dsType!=2){
						GauceDataSet ds1 = gis.read("DS_DETAIL");
						int v_est_sid = HDUtil.nullCheckNum(greq.getParameter("v_est_sid"));				//���� SID
						String v_vend_cd 	= HDUtil.nullCheckStr(greq.getParameter("v_vend_cd")); 	// �ŷ�ó�ڵ�
						
						StringUtil.printMsg("v_est_sid",v_est_sid+"",this);
						StringUtil.printMsg("v_vend_cd",v_vend_cd+"",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1, v_est_sid);
						cstmt.setString(2, v_vend_cd);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds9")){
						GauceDataSet ds1 = gis.read("DS9");
						int v_con_sid = HDUtil.nullCheckNum(greq.getParameter("v_con_sid"));			// ǰ�� SID
						String v_date_cgcd 	= HDUtil.nullCheckStr(greq.getParameter("v_date_cgcd")); 	// �˼�����
						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1, v_con_sid);
						cstmt.setString(2, v_date_cgcd);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_detail") && dsType==2 && dsType!=1){
						GauceDataSet ds1 = gis.read("DS_DETAIL_DATE");
						StringUtil.printMsg("DS_DETAIL_DATE","DS_DETAIL_DATE",this);
						
						int v_cgc_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_cgc_sid"));				//�˼������� SID
						int v_cgcd_sid = HDUtil.nullCheckNum(greq.getParameter("v_cgcd_sid"));			//�˼������� SID
						int v_con_sid = HDUtil.nullCheckNum(greq.getParameter("v_con_sid"));				// ǰ��
						String v_date_cgcd 	= HDUtil.nullCheckStr(greq.getParameter("v_date_cgcd")); 	// �˼�����
						
						//StringUtil.printMsg("v_est_sid",v_est_sid+"",this);
						//StringUtil.printMsg("v_item_sid",v_item_sid+"",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1, v_cgc_sid);
						cstmt.setInt(2, v_cgcd_sid);					
						cstmt.setInt(3, v_con_sid);					
						cstmt.setString(4, v_date_cgcd);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}
				 }
				 //gos.close();
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
	}
}