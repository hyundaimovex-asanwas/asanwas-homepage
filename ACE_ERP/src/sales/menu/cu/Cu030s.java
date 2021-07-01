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

public class Cu030s extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
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
			GauceDataSet[] dSets = gis.readAllOutput(); 
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TCU020 
			
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
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					//gceRes.enableFirstRow(ds1);
					
					// 모든 단체 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 
							+ "\n\t" + "    t2.sal_dam_cd sal_dam_cd, "
							+ "\n\t" + "    t2.sal_dam_nm sal_dam_nm, "
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
							+ "\n\t" + "	t1.sal_dam_sid sal_dam_sid, "
							+ "\n\t" + "    t1.zip_cd zip_cd, "
							+ "\n\t" + "    t1.address1 address1, "							
							+ "\n\t" + "    t1.address2 address2, "
							+ "\n\t" + "    t1.use_yn use_yn, "
							+ "\n\t" + "    t1.memo as memo, "
							+ "\n\t" + "	sales.fn_detail_nm('SY010',t1.use_yn) AS use_yn_nm "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	sales.tcu020 t1 LEFT OUTER JOIN sales.tsy410 t2 ON t1.sal_dam_sid = t2.sal_dam_sid " 
							+ "\n\t" + "WHERE 1=1 ";

					if (s_SalDamSid > 0) {
						whereQuery += ""
								   + "\n\t" + " AND t2.sal_dam_sid=? ";
					}					
					if (!"".equals(s_GroupCd)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.group_cd LIKE ? ";
					}
					if (!"".equals(s_GroupNm)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND t1.group_nm LIKE ? ";
					}
					if (!"".equals(s_UseYn)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND  t1.use_yn = ? ";
					}
						whereQuery += " ORDER BY t1.group_cd ";

					query += whereQuery;
		
					// 쿼리 실행
					cstmt = conn.prepareCall(query);
					
					if (s_SalDamSid > 0) {	
						cstmt.setInt(sCnt1++, s_SalDamSid);
					}
					if (!"".equals(s_GroupCd)) {	
						cstmt.setString(sCnt1++, s_GroupCd+"%");
					}	
					if (!"".equals(s_GroupNm)) {
						cstmt.setString(sCnt1++,  s_GroupNm+"%");
					}
					if (!"".equals(s_UseYn)) {	
						cstmt.setString(sCnt1++, s_UseYn);
					}
					//System.out.println("# Query : " + query);
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					//stmt.close();
				break;
				case 2:
				break;
			}
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
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
}