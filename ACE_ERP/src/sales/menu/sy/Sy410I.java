package sales.menu.sy;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Sy410I extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	}
	
	/*****************************************************************************
	 * Gauce Object 설정
	 * Select 에 들어갈 Project Name , Project Id를 조회한다
	 * 페이지 로딩시에 초기화 작업이다 
	 *****************************************************************************/
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds2 = null;
		GauceDataSet ds3 = null;		
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		try {
			// DataSet 생성 			
			ds2 = new GauceDataSet(); // Dataset TCU020
			ds3 = new GauceDataSet(); // Dataset TCU020			
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					// 프로젝트명을 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	detail, " 
							+ "\n\t" + "	detail_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY010 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n\t" + " AND rtrim(detail) > ' ' ";
					
					whereQuery += ""
								   + "\n\t" + " AND head='SY013' ";
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("detail", GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("detail_nm", GauceDataColumn.TB_STRING, 50));
					
//					 쿼리 실행
					cstmt = conn.prepareCall(query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds2));// DataSet set	 
				
					break;
					
				case 2 :
					// 프로젝트명을 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	detail, " 
							+ "\n\t" + "	detail_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY010 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n\t" + " AND rtrim(detail) > ' ' ";
					
					whereQuery += ""
								   + "\n\t" + " AND head='SY011' ";
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds3.addDataColumn(new GauceDataColumn("detail", GauceDataColumn.TB_STRING, 10));
					ds3.addDataColumn(new GauceDataColumn("detail_nm", GauceDataColumn.TB_STRING, 50));
					
//					 쿼리 실행
					cstmt = conn.prepareCall(query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds3));// DataSet set	 
					break;					
			
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();

		    if(cstmt!=null) cstmt.close();
		}
	}
	
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";
		String whereQuery =  "";
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TSY410
		
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sSaldamCd = HDUtil.nullCheckStr(greq.getParameter("sSaldamCd"));		// 담당자코드
			String sSaldamNm	 = HDUtil.nullCheckStr(greq.getParameter("sSaldamNm"));		// 담당자명
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					query   += "" 		
						+ "\n\t" + "SELECT " 	
						+ "\n\t" + "	t1.sal_dam_sid, "
						+ "\n\t" + "	t1.sal_dam_cd, " 
						+ "\n\t" + "	t1.sal_dam_nm, " 
						+ "\n\t" + "	t1.name_gu, "    
						+ "\n\t" + "	t1.office_tel, " 
						+ "\n\t" + "	t1.house_tel, "  
						+ "\n\t" + "	t1.mobile_tel, " 
						+ "\n\t" + "	t1.etc_tel, "    
						+ "\n\t" + "	t1.fax_no, "     
						+ "\n\t" + "	t1.business_gu, "
						+ "\n\t" + " (SELECT detail_nm FROM SALES.TSY010 WHERE head='SY012' AND detail<>''  AND t1.business_gu=detail) business_gunm, "						
						+ "\n\t" + "	t1.area_cd, "    
						+ "\n\t" + " (SELECT detail_nm FROM SALES.TSY010 WHERE head='SY006' AND detail<>'' AND t1.area_cd=detail) area_cdnm, "						
						+ "\n\t" + "	t1.b_email, "    
						+ "\n\t" + "	t1.msn_email, "  
						+ "\n\t" + "	t1.etc_email, "  
						+ "\n\t" + "	t1.bithday, "    
						+ "\n\t" + "	t1.bithday_gu, " 
						+ "\n\t" + "	t1.zip_cd, "     
						+ "\n\t" + "	t1.address1, "   
						+ "\n\t" + "	t1.address2, "   
						+ "\n\t" + "	t1.sal_dam_desc, "       
						+ "\n\t" + "	t1.deptcd, "     
						+ "\n\t" + "	t1.empno, "      
						+ "\n\t" + "	t1.u_empno, "    
						+ "\n\t" + "	t1.u_date, "     
						+ "\n\t" + "	t1.u_ip, "       
						+ "\n\t" + "	t2.empnmk, "     
						+ "\n\t" + "	t3.deptnm, "
						+ "\n\t" + "	t1.use_yn "						
						+ "\n\t" + " "								
						+ "\n\t" + "FROM "
						+ "\n\t" + "	SALES.TSY410 T1 LEFT OUTER JOIN  PAYROLL.HIPERSON T2 ON  T1.EMPNO  = T2.EMPNO "
						+ "\n\t" + "	 LEFT OUTER JOIN  PAYROLL.HCDEPT   T3 ON  T1.DEPTCD = T3.DEPTCD" 
						+ "\n\t" + "WHERE 1=1 ";
					
					if (!"".equals(sSaldamNm)) {
					whereQuery += ""
							   + "\n\t" + " AND t1.sal_dam_nm LIKE '%"+sSaldamNm+"%' ";
					}
					
					if (!"".equals(sSaldamCd)) {
						whereQuery += ""
								   + "\n\t" + " AND t1.sal_dam_cd LIKE '%"+sSaldamCd+"%' ";
						}					
					
					query += whereQuery + "ORDER BY T1.SAL_DAM_NM";
					//System.out.println(query);
//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					/*
					ds1.addDataColumn(new GauceDataColumn("sal_dam_sid", 		GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_cd", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_nm", 		GauceDataColumn.TB_STRING, 22));
					ds1.addDataColumn(new GauceDataColumn("name_gu", 		GauceDataColumn.TB_STRING, 22));
					ds1.addDataColumn(new GauceDataColumn("office_tel", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("house_tel", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("mobile_tel", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("etc_tel", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("fax_no", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("business_gu", 		GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("business_gunm", 		GauceDataColumn.TB_STRING, 10));					
					ds1.addDataColumn(new GauceDataColumn("area_cd", 		GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("area_cdnm", 		GauceDataColumn.TB_STRING, 6));					
					ds1.addDataColumn(new GauceDataColumn("b_email", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("msn_email", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("etc_email", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("bithday", 		GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("bithday_gu", 		GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("address1", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address2", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_desc", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("empnmk", 		GauceDataColumn.TB_STRING, 20));					
					ds1.addDataColumn(new GauceDataColumn("deptcd", 		GauceDataColumn.TB_STRING, 4));
					ds1.addDataColumn(new GauceDataColumn("deptnm", 		GauceDataColumn.TB_STRING, 20));					
					ds1.addDataColumn(new GauceDataColumn("use_yn", 		GauceDataColumn.TB_STRING, 1));					
					*/
//					 쿼리 실행
					cstmt = conn.prepareCall(query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds1));// DataSet set	
					break;
					
			}
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
	
		    if(cstmt!=null) cstmt.close();
		}
	}

	// 마트터 입력, 수정, 삭제
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
		CallableStatement cstmt = null;	
		ResultSet 			rs 			= null;

		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";
		
		try {
			
			GauceDataSet codeDs = gis.read("INPUT_DATA");
			
			/*
			 * Request Parameter
			 */
			
			int colNm_SaldamSid 	= codeDs.indexOfColumn("sal_dam_sid");	
			int colNm_SaldamCd 	= codeDs.indexOfColumn("sal_dam_cd");	
			int colNm_SaldamNm 	= codeDs.indexOfColumn("sal_dam_nm");	
			int colNm_NameGu 	= codeDs.indexOfColumn("name_gu");	
			int colNm_OfficeTel 	= codeDs.indexOfColumn("office_tel");      	
			int colNm_HouseTel 	= codeDs.indexOfColumn("house_tel");	
			int colNm_MobileTel 	= codeDs.indexOfColumn("mobile_tel");	
			int colNm_EtcTel 	= codeDs.indexOfColumn("etc_tel");	
			int colNm_FaxNo 	= codeDs.indexOfColumn("fax_no");         	
			int colNm_BusinessGu 	= codeDs.indexOfColumn("business_gu");	
			int colNm_AreaCd 	= codeDs.indexOfColumn("area_cd");
			int colNm_BEmail 	= codeDs.indexOfColumn("b_email");	
			int colNm_MsnEmail 	= codeDs.indexOfColumn("msn_email");
			int colNm_EtcEmail 	= codeDs.indexOfColumn("etc_email");			
			int colNm_Bithday 	= codeDs.indexOfColumn("bithday");	
			int colNm_BithdayGu 	= codeDs.indexOfColumn("bithday_gu");	
			int colNm_ZipCd 	= codeDs.indexOfColumn("zip_cd");	
			int colNm_Address1 	= codeDs.indexOfColumn("address1");	
			int colNm_Address2 	= codeDs.indexOfColumn("address2");	
			int colNm_sal_dam_desc 	= codeDs.indexOfColumn("sal_dam_desc");	
			int colNm_Empno 	= codeDs.indexOfColumn("empno");	
			int colNm_Deptcd 	= codeDs.indexOfColumn("deptcd");
			int colNm_UseYn 	= codeDs.indexOfColumn("use_yn");			
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY410 "
						+ "\n\t" + "	("
						+ "\n\t" + "		sal_dam_sid, "
						+ "\n\t" + "		sal_dam_cd, "
						+ "\n\t" + "		sal_dam_nm, "
						+ "\n\t" + "		name_gu, "
						+ "\n\t" + "		office_tel, "
						+ "\n\t" + "		house_tel, "
						+ "\n\t" + "		mobile_tel, "
						+ "\n\t" + "		etc_tel, "
						+ "\n\t" + "		fax_no, "
						+ "\n\t" + "		business_gu, "
						+ "\n\t" + "		area_cd, "
						+ "\n\t" + "		b_email, "
						+ "\n\t" + "		msn_email, "
						+ "\n\t" + "		etc_email, "						
						+ "\n\t" + "		bithday, "
						+ "\n\t" + "		bithday_gu, "
						+ "\n\t" + "		zip_cd, "
						+ "\n\t" + "		address1, "
						+ "\n\t" + "		address2, "
						+ "\n\t" + "		sal_dam_desc, "
						+ "\n\t" + "		empno, "
						+ "\n\t" + "		deptcd,	 "
						+ "\n\t" + "		use_yn 	"						
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		SALES.SWS_TSY410_ID.NEXTVAL,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY410"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		sal_dam_cd = ?,"
						+ "\n\t" + "		sal_dam_nm = ?, "
						+ "\n\t" + "		name_gu = ?, "
						+ "\n\t" + "		office_tel = ?, "
						+ "\n\t" + "		house_tel = ?, "
						+ "\n\t" + "		mobile_tel = ?, "
						+ "\n\t" + "		etc_tel = ?, "
						+ "\n\t" + "		fax_no = ?, "
						+ "\n\t" + "		business_gu = ?, "
						+ "\n\t" + "		area_cd = ?, "
						+ "\n\t" + "		b_email = ?, "
						+ "\n\t" + "		msn_email = ?, "
						+ "\n\t" + "		etc_email = ?, "						
						+ "\n\t" + "		bithday = ?, "
						+ "\n\t" + "		bithday_gu = ?, "
						+ "\n\t" + "		zip_cd = ?, "
						+ "\n\t" + "		address1 = ?, "
						+ "\n\t" + "		address2 = ?, "
						+ "\n\t" + "		sal_dam_desc = ?, "
						+ "\n\t" + "		empno = ?, "
						+ "\n\t" + "		deptcd = ?, "
						+ "\n\t" + "		use_yn = ? "						
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND sal_dam_sid=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY410 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND sal_dam_sid=?";	
			
			
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					//StringUtil.printMsg("# Command :","저장",this);
					//StringUtil.printMsg("# Query : ",insertQuery,this);
					cstmt = conn.prepareCall(insertQuery);
					
					cstmt.setString(iCnt++, rows[i].getString(colNm_SaldamCd));
					cstmt.setString(iCnt++, rows[i].getString(colNm_SaldamNm));
					cstmt.setString(iCnt++, rows[i].getString(colNm_NameGu));
					cstmt.setString(iCnt++, rows[i].getString(colNm_OfficeTel));
					cstmt.setString(iCnt++, rows[i].getString(colNm_HouseTel));
					cstmt.setString(iCnt++, rows[i].getString(colNm_MobileTel));
					cstmt.setString(iCnt++, rows[i].getString(colNm_EtcTel));
					cstmt.setString(iCnt++, rows[i].getString(colNm_FaxNo));
					cstmt.setString(iCnt++, rows[i].getString(colNm_BusinessGu));
					cstmt.setString(iCnt++, rows[i].getString(colNm_AreaCd));
					cstmt.setString(iCnt++, rows[i].getString(colNm_BEmail));
					cstmt.setString(iCnt++, rows[i].getString(colNm_MsnEmail));
					cstmt.setString(iCnt++, rows[i].getString(colNm_EtcEmail));
					cstmt.setString(iCnt++, rows[i].getString(colNm_Bithday));
					cstmt.setString(iCnt++, rows[i].getString(colNm_BithdayGu));
					cstmt.setString(iCnt++, rows[i].getString(colNm_ZipCd));
					cstmt.setString(iCnt++, rows[i].getString(colNm_Address1));
					cstmt.setString(iCnt++, rows[i].getString(colNm_Address2));
					cstmt.setString(iCnt++, rows[i].getString(colNm_sal_dam_desc));
					cstmt.setString(iCnt++, rows[i].getString(colNm_Empno));
					cstmt.setString(iCnt++, rows[i].getString(colNm_Deptcd));
					cstmt.setString(iCnt++, rows[i].getString(colNm_UseYn));
					/*
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(iCnt++, colNm_SaldamCd);	
					stmt.bindColumn(iCnt++, colNm_SaldamNm);	
					stmt.bindColumn(iCnt++, colNm_NameGu);	
					stmt.bindColumn(iCnt++, colNm_OfficeTel);	
					stmt.bindColumn(iCnt++, colNm_HouseTel);	
					stmt.bindColumn(iCnt++, colNm_MobileTel);	
					stmt.bindColumn(iCnt++, colNm_EtcTel);	
					stmt.bindColumn(iCnt++, colNm_FaxNo);	
					stmt.bindColumn(iCnt++, colNm_BusinessGu);	
					stmt.bindColumn(iCnt++, colNm_AreaCd);	
					stmt.bindColumn(iCnt++, colNm_BEmail);	
					stmt.bindColumn(iCnt++, colNm_MsnEmail);
					stmt.bindColumn(iCnt++, colNm_EtcEmail);					
					stmt.bindColumn(iCnt++, colNm_Bithday);	
					stmt.bindColumn(iCnt++, colNm_BithdayGu);	
					stmt.bindColumn(iCnt++, colNm_ZipCd);	
					stmt.bindColumn(iCnt++, colNm_Address1);	
					stmt.bindColumn(iCnt++, colNm_Address2);	
					stmt.bindColumn(iCnt++, colNm_sal_dam_desc);	
					stmt.bindColumn(iCnt++, colNm_Empno);	
					stmt.bindColumn(iCnt++, colNm_Deptcd);
					stmt.bindColumn(iCnt++, colNm_UseYn);					
					*/
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//StringUtil.printMsg("# Command :","수정",this);
					//StringUtil.printMsg("# Query : ", updateQuery,this);
					
					cstmt = conn.prepareCall(updateQuery);

					//stmt.setGauceDataRow(rows[i]);
					
					cstmt.setString(uCnt++, rows[i].getString(colNm_SaldamCd));
					cstmt.setString(uCnt++, rows[i].getString(colNm_SaldamNm));
					cstmt.setString(uCnt++, rows[i].getString(colNm_NameGu));
					cstmt.setString(uCnt++, rows[i].getString(colNm_OfficeTel));
					cstmt.setString(uCnt++, rows[i].getString(colNm_HouseTel));
					cstmt.setString(uCnt++, rows[i].getString(colNm_MobileTel));
					cstmt.setString(uCnt++, rows[i].getString(colNm_EtcTel));
					cstmt.setString(uCnt++, rows[i].getString(colNm_FaxNo));
					cstmt.setString(uCnt++, rows[i].getString(colNm_BusinessGu));
					cstmt.setString(uCnt++, rows[i].getString(colNm_AreaCd));
					cstmt.setString(uCnt++, rows[i].getString(colNm_BEmail));
					cstmt.setString(uCnt++, rows[i].getString(colNm_MsnEmail));
					cstmt.setString(uCnt++, rows[i].getString(colNm_EtcEmail));
					cstmt.setString(uCnt++, rows[i].getString(colNm_Bithday));
					cstmt.setString(uCnt++, rows[i].getString(colNm_BithdayGu));
					cstmt.setString(uCnt++, rows[i].getString(colNm_ZipCd));
					cstmt.setString(uCnt++, rows[i].getString(colNm_Address1));
					cstmt.setString(uCnt++, rows[i].getString(colNm_Address2));
					cstmt.setString(uCnt++, rows[i].getString(colNm_sal_dam_desc));
					cstmt.setString(uCnt++, rows[i].getString(colNm_Empno));
					cstmt.setString(uCnt++, rows[i].getString(colNm_Deptcd));
					cstmt.setString(uCnt++, rows[i].getString(colNm_UseYn));
					cstmt.setString(uCnt++, rows[i].getString(colNm_SaldamSid));
					/*
					stmt.bindColumn(uCnt++, colNm_SaldamCd);	
					stmt.bindColumn(uCnt++, colNm_SaldamNm);	
					stmt.bindColumn(uCnt++, colNm_NameGu);	
					stmt.bindColumn(uCnt++, colNm_OfficeTel);	
					stmt.bindColumn(uCnt++, colNm_HouseTel);	
					stmt.bindColumn(uCnt++, colNm_MobileTel);	
					stmt.bindColumn(uCnt++, colNm_EtcTel);	
					stmt.bindColumn(uCnt++, colNm_FaxNo);	
					stmt.bindColumn(uCnt++, colNm_BusinessGu);	
					stmt.bindColumn(uCnt++, colNm_AreaCd);	
					stmt.bindColumn(uCnt++, colNm_BEmail);	
					stmt.bindColumn(uCnt++, colNm_MsnEmail);
					stmt.bindColumn(uCnt++, colNm_EtcEmail);					
					stmt.bindColumn(uCnt++, colNm_Bithday);	
					stmt.bindColumn(uCnt++, colNm_BithdayGu);	
					stmt.bindColumn(uCnt++, colNm_ZipCd);	
					stmt.bindColumn(uCnt++, colNm_Address1);	
					stmt.bindColumn(uCnt++, colNm_Address2);	
					stmt.bindColumn(uCnt++, colNm_sal_dam_desc);	
					stmt.bindColumn(uCnt++, colNm_Empno);	
					stmt.bindColumn(uCnt++, colNm_Deptcd);
					stmt.bindColumn(uCnt++, colNm_UseYn);					
					stmt.bindColumn(uCnt++, colNm_SaldamSid);					
					*/
					cstmt.executeUpdate();
					if(cstmt!=null) cstmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					//StringUtil.printMsg("# Command : ","삭제");
					//StringUtil.printMsg("# Query : " ,deleteQuery,this);
					cstmt = conn.prepareCall(deleteQuery);
					
					//stmt.setGauceDataRow(rows[i]);
					cstmt.setString(dCnt++, rows[i].getString(colNm_SaldamSid));
					//stmt.bindColumn(dCnt++, colNm_SaldamSid);
					
					cstmt.executeUpdate();
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
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}		
	}
}
