package pms.menu.cc;
//	si110i
//	si110i_h1 ���

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

public class Cc110S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//ī�� ��� ��Ȳ ��ȸ
		arr_sql[0].append ("{call PMS.PR_CC110S_01(?,?,?,?,?,  ?,?,?,?) }" );

		//card use list detail ��ȸ - ��������
		arr_sql[1].append ("{call PMS.PR_CC110I_02(?,?) }" );

	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("�ʱ�ȭ~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_mgr_no 		= HDUtil.nullCheckStr(greq.getParameter("v_mgr_no"));			//ó���� ���
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				// �۾�����
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				// �۾�����
		String v_ccstat			= HDUtil.nullCheckStr(greq.getParameter("v_ccstat"));			// ó�� ����
		String v_card_num 		= HDUtil.nullCheckStr(greq.getParameter("v_card_num"));			// ī���ȣ
		int	v_acquire_sid 		= HDUtil.nullCheckNum(greq.getParameter("v_acquire_sid"));		// ����sid

		//���� ����
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;		
		//StringUtil.printMsg("v_site_sid",v_site_sid,this);
		StringUtil.printMsg("v_frdate",v_frdt,this);
		StringUtil.printMsg("v_todate",v_todt,this);

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_cul")){
					GauceDataSet ds1 = gis.read("DS_CUL");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, v_frdt);
					cstmt.setString(2, v_todt);
					cstmt.setString(3, v_mgr_no);
					cstmt.setString(4, v_card_num);
					cstmt.setString(5, v_ccstat);
					cstmt.setString(6, "");
					cstmt.setString(7, "");
					cstmt.setString(8, "");
					cstmt.registerOutParameter(9, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(9);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_culd")){
					GauceDataSet ds1 = gis.read("DS_CULD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_acquire_sid);
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