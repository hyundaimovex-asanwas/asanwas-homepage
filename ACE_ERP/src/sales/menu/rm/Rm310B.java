package sales.menu.rm;

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
 
public class Rm310B extends SuperServlet {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
			for(int i=0; i<arr_sql.length; i++)
				arr_sql[i] = new StringBuffer();
	 }
	
	 public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//System.out.println("# Command : 선조회");
		ResultSet rs = null;
		CallableStatement cstmt = null;
		//GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds2 = null;
		GauceDataSet ds3 = null;

		String query = "";			// SELECT절  변수
		String whereQuery =  "";	// WHERE절  변수
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
		    
			// DataSet 생성
			ds2 = new GauceDataSet();
			ds3 = new GauceDataSet();

			/**********************************************************************************
			 * Command
			 **********************************************************************************
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다
			 **********************************************************************************/

			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));		// 사업소코드

			switch(dsType) {
				case 1 :
					// 프로젝트명을 얻어옴
					query   += ""
							+ "\n\t" + "SELECT "
							+ "\n\t" + "	saup_sid, "
							+ "\n\t" + "	saup_nm "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 "
							+ "\n\t" + "ORDER BY saup_sid ";

					query += whereQuery;

					 /**********************************************************************************
					 * DataSet 초기화
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다
					 **********************************************************************************/
					ds2.addDataColumn(new GauceDataColumn("saup_sid", GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("saup_nm", GauceDataColumn.TB_STRING, 20));

					//쿼리 실행
					cstmt = conn.prepareCall(query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds2));// DataSet set
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
					break;

				case 2 :
					int sCnt2 = 1;
					// 프로젝트명을 얻어옴
					query   += ""
							+ "\n\t" + "SELECT "
							+ "\n\t" + "	upjang_sid, "
							+ "\n\t" + "	upjang_nm "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 "
							+ "\n\t" + "WHERE upjang_type='10' AND use_yn = 'Y' ";

					if (!"".equals(sSaupSid)) {
						whereQuery += ""
								   + "\n\t" + " AND saup_sid =? ";
						}
					query += whereQuery;
					query += "\n\t" + " ORDER BY  upjang_sid ";


					 /**********************************************************************************
					 * DataSet 초기화
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다
					 **********************************************************************************/
					//ds3.addDataColumn(new GauceDataColumn("upjang_sid", GauceDataColumn.TB_STRING, 10));
					//ds3.addDataColumn(new GauceDataColumn("upjang_nm", GauceDataColumn.TB_STRING, 30));

//					 쿼리 실행
					cstmt = conn.prepareCall(query);
					
					if (!"".equals(sSaupSid)) {
						cstmt.setString(sCnt2++, sSaupSid);
					}
					//System.out.println("# Query : " + query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds3));// DataSet set
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds3.getDataRowCnt());
					break;
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	// 조회 method
	 public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//System.out.println("# Command : 조회");
		/* DataSet */
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
	
		/* DataSet */
		GauceDataSet ds1 = null;

		String query = "";
		String whereQuery =  "";
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// DataSet 생성
			ds1 = new GauceDataSet(); // Dataset TSY410

			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));		// 사업소
			String sUpjangSid	 = HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));		// 영업장
			//System.out.println("#  sSaupSid : " + sSaupSid);
			//System.out.println("#  sUpjangSid : " + sUpjangSid);
			//dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			//System.out.println("# DsType : " + dsType);
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;

 					query   += ""
						+ "\n\t" + "SELECT "
						+ "\n\t" + sSaupSid + "   saup_sid, "
						+ "\n\t" + "  R1.upjang_sid, "
						+ "\n\t" + "  R1.upjang_nm, "
						+ "\n\t" + "  'F' AS USE_YN, "
						+ "\n\t" + "  TO_CHAR(SALES.FN_DATE(MAX(use_date))+1,'YYYYMMDD') AS BGN_DATE, "
						+ "\n\t" + "  TO_CHAR(SALES.FN_DATE(MAX(use_date))+365,'YYYYMMDD') AS END_DATE  "
						+ "\n\t" + "FROM SALES.TRM010 R1 LEFT OUTER JOIN    "
						+ "\n\t" + "   SALES.TRM050 R2  "
						+ "\n\t" + "	ON R2.upjang_sid   =  R1.upjang_sid "
						+ "\n\t" + "WHERE R1.use_yn='Y' AND R2.use_date is not null"
						+ "\n\t" + "AND R1.upjang_type  =  '10' ";

					if (!"0".equals(sSaupSid)) {
					whereQuery += ""
							   + "\n\t" + " AND R1.saup_sid =  " + sSaupSid;
					}

					if (!"0".equals(sUpjangSid)) {
						whereQuery += ""
								   + "\n\t" + " AND R1.upjang_sid =  " + sUpjangSid;
						}

					query += whereQuery;
					query += 	   "\n\t" + "GROUP BY R1.upjang_sid, R1.upjang_nm "
									+ "\n\t" + "ORDER BY R1.upjang_sid";

					//쿼리 실행
					//System.out.println("# Query : " + query);
					cstmt = conn.prepareCall(query);
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1)); // DataSet set & 전송
					//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
					break;
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

	// 마스터 입력, 수정, 삭제
	 public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		 
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
					
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
							
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
	
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";

		try {
			GauceDataSet codeDs = gis.read("INPUT_DATA");
			GauceDataRow[] 		rows = codeDs.getDataRows();
			GauceDataColumn[] 	cols = codeDs.getDataColumns();
			
			String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));		// 사업소
			String sUpjangSid = HDUtil.nullCheckStr(greq.getParameter("sUpjangSid"));		// 영업장
			int colNm_UpjangSid 	= codeDs.indexOfColumn("upjang_sid");
			int colNm_BgnDate 	= codeDs.indexOfColumn("bgn_date");
			int colNm_EndDate 	= codeDs.indexOfColumn("end_date");

			deleteQuery += "\n"
						+ "\n\t" + "DELETE FROM SALES.TRM050 "
						+ "\n\t" + "WHERE saup_sid    =  ? "
						+ "\n\t" + "AND upjang_sid  =  ? "
						+ "\n\t" + "AND use_date   >=  ? "
						+ "\n\t" + "AND use_date   <=  ? "
						+ "\n";

			insertQuery += "\n"
						+ "\n\t" + "INSERT INTO SALES.TRM050 "
						+ "\n\t" + "("
						+ "\n\t" + "		use_date, "
						+ "\n\t" + "		room_type_sid, "
						+ "\n\t" + "		room_cnt, "
						+ "\n\t" + "		saup_sid, "
						+ "\n\t" + "		upjang_sid, "
						+ "\n\t" + "		u_empno,  "
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip ) "
						+ "\n\t" + "SELECT "
						+ "\n\t" + "	S1.caln_date, "
						+ "\n\t" + "	R1.room_type_sid, "
						+ "\n\t" + "	R1.room_cnt, "
						+ "\n\t" + sSaupSid + "  AS SAUP_SID, "
						+ "\n\t" + "	R1.upjang_sid, "
						+ "\n\t" + "	'1'                AS U_EMPNO, "
						+ "\n\t" + "	CURRENT_TIMESTAMP  AS U_DATE, "
						+ "\n\t" + "	'1'                AS U_IP "
						+ "\n\t" + "	 FROM  SALES.TSY100 S1, "
						+ "\n\t" + "	 ( "
						+ "\n\t" + "	SELECT upjang_sid, "
						+ "\n\t" + "	room_type_sid, "
						+ "\n\t" + "	COUNT(room_type_sid) AS ROOM_CNT "
						+ "\n\t" + "	 FROM SALES.TRM040 "
						+ "\n\t" + "	WHERE use_yn      =  'Y' "
						+ "\n\t" + "	AND upjang_sid  =  ? "
						+ "\n\t" + "	GROUP BY upjang_sid, room_type_sid "
						+ "\n\t" + "	) R1 "
						+ "\n\t" + "	WHERE S1.caln_date  >=  ? "
						+ "\n\t" + "	AND S1.caln_date  <=  ? ";

			for(int i = 0; i < rows.length; i++) {
				if ( rows[i].getString(3).equals("T") ) {		// 생성 체크시
					// 삭제
					int dCnt = 1;
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//StringUtil.printMsg("if","if",this);
						//System.out.println("# Command : 삭제");
						//System.out.println("# Query : " + deleteQuery);
						//StringUtil.printMsg("sSaupSid",sSaupSid,this);
						//StringUtil.printMsg("colNm_UpjangSid",rows[i].getString(colNm_UpjangSid),this);
						//StringUtil.printMsg("colNm_BgnDate",rows[i].getString(colNm_BgnDate),this);
						//StringUtil.printMsg("colNm_EndDate",rows[i].getString(colNm_EndDate),this);
						cstmt = conn.prepareCall(deleteQuery);
						//StringUtil.printMsg("cstmt = conn.prepareCall(deleteQuery);","cstmt = conn.prepareCall(deleteQuery);",this);
						
						cstmt.setString(dCnt++,  sSaupSid);
						//StringUtil.printMsg("sSaupSid","sSaupSid",this);
						cstmt.setString(2, rows[i].getString(colNm_UpjangSid));
						//StringUtil.printMsg("colNm_UpjangSid","colNm_UpjangSid",this);
						cstmt.setString(3, rows[i].getString(colNm_BgnDate));
						//StringUtil.printMsg("colNm_BgnDate","colNm_BgnDate",this);
						cstmt.setString(4, rows[i].getString(colNm_EndDate));
						//StringUtil.printMsg("colNm_EndDate","colNm_EndDate",this);
						//cstmt.bindColumn(dCnt++, colNm_UpjangSid);
						//cstmt.bindColumn(dCnt++, colNm_BgnDate);
						//cstmt.bindColumn(dCnt++, colNm_EndDate);

						cstmt.executeUpdate();
						//StringUtil.printMsg("cstmt.executeUpdate();","cstmt.executeUpdate();",this);
						if(cstmt!=null) cstmt.close();	
					}
					// 입력
					int iCnt = 1;
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//System.out.println("# Command : 저장");
						//System.out.println("# Query : " + insertQuery);
						//StringUtil.printMsg("colNm_UpjangSid",rows[i].getString(colNm_UpjangSid),this);
						//StringUtil.printMsg("colNm_BgnDate",rows[i].getString(colNm_BgnDate),this);
						//StringUtil.printMsg("colNm_EndDate",rows[i].getString(colNm_EndDate),this);
						cstmt = conn.prepareCall(insertQuery);
						cstmt.setString(1, rows[i].getString(colNm_UpjangSid));	
						cstmt.setString(2, rows[i].getString(colNm_BgnDate));
						cstmt.setString(3, rows[i].getString(colNm_EndDate));
						/*
						stmt.bindColumn(iCnt++, colNm_UpjangSid);
						stmt.bindColumn(iCnt++, colNm_BgnDate);
						stmt.bindColumn(iCnt++, colNm_EndDate);
						 */
						cstmt.executeUpdate();
						if(cstmt!=null) cstmt.close();	
					}
				}
			}	//if (ds1 != null) {
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