package pms.news.dsh;

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

public class Dsh010 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		

				//ds_default ��ȸ
				arr_sql[1].append ("{call PMS.PR_NEW_DSH010_01(?,?,?)}");

   }

	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		ResultSet rs = null;

		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            GauceDataSet[] dSets = gis.readAllOutput(); 

            for(int i=0; i<dSets.length;i++){


            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					
					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//Ŀ�� OUT param. 					
				
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
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		ResultSet rs = null;

		String v_code				= HDUtil.nullCheckStr(greq.getParameter("v_code"));					//���ͱ��м���
		String v_project			= HDUtil.nullCheckStr(greq.getParameter("v_project"));				//������Ʈ

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            	
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_code);					
					cstmt.setString(2, v_project);

					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
				
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
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

		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();

        GauceDataSet ds_default 		= gis.read("DS_DEFAULT");

		try{
			
			if (ds_default != null) {
				
				GauceDataRow[] 		rows = ds_default.getDataRows();
				
                 
				int colNm_CD_ITEM        	= ds_default.indexOfColumn("CD_ITEM");          
				int colNm_DS_KSITEM			= ds_default.indexOfColumn("DS_KSITEM");
				int colNm_SZ_ITEM    		= ds_default.indexOfColumn("SZ_ITEM");   
				int colNm_UT_ITEM        	= ds_default.indexOfColumn("UT_ITEM");          
				int colNm_CD_BIG			= ds_default.indexOfColumn("CD_BIG");
				int colNm_CD_MID    		= ds_default.indexOfColumn("CD_MID");   
				int colNm_CD_SMALL        	= ds_default.indexOfColumn("CD_SMALL");          
				int colNm_AMT_ITEM			= ds_default.indexOfColumn("AMT_ITEM");
				int colNm_DT_APPLY    		= ds_default.indexOfColumn("DT_APPLY");   
				int colNm_TREE_LEVEL        = ds_default.indexOfColumn("TREE_LEVEL");          
			
   

				for(int i=0; i<rows.length; i++){
			
					//StringUtil.printMsg("ds_default "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					/*
					StringUtil.printMsg("colNm_CD_ITEM",rows[i].getString(colNm_CD_ITEM),this);
					StringUtil.printMsg("colNm_DS_KSITEM",rows[i].getString(colNm_DS_KSITEM),this);
					StringUtil.printMsg("colNm_CD_BIG",rows[i].getString(colNm_CD_BIG),this);
					StringUtil.printMsg("colNm_AMT_ITEM",rows[i].getString(colNm_AMT_ITEM),this);
					StringUtil.printMsg("colNm_DT_APPLY",rows[i].getString(colNm_DT_APPLY),this);
					StringUtil.printMsg("colNm_TREE_LEVEL",rows[i].getString(colNm_TREE_LEVEL),this);					
					StringUtil.printMsg("jobtype",rows[i].getJobType(),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					*/
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_CD_ITEM));
					cstmt.setString(2, rows[i].getString(colNm_DS_KSITEM));	
					cstmt.setString(3, rows[i].getString(colNm_SZ_ITEM));	
					cstmt.setString(4, rows[i].getString(colNm_UT_ITEM));
					cstmt.setString(5, rows[i].getString(colNm_CD_BIG));	
					cstmt.setString(6, rows[i].getString(colNm_CD_MID));	
					cstmt.setString(7, rows[i].getString(colNm_CD_SMALL));	
					cstmt.setString(8, rows[i].getString(colNm_AMT_ITEM));
					cstmt.setString(9, rows[i].getString(colNm_DT_APPLY));	
					cstmt.setString(10, rows[i].getString(colNm_TREE_LEVEL));						
					
					cstmt.setInt(11, rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.setString(12, iParamEmpno);
					
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