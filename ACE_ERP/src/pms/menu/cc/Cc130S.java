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

public class Cc130S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//ó���ں� [ó��]���� ��ȸ
		arr_sql[0].append ("{call PMS.PR_CC130S_01(?,?,?,?) }" );

		//������ ��ī �ŷ�����
		arr_sql[1].append ("{call PMS.PR_CC130S_02(?,?,?) }" );

		//ī�庰 �ŷ�����
		arr_sql[2].append ("{call PMS.PR_CC130S_03(?,?,?) }" );
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("�ʱ�ȭ~!","",this);


		

		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//String iParamEmpno 		= fParamEmpno;
		String v_empno	 		= HDUtil.nullCheckStr(greq.getParameter("v_empno"));			//ó���� ���
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//��ȸ�Ⱓ
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//��ȸ�Ⱓ
		String v_fsdat	        = HDUtil.nullCheckStr(greq.getParameter("v_fsdat"));      	    // ��������
		String v_fsnbr	        = HDUtil.nullCheckStr(greq.getParameter("v_fsnbr"));      	    // ������ȣ

		//���� ����
		//String r_s_yn		= null;
		//String r_msg_cd		= null;
		//String r_msg		= null;
		
		//StringUtil.printMsg("v_empno",v_empno,this);
		//StringUtil.printMsg("v_fdcode",v_fdcode,this);
		//StringUtil.printMsg("v_fsdat",v_fsdat,this);
		//StringUtil.printMsg("v_fsnbr",v_fsnbr,this);
		//StringUtil.printMsg("v_frdt",v_frdt,this);
		//StringUtil.printMsg("v_todt",v_todt,this);
		//StringUtil.printMsg("v_pl_dept",v_pl_dept,this);
		
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
            	if(dSets[i].getName().equals("ds_culd")){
					GauceDataSet ds1 = gis.read("DS_CULD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, v_fsdat);
					cstmt.setString(2, v_fsnbr);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
            	}

            	if(dSets[i].getName().equals("ds_culd1")){
					GauceDataSet ds1 = gis.read("DS_CULD1");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, v_fsdat);
					cstmt.setString(2, v_fsnbr);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
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