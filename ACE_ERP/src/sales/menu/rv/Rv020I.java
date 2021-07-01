package sales.menu.rv;

import java.sql.*;

import javax.servlet.ServletException;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Rv020I extends SuperServlet {
    public void makeSql(){
        for(int i=0; i<arr_sql.length; i++)
           arr_sql[i] = new StringBuffer();

		arr_sql[0].append ("SELECT  R1.MENU_SID,                                                                            /* 안보이게(자동증가)			*/	\n")
				  .append ("        R1.MENU_CD,                                                                             /* 메뉴코드                     */	\n")
				  .append ("        R1.MENU_NM,                                                                             /* 메뉴명                       */	\n")
				  .append ("        R1.MENU_GUBUN_CD                                                   AS MENU_GUBUN_CD,    /* No Visible                   */	\n")
				  .append ("        R1.MENU_ITEM1                                                      AS MENU_ITEM1,       /* 고객유형                     */	\n")
				  .append ("        R1.MENU_ITEM2                                                      AS MENU_ITEM2,       /* 요금 구분                    */	\n")
				  .append ("        R1.MENU_ITEM3                                                      AS MENU_ITEM3,       /* 숙소구분                     */	\n")
				  .append ("        1                                                                  AS MENU_ITEM4,       /* No Visible                   */	\n")
				  .append ("        1                                                                  AS MENU_ITEM5,       /* No Visible                   */	\n")
				  .append ("        0                                                                  AS BGN_PERSONS,      /* No Visible                   */	\n")
				  .append ("        0                                                                  AS END_PERSONS,      /* No Visible                   */	\n")
				  .append ("        R1.BGN_DATE                                                        AS BGN_DATE,         /* 시작일자                     */	\n")
				  .append ("        R1.END_DATE                                                        AS END_DATE,         /* 종료일자                     */	\n")
				  .append ("        R1.MENU_ENG_NM                                                     AS MENU_ENG_NM,      /* 메뉴영문명                   */	\n")
				  .append ("        R1.MENU_SHORT_NM                                                   AS MENU_SHORT_NM,    /* 메뉴단축명                   */	\n")
				  .append ("        CASE WHEN R1.TAX_YN='N' THEN 'F' WHEN R1.TAX_YN='Y' THEN 'T' END   AS TAX_YN,           /* 과세여부                     */	\n")
				  .append ("        R1.TAX_CALCU_CD                                                    AS TAX_CALCU_CD,     /* No Visible                   */	\n")
				  .append ("        R1.UNIT_AMT                                                        AS UNIT_AMT,         /* 단가                         */	\n")
				  .append ("        R1.NET_AMT                                                         AS NET_AMT,          /* No Visible                   */	\n")
				  .append ("        R1.VAT_AMT                                                         AS VAT_AMT,          /* No Visible                   */	\n")
				  .append ("        R1.EXCISE_AMT                                                      AS EXCISE_AMT,       /* No Visible                   */	\n")
				  .append ("        R1.EDU_AMT                                                         AS EDU_AMT,          /* No Visible                   */	\n")
				  .append ("        R1.VILLAGE_AMT                                                     AS VILLAGE_AMT,      /* No Visible                   */	\n")
				  .append ("        R1.SPORTS_AMT                                                      AS SPORTS_AMT,       /* No Visible                   */	\n")
				  .append ("        R1.TOUR_AMT                                                        AS TOUR_AMT,         /* No Visible                   */	\n")
				  .append ("        R1.ASSOC_AMT                                                       AS ASSOC_AMT,        /* No Visible                   */	\n")
				  .append ("        R1.TIP_AMT                                                         AS TIP_AMT,          /* No Visible                   */	\n")
				  .append ("        CASE WHEN R1.USE_YN='N' THEN 'F' WHEN R1.USE_YN='Y' THEN 'T' END   AS USE_YN ,          /* 사용여부                     */	\n")
				  .append ("        R1.SAUP_SID                                                        AS SAUP_SID,         /* No Visible 영업장SID         */	\n")
				  .append ("        R1.UPJANG_SID                                                      AS UPJANG_SID,       /* No Visible 업장SID           */	\n")
				  .append ("        SALES.FN_DETAIL_NM('RV003', R1.MENU_ITEM1)                         AS MENU_ITEM1_NM     /* 고객유형명                   */	\n")
				  .append ("  FROM  SALES.TRV100 R1                                                                                                           	\n")
				  .append (" WHERE  1 = 1                                                                                                                     	\n");
		
		arr_sql[1].append ("INSERT INTO SALES.TRV100  											\n")
				  .append ("	(                                                               \n")
				  .append ("		  MENU_CD			, MENU_NM			, MENU_GUBUN_CD     \n")
				  .append ("		, MENU_ITEM1		, MENU_ITEM2		, MENU_ITEM3        \n")
				  .append ("		, MENU_ITEM4		, MENU_ITEM5		, BGN_PERSONS       \n")
				  .append ("		, END_PERSONS		, BGN_DATE			, END_DATE          \n")
				  .append ("		, MENU_ENG_NM		, MENU_SHORT_NM		, TAX_YN            \n")
				  .append ("		, TAX_CALCU_CD		, UNIT_AMT			, NET_AMT           \n")
				  .append ("		, VAT_AMT			, EXCISE_AMT		, EDU_AMT           \n")
				  .append ("		, VILLAGE_AMT		, SPORTS_AMT		, TOUR_AMT          \n")
				  .append ("		, ASSOC_AMT			, TIP_AMT			, USE_YN            \n")
				  .append ("		, SAUP_SID			, UPJANG_SID		, U_EMPNO           \n")
				  .append ("        , U_DATE			, U_IP                                  \n")
				  .append ("	)                                                               \n")
				  .append ("VALUES (                                                            \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("	?, ?, ?, ?, ?, ?,                                               \n")
				  .append ("    CURRENT_TIMESTAMP,?                                             \n")
				  .append ("       )                                                            \n");
		
		arr_sql[2].append ("UPDATE SALES.TRV100 					\n")
				  .append ("	SET                                 \n")
				  .append ("		  MENU_CD			= ?         \n")
				  .append ("		, MENU_NM			= ?         \n")
				  .append ("		, MENU_GUBUN_CD		= ?         \n")
				  .append ("		, MENU_ITEM1		= ?         \n")
				  .append ("		, MENU_ITEM2		= ?         \n")
				  .append ("		, MENU_ITEM3		= ?         \n")
				  .append ("		, MENU_ITEM4		= ?         \n")
				  .append ("		, MENU_ITEM5		= ?         \n")
				  .append ("		, BGN_PERSONS		= ?         \n")
				  .append ("		, END_PERSONS		= ?         \n")
				  .append ("		, BGN_DATE			= ?         \n")
				  .append ("		, END_DATE          = ?         \n")
				  .append ("		, MENU_ENG_NM		= ?         \n")
				  .append ("		, MENU_SHORT_NM		= ?         \n")
				  .append ("		, TAX_YN            = ?         \n")
				  .append ("		, TAX_CALCU_CD		= ?         \n")
				  .append ("		, UNIT_AMT			= ?         \n")
				  .append ("		, NET_AMT           = ?         \n")
				  .append ("		, VAT_AMT			= ?         \n")
				  .append ("		, EXCISE_AMT		= ?         \n")
				  .append ("		, EDU_AMT           = ?         \n")
				  .append ("		, VILLAGE_AMT		= ?         \n")
				  .append ("		, SPORTS_AMT		= ?         \n")
				  .append ("		, TOUR_AMT          = ?         \n")
				  .append ("		, ASSOC_AMT			= ?         \n")
				  .append ("		, TIP_AMT			= ?         \n")
				  .append ("		, USE_YN            = ?         \n")
				  .append ("		, SAUP_SID			= ?         \n")
				  .append ("		, UPJANG_SID		= ?         \n")
				  .append ("		, U_EMPNO           = ?         \n")
				  .append ("        , U_DATE = CURRENT_TIMESTAMP    \n")
				  .append ("		, U_IP              = ?         \n")
				  .append ("WHERE MENU_SID = ?		                \n");
			
		arr_sql[3].append ("DELETE FROM SALES.TRV100 	\n")
				  .append ("WHERE MENU_SID = ?			\n");
    }

    public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
    	
    }

    //  조회 method
    public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		try {
			ds1 = req.getGauceDataSet("DEFAULT");

			int 	v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
			int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
			String	v_cust		 	= HDUtil.nullCheckStr(req.getParameter("v_cust"));
			String	v_date			= HDUtil.nullCheckStr(req.getParameter("v_date"));		//date INFO

			if(ds1!=null){
				res.enableFirstRow(ds1);
				int sCnt = 1;

				if (v_saup_sid!=0)
					arr_sql[0].append ("	AND R1.SAUP_SID = ?			\n");
				if (v_upjang_sid!=0) 
					arr_sql[0].append ("	AND R1.UPJANG_SID = ? 		\n");
				if(!v_cust.equals(""))
					arr_sql[0].append ("	AND R1.MENU_ITEM1 = ? 		\n");
				if (!"".equals(v_date))
					arr_sql[0].append ("	AND ? BETWEEN R1.BGN_DATE AND R1.END_DATE	\n");	//이용일자 추가
									
				arr_sql[0].append (" ORDER BY R1.MENU_ITEM1, R1.MENU_CD 		\n");
				stmt = conn.getGauceStatement(arr_sql[0].toString());
				
				if (v_saup_sid!=0)
					stmt.setInt(sCnt++, v_saup_sid);
				if (v_upjang_sid!=0) 
					stmt.setInt(sCnt++, v_upjang_sid);
				if(!v_cust.equals(""))
					stmt.setString(sCnt++, v_cust);
				if (!"".equals(v_date))
					stmt.setString(sCnt++, v_date);
					
				rs = stmt.executeQuery();
				getDataSet(rs, ds1).flush();

				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
			}
		} catch (SQLException sqle){
		    res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		    throw sqle;
		} catch (Exception e) {
		    res.writeException("ERROR", "", e.toString());
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
		    if(stmt!=null) stmt.close();
		}
    }
    public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceStatement stmt = null;
		ResultSet rs = null;
    	
		/* DataSet */
		GauceDataSet ds1 = null;
		try {
			ds1 = req.getGauceDataSet("DEFAULT");
			if(ds1!=null){
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[]   cols = ds1.getDataColumns();
				
				// Grid 첫번째 
				for(int i = 0; i < rows.length; i++) {
					// 입력 
					int j = 1;
					switch(rows[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							stmt = conn.getGauceStatement(arr_sql[1].toString());
							
							for(j=1; j<30; j++){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ){
									stmt.setInt(j, rows[i].getInt(j));
								} else {
									if(j==15 || j==27)
										stmt.setString(j, rows[i].getString(j).equals("T") ? "Y" : "N");
									else
										stmt.setString(j, rows[i].getString(j).trim());
								}
							}
							stmt.setString(j++, fParamEmpno);		// 수정자 사번 
							stmt.setString(j++, fParamIp);			// 수정자 ip
							
							stmt.executeUpdate();
							if(stmt!=null) stmt.close();
							break;
						case GauceDataRow.TB_JOB_UPDATE:
							stmt = conn.getGauceStatement(arr_sql[2].toString());
							for(j=1; j<30; j++){
								if(cols[j].getColType()== GauceDataColumn.TB_NUMBER ){
									stmt.setInt(j, rows[i].getInt(j));
								} else {
									if(j==15 || j==27)
										stmt.setString(j, rows[i].getString(j).equals("T") ? "Y" : "N");
									else
										stmt.setString(j, rows[i].getString(j));
								}
							}
							stmt.setString(j++, fParamEmpno);		// 수정자 사번 
							stmt.setString(j++, fParamIp);			// 수정자 ip
							stmt.setInt(j++, rows[i].getInt(0));	// 					
							
							stmt.executeUpdate();
							if(stmt!=null) stmt.close();
							break;
						case GauceDataRow.TB_JOB_DELETE:
							stmt = conn.getGauceStatement(arr_sql[3].toString());
							stmt.setInt(1, rows[i].getInt(0));
							
							stmt.executeUpdate();
							if(stmt!=null) stmt.close();
							break;
					}
				}
			}
		} catch (SQLException sqle){
		    res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		    throw sqle;
		} catch (Exception e) {
		    res.writeException("ERROR", "", e.toString());
		    throw e;
		} finally {
		    if(rs!=null) rs.close();
		    if(stmt!=null) stmt.close();
		}
    }

}
