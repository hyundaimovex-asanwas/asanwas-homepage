package security.menu.li;

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
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;


import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Lm020 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		// 조회
		arr_sql[0].append ("{call SECURITY.PR_LM020S_01(?,?,?,?,?,?) }" );
		
		// 중복시간 조회
		arr_sql[1].append ("{call SECURITY.PR_LM020S_02(?,?,?,?,?) }" );		
		
		// 저장
		arr_sql[2].append ("{call SECURITY.PR_LM020I_01(?,?,?,?,?,?,?,?) }" );
	
		// 삭제
		arr_sql[3].append ("{call SECURITY.PR_LM020D_01(?,?,?,?) }" );		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_staxdate  = HDUtil.nullCheckStr(greq.getParameter("v_staxdate")); 			// 일자
		String v_gusrid    = HDUtil.nullCheckStr(greq.getParameter("v_gusrid")); 				// 예약자
		String v_car        = HDUtil.nullCheckStr(greq.getParameter("v_car")); 				    // 차		
		String v_from_tm = HDUtil.nullCheckStr(greq.getParameter("v_from_tm")); 				// 시작시간	
		String v_to_tm    = HDUtil.nullCheckStr(greq.getParameter("v_to_tm")); 				// 종료시간	

		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
				//O:DS_DEFAULT=ds_default
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[0].toString());
				
					cstmt.setString(1, v_staxdate);
					cstmt.setString(2, v_gusrid);
					cstmt.setString(3, v_car);					
					cstmt.setString(4, v_from_tm);				
					cstmt.setString(5, v_to_tm);							
					
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 	
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));
					
				}else if (dSets[i].getName().equals("ds_check")){
					
					GauceDataSet ds1 = gis.read("DS_CHECK");

					cstmt = conn.prepareCall(arr_sql[1].toString());
				
					cstmt.setString(1, v_staxdate);
					cstmt.setString(2, v_car);		
					cstmt.setString(3, v_from_tm);					
					cstmt.setString(4, v_to_tm);							

					
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 	
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					
					//	getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
					gos.write(getDataSet(rs, ds1));			
					

            	}

            }
		}catch (SQLException sqle){
			
			gres.addException(sqle);
			throw sqle;
			
		} catch (Exception e){
			
			gres.addException(e);
			throw e;
			
		} finally {
			
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
			
		}
	}
	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt      = null;	
		ResultSet 			rs 			= null;
			
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT");

		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_CAR_NO     	= ds1.indexOfColumn("CAR_NO");        		//CAR_NO    
				int colNm_DRIVE_DT       = ds1.indexOfColumn("DRIVE_DT");		    	//DRIVE_DT      
				int colNm_FROM_TM      = ds1.indexOfColumn("FROM_TM");				//FROM_TM       
				int colNm_TO_TM        	= ds1.indexOfColumn("TO_TM");					//TO_TM    
				int colNm_ENO_NO      	= ds1.indexOfColumn("ENO_NO");		    	//ENO_NO     
				int colNm_SAYU        	= ds1.indexOfColumn("SAYU");					//SAYU       
				int colNm_REMARK        = ds1.indexOfColumn("REMARK");				//REMARK     
				int colNm_STATUS         = ds1.indexOfColumn("STATUS");				//STATUS


				for(int i=0; i<rows.length; i++){
					
					int j=1;

					switch(rows[i].getJobType()){
					
						case GauceDataRow.TB_JOB_INSERT:
						 					   
					        //StringUtil.printMsg("TB_JOB_INSERT::",rows[i].getJobType(),this);					
							
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
							cstmt.setString(5, rows[i].getString(colNm_ENO_NO));
							cstmt.setString(6, rows[i].getString(colNm_SAYU));
							cstmt.setString(7, rows[i].getString(colNm_REMARK));
							cstmt.setString(8, rows[i].getString(colNm_STATUS));									


							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();		
							break;
							

						case GauceDataRow.TB_JOB_UPDATE:
							
					        //StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
							
						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
							cstmt.setString(5, rows[i].getString(colNm_ENO_NO));
							cstmt.setString(6, rows[i].getString(colNm_SAYU));
							cstmt.setString(7, rows[i].getString(colNm_REMARK));
							cstmt.setString(8, rows[i].getString(colNm_STATUS));									

							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;
							
							
						case GauceDataRow.TB_JOB_DELETE:
							
							//StringUtil.printMsg("TB_JOB_DELETE::",rows[i].getJobType(),this);
							
							cstmt = conn.prepareCall(arr_sql[3].toString());

						    cstmt.setString(1, rows[i].getString(colNm_CAR_NO));
							cstmt.setString(2, rows[i].getString(colNm_DRIVE_DT));
							cstmt.setString(3, rows[i].getString(colNm_FROM_TM));
							cstmt.setString(4, rows[i].getString(colNm_TO_TM));
						
							
							cstmt.executeUpdate();
					
							if(cstmt!=null) cstmt.close();	
							break;						
							
					}
					
				}
				
			}
			
			gos.close();
			
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
		
	}
	

}