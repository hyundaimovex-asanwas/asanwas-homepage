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



public class Rm410I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	}
	
	/*****************************************************************************
	 * Gauce Object 설정
	 * Select 에 들어갈 Project Name , Project Id를 조회한다
	 * 페이지 로딩시에 초기화 작업이다 
	 *****************************************************************************/
	 public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("# Command","선조회",this);
		ResultSet rs = null;
		CallableStatement cstmt = null;
		/* DataSet */
		GauceDataSet ds2 = null;
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
		    //Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		    GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// DataSet 생성 			
			ds2 = new GauceDataSet(); 
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));		// 사업소코드
			String sHead = HDUtil.nullCheckStr(greq.getParameter("sHead"));		// Head			
			String sDetail = HDUtil.nullCheckStr(greq.getParameter("sDetail"));		// Detail	
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;					
					
					query   += "" 		
						+ "\n\t" + "SELECT 0 saup_sid, '' saup_nm FROM DUAL 	"
						+ "\n\t" + "UNION ALL	"
						+ "\n\t" + "SELECT " 									
						+ "\n\t" + "	saup_sid, " 
						+ "\n\t" + "	saup_nm " 
						+ "\n\t" + "FROM "
						+ "\n\t" + "	SALES.TSY200 "; 
				
				// 쿼리 실행
				cstmt = conn.prepareCall(query);
				
				if (!"".equals(sDetail)) {	
					cstmt.setString(sCnt1++, sDetail);
				}	
				rs = cstmt.executeQuery(); 
				gos.write(getDataSet(rs, ds2));// DataSet set
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
			// 검색시 조건
			String sGoodsSid = HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));				// 사업소
			String sGoodsCd	 = HDUtil.nullCheckStr(greq.getParameter("sGoodsCd"));				// 영업장
			String sGoodsNm	 = HDUtil.nullCheckStr(greq.getParameter("sGoodsNm"));				// 관리일자
			String sUseYn	 = HDUtil.nullCheckStr(greq.getParameter("sUseYn"));					// 사용유무
			String sSaupSid	 = HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));					// 사용유무
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					
 					query   += ""  					
 						+ "\n\t" + "SELECT "
 						+ "\n\t" + "			goods_sid, " 
 						+ "\n\t" + "			goods_cd, "
 						+ "\n\t" + "			goods_nm, "
 						+ "\n\t" + "			eng_nm, "
 						+ "\n\t" + "			short_nm, " 						
 						+ "\n\t" + "			course, "     
 						+ "\n\t" + "			nights, "
 						+ "\n\t" + "			days, "
 						+ "\n\t" + "			saup_sid, " 						
 						+ "\n\t" + "			theme_cd, "
 						+ "\n\t" + "			display_seq, "
 						+ "\n\t" + "			(CASE WHEN use_yn = 'Y' THEN 'T' ELSE 'F' END) AS use_yn "
 						+ "\n\t" + "FROM SALES.TRM200 A "
 						+ "\n\t" + "WHERE 1=1";
								
					if (!"".equals(sGoodsSid)) {
						whereQuery += ""
							   + "\n\t" + " AND goods_sid = '" + sGoodsSid + "'";
					}
					if (!"".equals(sSaupSid)) {
										whereQuery += ""
											   + "\n\t" + " AND saup_sid = '" + sSaupSid + "'";
									}
					
					if (!"".equals(sUseYn)) {
						whereQuery += ""
							   + "\n\t" + " AND use_yn = '" + sUseYn + "'";
					}
 					
					query += whereQuery
									+ "\n\t" + "ORDER BY goods_cd "; 

					//StringUtil.printMsg("query",query,this);
					//쿼리 실행
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
		 
		//StringUtil.printMsg("apply","apply",this);
		//System.out.println("aaaaaa:");
		 
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
			/*
			 * Request Parameter
			 */
			int colNm_GoodsSid 	= codeDs.indexOfColumn("goods_sid");	
			int colNm_GoodsCd 	= codeDs.indexOfColumn("goods_cd");	
			int colNm_GoodsNm 	= codeDs.indexOfColumn("goods_nm");
			int colNm_EngNm 	= codeDs.indexOfColumn("eng_nm");
			int colNm_ShortNm 	= codeDs.indexOfColumn("short_nm");			
			int colNm_Course 	= codeDs.indexOfColumn("course");
			int colNm_Nights 	= codeDs.indexOfColumn("nights");
			int colNm_Days 		= codeDs.indexOfColumn("days");
			int colNm_SaupSid 	= codeDs.indexOfColumn("saup_sid");			
			int colNm_ThemeCd 	= codeDs.indexOfColumn("theme_cd");
			int colNm_DisplaySeq = codeDs.indexOfColumn("display_seq");
			int colNm_UseYn 	 = codeDs.indexOfColumn("use_yn");
			int colNm_UEmpno 	 = codeDs.indexOfColumn("u_empno");
			int colNm_UIp 		 = codeDs.indexOfColumn("u_ip");			
			
			insertQuery += "\n" 		
				+ "\n\t" + "INSERT INTO SALES.TRM200 "
				+ "\n\t" + "	("
				+ "\n\t" + "		goods_sid, "
				+ "\n\t" + "		goods_cd, " 
				+ "\n\t" + "		goods_nm, "
				+ "\n\t" + "		eng_nm,  "
				+ "\n\t" + "		short_nm,  "				
				+ "\n\t" + "		course,  "
				+ "\n\t" + "		nights,  "
				+ "\n\t" + "		days,  "
				+ "\n\t" + "		saup_sid,  "
				+ "\n\t" + "		theme_cd,  "
				+ "\n\t" + "		display_seq,  "
				+ "\n\t" + "		use_yn, "
				+ "\n\t" + "		u_empno, "
				+ "\n\t" + "		u_ip "				
				+ "\n\t" + "	)"
				+ "\n\t" + "VALUES ("
				+ "\n\t" + "    	SALES.SWS_TRM200_ID.NEXTVAL,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? "
				+ "\n\t" + "       )"
				+ "\n";

			updateQuery += "\n" 		
				+ "\n\t" + "UPDATE SALES.TRM200"
				+ "\n\t" + "	SET"
				+ "\n\t" + "		goods_cd = ?, "
				+ "\n\t" + "		goods_nm = ?, "
				+ "\n\t" + "		eng_nm = ?, "
				+ "\n\t" + "		short_nm = ?, "				
				+ "\n\t" + "		course = ?, "
				+ "\n\t" + "		nights = ?, "
				+ "\n\t" + "		days = ?, "
				+ "\n\t" + "		saup_sid = ?, "	
				+ "\n\t" + "		theme_cd = ?, "				
				+ "\n\t" + "		display_seq = ?, "
				+ "\n\t" + "		use_yn = ?, "
				+ "\n\t" + "		u_empno = ?, "
				+ "\n\t" + "		u_date = sysdate, "
				+ "\n\t" + "		u_ip = ? "				
				+ "\n\t" + "WHERE 1=1 "
				+ "\n\t" + "	AND goods_sid=?";
			
			deleteQuery += "\n" 		
				+ "\n\t" + "DELETE FROM SALES.TRM200 "
				+ "\n\t" + "WHERE goods_sid    =  ? "
				+ "\n";			
			
			for(int i = 0; i < rows.length; i++) {
				// 입력
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					//StringUtil.printMsg("# Command","삽입",this);
					//StringUtil.printMsg("# Query",insertQuery,this);	
					cstmt = conn.prepareCall(insertQuery);
					
					cstmt.setString(1, rows[i].getString(colNm_GoodsCd));
					cstmt.setString(2, rows[i].getString(colNm_GoodsNm));
					cstmt.setString(3, rows[i].getString(colNm_EngNm));
					cstmt.setString(4, rows[i].getString(colNm_ShortNm));
					cstmt.setString(5, rows[i].getString(colNm_Course));
					cstmt.setString(6, rows[i].getString(colNm_Nights));
					cstmt.setString(7, rows[i].getString(colNm_Days));
					cstmt.setString(8, rows[i].getString(colNm_SaupSid));
					cstmt.setString(9, rows[i].getString(colNm_ThemeCd));
					cstmt.setString(10, rows[i].getString(colNm_DisplaySeq));
					/*
					StringUtil.printMsg("colNm_GoodsCd",rows[i].getString(colNm_GoodsCd),this);
					StringUtil.printMsg("colNm_GoodsNm",rows[i].getString(colNm_GoodsNm),this);
					StringUtil.printMsg("colNm_EngNm",rows[i].getString(colNm_EngNm),this);
					StringUtil.printMsg("colNm_ShortNm",rows[i].getString(colNm_ShortNm),this);
					StringUtil.printMsg("colNm_Course",rows[i].getString(colNm_Course),this);
					StringUtil.printMsg("colNm_Nights",rows[i].getString(colNm_Nights),this);
					StringUtil.printMsg("colNm_Days",rows[i].getString(colNm_Days),this);
					StringUtil.printMsg("colNm_SaupSid",rows[i].getString(colNm_SaupSid),this);
					StringUtil.printMsg("colNm_ThemeCd",rows[i].getString(colNm_ThemeCd),this);
					StringUtil.printMsg("colNm_DisplaySeq",rows[i].getString(colNm_DisplaySeq),this);
					StringUtil.printMsg("colNm_UseYn",rows[i].getString(colNm_UseYn),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					StringUtil.printMsg("iParamEmpno",iParamIp,this);
					*/
					/*
					stmt.bindColumn(iCnt++, colNm_GoodsCd);
					stmt.bindColumn(iCnt++, colNm_GoodsNm);
					stmt.bindColumn(iCnt++, colNm_EngNm);
					stmt.bindColumn(iCnt++, colNm_ShortNm);					
					stmt.bindColumn(iCnt++, colNm_Course);
					stmt.bindColumn(iCnt++, colNm_Nights);
					stmt.bindColumn(iCnt++, colNm_Days);
					stmt.bindColumn(iCnt++, colNm_SaupSid);
					stmt.bindColumn(iCnt++, colNm_ThemeCd);
					stmt.bindColumn(iCnt++, colNm_DisplaySeq);
					*/
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						cstmt.setString(11, "Y");
					else
						cstmt.setString(11, "N");				
					cstmt.setString(12, iParamEmpno);
					cstmt.setString(13, iParamIp);		
					
					cstmt.executeUpdate();
					//StringUtil.printMsg("cstmt.executeUpdate();","cstmt.executeUpdate();",this);
					if(cstmt!=null) cstmt.close();	
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//StringUtil.printMsg("# Command","수정",this);
					cstmt = conn.prepareCall(updateQuery);
					
					cstmt.setString(1, rows[i].getString(colNm_GoodsCd));
					cstmt.setString(2, rows[i].getString(colNm_GoodsNm));
					cstmt.setString(3, rows[i].getString(colNm_EngNm));
					cstmt.setString(4, rows[i].getString(colNm_ShortNm));
					cstmt.setString(5, rows[i].getString(colNm_Course));
					cstmt.setString(6, rows[i].getString(colNm_Nights));
					cstmt.setString(7, rows[i].getString(colNm_Days));
					cstmt.setString(8, rows[i].getString(colNm_SaupSid));
					cstmt.setString(9, rows[i].getString(colNm_ThemeCd));
					cstmt.setString(10, rows[i].getString(colNm_DisplaySeq));
					/*
					StringUtil.printMsg("# Query",updateQuery,this);
					StringUtil.printMsg("colNm_GoodsCd",rows[i].getString(colNm_GoodsCd),this);
					StringUtil.printMsg("colNm_GoodsNm",rows[i].getString(colNm_GoodsNm),this);
					StringUtil.printMsg("colNm_EngNm",rows[i].getString(colNm_EngNm),this);
					StringUtil.printMsg("colNm_ShortNm",rows[i].getString(colNm_ShortNm),this);
					StringUtil.printMsg("colNm_Course",rows[i].getString(colNm_Course),this);
					StringUtil.printMsg("colNm_Nights",rows[i].getString(colNm_Nights),this);
					StringUtil.printMsg("colNm_Days",rows[i].getString(colNm_Days),this);
					StringUtil.printMsg("colNm_SaupSid",rows[i].getString(colNm_SaupSid),this);
					StringUtil.printMsg("colNm_ThemeCd",rows[i].getString(colNm_ThemeCd),this);
					StringUtil.printMsg("colNm_DisplaySeq",rows[i].getString(colNm_DisplaySeq),this);
					StringUtil.printMsg("colNm_UseYn",rows[i].getString(colNm_UseYn),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					StringUtil.printMsg("iParamEmpno",iParamIp,this);
					StringUtil.printMsg("colNm_GoodsSid",rows[i].getString(colNm_GoodsSid),this);
					*/
					/*
					stmt.bindColumn(uCnt++, colNm_GoodsCd);	
					stmt.bindColumn(uCnt++, colNm_GoodsNm);	
					stmt.bindColumn(uCnt++, colNm_EngNm);
					stmt.bindColumn(uCnt++, colNm_ShortNm);					
					stmt.bindColumn(uCnt++, colNm_Course);	
					stmt.bindColumn(uCnt++, colNm_Nights);
					stmt.bindColumn(uCnt++, colNm_Days);
					stmt.bindColumn(uCnt++, colNm_SaupSid);	
					stmt.bindColumn(uCnt++, colNm_ThemeCd);
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);
					*/
					//StringUtil.printMsg("사용 값??????",rows[i].getString(colNm_UseYn),this);	
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						cstmt.setString(11, "Y");
					else
						cstmt.setString(11, "N");
					cstmt.setString(12, iParamEmpno);
					cstmt.setString(13, iParamIp);
					cstmt.setString(14, rows[i].getString(colNm_GoodsSid));
					
					cstmt.executeUpdate();
					//StringUtil.printMsg("cstmt.executeUpdate();","cstmt.executeUpdate();",this);
					if(cstmt!=null) cstmt.close();
				}
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					//StringUtil.printMsg("# Command","삭제",this);
					//StringUtil.printMsg("# Query",deleteQuery,this);
					cstmt = conn.prepareCall(deleteQuery);
					cstmt.setString(1, rows[i].getString(colNm_GoodsSid));
					//StringUtil.printMsg("colNm_GoodsSid",rows[i].getString(colNm_GoodsSid),this);
						
					cstmt.executeUpdate();
					//StringUtil.printMsg("cstmt.executeUpdate();","cstmt.executeUpdate();",this);
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

