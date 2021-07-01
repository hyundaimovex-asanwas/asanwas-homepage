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

public class Rq030 extends SuperServlet {

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;

	
	public void makeSql(){
		
		
		for(int i=0; i<arr_sql.length; i++)
			
			
			arr_sql[i] = new StringBuffer();
		
		
				//	default1 조회  
				arr_sql[1].append ("{call PMS.PR_NEW_RQ030_01(?,?,?) }" );
				
				
				
				// default2 조회 , 구매의뢰서 내용 검색 
				arr_sql[2].append ("{call PMS.PR_NEW_RQ030_02(?,?,?) }" );
				
				
				
				//	견적업체 List 조회
				arr_sql[3].append ("{call PMS.PR_NEW_RQ030_03(?,?,?) }" );
				
				
				
				//	default 조회  , 구매의뢰서 디테일(전체 실행 list) ,조회  - project_code , v_request_no
				//arr_sql[4].append ("{call PMS.PR_NEW_RQ030S_04(?,?,?) }" );
				
				
				
				//	견적 정보 insert
				arr_sql[5].append ("{call PMS.PR_NEW_RQ030S_05(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }" );
				
				
				//여기까지!!
				

				//	default 저장  , 구매의뢰서 디테일(청구 품목 list) ,저장  - REQUST_QN 
				arr_sql[6].append ("{call PMS.PR_NEW_RQ010S_06(?,?,?,?,?,?,?,?) }" );
				
				


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
		
		CallableStatement 	cstmt 	= null;
		ResultSet 				rs 	= null;

		String v_request_no 			= HDUtil.nullCheckStr(greq.getParameter("v_request_no"));			// 상등록공종
		String v_project_code 			= HDUtil.nullCheckStr(greq.getParameter("v_project_code"));			// 상등록공종

		

		//System.out.println("select 입니다.");
		

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

        
        
		try {
            
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){


            	// arr_sql[1] [기본 정보 List]
            	if(dSets[i].getName().equals("ds_default")){

					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					cstmt.setString(1, v_project_code); //프로젝트 명(code)로 값 던짐
					cstmt.setString(2, v_request_no); //구매의뢰서 번호 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();	//실행
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
            	
            	
            	// arr_sql[2] [청구 품목 List]
            	if(dSets[i].getName().equals("ds_default2")){

            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());
					
					cstmt.setString(1, v_project_code); //프로젝트 명(code)로 값 던짐
					cstmt.setString(2, v_request_no); //구매의뢰서 번호 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();	//실행
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 		
					
					gos.write(getDataSet(rs, ds1));
					
            	}
            	
            	
            	
            	// arr_sql[3] [견적 업체 List]
            	if(dSets[i].getName().equals("ds_default3")){

            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT3");
					
					cstmt = conn.prepareCall(arr_sql[3].toString());
					
					
					cstmt.setString(1, v_project_code); //프로젝트 명(code)로 값 던짐
					cstmt.setString(2, v_request_no);   //구매의뢰서 번호 
					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();	//실행
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
					
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

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        

        
        GauceDataSet ds_culdes = gis.read("DS_CULDES");
        //GauceDataSet ds_culds  = gis.read("DS_CULDS");

		
        
		
		try{
			
			
			if (ds_culdes != null) {
				
				GauceDataRow[] 		rows = ds_culdes.getDataRows();
				

				int colNm_NO_ESTIMATE	 	= ds_culdes.indexOfColumn("NO_ESTIMATE");			//견적서 번호          
				int colNm_COST_CD		    = ds_culdes.indexOfColumn("COST_CD");  				//project code    
				int colNm_NO_MA_REQUEST	 	= ds_culdes.indexOfColumn("NO_MA_REQUEST");			//구매의뢰서 번호        
				int colNm_VEND_NM		    = ds_culdes.indexOfColumn("VEND_NM");   			//업체명             
				int colNm_CD_VENDOR		 	= ds_culdes.indexOfColumn("CD_VENDOR");				//사업자 등록번호        
				int colNm_VD_DIRECT		    = ds_culdes.indexOfColumn("VD_DIRECT");   			//대표자             
				int colNm_BSNS_CND		 	= ds_culdes.indexOfColumn("BSNS_CND");				//업태              
				int colNm_BSNS_KND		    = ds_culdes.indexOfColumn("BSNS_KND");   			//업종              
				int colNm_VD_TELNO		 	= ds_culdes.indexOfColumn("VD_TELNO");				//연락처             
				int colNm_AM_ESTIMATE	    = ds_culdes.indexOfColumn("AM_ESTIMATE");  			//견적 금액           
				int colNm_CHOICE_REASON	 	= ds_culdes.indexOfColumn("CHOICE_REASON");			//선정 사유           
				int colNm_YN_SELECT		    = ds_culdes.indexOfColumn("YN_SELECT");  			//신청 여부
				

				for(int i=0; i<rows.length; i++){
					
					/*
					StringUtil.printMsg("colNm_NO_ESTIMATE	",rows[i].getString(colNm_NO_ESTIMATE	),this);
					StringUtil.printMsg("colNm_COST_CD		",rows[i].getString(colNm_COST_CD		),this);
					StringUtil.printMsg("colNm_NO_MA_REQUEST",rows[i].getString(colNm_NO_MA_REQUEST	),this);
					StringUtil.printMsg("colNm_VEND_NM		",rows[i].getString(colNm_VEND_NM		),this);
					StringUtil.printMsg("colNm_CD_VENDOR	",rows[i].getString(colNm_CD_VENDOR		),this);
					StringUtil.printMsg("colNm_VD_DIRECT	",rows[i].getString(colNm_VD_DIRECT		),this);
					StringUtil.printMsg("colNm_BSNS_CND		",rows[i].getString(colNm_BSNS_CND		),this);
					StringUtil.printMsg("colNm_BSNS_KND		",rows[i].getString(colNm_BSNS_KND		),this);
					StringUtil.printMsg("colNm_VD_TELNO		",rows[i].getString(colNm_VD_TELNO		),this);
					StringUtil.printMsg("colNm_AM_ESTIMATE	",rows[i].getString(colNm_AM_ESTIMATE	),this);
					StringUtil.printMsg("colNm_CHOICE_REASON",rows[i].getString(colNm_CHOICE_REASON	),this);
					StringUtil.printMsg("colNm_YN_SELECT	",rows[i].getString(colNm_YN_SELECT		),this);
					StringUtil.printMsg("colNm_COST_CD		",rows[i].getString(colNm_COST_CD		),this);
					 */
					//StringUtil.printMsg("ds_default "+i+"행 작업===",rows[i].getJobType(),this);
					// 가우스 행 JobType : 2=insert, 3=update, 4=delete
					cstmt = conn.prepareCall(arr_sql[4].toString());

					
					cstmt.setString(1, rows[i].getString(colNm_NO_ESTIMATE));		//견적서 번호                   
					cstmt.setString(2, rows[i].getString(colNm_COST_CD));			//project code             
					cstmt.setString(3, rows[i].getString(colNm_CD_VENDOR));			//사업자 등록번호            
					cstmt.setString(4, rows[i].getString(colNm_VEND_NM));			//업체명                      
					cstmt.setString(5, rows[i].getString(colNm_VD_DIRECT));			//대표자                      
					cstmt.setString(6, rows[i].getString(colNm_BSNS_CND));			//업태                       
					cstmt.setString(7, rows[i].getString(colNm_BSNS_KND));			//업종                       
					cstmt.setString(8, rows[i].getString(colNm_VD_TELNO));			//연락처                      
					cstmt.setString(9, rows[i].getString(colNm_NO_MA_REQUEST));		//구매의뢰서 번호                 
					cstmt.setString(10, rows[i].getString(colNm_AM_ESTIMATE));		//견적 금액                    
					cstmt.setString(11, rows[i].getString(colNm_YN_SELECT));		//신청 여부                    
					cstmt.setString(12, rows[i].getString(colNm_CHOICE_REASON));	//선정 사유                    
					cstmt.setInt(13, rows[i].getJobType() );	//가우스행 작업 값
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




