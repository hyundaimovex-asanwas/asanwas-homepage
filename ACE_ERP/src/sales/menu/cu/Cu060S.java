package sales.menu.cu;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.Connection;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import oracle.jdbc.OracleTypes;

public class Cu060S extends SuperServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


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
				  .append ("	'' head, '' detail, '전체' detail_nm    \n")
				  .append ("FROM DUAL                      \n")
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
		 * 대리점 조회
		 */
		arr_sql[1].append("SELECT 																							\n")
				  .append("		 T2.SAL_DAM_NM																				\n") 	/* 영업담당자       */
				  .append("		,T1.CLIENT_CD																				\n")	/* 협력업체 코드    */
				  .append("		,T1.VEND_CD																					\n")	/* [회계]거래처 코드*/
				  .append("		,T1.CLIENT_NM																				\n")	/* 협력업체명       */
				  .append("		,SALES.FN_DETAIL_NM ('CU012',T1.DIR_YN)      AS DIR_YN_NAME									\n")	/* 직판             */
				  .append("		,T1.CLIENT_DAM_NM																			\n")	/* 매출처담당자     */
				  .append("		,SALES.FN_SECURE_RETURN(T1.TEL_NO,6) AS TEL_NO												\n")	/* 전화번호         */
				  .append("		,SALES.FN_SECURE_RETURN(T3.MANAGE_NO,7) AS MANAGE_NO										\n")	/* 관리번호(주민/여권)*/
				  .append("		,T3.CUST_NM																					\n")	/* 한글성명           */
				  .append("		,T3.EDUC_YN																					\n")	/* 방북교육유무       */
				  .append("		,SALES.FN_DETAIL_NM ( 'CU014',T3.EDUC_YN)   AS EDUC_YN_NAME									\n")	/* 방북교육유무       */
				  .append("		,T4.N_CARD_NO																				\n")	/* 방북증번호         */
				  .append("FROM  SALES.TCU030 T1 LEFT OUTER JOIN SALES.TSY410 T2 ON T1.SAL_DAM_SID  = T2.SAL_DAM_SID		\n")	
				  .append("		,SALES.TCU010 T3 LEFT OUTER JOIN SALES.TCU060 T4 ON T3.CUST_SID      = T4.CUST_SID			\n")	
				  .append("WHERE 1 = 1																						\n")
				  .append("AND T1.CLIENT_GU   = '2'																			\n")	/* 매출처구분 : 2:협력업체) */
				  .append("AND T1.CLIENT_SID  = T3.CLIENT_SID																\n");
		
	}

	 public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		 /* DataSet */
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
		   		if(dSets[i].getName().equals("sCodeDs1")){//고객구분
		    		GauceDataSet ds1 = gis.read("S_USEYN");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
		    		cstmt.setString(1, "SY011");
		    		rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
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
		 /* DataSet */
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
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    
		    int sCnt1 = 1;
			
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//고객구분
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
						arr_sql[1].append("ORDER BY T2.SAL_DAM_NM ,T1.CLIENT_CD,T3.CUST_NM	\n");
		
						cstmt = conn.prepareCall(arr_sql[1].toString());  
				  		
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
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1));
					}
				}
		    gos.close();
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
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
