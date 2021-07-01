package pms.news.bud;

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

public class Bud021 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		
				//tree default ��ȸ 
				arr_sql[1].append ("{call PMS.PR_NEW_BUD021_01(?,?,?) }" );
				
				
				//tree detail ��ȸ
				arr_sql[2].append ("{call PMS.PR_NEW_BUD021_02(?,?,?,?,?)}");
				
				
				//Grid ds_detail ��ȸ
				arr_sql[3].append ("{call PMS.PR_NEW_BUD021_03(?,?,?) }");

				
				//Grid ds_detail2 ��ȸ
				arr_sql[4].append ("{call PMS.PR_NEW_BUD021_04(?,?,?) }");
				
				
				//Grid ds_detail3 ��ȸ
				arr_sql[5].append ("{call PMS.PR_NEW_BUD021_05(?,?,?) }");	
				

				//	insert update����
				arr_sql[9].append ("{call PMS.PR_NEW_BUD021_09(?,?,?,?,?,?,?,?,?,?)}");
				
				
				
   }

	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
				CallableStatement cstmt = null;
				
				ResultSet rs = null;
				
				String v_cost_cd 		= HDUtil.nullCheckStr(greq.getParameter("V_COST_CD"));		
				String v_no_budget 		= HDUtil.nullCheckStr(greq.getParameter("V_NO_BUDGET"));	
				
				try {
					
		            GauceInputStream gis = greq.getGauceInputStream();
		            GauceOutputStream gos = gres.getGauceOutputStream();
		            
		            GauceDataSet[] dSets = gis.readAllOutput(); 
		            
		            for(int i=0; i<dSets.length;i++){
		            	
		            	
		            	if(dSets[i].getName().equals("ds_item_m")){
		            		
							GauceDataSet ds1 = gis.read("DS_ITEM_M");
							
							cstmt = conn.prepareCall(arr_sql[1].toString());

							cstmt.setString(1, v_cost_cd);
							cstmt.setString(2, v_no_budget);
							
							cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
							
							cstmt.executeQuery();
							
							rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 	

							gos.write(getDataSet(rs, ds1));
		
		            	}
		            	

					}
				}catch (SQLException sqle){
				} catch (Exception e){
				} finally {
				}
		
	}
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs			= null;

		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));		
		String v_no_budget 		= HDUtil.nullCheckStr(greq.getParameter("v_no_budget"));	


		//Tree Ŭ���� �Ѱ��ִ� ������
		String v_overValue1 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue1"));	//code
		String v_overValue2 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue2"));	//tree level	
		

		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {

            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){


            	//ȭ�� Ʈ�� ��Ŭ���� �����ʿ� �����ֱ� 
            	if(dSets[i].getName().equals("ds_item_d")){
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D");

					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						
					cstmt.setString(3, v_overValue1);
					cstmt.setString(4, v_overValue2);	
					
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(5);	//Ŀ�� OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
					
            	}
            	
            	
            	
            	
            	
            	//ȭ�� grid �����ֱ� 
            	if(dSets[i].getName().equals("ds_item_d_grid")){
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID");
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
            	}            	
            	
            	
            	
            	
            	//ȭ�� grid2 �����ֱ� 
            	if(dSets[i].getName().equals("ds_item_d_grid2")){

					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID2");

					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
            	}  
            	
            	
            	
            	
            	//ȭ�� grid3 �����ֱ� 
            	if(dSets[i].getName().equals("ds_item_d_grid3")){
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID3");

					cstmt = conn.prepareCall(arr_sql[5].toString());

					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
            	}            
            	

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

		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        //tree �κ� ���� 
        GauceDataSet ds_item_d = gis.read("DS_ITEM_D");
        

		try{

			if (ds_item_d != null) {
				
				GauceDataRow[] 		rows = ds_item_d.getDataRows();
				
				int colNm_COST_CD				= ds_item_d.indexOfColumn("COST_CD");        		// ������Ʈ�ڵ�            
				int colNm_NO_BUDGET        		= ds_item_d.indexOfColumn("NO_BUDGET");   			// ����       
				int colNm_CD_COST				= ds_item_d.indexOfColumn("CD_COST");				// �󼼺з��ڵ�
				int colNm_DS_KSITEM    			= ds_item_d.indexOfColumn("DS_KSITEM");     		// ǰ���
				int colNm_COST_YN    			= ds_item_d.indexOfColumn("COST_YN");     			// node,leaf ����
				int colNm_ORDER_AMT_NOW    		= ds_item_d.indexOfColumn("ORDER_AMT_NOW");   		// ���ޱݾ�(����)         
				int colNm_EXE_ACT_AMT_NOW      	= ds_item_d.indexOfColumn("EXE_ACT_AMT_NOW");       // ���࿹��(����) 
				int colNm_ITEM_CD      			= ds_item_d.indexOfColumn("ITEM_CD");       		// ǰ���ڵ� 

				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){
						
						cstmt = conn.prepareCall(arr_sql[9].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));	
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//���콺�� �۾� ��
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
						
					}else if(rows[i].getJobType()==3){
						
						cstmt = conn.prepareCall(arr_sql[9].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//���콺�� �۾� ��
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
					
					}

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



