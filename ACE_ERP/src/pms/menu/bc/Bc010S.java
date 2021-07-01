package pms.menu.bc;


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

public class Bc010S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main ��ȸ
		arr_sql[0].append ("{call PMS.PR_BC010S_01(?,?,?,?,?, ?,?,?,?,?, ? ) }" );
		
		//���̾�1 ��ȸ
		arr_sql[1].append ("{call PMS.PR_BC010S_D_01(?,?  ) }" );	//1_0 ����
		arr_sql[2].append ("{call PMS.PR_BC010S_D_02(?,?  ) }" );	//1_1 ����
		arr_sql[3].append ("{call PMS.PR_BC010S_01(?,?,?,?,?, ?,?,?,?,? ) }" );	//1_2 ���
		arr_sql[4].append ("{call PMS.PR_BC010I_11(?,?) }" );	//1_3 �ſ�
		arr_sql[5].append ("{call PMS.PR_BC010I_21(?,?) }" );	//1_4 ����
	
			
		//���»� ī��Ʈ
		arr_sql[6].append ("{call PMS.PR_BC010S_D_09(?) }" );
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		int v_bp_sid 				= HDUtil.nullCheckNum(greq.getParameter("v_bp_sid"));			// ���»�
		String v_in_cstr_kind 		= HDUtil.nullCheckStr(greq.getParameter("v_in_cstr_kind"));		// ���ϰ���
		String v_lic_kind 			= HDUtil.nullCheckStr(greq.getParameter("v_lic_kind"));			// ��������
		String v_loc_place 			= HDUtil.nullCheckStr(greq.getParameter("v_loc_place"));		// ������
		int v_cstr_eval_fee_fr 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_fr")); // ����� From
		int v_cstr_eval_fee_to 		= HDUtil.nullCheckNum(greq.getParameter("v_cstr_eval_fee_to")); // ����� To
		String v_credit_grd			= HDUtil.nullCheckStr(greq.getParameter("v_credit_grd")); 		// �ſ���
		String v_cashflow_grd		= HDUtil.nullCheckStr(greq.getParameter("v_cashflow_grd")); 	// �����帧
		String v_in_yn				= HDUtil.nullCheckStr(greq.getParameter("v_in_yn")); 			// �������
		String v_yet_only_yn		= HDUtil.nullCheckStr(greq.getParameter("v_yet_only_yn")); 		// ��ȿ ����
		
		//StringUtil.printMsg("v_bp_sid",v_bp_sid,this);
		//StringUtil.printMsg("v_in_cstr_kind",v_in_cstr_kind,this);
		//StringUtil.printMsg("v_lic_kind",v_lic_kind,this);
		//StringUtil.printMsg("v_loc_place",v_loc_place,this);
		//StringUtil.printMsg("v_cstr_eval_fee_fr",v_cstr_eval_fee_fr,this);
		//StringUtil.printMsg("v_cstr_eval_fee_to",v_cstr_eval_fee_to,this);
		//StringUtil.printMsg("v_credit_grd",v_credit_grd,this);
		//StringUtil.printMsg("v_cashflow_grd",v_cashflow_grd,this);		
		//StringUtil.printMsg("v_in_yn",v_in_yn,this);
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	if(dSets[i].getName().equals("ds_default")){
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.setString(2, v_in_cstr_kind);
					cstmt.setString(3, v_lic_kind);
					cstmt.setString(4, v_loc_place);
					cstmt.setInt(5, v_cstr_eval_fee_fr);
					cstmt.setInt(6, v_cstr_eval_fee_to);
					cstmt.setString(7, v_credit_grd);
					cstmt.setString(8, v_cashflow_grd);
					cstmt.setString(9, v_in_yn);
					cstmt.setString(10, v_yet_only_yn);
					cstmt.registerOutParameter(11, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(11);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}

            	if(dSets[i].getName().equals("ds_1_0")){// ���̾�1 ����
					GauceDataSet ds1 = gis.read("DS_1_0");
					//StringUtil.printMsg("ds1_3","-------------",this);
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();	//����
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_1_1")){	// ���̾�1 �������
					GauceDataSet ds1 = gis.read("DS_1_1");
					//StringUtil.printMsg("ds1_3","-------------",this);
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();	//����
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}            	
            	if(dSets[i].getName().equals("ds_1_3")){
					GauceDataSet ds1 = gis.read("DS_1_3");
					//StringUtil.printMsg("ds1_3","-------------",this);
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();	//����
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_1_4")){
					GauceDataSet ds1 = gis.read("DS_1_4");
					//StringUtil.printMsg("ds1_4","-------------",this);
					cstmt = conn.prepareCall(arr_sql[5].toString());
					cstmt.setInt(1, v_bp_sid);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();	//����
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}            
            	if(dSets[i].getName().equals("ds_cnt")){
					GauceDataSet ds1 = gis.read("DS_CNT");
					//StringUtil.printMsg("ds1_4","-------------",this);
					cstmt = conn.prepareCall(arr_sql[6].toString());
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();	//����
					rs = (ResultSet)cstmt.getObject(1);	//Ŀ�� OUT param. 					
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
	}
}