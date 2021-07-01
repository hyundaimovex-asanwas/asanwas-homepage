package sales.menu.cu;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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
 
import oracle.jdbc.OracleTypes;
 
public class Cu010I2 extends SuperServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 사진 이미지 저장 
	 * 환경에 맞추어 경로 변경 요함
	 */ 
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
   
		arr_sql[0].append ("SELECT										\n")
				  .append ("	'' HEAD, '' DETAIL, '전체' DETAIL_NM    \n")
				  .append ("FROM DUAL                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.DETAIL)) > 0                  \n");
		
		arr_sql[1].append ("SELECT                                      \n")
				  .append ("	B.HEAD, B.DETAIL||'' DETAIL, B.DETAIL_NM           \n")
				  .append ("FROM                                        \n")
				  .append ("	SALES.TSY011 A,                         \n")
				  .append ("	SALES.TSY010 B                          \n")
				  .append ("WHERE 1=1                                   \n")
				  .append (" AND A.HEAD = B.HEAD                        \n")
				  .append (" AND B.HEAD = ?                             \n")
				  .append (" AND LENGTH (rtrim(B.DETAIL)) > 0                  \n");
		
		arr_sql[2].append ("SELECT 																										\n")
				  .append ("    T1.CUST_SID    ,T1.MANAGE_NO    ,T1.REGI_NO					\n")//3
				  .append ("   ,T1.CUST_NM     ,T1.BIRTHDAY     ,T1.SEX 		    		\n")//6
				  .append ("   ,T1.MOBILE_NO   ,T1.PASS_NO      ,T1.PASS_EXPIRE_DATE		\n")//9
				  .append ("   ,T1.PASS_TYPE   ,T1.REGI_YN_T	,T1.CUST_GU					\n")//12
				  .append ("   ,T1.CLIENT_SID  ,T1.COUNTRY_GU   ,T1.GROUP_CD				\n")//15
				  .append ("   ,T2.CLIENT_NM 	         				          			\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU008',T1.PASS_TYPE)  AS PASS_TYPE_NAME                       \n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU002',T1.REGI_YN)    AS REGI_YN_NAME     /* 인증여부 */    	\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU001',T1.CUST_GU)    AS CUST_GU_NAME     /* 고객구분 */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'CU009',T1.COUNTRY_GU) AS COUNTRY_GU_NAME  /* 국적구분  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'SY009',T1.SEX)    	AS SEX_GU_NAME      /* 성별구분  */   		\n")
				  .append ("   ,SALES.FN_DETAIL_NM ( 'SY005',T1.COUNTRY_CD)  AS COUNTRY_NM                       \n")
				  .append ("   ,SALES.FN_CUST_CLOSE_YN (T1.CUST_SID,'" + fParamEmpno + "') AS CLOSE_YN	\n")	//연계예약일 경우에는 방북마감 기준..~
				  .append ("FROM                                                                                    \n")
				  .append ("   SALES.TCU010 T1 LEFT OUTER JOIN SALES.TCU030 T2 ON ( T1.CLIENT_SID  = T2.CLIENT_SID)  \n")
				  .append ("WHERE 1 = 1                                                                             \n");




		arr_sql[3].append ("SELECT T1.CLIENT_SID||'' CLIENT_SID    /* 매출처SID */  \n")
				  .append ("     ,T1.CLIENT_CD      /* 매출처 코드*/  \n")
				  .append ("     ,T1.CLIENT_NM      /* 매출처 명   */  \n")
				  .append ("FROM SALES.TCU030 T1                   \n");
		arr_sql[4].append ("SELECT										\n")
				  .append ("	'' CLIENT_SID, '' CLIENT_CD, '전체' CLIENT_NM    \n")
				  .append ("FROM DUAL                       \n")
				  .append ("UNION ALL                                   \n")
				  .append ("SELECT T1.CLIENT_SID||'' CLIENT_SID    /* 매출처SID */  \n")
				  .append ("     ,T1.CLIENT_CD      /* 매출처 코드*/  \n")
				  .append ("     ,T1.CLIENT_NM      /* 매출처 명   */  \n")
				  .append ("FROM SALES.TCU030 T1                   \n");
		
		//고객정보 등록 PLZ용 
		arr_sql[5].append ("INSERT INTO SALES.TCU010 (								\n")
				  .append ("CUST_SID									     		,\n")
				  .append (" MANAGE_NO    		,REGI_NO  							\n")//2
				  .append (",CUST_NM     		,BIRTHDAY       ,SEX 		   		\n")//5
				  .append (",MOBILE_NO        	,PASS_NO        ,PASS_EXPIRE_DATE 	\n")//8
				  .append (",PASS_TYPE		  	,REGI_YN_T      ,CUST_GU          	\n")//11
				  .append (",CLIENT_SID			,COUNTRY_GU		,GROUP_CD			\n")//14
				  .append (",U_EMPNO     		,U_DATE         ,U_IP				\n")
				  .append ("     ) VALUES (											\n")
				  .append ("SALES.SWS_TCU010_ID.NEXTVAL					, 			 \n")
				  .append ("	?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?, 		 			\n")
				  .append ("	?, CURRENT_TIMESTAMP, ? 		)					\n");

		//고객정보 변경
		arr_sql[6].append ("UPDATE SALES.TCU010 SET					\n")
				  .append ("			MANAGE_NO    		= ?,	\n")
				  .append ("			REGI_NO          	= ?,	\n")
				  .append ("			CUST_NM     		= ?,	\n")
				  .append ("			BIRTHDAY          	= ?,	\n")
				  .append ("			SEX 		   		= ?,	\n")
				  .append ("			MOBILE_NO        	= ?,	\n")
				  .append ("			PASS_NO          	= ?,	\n")
				  .append ("			PASS_EXPIRE_DATE 	= ?,	\n")
				  .append ("			PASS_TYPE        	= ?,	\n")
				  .append ("			REGI_YN_T		    = ?,	\n")
				  .append ("			CUST_GU          	= ?,	\n")
				  .append ("			CLIENT_SID       	= ?,	\n")				  
				  .append ("			COUNTRY_GU       	= ?,	\n")
				  .append ("			GROUP_CD         	= ?, 	\n")
				  
				  .append ("			U_EMPNO     		= ?,	\n")
				  .append ("			U_DATE           	= CURRENT_TIMESTAMP,	\n")
				  .append ("			U_IP             	= ?		\n")
				  .append ("WHERE CUST_SID = ?						\n");			
				  
		//고객정보 삭제
		arr_sql[7].append ("DELETE FROM SALES.TCU010 WHERE CUST_SID = ?	\n");

		//고객정보 등록 후 CUST_SID GET 
		arr_sql[8].append ("SELECT MANAGE_NO FROM SALES.TCU010 WHERE MANAGE_NO = ?");
		
		//고객정보 등록 후 CUST_SID GET 
		arr_sql[9].append ("SELECT CUST_SID FROM SALES.TCU010 WHERE MANAGE_NO = ?");
		
	}
	// 초기
    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/* DataSet */
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		CallableStatement cstmt = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		//StringUtil.printMsg("DS TYPE","선조회",this);
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 

		    for(int i=0; i<dSets.length;i++){
		    	if(dSets[i].getName().equals("searchds1")){//고객구분
		    		GauceDataSet ds1 = gis.read("CUSTALL");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU001");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("searchds2")){//국적구분
					GauceDataSet ds1 = gis.read("NATIONALL");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, "CU009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds4")){//고객구분
					GauceDataSet ds1 = gis.read("CUST");
		    		cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU001");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds1")){//국적구분
					GauceDataSet ds1 = gis.read("NATION");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds2")){//인증여부
					GauceDataSet ds1 = gis.read("AUTH");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU002");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds3")){//성별
					GauceDataSet ds1 = gis.read("SEX");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "SY009");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds5")){//성별
					GauceDataSet ds1 = gis.read("TRAD");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU003");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds8")){//사업구분
					GauceDataSet ds1 = gis.read("SAUP");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU004");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds6")){//여권종류
					GauceDataSet ds1 = gis.read("PASS");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU008");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("BUY_TYPEALL")){
					GauceDataSet ds1 = gis.read("BUY_TYPEALL");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("BUY_TYPEALL")){
					GauceDataSet ds1 = gis.read("BUY_TYPE");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds9")){
					GauceDataSet ds1 = gis.read("CUST_TYPE");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "RV003");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("ds1")){//기본조회
					GauceDataSet ds1 = gis.read("DEFAULT");
					arr_sql[2].append (" AND T1.MANAGE_NO = '999999999999' ");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds10")){//기본조회
					GauceDataSet ds1 = gis.read("CU019");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU019");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("initds11")){
					GauceDataSet ds1 = gis.read("CU020");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, "CU020");
					rs = cstmt.executeQuery(); 
		   			gos.write(getDataSet(rs, ds1));// DataSet set
		   			rsmd = rs.getMetaData();
					columnName = new String[rsmd.getColumnCount()];
				} else if(dSets[i].getName().equals("imgDs")){	
					GauceDataSet ds1 = gis.read("IMAGE");
					ds1.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
					ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
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

	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		int v_rowcnt = 0;

		// 검색시 조건
		//String  sClientNm	= HDUtil.nullCheckStr(greq.getParameter("sClientSid")); 	// 매출처
		int  	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 	// 매출처
		String	sCustGu		= HDUtil.nullCheckStr(greq.getParameter("sCustGu"));		// 고객구분
		String  sCountryGu	= HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));	// 국적구분
		String  sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		// 고객명
		String  sManegeNo	= HDUtil.nullCheckStr(greq.getParameter("sManegeNo"));		// 관리번호
		//int  	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid")); 	// 매출처
		String 	sAcceptNo	= HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));
		// dataset 구분 param
				int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
				
				try{
					GauceInputStream gis = greq.getGauceInputStream();
					GauceOutputStream gos = gres.getGauceOutputStream();
					//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
					GauceDataSet[] dSets = gis.readAllOutput(); 
					
					for(int i=0; i<dSets.length;i++){
						//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
						//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
						
						if(dSets[i].getName().equals("ds1")){// || dSets[i].getName().equals("imgDs")){
							/*
							StringUtil.printMsg(" sClientSid ",sClientSid,this);
							StringUtil.printMsg(" sCustGu ",sCustGu,this);
							StringUtil.printMsg(" sCountryGu ",sCountryGu,this);
							StringUtil.printMsg(" sCustNm ",sCustNm,this);
							StringUtil.printMsg(" sManegeNo ",sManegeNo,this);
							StringUtil.printMsg(" sAcceptNo ",sAcceptNo,this);
							*/
							int sCnt1 = 1;
							GauceDataSet ds1 = gis.read("DEFAULT");
							GauceDataSet imgDs = gis.read("IMAGE");
							if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
								//StringUtil.printMsg(" IF::::::::::::: ","IF",this);
								if (!"".equals(sManegeNo)) {
									arr_sql[2].append (" AND T1.MANAGE_NO = ? ");
								}
								if (!"".equals(sCustNm)) {
									arr_sql[2].append (" AND T1.CUST_NM = ? ");
								}
								//System.out.println("주민번호 성명 들어올경우");
							} else {
								//StringUtil.printMsg(" ELSE::::::::::::: ","ELSE",this);
								//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);
								if (sClientSid>0) 
									arr_sql[2].append (" AND T1.CLIENT_SID = ? ");
								if (!"".equals(sCustGu))
									arr_sql[2].append (" AND T1.CUST_GU = ? ");
								if (!"".equals(sCountryGu)) 
									arr_sql[2].append (" AND T1.COUNTRY_GU = ? ");
								if (!"".equals(sCustNm)) 
									arr_sql[2].append (" AND T1.CUST_NM = ? ");
								if (!"".equals(sManegeNo)) 
									arr_sql[2].append (" AND T1.MANAGE_NO = ? ");
								if (!"".equals(sAcceptNo)) {
									arr_sql[2].append(" AND T1.GROUP_CD = ? ");
								}
							}
						 
							arr_sql[2].append(" AND ROWNUM <= 2000");
						
						//쿼리 실행
						
						//StringUtil.printMsg("고객조회 ------->" + arr_sql[2].toString(), this);//여기까지 정상
						cstmt = conn.prepareCall(arr_sql[2].toString()); 
						if (!"".equals(sCustNm) && !"".equals(sManegeNo)) {
							if (!"".equals(sManegeNo)) {
								cstmt.setString(sCnt1++, sManegeNo );
							}
							if (!"".equals(sCustNm)) {
								cstmt.setString(sCnt1++, sCustNm );
							}
						} else {
							if (sClientSid>0) {
								cstmt.setInt(sCnt1++, sClientSid);
							}					
							if (!"".equals(sCustGu)) {
								cstmt.setString(sCnt1++, sCustGu);
							}
							if (!"".equals(sCountryGu)) {
								cstmt.setString(sCnt1++, sCountryGu);
							}
							if (!"".equals(sCustNm)) {
								cstmt.setString(sCnt1++, sCustNm);
							}
							if (!"".equals(sManegeNo)) {
								cstmt.setString(sCnt1++, sManegeNo );
							}
							if (!"".equals(sAcceptNo)) {
								cstmt.setString(sCnt1++, sAcceptNo);
							}
						}	
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
						//gos.write(getDataSet(rs, imgDs)); // DataSet set & 전송
						}
					
						if(dSets[i].getName().equals("searchds4")){
							GauceDataSet ds1 = gis.read("SEARCH_DS4");
								//쿼리 실행
							//StringUtil.printMsg("sClientSid ------->" , sClientSid, this);
							//StringUtil.printMsg("fParamEmpno ------->" ,fParamEmpno, this);
							//StringUtil.printMsg("fParamIp ------->" ,fParamIp, this);
							cstmt = conn.prepareCall("SELECT SALES.FN_ACCEPT_NO(" + sClientSid + ",'" + fParamEmpno + "','" + fParamIp + "') AS ACCEPT_NO FROM DUAL");
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
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// 입력, 수정, 삭제
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet inputDs = gis.read("REGIST");
		GauceDataSet resultDs = gis.read("RESULT");
		
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;	//cust_sid 다음 컬럼부터:)
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							
							cstmt = conn.prepareCall(arr_sql[8].toString());
							cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
							rs = cstmt.executeQuery();
							if(rs.next())
								throw new Exception("이미 중복된 자료가 있습니다.");
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
								
							cstmt = conn.prepareCall(arr_sql[5].toString());
								
								for(; j<15;){
									if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
										cstmt.setInt(j, rows[i].getInt(j++));
									else
										cstmt.setString(j, rows[i].getString(j++).trim());
								}
								
								cstmt.setString(j++, iParamEmpno);
								//StringUtil.printMsg("iParamEmpno:::::",iParamEmpno, this);
								cstmt.setString(j++, iParamIp);
								//StringUtil.printMsg("iParamIp:::::", iParamIp, this);
								cstmt.executeUpdate();
								if(cstmt!=null) cstmt.close();
								/*
								cstmt = conn.prepareCall(arr_sql[9].toString());
								cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("MANAGE_NO")));
								rs = cstmt.executeQuery();
								if(rs.next()){
									if(resultDs!=null) {
										GauceDataRow resultRow = resultDs.newDataRow();
										resultRow.addColumnValue(rs.getInt("CUST_SID"));
										resultDs.addDataRow(resultRow);
									}
								}
								*/
								
								if(rs!=null) rs.close();
								if(cstmt!=null) cstmt.close();
								
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall(arr_sql[6].toString());

							for(; j<15;){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setString(j++, iParamEmpno);	//40
							cstmt.setString(j++, iParamIp);		//41
							//cstmt.setString(j++, rows[i].getString(0).trim());
							cstmt.setString(j++, rows[i].getString(inputDs.indexOfColumn("CUST_SID")));//42

							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							//StringUtil.printMsg("End CUST_SID", rows[i].getString(inputDs.indexOfColumn("CUST_SID")), this);
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[7].toString());
							cstmt.setString(1, rows[i].getString(inputDs.indexOfColumn("CUST_SID"))); // 관리번호로 삭제 
							cstmt.executeUpdate();
							break;
					}
					if(cstmt!=null) cstmt.close();
				}
				
				if(resultDs!=null) resultDs.flush();
				
				/*20131211주석
				for(int i=0; i<imgRow.length; i++){
					switch(imgRow[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//고객 사진 정보 등록
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							
							if(!imgRow[i].getString(1).trim().equals("") && d_name!=null && !d_name.equals("")){
								String o_name = imgRow[i].getString(0).trim() + ".JPG";
								
								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}

							break;
					}
				}
				*/
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			//writeException(java.lang.String type, java.lang.String code, java.lang.String e);
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}