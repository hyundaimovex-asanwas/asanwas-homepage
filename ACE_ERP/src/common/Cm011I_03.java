package common;



import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletException;

import common.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import oracle.jdbc.OracleTypes;



public class Cm011I_03 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql(){

		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//�޴� Ʈ�� �����
		arr_sql[0].append ("{CALL COMMON.PR_CM010S_13(?, ?)}");	//���� * �ý��۸� - ��ȸ��
        
        arr_sql[1].append ("{CALL COMMON.PR_CM010S_04( ?, ?, ? )}");	//Ÿ��Ʋ ���Ͽ�.
				      
   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����ȸ",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
	}	
	
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","��ȸ",this);
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("�α��� ����� ����~", fParamEmpno, this);
		//StringUtil.printMsg("�α��� ����� IP~", fParamIp, this);
		
		try{
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            String paramDEPTNO = greq.getParameter("goods_cd");	//�׽�Ʈ �Ķ����
            int tree_idx = HDUtil.nullCheckNum(greq.getParameter("tree_idx"));
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			String menu_nm = "";
			String full_dir_nm = "";
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				if(dSets[i].getName().equals("ds_tree")){	//�޴�Ʈ�� �θ� ��
					GauceDataSet ds1 = gis.read("DEFAULT");	//��¾�� �̰��� �����߾� ��_��.. ����~!!
					//StringUtil.printMsg(" ddd",ds1.getName(),this);
					//gos.fragment(ds1);
					
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1,fParamEmpno);				//�����
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
					
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
				}
				
				if(dSets[i].getName().equals("ds_title")){	//������ �θ� ��
					GauceDataSet ds1 = gis.read("TITLE");
					//gos.fragment(ds1);
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);	//�޴���
					cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);	//Ǯ ��θ�
					cstmt.setInt	          (3, tree_idx);				//�ε���
					cstmt.executeUpdate();
					
					menu_nm 		= cstmt.getString(1);
					full_dir_nm 	= cstmt.getString(2);
					ds1.put("MENU_NM",menu_nm, 100);
					ds1.put("FULL_DIR_NM",full_dir_nm, 300);
					ds1.heap();
					gos.write(ds1);
					
					
					//StringUtil.printMsg("�޴���", menu_nm, this);
					//StringUtil.printMsg("�޴���", menu_nm.length(), this);
					//StringUtil.printMsg("Ǯ ��θ�", full_dir_nm, this);
					//StringUtil.printMsg("Ǯ ��θ�", full_dir_nm.length(), this);
					
					
				}				
			}
            gos.close();
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

}
