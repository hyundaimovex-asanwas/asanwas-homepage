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

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;


public class Cq010S extends SuperServlet {

	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		arr_sql[0].append ("  SELECT																										\n")
				  .append (" 		  T2.TOUR_NO                                     AS TOUR_NO    /* 순번          */                      \n")
				 
				  
//				  .append ("         ,T2.CLASS                                       AS CLASS      /* 반            */                      \n")
				  .append ("          ,SALES.FN_DETAIL_NM ('RV017', T2.CLASS) AS CLASS \n")
				  
				  .append ("         ,T2.TEAMS                                       AS TEAMS      /* 조            */                      \n")
				  .append ("         ,T2.CUST_SID                                    AS CUST_SID   /* 고객 SID      */                      \n")
				  
//				  .append ("         ,T3.CUST_NM                                     AS CUST_NM    /* 이름          */                      \n")
				  .append (" 		,CASE WHEN T3.COUNTRY_GU = '10' THEN T3.CUST_NM 														\n")
				  .append ("         ELSE 																									\n")
				  .append ("         		RTRIM(T3.CUST_NM) || ' ' || RTRIM(T3.FIRST_NM) || ' ' || RTRIM(T3.LAST_NM) 						\n")
				  .append ("		 END											AS CUST_NM 												\n")	
				  
				  .append ("         ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS SEX        /* 성별 :SY009   */                      \n")
				  .append ("         ,T3.BIRTHDAY                                    AS BIRTHDAY   /* 생년월일      */                      \n")
				  .append ("         ,T3.COMPANY_NM || ' ' ||T3.POSITIONS            AS COMP_NM    /*  직장/직위1	*/                      \n")
				  
				  .append ("         ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                                          \n")
				  //주소 부르는 부분 수정 by 20140206 심동현
				  .append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
				  //.append("            SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2,1, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' '))					\n")
				  //.append("          ||SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1 ,   				\n")
				  //.append("          LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ', LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1  ))  	\n")  
				  .append ("          ELSE                                                                                                  \n")
				  .append ("               T3.ADDRESS1                                                                                      \n")
				  .append ("          END                                            AS ADDRESS1                                            \n")
				 
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD))                          			\n")
				  .append("		   END			 AS COUNTRY_CD 																						\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))                                         			\n")
				  .append("		   END			 AS NATION_CD 																						\n")
				  .append ("         ,T3.PASS_NO                                     AS PASS_NO    /* 여권번호		*/                      \n")
				  
				  .append ("      ,CASE WHEN T2.STATUS_CD IN ('RC','NS') THEN                                             			\n")
				  .append ("            '취소'                                                                                  			\n")
				  .append("		   END AS STATUS_CD 																						\n")
				  
				  
				  .append ("  FROM SALES.TRV010 T1                                                                                          \n")
				  .append ("      ,SALES.TRV020 T2                                                                                          \n")
				  .append ("      ,SALES.TCU010 T3 LEFT OUTER JOIN  SALES.TSY110 T5 ON  T3.ZIP_SID    = T5.ZIP_SID                          \n")
				  .append (" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID                                                                           \n")
				  .append ("   AND T2.CUST_SID    = T3.CUST_SID                                                                             \n")
				  
				  .append ("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR'))   /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */     \n")
				  .append ("    OR (T2.STATUS_CD IN ('RC', 'NS')  AND T2.TOUR_NO <> ''))															\n")
				  .append("   AND T2.SAUP_GU     <> '65'																							\n");
		
		arr_sql[1].append ("SELECT 																										\n")
				  .append ("       T2.DEPART_DATE||T2.CLASS||T4.GOODS_CD||T2.TEAMS          AS PAGE_SKIP   /* PAGE를 넘기는 변수 */   			\n")
				  .append ("      ,CASE WHEN T1.SAUP_SID = 1 THEN '금강산 관광객 명단          '	\n")
				  .append ("            WHEN T1.SAUP_SID = 2 THEN '개성 관광객 명단         '	\n")
				  .append ("            END  AS DOC_TITLE    /* 문서 제목 (2007.08.10 심동현 추가)    */         			\n")
				  .append ("      ,T4.GOODS_NM                                    AS GOODS_NM    /* 상품명       */         			\n")
				  .append ("      ,T2.DEPART_DATE                                 AS DEPART_DATE /* 출경일자 */             			\n")
				  .append ("      ,T2.ARRIVE_DATE                                 AS ARRIVE_DATE /* 입경일자 */             			\n")
				  .append ("      ,T2.TOUR_NO                                     AS TOUR_NO     /* 순번         */         			\n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'RV017',T2.CLASS)         AS CLASS       /* 반           */         			\n")
				  .append ("      ,T2.TEAMS                                                        /* 조           */       			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            T3.CUST_NM                                                                          			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       END                                            AS CUST_NM1 /* 성명1        */            			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.CUST_NM                                                                          			\n")
				  .append ("       END                                            AS CUST_NM2 /* 성명2        */            			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.FIRST_NM||' '||T3.LAST_NM                                                        			\n")
				  .append ("       END                                            AS CUST_ENM /* 영문성명     */            			\n")
				  .append ("      ,SALES.FN_DETAIL_NM ( 'SY009',T3.SEX)           AS SEX              /* 성별 :SY009  */          			\n")
				  .append ("      ,T3.BIRTHDAY                                                  /* 생년월일     */          			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            T3.COMPANY_NM || ' ' ||T3.POSITIONS                                                 			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       END                                            AS COMP_NM1 /* 직장/직위1   */            			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.COMPANY_NM || ' ' ||T3.POSITIONS                                                 			\n")
				  .append ("       END                                            AS COMP_NM2 /* 직장/직위2   */            			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.ENG_COMPANY_NM||' '||T3.ENG_POSITION                                             			\n")
				  .append ("       END                                            AS COMP_ENM /* 영문직장/직위*/            			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("             SUBSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ',1, INSTR(RTRIM(T3.ADDRESS1)||' '||T3.ADDRESS2||' ' , ' ',1,2)-1 )	\n")
				  //.append ("           RTRIM(T5.ADDRESS1) ||' '|| SUBSTRING(RTRIM(T5.ADDRESS2),1, POSITION (' ' IN T5.ADDRESS2||' '))	\n")
				  //.append("            SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2,1, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' '))					\n")
				  //.append("          ||SUBSTRING(T5.ADDRESS1 ||' '||T5.ADDRESS2, LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1 ,   				\n")
				  //.append("          LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ', LOCATE (' ',T5.ADDRESS1 ||' '||T5.ADDRESS2||' ') + 1  ))  	\n")  
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.ADDRESS1                                                                         			\n")
				  .append ("       END                                            AS ADDRESS1 /* 사는 곳       */           			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.COUNTRY_CD))                          			\n")
				  .append("		   END			 AS COUNTRY_CD 																						\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            RTRIM(SALES.FN_DETAIL_NM ( 'SY005',T3.NATION_CD ))                                         			\n")
				  .append("		   END			 AS NATION_CD 																						\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            SALES.FN_DETAIL_NM ( 'CU008',T3.PASS_TYPE)                                          			\n")
				  .append ("       END                                            AS PASS_TYPE /* 여권종류:CU008  */        			\n")
				  .append ("      ,CASE WHEN T3.COUNTRY_GU IN ('10') THEN                                             			\n")
				  .append ("            ''                                                                                  			\n")
				  .append ("       ELSE                                                                                     			\n")
				  .append ("            T3.PASS_NO                                                                          			\n")
				  .append ("       END                                            AS PASS_NO /* 여권번호    */              			\n")
					  .append ("  , CASE WHEN T2.CUST_GU ='1' THEN   																					\n")
					  .append ("    		CASE WHEN T3.COUNTRY_GU IN ('10','20') THEN '*'||t2.unity_no||'*'											\n")
					  .append ("   				 ELSE								    '*'||t3.manage_no||'*' END										\n")
					  .append ("    	 WHEN T2.CUST_GU ='2' THEN																						\n")
					  .append ("  			(SELECT '*'|| MAX(N_CARD_NO) ||'*' FROM SALES.TCU072 WHERE CUST_SID=T3.CUST_SID) 							\n")
					  .append (" 		 END AS unity_no1 																								\n")

				  .append ("  FROM SALES.TRV010 T1                                                                          			\n")
				  .append ("      ,SALES.TRV020 T2                                                                          			\n")
				  .append ("      ,SALES.TCU010 T3 LEFT OUTER JOIN  SALES.TSY110 T5 ON  T3.ZIP_SID    = T5.ZIP_SID          			\n")
				  .append ("      ,SALES.TRM200 T4                                                                          			\n")
				  .append (" WHERE T1.ACCEPT_SID  = T2.ACCEPT_SID                                                           			\n")
				  .append ("   AND T2.CUST_SID    = T3.CUST_SID                                                             			\n")
				  .append ("   AND T1.GOODS_SID   = T4.GOODS_SID                                                                    	\n")
				  .append ("   AND ((T2.STATUS_CD   IN ('RA', 'RR' , 'DP' ,'AR'))   /* 예약자료상태(RR:예약/RC:취소/NS/DP:출경/AR:입경) */ \n")
				  .append("    OR  (T2.STATUS_CD IN('RC', 'NS') AND T2.TOUR_NO <> '')) \n")
				  .append("   AND T2.SAUP_GU     <> '65'																							\n");
		
    }

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
	
	
		
	//select method
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

			//System.out.println(sSaupSid+":"+sDepartDate+":"+sDepartTime+":"+sGoodsSid+":"+sClass+":"+sTeams);

		
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
            GauceDataSet[] dSets = gis.readAllOutput();			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//DS1=ds1, 					DEFAULT=ds9 (리포트용)
				int sCnt1 = 1; 
				int sCnt2 = 1;
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
			        if (sSaupSid > 0)
						arr_sql[0].append (" AND T1.SAUP_SID = ?    \n");
					if (!sDepartDate.equals(""))
						arr_sql[0].append (" AND T2.DEPART_DATE = ? \n");
					if (!sDepartTime.equals(""))
						arr_sql[0].append (" AND T2.DEPART_TIME = ? \n");
					if (sGoodsSid > 0)
						arr_sql[0].append (" AND T1.GOODS_SID = ?   \n");
					if (!sClass.equals(""))
						arr_sql[0].append (" AND T2.CLASS = ?       \n");
					if (!sTeams.equals(""))
						arr_sql[0].append (" AND T2.TEAMS = ?       \n");

					arr_sql[0].append (" ORDER BY T2.CLASS, T2.TEAMS, T2.TOUR_NO, T2.RSV_SID  \n");
					//StringUtil.printMsg("조회용 SQL", arr_sql[0].toString(), this);
					cstmt = conn.prepareCall(arr_sql[0].toString());	
					if (sSaupSid > 0) 
						cstmt.setInt(sCnt1++, sSaupSid);
					
					if (!sDepartDate.equals(""))
						cstmt.setString(sCnt1++, sDepartDate);
					
					if (!sDepartTime.equals(""))
						cstmt.setString(sCnt1++, sDepartTime);
					
					if (sGoodsSid > 0) 
						cstmt.setInt(sCnt1++, sGoodsSid);
					
					if (!sClass.equals(""))
						cstmt.setString(sCnt1++, sClass);		
					
					if (!sTeams.equals(""))
						cstmt.setString(sCnt1++, sTeams);

					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}
            	
            	if(dSets[i].getName().equals("ds9")){
					GauceDataSet ds1 = gis.read("DEFAULT");
			        if (sSaupSid > 0)
						arr_sql[1].append (" AND T1.SAUP_SID = ?    \n");
					if (!sDepartDate.equals(""))
						arr_sql[1].append (" AND T2.DEPART_DATE = ? \n");
					if (!sDepartTime.equals(""))
						arr_sql[1].append (" AND T2.DEPART_TIME = ? \n");
					if (sGoodsSid > 0)
						arr_sql[1].append (" AND T1.GOODS_SID = ?   \n");
					if (!sClass.equals(""))
						arr_sql[1].append (" AND T2.CLASS = ?       \n");
					if (!sTeams.equals(""))
						arr_sql[1].append (" AND T2.TEAMS = ?       \n");

					  arr_sql[1].append (" ORDER BY T2.CLASS, T2.TEAMS, T2.TOUR_NO, T2.RSV_SID  \n");
					
					cstmt = conn.prepareCall(arr_sql[1].toString());
					
					if (sSaupSid > 0) 
						cstmt.setInt(sCnt2++, sSaupSid);
					
					if (!sDepartDate.equals(""))
						cstmt.setString(sCnt2++, sDepartDate);
					
					if (!sDepartTime.equals(""))
						cstmt.setString(sCnt2++, sDepartTime);
					
					if (sGoodsSid > 0) 
						cstmt.setInt(sCnt2++, sGoodsSid);
					
					if (!sClass.equals(""))
						cstmt.setString(sCnt2++, sClass);		
					
					if (!sTeams.equals(""))
						cstmt.setString(sCnt2++, sTeams);
					rs = cstmt.executeQuery();
					gos.write(getDataSet(rs, ds1));
				}            	
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

	/**
	 *
	 */
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

}
