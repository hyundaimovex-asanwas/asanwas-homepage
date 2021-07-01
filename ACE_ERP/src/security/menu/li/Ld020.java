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

public class Ld020 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();

		//차량 조회
		arr_sql[0].append ("{call SECURITY.PR_LD020S_00(?) }" );			
		
		arr_sql[1].append ("{call SECURITY.PR_LD020S_01(?,?) }" );
		
		arr_sql[2].append ("{call SECURITY.PR_LD020S_02(?,?) }" );		
		
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_staxdate = HDUtil.nullCheckStr(greq.getParameter("v_staxdate")); 				// 일자

		
		try {
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            
            	
				//O:DS_DEFAULT=ds_default
            	
            	if(dSets[i].getName().equals("gcds_car")){
            		
					GauceDataSet ds1 = gis.read("gcds_car");

					cstmt = conn.prepareCall(arr_sql[0].toString());
				
					//cstmt.setString(1, v_staxdate);

					cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 	

					gos.write(getDataSet(rs, ds1));
					
            	}              	
            	
            	
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");

					cstmt = conn.prepareCall(arr_sql[1].toString());
				
					cstmt.setString(1, v_staxdate);

					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 	

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
		
	}
	
	
	
	
}