package pms.news.bud;

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

public class Bd021 extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
				//	default 조회
				//arr_sql[0].append ("{call PMS.PR_NEW_BD010_01(?) }" );
				
				
				//	PROJECT 정보 조회
				arr_sql[1].append ("{call PMS.PR_NEW_BD021_01(?,?,?)}");
				
				
				// bd011.jsp Detail 조회
				//arr_sql[2].append ("{call PMS.PR_NEW_BD010_03(?,?,?)}");
				
				// 프로젝트명 검색 하는 쿼리 
				//arr_sql[3].append ("{call PMS.PR_NEW_RQ010S_02(?,?) }" );
				
				
				
				//	insert update쿼리
				arr_sql[4].append ("{call PMS.PR_NEW_BD021_04(?,?,?,?,?,?,?,?,?,?)}");
				
				
				//tree default 조회 
				arr_sql[5].append ("{call PMS.PR_NEW_BD021_05(?,?,?) }" );
				
				//tree ds_detail 조회
				arr_sql[6].append ("{call PMS.PR_NEW_BD021_06(?,?,?,?,?)}");
				
				//Grid ds_detail 조회
				arr_sql[7].append ("{call PMS.PR_NEW_BD021_07(?,?,?) }");

				//Grid ds_detail2 조회
				arr_sql[8].append ("{call PMS.PR_NEW_BD021_08(?,?,?) }");
				
				//Grid ds_detail3 조회
				arr_sql[9].append ("{call PMS.PR_NEW_BD021_09(?,?,?) }");				
				
   }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
				CallableStatement cstmt = null;
				
				ResultSet rs = null;
				
				String v_cost_cd 		= HDUtil.nullCheckStr(greq.getParameter("V_COST_CD"));		
				String v_no_budget 		= HDUtil.nullCheckStr(greq.getParameter("V_NO_BUDGET"));	
				
				try {
					
		            GauceInputStream gis = greq.getGauceInputStream();
		            GauceOutputStream gos = gres.getGauceOutputStream();
		            
		            GauceDataSet[] dSets = gis.readAllOutput(); 
		            
		            for(int i=0; i<dSets.length;i++){
		            	
		            	
		            	if(dSets[i].getName().equals("ds_item_m")){
		            		
							GauceDataSet ds1 = gis.read("DS_ITEM_M");
							
							//System.out.println("a18==="+v_cost_cd);
							
							cstmt = conn.prepareCall(arr_sql[5].toString());
							
							//System.out.println(v_cost_cd+":::"+v_no_budget);
							
							cstmt.setString(1, v_cost_cd);
							cstmt.setString(2, v_no_budget);
							
							cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
							
							cstmt.executeQuery();
							
							rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
							
							//GAUCE 5.x버전 : OutputStream에 DS를 써보낸다.
							//getDataSet(rs,ds1)을 호출하면 SuperServlet에서 rs를 ds1에 담아 ds1를 리턴~!
							
							gos.write(getDataSet(rs, ds1));
		
		            	}
		            	
		            	
		            	if(dSets[i].getName().equals("ds_project")){
		            		
							GauceDataSet ds1 = gis.read("DS_PROJECT");
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							//System.out.println("B18==="+v_cost_cd);
							cstmt.setString(1, v_cost_cd);
							cstmt.setString(2, v_no_budget);
							
							cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
							
							cstmt.executeQuery();
							
							rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 	
							
							gos.write(getDataSet(rs, ds1));
							
		            	}		            	
		            	
		            	
		            	
		            	
		            	
					}
				}catch (SQLException sqle){
				} catch (Exception e){
				} finally {
				}
		
	}
	
	
	
	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs			= null;

		
		String v_project 		= HDUtil.nullCheckStr(greq.getParameter("v_project"));	
		String v_stat 			= HDUtil.nullCheckStr(greq.getParameter("v_stat"));				
		String v_kind 			= HDUtil.nullCheckStr(greq.getParameter("v_kind"));		
		
		
		//bd011.jsp 값 받기 
		String v_cost_cd 		= HDUtil.nullCheckStr(greq.getParameter("v_cost_cd"));		
		String v_no_budget 		= HDUtil.nullCheckStr(greq.getParameter("v_no_budget"));	
		
		
		//BU013 프로젝트 코드 조회 
		String v_project_name 	= HDUtil.nullCheckStr(greq.getParameter("v_project_name"));	
		
		
		//Tree 클릭시 넘겨주는 변수값
		String v_overValue1 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue1"));	//code
		String v_overValue2 	= HDUtil.nullCheckStr(greq.getParameter("v_overValue2"));	//tree level	
		

		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
            
          //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 

			
            for(int i=0; i<dSets.length;i++){
            	
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS_DEFAULT=ds_default
            	
            	
            	if(dSets[i].getName().equals("ds_default")){
            		
					GauceDataSet ds1 = gis.read("DS_DEFAULT");
					
					if(v_kind.equals("1")){
						
						cstmt = conn.prepareCall(arr_sql[1].toString());
					 
					 	cstmt.setString(1, v_project);
					 	cstmt.setString(2, v_stat);		 
					 	cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					 
					 	cstmt.executeQuery();
						
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 		
						
						
					}else{

						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.registerOutParameter(1, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(1);	//커서 OUT param. 		
						
					}

					gos.write(getDataSet(rs, ds1));
            	}
            	


            	
            	
            	//화면 트리 온클릭시 오른쪽에 보여주기 
            	if(dSets[i].getName().equals("ds_item_d")){
            		
            		//System.out.println("여기는 타나요18??!!!!"+v_overValue1+":::"+v_overValue2);
            		//System.out.println("여기는 타나요18??!!!!"+v_project+":::"+v_no_budget);
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D");
					
					
					cstmt = conn.prepareCall(arr_sql[6].toString());
					
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						
					cstmt.setString(3, v_overValue1);
					cstmt.setString(4, v_overValue2);	
					
					cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
					
            	}
            	
            	
            	//화면 grid 보여주기 
            	if(dSets[i].getName().equals("ds_item_d_grid")){
            		
            		//System.out.println("여기는 타나요18??!!!!"+v_overValue1+":::"+v_overValue2);
            		System.out.println("여기는 타나요18??!!!!"+v_project+":::"+v_no_budget);
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID");
					
					
					cstmt = conn.prepareCall(arr_sql[7].toString());
					
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
					
            	}            	
            	
            	
            	//화면 grid2 보여주기 
            	if(dSets[i].getName().equals("ds_item_d_grid2")){
            		
            		//System.out.println("여기는 타나요18??!!!!"+v_overValue1+":::"+v_overValue2);
            		//System.out.println("여기는 타나요18??!!!!"+v_project+":::"+v_no_budget);
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID2");
					
					
					cstmt = conn.prepareCall(arr_sql[8].toString());
					
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
					
					cstmt.executeQuery();
					
					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					

					gos.write(getDataSet(rs, ds1));
					
					
            	}  
            	
            	
            	//화면 grid3 보여주기 
            	if(dSets[i].getName().equals("ds_item_d_grid3")){
            		
            		//System.out.println("여기는 타나요18??!!!!"+v_overValue1+":::"+v_overValue2);
            		//System.out.println("여기는 타나요18??!!!!"+v_project+":::"+v_no_budget);
            		
					GauceDataSet ds1 = gis.read("DS_ITEM_D_GRID3");
					
					
					cstmt = conn.prepareCall(arr_sql[9].toString());
					
					
					cstmt.setString(1, v_project);
					cstmt.setString(2, v_no_budget);						

					
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
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		CallableStatement 	cstmt 		= null;	
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		
		String iParamEmpno 	= fParamEmpno;

				
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        //tree 부분 저장 
        GauceDataSet ds_item_d = gis.read("DS_ITEM_D");
        

		try{

			if (ds_item_d != null) {
				
				GauceDataRow[] 		rows = ds_item_d.getDataRows();
				
				int colNm_COST_CD				= ds_item_d.indexOfColumn("COST_CD");        		// 프로젝트코드            
				int colNm_NO_BUDGET        		= ds_item_d.indexOfColumn("NO_BUDGET");   			// 차수       
				int colNm_CD_COST				= ds_item_d.indexOfColumn("CD_COST");				// 상세분류코드
				int colNm_DS_KSITEM    			= ds_item_d.indexOfColumn("DS_KSITEM");     		// 품목명
				int colNm_COST_YN    			= ds_item_d.indexOfColumn("COST_YN");     			// node,leaf 여부
				int colNm_ORDER_AMT_NOW    		= ds_item_d.indexOfColumn("ORDER_AMT_NOW");   		// 도급금액(현재)         
				int colNm_EXE_ACT_AMT_NOW      	= ds_item_d.indexOfColumn("EXE_ACT_AMT_NOW");       // 실행예산(현재) 
				int colNm_ITEM_CD      			= ds_item_d.indexOfColumn("ITEM_CD");       		// 품목코드 

				for(int i=0; i<rows.length; i++){

					if(rows[i].getJobType()==2){
						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));	
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
						cstmt.setInt(9, rows[i].getJobType() );	//가우스행 작업 값
						
						cstmt.setString(10, iParamEmpno);
						
						cstmt.executeUpdate();
						
						
					}else if(rows[i].getJobType()==3){
						
						cstmt = conn.prepareCall(arr_sql[4].toString());
						
						cstmt.setString(1, rows[i].getString(colNm_COST_CD));
						cstmt.setString(2, rows[i].getString(colNm_NO_BUDGET));	
						cstmt.setString(3, rows[i].getString(colNm_CD_COST));	
						cstmt.setString(4, rows[i].getString(colNm_DS_KSITEM));
						cstmt.setString(5, rows[i].getString(colNm_COST_YN));
						cstmt.setString(6, rows[i].getString(colNm_ORDER_AMT_NOW));
						cstmt.setString(7, rows[i].getString(colNm_EXE_ACT_AMT_NOW));	
						cstmt.setString(8, rows[i].getString(colNm_ITEM_CD));	
						
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
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}
	}
}