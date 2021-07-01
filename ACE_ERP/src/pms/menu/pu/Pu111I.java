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

public class Pu111I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//������ ��ȸ
		arr_sql[0].append ("{call PMS.PR_PU111I_01(?,?,?,?,?) }" );

		//Detail ��ȸ
		arr_sql[1].append ("{call PMS.PR_PU111I_02(?,?) }" );

		//Main ����
		arr_sql[2].append ("{call PMS.PR_PU111I_03(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?) }");
		//Detail ����
		arr_sql[3].append ("{call PMS.PR_PU111I_04(?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?                ,?) }");

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
						cstmt.setInt(1, 1);
						cstmt.setString(2, "19990101");
						cstmt.setString(3, "19990101");
						cstmt.setString(4, "2");
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
						//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
						//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
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
						int v_site_sid 			= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// ���� SID
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
						cstmt.setInt(1, v_site_sid);
						cstmt.setString(2, v_fr_rqst_date);
						cstmt.setString(3, v_to_rqst_date);
						cstmt.setString(4, v_rqst_status);
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 			
						//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
						//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
						gos.write(getDataSet(rs, ds1));
					} else if(dSets[i].getName().equals("ds_tender")){
						int v_rqst_sid = HDUtil.nullCheckNum(greq.getParameter("v_rqst_sid"));			// ���� SID
						GauceDataSet ds1 = gis.read("DS_TENDER");
						//StringUtil.printMsg("v_rqst_sid",v_rqst_sid+"",this);
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
					
				String v_rqst_status		= HDUtil.nullCheckStr(greq.getParameter("sRqstStatus")); 	
				String v_rqst_date		= HDUtil.nullCheckStr(greq.getParameter("sRqstDate")); 	
				String v_rqst_no 			= HDUtil.nullCheckStr(greq.getParameter("sRqstNo")); 	
				int v_rqst_sid 				= HDUtil.nullCheckNum(greq.getParameter("sRqstSid"));
				String v_site_cd 			= HDUtil.nullCheckStr(greq.getParameter("sSiteCd")); 	
				String v_pu_empno		= HDUtil.nullCheckStr(greq.getParameter("sPuEmpno"));
				int v_site_sid 				= HDUtil.nullCheckNum(greq.getParameter("sSiteSid"));	
				String v_rqst_use			= HDUtil.nullCheckStr(greq.getParameter("sRqstUse"));
				String v_sys_file 			= HDUtil.nullCheckStr(greq.getParameter("sSysFile")); 	// ÷������system
				String v_real_file			= HDUtil.nullCheckStr(greq.getParameter("sRealFile")); 	// ÷������real
					
				//StringUtil.printMsg("v_real_file",v_real_file,this);					
				//StringUtil.printMsg("v_sys_file",v_sys_file,this);
				//û����ȣ
			    //res.enableFirstRow(rqstNoDS);
			    //rqstNoDS.addDataColumn(new GauceDataColumn("RQST_NO", GauceDataColumn.TB_STRING));

				//for(int i=0; i<rows.length; i++){
					
							//StringUtil.printMsg("v_real_file","v_real_file===========",this);
					
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
							cstmt.setString(1, v_rqst_status);
							cstmt.setString(2, v_rqst_date);
							cstmt.setString(3, v_rqst_no);
							cstmt.setInt(4, v_rqst_sid);
							cstmt.setString(5, v_site_cd);
							cstmt.setString(6, v_pu_empno);
							cstmt.setInt(7, v_site_sid);
							cstmt.setString(8, v_rqst_use);
							cstmt.setString(9, v_real_file);
							cstmt.setString(10, v_sys_file);
							cstmt.setString(11, iParamEmpno);
							cstmt.setString(12, iParamIp);
							cstmt.setString(13, "3");
			
						
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
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