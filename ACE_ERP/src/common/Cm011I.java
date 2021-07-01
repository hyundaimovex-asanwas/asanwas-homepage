package common;




import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;


public class Cm011I extends SuperServlet {

    public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//�޴� Ʈ�� �����
        //arr_sql[0].append ("{CALL COMMON.PR_CM010S_01()}");	//��ü��ȸ��
		arr_sql[0].append ("{CALL COMMON.PR_CM010S_02(?)}");	//��������-��ȸ��
        
        arr_sql[1].append ("{CALL COMMON.PR_CM010S_03()}");	//������ȸ��
        
        arr_sql[2].append ("{CALL COMMON.PR_CM010S_04( ?, ?, ? )}");	//Ÿ��Ʋ ���Ͽ�.
				      
   }

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","����ȸ",this);

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
	}	
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		//StringUtil.printMsg("# Command","��ȸ",this);
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		//StringUtil.printMsg("�α��� �����", fParamEmpno, this);
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				String menu_nm = "";
				String full_dir_nm = "";
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){	//�޴�Ʈ�� �θ� ��

						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1,fParamEmpno);				//����� 
						//cstmt.setString(1,"2020004");				//�����
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
					}

					if(gauceName.equals("TITLE")){		//Ÿ��Ʋ �θ� ��
						int tree_idx = HDUtil.nullCheckNum(req.getParameter("tree_idx"));
						res.enableFirstRow(ds1);
						ds1.addDataColumn(new GauceDataColumn("MENU_NM", GauceDataColumn.TB_STRING));
						ds1.addDataColumn(new GauceDataColumn("FULL_DIR_NM", GauceDataColumn.TB_STRING));
						
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);	//�޴���
						cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);	//Ǯ ��θ�
						cstmt.setInt	          (3, tree_idx);				//�ε���
						cstmt.executeUpdate();
						
						menu_nm 		= cstmt.getString(1);
						full_dir_nm 	= cstmt.getString(2);
						
						//StringUtil.printMsg("�޴���", menu_nm, this);
						//StringUtil.printMsg("Ǯ ��θ�", full_dir_nm, this);
						
						GauceDataRow row1 = ds1.newDataRow();
						row1.addColumnValue(menu_nm);
						row1.addColumnValue(full_dir_nm);
						
						ds1.addDataRow(row1);		//�����ͼ¿� ����� �߰�!

						if(cstmt!=null) cstmt.close();
						if(ds1!=null)
							ds1.flush();
						
					}					
				}
			}		
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {

	}

}
