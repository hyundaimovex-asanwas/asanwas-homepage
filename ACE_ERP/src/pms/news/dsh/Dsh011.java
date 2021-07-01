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

public class Dsh011 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		

				//ds_tab1조회
				arr_sql[1].append ("{call PMS.PR_NEW_DSH011_01(?,?)}");
				
				//ds_tab2조회
				arr_sql[2].append ("{call PMS.PR_NEW_DSH011_02(?,?)}");
				
				//ds_tab3조회
				arr_sql[3].append ("{call PMS.PR_NEW_DSH011_03(?,?)}");				
				
				//ds_tab3조회
				arr_sql[32].append ("{call PMS.PR_NEW_DSH011_032(?,?)}");					
				
				//ds_tab4조회
				arr_sql[4].append ("{call PMS.PR_NEW_DSH011_04(?,?)}");				
				
				

				//ds_tab3 insert update쿼리
				arr_sql[8].append ("{call PMS.PR_NEW_DSH011_08(?,?,?,?,?,?,?,?,?,?)}");					
				
				
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

		String v_project			= HDUtil.nullCheckStr(greq.getParameter("v_project"));				//프로젝트

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_tab1")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB1");

					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서

					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 					
				
					gos.write(getDataSet(rs, ds1));

            	}


            	if(dSets[i].getName().equals("ds_tab2")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_project);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
            	}            	
            	
            	
            	if(dSets[i].getName().equals("ds_tab3")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB3");

					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					cstmt.setString(1, v_project);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
            	}   
            	
            	if(dSets[i].getName().equals("ds_tab32")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB32");

					cstmt = conn.prepareCall(arr_sql[32].toString());
					
					cstmt.setString(1, v_project);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();

					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	
					
					gos.write(getDataSet(rs, ds1));
            	}               	
            	
            	if(dSets[i].getName().equals("ds_tab4")){
            		
					GauceDataSet ds1 = gis.read("DS_TAB4");
					
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setString(1, v_project);
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	

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

        //수행인원 저장 
        GauceDataSet ds_tab3 = gis.read("DS_TAB3");


		try{

			if (ds_tab3 != null) {
				
				GauceDataRow[] 		rows = ds_tab3.getDataRows();
				
				int colNm_COST_CD				= ds_tab3.indexOfColumn("COST_CD");        		// 프로젝트코드 
				int colNm_SEQ					= ds_tab3.indexOfColumn("SEQ");					// SEQ				
				int colNm_ENO_NO				= ds_tab3.indexOfColumn("ENO_NO");				// 직원 사번
				int colNm_ENO_NM    			= ds_tab3.indexOfColumn("ENO_NM");     			// 직원 성명
				int colNm_JOB_CD    			= ds_tab3.indexOfColumn("JOB_CD");     			// 직위코드
				int colNm_JOB_NM    			= ds_tab3.indexOfColumn("JOB_NM");   			// 직위명       
				int colNm_FR_DT      			= ds_tab3.indexOfColumn("FR_DT");       		// 투입시작일자 
				int colNm_TO_DT      			= ds_tab3.indexOfColumn("TO_DT");       		// 투입종료일자 


				
				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){
						
						cstmt = conn.prepareCall(arr_sql[8].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
						
					}else if(rows[i].getJobType()==3){

						cstmt = conn.prepareCall(arr_sql[8].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
						cstmt.setString(10, iParamEmpno);

						cstmt.executeUpdate();
						
					}else if(rows[i].getJobType()==4){

						cstmt = conn.prepareCall(arr_sql[8].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));	
						cstmt.setString(2, rows[i].getString(colNm_SEQ));						
						cstmt.setString(3, rows[i].getString(colNm_ENO_NO));	
						cstmt.setString(4, rows[i].getString(colNm_ENO_NM));
						cstmt.setString(5, rows[i].getString(colNm_JOB_CD));	
						cstmt.setString(6, rows[i].getString(colNm_JOB_NM));
						cstmt.setString(7, rows[i].getString(colNm_FR_DT));	
						cstmt.setString(8, rows[i].getString(colNm_TO_DT));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
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