package Payroll;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class p030009i_01 extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 종전근무지 테이블  정보 조회
		arr_sql[0].append("")
			.append("SELECT               							         \n") //
			.append("        R1.SEQ		          AS SEQ		             \n") //--NUMERIC	1,0	개인당 순서 (최대 2개)
			.append("       ,R1.DEPTCD	          AS DEPTCD		             \n") //--VARCHAR	4	부서	933		직원 개인정보
			.append("       ,R1.PAYGRD	          AS PAYGRD		             \n") //--VARCHAR	4	직위	933		직원 개인정보			    
			.append("       ,R1.YYYY              AS YYYY                    \n") //  귀속년도
			.append("       ,R1.EMPNO             AS EMPNO                   \n") //  사번
			//.append("       ,R2.EMPNMK            AS EMPNMK                  \n") //  사원명
			.append("       ,R1.STRTDT	          AS STRTDT		             \n") //--CHARACTER	8	입사일	933	직원 개인정보				
			.append("       ,R1.ENDDT	          AS ENDDT		             \n") //--CHARACTER	8	퇴사일	933	직원 개인정보	
			.append("       ,R1.WKNM	          AS WKNM		             \n") //--VARCHAR	30	근무처명	933		0			
			.append("       ,R1.WKRESINO          AS WKRESINO	             \n") //--VARCHAR	20	사업자등록번호	933		0
			.append("       ,R1.BP11000	          AS BP11000	             \n") //--NUMERIC	9,0	급여						            
			.append("       ,R1.BP12000	          AS BP12000	             \n") //--NUMERIC	9,0	상여						            	
			.append("       ,R1.BP13000	          AS BP13000	             \n") //--NUMERIC	9,0	인정상여						        
			.append("       ,R1.BP11000 + R1.BP12000 + R1.BP13000 AS BP10SUM \n") //--NUMERIC	9,0	총급여계						        
			.append("       ,R1.BP21000	          AS BP21000	             \n") //--NUMERIC	9,0	국외근로비과세						    
			.append("       ,R1.BP22000	          AS BP22000	             \n") //--NUMERIC	9,0	야간근로비과세
			.append("       ,R1.BTAXCD01	          AS BTAXCD01	             \n") //-- VARCHAR(3) 비과세
			.append("       ,R1.BTAXCD02	          AS BTAXCD02	             \n") //-- VARCHAR(3) 비과세
			.append("       ,R1.BTAXNM01	          AS BTAXNM01	             \n") //-- VARCHAR(40) 비과세
			.append("       ,R1.BTAXNM02	          AS BTAXNM02	             \n") //-- VARCHAR(40) 비과세
			.append("       ,R1.BTAXAMT01	          AS BTAXAMT01	             \n") //--NUMERIC	9,0	비과세
			.append("       ,R1.BTAXAMT02	          AS BTAXAMT02	             \n") //--NUMERIC	9,0	비과세
			.append("       ,R1.BP21000 + R1.BP22000 + R1.BTAXAMT01+ R1.BTAXAMT02 AS BP20SUM \n") 			
			.append("       ,R1.BP31000		      AS BP31000	             \n") //--NUMERIC	9,0	국민연금						        
			.append("       ,R1.BP32000		      AS BP32000                 \n") //--NUMERIC	9,0	건강보험						        
			.append("       ,R1.BP33000		      AS BP33000                 \n") //--NUMERIC	9,0	Yes	0	고용보험
			.append("       ,R1.BP34000		      AS BP34000                 \n") //--NUMERIC	9,0	Yes	0	퇴직연금
			.append("       ,R1.BP31000 + R1.BP32000 + R1.BP33000+ R1.BP34000 AS BP30SUM \n")			
			.append("       ,R1.BP41000	          AS BP41000	             \n") //--NUMERIC	9,0	Yes	0	결정소득세						                
			.append("       ,R1.BP42000	          AS BP42000	             \n") //--NUMERIC	9,0	Yes	0	결정주민세						            
			.append("       ,R1.BP43000	          AS BP43000	             \n") //--NUMERIC	9,0	Yes	0	결정농특세						            
			.append("       ,R1.BP41000 + R1.BP42000 + R1.BP43000 AS BP40SUM \n") //--NUMERIC	9,0	Yes	0	세액계						            
			.append("  FROM PAYROLL.YCBEFOFF R1                              \n") //
			.append(" WHERE R1.EMPNO = ?       	                             \n") //-- 사번
			.append("   AND R1.YYYY  = ?     	                             \n")  		
			.append(" ORDER BY R1.SEQ ASC     	                             \n");

		// 저장/수정
		arr_sql[1].append("{CALL PAYROLL.PR_P030009I_01 (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
		// 인서트 후 집계내서 업데이트
		
		// 딜리트 후 집계내서 업데이트 
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* 검색시 필요한 조건  --------------------------------------------------------------- */
		String eyy 		    = HDUtil.nullCheckStr(req.getParameter("eyy"));	// 귀속년도
		String eno	        = HDUtil.nullCheckStr(req.getParameter("eno"));	// 사번 
		//int sHotel 			= HDUtil.nullCheckNum(req.getParameter("sUpjang"));	// 호텔
		/* 검색시 필요한 조건  --------------------------------------------------------------- */		
		
		StringUtil.printMsg("디버그eyy: ", eyy, this);		
		StringUtil.printMsg("디버그eno: ", eno, this);
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						stmt = conn.getGauceStatement(arr_sql[0].toString());							
						//StringUtil.printMsg("조회 SQL-sdh", arr_sql[0].toString(), this);

						stmt.setString(1, eno);
						stmt.setString(2, eyy);

						rs = stmt.executeQuery();

					}


					
					getDataSet(rs, ds1).flush();

				}
			}
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
		
	}

	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		//StringUtil.printMsg("DS TYPE:::","업데이트",this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = req.getGauceDataSet("RESULT");
		ResultSetMetaData rsmd = null;
		
		
		try {
			//메시지처리
			if(ds_result!=null){
				res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			String r_s_yn	;
			String r_msg_cd	;
			String r_msg	;
			String job_cd	;	//인서트, 업데이트, 딜리트 구분..			
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_YYYY	    = ds1.indexOfColumn("YYYY");
						int colNm_EMPNO	    = ds1.indexOfColumn("EMPNO");
						int colNm_WKRESINO  = ds1.indexOfColumn("WKRESINO");
						int colNm_WKNM	    = ds1.indexOfColumn("WKNM");
						int colNm_SEQ	    = ds1.indexOfColumn("SEQ");
						int colNm_BP11000   = ds1.indexOfColumn("BP11000");
						int colNm_BP12000   = ds1.indexOfColumn("BP12000");	
						int colNm_BP13000   = ds1.indexOfColumn("BP13000");
						int colNm_BP21000   = ds1.indexOfColumn("BP21000");	
						int colNm_BP22000	= ds1.indexOfColumn("BP22000");
						int colNm_BP31000	= ds1.indexOfColumn("BP31000");
						int colNm_BP32000	= ds1.indexOfColumn("BP32000");
						int colNm_BP33000	= ds1.indexOfColumn("BP33000");
						int colNm_BP34000	= ds1.indexOfColumn("BP34000");
						int colNm_BP41000	= ds1.indexOfColumn("BP41000");
						int colNm_BP42000	= ds1.indexOfColumn("BP42000");
						int colNm_BP43000	= ds1.indexOfColumn("BP43000");
						int colNm_BTAXCD01	= ds1.indexOfColumn("BTAXCD01");
						int colNm_BTAXCD02	= ds1.indexOfColumn("BTAXCD02");
						int colNm_BTAXAMT01	= ds1.indexOfColumn("BTAXAMT01");
						int colNm_BTAXAMT02	= ds1.indexOfColumn("BTAXAMT02");
						int colNm_BTAXNM01	= ds1.indexOfColumn("BTAXNM01");
						int colNm_BTAXNM02	= ds1.indexOfColumn("BTAXNM02");
						int colNm_STRTDT	= ds1.indexOfColumn("STRTDT");
						int colNm_ENDDT		= ds1.indexOfColumn("ENDDT");						
						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// 신규행이면
									StringUtil.printMsg("DS TYPE:::","인서트",this);
									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:
									StringUtil.printMsg("DS TYPE:::","딜리트",this);
									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									StringUtil.printMsg("DS TYPE:::","업데이트",this);
									job_cd = "3";
									break;
							} //switch
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							/*StringUtil.printMsg("YYYY",rows[i].getString(colNm_YYYY),this); 
							StringUtil.printMsg("EMPNO",rows[i].getString(colNm_EMPNO),this);*/ 
							StringUtil.printMsg("SEQ", rows[i].getInt(colNm_SEQ) ,this);
							/*StringUtil.printMsg("WKRESINO",rows[i].getString(colNm_WKRESINO),this); 
							StringUtil.printMsg("WKNM",rows[i].getString(colNm_WKNM),this); 
							StringUtil.printMsg("BP11000",rows[i].getInt(colNm_BP11000),this); 
							StringUtil.printMsg("BP12000",rows[i].getInt(colNm_BP12000),this); 
							StringUtil.printMsg("BP13000",rows[i].getInt(colNm_BP13000),this); 
							StringUtil.printMsg("BP21000",rows[i].getInt(colNm_BP21000),this); 
							StringUtil.printMsg("BP22000",rows[i].getInt(colNm_BP22000),this); 
							StringUtil.printMsg("BP23000",rows[i].getInt(colNm_BP23000),this); 
							StringUtil.printMsg("BP31000",rows[i].getInt(colNm_BP31000),this); 
							StringUtil.printMsg("BP32000",rows[i].getInt(colNm_BP32000),this); 
							StringUtil.printMsg("BP33000",rows[i].getInt(colNm_BP33000),this); 
							StringUtil.printMsg("BP41000",rows[i].getInt(colNm_BP41000),this); 
							StringUtil.printMsg("BP42000",rows[i].getInt(colNm_BP42000),this); 
							StringUtil.printMsg("BP43000",rows[i].getInt(colNm_BP43000),this);*/ 
	
							
							cstmt.setString( 1,rows[i].getString(colNm_YYYY)    );	//귀속년도                          
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO)   );	//사번                  
							cstmt.setInt   ( 3,rows[i].getInt(colNm_SEQ)     );	//순서                  
							cstmt.setString( 4,rows[i].getString(colNm_WKRESINO));	//사업자등록번호        
							cstmt.setString( 5,rows[i].getString(colNm_WKNM)    );	//근무처명              
							cstmt.setInt   ( 6,rows[i].getInt(colNm_BP11000)    );	//급여                  
							cstmt.setInt   ( 7,rows[i].getInt(colNm_BP12000)    );	//상여                  
							cstmt.setInt   ( 8,rows[i].getInt(colNm_BP13000)    );	//인정상여              
							cstmt.setInt   ( 9,rows[i].getInt(colNm_BP21000)    );	//국외근로비과세        
							cstmt.setInt   (10,rows[i].getInt(colNm_BP22000)    );	//야간근로비과세                  
							cstmt.setInt   (11,rows[i].getInt(colNm_BP31000)    );	//국민연금              
							cstmt.setInt   (12,rows[i].getInt(colNm_BP32000)    );	//건강보험              
							cstmt.setInt   (13,rows[i].getInt(colNm_BP33000)    );	//고용보험 
							cstmt.setInt   (14,rows[i].getInt(colNm_BP34000)    );	//퇴직연금 							
							cstmt.setInt   (15,rows[i].getInt(colNm_BP41000)    );	//결정소득세            
							cstmt.setInt   (16,rows[i].getInt(colNm_BP42000)    );	//결정주민세            
							cstmt.setInt   (17,rows[i].getInt(colNm_BP43000)    );	//결정농특세  
							cstmt.setString   (18,rows[i].getString(colNm_BTAXCD01)    );	//기타비과세코드1 							
							cstmt.setString   (19,rows[i].getString(colNm_BTAXCD02)    );	//기타비과세코드2            
							cstmt.setInt	  (20,rows[i].getInt(colNm_BTAXAMT01)    );	//기타비과세금액1            
							cstmt.setInt      (21,rows[i].getInt(colNm_BTAXAMT02)    );	//기타비과세금액2
							cstmt.setString   (22,rows[i].getString(colNm_BTAXNM01)    );
							cstmt.setString   (23,rows[i].getString(colNm_BTAXNM02)    );						
							cstmt.setString   (24,rows[i].getString(colNm_STRTDT)    );	//입사일            
							cstmt.setString   (25,rows[i].getString(colNm_ENDDT)    );	//퇴사일


							cstmt.setString(26,rows[i].getString(colNm_EMPNO)   );	//최종수정자사번
							cstmt.setString(27,""                               );	//최종수정IP
							cstmt.setString(28,job_cd                           );	//편집상태1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(31, java.sql.Types.VARCHAR);				
	
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(29);
							r_msg_cd	= cstmt.getString(30);
							r_msg		= cstmt.getString(31);
							
							if(!r_s_yn.equals("Y"))
								throw new Exception(r_msg);
							
							if(ds_result!=null){
								GauceDataRow row1 = ds_result.newDataRow();
								row1.addColumnValue(r_s_yn);
								row1.addColumnValue(r_msg_cd);
								row1.addColumnValue(r_msg);
								
								ds_result.addDataRow(row1);	
							}
							if(cstmt!=null) cstmt.close();
						};	//for(int i=0; i<rows.length; i++){
					}; 	//if ("DS1".equals(gauceName)) {					
				}
			}		
		} catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}	

	}

}
