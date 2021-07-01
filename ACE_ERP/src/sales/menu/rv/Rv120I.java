package sales.menu.rv;

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

public class Rv120I extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		} 
		 
		/*
		 * 공통코드 쿼리
		 * SY011 : 사용유무
		 * RV003 : 할인코드 
		 * RV004 : 할인적용방법
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' head, '' detail, '전체' detail_nm    \n")
				  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (B.detail) > 0                  \n");
	
		
		/*
		 * 할인정보 테이블 조회
		 */
		arr_sql[1].append("SELECT T1.DC_SID			    									\n")	/* 활인코드SID                	*/
	      		  .append("		 ,T1.DC_GUBUN_CD        									\n")	/* 활인구분코드 (1단체, 2일반)    	*/
	      		  .append("		 ,T1.DC_ITEM3      											\n")	/* 할인구분3(지역)            	*/
	      		  .append("		 ,T1.DC_ITEM1      											\n")	/* 할인구분1(상품)            	*/
	      		  .append("		 ,T1.DC_ITEM2      											\n")	/* 할인구분2(고객유형)            	*/
	      		  .append("		 ,T1.BGN_DATE      											\n")	/* 시작일         					*/
	      		  .append("		 ,T1.END_DATE        										\n")	/* 종료일         					*/
	      		  .append("		 ,T1.APP_DC_CD         										\n")	/* 할인적용방법(RV004)         	*/
	      		  .append("		 ,SALES.FN_DETAIL_NM ('RV004', T1.APP_DC_CD) AS APP_DC_NM   \n")	
	      		  .append("		 ,INTEGER(T1.APP_DC_RATE) AS APP_DC_RATE					\n")	/* 할인적요율/금액     			*/
	      		  .append("		 ,T1.APP_PERSONS  											\n")	/* 연령   		*/
	      		  .append("		 ,T1.USE_YN         										\n")	/* 사용여부                   		*/
	      		  .append(" FROM SALES.TRV300 T1											\n")
	      		  .append("WHERE 1 = 1 														\n")
	      		  .append("	 AND T1.DC_GUBUN_CD  = '3' 									\n");	//주말 할증만			  

		
		/*
		 * 할인정보 테이블 등록
		 */

		arr_sql[2].append("INSERT INTO SALES.TRV300 (	\n")
				  .append("				 DC_GUBUN_CD    \n")	/* 활인구분코드 (1단체, 2일반)     */
				  .append("				,DC_ITEM2      	\n")	/* 할인구분1(고객유형               	*/
				  .append("				,BGN_DATE      	\n")	/* 시작일                 			*/
				  .append("				,END_DATE      	\n")	/* 종료일         					*/
				  .append("				,APP_DC_CD      \n")	/* 할인적용방법(RV004)        	*/
				  
				  .append("				,APP_DC_RATE    \n")	/* 할인적요율/금액         			*/
				  .append("				,FOC_PERSONS    \n")	/* 적용FOC          				*/
				  .append("				,USE_YN		    \n")	/* 사용여부     					*/
				  .append("				,U_EMPNO		\n")	
				  .append("				,U_DATE		    \n")	
				  
				  .append("				,U_IP		    \n")	
				  .append("			)					\n")
				  
				  .append("VALUES						\n")
				  .append("			(	    			\n")
				  .append("				?,?,?,?,?,		\n")	
				  .append("				?,?,?,?,CURRENT TIMESTAMP,		\n")
				  .append("				?				\n")
				  .append("			)");
		
		
		/*
		 * 할인정보 테이블 수정
		 */

		arr_sql[3].append("UPDATE SALES.TRV300 SET 						\n")
				  .append("		 END_DATE		= ?     				\n")	/* 종료일         					*/
				  .append("		,APP_DC_CD      = ?  					\n")	/* 할인적용방법(RV004)          	*/

				  .append("		,APP_DC_RATE	= ?    					\n")	/* 할인적요율/금액    			 	*/
				  .append("		,FOC_PERSONS	= ?  					\n")	/* 적용FOC               		*/
				  .append("		,USE_YN         = ?						\n")	/* 사용여부                   		*/
				  .append("		,U_EMPNO      	= ?						\n")	
				  .append("		,U_DATE         = CURRENT TIMESTAMP						\n")	

				  .append("		,U_IP         	= ?						\n")	
				 .append ("WHERE   DC_SID 		= ?       				\n");
				  
		
		 arr_sql[4].append("DELETE FROM SALES.TRV300 WHERE DC_SID = ?");	
		 
		 
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
		GauceDataSet ds1 = null; // 할인정보 테이블 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		String sDate 		= HDUtil.nullCheckStr(req.getParameter("sDate"));		// 기준일자
		String sSaup	 	= HDUtil.nullCheckStr(req.getParameter("sSaup")); 		// 지역 (trm300 테이블에서는 dc_item3 컬럼=문자열임)
		String sGoods	 	= HDUtil.nullCheckStr(req.getParameter("sGoods")); 		// 상품 (trm300 테이블에서는 dc_item1 컬럼=문자열임)
		String sSeason	 	= HDUtil.nullCheckStr(req.getParameter("sSeason")); 	// 시즌 
		String sUse_yn 		= HDUtil.nullCheckStr(req.getParameter("sUse_yn")); 	// 사용유무
		
		StringUtil.printMsg("날자", sDate+"", this);
		StringUtil.printMsg("지역", sSaup+"", this);
		StringUtil.printMsg("상품", sGoods+"", this);
		StringUtil.printMsg("시즌", sSeason+"", this);
		StringUtil.printMsg("사용", sUse_yn+"", this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					/*
					 * 대리점 조회
					 */
					if ("DS1".equals(gauceName)) {
	
						if (!"".equals(sDate)) { // 기준일자
					  		 arr_sql[1].append("		 AND ? BETWEEN T1.BGN_DATE AND T1.END_DATE	\n");	//기준일
						}
						if (!"0".equals(sSaup)) { // 지역
							arr_sql[1].append("		 AND T1.DC_ITEM3  = ?      						\n"); 
						}
						if (!"0".equals(sGoods)) { // 상품
							arr_sql[1].append("		 AND T1.DC_ITEM1  = ?      						\n"); 
						}
						if (!"".equals(sSeason)) { // 시즌
					  		 arr_sql[1].append("		 AND T1.DC_ITEM2  = ?      						\n"); 
						}
						if (!"".equals(sUse_yn)) { // 사용유무
					  		 arr_sql[1].append("		 AND T1.USE_YN  = ?      						\n"); 
						}
						//arr_sql[1].append("ORDER BY T2.ITEM7 					\n");	//할인코드 정렬순서		
				  		 // 쿼리 실행
				  		 
				  		stmt = conn.getGauceStatement(arr_sql[1].toString()); 
				  		// 조건
				  		if (!"".equals(sDate)) {
					  		stmt.setString(sCnt1++, sDate);		// 기준일
						}
						
						if (!"0".equals(sSaup)) { 
							stmt.setString(sCnt1++, sSaup );			// 지역 
						}

						if (!"0".equals(sGoods)) { 
							stmt.setString(sCnt1++, sGoods );			// 상품 
						}

						if (!"".equals(sSeason)) { 
							stmt.setString(sCnt1++, sSeason );			// 시즌 
						}
						
						if (!"".equals(sUse_yn)) { 
							stmt.setString(sCnt1++, sUse_yn );			// 사용유무 
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
//		ResultSetMetaData 	rsmd 		= null;
		ResultSet 			rs 			= null;
//		String[] 			columnName 	= null;

		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		/* DataSet */
		GauceDataSet ds1 = req.getGauceDataSet("DS1");
		
		try{
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_DcSid                 = ds1.indexOfColumn("DC_SID");
				int colNm_DcGubun_cd            = ds1.indexOfColumn("DC_GUBUN_CD");
				int colNm_DcItem2               = ds1.indexOfColumn("DC_ITEM2");
				int colNm_BgnDate               = ds1.indexOfColumn("BGN_DATE");
				int colNm_EndDate               = ds1.indexOfColumn("END_DATE");
				int colNm_AppDc_cd              = ds1.indexOfColumn("APP_DC_CD");
				int colNm_AppDc_rate            = ds1.indexOfColumn("APP_DC_RATE");
				int colNm_FocPersons            = ds1.indexOfColumn("FOC_PERSONS");
				int colNm_UseYn                 = ds1.indexOfColumn("USE_YN");
				
				for(int i = 0; i < rows.length; i++) {

					int iCnt = 1;
					int dCnt = 1;
					int uCnt = 1;
					
					int colNum = 0;
					
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							StringUtil.printMsg("쿼리",arr_sql[2].toString(), this);
							stmt = conn.getGauceStatement(arr_sql[2].toString());
					
							stmt.setGauceDataRow(rows[i]);
							  
							//StringUtil.printMsg("colNm_DcSid",rows[i].getString(colNm_DcSid)+"", this);
							//StringUtil.printMsg("colNm_DcGubun_cd",rows[i].getString(colNm_DcGubun_cd)+"", this);
							//StringUtil.printMsg("colNm_DcItem2",rows[i].getString(colNm_DcItem2)+"", this);
							//StringUtil.printMsg("colNm_BgnDate",rows[i].getString(colNm_BgnDate)+"", this);
							//StringUtil.printMsg("colNm_EndDate",rows[i].getString(colNm_EndDate)+"", this);
							//StringUtil.printMsg("colNm_AppDc_cd",rows[i].getString(colNm_AppDc_cd)+"", this);
							//StringUtil.printMsg("colNm_AppDc_rate",rows[i].getString(colNm_AppDc_rate)+"", this);
							//StringUtil.printMsg("colNm_FocPersons",rows[i].getString(colNm_FocPersons)+"", this);
							//StringUtil.printMsg("colNm_UseYn",rows[i].getString(colNm_UseYn)+"", this);

							
							stmt.setString(iCnt++, "2");			//여기서 기타 할인할증("2")로 기본셋팅
							stmt.bindColumn(iCnt++, colNm_DcItem2);
							stmt.bindColumn(iCnt++, colNm_BgnDate);
							stmt.bindColumn(iCnt++, colNm_EndDate);
							stmt.bindColumn(iCnt++, colNm_AppDc_cd);
							stmt.bindColumn(iCnt++, colNm_AppDc_rate);
							stmt.bindColumn(iCnt++, colNm_FocPersons);
							stmt.bindColumn(iCnt++, colNm_UseYn);
							stmt.setString(iCnt++, iParamEmpno);
							stmt.setString(iCnt++, iParamIp);

							// 쿼리실행
							stmt.executeUpdate();
							
							stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(uCnt++, colNm_EndDate);
							stmt.bindColumn(uCnt++, colNm_AppDc_cd);
							stmt.bindColumn(uCnt++, colNm_AppDc_rate);
							stmt.bindColumn(uCnt++, colNm_FocPersons);
							stmt.bindColumn(uCnt++, colNm_UseYn);
							stmt.setString(uCnt++, iParamEmpno);
							stmt.setString(uCnt++, iParamIp);
							stmt.bindColumn(uCnt++, colNm_DcSid);
							
							// 쿼리실행
							stmt.executeUpdate();
							
							if(stmt!=null) {
								stmt.close();
							}
							break;
						
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[4].toString());
							stmt.setGauceDataRow(rows[i]);
							
							stmt.bindColumn(dCnt++, colNm_DcSid);
							
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
