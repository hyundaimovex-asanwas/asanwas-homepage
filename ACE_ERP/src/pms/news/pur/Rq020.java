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

public class Rq020 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			
			arr_sql[i] = new StringBuffer();
		

				//ds_default 조회
				arr_sql[1].append ("{call PMS.PR_NEW_RQ020_01(?,?,?,?,?)}");
				

				//ds_default 저장
				arr_sql[2].append ("{call PMS.PR_NEW_RQ020_02(?,?,?)}");


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
            
            //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

    		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));			//프로젝트명
    		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//조회기간
    		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//조회기간
    		String v_stat			= HDUtil.nullCheckStr(greq.getParameter("v_stat"));				//처리 상태

    		
            for(int i=0; i<dSets.length;i++){
            	
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);	
            	
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	
            	StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());

					cstmt.setString(1, v_project);
					cstmt.setString(2, v_frdt);
					cstmt.setString(3, v_todt);
					cstmt.setString(4, v_stat);
					
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
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
		
		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));			//프로젝트명
		String v_frdt 			= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));				//조회기간
		String v_todt 			= HDUtil.nullCheckStr(greq.getParameter("v_todt"));				//조회기간
		String v_stat			= HDUtil.nullCheckStr(greq.getParameter("v_stat"));				//처리 상태


        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
         
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            	
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_frdt);
					cstmt.setString(3, v_todt);
					cstmt.setString(4, v_stat);
					
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					
				
					//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
					//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
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
	
	
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	

		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;
		String v_stat 		= HDUtil.nullCheckStr(greq.getParameter("v_stat"));		// status       
			
		GauceInputStream gis 	= greq.getGauceInputStream();
        GauceOutputStream gos 	= gres.getGauceOutputStream();
        

        GauceDataSet ds_default 		= gis.read("DS_DEFAULT");

		try{
			
			if (ds_default != null) {
				
				GauceDataRow[] 		rows = ds_default.getDataRows();
				
                 
				int colNm_NO_MA_REQUEST        	= ds_default.indexOfColumn("NO_MA_REQUEST");          

				for(int i=0; i<rows.length; i++){

					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_NO_MA_REQUEST));
					cstmt.setString(2, v_stat);
					cstmt.setString(3, iParamEmpno);

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