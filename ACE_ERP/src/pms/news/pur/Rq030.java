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

public class Rq030 extends SuperServlet {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;

	
	public void makeSql(){
		
		
		for(int i=0; i<arr_sql.length; i++)
			
			
			arr_sql[i] = new StringBuffer();
		
		
				//	default1 ��ȸ  
				arr_sql[1].append ("{call PMS.PR_NEW_RQ030_01(?,?,?) }" );
				
				
				
				// default2 ��ȸ , �����Ƿڼ� ���� �˻� 
				arr_sql[2].append ("{call PMS.PR_NEW_RQ030_02(?,?,?) }" );
				
				
				
				//	������ü List ��ȸ
				arr_sql[3].append ("{call PMS.PR_NEW_RQ030_03(?,?,?) }" );
				
				
				
				//	default ��ȸ  , �����Ƿڼ� ������(��ü ���� list) ,��ȸ  - project_code , v_request_no
				//arr_sql[4].append ("{call PMS.PR_NEW_RQ030S_04(?,?,?) }" );
				
				
				
				//	���� ���� insert
				arr_sql[5].append ("{call PMS.PR_NEW_RQ030S_05(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }" );
				
				
				//�������!!
				

				//	default ����  , �����Ƿڼ� ������(û�� ǰ�� list) ,����  - REQUST_QN 
				arr_sql[6].append ("{call PMS.PR_NEW_RQ010S_06(?,?,?,?,?,?,?,?) }" );
				
				


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
		
		CallableStatement 	cstmt 	= null;
		ResultSet 				rs 	= null;

		String v_request_no 			= HDUtil.nullCheckStr(greq.getParameter("v_request_no"));			// ���ϰ���
		String v_project_code 			= HDUtil.nullCheckStr(greq.getParameter("v_project_code"));			// ���ϰ���

		

		//System.out.println("select �Դϴ�.");
		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
        
		try {
            
            
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){


            	// arr_sql[1] [�⺻ ���� List]
            	if(dSets[i].getName().equals("ds_default")){

					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project_code); //������Ʈ ��(code)�� �� ����
					cstmt.setString(2, v_request_no); //�����Ƿڼ� ��ȣ 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();	//����
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
            	
            	
            	// arr_sql[2] [û�� ǰ�� List]
            	if(dSets[i].getName().equals("ds_default2")){

            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_project_code); //������Ʈ ��(code)�� �� ����
					cstmt.setString(2, v_request_no); //�����Ƿڼ� ��ȣ 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();	//����
					
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
            	
            	// arr_sql[3] [���� ��ü List]
            	if(dSets[i].getName().equals("ds_default3")){

            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT3");
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					
					cstmt.setString(1, v_project_code); //������Ʈ ��(code)�� �� ����
					cstmt.setString(2, v_request_no);   //�����Ƿڼ� ��ȣ 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					
					cstmt.executeQuery();	//����
					
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
        

        
        GauceDataSet ds_culdes = gis.read("DS_CULDES");
        //GauceDataSet ds_culds  = gis.read("DS_CULDS");

		
        
		
		try{
			
			
			if (ds_culdes != null) {
				
				GauceDataRow[] 		rows = ds_culdes.getDataRows();
				

				int colNm_NO_ESTIMATE	 	= ds_culdes.indexOfColumn("NO_ESTIMATE");			//������ ��ȣ          
				int colNm_COST_CD		    = ds_culdes.indexOfColumn("COST_CD");  				//project code    
				int colNm_NO_MA_REQUEST	 	= ds_culdes.indexOfColumn("NO_MA_REQUEST");			//�����Ƿڼ� ��ȣ        
				int colNm_VEND_NM		    = ds_culdes.indexOfColumn("VEND_NM");   			//��ü��             
				int colNm_CD_VENDOR		 	= ds_culdes.indexOfColumn("CD_VENDOR");				//����� ��Ϲ�ȣ        
				int colNm_VD_DIRECT		    = ds_culdes.indexOfColumn("VD_DIRECT");   			//��ǥ��             
				int colNm_BSNS_CND		 	= ds_culdes.indexOfColumn("BSNS_CND");				//����              
				int colNm_BSNS_KND		    = ds_culdes.indexOfColumn("BSNS_KND");   			//����              
				int colNm_VD_TELNO		 	= ds_culdes.indexOfColumn("VD_TELNO");				//����ó             
				int colNm_AM_ESTIMATE	    = ds_culdes.indexOfColumn("AM_ESTIMATE");  			//���� �ݾ�           
				int colNm_CHOICE_REASON	 	= ds_culdes.indexOfColumn("CHOICE_REASON");			//���� ����           
				int colNm_YN_SELECT		    = ds_culdes.indexOfColumn("YN_SELECT");  			//��û ����
				

				for(int i=0; i<rows.length; i++){
					
					/*
					StringUtil.printMsg("colNm_NO_ESTIMATE	",rows[i].getString(colNm_NO_ESTIMATE	),this);
					StringUtil.printMsg("colNm_COST_CD		",rows[i].getString(colNm_COST_CD		),this);
					StringUtil.printMsg("colNm_NO_MA_REQUEST",rows[i].getString(colNm_NO_MA_REQUEST	),this);
					StringUtil.printMsg("colNm_VEND_NM		",rows[i].getString(colNm_VEND_NM		),this);
					StringUtil.printMsg("colNm_CD_VENDOR	",rows[i].getString(colNm_CD_VENDOR		),this);
					StringUtil.printMsg("colNm_VD_DIRECT	",rows[i].getString(colNm_VD_DIRECT		),this);
					StringUtil.printMsg("colNm_BSNS_CND		",rows[i].getString(colNm_BSNS_CND		),this);
					StringUtil.printMsg("colNm_BSNS_KND		",rows[i].getString(colNm_BSNS_KND		),this);
					StringUtil.printMsg("colNm_VD_TELNO		",rows[i].getString(colNm_VD_TELNO		),this);
					StringUtil.printMsg("colNm_AM_ESTIMATE	",rows[i].getString(colNm_AM_ESTIMATE	),this);
					StringUtil.printMsg("colNm_CHOICE_REASON",rows[i].getString(colNm_CHOICE_REASON	),this);
					StringUtil.printMsg("colNm_YN_SELECT	",rows[i].getString(colNm_YN_SELECT		),this);
					StringUtil.printMsg("colNm_COST_CD		",rows[i].getString(colNm_COST_CD		),this);
					 */
					//StringUtil.printMsg("ds_default "+i+"�� �۾�===",rows[i].getJobType(),this);
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					cstmt = conn.prepareCall(arr_sql[4].toString());

					
					cstmt.setString(1, rows[i].getString(colNm_NO_ESTIMATE));		//������ ��ȣ                   
					cstmt.setString(2, rows[i].getString(colNm_COST_CD));			//project code             
					cstmt.setString(3, rows[i].getString(colNm_CD_VENDOR));			//����� ��Ϲ�ȣ            
					cstmt.setString(4, rows[i].getString(colNm_VEND_NM));			//��ü��                      
					cstmt.setString(5, rows[i].getString(colNm_VD_DIRECT));			//��ǥ��                      
					cstmt.setString(6, rows[i].getString(colNm_BSNS_CND));			//����                       
					cstmt.setString(7, rows[i].getString(colNm_BSNS_KND));			//����                       
					cstmt.setString(8, rows[i].getString(colNm_VD_TELNO));			//����ó                      
					cstmt.setString(9, rows[i].getString(colNm_NO_MA_REQUEST));		//�����Ƿڼ� ��ȣ                 
					cstmt.setString(10, rows[i].getString(colNm_AM_ESTIMATE));		//���� �ݾ�                    
					cstmt.setString(11, rows[i].getString(colNm_YN_SELECT));		//��û ����                    
					cstmt.setString(12, rows[i].getString(colNm_CHOICE_REASON));	//���� ����                    
					cstmt.setInt(13, rows[i].getJobType() );	//���콺�� �۾� ��
					cstmt.setString(14, iParamEmpno);
					
					
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




