package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em010_S1 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= req.getParameter("v_str1"); 
				String  str2	= req.getParameter("v_str2"); 
				String  str3	= req.getParameter("v_str3"); 

				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																				"CUST_SID","USESTS","EMPNMK","EMPNMC","LAST_NM",
																				"FIRST_NM","EMPNO","BIRTHDAY","SEX","NATION_CD",
																				"START_DT","JOB_CD","AGENCY_CD","VEND_CD","DEPT_CD",
																				"TEAM_CD","WORK_CD","SKILL_CD","COUNTRY_CD","PASS_NO",
																				"PASS_EXPIRE_DATE","CON_YEAR","I_DATE","U_DATE","I_EMPNO",
																				"U_EMPNO","N_CARD_NO","USTS",  "ZIP_ADD","ZIP_CD",
																				"ADDRESS1","ADDRESS2","TEL_NO","MOBILE_NO","HEIGHT",
																				"WEIGHT","SIZE_UP",   "SIZE_DN","SIZE_FT","SIZE_WT",
																				"BLOOD",  "ENG_NM",   "B_SKILL_CD", "ORD_CD" ,
																				"END_DT",  "CHGYMD",  "C_VEND_CD", "CHI_NM",	"CHI_RNM",	
																				"CHI_TEL", "CHI_ADD",	"SCH_FR",	   "SCH_TO",	"ATT_CD",	 "ATT_NM",
																				"SCH_NM",	 "HOBBY",   "SPC_NM",	   "B_PAY",   "MANAGE_NO",
																				"REM_BNK", "SAV_NM", "SAV_TEL",   "REM_ACC",  "PIC_DIR",
                                        "WORK_NM","JOB_NM","AGENCY_NM",
																				"ORD_NM","COUNTRY_NM","NATION_NM","SEX_NM", "REM_BNK_NM","SCH_FRTO","TEAM_NM"
																					
																			}; 	
																					

				int[] intArrCN = new int[] { 
																				10,1,30,20,30,
																				30,10,8,1,3,
																				8,5,3,10,5,
																				5,5,3,3,20,
																				8,2,10,10,10,
																				10,20,1,86,6,
																				80,60,20,20,4,
																				4,3,3,3,3,
																				5,60,3, 3,
																				8, 8, 10,30, 20,
                                       20, 50, 6, 6, 2, 30,
																			 30, 30, 30, 10,  20,
																			 3,  20, 20, 30, 120,
																			 30, 30, 30,
                                       30, 30, 30, 30, 30,30, 50
																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1,-1,-1,-1,
																				-1,-1,-1,-1,-1,
																				-1,-1,-1,0,-1,
																				-1,-1,-1,-1,-1,
																				-1,0,-1,-1,-1,
																				-1,0,-1,-1,-1,
																				-1,-1,-1,-1,1,
																				 0,-1,-1,0, 0,
																				-1,-1,-1,-1,
                                        -1,-1 ,0,  -1, -1,
                                        -1,-1 ,-1, -1, -1, -1,
                                        -1,-1 ,-1,  0, -1,
																				-1,-1, -1, -1, -1, -1,
																				-1,-1,-1,
                                        -1,-1,-1,-1,-1,-1, -1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT '1'   AS  USTS,  A.CUST_SID, A.USESTS,RTRIM(A.EMPNMK) AS EMPNMK, RTRIM(A.EMPNMC) AS EMPNMC,              \n");
						sql.append( "	       RTRIM(B.LAST_NM) AS  LAST_NM, RTRIM(B.FIRST_NM)  AS  FIRST_NM, LAST_NM||'-'||FIRST_NM AS ENG_NM,         \n");
						sql.append( "	       A.EMPNO AS  EMPNO, TRIM(B.BIRTHDAY) AS BIRTHDAY, B.SEX ,                                                 \n");
						sql.append( "	       A.NATION_CD, A.START_DT,A.JOB_CD,A.AGENCY_CD, A.VEND_CD,                                                 \n");
						sql.append( "	       A.DEPT_CD, A.TEAM_CD, A.WORK_CD, A.SKILL_CD,  B.COUNTRY_CD,                                              \n");
						sql.append( "	       B.PASS_NO, B.PASS_EXPIRE_DATE, A.CON_YEAR, A.I_DATE,                                                     \n");
						sql.append( "	       A.U_DATE,  A.I_EMPNO , A.U_EMPNO,  IFNULL(C.N_CARD_NO,0)  AS  N_CARD_NO,                                 \n");
						sql.append( "	       ADDRESS1 AS ZIP_ADD, B.ZIP_CD,                                                                           \n");
						sql.append( "	       TRIM(B.ADDRESS1)||' '||TRIM(B.ADDRESS2) AS ADDRESS1,                                                     \n");
						sql.append( "	       TRIM(B.ADDRESS2) AS ADDRESS2,                                                                            \n");
						sql.append( "	       TRIM(B.TEL_NO)   AS  TEL_NO,                                                                             \n");
						sql.append( "	       TRIM(B.MOBILE_NO) AS  MOBILE_NO,                                                                         \n");
						sql.append( "	       TRIM(A.SIZE_UP) AS  SIZE_UP,                                                                             \n");
						sql.append( "	       TRIM(A.SIZE_DN) AS  SIZE_DN,                                                                             \n");
						sql.append( "	       TRIM(A.BLOOD)   AS  BLOOD,                                                                               \n");
						sql.append( "	       A.HEIGHT, A.WEIGHT ,  SIZE_FT, SIZE_WT,                                                                  \n");
						sql.append( "	       A.B_SKILL_CD, A.ORD_CD, IFNULL(A.END_DT,'')END_DT, IFNULL(A.CHGYMD,'')CHGYMD,                            \n");
						sql.append( "	       IFNULL(A.C_VEND_CD,0) C_VEND_CD, IFNULL(A.CHI_NM,'')CHI_NM,IFNULL(A.CHI_RNM,'')CHI_RNM,                   \n");
						sql.append( "	       IFNULL(A.CHI_TEL,'')CHI_TEL,IFNULL(A.CHI_ADD,'')CHI_ADD,IFNULL(A.SCH_FR,'')SCH_FR,                       \n");
						sql.append( "	       IFNULL(A.SCH_TO,'')SCH_TO,IFNULL(A.ATT_CD,'')ATT_CD, RTRIM(G.DETAIL_NM)ATT_NM,                           \n");
						sql.append( "	       IFNULL(A.SCH_NM,'')SCH_NM,IFNULL(A.HOBBY,'')HOBBY,IFNULL(A.SPC_NM,'')SPC_NM,                             \n");
						sql.append( "	       IFNULL(H.B_PAY,0)B_PAY, IFNULL(B.MANAGE_NO,'')MANAGE_NO,                                                 \n");
						sql.append( "	       IFNULL(A.REM_BNK,'')REM_BNK,IFNULL(A.SAV_NM,'')SAV_NM,IFNULL(A.SAV_TEL,'')SAV_TEL,                       \n");
						sql.append( "	       IFNULL(A.REM_ACC,'')REM_ACC , ''PIC_DIR,                                                                 \n");
						sql.append( "	       RTRIM(N.DETAIL_NM)WORK_NM,RTRIM(I.DETAIL_NM)JOB_NM,RTRIM(J.DETAIL_NM)AGENCY_NM,                          \n");
						sql.append( "	       RTRIM(K.DETAIL_NM)ORD_NM,RTRIM(L.DETAIL_NM)COUNTRY_NM,RTRIM(M.DETAIL_NM)NATION_NM,                       \n");
						sql.append( "	       CASE WHEN B.SEX='M' THEN '남' ELSE '여' END SEX_NM,                                                       \n");
						sql.append( "	       RTRIM(O.DETAIL_NM)REM_BNK_NM,                                                      \n");
						sql.append( "	       CASE WHEN SCH_FR IS NOT NULL OR  RTRIM(SCH_FR)<>'' THEN SCH_FR||SCH_TO ELSE '' END SCH_FRTO, RTRIM(F.DETAIL_NM) TEAM_NM \n");
						sql.append( "		FROM SALES.TCM300 A                                                                                           \n");
						sql.append( "		LEFT JOIN SALES.TCU010 B ON A.CUST_SID=B.CUST_SID                                                             \n");
						sql.append( "		LEFT JOIN SALES.TCU060 C ON A.CUST_SID=C.CUST_SID                                                             \n");
						sql.append( "		LEFT OUTER JOIN SALES.TSY010 F ON TRIM(F.DETAIL)=TRIM(A.TEAM_CD) AND F.HEAD='CM003' AND TRIM(F.DETAIL)<>''    \n");
						sql.append( "		LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.ATT_CD)    AND G.HEAD='CM027' AND RTRIM(G.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 N ON RTRIM(N.DETAIL) = RTRIM(A.WORK_CD)   AND N.HEAD='CM003' AND RTRIM(N.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.JOB_CD)    AND I.HEAD='CM004' AND RTRIM(I.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(A.AGENCY_CD) AND J.HEAD='CM005' AND RTRIM(J.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(A.ORD_CD)    AND K.HEAD='CM012' AND RTRIM(K.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 L ON RTRIM(L.DETAIL) = RTRIM(B.COUNTRY_CD) AND L.HEAD='SY005' AND RTRIM(L.DETAIL)<>''  \n");
						sql.append( "		LEFT JOIN SALES.TSY010 M ON RTRIM(M.DETAIL) = RTRIM(A.NATION_CD)  AND M.HEAD='CM020' AND RTRIM(M.DETAIL)<>''  \n");
						sql.append( "	  LEFT JOIN SALES.TSY010 O ON RTRIM(O.DETAIL) = RTRIM(A.REM_BNK)  AND O.HEAD='CM028' AND RTRIM(O.DETAIL)<>''    \n");
						sql.append( "		LEFT JOIN SALES.TCM410 H ON H.YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)                                 \n");
						sql.append( "														AND H.SKILL_CD = A.SKILL_CD                                                           \n");
						sql.append( "														AND H.CON_YEAR = A.CON_YEAR                                                           \n");
						sql.append( "	WHERE 1=1                           \n");
						if(!str1.equals(""))sql.append( "	  AND A.USESTS = '"+str1+"'         \n");
						if(!str2.equals(""))sql.append( "	  AND A.TEAM_CD =  LIKE '"+str2+"'  \n");
						if(!str3.equals(""))sql.append( "	  AND A.EMPNMK LIKE '"+str3+"%'     \n");
						sql.append( "	ORDER BY A.EMPNO                    \n");

            logger.dbg.println(this,sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}