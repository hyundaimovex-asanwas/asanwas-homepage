package pms.news.pur;

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

public class Rq040 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		
		
		
				//	default ��ȸ  , �����Ƿڼ� ���� ,����  - project 
				arr_sql[1].append ("{call PMS.PR_NEW_RQ040_01(?,?) }" );
				
				
				
				// default ��ȸ , ������Ʈ �˾�, param - Project
				//arr_sql[1].append ("{call PMS.PR_NEW_RQ010S_02(?,?) }" );

				
				
				//	default ����  , �����Ƿڼ� �ۼ� ,����  - project 
				//arr_sql[2].append ("{call PMS.PR_NEW_RQ040S_03(?,?,?,?,?,?,?) }" );

				
				
				//	default ��ȸ  , �����Ƿڼ� ���� ������(���� �⺻ ����) ,��ȸ  - project_code , v_project_no
				//arr_sql[3].append ("{call PMS.PR_NEW_RQ041S_01(?,?,?) }" );
				
				
				
				//	default ��ȸ  , �����Ƿڼ� ���� ������(���� ǰ�� list) ,��ȸ  - project_code , v_project_no
				//arr_sql[4].append ("{call PMS.PR_NEW_RQ041S_02(?,?,?) }" );
				
				
				
				//	default ����  , �����Ƿڼ� ������(���� ǰ�� list) ,����/����   
				//arr_sql[5].append ("{call PMS.PR_NEW_RQ041S_03(?,?,?) }" );
				


   }

	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		try {
		} catch (Exception e){
		} finally {
		}
		
	}
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		
		CallableStatement cstmt = null;
		ResultSet 			rs  = null;


		String v_project 			= HDUtil.nullCheckStr(greq.getParameter("v_project"));			// ���ϰ���
		//String v_po 				= HDUtil.nullCheckStr(greq.getParameter("v_po"));				// ���� ��ȣ
		//String v_project_name 		= HDUtil.nullCheckStr(greq.getParameter("v_project_name"));		// ���ϰ���
		//String v_project_code 		= HDUtil.nullCheckStr(greq.getParameter("v_project_code"));		// ���ϰ���
		//String v_project_no 		= HDUtil.nullCheckStr(greq.getParameter("v_project_no"));		// ���ϰ���
		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {

            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){

            	if(dSets[i].getName().equals("ds_default")){

					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					

					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project);

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					

					gos.write(getDataSet(rs, ds1));
            	}
            	
            	
            	/*
            	if(dSets[i].getName().equals("ds_culd")){

					GauceDataSet ds2 = gis.read("DS_CULD");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project_name);
					
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 		
					
					gos.write(getDataSet(rs, ds2));
            	}
            	 */            	
            	
            	
            	// arr_sql[3]
            	// �����Ƿڼ� ���� - ��ȭ�� (���� �⺻ ����  select)
            	/*
            	if(dSets[i].getName().equals("ds_culs")){

					GauceDataSet ds1 = gis.read("DS_CULS");
					
					cstmt = conn.prepareCall(arr_sql[3].toString());

					
					cstmt.setString(1, v_project); //������Ʈ ��(code)�� �� ����
					cstmt.setString(2, v_po); 		//���� ��ȣ 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();	//����
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	*/
            	
            	
            	//arr_sql[4]
            	//�����Ƿڼ� ���� - ��ȭ�� (���� ǰ�� list)
            	/*
            	if(dSets[i].getName().equals("ds_culds")){

            		
					GauceDataSet ds1 = gis.read("DS_CULDS");
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setString(1, v_project); //������Ʈ ��(code)�� �� ����
					cstmt.setString(2, v_po); 	   //���� ��ȣ 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();	//����
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	*/
            	
			}

            
            gos.close();
            
		}catch (SQLException sqle){

			throw sqle;
			
		} catch (Exception e){

			throw e;
			
		} finally {
			
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
			
		}
		
	}
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		

		CallableStatement 		cstmt 		= null;	
		GauceStatement 			stmt 		= null;
		ResultSet 				rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        

        GauceDataSet ds_culs = gis.read("DS_CULS");

		
		try{
			if (ds_culs != null) {
				
				GauceDataRow[] 		rows = ds_culs.getDataRows();


				int colNm_COST_CD        	= ds_culs.indexOfColumn("COST_CD");			//������Ʈ �ڵ�
				int colNm_NO_PO     		= ds_culs.indexOfColumn("NO_PO");          	//���ּ� ��ȣ
  

				for(int i=0; i<rows.length; i++){
					

					cstmt = conn.prepareCall(arr_sql[5].toString());

					
					cstmt.setString(1, rows[i].getString(colNm_COST_CD));			//������Ʈ �ڵ�
					cstmt.setString(2, rows[i].getString(colNm_NO_PO));				//���ּ� ��ȣ	
					cstmt.setString(3, iParamEmpno);
					
					
					cstmt.executeUpdate();
					
					if(cstmt!=null) cstmt.close();		
						
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
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();	
		}
		
		
	}
	
	
}



