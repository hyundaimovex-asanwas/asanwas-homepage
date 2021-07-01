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

public class Bd013 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		
		
				//	default ��ȸ
				arr_sql[1].append ("{call PMS.PR_NEW_BD013_01(?,?) }" );
				
				//	bd010.jsp �Է°� ��ȸ
				//arr_sql[1].append ("{call PMS.PR_NEW_BD013_02(?,?,?)}");
				


   }

	//init method
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
					
					cstmt = conn.prepareCall(arr_sql[5].toString());
					
					cstmt.setString(1, v_cost_cd);
					cstmt.setString(2, v_no_budget);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 	
					
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					
					gos.write(getDataSet(rs, ds1));

            	}
            	
			}
		}catch (SQLException sqle){
		} catch (Exception e){
		} finally {
		}
	}
	
	
	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs			= null;

		//BU013 item �ڵ� ��ȸ 
		String v_item 	= HDUtil.nullCheckStr(greq.getParameter("v_item"));	

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            	

            	if(dSets[i].getName().equals("ds_pCode_serch")){
            		
					GauceDataSet ds1 = gis.read("DS_PCODE_SERCH");
					
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_item);
					
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 	
					
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
	
	
	
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String iParamIp 	= fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        String v_default_row 		= HDUtil.nullCheckStr(greq.getParameter("v_default_row"));
        GauceDataSet ds_default = gis.read("DS_DEFAULT");
        
        //tree �κ� ���� 
        GauceDataSet ds_item_d = gis.read("DS_ITEM_D");
        GauceDataSet ds_gr_lic = gis.read("DS_GR_LIC");

        
		
		try{
			if (ds_default != null) {
				GauceDataRow[] 		rows = ds_default.getDataRows();
				
		    	//alert("�Է°� Ȯ��:::1:"+V_COST_CD+"2:"+V_TY_BUDGET+"3:"+V_DS_BUDGET+"4:"+V_I_EMPNO);
				int cost_cd		= ds_default.indexOfColumn("COST_CD");                    
				int ty_budget         = ds_default.indexOfColumn("TY_BUDGET");          
				int ds_budget	= ds_default.indexOfColumn("DS_BUDGET");
				int I_EMPNO    = ds_default.indexOfColumn("I_EMPNO");   
				int jobtype = 2;
				System.out.println(rows.length+":cost_cd:"+cost_cd+":ty_budget:"+ty_budget+":ds_budget:"+ds_budget+":I_EMPNO:"+I_EMPNO);
				for(int i=0; i<rows.length; i++){
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("ds1�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					
					System.out.println(":cost_cd:"+rows[i].getString(cost_cd));
					System.out.println(":cost_cd:"+rows[i].getString(ty_budget));
					System.out.println(":cost_cd:"+rows[i].getString(ds_budget));
					System.out.println(":cost_cd:"+rows[i].getString(I_EMPNO));
					//���� ȣ��
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setString(1, rows[i].getString(cost_cd));
					cstmt.setString(2, rows[i].getString(ty_budget));
					cstmt.setString(3, rows[i].getString(ds_budget));	
					cstmt.setString(4, rows[i].getString(I_EMPNO));	
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
				}
			}
			if (ds_item_d != null) {
				System.out.println("���࿹���û���� �Ѿ�Խ��ϴ� BUD020.jsp");
				GauceDataRow[] 		rows = ds_item_d.getDataRows();
				int colNm_COST_CD		= ds_item_d.indexOfColumn("COST_CD");        // ������Ʈ�ڵ�            
				int colNm_NO_BUDGET        = ds_item_d.indexOfColumn("NO_BUDGET");   // ����       
				int colNm_CD_COST		= ds_item_d.indexOfColumn("CD_COST");		//�󼼺з��ڵ�
				int colNm_DS_KSITEM    	= ds_item_d.indexOfColumn("DS_KSITEM");     //ǰ���
				int colNm_ORDER_AMT_NOW    = ds_item_d.indexOfColumn("ORDER_AMT_NOW");   // ���ޱݾ�(����)         
				int colNm_EXE_ACT_AMT_NOW      = ds_item_d.indexOfColumn("EXE_ACT_AMT_NOW");        // ���࿹��(����) 
  
				for(int i=0; i<rows.length; i++){
						System.out.println(":colNm_COST_CD:"+rows[i].getString(colNm_COST_CD));
						System.out.println(":colNm_NO_BUDGET:"+rows[i].getString(colNm_NO_BUDGET));
						System.out.println(":colNm_CD_COST:"+rows[i].getString(colNm_CD_COST));
						System.out.println(":colNm_DS_KSITEM:"+rows[i].getString(colNm_DS_KSITEM));
						System.out.println(":colNm_ORDER_AMT_NOW:"+rows[i].getString(colNm_ORDER_AMT_NOW));
						System.out.println(":colNm_EXE_ACT_AMT_NOW:"+rows[i].getString(colNm_EXE_ACT_AMT_NOW));
						System.out.println("jobtype"+rows[i].getJobType());
						System.out.println("iParamEmpno"+iParamEmpno);
					
					if(rows[i].getJobType()==2){
						cstmt = conn.prepareCall(arr_sql[7].toString());
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(6, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setInt(7, rows[i].getJobType() );	//���콺�� �۾� ��
						cstmt.setString(8, iParamEmpno);
						cstmt.executeUpdate();
						
					}else if(rows[i].getJobType()==3){
						cstmt = conn.prepareCall(arr_sql[7].toString());
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(6, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setInt(7, rows[i].getJobType() );	//���콺�� �۾� ��
						cstmt.setString(8, iParamEmpno);
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}
	}
}