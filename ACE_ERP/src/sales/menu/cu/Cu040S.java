package sales.menu.cu;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Cu040S extends SuperServlet {

	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * 공통코드 쿼리
		 * 대리점구분 : CU006
		 * 직판구분 : CU012
		 * 지역 : SY006
		 * 계약상태 : CU013
		 * 사용유무 : SY011
		 * 보증보험회사 : CU010
		 * 하위대리점여부 : CU011
		 */
		arr_sql[0].append ("SELECT										\n")
				  .append ("	' ' head, ' ' detail, '전체' detail_nm    \n")
				  .append ("FROM DUAL                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.head, B.detail, B.detail_nm           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.head = B.head                        \n")
				  .append (" AND B.head = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.detail)) > 0                  \n");
		
		/*
		 * 대리점 조회
		 */
		arr_sql[1].append("SELECT 																							\n")
	       		  .append(" 	 T2.SAL_DAM_NM 																				\n") /* 영업담당자       */
	       		  .append("		,T1.CLIENT_CD 																				\n") /* 대리점 코드      */
			      .append("		,T1.VEND_CD 																				\n") /* [회계]거래처 코드*/
			      .append("		,T1.CLIENT_NM 																				\n") /* 대리점 명        */
			      .append("		,SALES.FN_DETAIL_NM ('CU006',T1.AGEN_GU)     AS AGEN_GU_NAME 								\n") /* 구분             */
			      .append("		,SALES.FN_DETAIL_NM ('CU012',T1.DIR_YN)      AS DIR_YN_NAME 								\n") /* 직판             */
			      .append("		,SALES.FN_DETAIL_NM ('SY006',T1.AREA_CD)     AS AREA_CD_NAME 								\n") /* 지역             */
			      .append("		,T1.COMMI_RATE 																				\n") /* 수수료율         */
			      .append("		,SALES.FN_DETAIL_NM ('CU013',T1.CUNT_STATUS) AS CUNT_STATUS_NAME 							\n") /* 계약             */
			      .append("		,T1.CLIENT_DAM_NM 																			\n") /* 매출처담당자     */
			      .append("		,T1.TEL_NO 																					\n") /* 전화번호         */
			      .append("		,T1.MOBILE_NO 																				\n") /* 휴대전화         */
			      .append("		,T1.FAX_NO 																					\n") /* 팩스번호         */
			      .append("		,T1.E_MAIL 																					\n") /* 메일주소         */
			      .append("		,T3.CONT_DATE 																				\n") /* 계약일자         */
			      .append("		,T3.EXPIRE_DATE 																			\n") /* 만기일자         */
			      .append("		,SALES.FN_DETAIL_NM ('CU010',T3.INSUR_COMP_CD) AS INSUR_COMP_CD_NAME 						\n") /* 보증보험회사명   */      
			      .append("		,SALES.FN_DETAIL_NM ('SY011',T1.USE_YN)      AS USE_YN_NAME 								\n") /* 사용유무         */
			      .append("FROM SALES.TCU030 T1 LEFT OUTER JOIN SALES.TSY410 T2 ON T1.SAL_DAM_SID  = T2.SAL_DAM_SID 		\n")
	              .append("		LEFT OUTER JOIN SALES.TCU031 T3 ON T1.CLIENT_SID   = T3.CLIENT_SID 							\n")
				  .append("WHERE 1 = 1 																						\n")
		  		  .append("		AND T3.CONT_DATE    = (SELECT MAX(T4.CONT_DATE ) 											\n")
				  .append("									FROM SALES.TCU031 T4 											\n")
				  .append("									WHERE T4.CLIENT_SID   = T1.CLIENT_SID) 							\n")
				  .append("		AND T1.CLIENT_GU = '1' 																		\n"); /* 매출처구분 : 2:대리점) */
				
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
		    for(int i=0; i<dSets.length;i++){
		    	 if(dSets[i].getName().equals("codeDs5")){//사용유무
			    		GauceDataSet ds1 = gis.read("USEYN"); 		
			    		cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "SY011");
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set
			   			rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];	
			   		} else if(dSets[i].getName().equals("sCodeDs1")){//사용유무
			    		GauceDataSet ds1 = gis.read("S_USEYN"); 		
			    		cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, "SY011");
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set
			   			rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];	
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

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		/*
		 * 검색시 필요한 조건
		 */
		
		String sClient_sid = HDUtil.nullCheckStr(greq.getParameter("sClient_sid"));	// 매출처 SID
		String sClient_nm = HDUtil.nullCheckStr(greq.getParameter("sClient_nm")); 	// LIKE
		String sSal_dam_sid = HDUtil.nullCheckStr(greq.getParameter("sSal_dam_sid")); 	// 영업담당자 코드 
		String sUse_yn = HDUtil.nullCheckStr(greq.getParameter("sUse_yn"));			// 사용유무 
		
		try {
			int sCnt1 = 1;
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DS1");
					if (!"".equals(sClient_nm)) { // 대리점코드/명
				  		 arr_sql[1].append("		 AND (T1.client_cd    LIKE ? OR T1.client_nm LIKE ?)	\n");	//매출처코드
					}
					if (!"".equals(sSal_dam_sid)) { // 영업담당자명/코드
						arr_sql[1].append("					AND (T2.SAL_DAM_SID = ?) 								\n");        /* 영업담당자 */
					}
					if (!"".equals(sUse_yn)) { // 사용유무 
				  		 arr_sql[1].append("		 AND T1.use_yn     = ?          						\n");	// 사용여부 
					}
					arr_sql[1].append("				ORDER BY T2.SAL_DAM_NM  ,T1.CLIENT_CD  \n");		/* 매출처구분 :CU005          */
						  		  
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[1].toString()); 
					//StringUtil.printMsg(" arr_sql[1].toString() ",arr_sql[1].toString(),this);	
				  		
			  		// 조건
			  		if (!"".equals(sClient_nm)) {
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// 매출처코드
				  		cstmt.setString(sCnt1++, sClient_nm + "%");		// 매출처명
				  		 
					}
					if (!"".equals(sSal_dam_sid)) { 
						cstmt.setString(sCnt1++, sSal_dam_sid );			// 영업담당자 
					}
					if (!"".equals(sUse_yn)) { 
				  		 cstmt.setString(sCnt1++, sUse_yn);				// 사용여부 
					}
					
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			
				}
				sCnt1 = 1;
			}
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
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}