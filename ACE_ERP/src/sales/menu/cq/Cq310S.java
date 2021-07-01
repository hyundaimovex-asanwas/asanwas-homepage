package sales.menu.cq;

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

public class Cq310S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * 대리점 조회
		 */
		arr_sql[1].append("")
					.append("SELECT  																					\n")
					.append("	CASE WHEN T3.COUNTRY_GU = '10' THEN														\n")							
					.append("    	T3.COMPANY_NM 																		\n")
					.append("	ELSE																					\n")
					.append("    	CASE WHEN T3.ENG_COMPANY_NM = null  THEN												\n")
					.append("         	T3.COMPANY_NM 																	\n")
					.append("    	ELSE																				\n")
					.append("         	RTRIM(T3.COMPANY_NM)|| '(' ||RTRIM(T3.ENG_COMPANY_NM)||')'						\n")
					.append("    	END																					\n")
					.append("	END                                                                   AS  COMPANY_NM 	\n")     /* 소속   */
					.append("	,CASE WHEN T3.COUNTRY_GU = '10' THEN													\n")
					.append(" 	        T3.POSITIONS																	\n")
					.append("	ELSE																					\n")
					.append("	    CASE WHEN T3.ENG_POSITION = null  THEN												\n")
					.append("	         T3.POSITIONS																	\n")
					.append("	    ELSE																				\n")
					.append("	         RTRIM(T3.POSITIONS)|| '(' ||RTRIM(T3.ENG_POSITION)||')'						\n")
					.append("    	END																					\n")
					.append("	END                                                                  AS  POSITIONS  	\n")     /* 직책   */
					.append("	,CASE WHEN T3.COUNTRY_GU = '10' THEN													\n")
					.append("	    T3.CUST_NM																			\n")
					.append("	ELSE																					\n")
					.append("	    CASE WHEN T3.FIRST_NM = null  AND T3.LAST_NM = null THEN								\n")
					.append("	         T3.CUST_NM																		\n")
					.append("	    ELSE																				\n")
					.append("	         RTRIM(T3.CUST_NM)|| '(' ||T3.FIRST_NM||' '||T3.LAST_NM||')'					\n")
					.append("	    END																					\n")
					.append("	END                                                                  AS  CUST_NM   		\n")      /* 성명         */
					.append("      ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS  SEX								\n")             /* 성별 :SY009  */
					.append("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN										\n")
					.append("            SUBSTR(T3.REGI_NO,1,6)||'-'||													\n")
					.append("            SUBSTR(T3.REGI_NO,7,7)															\n")
					.append("       ELSE																				\n")
					.append("            T3.PASS_NO||'('||																\n")
					.append("            SUBSTR(T3.BIRTHDAY,1,4)||'.'||													\n")
					.append("            SUBSTR(T3.BIRTHDAY,5,2)||'.'||													\n")
					.append("            SUBSTR(T3.BIRTHDAY,7,2)||')'													\n")
					.append("       END                                         AS  REGI_NO								\n")         /* 주민등록번호 */
					.append("     ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                     														\n")
					//주소 부르는 부분 수정 by 20140206 심동현
					.append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
					//.append("          RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))				\n")                           
					.append("      ELSE																												\n")
					.append("           T3.ADDRESS1                                    																\n")                               
					.append ("          END                                            AS ADDRESS1                                            \n")    
					.append("     ,T3.CUST_SID, T3.CUST_GU, T3.COUNTRY_GU, T3.COUNTRY_CD								\n")
					.append("      ,RTRIM(SALES.FN_DETAIL_NM('RV017',T2.CLASS))||'/'||T2.TEAMS							\n")
					.append("                                                      AS  CAR_NO							\n")         /* 답승차량      */
					.append("      ,SUBSTR(T3.BIRTHDAY,1,4)||'.'||														\n")
					.append("       SUBSTR(T3.BIRTHDAY,5,2)||'.'||														\n")
					.append("       SUBSTR(T3.BIRTHDAY,7,2)                     AS  BIRTHDAY							\n")       /* 생년월일      */
					.append("      ,RTRIM(SALES.FN_DETAIL_NM('RV017', T2.CLASS))   AS  CLASS							\n")          /* 반            */
					.append("      ,T2.TEAMS                                       AS  TEAMS							\n")          /* 조            */
					.append("      ,T2.TOUR_NO                                     AS  TOUR_NO							\n")        /* 순번(관광증번호) */
					.append("      ,SALES.FN_CUST_GU(T2.RSV_SID, 'SN')           AS  ETC								\n")             /* 비고         */
					.append("  FROM SALES.TRV010 T1																		\n")
					.append("      ,SALES.TRV020 T2  													\n")
					.append("      ,SALES.TCU010 T3    												\n")
					.append("      ,SALES.TRM200 T4																		\n")
					.append(" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID														\n")
					.append("   AND T2.CUST_SID    = T3.CUST_SID														\n")
					.append("   AND T1.GOODS_SID   = T4.GOODS_SID														\n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		int v_rowcnt = 0;

		/*
		 * 검색시 필요한 조건
		 */
		
		String sSaup_sid 	= HDUtil.nullCheckStr(greq.getParameter("sSaup_sid"));	// 사업소
		String sDepart_date = HDUtil.nullCheckStr(greq.getParameter("sDepart_date")); 	// 출경일자
		String sDepart_time = HDUtil.nullCheckStr(greq.getParameter("sDepart_time")); 	// 출경시간 
		String sGoods_sid 	= HDUtil.nullCheckStr(greq.getParameter("sGoods_sid"));			// 상품SID 
		String sClass		= HDUtil.nullCheckStr(greq.getParameter("sClass")); //반
		String sTeam		= HDUtil.nullCheckStr(greq.getParameter("sTeam"));  //조
		String sJobsel		= HDUtil.nullCheckStr(greq.getParameter("sJobsel")); //신분
		String sCustNm		= HDUtil.nullCheckStr(greq.getParameter("sCustNm")); //신분
		
		//StringUtil.printMsg("사업소====",sSaup_sid,this);
		//StringUtil.printMsg("출경일자==",sDepart_date,this);
		//StringUtil.printMsg("출경시간==",sDepart_time,this);
		//StringUtil.printMsg("상품SID==",sGoods_sid+"",this);
		//StringUtil.printMsg("반=======",sClass+"",this);
		//StringUtil.printMsg("조=======",sTeam+"",this);
		//StringUtil.printMsg("신분======",sJobsel+"",this);
		
		try {
			int sCnt1 = 1;
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DEFAULT=ds_default,O: MASTER=ds_master	DATE=ds_date
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					
						if (!"".equals(sSaup_sid)) { 
							arr_sql[1].append("   AND T1.SAUP_SID    = ?																	\n");	/* 사업소 										*/
						}
						if (!"".equals(sDepart_date)) {
							arr_sql[1].append("   AND T2.DEPART_DATE = ?																	\n");	/* 출경일자 										*/
						}
						if (!"".equals(sDepart_time)) { 
							arr_sql[1].append("   AND T2.DEPART_TIME = ?																	\n");	/* 출경시간 										*/ 
						}
						
						if (!"0".equals(sGoods_sid)) {
							arr_sql[1].append("   AND T1.GOODS_SID   = ?															\n");	/* 상품SID  										*/
						}
						if (!"".equals(sClass)) {
							arr_sql[1].append("   AND T2.CLASS   = ?																	\n");	/* 상품SID  										*/
						}
						if (!"".equals(sTeam)) {
							arr_sql[1].append("   AND T2.TEAMS   = ?																	\n");	/* 상품SID  										*/
						}
						if (!"".equals(sCustNm)) {
							arr_sql[1].append("   AND T3.CUST_NM = ?			\n");	/* 고객명	*/
						}
						if (!"".equals(sJobsel)) {
							arr_sql[1].append("AND ( ("+sJobsel+"=''							)	\n")
									.append("OR ("+sJobsel+"='1' AND T2.CUST_GU='1'               )	\n")
									.append("OR ("+sJobsel+"='2' AND T2.CUST_GU='2' AND T2.SAUP_GU NOT IN ('50','55') )	\n")
									.append("OR ("+sJobsel+"='3' AND T2.CUST_GU='2' AND T2.SAUP_GU IN ('50','55') ) ) 	\n");  										
						}
						
						arr_sql[1].append("   AND T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR')														\n")	/* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */
							.append("ORDER BY T2.CLASS																						\n")
							.append("        ,T2.TEAMS																						\n")
							.append("        ,T2.TOUR_NO																					\n")
							.append("        ,T2.RSV_SID																					\n");  
		
				  		// 쿼리 실행
				  		 
						
						cstmt = conn.prepareCall(arr_sql[1].toString()); 
				  		//StringUtil.printMsg("쿼리",arr_sql[1].toString(),this);
				  		// 조건
				  		if (!"".equals(sSaup_sid)) {
					  		cstmt.setInt(sCnt1++, Integer.parseInt(sSaup_sid));		// 사업소
					  		 
						}
						if (!"".equals(sDepart_date)) { 
							cstmt.setString(sCnt1++, sDepart_date );			// 출경일자 
						}
						if (!"".equals(sDepart_time)) { 
					  		 cstmt.setString(sCnt1++, sDepart_time);				// 출경시간 
						}
						if (!"0".equals(sGoods_sid)) {
					  		 cstmt.setInt(sCnt1++, Integer.parseInt(sGoods_sid));				// 상품SID 
						}
						if (!"".equals(sClass)) { 
					  		 cstmt.setString(sCnt1++, sClass);				// 출경시간 
						}
						if (!"".equals(sTeam)) { 
					  		 cstmt.setString(sCnt1++, sTeam);
						}
						if (!"".equals(sCustNm)) {
							cstmt.setString(sCnt1++, sCustNm);
						}
				
						rs = cstmt.executeQuery(); 
						gos.write(getDataSet(rs, ds1));// DataSet set
//						if (!"".equals(sJobsel)) { 
//					  		 stmt.setString(sCnt1++, sJobsel);
//						}
						
					}
					//StringUtil.printMsg("사업소====",sSaup_sid,this);
					//StringUtil.printMsg("출경일자==",sDepart_date,this);
					//StringUtil.printMsg("출경시간==",sDepart_time,this);
					//StringUtil.printMsg("상품SID==",sGoods_sid+"",this);
					//StringUtil.printMsg("반=======",sClass+"",this);
					//StringUtil.printMsg("조=======",sTeam+"",this);
					//StringUtil.printMsg("신분======",sJobsel+"",this);
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
		// TODO Auto-generated method stub
	}
}