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

public class p030010i_10 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 주택자금 테이블  정보 조회
		arr_sql[0].append("{CALL PAYROLL.PR_P030010I_10s (?,?) }");

		// 저장/수정
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I_10i (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("START ", "시작입니다.", this);
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;

		/* DataSet */
		GauceDataSet ds1 = null;  
		
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		
		/* 검색시 필요한 조건  --------------------------------------------------------------- */
		String eyy 		        = HDUtil.nullCheckStr(req.getParameter("eyy"));	      // 귀속년도
		String eno					= HDUtil.nullCheckStr(req.getParameter("eno"));	      // 사번 
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

						stmt.setString(1, eyy 		);		
						stmt.setString(2, eno	    );

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
			String givtype=""  ; 	//유형선언
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
							int colNm_APPYY   		= ds1.indexOfColumn("APPYY");		//귀속년도         
							int colNm_EMPNO  		= ds1.indexOfColumn("EMPNO");		//사번             
							int colNm_SEQ     			= ds1.indexOfColumn("SEQ");			//기부년
							int colNm_DUDGB	  		= ds1.indexOfColumn("DUDGB");		//코드          
							int colNm_FINACD     	= ds1.indexOfColumn("FINACD");		//금융기관코드 
							int colNm_FINANM			= ds1.indexOfColumn("FINANM");		//금융기관상호
							int colNm_ACCNO			= ds1.indexOfColumn("ACCNO");		//계좌번호
							int colNm_YEARLY			= ds1.indexOfColumn("YEARLY");		//납입연차
							int colNm_PAYAMT     	= ds1.indexOfColumn("PAYAMT");		//불입금액  
							int colNm_DEDAMT     	= ds1.indexOfColumn("DEDAMT");	//공제금액   
							int colNm_STATDT     	= ds1.indexOfColumn("STATDT");		//가입일
							int colNm_FLAGCOL 		= ds1.indexOfColumn("FLAGCOL");	//플래그 컬
						
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
									}
									break;
							} //switch


							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							cstmt.setString( 1,rows[i].getString(colNm_APPYY) );		//귀속년도       
							cstmt.setString( 2,rows[i].getString(colNm_EMPNO) );		//사번             
							cstmt.setString( 3,rows[i].getString(colNm_SEQ));			//기부년          
							cstmt.setString( 4,rows[i].getString(colNm_DUDGB));		//코드             
							cstmt.setString( 5,rows[i].getString(colNm_FINACD));		//금융기관코드 
							cstmt.setString( 6,rows[i].getString(colNm_FINANM));		//금융기관상호 
							cstmt.setString( 7,rows[i].getString(colNm_ACCNO));		//계좌번호       
							cstmt.setInt( 8,rows[i].getInt(colNm_YEARLY));				//납입연차       
							cstmt.setInt( 9,rows[i].getInt(colNm_PAYAMT));				//불입금액       
							cstmt.setInt( 10,rows[i].getInt(colNm_DEDAMT));				//공제금액       
							cstmt.setString( 11,rows[i].getString(colNm_STATDT));	//가입일          
							cstmt.setString(12,job_cd                           );					//편집상태1: INSERT, 2: DELETE, 3: UPDATE
							cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);		

							cstmt.executeUpdate();

							r_s_yn		= cstmt.getString(13);
							r_msg_cd	= cstmt.getString(14);
							r_msg		= cstmt.getString(15);
							

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
