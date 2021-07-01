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

public class Rm020I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String	s_DongCd	= HDUtil.nullCheckStr(greq.getParameter("s_DongCd"));
			String	s_DongNm	= HDUtil.nullCheckStr(greq.getParameter("s_DongNm"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
				if(dSets[i].getName().equals("ds1")){
		    		GauceDataSet ds1 = gis.read("DEFAULT");
					switch(dsType) {
						case 1 :
							int sCnt1 = 1;
							// 모든 사업장 얻어옴 
							query   += "" 		
									+ "\n\t" + "SELECT " 
									+ "\n\t" + "    r1.dong_sid dong_sid, "
									+ "\n\t" + "	r1.dong_cd dong_cd, "
									+ "\n\t" + "    r1.dong_nm dong_nm, "
									+ "\n\t" + "    r1.dong_eng_nm dong_eng_nm, "
									+ "\n\t" + "    r1.dong_short_nm dong_short_nm, "
									+ "\n\t" + "    r1.upjang_sid upjang_sid, "
									+ "\n\t" + "    r2.upjang_cd upjang_cd, "
									+ "\n\t" + "    r2.upjang_nm upjang_nm, "
									+ "\n\t" + "    r1.u_empno u_empno, "
									+ "\n\t" + "    to_char(r1.u_date) u_date, "
									+ "\n\t" + "    r1.u_ip u_ip "
									+ "\n\t" + "FROM "
									+ "\n\t" + "	sales.trm020 r1, sales.trm010 r2 "
									+ "\n\t" + "WHERE 1=1 "
									+ "\n\t" + "AND r1.upjang_sid=r2.upjang_sid ";
		
							if (!"".equals(s_DongCd)) {
								whereQuery += ""
										   + "\n\t" + " AND r1.dong_cd=? ";
							}
							if (!"".equals(s_DongNm)) {
								whereQuery += ""
											+ "\n\t" + " AND r1.dong_nm LIKE ? ";
							}				
							query += whereQuery;
	
							 /**********************************************************************************
							 * DataSet 초기화 
							 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
							 **********************************************************************************/					
							ds1.addDataColumn(new GauceDataColumn("dong_sid", 		GauceDataColumn.TB_DECIMAL, 10,0));
							ds1.addDataColumn(new GauceDataColumn("dong_cd", 		GauceDataColumn.TB_STRING, 4));
							ds1.addDataColumn(new GauceDataColumn("dong_nm", 		GauceDataColumn.TB_STRING, 30));
							ds1.addDataColumn(new GauceDataColumn("dong_eng_nm", 	GauceDataColumn.TB_STRING, 30));
							ds1.addDataColumn(new GauceDataColumn("dong_short_nm", 	GauceDataColumn.TB_STRING, 12));
							ds1.addDataColumn(new GauceDataColumn("upjang_sid", 	GauceDataColumn.TB_DECIMAL, 10,0));
							ds1.addDataColumn(new GauceDataColumn("upjang_cd",  	GauceDataColumn.TB_STRING, 4));
							ds1.addDataColumn(new GauceDataColumn("upjang_nm", 	    GauceDataColumn.TB_STRING, 30));
							ds1.addDataColumn(new GauceDataColumn("u_empno", 	    GauceDataColumn.TB_STRING, 7));
							ds1.addDataColumn(new GauceDataColumn("u_date", 	    GauceDataColumn.TB_STRING, 26));
							ds1.addDataColumn(new GauceDataColumn("u_ip", 	        GauceDataColumn.TB_STRING, 30));
							
							// 쿼리 실행
							cstmt = conn.prepareCall(query); 
							
							if (!"".equals(s_DongCd)) {	
								cstmt.setString(sCnt1++, s_DongCd);
							}
							if (!"".equals(s_DongNm)) {
								cstmt.setString(sCnt1++, "%" + s_DongNm + "%");
							}
		
							rs = cstmt.executeQuery(); 
				   			gos.write(getDataSet(rs, ds1));// DataSet set
						break;
						case 2:
						break;
					}
				}
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
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// 입력, 수정, 삭제
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		//StringUtil.printMsg("apply  " ," apply",this);
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
				
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
						
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";
		
		/* DataSet */
		GauceDataSet inputDs1 = gis.read("INPUT_DATA");
		
		try {
			//StringUtil.printMsg("try  " ," try",this);
			if (inputDs1 != null) {
				//StringUtil.printMsg("if  " ," if",this);
				GauceDataRow[] 		rows = inputDs1.getDataRows();
			/*
			 * Request Parameter
			 */
			// Grid 첫번째 
			///////////////////////////////////////////////////////////////////////
			int colNm_DongSid	= inputDs1.indexOfColumn("dong_sid");	//
			int colNm_DongCd	= inputDs1.indexOfColumn("dong_cd");	//
			int colNm_DongNm  	= inputDs1.indexOfColumn("dong_nm");	//
			int colNm_DongEngNm = inputDs1.indexOfColumn("dong_eng_nm");	//
			int colNm_DongShortNm = inputDs1.indexOfColumn("dong_short_nm");	//
			int colNm_UpjangSid	= inputDs1.indexOfColumn("upjang_sid");	//
			int colNm_UpjangCd  = inputDs1.indexOfColumn("upjang_cd");	//
			int colNm_UpjangNm  = inputDs1.indexOfColumn("upjang_nm");	//
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO sales.trm020 "
						+ "\n\t" + "	("
						+ "\n\t" + "		dong_sid, dong_cd, dong_nm, dong_eng_nm, dong_short_nm, upjang_sid, "
						+ "\n\t" + "		u_empno, u_date, u_ip "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "	SALES.SWS_TRM020_ID.NEXTVAL,?,?,?,?,?, "	
						+ "\n\t" + "    ?,SYSTIMESTAMP,? "
						+ "\n\t" + "       )"
						+ "\n"; //dong_sid 자동증가
		
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE sales.trm020 "
						+ "\n\t" + "	SET"
						+ "\n\t" + "		dong_cd = ?, "
						+ "\n\t" + "        dong_nm = ?, "
						+ "\n\t" + "        dong_eng_nm = ?, "
						+ "\n\t" + "		dong_short_nm = ?, "
						+ "\n\t" + "        upjang_sid = ?, "
						+ "\n\t" + "        u_empno = ?, "
						+ "\n\t" + "		u_date = SYSTIMESTAMP, "
						+ "\n\t" + "        u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND dong_sid=?";	
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM sales.trm020 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND dong_sid=?";	
			
			// Grid 첫번째 
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					cstmt = conn.prepareCall(insertQuery);
					
					cstmt.setString(iCnt++, rows[i].getString(colNm_DongCd));
					cstmt.setString(iCnt++, rows[i].getString(colNm_DongNm));
					cstmt.setString(iCnt++, rows[i].getString(colNm_DongEngNm));
					cstmt.setString(iCnt++, rows[i].getString(colNm_DongShortNm));
					cstmt.setString(iCnt++, rows[i].getString(colNm_UpjangSid));
					cstmt.setString(iCnt++, iParamEmpno);
					cstmt.setString(iCnt++, iParamIp);
					/*
					stmt.bindColumn(iCnt++, colNm_DongCd);	// 
					stmt.bindColumn(iCnt++, colNm_DongNm);	//
					stmt.bindColumn(iCnt++, colNm_DongEngNm);	//
					stmt.bindColumn(iCnt++, colNm_DongShortNm);	// 
					stmt.bindColumn(iCnt++, colNm_UpjangSid);	//					
					// **** 쿠키 ***** //
					stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
					stmt.setString(iCnt++, iParamIp);			// 수정자 ip
					*/
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					cstmt = conn.prepareCall(updateQuery);
					/*
					StringUtil.printMsg("updateQuery",updateQuery,this);
					StringUtil.printMsg("rows[i].getString(colNm_DongCd)",rows[i].getString(colNm_DongCd),this);
					StringUtil.printMsg("rows[i].getString(colNm_DongNm)",rows[i].getString(colNm_DongNm),this);
					StringUtil.printMsg("rows[i].getString(colNm_DongEngNm)",rows[i].getString(colNm_DongEngNm),this);
					StringUtil.printMsg("rows[i].getString(colNm_DongShortNm)",rows[i].getString(colNm_DongShortNm),this);
					StringUtil.printMsg("rows[i].getString(colNm_UpjangSid)",rows[i].getString(colNm_UpjangSid),this);
					StringUtil.printMsg("iParamEmpno",iParamEmpno,this);
					StringUtil.printMsg("iParamIp",iParamIp,this);
					StringUtil.printMsg("rows[i].getString(colNm_DongSid)",rows[i].getString(colNm_DongSid),this);
					*/
					cstmt.setString(uCnt++, rows[i].getString(colNm_DongCd));
					cstmt.setString(uCnt++, rows[i].getString(colNm_DongNm));
					cstmt.setString(uCnt++, rows[i].getString(colNm_DongEngNm));
					cstmt.setString(uCnt++, rows[i].getString(colNm_DongShortNm));
					cstmt.setString(uCnt++, rows[i].getString(colNm_UpjangSid));
					cstmt.setString(uCnt++, iParamEmpno);
					cstmt.setString(uCnt++, iParamIp);
					cstmt.setString(uCnt++, rows[i].getString(colNm_DongSid));
					/*
					stmt.bindColumn(uCnt++, colNm_DongCd);	// 
					stmt.bindColumn(uCnt++, colNm_DongNm);	//
					stmt.bindColumn(uCnt++, colNm_DongEngNm);	//
					stmt.bindColumn(uCnt++, colNm_DongShortNm);	// 
					stmt.bindColumn(uCnt++, colNm_UpjangSid);	// 
					// **** 쿠키 ***** //
					stmt.setString(uCnt++, iParamEmpno);		// 수정자 사번 
					stmt.setString(uCnt++, iParamIp);			// 수정자 ip					
					stmt.bindColumn(uCnt++, colNm_DongSid);	// 					
					*/
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();				
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					cstmt = conn.prepareCall(deleteQuery);
					cstmt.setString(dCnt++, rows[i].getString(colNm_DongSid));
					//stmt.bindColumn(dCnt++, colNm_DongSid);
					
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
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
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}
}