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

public class Sy410S extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
	}
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}

	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//System.out.println("# Command : 조회");
		
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TCU020 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String  s_DeptCd	= HDUtil.nullCheckStr(greq.getParameter("s_DeptCd"));
			String	s_SalDamCd	= HDUtil.nullCheckStr(greq.getParameter("s_SalDamCd"));
			String  s_SalDamNm	= HDUtil.nullCheckStr(greq.getParameter("s_SalDamNm"));
			String  s_UseYn 	= HDUtil.nullCheckStr(greq.getParameter("s_UseYn"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					//gceRes.enableFirstRow(ds1);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	t3.deptnm deptnm, " 
							+ "\n\t" + "	t1.sal_dam_cd sal_dam_cd, " 
							+ "\n\t" + "	t1.sal_dam_nm sal_dam_nm, " 
							+ "\n\t" + "	t1.name_gu name_gu, "
							+ "\n\t" + "	t1.office_tel office_tel, " 
							+ "\n\t" + "	t1.house_tel house_tel, "
							+ "\n\t" + "    t1.mobile_tel mobile_tel, "
							+ "\n\t" + "	t1.etc_tel etc_tel, " 
							+ "\n\t" + "	t1.fax_no fax_no, "
							+ "\n\t" + "    t1.business_gu business_gu, "
							+ "\n\t" + "	t1.area_cd area_cd, " 
							+ "\n\t" + "	sales.fn_detail_nm('SY012',t1.business_gu) AS business_gu_nm, "
							+ "\n\t" + "    sales.fn_detail_nm('SY006',t1.area_cd) AS area_cd_nm, "
							+ "\n\t" + "	t1.b_email b_email, " 
							+ "\n\t" + "	t1.msn_email msn_email, "
							+ "\n\t" + "    t1.etc_email etc_email, "
							+ "\n\t" + "	t1.bithday bithday, " 
							+ "\n\t" + "	sales.fn_detail_nm('SY013',t1.bithday_gu) AS bithday_gu_nm, "
							+ "\n\t" + "    t1.zip_cd zip_cd, "
							+ "\n\t" + "    t1.address1 address1, "							
							+ "\n\t" + "    t1.address2 address2, "							
							+ "\n\t" + "    t1.sal_dam_desc sal_dam_desc "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	sales.tsy410 t1 LEFT OUTER JOIN payroll.hiperson t2 ON t1.empno = t2.empno " 
							+ "\n\t" + "	                LEFT OUTER JOIN payroll.hcdept   t3 ON t1.deptcd = t3.deptcd " 
							+ "\n\t" + "WHERE 1=1 ";

					if (!"".equals(s_DeptCd)) {
						whereQuery += ""
								   + "\n\t" + " AND (?='' OR t1.deptcd=?) ";
					}					
					if (!"".equals(s_SalDamCd)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.sal_dam_cd = ? ";
					}
					if (!"".equals(s_SalDamNm)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.sal_dam_nm LIKE ? ";
					}
					if (!"".equals(s_UseYn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND ?='A' OR t1.use_yn = ? ";
					}
						whereQuery += " ORDER BY t1.deptcd, t1.sal_dam_cd, t1.bithday_gu, t1.deptcd, t1.empno, t2.empnmk ";

					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/	
					/*
					ds1.addDataColumn(new GauceDataColumn("deptnm",     	GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_cd", 	GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_nm",		GauceDataColumn.TB_STRING, 22));
					ds1.addDataColumn(new GauceDataColumn("name_gu", 		GauceDataColumn.TB_STRING, 22));
					ds1.addDataColumn(new GauceDataColumn("office_tel", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("house_tel", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("mobile_tel", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("etc_tel",     	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("fax_no",     	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("business_gu",		GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("area_cd", 		GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("business_gu_nm", GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("area_cd_nm", 	GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("b_email",    	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("msn_email",  	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("etc_email",     	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("bithday",     	GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("bithday_gu_nm",	GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("address1",   	GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address2", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("desc",       GauceDataColumn.TB_STRING, 60));
					*/
//					 쿼리 실행
					cstmt = conn.prepareCall(query);
					
					if (!"".equals(s_DeptCd)) {	
						cstmt.setString(sCnt1++, s_DeptCd);
					}
					if (!"".equals(s_DeptCd)) {	
						cstmt.setString(sCnt1++, s_DeptCd);
					}
					if (!"".equals(s_SalDamCd)) {	
						cstmt.setString(sCnt1++, s_SalDamCd);
					}	
					if (!"".equals(s_SalDamNm)) {
						cstmt.setString(sCnt1++,  "%"+s_SalDamNm+"%");
					}
					if (!"".equals(s_UseYn)) {	
						cstmt.setString(sCnt1++, s_UseYn);
					}
					if (!"".equals(s_UseYn)) {	
						cstmt.setString(sCnt1++, s_UseYn);
					}
					
					//System.out.println("# Query : " + query);
					rs = cstmt.executeQuery(); 
					gos.write(getDataSet(rs, ds1));// DataSet set	
					break;
				case 2:
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		
	}
}
