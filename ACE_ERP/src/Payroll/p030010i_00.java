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

public class p030010i_00 extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// 종전근무지 테이블  정보 조회
		arr_sql[0].append("{CALL PAYROLL.PR_P030010S (?,?) }");

		// 저장/수정(3개)
		arr_sql[1].append("{CALL PAYROLL.PR_P030010I(?,?,?) }");
	
	}
 
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("START ", "시작", this);
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
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){

				String gauceName = (String)it.next();

				//StringUtil.printMsg("gauceName ::: ", gauceName, this);
				
				ds1 = req.getGauceDataSet(gauceName);

				if(ds1!=null){

					if ("DS1".equals(gauceName)) {

						GauceDataRow[] 		rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
					
						int colNm_APPDT   			= ds1.indexOfColumn("APPDT");			//귀속년도         
						int colNm_EMPNO  			= ds1.indexOfColumn("EMPNO");			//사번             

						int colNm_HOUAMT01	  	= ds1.indexOfColumn("HOUAMT01");	//주택임차차입금   
						int colNm_HOUAMT02	  	= ds1.indexOfColumn("HOUAMT02");	//월세액            
						int colNm_HOUAMT03	  	= ds1.indexOfColumn("HOUAMT03");	//장기주택저당차입금  14년미만   
						int colNm_HOUAMT04	  	= ds1.indexOfColumn("HOUAMT04");	//장기주택저당차입금  15년이상 
						int colNm_HOUAMT05	  	= ds1.indexOfColumn("HOUAMT05");	//장기주택저당차입금  30년이상				

						int colNm_PESAMT01   		= ds1.indexOfColumn("PESAMT01");		//개인연금                  
						int colNm_PESAMT02	  	= ds1.indexOfColumn("PESAMT02");		//연금저축	                

						int colNm_FNDAMT01	  	= ds1.indexOfColumn("FNDAMT01");	//장기주식형저축소득1년차불입액
						int colNm_FNDAMT02	  	= ds1.indexOfColumn("FNDAMT02");	//장기주식형저축소득2년차불입액
						int colNm_FNDAMT03	  	= ds1.indexOfColumn("FNDAMT03");	//장기주식형저축소득3년차불입액
						

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
									//String temp1 =rows[i].getString(colNm_FLAGCOL) ;	//조회 프로시저에서 강제로 넣은 플래그
									//if("U".equals(temp1)) {	//업데이트면..
										//StringUtil.printMsg("flagcol2 :::",  temp1 + "***" ,this);
										//StringUtil.printMsg("DS TYPE2:::","업데이",this);
									//	job_cd = "3";
									//} else {	//최초 인서트면;;
										//StringUtil.printMsg("flagcol3:::",  temp1 + "***" ,this);
										//StringUtil.printMsg("DS TYPE2:::","인서트",this);
										job_cd = "3";
									//};
									break;
							} //switch
							//StringUtil.printMsg("job_cd: ",job_cd,this);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
						
							//StringUtil.printMsg("02시작 저장", "무하하하" ,this);
/*
							StringUtil.printMsg("APPDT) ", rows[i].getString(colNm_APPDT) 		 ,this);
							StringUtil.printMsg("EMPNO) ", rows[i].getString(colNm_EMPNO) 		 ,this);
							StringUtil.printMsg("FAMNMK)", rows[i].getString(colNm_FAMNMK) 		 ,this);
							StringUtil.printMsg("FAMRELA", rows[i].getInt   (colNm_FAMRELA_CD)	 ,this);
							StringUtil.printMsg("FAMJUNO", rows[i].getString(colNm_FAMJUNO)		 ,this);
							StringUtil.printMsg("REF1) )", rows[i].getString(colNm_REF1) 		 ,this);
							StringUtil.printMsg("REF2) )", rows[i].getString(colNm_REF2) 		 ,this);
							StringUtil.printMsg("REF3) )", rows[i].getString(colNm_REF3) 		 ,this);
							StringUtil.printMsg("REF4) )", rows[i].getString(colNm_REF4) 		 ,this);
							StringUtil.printMsg("REF5) )", rows[i].getString(colNm_REF5) 		 ,this);
							StringUtil.printMsg("REFB11)", rows[i].getInt   (colNm_REFB11) 		 ,this);
							StringUtil.printMsg("REFB12)", rows[i].getInt   (colNm_REFB12) 		 ,this);
							StringUtil.printMsg("REFB13)", rows[i].getInt   (colNm_REFB13) 		 ,this);
							StringUtil.printMsg("REFB14)", rows[i].getInt   (colNm_REFB14) 		 ,this);
*/							
							
							
							
							cstmt.setString(1,rows[i].getString(colNm_APPDT) );				//귀속년도      
							cstmt.setString(2,rows[i].getString(colNm_EMPNO) );				//사번

							cstmt.setInt   ( 3,rows[i].getInt   (colNm_HOUAMT01	) );	//주택임차차입금           
/*
							cstmt.setInt   ( 4,rows[i].getInt   (colNm_HOUAMT02	) );	//월세액           
							cstmt.setInt   ( 5,rows[i].getInt   (colNm_HOUAMT03	) );	//장기주택저당차입금  14년미만    
							cstmt.setInt   ( 6,rows[i].getInt   (colNm_HOUAMT04	) );	//장기주택저당차입금  15년이상
							cstmt.setInt   ( 7,rows[i].getInt   (colNm_HOUAMT05	) );	//장기주택저당차입금  30년이상 							

							cstmt.setInt   ( 8,rows[i].getInt   (colNm_PESAMT01	) );		//개인연금 
							cstmt.setInt   ( 9,rows[i].getInt   (colNm_PESAMT02	) );		//연금저축  				

							cstmt.setInt   ( 10,rows[i].getInt   (colNm_FNDAMT01) );	//장기주식형저축소득1년차불입액  
							cstmt.setInt   ( 11,rows[i].getInt   (colNm_FNDAMT02) );	//장기주식형저축소득2년차불입액  
							cstmt.setInt   ( 12,rows[i].getInt   (colNm_FNDAMT03) );	//장기주식형저축소득3년차불입액    

							cstmt.setString(13,job_cd );												//편집상태1: INSERT, 2: DELETE, 3: UPDATE

							cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	
*/
							//System.out.print("DS TYPE:::업데이트99");
	
							cstmt.executeUpdate();
							
							//r_s_yn		= cstmt.getString(14);
							//r_msg_cd	= cstmt.getString(15);
							//r_msg		= cstmt.getString(16);
							
							//if(!r_s_yn.equals("Y"))
							//	throw new Exception(r_msg);
							
							//if(ds_result!=null){
							//	GauceDataRow row1 = ds_result.newDataRow();
								//row1.addColumnValue(r_s_yn);
								//row1.addColumnValue(r_msg_cd);
								//row1.addColumnValue(r_msg);
								
							//	ds_result.addDataRow(row1);	
							//}
							//if(cstmt!=null) cstmt.close();
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
