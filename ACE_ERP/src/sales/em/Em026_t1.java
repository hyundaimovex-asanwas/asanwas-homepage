//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em026_t1 extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

				//파라메타 받아오는것 선언

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

        String strPaycd="";
				String strMemo="";
				String strYYmmdd="";
				String strYYmmdd2="";
			  String strYYmm="";   //급여년월 -1 월
			  String strYYmm2="";  //급여년월 -2 월
				//파라메타 받아오는것 선언
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_DIV","I_EMPNO"                         
																			  };

				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            //////////////////////////////////////////////////////
            //급여 작업 테이블 처리 시작  
            ////////////////////////////////////////////////////// 
            //기존데이타 DELETE 
						StringBuffer DeleteSql_00 = new StringBuffer();
						DeleteSql_00.append( " DELETE FROM SALES.TCM499		\n")
										    .append( "	WHERE APPDT=?							\n")
				  					    .append( "    AND PAYDIV=?						\n");
						GauceStatement gsmt_00 = conn.getGauceStatement(DeleteSql_00.toString());
						gsmt_00.setGauceDataRow(rows[j]);

						gsmt_00.bindColumn(1, idx[0]);
						gsmt_00.bindColumn(2, idx[1]);

						gsmt_00.executeUpdate();
						gsmt_00.close(); 

						for(int k=1;k<=1;k++) { 
               if (k==1){
								 strPaycd ="000"; 
								 strMemo="대상자,기본급,시급,일수계산중";  //기본급
							 }

							 StringBuffer InsertSql_2 = new StringBuffer();
							 //급여작업결과 성공
							 InsertSql_2.append("  INSERT INTO SALES.TCM499 (  \n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,  \n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,	\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE  \n" )
													.append("  ) VALUES ( \n" )
													.append("  '"+rows[j].getString(idx[0])+"', \n" )
													.append("  '"+rows[j].getString(idx[1])+"', \n" )
													.append("  '','1', \n" )
													.append("  '"+strPaycd+"',\n" )
													.append("   REPLACE(CAST(CURRENT DATE AS VARCHAR(10)),'-',''), \n" )
													.append("   REPLACE(CAST(CURRENT TIME AS VARCHAR(8)),'.',''),  \n" )
													.append("   '','',\n" )
													.append("   '1', \n" ) //진행중
													.append("   '"+strMemo+"', \n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP,\n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP) \n" );

							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();
						}

            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              급여 계산 기초 데이타
						  +++++++++++++++++++++++++++++++++++++++++++++++*/

            //급여지급년월 - 1 개월===========================================================
						StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;

						strYYmmdd = rows[j].getString(idx[0]);  //급여년월
            strYYmmdd2 =  strYYmmdd.substring(0,4)+"-"+strYYmmdd.substring(4,6)+"-"+"01"; //급여년월의 1일

						sql0.append( " SELECT SUBSTR(REPLACE(CAST((CAST('"+strYYmmdd2+"' AS DATE) - 1 MONTH ) AS VARCHAR(10)),'-',''),1,6),   \n" )
							  .append( "        SUBSTR(REPLACE(CAST((CAST('"+strYYmmdd2+"' AS DATE) - 2 MONTH ) AS VARCHAR(10)),'-',''),1,6)   \n" )
							  .append( "   FROM SYSIBM.SYSDUMMY1    \n" );
							  
           // logger.dbg.println(this,sql0.toString());
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						while (rs0.next())	{
								strYYmm=rs0.getString(1);
								strYYmm2 = rs0.getString(2);
						}
						rs0.close();
						stmt0.close();
						//================================================================================
						//기존데이타 DELETE 
						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM400		\n")
										 .append( "	 WHERE PAY_YM=?							\n")
				  					 .append( "    AND PAY_DIV=?						\n");
						GauceStatement gsmt_0 = conn.getGauceStatement(DeleteSql.toString());
						gsmt_0.setGauceDataRow(rows[j]);

						gsmt_0.bindColumn(1, idx[0]);
						gsmt_0.bindColumn(2, idx[1]);

						gsmt_0.executeUpdate();
						gsmt_0.close();

            //급여대상자 생성 --년차도 자동으로 가져옴 =======================================================================================================================================
            StringBuffer InsertSql = new StringBuffer();
					  InsertSql.append(" INSERT INTO SALES.TCM400 (  PAY_YM,     PAY_DIV,  EMPNO,     CUST_SID, VEND_CD,      \n" )
						 				 .append("                             DEPT_CD,    TEAM_CD,  WORK_CD,   JOB_CD,   SKILL_CD,     \n" )
							       .append("                             CON_YEAR,   PAY_DT,   PASS_NO,   B_PAY0,                 \n" )
							       .append("                             B_PAY1,     B_PAY2,   T_PAY1,    T_PAY2,                \n" )
							       .append("                             H_DAY,      RW_DAY1,  RW_DAY2,   O_TIME1,  O_TIME2,  O_TIME_TOT,   \n" )
							       .append("                             BASIC_TOT,  RET_PAY,  SEN_PAY,   AIR_PAY,  B20_PAY,      \n" )
							       .append("                             BON_PAY,    LST_PAY,  TEL_PAY,   ADV_PAY,  TELUBO_PAY,   \n" )
							       .append("                             TELSAVE_PAY,ETC_PAY,  EX_AIR_PAY,SND_PAY,  PAY_SUM,      \n" )
							       .append("                             DEDUCT_SUM, REAL_PAY_SUM, M_DAYS, CHGYMD,  AGENCY_CD,    \n" )
							       .append("                             I_EMPNO,    I_DATE,      U_EMPNO,    U_DATE              \n" )
							       .append("                             )                                                        \n" )
							      /*
						         .append("  SELECT '"+rows[j].getString(idx[0])+"','"+rows[j].getString(idx[1])+"', X.EMPNO, MAX(Y.CUST_SID), MAX(Y.VEND_CD),                                           \n" )
							       .append("         IFNULL(MAX(Y.DEPT_CD),''), IFNULL(MAX(Y.TEAM_CD),''), IFNULL(MAX(Y.WORK_CD),''), IFNULL(MAX(Y.JOB_CD),''),IFNULL(MAX(Y.SKILL_CD),''),                \n" )
							       .append("         IFNULL(MAX(Y.CON_YEAR),0)CON_YEAR, '', IFNULL(MAX(Y.PASS_NO),''), 0, \n" )
							       .append("         IFNULL(MAX(M.B_PAY),0)B_PAY1, IFNULL(MAX(L.B_PAY),0)B_PAY2, IFNULL(MAX(M.T_PAY),0)T_PAY1, IFNULL(MAX(L.T_PAY),0)T_PAY2, IFNULL(SUM(X.H_DAY),0)H_DAY, \n" )
							       .append("         IFNULL(SUM(X.RW_DAY1),0)+IFNULL(SUM(X.RW_DAY11),0)RW_DAY1,IFNULL(SUM(X.RW_DAY2),0)+IFNULL(SUM(X.RW_DAY22),0)RW_DAY2,                      \n" )
							       .append("         IFNULL(SUM(X.O_TIME1),0)O_TIME1, IFNULL(SUM(X.O_TIME2),0)O_TIME2,0,                      \n" )
							       .append("         0,0,0,0,0,  \n" )
							       .append("         0,0,0,0,0,  \n" )
							       .append("         0,0,0,0,0,  \n" )
							       .append("         0,0, SUBSTR(REPLACE(CAST(CAST('"+strYYmmdd2+"' AS DATE)-1 days AS VARCHAR(10)),'-',''),7,2) M_DAYS,    \n" )
							       .append("         '"+rows[j].getString(idx[2])+"',CURRENT TIMESTAMP,'"+rows[j].getString(idx[2])+"',CURRENT TIMESTAMP                                                                                              \n" )					
										 */
										 .append("   SELECT '"+rows[j].getString(idx[0])+"','"+rows[j].getString(idx[1])+"', X.EMPNO, MAX(Y.CUST_SID), MAX(Y.VEND_CD),                                                                                    \n" ) 
										 .append("   			 IFNULL(MAX(Y.DEPT_CD),''), IFNULL(MAX(Y.TEAM_CD),''), IFNULL(MAX(Y.WORK_CD),''), IFNULL(MAX(Y.JOB_CD),''),IFNULL(MAX(Y.SKILL_CD),''), \n" ) 
										 .append("   			 IFNULL(MAX(Y.CON_YEAR),0)CON_YEAR, '', IFNULL(MAX(Y.PASS_NO),''), 0,                                                                  \n" ) 
                     .append("   			 IFNULL(MAX(X.B_PAY1),0)B_PAY1, IFNULL(MAX(X.B_PAY2),0)B_PAY2, IFNULL(MAX(X.T_PAY1),0)T_PAY1, IFNULL(MAX(X.T_PAY2),0)T_PAY2,           \n" ) 
										 .append("   			 IFNULL(SUM(X.H_DAY),0)+IFNULL(SUM(X.H_DAY2),0) H_DAY,                                                                                 \n" ) 
										 .append("   			 IFNULL(SUM(X.RW_DAY1),0)+IFNULL(SUM(X.RW_DAY11),0)RW_DAY1,IFNULL(SUM(X.RW_DAY2),0)+IFNULL(SUM(X.RW_DAY22),0)RW_DAY2,                  \n" ) 
										 .append("   			 IFNULL(SUM(X.O_TIME1),0)O_TIME1, IFNULL(SUM(X.O_TIME2),0)O_TIME2,0,                                                                   \n" ) 
										 .append("   			 0,0,0,0,0,                                                                                                                            \n" ) 
										 .append("   			 0,0,0,0,0,                                                                                                                            \n" ) 
										 .append("   			 0,0,0,0,0,                                                                                                                            \n" ) 
										 .append("   			 0,0,                                                                                                                                  \n" ) 
										 .append("   			 SUBSTR(REPLACE(CAST(CAST('"+strYYmmdd2+"' AS DATE)-1 days AS VARCHAR(10)),'-',''),7,2) M_DAYS, MAX(X.CHGYMD)CHGYMD, MAX(X.AGENCY_CD),    \n" ) 
						         .append("   			 '"+rows[j].getString(idx[2])+"',CURRENT TIMESTAMP,'"+rows[j].getString(idx[2])+"',CURRENT TIMESTAMP                                   \n" ) 
										 .append("			   FROM (                                                                                                                 \n" ) 								 
										 .append("			          --일할계산인 경우 : 연장계약이전                                                                                \n" ) 
										 .append("			          SELECT A.EMPNO,                                                                                                 \n" ) 
										 .append("			                  IFNULL(MAX(L.B_PAY),0)B_PAY1, 0 B_PAY2, IFNULL(MAX(L.T_PAY),0)T_PAY1, 0 T_PAY2,                         \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('001') THEN A.EMPNO END ) RW_DAY1,                                   \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 RW_DAY11, --반휴 반근무                \n" ) 
										 .append("			                       0 RW_DAY2, 0 RW_DAY22,                                                                             \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('002') THEN A.EMPNO END ) H_DAY,                                     \n" )
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 H_DAY2,  --반휴                        \n" ) 								 
										 .append("			                       SUM(CASE WHEN A.WORK_GB IN ('001','003') THEN A.O_TIME_TOT ELSE 0 END) O_TIME1, --근무,반휴무의OT  \n" ) 
										 .append("			                       0 O_TIME2, MAX(B.CHGYMD)CHGYMD,MAX(B.AGENCY_CD)AGENCY_CD                                           \n" ) 
										 .append("			            FROM SALES.TCM350 A                                                                                           \n" ) 
										 .append("			            LEFT JOIN SALES.TCM300 B ON A.EMPNO = B.EMPNO                                                                 \n" ) 
										 .append("			            LEFT JOIN SALES.TCM410 L ON L.SKILL_CD = B.B_SKILL_CD    --일할계산 기본급 시급                               \n" ) 
										 .append("			                                    AND L.CON_YEAR = B.B_CON_YEAR                                                         \n" ) 
										 .append("			                                    AND L.YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)                                 \n" )
										 .append("			           WHERE A.ATT_DT < (SELECT B.CHGYMD FROM SALES.TCM300 B                                                          \n" ) 								 
										 .append("			                                            WHERE B.CHGYMD LIKE '"+strYYmm+"%'                                            \n" ) 
										 .append("			                                              AND B.EMPNO=A.EMPNO)                                                        \n" ) 
										 .append("			             AND A.PAY_YM = '"+rows[j].getString(idx[0])+"'                                                               \n" ) 
                     .append("			             AND (B.USESTS='1'  OR  (B.USESTS='3' AND  B.END_DT LIKE '"+strYYmm+"%'))                                     \n" ) 
										 .append("			           GROUP BY A.EMPNO                                                                                               \n" ) 
										 .append("			          UNION ALL                                                                                                       \n" ) 
										 .append("			          --일할계산인 경우 : 연장계약이후                                                                                \n" ) 
										 .append("			          SELECT A.EMPNO,                                                                                                 \n" )
										 .append("			                 0 B_PAY1, IFNULL(MAX(L.B_PAY),0)B_PAY2, 0 T_PAY1, IFNULL(MAX(L.T_PAY),0)T_PAY2,                          \n" ) 								 
										 .append("			                       0 RW_DAY1, 0 RW_DAY11,                                                                             \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('001') THEN A.EMPNO END ) RW_DAY2,                                   \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 RW_DAY22,                              \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('002') THEN A.EMPNO END ) H_DAY,                                     \n" ) 
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 H_DAY2,                                \n" ) 
										 .append("			                       0 O_TIME1, --근무,반휴무의OT                                                                       \n" ) 
										 .append("			                       SUM(CASE WHEN A.WORK_GB IN ('001','003') THEN A.O_TIME_TOT ELSE 0 END) O_TIME2,                    \n" )
									   .append("			                       MAX(B.CHGYMD)CHGYMD, MAX(B.AGENCY_CD)AGENCY_CD                                                     \n" )	 
                     .append("			            FROM SALES.TCM350 A                                                                                           \n" )								 
										 .append("			            LEFT JOIN SALES.TCM300 B ON A.EMPNO = B.EMPNO                                                                 \n" )
										 .append("			            LEFT JOIN SALES.TCM410 L ON L.SKILL_CD = B.SKILL_CD    --일할계산 기본급 시급                                 \n" )
										 .append("			                                    AND L.CON_YEAR = B.CON_YEAR                                                           \n" )
										 .append("			                                    AND L.YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)                                 \n" )
										 .append("			           WHERE A.ATT_DT >=(SELECT B.CHGYMD FROM SALES.TCM300 B                                                          \n" )
										 .append("			                                            WHERE B.CHGYMD LIKE '"+strYYmm+"%'                                            \n" )
										 .append("			                                              AND B.EMPNO=A.EMPNO)                                                        \n" )
										 .append("			             AND A.PAY_YM = '"+rows[j].getString(idx[0])+"'                                                               \n" )
										 .append("			             AND (B.USESTS='1'  OR  (B.USESTS='3' AND  B.END_DT LIKE '"+strYYmm+"%'))                                     \n" ) 
										 .append("			           GROUP BY A.EMPNO                                                                                               \n" )
										 .append("			           UNION ALL                                                                                                      \n" )
										 .append("			          --일할계산 아닌경우의 사람                                                                                      \n" )
										 .append("			          SELECT A.EMPNO,                                                                                                 \n" )
										 .append("			                 0 B_PAY1, IFNULL(MAX(L.B_PAY),0)B_PAY2, 0 T_PAY1, IFNULL(MAX(L.T_PAY),0)T_PAY2,                          \n" )
										 .append("			                       0 RW_DAY1, 0 RW_DAY11,                                                                             \n" )
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('001') THEN A.EMPNO END ) RW_DAY2,                                   \n" )
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 RW_DAY22,                              \n" )
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('002') THEN A.EMPNO END ) H_DAY,                                     \n" )
										 .append("			                       COUNT(CASE WHEN A.WORK_GB IN ('003') THEN A.EMPNO END )*0.5 H_DAY2,                                \n" )
										 .append("			                       0 O_TIME1, --근무,반휴무의OT                                                                       \n" )
										 .append("			                       SUM(CASE WHEN A.WORK_GB IN ('001','003') THEN A.O_TIME_TOT ELSE 0 END) O_TIME2,                    \n" )
										 .append("			                       ''CHGYMD ,MAX(B.AGENCY_CD)AGENCY_CD                                                                \n" )
										 .append("			            FROM SALES.TCM350 A                                                                                           \n" )
										 .append("			            LEFT JOIN SALES.TCM300 B ON A.EMPNO = B.EMPNO                                                                 \n" )
										 .append("			            LEFT JOIN SALES.TCM410 L ON L.SKILL_CD = B.SKILL_CD    --일할계산 기본급 시급                                 \n" )
										 .append("			                                    AND L.CON_YEAR = B.CON_YEAR                                                           \n" )
										 .append("			                                    AND L.YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)                                 \n" )
										 .append("			           WHERE NOT EXISTS ( SELECT B.EMPNO FROM SALES.TCM300 B                                                          \n" )
										 .append("			                                            WHERE B.CHGYMD LIKE '"+strYYmm+"%'                                            \n" )
										 .append("			                                              AND B.EMPNO = A.EMPNO                                                       \n" )
										 .append("			                                               )                                                                          \n" )
                     .append("			             AND A.PAY_YM = '"+rows[j].getString(idx[0])+"'                                                               \n" ) 
										 .append("			             AND (B.USESTS='1'  OR  (B.USESTS='3' AND  B.END_DT LIKE '"+strYYmm+"%'))                                     \n" ) 
										 .append("			           GROUP BY A.EMPNO                                                                                               \n" )
                     .append("			          UNION ALL \n" )
										 .append("					     --퇴직자 중 이전월에 전화비 유보가 존재하는 사람          \n" )
										 .append("					    SELECT A.EMPNO, 0 B_PAY1, 0 B_PAY2, 0 T_PAY1, 0 T_PAY2,    \n" )
										 .append("					    			 0 RW_DAY1, 0 RW_DAY11, 0 RW_DAY2, 0 RW_DAY22,       \n" )
										 .append("					    			 0 H_DAY, 0 H_DAY2, 0 O_TIME1, 0 O_TIME2, ''CHGYMD ,B.AGENCY_CD  \n" )
										 .append("					    	FROM SALES.TCM400 A, SALES.TCM300 B                      \n" )
										 .append("					     WHERE A.PAY_YM = '"+strYYmm+"'                            \n" )
										 .append("					    	 AND A.TELUBO_PAY <> 0                                   \n" )
										 .append("					    	 AND A.EMPNO=B.EMPNO                                     \n" )
										 .append("			    	     AND B.USESTS='3'                                        \n" )
										 .append("			           AND (B.USESTS='1'  OR  (B.USESTS='3' AND  B.END_DT LIKE '"+strYYmm2+"%')) \n" ) 
										 .append("			   ) X                                                             \n" )
										 .append("			   LEFT JOIN SALES.TCM300 Y ON X.EMPNO = Y.EMPNO                   \n" )
										 .append("			   GROUP BY X.EMPNO                                                \n" );
										 
						  logger.dbg.println(this, InsertSql.toString());
							GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
							gsmt_1.setGauceDataRow(rows[j]);

							gsmt_1.executeUpdate();
							gsmt_1.close();
					  //=======================================================================================================================================

            //실제근무일수로 ==> 급여계산 급무일수 계산 =============================================================================================
						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
              근무일수 재계산  
              H_DAY - 실제휴일
              RW_DAY1 - 실제근무일 (일할계산 이전)
              RW_DAY2 - 실제근무일 (일할계산 이후 일할계산 없을 경우)
              W_DAY1 -  계산근무일 (일할계산 이전) 
              W_DAY2 -  계산근무일 (일할계산 이후 일할계산 없을 경우)
							* 계산 근무일은 실제 근무일에 휴무 여부에 따라 근무일이 더해진다.
							15일 이상 근무시 - 2일 추가
							15일 미만 근무시 - 1일 추가
							1일  근무는 추가 일 없음.
							HO_DAY - 휴일 OT 근무일수
						 +++++++++++++++++++++++++++++++++++++++++++++++*/
						StringBuffer UpdateSql_2 = new StringBuffer();
					  UpdateSql_2.append(" UPDATE SALES.TCM400 A                                                     \n" )
						 				   .append("    SET (A.W_DAY1,A.W_DAY2,A.HO_DAY)=                                      \n" )
							         .append("    ( SELECT X.W_DAY1, X.W_DAY2,X.HO_DAY                                   \n" )
							         .append("       FROM (SELECT EMPNO, PAY_YM, PAY_DIV, H_DAY, RW_DAY1, RW_DAY2,M_DAYS,\n" )
                       .append(" 									 CASE WHEN RW_DAY1=0 THEN 0                              \n" )
							         .append(" 									      WHEN RW_DAY1<>0 AND RW_DAY1>RW_DAY2 THEN           \n" )
							         .append(" 												CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN         \n" )
							         .append(" 														 CASE WHEN H_DAY = 0 THEN RW_DAY1              \n" )
							         .append(" 																	WHEN H_DAY = 1 THEN RW_DAY1+1            \n" )
							         .append(" 																	WHEN H_DAY >=2 THEN RW_DAY1+2            \n" )
							         .append(" 																	ELSE 0 END                               \n" )
							         .append(" 														 WHEN (RW_DAY1+RW_DAY2)>0 AND (RW_DAY1+RW_DAY2)<15 THEN  \n" )
							         .append(" 														 CASE WHEN H_DAY = 0 THEN RW_DAY1              \n" )
							         .append(" 																	WHEN H_DAY >= 1 THEN RW_DAY1+1           \n" )
							         .append(" 																	ELSE 0 END                               \n" )
							         .append(" 														 ELSE 0 END                                    \n" )
							         .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1<RW_DAY2 THEN RW_DAY1   \n" )
							         .append(" 									 END AS W_DAY1,                                          \n" )
							         .append(" 									 CASE WHEN RW_DAY1=0 THEN                                \n" )
							         /*
							         .append(" 												CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN         \n" )
							         .append(" 														 CASE WHEN (RW_DAY1+RW_DAY2+2)>=M_DAYS THEN M_DAYS ELSE RW_DAY1+RW_DAY2+2 END \n" )
							         .append(" 														 WHEN (RW_DAY1+RW_DAY2)>0 AND (RW_DAY1+RW_DAY2)<15 THEN RW_DAY1+RW_DAY2+1 ELSE 0 END \n" )
											 */
                       .append("                        CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN       \n" )
											 .append("    				                      CASE WHEN H_DAY = 0 THEN RW_DAY2       \n" )
											 .append("    							                     WHEN H_DAY = 1 THEN RW_DAY2+1     \n" )
											 .append("    							                     WHEN H_DAY >=2 THEN RW_DAY2+2     \n" )
											 .append("    					                    ELSE 0 END                             \n" )
											 .append("    		                     WHEN (RW_DAY1+RW_DAY2)<15 THEN              \n" )
											 .append("    				                      CASE WHEN H_DAY = 0 THEN RW_DAY2       \n" )
											 .append("    							                     WHEN H_DAY >=1 THEN RW_DAY2+1     \n" )
											 .append("    				                      ELSE 0 END                             \n" )
											 .append("                        ELSE 0 END                                       \n" )
							         
											 .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1<RW_DAY2 THEN           \n" )
							         .append(" 														 CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN    \n" )
							         .append(" 																	CASE WHEN H_DAY = 0 THEN RW_DAY2         \n" )
							         .append(" 																			 WHEN H_DAY = 1 THEN RW_DAY2+1       \n" )
							         .append(" 																			 WHEN H_DAY >=2 THEN RW_DAY2+2       \n" )
							         .append(" 																			 ELSE 0 END                          \n" )
							         .append(" 																	WHEN (RW_DAY1+RW_DAY2)>0 AND (RW_DAY1+RW_DAY2)<15 THEN \n" )
							         .append(" 																	CASE WHEN H_DAY = 0 THEN RW_DAY2         \n" )
							         .append(" 																			 WHEN H_DAY >= 1 THEN RW_DAY2+1      \n" )
							         .append(" 																			 ELSE 0 END                          \n" )
							         .append(" 																	ELSE 0 END                               \n" )
							         .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1>RW_DAY2 THEN RW_DAY2   \n" )
							         .append(" 										END AS W_DAY2,                                         \n" )
                       //2008.03.18 추가사항 
						           //근무일수가 5일 이하인 사람 중에서 근무기간에 휴무가 없을 경우 
						           //근무기간내에 휴무일 체크하여 휴무가 없는 사람은 휴일OT일수(HO_DAY)가 0가 된다.  
                       .append("                  -- 휴일근무OT일자                                         \n" ) 
											 .append("                   CASE WHEN RW_DAY1+RW_DAY2>15 THEN                        \n" ) 
											 .append("     					               CASE WHEN H_DAY=0 THEN 2                       \n" ) 
											 .append("     							                WHEN H_DAY=1 THEN 1                       \n" ) 
											 .append("     							           ELSE 0 END                                     \n" ) 
											 .append("     		                WHEN RW_DAY1+RW_DAY2>1 AND RW_DAY1+RW_DAY2 <=15 THEN  \n" ) 
											 .append("     					               CASE WHEN RW_DAY1+RW_DAY2<=5 THEN                \n" ) 
                       .append("     					                    CASE WHEN H_DAY = 0 THEN 0                  \n" ) 
                       .append("     					                         WHEN H_DAY = 1 THEN 1                  \n" ) 
                       .append("     					                    ELSE 0 END                                  \n" ) 
                       .append("     					               ELSE CASE WHEN H_DAY=0 THEN 1                    \n" ) 
											 .append("     							                     ELSE 0 END                             \n" ) 
										   .append("     							      END                                                 \n" ) 
											 .append("     		           ELSE 0 END AS HO_DAY                                     \n" ) 
							         .append(" 							FROM SALES.TCM400                                             \n" )
						           .append(" 						 WHERE PAY_YM =?                                                \n" )
							         .append(" 							 AND PAY_DIV=?                                                \n" )		
							         .append(" 				 )X                                                                 \n" )
							         .append("     WHERE X.EMPNO = A.EMPNO                                                \n" )
							         .append("       AND X.PAY_YM = A.PAY_YM                                              \n" )
							         .append("       AND X.PAY_DIV =A.PAY_DIV                                             \n" )
							         .append("    )                                                                       \n" )
						           .append("  WHERE A.PAY_YM=?                            \n" )
											 .append("    AND A.PAY_DIV=?                           \n" );
						
						logger.dbg.println(this,"jys::"+UpdateSql_2.toString());
						GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql_2.toString()); //로그남기는것
										 
						gsmt_2.setGauceDataRow(rows[j]);

						gsmt_2.bindColumn(1, idx[0]);
						gsmt_2.bindColumn(2, idx[1]);
						gsmt_2.bindColumn(3, idx[0]);
						gsmt_2.bindColumn(4, idx[1]);
					
						gsmt_2.executeUpdate();
						gsmt_2.close();           

  				  //=======================================================================================================================================

							 
						for(int m=1;m<=1;m++) { 
							 strPaycd="";
							 if (m==1){ 
								 strPaycd ="000"; 
								 strMemo="대상자,기본급,시급,일수계산완료";  //기본급
							 }

							StringBuffer UpdateSql = new StringBuffer();			
							UpdateSql.append( " UPDATE SALES.TCM499		\n")
												.append( " SET                  \n")
												.append( " TODT=REPLACE(CAST(CURRENT DATE AS VARCHAR(10)),'-',''), \n")
												.append( " TOTM=REPLACE(CAST(CURRENT TIME AS VARCHAR(8)),'.',''),  WRKSTS='2',   \n")
                        .append("  MEMO = '"+strMemo+"', \n" )
												.append( " U_DATE=CURRENT TIMESTAMP \n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'	\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' \n")
												.append( "   AND PAYCD='"+strPaycd+"'       \n");
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									
					  }
						
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

            /*
	
						StringBuffer UpdateSql = new StringBuffer();			

					  UpdateSql.append( " UPDATE SALES.TCM345			\n")
											.append( " SET                      \n")
											.append( " JOB_CD=?,  VEND_CD=?,  DEPT_CD=?,   TEAM_CD=?, WORK_CD=?,   \n")
											.append( " CONT_GB=?, START_DT=?, END_DT=?,    C_EMPNO=?, C_POSI_CD=?, \n")
											.append( " C_OPI=?,   T_EMPNO=?,  T_POSI_CD=?, T_OPI=?,   REMARK=?,    \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
							        .append( " REWARD_YM=? \n")
											.append( " WHERE EMPNO=?						\n")
											.append( " AND SEQ=?                \n");

						rows[j].setString(idx[20],strEmpno);

  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[3]);	
						gsmt.bindColumn(2,  idx[4]);	
						gsmt.bindColumn(3,  idx[5]);	
						gsmt.bindColumn(4,  idx[6]);	
						gsmt.bindColumn(5,  idx[7]);	
						gsmt.bindColumn(6,  idx[8]);	
						gsmt.bindColumn(7,  idx[9]);	
						gsmt.bindColumn(8,  idx[10]);	
						gsmt.bindColumn(9,  idx[11]);	
						gsmt.bindColumn(10,  idx[12]);	
						gsmt.bindColumn(11,  idx[13]);	
						gsmt.bindColumn(12,  idx[14]);	
						gsmt.bindColumn(13,  idx[15]);	
						gsmt.bindColumn(14,  idx[16]);	
						gsmt.bindColumn(15,  idx[17]);	
						gsmt.bindColumn(16,  idx[20]);
						gsmt.bindColumn(17,  idx[22]);
						gsmt.bindColumn(18,  idx[0]);	
						gsmt.bindColumn(19,  idx[1]);	
						gsmt.executeUpdate();					
						gsmt.close();									
						*/
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            /*

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM345		\n")
										 .append( "	 WHERE EMPNO=?							\n")
				  					 .append( "    AND SEQ=?							  \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);

						gsmt.executeUpdate();
						gsmt.close();

						*/

			   	}
				}
			}
			catch(Exception e){
				conn.rollback();
				
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
