/******************************************************************************
 * 시스템명		: 협력업체 등록
 * 프로그램ID 	: CU050I
 * J  S  P		: cu050i
 * 서 블 릿		: Cu050I
 * [수  정   일  자][수정자] 내용
 * [2008-02-27][심동현] 사업자전용 : 테이블 수정에 맞춰 다시 수정
 * 					협력업체 정보 SALES.TCU030 1개만 사용함.
 * 					회계상의 거래처 ACCOUNT.GCZM_VENDER
 * [2013-07-03][박경국] 공사관리시스템 협력업체 코드생성메뉴로 신규작성
 *****************************************************************************/
package pms.menu.sy;

import java.io.FileOutputStream;
import java.io.InputStream;
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

public class Sy201I extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		/*
		 * 협력업체조회
		 */
		arr_sql[1].append("SELECT coop_sid			    										\n")	/* 협력업체SID                	*/
				  .append("		 ,coop_cd      												 				\n")	/* 협력업체코드               	*/
				  .append("		 ,coop_nm     												 				\n")	/* 협력업체명               	*/
	      		 	      		  
				  .append("FROM PMS.TSY030 \n")
				  .append("WHERE 1 = 1 																		\n");	      		  
		
		/*
		 *  협력업체등록
		 */
		arr_sql[4].append("INSERT INTO PMS.TSY030 (")
				  .append("				 coop_cd      \n")		/* 협력업체코드    */
				  .append("				,coop_nm      \n")		/* 협력업체명       */
				  .append("		 		,u_date       	\n") 		/* 최종수정일자    */
				  .append("		 		,u_empno       	\n")	/* 최종수정자사번 */
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,CURRENT TIMESTAMP,?	\n")
				  .append("			)");
		
		/*
		 * 협력업체수정
		 */
		arr_sql[7].append("UPDATE PMS.TSY030 SET 						\n")
				  .append("		 coop_cd		= ?     									\n")		/* 협력업체코드           	*/
				  .append("		,coop_nm		= ?									\n")		/* 협력업체명	 			*/
				  .append("		,u_date        	= CURRENT TIMESTAMP		\n") 	/* 최종수정일자           	*/
				  .append("		,u_empno       	= ?						\n")					/* 최종수정자사번        	*/
				 .append ("WHERE   coop_sid 	= ?       				\n");
			
		/*
		 * 협력업체삭제
		 */	  

		 arr_sql[10].append("DELETE FROM PMS.TSY030 WHERE coop_sid = ?");	
	
		 /*
		 * Coop SID 얻어오기
		 */
		arr_sql[13].append("SELECT coop_sid FROM PMS.TSY030 WHERE coop_cd = ?\n");
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
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 협력업체 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		String sCoop_cd = HDUtil.nullCheckStr(req.getParameter("sCoop_cd")); 	// 협력업체 코드
		String sCoop_nm = HDUtil.nullCheckStr(req.getParameter("sCoop_nm")); 	// 협력업체 명 
		//StringUtil.printMsg("협력업체 코드",sCoop_cd,this);
		//StringUtil.printMsg("협력업체 명",sCoop_nm,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					// 협력업체 조회
					if ("DS1".equals(gauceName)) {
						if (!"".equals(sCoop_cd)) { // 협력업체 코드
							 arr_sql[1].append("		 AND coop_cd  LIKE ? \n");	
						}
						if (!"".equals(sCoop_nm)) { //협력업체 명
							 arr_sql[1].append("		 AND coop_nm LIKE ?	\n");	 
						}
						 arr_sql[1].append("		 ORDER BY coop_cd	\n");
		
						stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		
						// 조건
						if (!"".equals(sCoop_cd)) { 
							stmt.setString(sCnt1++, sCoop_cd + "%");				// 협력업체 코드 
											}
						if (!"".equals(sCoop_nm)) {
							stmt.setString(sCnt1++, sCoop_nm + "%");		// 협력업체 명
						}
					}
					rs = stmt.executeQuery();		// Query 실행
					getDataSet(rs, ds1).flush();
					sCnt1 = 1;
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
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		int fCoopSid = 0;
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_CoopSid             = ds1.indexOfColumn("coop_sid".toUpperCase());
				int colNm_CoopCd              = ds1.indexOfColumn("coop_cd".toUpperCase());
				int colNm_CoopNm             = ds1.indexOfColumn("coop_nm".toUpperCase());
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[4].toString());	//tsy030 저장
						
							//StringUtil.printMsg("colNm_CoopCd " , colNm_CoopCd+"",this);
							//StringUtil.printMsg("colNm_CoopNm " , colNm_CoopNm+"",this);
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(iCnt++, colNm_CoopCd);
							stmt.bindColumn(iCnt++, colNm_CoopNm);
							stmt.setString(iCnt++, iParamEmpno);
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							
							stmt = conn.getGauceStatement(arr_sql[13].toString());
						
							stmt.setString(1, rows[i].getColumnValue(colNm_CoopCd)+"");
							rs = stmt.executeQuery();
							
							if(rs.next()) {
								fCoopSid = rs.getInt(1);
							}
													
							rs.close();
							stmt.close();
							break;
							
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[7].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_CoopCd);
							stmt.bindColumn(uCnt++, colNm_CoopNm);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.bindColumn(uCnt++, colNm_CoopSid);
							
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[10].toString());
							stmt.setGauceDataRow(rows[i]);
							stmt.bindColumn(dCnt++, colNm_CoopSid);
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
					}
				}
			}	
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally{
			if(stmt!=null) stmt.close();
		}
	}
}