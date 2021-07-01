package sales.menu.cu;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;

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

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
 
import oracle.jdbc.OracleTypes;

public class Cu100I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_DRIVE;

	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT T1.DRIVE_SID																			\n")
				  .append ("	  ,T1.DRIVE_NO              /* 운전면허번호    */                                         	\n")
				  .append ("      ,T1.LICENSE_DATE          /* 면허일자        */                                         	\n")
				  .append ("      ,T1.RENEWAL_DATE          /* 갱신기간        */                                         	\n")
				  .append ("      ,T1.LICENSE_TYPE          /* 면허종류코드    */                                         	\n")
				  .append ("      ,T1.CUST_SID              /* 고객SID         */                                        \n")
				  .append ("      ,T2.CUST_NM               /* 운전자          */                                         		\n")
				  .append ("      ,SALES.FN_SECURE_RETURN(T2.MANAGE_NO,7) AS MANAGE_NO /* 주민/여권 번호*/     	\n")
				  .append ("      ,T2.MANAGE_NO AS MANAGE_NO_FULL                                        	\n")
				  .append ("      ,T3.CLIENT_CD             /* 협력업체코드    */                                         	\n")
				  .append ("      ,T3.CLIENT_NM             /* 협력업체명      */                                         	\n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'CU007',T1.LICENSE_TYPE) LICENSE_TYPE_NAME                      \n")
				  .append ("FROM                                                                                        \n")
				  .append ("       SALES.TCU040 T1                                                                      \n")
				  .append ("      ,SALES.TCU010 T2 LEFT OUTER JOIN  SALES.TCU030 T3 ON  T2.CLIENT_SID  = T3.CLIENT_SID  \n")
				  .append ("WHERE 1 = 1                                                                                 \n")
				  .append ("  AND T1.CUST_SID = T2.CUST_SID																\n");
		 
		arr_sql[1].append ("INSERT INTO SALES.TCU040										\n")
				  .append ("(DRIVE_SID, DRIVE_NO, LICENSE_DATE, RENEWAL_DATE, LICENSE_TYPE, CUST_SID,  \n")
				  .append (" U_EMPNO, U_DATE, U_IP)                                         \n")
				  .append ("VALUES (SALES.SWS_TCU040_ID.NEXTVAL, ?, ?, ?, ?, ?, ?, SYSDATE, ?)                 \n");
		
		 arr_sql[2].append ("UPDATE  SALES.TCU040		\n")
				   .append ("   SET  DRIVE_NO = ?,		\n") 
				   .append ("		LICENSE_DATE = ?,   \n")
				   .append ("		RENEWAL_DATE = ?,   \n")
				   .append ("		LICENSE_TYPE = ?,   \n")
				   .append ("		CUST_SID = ?,       \n")
				   .append ("		U_EMPNO = ?,        \n")
				   .append ("		U_DATE = SYSDATE,         \n")
				   .append ("		U_IP = ?            \n")
				   .append ("WHERE   DRIVE_NO = ?        \n");
		 arr_sql[3].append("DELETE FROM SALES.TCU040 WHERE DRIVE_NO = ?");
		 
		 arr_sql[4].append ("SELECT DRIVE_SID FROM SALES.TCU040 WHERE DRIVE_NO = ?");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/* DataSet */
		ResultSet rs = null;
		CallableStatement cstmt = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    //StringUtil.printMsg("DS TYPE","선조회",this);
		    for(int i=0; i<dSets.length;i++){
		   		if(dSets[i].getName().equals("ds1")){//고객구분
		    		GauceDataSet ds1 = gis.read("DEFAULT");
		    		//StringUtil.printMsg("DS TYPE","선조회",this);
		    		arr_sql[0].append (" AND T1.LICENSE_DATE = '11111212' ");
		    		cstmt = conn.prepareCall(arr_sql[0].toString());
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
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/

		// 검색시 조건
		String  sClientCd	= HDUtil.nullCheckStr(greq.getParameter("sClientCd")); 	// 매출처
		String	sDriveNo	= HDUtil.nullCheckStr(greq.getParameter("sDriveNo"));		// 고객구분
		String  sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm"));		// 고객명
		
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
						
		 
						if (!"".equals(sClientCd)) 
							arr_sql[0].append (" AND T2.CLIENT_SID = ? ");
						
						if (!"".equals(sDriveNo))
							arr_sql[0].append (" AND T1.DRIVE_NO LIKE ? ");
		
						if (!"".equals(sCustNm)) 
							arr_sql[0].append (" AND T2.CUST_NM LIKE ? ");
						
						//System.out.println("arr_sql[0].toString() : " + arr_sql[0].toString());
						//쿼리 실행
						cstmt = conn.prepareCall(arr_sql[0].toString()); 
		
						if (!"".equals(sClientCd)) {
							cstmt.setString(sCnt1++, sClientCd);
						}			
						
						if (!"".equals(sDriveNo)) {
							cstmt.setString(sCnt1++, "%" +sDriveNo+"%");
						}
						
						if (!"".equals(sCustNm)) {
							cstmt.setString(sCnt1++, sCustNm +"%");
						}
						
						rs = cstmt.executeQuery(); // DataSet set
						gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
												
					}
					gos.close();
			}
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
		//StringUtil.printMsg("# Command","저장",this);
		//StringUtil.printMsg("# Command","저장",this);
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet inputDs = gis.read("REGIST");
		
		try{
			if(inputDs!=null){
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//System.out.println("arr_sql[1].toString() : " + arr_sql[1].toString());
							cstmt = conn.prepareCall(arr_sql[1].toString());

							for(; j<6;){
							//System.out.println(j + " : " + cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] colType() [" + cols[j].getColType() +"]");
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ) 
									cstmt.setInt(j, rows[i].getInt(j++));
								else 
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setString(j++, iParamEmpno);
							cstmt.setString(j++, iParamIp);

							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							//System.out.println("arr_sql[2].toString() : " + arr_sql[2].toString());
							cstmt = conn.prepareCall(arr_sql[2].toString());

							for(; j<6;){
								//System.out.println(j + " : " + cols[j].getColName() + " value [" + rows[i].getString(j).trim() + "] colType() [" + cols[j].getColType() +"]");
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER )
									cstmt.setInt(j, rows[i].getInt(j++));
								else
									cstmt.setString(j, rows[i].getString(j++).trim());
							}
							
							cstmt.setString(j++, iParamEmpno);
							cstmt.setString(j++, iParamIp);
							cstmt.setString(j++, rows[i].getString(1).trim());

							cstmt.executeUpdate();
							if(cstmt!=null) cstmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall(arr_sql[3].toString());
							cstmt.setString(1, rows[i].getString(1).trim());
							cstmt.executeUpdate();
							break;
					}
					if(cstmt!=null) cstmt.close();
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}