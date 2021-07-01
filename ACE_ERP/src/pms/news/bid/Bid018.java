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

public class Bid018 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		

				//ds_tab1��ȸ - �����ο�
				arr_sql[1].append ("{call PMS.PR_NEW_BID018_01(?,?)}");
				
				//ds_tab2��ȸ - ���ͺм�
				arr_sql[2].append ("{call PMS.PR_NEW_BID018_02(?,?)}");
				

				
				//ds_tab1 insert update����
				arr_sql[5].append ("{call PMS.PR_NEW_BID018_05(?,?,?,?,?,?,?,?,?,?)}");					
				
				
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
		
		ResultSet rs = null;

		String v_bid_cd			= HDUtil.nullCheckStr(greq.getParameter("v_bid_cd"));				//v_bid_cd

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
          //Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	//�����ο�
            	if(dSets[i].getName().equals("ds_tab1")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB1");

					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_bid_cd);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��

					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
				
					gos.write(getDataSet(rs, ds1));

            	}

            	// ���ͺм�
            	if(dSets[i].getName().equals("ds_tab2")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_bid_cd);
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

        //�����ο� ���� 
        GauceDataSet ds_tab3 = gis.read("DS_TAB1");


		try{

			if (ds_tab3 != null) {
				
				GauceDataRow[] 		rows = ds_tab3.getDataRows();
				
				int colNm_BID_CD				= ds_tab3.indexOfColumn("BID_CD");        		// BID�ڵ� 
				int colNm_SEQ					= ds_tab3.indexOfColumn("SEQ");					// SEQ				
				int colNm_ENO_NO				= ds_tab3.indexOfColumn("ENO_NO");				// ���� ���
				int colNm_ENO_NM    			= ds_tab3.indexOfColumn("ENO_NM");     			// ���� ����
				int colNm_JOB_CD    			= ds_tab3.indexOfColumn("JOB_CD");     			// �����ڵ�
				int colNm_JOB_NM    			= ds_tab3.indexOfColumn("JOB_NM");   			// ������       
				int colNm_FR_DT      			= ds_tab3.indexOfColumn("FR_DT");       		// ���Խ������� 
				int colNm_TO_DT      			= ds_tab3.indexOfColumn("TO_DT");       		// ������������ 


				
				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){
						
						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_BID_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//���콺�� �۾� ��
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
						
					}else if(rows[i].getJobType()==3){

						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_BID_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//���콺�� �۾� ��
						
						cstmt.setString(10, iParamEmpno);

						cstmt.executeUpdate();
						
					}else if(rows[i].getJobType()==4){

						cstmt = conn.prepareCall(arr_sql[5].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_BID_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
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