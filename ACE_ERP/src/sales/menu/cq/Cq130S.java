package sales.menu.cq;

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

public class Cq130S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		arr_sql[0].append (" SELECT                                                      \n")
		  .append ("    sales.fn_detail_nm('RM014',t2.depart_time) AS depart_time,  \n")
		  .append ("    t4.goods_nm AS goods_nm,                                    \n")
		  .append ("	sales.fn_detail_nm('RV017',t2.class) AS class,              \n")
		  .append ("	SUBSTR(t2.teams,1,2) AS teams,                              \n")
		  .append ("    t2.tour_no AS tour_no,                                      \n")
		  .append ("	t3.cust_nm AS cust_nm,                                      \n")
		  .append ("    CASE WHEN T3.COUNTRY_GU = '10'                                                     THEN SUBSTR(T3.REGI_NO,1,6)||'-'||SUBSTR(T3.REGI_NO,7,7) \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) <> '2' AND T3.SEX = 'M' THEN T3.BIRTHDAY||'-1'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) <> '2' AND T3.SEX = 'F' THEN T3.BIRTHDAY||'-2'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) =  '2' AND T3.SEX = 'M' THEN T3.BIRTHDAY||'-3'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) =  '2' AND T3.SEX = 'F' THEN T3.BIRTHDAY||'-4'||'000000'            \n")
			.append("                   ELSE ''       END                         AS REGI_NO,                                                                      \n")
		  .append ("    sales.fn_detail_nm('SY009',t3.sex) AS sex,                  \n")
		  .append(" 	'대한민국' AS COUNTRY_CD,  										\n")					
		 // .append ("    sales.fn_detail_nm('SY005',t3.country_cd) AS country_cd,    \n")
		  .append ("	t2.unity_no AS unity_no,                                    \n")
		  .append ("    '*'||t2.unity_no||'*' AS unity_no1,                         \n")
		  .append ("	t3.address1 AS address1,                                    \n")
		  .append ("	t3.tel_no AS tel_no,                                        \n")
		  .append ("    t3.company_nm AS company_nm,                                \n")
		  .append ("    CASE WHEN t2.cust_gu='1' THEN '관광' ELSE '사업' END AS tour_obj, \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'1') AS start_end,        \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'2') AS end_start,        \n")
		  .append ("    t4.goods_nm AS goods_nm                                     \n")
		  .append (" FROM sales.trv010 t1, sales.trv020 t2,                         \n")
		  .append ("      sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON t3.zip_sid=t5.zip_sid, \n")
		  .append ("      sales.trm200 t4                                           \n")
		  .append (" WHERE t1.accept_sid=t2.accept_sid                              \n")
		  .append (" AND t2.cust_sid=t3.cust_sid                                    \n")
		  .append (" AND t1.goods_sid=t4.goods_sid                                  \n")
		  .append (" AND t2.status_cd IN('RA','RR','DP','AR')                            \n");

		arr_sql[1].append ("  SELECT                                                      \n")
		  .append ("    sales.fn_detail_nm('RM014',t2.depart_time) AS depart_time,  \n")
		  .append ("    t4.goods_nm AS goods_nm,                                    \n")
		  .append ("    sales.fn_detail_nm('RV017',t2.class) AS class,              \n")
		  .append ("    SUBSTR(t2.teams,1,2) AS teams,                              \n")
		  .append ("    t2.tour_no AS tour_no,                                      \n")
		  .append ("    RTRIM(t3.last_nm)||' '||RTRIM(t3.first_nm) AS cust_nm,      \n")
		  .append ("    t3.birthday AS regi_no,                                     \n")
		  .append ("    sales.fn_detail_nm('SY009',t3.sex) AS sex,                  \n")
		  .append ("    sales.fn_country_eng_nm(t3.country_cd) AS country_cd,       \n")
		  .append ("    t3.pass_no AS unity_no,                                    \n")
		  .append ("    '*'||t2.unity_no||'*' AS unity_no1,                         \n")
		  .append ("    t3.eng_addr1 AS address1,                                  \n")
		  .append ("    t3.tel_no AS tel_no,                                        \n")
		  .append ("    t3.eng_company_nm||' '||t3.eng_position AS conpany_nm,      \n")
		  .append ("    '' AS tour_obj,                                             \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'3') AS start_end,        \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'4') AS end_start,        \n")
		  .append ("    t4.eng_nm AS goods_nm                                       \n")
		  .append (" FROM sales.trv010 t1, sales.trv020 t2,                         \n")
		  .append ("      sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON t3.zip_sid=t5.zip_sid, \n")
		  .append ("      sales.trm200 t4                                           \n")
		  .append (" WHERE t1.accept_sid=t2.accept_sid                              \n")
		  .append (" AND t2.cust_sid=t3.cust_sid                                    \n")
		  .append (" AND t1.goods_sid=t4.goods_sid                                  \n")
		  .append (" AND t2.status_cd IN('RA','RR','DP','AR')                            \n");
		
		arr_sql[2].append (" SELECT                                                      \n")
		  .append ("    sales.fn_detail_nm('RM014',t2.depart_time) AS depart_time,  \n")
		  .append ("    t4.goods_nm AS goods_nm,                                    \n")
		  .append ("	sales.fn_detail_nm('RV017',t2.class) AS class,              \n")
		  .append ("	SUBSTR(t2.teams,1,2) AS teams,                              \n")
		  .append ("    t2.tour_no AS tour_no,                                      \n")
		  .append ("	t3.cust_nm AS cust_nm,                                      \n")
		  .append ("    t3.birthday AS birthday,                                    \n")
		  .append ("    CASE WHEN T3.COUNTRY_GU = '10'                                                     THEN SUBSTR(T3.REGI_NO,7,7) \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) <> '2' AND T3.SEX = 'M' THEN '1'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) <> '2' AND T3.SEX = 'F' THEN '2'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) =  '2' AND T3.SEX = 'M' THEN '3'||'000000'            \n")
			.append("                   WHEN T3.COUNTRY_GU = '20' AND SUBSTR(T3.BIRTHDAY,1,1) =  '2' AND T3.SEX = 'F' THEN '4'||'000000'            \n")
			.append("                   ELSE ''       END                         AS REGI_NO,                                                                      \n")
		  .append ("    CASE WHEN t3.sex='M' THEN '○' ELSE '' END AS m_sex_chk,    \n")
		  .append ("    CASE WHEN t3.sex='F' THEN '○' ELSE '' END AS f_sex_chk,    \n")
		  .append(" 	'대한민국' AS COUNTRY_CD,  										\n")	
		  // .append ("    sales.fn_detail_nm('SY005',t3.country_cd) AS country_cd,    \n")
		  .append ("	t2.unity_no AS unity_no,                                    \n")
		  .append ("    '*'||t2.unity_no||'*' AS unity_no1,                         \n")
		  .append ("	t3.address1 AS address1,                                    \n")
		  .append ("	t3.tel_no AS tel_no,                                        \n")
		  .append ("    t3.company_nm AS company_nm,                                \n")
		  .append ("    CASE WHEN t2.cust_gu='1' THEN '관광' ELSE '사업' END AS tour_obj, \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'1') AS start_end,        \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'2') AS end_start,        \n")
		  .append ("    t4.goods_nm AS goods_nm                                     \n")
		  .append (" FROM sales.trv010 t1, sales.trv020 t2,                         \n")
		  .append ("      sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON t3.zip_sid=t5.zip_sid, \n")
		  .append ("      sales.trm200 t4                                           \n")
		  .append (" WHERE t1.accept_sid=t2.accept_sid                              \n")
		  .append (" AND t2.cust_sid=t3.cust_sid                                    \n")
		  .append (" AND t1.goods_sid=t4.goods_sid                                  \n")
		  .append (" AND t2.status_cd IN('RA','RR','DP','AR')                            \n");

		arr_sql[3].append ("  SELECT                                                      \n")
		  .append ("    sales.fn_detail_nm('RM014',t2.depart_time) AS depart_time,  \n")
		  .append ("    t4.goods_nm AS goods_nm,                                    \n")
		  .append ("    sales.fn_detail_nm('RV017',t2.class) AS class,              \n")
		  .append ("    SUBSTR(t2.teams,1,2) AS teams,                              \n")
		  .append ("    t2.tour_no AS tour_no,                                      \n")
		  .append ("    RTRIM(t3.last_nm)||' '||RTRIM(t3.first_nm) AS cust_nm,      \n")
		  .append ("    t3.birthday AS birthday,                                    \n")
		  .append ("    '' AS regi_no,                                              \n")
		  .append ("    CASE WHEN t3.sex='M' THEN '○' ELSE '' END AS m_sex_chk,    \n")
		  .append ("    CASE WHEN t3.sex='F' THEN '○' ELSE '' END AS f_sex_chk,    \n")
		  .append ("    sales.fn_country_eng_nm(t3.country_cd) AS country_cd,       \n")
		 .append ("    t3.pass_no AS unity_no,                                    \n")
		  //.append ("    t2.unity_no AS unity_no,                                    \n")
		  .append ("    '*'||t2.unity_no||'*' AS unity_no1,                         \n")
		  .append ("    t3.eng_addr1 AS address1,                                  \n")
		  .append ("    t3.tel_no AS tel_no,                                        \n")
		  .append ("    t3.eng_company_nm||' '||t3.eng_position AS conpany_nm,      \n")
		  .append ("    '' AS tour_obj,                                             \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'3') AS start_end,        \n")
		  .append ("    sales.fn_tour_saup_cd(t1.saup_sid,'4') AS end_start,        \n")
		  .append ("    t4.eng_nm AS goods_nm                                       \n")
		  .append (" FROM sales.trv010 t1, sales.trv020 t2,                         \n")
		  .append ("      sales.tcu010 t3 LEFT OUTER JOIN sales.tsy110 t5 ON t3.zip_sid=t5.zip_sid, \n")
		  .append ("      sales.trm200 t4                                           \n")
		  .append (" WHERE t1.accept_sid=t2.accept_sid                              \n")
		  .append (" AND t2.cust_sid=t3.cust_sid                                    \n")
		  .append (" AND t1.goods_sid=t4.goods_sid                                  \n")
		  .append (" AND t2.status_cd IN('RA','RR','DP','AR')                            \n");		
		
    }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		try {
			// 검색시 조건
			int 	sSaupSid = HDUtil.nullCheckNum(greq.getParameter("sSaupSid"));
			String  sDepartDate = HDUtil.nullCheckStr(greq.getParameter("sDepartDate"));
			String  sDepartTime = HDUtil.nullCheckStr(greq.getParameter("sDepartTime"));
			int 	sGoodsSid = HDUtil.nullCheckNum(greq.getParameter("sGoodsSid"));
			String  sClass = HDUtil.nullCheckStr(greq.getParameter("sClass"));
			String  sTeams = HDUtil.nullCheckStr(greq.getParameter("sTeams"));
			String  sCountryGu = HDUtil.nullCheckStr(greq.getParameter("sCountryGu"));
			String  sManageNo = HDUtil.nullCheckStr(greq.getParameter("sManageNo"));

			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int j=0; j<dSets.length;j++){	
				if(dSets[j].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							if(sCountryGu.equals("10")||sCountryGu.equals("20")) {
//							if(sCountryGu.equals("10")) {
								if(sSaupSid!=0)
									arr_sql[0].append(" AND t1.saup_sid=? \n");
								if(!sDepartDate.equals(""))
									arr_sql[0].append(" AND t2.depart_date=? \n");
								if(!sDepartTime.equals(""))
									arr_sql[0].append(" AND t2.depart_time=? \n");
								if(sGoodsSid!=0)
									arr_sql[0].append(" AND t1.goods_sid=? \n");
								if(!sClass.equals(""))
									arr_sql[0].append(" AND t2.class=? \n");
								if(!sTeams.equals(""))
									arr_sql[0].append(" AND t2.teams=? \n");
								if(!sCountryGu.equals(""))
									arr_sql[0].append(" AND t3.country_gu=? \n");
								if(!sManageNo.equals(""))
									arr_sql[0].append(" AND t3.manage_no=? \n");

								arr_sql[0].append(" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
								cstmt = conn.prepareCall(arr_sql[0].toString());
							
								if(sSaupSid!=0)
									cstmt.setInt(sCnt1++, sSaupSid);
								if(!sDepartDate.equals(""))
									cstmt.setString(sCnt1++, sDepartDate);
								if(!sDepartTime.equals(""))
									cstmt.setString(sCnt1++, sDepartTime);
								if(sGoodsSid!=0)
									cstmt.setInt(sCnt1++, sGoodsSid);
								if(!sClass.equals(""))
									cstmt.setString(sCnt1++, sClass);
								if(!sTeams.equals(""))
									cstmt.setString(sCnt1++, sTeams);
								if(!sCountryGu.equals(""))
									cstmt.setString(sCnt1++, sCountryGu);
								if(!sManageNo.equals(""))
									cstmt.setString(sCnt1++, sManageNo);
								
								rs = cstmt.executeQuery(); // DataSet set
								gos.write(getDataSet(rs, ds1));
								
							} else {
								if(sSaupSid!=0)
									arr_sql[1].append(" AND t1.saup_sid=? \n");
								if(!sDepartDate.equals(""))
									arr_sql[1].append(" AND t2.depart_date=? \n");
								if(!sDepartTime.equals(""))
									arr_sql[1].append(" AND t2.depart_time=? \n");
								if(sGoodsSid!=0)
									arr_sql[1].append(" AND t1.goods_sid=? \n");
								if(!sClass.equals(""))
									arr_sql[1].append(" AND t2.class=? \n");
								if(!sTeams.equals(""))
									arr_sql[1].append(" AND t2.teams=? \n");
								if(!sCountryGu.equals(""))
									arr_sql[1].append(" AND t3.country_gu=? \n");
								if(!sManageNo.equals(""))
									arr_sql[1].append(" AND t3.manage_no=? \n");

								arr_sql[1].append(" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
								cstmt = conn.prepareCall(arr_sql[1].toString());
							
								if(sSaupSid!=0)
									cstmt.setInt(sCnt1++, sSaupSid);
								if(!sDepartDate.equals(""))
									cstmt.setString(sCnt1++, sDepartDate);
								if(!sDepartTime.equals(""))
									cstmt.setString(sCnt1++, sDepartTime);
								if(sGoodsSid!=0)
									cstmt.setInt(sCnt1++, sGoodsSid);
								if(!sClass.equals(""))
									cstmt.setString(sCnt1++, sClass);
								if(!sTeams.equals(""))
									cstmt.setString(sCnt1++, sTeams);
								if(!sCountryGu.equals(""))
									cstmt.setString(sCnt1++, sCountryGu);
								if(!sManageNo.equals(""))
									cstmt.setString(sCnt1++, sManageNo);
								
								rs = cstmt.executeQuery(); // DataSet set
								gos.write(getDataSet(rs, ds1));
							}

							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();

						break;
						
						case 2:
						int sCnt2 = 1;
						if(sCountryGu.equals("10")||sCountryGu.equals("20")) {
//						if(sCountryGu.equals("10")) {
							if(sSaupSid!=0)
								arr_sql[2].append(" AND t1.saup_sid=? \n");
							if(!sDepartDate.equals(""))
								arr_sql[2].append(" AND t2.depart_date=? \n");
							if(!sDepartTime.equals(""))
								arr_sql[2].append(" AND t2.depart_time=? \n");
							if(sGoodsSid!=0)
								arr_sql[2].append(" AND t1.goods_sid=? \n");
							if(!sClass.equals(""))
								arr_sql[2].append(" AND t2.class=? \n");
							if(!sTeams.equals(""))
								arr_sql[2].append(" AND t2.teams=? \n");
							if(!sCountryGu.equals(""))
								arr_sql[2].append(" AND t3.country_gu=? \n");
							if(!sManageNo.equals(""))
								arr_sql[2].append(" AND t3.manage_no=? \n");

							arr_sql[2].append(" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
							
							//StringUtil.printMsg("출력 내국인 쿼리 ", arr_sql[2].toString(),this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
						
							if(sSaupSid!=0)
								cstmt.setInt(sCnt2++, sSaupSid);
							if(!sDepartDate.equals(""))
								cstmt.setString(sCnt2++, sDepartDate);
							if(!sDepartTime.equals(""))
								cstmt.setString(sCnt2++, sDepartTime);
							if(sGoodsSid!=0)
								cstmt.setInt(sCnt2++, sGoodsSid);
							if(!sClass.equals(""))
								cstmt.setString(sCnt2++, sClass);
							if(!sTeams.equals(""))
								cstmt.setString(sCnt2++, sTeams);
							if(!sCountryGu.equals(""))
								cstmt.setString(sCnt2++, sCountryGu);
							if(!sManageNo.equals(""))
								cstmt.setString(sCnt2++, sManageNo);
							
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1));
						} else {
							if(sSaupSid!=0)
								arr_sql[3].append(" AND t1.saup_sid=? \n");
							if(!sDepartDate.equals(""))
								arr_sql[3].append(" AND t2.depart_date=? \n");
							if(!sDepartTime.equals(""))
								arr_sql[3].append(" AND t2.depart_time=? \n");
							if(sGoodsSid!=0)
								arr_sql[3].append(" AND t1.goods_sid=? \n");
							if(!sClass.equals(""))
								arr_sql[3].append(" AND t2.class=? \n");
							if(!sTeams.equals(""))
								arr_sql[3].append(" AND t2.teams=? \n");
							if(!sCountryGu.equals(""))
								arr_sql[3].append(" AND t3.country_gu=? \n");
							if(!sManageNo.equals(""))
								arr_sql[3].append(" AND t3.manage_no=? \n");

							arr_sql[3].append(" ORDER BY t2.depart_time,t4.goods_cd,t2.class,t2.teams,t2.tour_no,t2.rsv_sid \n");
							cstmt = conn.prepareCall(arr_sql[3].toString());
						
							if(sSaupSid!=0)
								cstmt.setInt(sCnt2++, sSaupSid);
							if(!sDepartDate.equals(""))
								cstmt.setString(sCnt2++, sDepartDate);
							if(!sDepartTime.equals(""))
								cstmt.setString(sCnt2++, sDepartTime);
							if(sGoodsSid!=0)
								cstmt.setInt(sCnt2++, sGoodsSid);
							if(!sClass.equals(""))
								cstmt.setString(sCnt2++, sClass);
							if(!sTeams.equals(""))
								cstmt.setString(sCnt2++, sTeams);
							if(!sCountryGu.equals(""))
								cstmt.setString(sCnt2++, sCountryGu);
							if(!sManageNo.equals(""))
								cstmt.setString(sCnt2++, sManageNo);
							
							rs = cstmt.executeQuery(); // DataSet set
							gos.write(getDataSet(rs, ds1));
						}

						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
					break;
					}
				}
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
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}