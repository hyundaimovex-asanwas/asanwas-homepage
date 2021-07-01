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

public class p030010i extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 기본정보 테이블  정보 조회 
		arr_sql[0].append("{CALL PAYROLL.PR_P030010S (?,?) }");

		// 저장/수정(16개) 
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?  ,?) }");

		// 종전근무지 테이블  정보 조회
		arr_sql[2].append("{CALL PAYROLL.PR_P030010S1 (?,?) }");

		// 인적공제 테이블  정보 조회
		arr_sql[3].append("{CALL PAYROLL.PR_P030010S2 (?,?) }");
	
		// 기부금 테이블  정보 조회
		arr_sql[4].append("{CALL PAYROLL.PR_P030010S3 (?,?) }");
		


		// 인적공제 테이블  정보 저장 (17개)
		arr_sql[5].append("{CALL PAYROLL.PR_P030010_I2 (?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?) }");


        // 연말정산 근로소득공제신고서 출력물 관련 Start

		// 인적공제 
		arr_sql[6].append("{CALL PAYROLL.PR_P030010S10 (?,?) }");

		// 기본
		arr_sql[7].append("{CALL PAYROLL.PR_P030010S11 (?,?) }");

		// 연금등등등
		arr_sql[12].append("{CALL PAYROLL.PR_P030010S12 (?,?) }");

		//연말정산 근로소득공제신고서 출력물 관련 End

        //전산제출 
        arr_sql[8].append("{CALL PAYROLL.PR_P030010I99 (?,?,?,?,?,?) }");

		//전산조회 
        arr_sql[9].append("{CALL PAYROLL.PR_P030010S99 (?,?) }");

		// 주택  정보 조회
		arr_sql[10].append("{CALL PAYROLL.PR_P030010S4 (?,?) }");
	
		// 연금등등  정보 조회
		arr_sql[11].append("{CALL PAYROLL.PR_P030010S5 (?,?) }");

	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
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
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));				// 귀속년도
		String eno					= HDUtil.nullCheckStr(req.getParameter("eno"));				// 사번 

		/* 검색시 필요한 조건  --------------------------------------------------------------- */		
		
		try {
			//int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			while (it.hasNext()) {
				String gauceName = (String)it.next();

				ds1 = req.getGauceDataSet(gauceName);
				StringUtil.printMsg("gauceName",gauceName,this);

				if(ds1!=null){

					res.enableFirstRow(ds1);

					if ("DS1".equals(gauceName)) {	//기본정보 조회

						stmt = conn.getGauceStatement(arr_sql[0].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					
					if ("DS2".equals(gauceName)) {	//종전근무지 조회
						stmt = conn.getGauceStatement(arr_sql[2].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					
					if ("DS3".equals(gauceName)) {	//인적공제
						stmt = conn.getGauceStatement(arr_sql[3].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}
					

					if ("DS4".equals(gauceName)) {	//기부금 조회
						stmt = conn.getGauceStatement(arr_sql[4].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}


					if ("DS5".equals(gauceName)) {	//연말정산 근로속득공제신고서 인적공제
						stmt = conn.getGauceStatement(arr_sql[6].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS6".equals(gauceName)) {	//연말정산 근로속득공제신고서  기본
						stmt = conn.getGauceStatement(arr_sql[7].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS8".equals(gauceName)) {	//주택자금
						stmt = conn.getGauceStatement(arr_sql[10].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS9".equals(gauceName)) {	//전산제출구분조회
						stmt = conn.getGauceStatement(arr_sql[9].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS11".equals(gauceName)) {	//연금등등등
						stmt = conn.getGauceStatement(arr_sql[11].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					if ("DS12".equals(gauceName)) {	//출력시 연금등등등
						stmt = conn.getGauceStatement(arr_sql[12].toString());							

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
					}

					rs = stmt.executeQuery();
					getDataSet(rs, ds1).flush();

					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();
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
		StringUtil.printMsg("DS TYPE:::","업데이트",this);
		//System.out.print("DS TYPE:::업데이트");

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
					
						int colNm_APPDT   			= ds1.indexOfColumn("APPDT");			//귀속년도         
						int colNm_EMPNO  			= ds1.indexOfColumn("EMPNO");			//사번             
						int colNm_HOUSEYN			= ds1.indexOfColumn("HOUSEYN");		//세대주여부            
						int colNm_HOUCNT			= ds1.indexOfColumn("HOUCNT");		//주택수            
						int colNm_HOUAREA			= ds1.indexOfColumn("HOUAREA");		//전용면적             
						int colNm_HOUVAL			= ds1.indexOfColumn("HOUVAL");			//기준시가 
						int colNm_HOULOAN			= ds1.indexOfColumn("HOULOAN");		//3개월내저당차입 
						int colNm_HOUAMT01	  	= ds1.indexOfColumn("HOUAMT01");	//주택마련저축액            
						int colNm_HOUAMT02	  	= ds1.indexOfColumn("HOUAMT02");	//주택차입금상환            
						int colNm_HOUAMT03	  	= ds1.indexOfColumn("HOUAMT03");	//주택저당차임6             
						int colNm_HOUAMT04	  	= ds1.indexOfColumn("HOUAMT04");	//주택저당차임10 
						int colNm_HOUAMT05	  	= ds1.indexOfColumn("HOUAMT05");	//주택저당차임15  
						//int colNm_PESAMT01	  	= ds1.indexOfColumn("PESAMT01");		//개인연금
						//int colNm_PESAMT02	  	= ds1.indexOfColumn("PESAMT02");		//연금저축
						//int colNm_FNDAMT01	  	= ds1.indexOfColumn("FNDAMT01");	//장기주식형저축소득1년차불입액
						//int colNm_FNDAMT02	  	= ds1.indexOfColumn("FNDAMT02");	//장기주식형저축소득2년차불입액
						//int colNm_FNDAMT03	  	= ds1.indexOfColumn("FNDAMT03");	//장기주식형저축소득3년차불입액
						//int colNm_CONAMT99	  	= ds1.indexOfColumn("CONAMT99");	//정치자금 기부금

						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// 신규행이면
									//StringUtil.printMsg("DS TYPE:::","인서트",this);
									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:
									//StringUtil.printMsg("DS TYPE:::","딜리트",this);
									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									//StringUtil.printMsg("DS TYPE:::","업데이트",this);
									job_cd = "3";
									break;
							} //switch
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						
/*							StringUtil.printMsg("01기본저장", "캬캬" ,this);
							StringUtil.printMsg("colNm_HOULOAN", rows[i].getString(colNm_HOULOAN) 		 ,this);
							StringUtil.printMsg("colNm_FNDAMT01", rows[i].getInt   (colNm_FNDAMT01) 		 ,this);
							StringUtil.printMsg("colNm_FNDAMT02", rows[i].getInt   (colNm_FNDAMT02) 		 ,this);
							StringUtil.printMsg("colNm_FNDAMT03", rows[i].getInt   (colNm_FNDAMT03) 		 ,this);
							StringUtil.printMsg("colNm_PESAMT02", rows[i].getInt   (colNm_PESAMT02) 		 ,this);
							StringUtil.printMsg("colNm_CONAMT99", rows[i].getInt   (colNm_CONAMT99) 		 ,this);			
							StringUtil.printMsg("job_cd", job_cd 		 ,this);								
*/
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );		//귀속년도      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );		//사번
							cstmt.setString( 3,rows[i].getString(colNm_HOUSEYN	) );		//세대주여부      	
							cstmt.setString( 4,rows[i].getString(colNm_HOUCNT		) );		//주택수              	
							cstmt.setString( 5,rows[i].getString(colNm_HOUAREA	) );		//전용면적               
							cstmt.setString( 6,rows[i].getString(colNm_HOUVAL		) );		//기준시가               
							cstmt.setString( 7,rows[i].getString(colNm_HOULOAN	) );		//3개월내저당차입    
							cstmt.setInt   ( 8,rows[i].getInt   (colNm_HOUAMT01	   ) );	//주택마련저축액           
							cstmt.setInt   ( 9,rows[i].getInt   (colNm_HOUAMT02	   ) );	//주택차입금상환           
							cstmt.setInt   ( 10,rows[i].getInt   (colNm_HOUAMT03	   ) );	//주택저당차임6            
							cstmt.setInt   ( 11,rows[i].getInt   (colNm_HOUAMT04	   ) );	//주택저당차임10 
							cstmt.setInt   ( 12,rows[i].getInt   (colNm_HOUAMT05	   ) );	//주택저당차임15  			
							
							//cstmt.setInt   ( 13,rows[i].getInt   (colNm_PESAMT01	   ) );	//개인연금  
							//cstmt.setInt   ( 14,rows[i].getInt   (colNm_PESAMT02	   ) );	//연금저축
							//cstmt.setInt   ( 15,rows[i].getInt   (colNm_FNDAMT01	   ) );	//장기주식형저축소득1년차불입액  
							//cstmt.setInt   ( 16,rows[i].getInt   (colNm_FNDAMT02	   ) );	//장기주식형저축소득2년차불입액  
							//cstmt.setInt   ( 17,rows[i].getInt   (colNm_FNDAMT03	   ) );	//장기주식형저축소득3년차불입액  
							//cstmt.setInt   ( 18,rows[i].getInt   (colNm_CONAMT99	   ) );	//정치자금 기부금

							cstmt.setString(13,job_cd);														//편집상태1: INSERT, 2: DELETE, 3: UPDATE

							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);				

							cstmt.executeUpdate();

							r_s_yn		= cstmt.getString(14);
							r_msg_cd	= cstmt.getString(15);
							r_msg		= cstmt.getString(16);

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
						}
							
					}






					if ("DS3".equals(gauceName)) {

						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");		//귀속년도         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");		//사번
						int colNm_FAMNM1	 	= ds1.indexOfColumn("FAMNM1");	//'성명'	
						int colNm_RELAT1	  		= ds1.indexOfColumn("RELAT1");		//'관계코드'		
						int colNm_RESINO1    	= ds1.indexOfColumn("RESINO1");	//'주민번호'	
						int colNm_REF1	      		= ds1.indexOfColumn("REF1");			//'외국인'	    
						int colNm_REF2	      		= ds1.indexOfColumn("REF2");			//'100만? 기본공제'	    
						int colNm_REF3	     		= ds1.indexOfColumn("REF3");			//'장애인'	    
						int colNm_REF4	      		= ds1.indexOfColumn("REF4");			//'자녀? 6세 이하자'		
						int colNm_REF5	     		= ds1.indexOfColumn("REF5");			//'경로우대'		
						int colNm_REF6	     		= ds1.indexOfColumn("REF6");			//'부녀자'
						int colNm_REF7	     		= ds1.indexOfColumn("REF7");			//'다자녀YN??'
						int colNm_REF8	     		= ds1.indexOfColumn("REF8");			//'출산입양' 2008.12.29 추가

						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// 신규행이면
									//StringUtil.printMsg("DS TYPE:::","인서트",this);
									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:
									//StringUtil.printMsg("DS TYPE:::","딜리트",this);
									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									//StringUtil.printMsg("DS TYPE2:::","업데이트",this);
									job_cd = "3";
									break;
							} //switch
							
							cstmt = conn.prepareCall(arr_sql[5].toString());
												
							//StringUtil.printMsg("ds3 인적공제저장", "무하하하" ,this);

							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );		//귀속년도      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );		//사번          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNM1) );	//'성명'
							cstmt.setInt( 4,rows[i].getInt(colNm_RELAT1) );				//'관계'	
							cstmt.setString( 5,rows[i].getString(colNm_RESINO1) );	//'주민번호'	
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );			//'외국인'	
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );			//'100만'	
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );			//'장애인'	
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );			//'자녀'	
							cstmt.setString(10,rows[i].getString(colNm_REF5) );		//'경로'
							cstmt.setString(11,rows[i].getString(colNm_REF6) );		//'부녀자
							cstmt.setString(12,rows[i].getString(colNm_REF7) );		//'다자녀YN'
							cstmt.setString(13,rows[i].getString(colNm_REF8) );		//'출산입양'
							cstmt.setString(14,job_cd);												//편집상태1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	
								
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(15);
							r_msg_cd	= cstmt.getString(16);
							r_msg		= cstmt.getString(17);
							
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
						}
					}


					if ("DS7".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");			//귀속년도         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");			//사번
						
						for(int i=0; i<rows.length; i++){
							job_cd = "3"; //항상 업데이트
							cstmt = conn.prepareCall(arr_sql[8].toString());
												
							//StringUtil.printMsg("ds7 전산제출", "업데이트" ,this);
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );			//귀속년도      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );			//사번          
							cstmt.setString( 3,job_cd);													//편집상태1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	
								
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(4);
							r_msg_cd	= cstmt.getString(5);
							r_msg		= cstmt.getString(6);
							
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
						}
					}			
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
