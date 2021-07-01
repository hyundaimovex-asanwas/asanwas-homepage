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

public class Pr020 extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//project list : Master 조회
		arr_sql[1].append ("{call PMS.PR_NEW_PRO020_01(?,?,?,?,?,?) }" );


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
		String v_frdt 				= HDUtil.nullCheckStr(greq.getParameter("v_frdt"));					// 시작
		String v_todt 				= HDUtil.nullCheckStr(greq.getParameter("v_todt"));					// 끝
		String v_prop1 				= HDUtil.nullCheckStr(greq.getParameter("v_prop1"));				// 대분류 손익센터
		String v_prop2 				= HDUtil.nullCheckStr(greq.getParameter("v_prop2"));				// 중분류 사업구분


		try {
			
            GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project);	
					cstmt.setString(2, v_frdt);
					cstmt.setString(3, v_todt);
					cstmt.setString(4, v_prop1);
					cstmt.setString(5, v_prop2);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 					

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

		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        
        
		/* DataSet */
        GauceDataSet ds_default= gis.read("DS_DEFAULT");

        
        
		try{
			if (ds_default != null) {
				
				GauceDataRow[] 	rows    = ds_default.getDataRows();
				
				int colNm_job_sel			= ds_default.indexOfColumn("job_sel");
				int colNm_PLJ_CD  			= ds_default.indexOfColumn("PLJ_CD");
				int colNm_PLJ_NM    		= ds_default.indexOfColumn("PLJ_NM");
				int colNm_COST_CD      		= ds_default.indexOfColumn("COST_CD");
				int colNm_PROP1				= ds_default.indexOfColumn("PROP1");			//                   
				int colNm_PROP2				= ds_default.indexOfColumn("PROP2");			//
				int colNm_PRINT_SEQ    		= ds_default.indexOfColumn("PRINT_SEQ");  		//
				int colNm_ORDER_COMP_CD   	= ds_default.indexOfColumn("ORDER_COMP_CD");	//          
				int colNm_ORDER_COMP_NM   	= ds_default.indexOfColumn("ORDER_COMP_NM");	//        
				int colNm_PL_DEPT_CD    	= ds_default.indexOfColumn("PL_DEPT_CD");		//      
				int colNm_PL_DEPT_NM    	= ds_default.indexOfColumn("PL_DEPT_NM");		//    
				int colNm_CTRT_BGNDATE 		= ds_default.indexOfColumn("CTRT_BGNDATE");		//     
				int colNm_CTRT_ENDDATE		= ds_default.indexOfColumn("CTRT_ENDDATE");		//
				int colNm_WIN_DATE     		= ds_default.indexOfColumn("WIN_DATE");			//    
				int colNm_SALES_EXC      	= ds_default.indexOfColumn("SALES_EXC");		//         
				int colNm_EXC_NM  			= ds_default.indexOfColumn("EXC_NM");			//
				int colNm_PM   				= ds_default.indexOfColumn("PM");				//      
				int colNm_PM_NM       		= ds_default.indexOfColumn("PM_NM");			//
				int colNm_WIN_FEE      		= ds_default.indexOfColumn("WIN_FEE");			//         
				int colNm_COST_FEE 			= ds_default.indexOfColumn("COST_FEE");			//
				int colNm_NOTE   			= ds_default.indexOfColumn("NOTE,");			//      
				int colNm_USE_YN       		= ds_default.indexOfColumn("USE_YN");			//
				int colNm_DSU_DATE       	= ds_default.indexOfColumn("DSU_DATE");			//폐기일자
				
				int jobtype = 3;
				
				
				
				for(int i=0; i<rows.length; i++){

					if(rows[i].getString(colNm_job_sel).equals("T")){//chk가 체크되면 신규 인서트임.. 나머지는 걍 업데이트
						jobtype = 2;
					}

					//StringUtil.printMsg("ds_cl "+i+"행 작업===",jobtype,this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					/*StringUtil.printMsg("colNm_ca_sid",rows[i].getInt(colNm_ca_sid),this);
					StringUtil.printMsg("colNm_CACARDSPEC",rows[i].getString(colNm_CACARDSPEC),this);
					StringUtil.printMsg("colNm_CADIV",rows[i].getString(colNm_CADIV),this);
					StringUtil.printMsg("colNm_CADEPTCD",rows[i].getString(colNm_CADEPTCD),this);
					StringUtil.printMsg("colNm_CAEMPNO",rows[i].getString(colNm_CAEMPNO),this);
					StringUtil.printMsg("colNm_CANBR",rows[i].getString(colNm_CANBR),this);
					StringUtil.printMsg("colNm_CAUSEYYMM",rows[i].getString(colNm_CAUSEYYMM),this);
					StringUtil.printMsg("colNm_CAMAX",rows[i].getInt(colNm_CAMAX),this);
					StringUtil.printMsg("colNm_CAETC",rows[i].getString(colNm_CAETC),this);
					StringUtil.printMsg("colNm_CAISSYYMM",rows[i].getString(colNm_CAISSYYMM),this);
					StringUtil.printMsg("colNm_CASTTDAT",rows[i].getString(colNm_CASTTDAT),this);
					StringUtil.printMsg("colNm_CAACCBANK",rows[i].getString(colNm_CAACCBANK),this);
					StringUtil.printMsg("colNm_CABANKNO",rows[i].getString(colNm_CABANKNO),this);
					StringUtil.printMsg("colNm_CACUST",rows[i].getString(colNm_CACUST),this);
					StringUtil.printMsg("colNm_VEND_NM",rows[i].getString(colNm_VEND_NM),this);
					StringUtil.printMsg("colNm_VEND_CD",rows[i].getString(colNm_VEND_CD),this);
					StringUtil.printMsg("colNm_USE_TAG",rows[i].getString(colNm_USE_TAG),this);
					StringUtil.printMsg("colNm_DSUDT",rows[i].getString(colNm_DSUDT),this);
					StringUtil.printMsg("jobtype",jobtype+"",this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);*/

					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, rows[i].getString(colNm_PLJ_CD) );
					cstmt.setString(2, rows[i].getString(colNm_PLJ_NM));
					cstmt.setString(3, rows[i].getString(colNm_COST_CD));
					cstmt.setString(4, rows[i].getString(colNm_PROP1));
					cstmt.setString(5, rows[i].getString(colNm_PROP2));
					cstmt.setString(6, rows[i].getString(colNm_ORDER_COMP_CD));
					cstmt.setString(7, rows[i].getString(colNm_PL_DEPT_CD) );
					cstmt.setString(8, rows[i].getString(colNm_CTRT_BGNDATE));
					cstmt.setString(9, rows[i].getString(colNm_CTRT_ENDDATE));
					cstmt.setString(10, rows[i].getString(colNm_PM));
					cstmt.setString(11, rows[i].getString(colNm_WIN_FEE));
					cstmt.setString(12, rows[i].getString(colNm_COST_FEE));
					
					cstmt.setInt(13, jobtype );	//가우스행 작업 값
					
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