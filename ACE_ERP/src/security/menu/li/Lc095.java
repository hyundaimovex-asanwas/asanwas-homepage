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
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import pms.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Lc095 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call SECURITY.PR_LC095S_01(?,?,?) }" );
		
		// 저장
		arr_sql[1].append ("{call SECURITY.PR_LC095I_01(?) }" );		
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_staxdate    	= HDUtil.nullCheckStr(greq.getParameter("v_staxdate")); 				
		String v_car    			= HDUtil.nullCheckStr(greq.getParameter("v_car")); 		

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
					cstmt.setString(2, v_car);
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
	
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
				
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
			
		CallableStatement cstmt_ms  = null;	
		ResultSet 			rs_ms 		= null;		
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
		/* DataSet */
		GauceDataSet ds1 = gis.read("DS_DEFAULT2");

		  
		try{
			if (ds1 != null) {
				
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
					
				int colNm_ENO_NO       = ds1.indexOfColumn("ENO_NO");		    	//ENO_NO 

				for(int i=0; i<rows.length; i++){
					
					int j=1;

					switch(rows[i].getJobType()){
					
						case GauceDataRow.TB_JOB_INSERT:
							
							
							//StringUtil.printMsg("colNm_ENO_NO::",rows[i].getString(colNm_ENO_NO),this);	
							 

							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setString(1, rows[i].getString(colNm_ENO_NO));
							
							cstmt.executeUpdate();
							
							if(cstmt!=null) cstmt.close();		
							break;

							
						case GauceDataRow.TB_JOB_UPDATE:
							
					        //StringUtil.printMsg("TB_JOB_UPDATE::",rows[i].getJobType(),this);

						case GauceDataRow.TB_JOB_DELETE:

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