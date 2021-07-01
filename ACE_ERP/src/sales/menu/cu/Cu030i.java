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

public class Cu030i extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        /* DataSet */
		GauceDataSet ds1 = null;
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			 GauceDataSet[] dSets = gis.readAllOutput(); 
			// DataSet 생성 			
				ds1 = new GauceDataSet(); // Dataset(TSY010)
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			int     s_SalDamSid	= HDUtil.nullCheckNum(greq.getParameter("s_SalDamSid"));
			String	s_GroupCd   = HDUtil.nullCheckStr(greq.getParameter("s_GroupCd"));
			String  s_GroupNm	= HDUtil.nullCheckStr(greq.getParameter("s_GroupNm"));
			String  s_UseYn 	= HDUtil.nullCheckStr(greq.getParameter("s_UseYn"));
			
			
			//StringUtil.printMsg("단체코드",s_SalDamSid,this);
			//StringUtil.printMsg("그룹시디",s_GroupCd,this);
			//StringUtil.printMsg("그룹명",s_GroupNm,this);
			//StringUtil.printMsg("사용여부",s_UseYn,this);
			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					// 모든 단체 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 
							+ "\n\t" + "	t1.group_sid group_sid, " 
							+ "\n\t" + "	t1.group_cd group_cd, " 
							+ "\n\t" + "	t1.group_nm group_nm, " 
							+ "\n\t" + "	t1.area_cd area_cd, "
							+ "\n\t" + "	sales.fn_detail_nm('SY006',t1.area_cd) AS area_cd_nm, "
							+ "\n\t" + "	t1.vd_direct vd_direct, " 
							+ "\n\t" + "	t1.tel_no tel_no, "
							+ "\n\t" + "    t1.mobile_no mobile_no, "
							+ "\n\t" + "	t1.fax_no fax_no, " 
							+ "\n\t" + "	t1.e_mail e_mail, " 
							+ "\n\t" + "    t1.sal_dam_sid sal_dam_sid, "
							+ "\n\t" + "	t2.sal_dam_cd sal_dam_cd, "
							+ "\n\t" + "    t2.sal_dam_nm sal_dam_nm, "
							+ "\n\t" + "    t1.zip_cd zip_cd, "
							+ "\n\t" + "    t1.address1 address1, "							
							+ "\n\t" + "    t1.address2 address2, "
							+ "\n\t" + "    t1.use_yn use_yn, "
							+ "\n\t" + "    t1.memo as memo, "
							+ "\n\t" + "	sales.fn_detail_nm('SY011',t1.use_yn) AS use_yn_nm, "											
							+ "\n\t" + "    t1.after_cu AS after_cu " 																							
							+ "\n\t" + "FROM "
							+ "\n\t" + "	sales.tcu020 t1 LEFT OUTER JOIN sales.tsy410 t2 ON t1.sal_dam_sid = t2.sal_dam_sid " 
							+ "\n\t" + "WHERE 1=1 ";

					if (s_SalDamSid > 0) {
						whereQuery += ""
								   + "\n\t" + " AND  t2.sal_dam_sid=? ";
					}					
					if (!"".equals(s_GroupCd)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.group_cd  LIKE ? ";
					}
					if (!"".equals(s_GroupNm)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.group_nm LIKE ? ";
					}
					if (!"".equals(s_UseYn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.use_yn = ? ";
					}
						whereQuery += " ORDER BY t1.group_cd ";

					query += whereQuery;
		
					// 쿼리 실행
					cstmt = conn.prepareCall(query);
					//StringUtil.printMsg("query",query,this);
					
					if (s_SalDamSid > 0) {	
						cstmt.setInt(sCnt1++, s_SalDamSid);
					}
					if (!"".equals(s_GroupCd)) {	
						cstmt.setString(sCnt1++, s_GroupCd + "%");
					}	
					if (!"".equals(s_GroupNm)) {
						cstmt.setString(sCnt1++,  s_GroupNm+"%");
					}
					if (!"".equals(s_UseYn)) {	
						cstmt.setString(sCnt1++, s_UseYn);
					}
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
				break;
				case 2:
				break;
			}
			//gos.close();
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
		ResultSet 			rs 			= null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";

		try {
			GauceDataSet inputDs1 	= gis.read("INPUT_DATA");
			/*
			 * Request Parameter
			 */
			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			if (inputDs1 != null) {
				
				GauceDataRow[] 		rows = inputDs1.getDataRows();
				GauceDataColumn[] 	cols = inputDs1.getDataColumns();
			
				String fParamEmpno = "";
				String fParamIp = "";
				String iParamEmpno = fParamEmpno;
				String iParamIp = fParamIp;
					 
			 
			// Grid 첫번째 
			///////////////////////////////////////////////////////////////////////
			int colNm_GroupSid = inputDs1.indexOfColumn("group_sid");	//
			int colNm_GroupCd  = inputDs1.indexOfColumn("group_cd");	//
			int colNm_GroupNm  = inputDs1.indexOfColumn("group_nm");	//
			int colNm_AreaCd   = inputDs1.indexOfColumn("area_cd");	//
			int colNm_VdDirect = inputDs1.indexOfColumn("vd_direct");	//
			int colNm_TelNo    = inputDs1.indexOfColumn("tel_no");	//
			int colNm_MobileNo = inputDs1.indexOfColumn("mobile_no");	//
			int colNm_FaxNo    = inputDs1.indexOfColumn("fax_no");	//
			int colNm_EMail    = inputDs1.indexOfColumn("e_mail");	//
			int colNm_SalDamSid = inputDs1.indexOfColumn("sal_dam_sid");	//
			int colNm_ZipCd    = inputDs1.indexOfColumn("zip_cd");	//
			int colNm_Address1 = inputDs1.indexOfColumn("address1");	//
			int colNm_Address2 = inputDs1.indexOfColumn("address2");	//
			int colNm_UseYn    = inputDs1.indexOfColumn("use_yn");	//	
			int colNm_Memo     = inputDs1.indexOfColumn("memo");	//
			int colNm_Aftercu    = inputDs1.indexOfColumn("after_cu");	//		06.10 정하나 추가
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO sales.tcu020 "
						+ "\n\t" + "	("
						+ "\n\t" + "		group_sid, "
						+ "\n\t" + "		group_cd, "
						+ "\n\t" + "		group_nm, "
						+ "\n\t" + "		area_cd, "
						+ "\n\t" + "		vd_direct, " 
						+ "\n\t" + "		tel_no,  "
						+ "\n\t" + "		mobile_no, "
						+ "\n\t" + "		fax_no, "
						+ "\n\t" + "		e_mail, "
						+ "\n\t" + "		sal_dam_sid, "
						+ "\n\t" + "		zip_cd,  "
						+ "\n\t" + "		address1, "
						+ "\n\t" + "		address2, "
						+ "\n\t" + "		use_yn, "
						+ "\n\t" + "		memo, "
						+ "\n\t" + "		after_cu, "						
						+ "\n\t" + "		u_empno, " 
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    	SALES.SWS_TCU020_ID.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,SYSTIMESTAMP,? "
						+ "\n\t" + "       )"
						+ "\n";
		
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE sales.tcu020 "
						+ "\n\t" + "	SET"
						+ "\n\t" + "		group_cd=?, "
						+ "\n\t" + "		group_nm=?, "
						+ "\n\t" + "		area_cd=?, "
						+ "\n\t" + "		vd_direct=?, " 
						+ "\n\t" + "		tel_no=?,  "
						+ "\n\t" + "		mobile_no=?, "
						+ "\n\t" + "		fax_no=?, "
						+ "\n\t" + "		e_mail=?, "
						+ "\n\t" + "		sal_dam_sid=?, "
						+ "\n\t" + "		zip_cd=?,  "
						+ "\n\t" + "		address1=?, "
						+ "\n\t" + "		address2=?, "
						+ "\n\t" + "		use_yn=?, "
						+ "\n\t" + "		memo=?, "
						+ "\n\t" + "		after_cu=?, "						
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = SYSTIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND group_sid=?";	
			
		
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM sales.tcu020 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND group_sid=?";	
			
			// Grid 첫번째 
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					//System.out.println("# Command : 저장");
					//System.out.println("# Query : " + insertQuery);
					
					//System.out.println("# Value Head =");
					//System.out.println("# Value HeadName =");
					cstmt = conn.prepareCall(insertQuery);
					cstmt.setString(1, rows[i].getString(colNm_GroupCd));
					cstmt.setString(2, rows[i].getString(colNm_GroupNm));
					cstmt.setString(3, rows[i].getString(colNm_AreaCd));
					cstmt.setString(4, rows[i].getString(colNm_VdDirect));
					cstmt.setString(5, rows[i].getString(colNm_TelNo));
					cstmt.setString(6, rows[i].getString(colNm_MobileNo));
					cstmt.setString(7, rows[i].getString(colNm_FaxNo));
					cstmt.setString(8, rows[i].getString(colNm_EMail));
					cstmt.setString(9, rows[i].getString(colNm_SalDamSid));
					cstmt.setString(10, rows[i].getString(colNm_ZipCd));
					cstmt.setString(11, rows[i].getString(colNm_Address1));
					cstmt.setString(12, rows[i].getString(colNm_Address2));
					cstmt.setString(13, rows[i].getString(colNm_UseYn));
					cstmt.setString(14, rows[i].getString(colNm_Memo));
					cstmt.setString(15, rows[i].getString(colNm_Aftercu));
					cstmt.setString(16, iParamEmpno);
					cstmt.setString(17, iParamIp);
					/*
					stmt.bindColumn(iCnt++, colNm_GroupCd);	// 
					stmt.bindColumn(iCnt++, colNm_GroupNm);	// 
					stmt.bindColumn(iCnt++, colNm_AreaCd);	//
					stmt.bindColumn(iCnt++, colNm_VdDirect);	// 
					stmt.bindColumn(iCnt++, colNm_TelNo);	// 
					stmt.bindColumn(iCnt++, colNm_MobileNo);	//
					stmt.bindColumn(iCnt++, colNm_FaxNo);	// 
					stmt.bindColumn(iCnt++, colNm_EMail);	// 
					stmt.bindColumn(iCnt++, colNm_SalDamSid);	//					
					stmt.bindColumn(iCnt++, colNm_ZipCd);	// 
					stmt.bindColumn(iCnt++, colNm_Address1);	// 
					stmt.bindColumn(iCnt++, colNm_Address2);	//					
					stmt.bindColumn(iCnt++, colNm_UseYn);	// 
					stmt.bindColumn(iCnt++, colNm_Desc);	// 
					stmt.bindColumn(iCnt++, colNm_Aftercu);	// 					
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
					//System.out.println("# Command : 수정");
					//System.out.println("# Query : " + updateQuery);
					//System.out.println("# Value atname 	=");
					//System.out.println("# Value atcode 	=");
					cstmt = conn.prepareCall(updateQuery);
					
					cstmt.setString(1, rows[i].getString(colNm_GroupCd));
					cstmt.setString(2, rows[i].getString(colNm_GroupNm));
					cstmt.setString(3, rows[i].getString(colNm_AreaCd));
					cstmt.setString(4, rows[i].getString(colNm_VdDirect));
					cstmt.setString(5, rows[i].getString(colNm_TelNo));
					cstmt.setString(6, rows[i].getString(colNm_MobileNo));
					cstmt.setString(7, rows[i].getString(colNm_FaxNo));
					cstmt.setString(8, rows[i].getString(colNm_EMail));
					cstmt.setString(9, rows[i].getString(colNm_SalDamSid));
					cstmt.setString(10, rows[i].getString(colNm_ZipCd));
					cstmt.setString(11, rows[i].getString(colNm_Address1));
					cstmt.setString(12, rows[i].getString(colNm_Address2));
					cstmt.setString(13, rows[i].getString(colNm_UseYn));
					cstmt.setString(14, rows[i].getString(colNm_Memo));
					cstmt.setString(15, rows[i].getString(colNm_Aftercu));
					cstmt.setString(16, iParamEmpno);
					cstmt.setString(17, iParamIp);
					cstmt.setString(18, rows[i].getString(colNm_GroupSid));
					/*
					stmt.bindColumn(uCnt++, colNm_GroupCd);	// 
					stmt.bindColumn(uCnt++, colNm_GroupNm);	// 
					stmt.bindColumn(uCnt++, colNm_AreaCd);	//
					stmt.bindColumn(uCnt++, colNm_VdDirect);	// 
					stmt.bindColumn(uCnt++, colNm_TelNo);	// 
					stmt.bindColumn(uCnt++, colNm_MobileNo);	//
					stmt.bindColumn(uCnt++, colNm_FaxNo);	// 
					stmt.bindColumn(uCnt++, colNm_EMail);	// 
					stmt.bindColumn(uCnt++, colNm_SalDamSid);	//					
					stmt.bindColumn(uCnt++, colNm_ZipCd);	// 
					stmt.bindColumn(uCnt++, colNm_Address1);	// 
					stmt.bindColumn(uCnt++, colNm_Address2);	//					
					stmt.bindColumn(uCnt++, colNm_UseYn);	// 
					stmt.bindColumn(uCnt++, colNm_Desc);	// 
					stmt.bindColumn(uCnt++, colNm_Aftercu);	// 					
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_GroupSid);	// 
					*/
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					//System.out.println("# Command : 삭제");
					//System.out.println("# Query : " + deleteQuery);
					//System.out.println("# Value : head ");
					cstmt = conn.prepareCall(deleteQuery);
					cstmt.setString(1, rows[i].getString(colNm_GroupSid));
					//stmt.bindColumn(dCnt++, colNm_GroupSid);
					
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
