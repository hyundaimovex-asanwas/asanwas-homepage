package pms.menu.si;


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

public class Si110S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Work Master List ��ȸ
		arr_sql[0].append ("{call PMS.PR_SI110S_01(?,?,?) }" );
		//work Detail ��ȸ
		arr_sql[1].append ("{call PMS.PR_SI110I_11(?,?) }" );
		//detail1 ��ȸ
		arr_sql[2].append ("{call PMS.PR_SI110I_21(?,?) }" );
		//detail2 ��ȸ
		arr_sql[3].append ("{call PMS.PR_SI110I_31(?,?) }" );
		//detail3 ��ȸ
		arr_sql[4].append ("{call PMS.PR_SI110I_41(?,?) }" );
		
		//work Master ����
		arr_sql[5].append ("{call PMS.PR_SI110I_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }" );
		//work Detail ����
		arr_sql[6].append ("{call PMS.PR_SI110I_12(?,?,?,?,?, ?) }" );
		//detail1 ����
		arr_sql[7].append ("{call PMS.PR_SI110I_22(?,?,?,?,?, ?,?,?) }" );
		//detail2 ����
		arr_sql[8].append ("{call PMS.PR_SI110I_32(?,?,?,?,?) }" );
		//detail3 ����
		arr_sql[9].append ("{call PMS.PR_SI110I_42(?,?,?,?,? ) }" );

		//work Master ��¥ �ߺ� üũ
		arr_sql[10].append ("{call PMS.PR_SI110I_03(?,?,?,?,?) }" );
		
		//���ڰ��� - ����ȭ�� ��ȸ
		arr_sql[11].append ("{call PMS.PR_SI110I_51(?,?) }" );
		//���ڰ��� - ���ȭ�� ��ȸ
		arr_sql[12].append ("{call PMS.PR_SI110I_61(?,?,?,?,?) }" );
		
   }

	//init method
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
            	if(dSets[i].getName().equals("ds_wml")){
					GauceDataSet ds1 = gis.read("DS_WML");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, 0);
					cstmt.setString(2, "200001");
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail ��ȸ
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//�ϴ� detail 1 ��ȸ : �η�
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//�ϴ� detail 2 ��ȸ : �ֿ� ���
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//�ϴ� detail 3 ��ȸ : �ֿ�����
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, 0);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
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
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_site_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_site_sid"));			// ����sid
		String v_date 				= HDUtil.nullCheckStr(greq.getParameter("v_date"));				// �۾�����
		int v_dwr_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_dwr_sid"));			// DWR_sid

		//���� ����
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		StringUtil.printMsg("v_site_sid",v_site_sid,this);
		StringUtil.printMsg("v_date",v_date,this);
		//StringUtil.printMsg("v_dwr_sid",v_dwr_sid,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_wml")){
					GauceDataSet ds1 = gis.read("DS_WML");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_wd")){	//work detail ��ȸ
					GauceDataSet ds1 = gis.read("DS_WD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	
            	if(dSets[i].getName().equals("ds_detail1")){	//�ϴ� detail 1 ��ȸ : �η�
					GauceDataSet ds1 = gis.read("DS_DETAIL1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail2")){	//�ϴ� detail 2 ��ȸ : �ֿ� ���
					GauceDataSet ds1 = gis.read("DS_DETAIL2");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_detail3")){	//�ϴ� detail 3 ��ȸ : �ֿ�����
					GauceDataSet ds1 = gis.read("DS_DETAIL3");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            			
            	if(dSets[i].getName().equals("ds_wm_chk")){
					GauceDataSet ds_wm_chk = gis.read("DS_WM_CHK");	//���� �ߺ� üũ ���
					
					cstmt = conn.prepareCall(arr_sql[10].toString());
					cstmt.setInt(1, v_site_sid);
					cstmt.setString(2, v_date);
					cstmt.registerOutParameter(3, OracleTypes.VARCHAR);	//����� ���� 
					cstmt.registerOutParameter(4, OracleTypes.VARCHAR);	//����� ���� 
					cstmt.registerOutParameter(5, OracleTypes.VARCHAR);	//����� ����
					
					cstmt.executeQuery();
					r_s_yn		 = cstmt.getString(3);
					r_msg_cd	 = cstmt.getString(4);
					r_msg		 = cstmt.getString(5);
					
					//StringUtil.printMsg(" r_s_yn",cstmt.getString(3),this);
					
					//if(!r_s_yn.equals("Y"))
						//throw new Exception (r_msg);
					
					if(ds_wm_chk!=null){
						ds_wm_chk.put("S_YN", 	r_s_yn, 1);//Ŀ�� OUT param.
						ds_wm_chk.put("MSG_CD", r_msg_cd, 4);//Ŀ�� OUT param.
						ds_wm_chk.put("MSG", 	r_msg, 200);//Ŀ�� OUT param.
						ds_wm_chk.heap();
					}
					if(cstmt!=null) cstmt.close();
					if(ds_wm_chk!=null) gos.write(ds_wm_chk);
            	}
            	if(dSets[i].getName().equals("ds_ap_dwr")){	//���ڰ��� - ����ȭ�� ��ȸ
					GauceDataSet ds1 = gis.read("DS_AP_DWR");
					cstmt = conn.prepareCall(arr_sql[11].toString());
					cstmt.setInt(1, v_dwr_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
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
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("����~!","",this);
	}
}