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

public class p030009i_04 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 교육비공제 테이블  정보 조회
		arr_sql[0].append("{CALL PAYROLL.PR_P030009I_04s (?,?,?) }");

		// 저장/수정
		arr_sql[1].append("{CALL PAYROLL.PR_P030009I_04i (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("START ", "시작지샂", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* 검색시 필요한 조건  --------------------------------------------------------------- */
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // 귀속년도
		String eno	            = HDUtil.nullCheckStr(req.getParameter("eno"));	      // 사번 
		String eJuno	        = HDUtil.nullCheckStr(req.getParameter("eJuno"));	  // 공제자주민

		/* 검색시 필요한 조건  --------------------------------------------------------------- */		
		
		/*StringUtil.printMsg("디버그eyy: ", eyy, this);		
		StringUtil.printMsg("디버그eno: ", eno, this);
		StringUtil.printMsg("디버그eName: ", eName, this);
		StringUtil.printMsg("디버그eRelation: ", eRelation, this);
		StringUtil.printMsg("디버그eJuno: ", eJuno, this);*/
		
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
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   		= ds1.indexOfColumn("APPDT");	//귀속년도         
						int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");	//사번             
						int colNm_FAMNMK		= ds1.indexOfColumn("FAMNMK");  //공제대상 이름    
						int colNm_FAMRELA_CD	= ds1.indexOfColumn("FAMRELA_CD");  //공제대상 관계 (MI
						int colNm_FAMJUNO		= ds1.indexOfColumn("FAMJUNO");	//공제대상 주민번호
						int colNm_REF1   		= ds1.indexOfColumn("REF1");	//외국인YN         
						int colNm_REF2   		= ds1.indexOfColumn("REF2");	//100만원이하YN    
						int colNm_REF3   		= ds1.indexOfColumn("REF3");	//장애인YN         
						int colNm_REF4   		= ds1.indexOfColumn("REF4");	//자녀YN           
						int colNm_REF5   		= ds1.indexOfColumn("REF5");	//경로YN    
						int colNm_EDU10			= ds1.indexOfColumn("EDU10");	//   국세청유치원비
						int colNm_EDU11			= ds1.indexOfColumn("EDU11");	//   국세청초교육비
						int colNm_EDU12			= ds1.indexOfColumn("EDU12");	//   국세청대교육비
						int colNm_EDU13			= ds1.indexOfColumn("EDU13");	//   국세청장교육비
						int colNm_EDU20			= ds1.indexOfColumn("EDU20");	//   유치원비외
						int colNm_EDU21			= ds1.indexOfColumn("EDU21");	//   초교육비외    
						int colNm_EDU22			= ds1.indexOfColumn("EDU22");	//   대교육비외    
						int colNm_EDU23			= ds1.indexOfColumn("EDU23");	//   장교육비외    
						int colNm_FLAGCOL 		= ds1.indexOfColumn("FLAGCOL");	//플래그 컬
						
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
									String temp1 =rows[i].getString(colNm_FLAGCOL) ;	//조회 프로시저에서 강제로 넣은 플래그
									if("U".equals(temp1)) {	//업데이트면..
										//StringUtil.printMsg("DS TYPE2:::","업데이",this);
										job_cd = "3";
									} else {	//최초 인서트면;;
										//StringUtil.printMsg("DS TYPE2:::","인서트",this);
										job_cd = "1";
									};
									break;
							} //switch
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							//StringUtil.printMsg("02시작 저장", "무하하하" ,this);
 								
							cstmt.setString( 1,rows[i].getString(colNm_APPDT) );//귀속년도      
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );//사번          
							cstmt.setString( 3,rows[i].getString(colNm_FAMNMK) );//공제대상 이름              
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_FAMRELA_CD) );//공제대상 관계 (MINOR_CD)   
							cstmt.setString( 5,rows[i].getString(colNm_FAMJUNO) );//공제대상 주민번호       
							cstmt.setString( 6,rows[i].getString(colNm_REF1) );//외국인YN
							cstmt.setString( 7,rows[i].getString(colNm_REF2) );//100만원이하YN
							cstmt.setString( 8,rows[i].getString(colNm_REF3) );//장애인YN
							cstmt.setString( 9,rows[i].getString(colNm_REF4) );//자녀YN
							cstmt.setString(10,rows[i].getString(colNm_REF5) );//경로YN
							cstmt.setInt   (11,rows[i].getInt   (colNm_EDU10) );//국세청초교육비
							cstmt.setInt   (12,rows[i].getInt   (colNm_EDU11) );//국세청초교육비
							cstmt.setInt   (13,rows[i].getInt   (colNm_EDU12) );//국세청대교육비
							cstmt.setInt   (14,rows[i].getInt   (colNm_EDU13) );//국세청장교육비
							cstmt.setInt   (15,rows[i].getInt   (colNm_EDU20) );//초교육비외    
							cstmt.setInt   (16,rows[i].getInt   (colNm_EDU21) );//초교육비외    
							cstmt.setInt   (17,rows[i].getInt   (colNm_EDU22) );//대교육비외    
							cstmt.setInt   (18,rows[i].getInt   (colNm_EDU23) );//장교육비외    
							cstmt.setString(19,job_cd                           );	//편집상태1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);				
							cstmt.executeUpdate();
							
							r_s_yn		= cstmt.getString(20);
							r_msg_cd	= cstmt.getString(21);
							r_msg		= cstmt.getString(22);
							
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
