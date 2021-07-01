package pms.news.sta;

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

public class Sta500 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		
		
				//ds_default ��ȸ
				arr_sql[1].append ("{call PMS.PR_NEW_STA500S_01(?,?,?)}");
				

				//ds_default ����
				arr_sql[2].append ("{call PMS.PR_NEW_STA500S_02(?,?,?,?,?,?,?,?,?,?,?,?)}");


   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		ResultSet rs = null;

		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
            //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

    		
            for(int i=0; i<dSets.length;i++){
            	
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	
            	StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[0].toString());

					
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
	
	
	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		
		ResultSet rs = null;



		String v_frdt 				= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//��ȸ�Ⱓ
		String v_todt 				= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//��ȸ�Ⱓ

		
		//StringUtil.printMsg("# Command","����",this);
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            	
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_frdt);
					cstmt.setString(2, v_todt);
					
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
	
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
		/* 2013.10.22 �ɵ���
		 * �̷��� TR�� ȣ���մϴ�. 
		 * 		 * "JSP(I:DS1=ds1,I:DS2=ds2,I:DS3=ds3)",
		 * 	���� gis.read�� �������� ��.
		 * */
	
		//StringUtil.printMsg("# Command","����",this);
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

			
		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();
        
		/* DataSet */
        // (ds_default.IsUpdated) {
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