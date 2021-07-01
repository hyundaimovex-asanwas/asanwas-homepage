package pms.news.bid;

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

public class Bid011 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		
		

				//	default ��ȸ
				arr_sql[1].append ("{call PMS.PR_NEW_BID011_01(?,?)}");

				
				//	insert/update ����
				arr_sql[2].append ("{call PMS.PR_NEW_BID011_02(?,?,?,?,?,?)}");
				


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
		ResultSet rs			= null;

			
		String v_bid 			= HDUtil.nullCheckStr(greq.getParameter("v_bid"));		


        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
		try {
            
			
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
						cstmt = conn.prepareCall(arr_sql[1].toString());
					 
					 	cstmt.setString(1, v_bid);	

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

        GauceDataSet ds_default = gis.read("DS_DEFAULT");

        
		try{
			
			if (ds_default != null) {
				
				GauceDataRow[] 		rows = ds_default.getDataRows();

				int colNm_BID_CD				= ds_default.indexOfColumn("BID_CD");        		// ������Ʈ�ڵ�            
				int colNm_BID_NM       			= ds_default.indexOfColumn("BID_NM");   			// ����       
				int colNm_BID_DT				= ds_default.indexOfColumn("BID_DT");				// �󼼺з��ڵ�
				int colNm_ESTIMATE_AMT    		= ds_default.indexOfColumn("ESTIMATE_AMT");     	// ǰ���
				int colNm_YN_RESULT    			= ds_default.indexOfColumn("YN_RESULT");     		// node,leaf ����
				int jobtype 	= 3;

				for(int i=0; i<rows.length; i++){
					
					// ���콺 �� JobType : 2=insert, 3=update, 4=delete
					//StringUtil.printMsg("ds1�� "+i+"�� �۾�===",rows[i].getJobType(),this);
					//���� ȣ��
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_BID_CD));
					cstmt.setString(2, rows[i].getString(colNm_BID_NM));
					cstmt.setString(3, rows[i].getString(colNm_BID_DT));	
					cstmt.setString(4, rows[i].getString(colNm_ESTIMATE_AMT));	
					cstmt.setString(5, rows[i].getString(colNm_YN_RESULT));						
					cstmt.setString(6, iParamEmpno);					
					
					
					cstmt.executeUpdate();
					
					if(cstmt!=null) cstmt.close();		
				}
			}
			
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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




