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

public class p030010i_03 extends SuperServlet {
	
	public void makeSql() {

		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 의료비 테이블  정보 조회
		arr_sql[0].append("{CALL PAYROLL.PR_P030010I_03S (?,?,?) }");

		// 저장/수정
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I_03I (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("START ", "시작", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* 검색시 필요한 조건  --------------------------------------------------------------- */
		String eyy 		    = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // 귀속년도
		String eno	            = HDUtil.nullCheckStr(req.getParameter("eno"));	      // 사번 
		String eJuno	        = HDUtil.nullCheckStr(req.getParameter("eJuno"));	  // 공제자주민
		/* 검색시 필요한 조건  --------------------------------------------------------------- */		
		
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

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );
                        stmt.setString(3, eJuno	    );

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
						GauceDataRow[] 	rows		= ds1.getDataRows();
						GauceDataColumn[] 	cols	= ds1.getDataColumns();
						int colNm_APPDT   			= ds1.indexOfColumn("APPDT");			//귀속년도         
						int colNm_EMPNO  			= ds1.indexOfColumn("EMPNO");			//사번             
						int colNm_FAMNMK			= ds1.indexOfColumn("FAMNMK");		//공제대상 이름    
						int colNm_FAMRELA_CD	= ds1.indexOfColumn("FAMRELA_CD");  //공제대상 관계 (MI
						int colNm_FAMJUNO			= ds1.indexOfColumn("FAMJUNO");		//공제대상 주민번호
						int colNm_REF1   				= ds1.indexOfColumn("REF1");				//외국인YN         
						int colNm_REF2   				= ds1.indexOfColumn("REF2");				//100만원이하YN    
						int colNm_REF3   				= ds1.indexOfColumn("REF3");				//장애인YN         
						int colNm_REF4   				= ds1.indexOfColumn("REF4");				//자녀YN           
						int colNm_REF5   				= ds1.indexOfColumn("REF5");				//경로YN    
						int colNm_INDNO				= ds1.indexOfColumn("INDNO");			//사업자등록번호	 
						int colNm_INDNAME			= ds1.indexOfColumn("INDNAME");		//의료기관명	

						int colNm_CASHCNTA	  	= ds1.indexOfColumn("CASHCNTA");	//국세청현금건수	  
						int colNm_CASHAMTA	  	= ds1.indexOfColumn("CASHAMTA");	//국세청현금	      
     
						int colNm_CASHCNTB	  	= ds1.indexOfColumn("CASHCNTB");	//현금건수외	      
						int colNm_CASHAMTB	  	= ds1.indexOfColumn("CASHAMTB");	//현금외

						int colNm_PRFCD 				= ds1.indexOfColumn("PRFCD");			//의료비증빙코드
						int colNm_FLAGCOL 			= ds1.indexOfColumn("FLAGCOL");		//플래그 컬럼
						
						
						for(int i=0; i<rows.length; i++){
							job_cd = "1";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_INSERT:	// 신규행이면

									job_cd = "1";
									break;
								case GauceDataRow.TB_JOB_DELETE:

									job_cd = "2";
									break;
								case GauceDataRow.TB_JOB_UPDATE:
									String temp1 =rows[i].getString(colNm_FLAGCOL) ;	//조회 프로시저에서 강제로 넣은 플래그
									if("U".equals(temp1)) {	//업데이트면..

										job_cd = "3";
									} else {	//최초 인서트면;;

										job_cd = "1";
									};
									break;
							} //switch

							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						

 								
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );			//귀속년도      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );			//사번          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNMK) );		//공제대상 이름              
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_FAMRELA_CD) );	//공제대상 관계 (MINOR_CD)   
							cstmt.setString( 5,rows[i].getString(colNm_FAMJUNO) );		//공제대상 주민번호       
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );				//외국인YN
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );				//100만원이하YN
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );				//장애인YN
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );				//자녀YN
							cstmt.setString(10,rows[i].getString(colNm_REF5) );			//경로YN
							cstmt.setString(11,rows[i].getString(colNm_INDNO	)  );		//사업자등록번호	 
							cstmt.setString(12,rows[i].getString(colNm_INDNAME	)  );  //의료기관명	

							cstmt.setInt   (13,rows[i].getInt    (colNm_CASHCNTA)  );		//국세청현금건수	  
							cstmt.setInt   (14,rows[i].getInt    (colNm_CASHAMTA)  );	//국세청현금	      
  
							cstmt.setInt   (15,rows[i].getInt    (colNm_CASHCNTB)  );		//현금건수외	      
							cstmt.setInt   (16,rows[i].getInt    (colNm_CASHAMTB)  );	//현금외

							cstmt.setString(17,rows[i].getString(colNm_PRFCD)  );			//의료비증빙코드	
							cstmt.setString(18,job_cd                           );						//편집상태1: INSERT, 2: DELETE, 3: UPDATE

							cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);	
							

							cstmt.executeUpdate();
						
							r_s_yn		= cstmt.getString(19);
							r_msg_cd	= cstmt.getString(20);
							r_msg		= cstmt.getString(21);
							
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
