package pms.news.pro;
//	si110i
//	si110i_h1 사용

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

public class Pr010 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//project list : Master 조회
		arr_sql[1].append ("{call PMS.PR_NEW_PRO010_01(?,?,?,?) }" );
		

		//project list : Master 저장
		arr_sql[2].append ("{call PMS.PR_NEW_PRO010_02(?,?,?) }" );
		
		
		//project list : Master 등록 요청
		arr_sql[3].append ("{call PMS.PR_NEW_PRO010_03(?,?) }" );
		
		
		//project list : 삭제
		arr_sql[4].append ("{call PMS.PR_NEW_PRO010_04(?) }" );
		
	}

	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//init method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		//StringUtil.printMsg("초기화~!","",this);
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		
		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, "");
					cstmt.setString(2, "");
					cstmt.setString(3, "A");
					cstmt.setString(4, "");
					cstmt.setString(5, "");
					cstmt.setString(6, "");
					
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(7);	//커서 OUT param. 
					
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
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//select method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

		String v_project 			= HDUtil.nullCheckStr(greq.getParameter("v_project"));				// 프로젝트명
		String v_prop1 				= HDUtil.nullCheckStr(greq.getParameter("v_prop1"));				// 손익센터
		String v_prop2 				= HDUtil.nullCheckStr(greq.getParameter("v_prop2"));				// 사업구분


		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
            	
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project);					
					cstmt.setString(2, v_prop1);
					cstmt.setString(3, v_prop2);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(4);	//커서 OUT param. 					
				
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
	
	
	
	
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//apply method
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		//StringUtil.printMsg("저장~!","",this);
		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		String iParamEmpno 	= fParamEmpno;

		
		GauceInputStream gis  = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		/* DataSet */
        GauceDataSet ds_default = gis.read("DS_DEFAULT");
        GauceDataSet ds_cult	= gis.read("DS_CULT");
        GauceDataSet ds_culd	= gis.read("DS_CULD");
        
		try{
			if (ds_default != null) {
				
				GauceDataRow[] 	rows    = ds_default.getDataRows();
				
				int colNm_REQUEST_CD  		= ds_default.indexOfColumn("REQUEST_CD");
				int colNm_FILE_KEY    		= ds_default.indexOfColumn("FILE_KEY");
  
				for(int i=0; i<rows.length; i++){

					//System.out.println(":cost_cd:"+rows[i].getString(colNm_REQUEST_CD));
					//System.out.println(":cost_cd:"+rows[i].getString(colNm_FILE_KEY));

					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_REQUEST_CD) );
					cstmt.setString(2, rows[i].getString(colNm_FILE_KEY));
					cstmt.setString(3, iParamEmpno);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();		
						
				}
			}

			if (ds_cult != null) {
				
				GauceDataRow[] 	rows    = ds_cult.getDataRows();
				
				int colNm_REQUEST_CD  	= ds_cult.indexOfColumn("REQUEST_CD");

				for(int i=0; i<rows.length; i++){				
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_REQUEST_CD) );
					cstmt.setString(2, iParamEmpno);
					
					cstmt.executeUpdate();
					
					if(cstmt!=null) cstmt.close();		
						
				}				

			}
			
			if (ds_culd != null) {
				
				GauceDataRow[] 	rows    = ds_culd.getDataRows();

				int colNm_REQUEST_CD  	= ds_culd.indexOfColumn("REQUEST_CD");

				for(int i=0; i<rows.length; i++){				
					System.out.println(":cost_cd:"+rows[i].getString(colNm_REQUEST_CD));
					cstmt = conn.prepareCall(arr_sql[4].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_REQUEST_CD) );
					
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