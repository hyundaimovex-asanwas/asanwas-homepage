package DDms;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceStatement;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;
import java.sql.*; 
import oracle.jdbc.OracleTypes;

public class dd100_s2 extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();


		//System.out.println("a010001_s1 \n" + arr_sql[1].toString());		
		//System.out.println("이동훈 \n");		
		//업체 추천이 있을 경우
		arr_sql[1].append ("{call ASNHR.PR_DD100S_S02(?,?,?) }" );
		 	
		
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 

			for(int i=0; i<dSets.length;i++){

				if(dSets[i].getName().equals("gcds_date")){

						GauceDataSet ds1 = gis.read("gcds_date"); 
						
						cstmt = conn.prepareCall(arr_sql[1].toString());

						//int  v_ap_m_sid	= HDUtil.nullCheckNum(greq.getParameter("v_ap_m_sid")); 		// 결재sid
						String v_fr_inout_dt 	    = HDUtil.nullCheckStr(greq.getParameter("v_fr_inout_dt")); 		// 일자 시작
						String v_to_inout_dt	    = HDUtil.nullCheckStr(greq.getParameter("v_to_inout_dt")); 	// 일자 종료
						
						//System.out.println("v_fr_inout_dt \n" + v_fr_inout_dt);		
						//System.out.println("v_to_inout_dt \n" + v_to_inout_dt);
						
						cstmt.setString(1, v_fr_inout_dt);
						cstmt.setString(2, v_to_inout_dt);
						
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
				

				}					
				
			}
			
				 gos.close();
				 
			}catch (SQLException sqle){
				//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
				throw sqle;
				
			} catch (Exception e){
				//res.writeException("ERROR", "", e.toString());
				throw e;
				
			} finally {
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
			}
		}

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {	
		
		CallableStatement cstmt = null;	
		GauceStatement 	stmt 		= null;
		ResultSet 		rs 			= null;
						
		/* DataSet */
		CallableStatement cstmt2 = null;
		ResultSet rs2 = null;				
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet msgDS = gis.read("msgDS");
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{

		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
	
}