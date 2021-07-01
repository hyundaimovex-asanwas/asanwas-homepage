package pms.menu.cc;

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

public class Cc120I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//ó���ں� [ó��]���� ��ȸ
		arr_sql[0].append ("{call PMS.PR_CC120I_01(?,?,?,?) }" );

		//��ǥ ���� ������ ��ȸ = 1:1��Ī��,  ��������=T
		arr_sql[1].append ("{call PMS.PR_CC120I_02(?,?,?,?,?,  ?,?) }" );
		
		//��ǥ ���� �� ������ȣ ������ ���ʵ����� ��ȸ 
		arr_sql[2].append ("{call PMS.PR_CC120I_03(?,?,?,?,?,  ?,?) }" );

		//��ǥ ���� ������ ��ȸ = 1:n ��Ī ��, ��������=T
		arr_sql[3].append ("{call PMS.PR_CC120I_04(?,?,?,?,?,  ?,?) }" );
		
		
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
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "02");
					cstmt.setString(2, "A19000201");
					cstmt.setString(3, "20010101");
					cstmt.setString(4, "20010101");
					cstmt.setString(5, "6050006");
					cstmt.setString(6, "1000");
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
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

		String iParamEmpno 		= fParamEmpno;
		String v_empno	 		= HDUtil.nullCheckStr(greq.getParameter("v_empno"));			//ó���� ���
		String v_fdcode	        = HDUtil.nullCheckStr(greq.getParameter("v_fdcode"));      		// ����
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // ��������
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//��ȸ�Ⱓ
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//��ȸ�Ⱓ
		String v_pl_dept		= HDUtil.nullCheckStr(greq.getParameter("v_pl_dept"));			// �ͼ��ڵ�
		String v_group_nm		= HDUtil.nullCheckStr(greq.getParameter("v_group_nm"));			// �׷��
		int	   v_avgcnt			= HDUtil.nullCheckNum(greq.getParameter("v_avgcnt"));			// ��Ī ���� ��հ�
		//���� ����
		String r_s_yn		= null;
		String r_msg_cd		= null;
		String r_msg		= null;
		
		//StringUtil.printMsg("v_empno",v_empno,this);
		//StringUtil.printMsg("v_fdcode",v_fdcode,this);
		//StringUtil.printMsg("v_fsdat",v_fsdat,this);
		//StringUtil.printMsg("v_frdt",v_frdt,this);
		//StringUtil.printMsg("v_todt",v_todt,this);
		//StringUtil.printMsg("v_group_nm",v_group_nm,this);
		
		
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
					cstmt.setString(3, v_empno);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_slipdtl")){
					GauceDataSet ds1 = gis.read("DS_SLIPDTL");
					
					//20151207
					StringUtil.printMsg("v_group_nm",v_group_nm,this);
					//StringUtil.printMsg("v_avgcnt",v_avgcnt+"",this);
					//String[] pl_dept = v_pl_dept.split(":");
					//String v_pl_depts = "";	//���ν��� ���޿� �μ�s ��. in ������
						//StringUtil.printMsg("pl_dept[0]",pl_dept[0],this);
						//StringUtil.printMsg("pl_dept[1]",pl_dept[1],this);
						//StringUtil.printMsg("pl_dept�迭 ������",pl_dept.length+"",this);
					
					//3280,1220 �� �̷��� ���ڷ� C12.PL_DEPT �÷��� ����ȯ�� �ɰ��̴�.
					//	''3280'',''1220'' �̷� ���·� ���ư��� �ϴµ� ������.. ��..   ��� ����������
					//	'3280','1220' ���� ������ �޳׿�.. �������� ���ڿ���
					//for (int j = 0; j < pl_dept.length; j++) {
					//	v_pl_depts += "'"+pl_dept[j]+"',"; // �� �迭 ����� ���� �� �հ� ���ϱ�
					//}
						//StringUtil.printMsg("v_pl_depts",v_pl_depts.substring(0, v_pl_depts.length()),this);
						//StringUtil.printMsg("v_pl_depts",v_pl_depts.substring(0, v_pl_depts.length()-1),this); //������ ��ǥ �ڸ���
					
					//20160108 �׷�� ������ ���鼭 ���� �����̰� �����..^^
					
					if(v_avgcnt>1){	//1���� ũ�� ���� �ͼ������� �̾߱���..
						StringUtil.printMsg("���� �ͼ� ����","",this);
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fsdat);
						cstmt.setString(3, v_frdt);
						cstmt.setString(4, v_todt);
						cstmt.setString(5, v_empno);
						cstmt.setString(6, v_group_nm);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					}else{
						StringUtil.printMsg("���� �ͼ� ����","",this);
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString(1, v_fdcode);
						cstmt.setString(2, v_fsdat);
						cstmt.setString(3, v_frdt);
						cstmt.setString(4, v_todt);
						cstmt.setString(5, v_empno);
						cstmt.setString(6, v_group_nm);
						cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					}
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}
            	if(dSets[i].getName().equals("ds_cus")){
					GauceDataSet ds1 = gis.read("DS_CUS");
					
					/*String[] pl_dept = v_pl_dept.split(":");
					String v_pl_depts = "";	//���ν��� ���޿� �μ�s ��. in ������
					for (int j = 0; j < pl_dept.length; j++) {
						v_pl_depts += "'"+pl_dept[j]+"',"; // �� �迭 ����� ���� �� �հ� ���ϱ�
					}*/
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_fdcode);
					cstmt.setString(2, v_fsdat);
					cstmt.setString(3, v_frdt);
					cstmt.setString(4, v_todt);
					cstmt.setString(5, v_empno);
					cstmt.setString(6, v_group_nm);
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
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