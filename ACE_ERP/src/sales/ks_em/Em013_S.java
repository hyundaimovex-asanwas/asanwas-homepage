package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em013_S extends HttpServlet {

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
				String [] str = new String [21];
				str[0]	= req.getParameter("v_str1");		//근무업체        
				str[1]	= req.getParameter("v_str2");		//직종            
				str[2]	= req.getParameter("v_str3");		//계약일 from     
				str[3]	= req.getParameter("v_str4");		//계약일 to       
				str[4]	= req.getParameter("v_str5");		//부서            
				str[5]	= req.getParameter("v_str6");		//인력대리점      
				str[6]	= req.getParameter("v_str7");		//입사일 from     
        str[7]	= req.getParameter("v_str8");		//입사일 to       
				str[8]	= req.getParameter("v_str9");		//소속팀          
				str[9]	= req.getParameter("v_str10");	//국적            
				str[10]	= req.getParameter("v_str11");	//여권만료일 from 
				str[11]	= req.getParameter("v_str12");	//여권만료일 to   
				str[12]	= req.getParameter("v_str13");	//근무지          
				str[13]	= req.getParameter("v_str14");	//민족            
        str[14]	= req.getParameter("v_str15");	//성별            
				str[15]	= req.getParameter("v_str16");	//재직구분        
				str[16]	= req.getParameter("v_str17");	//근속년차        
				str[17]	= req.getParameter("v_str18");	//학력            
				str[18]	= req.getParameter("v_str19");	//송금은행  
				str[19]	= req.getParameter("v_str20");	//송금은행  
				str[20]	= req.getParameter("v_str21");	//송금은행  

				for (int s=0;s<21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				
			 String[] strArrCN = new String[]{ "EMPNO",    "EMPNMK",   "USESTS",    "CON_YEAR",  "CHGYMD",                             
																				 "ORD_CD",   "VEND_CD",  "DEPT_CD",   "TEAM_CD",   "WORK_CD",                            
																				 "JOB_CD",   "SKILL_CD", "AGENCY_CD", "COUNTRY_CD","NATION_CD", "CSTART_DT", 
																				 "CEND_DT",  "ASTART_DT","PASS_NO","PASS_EXPIRE_DATE", "SEX",      
																				 "C_VEND_CD","REM_ACC", "REM_BNK", "SAV_NM", "SAV_TEL",                                  
																				 "HOBBY",    "SPC_NM",  "HEIGHT",  "WEIGHT", "SIZE_UP",                                  
																				 "SIZE_DN",  "SIZE_FT", "SIZE_WT", "BLOOD",  "CHI_NM",                                   
																				 "CHI_RNM",  "CHI_TEL", "CHI_ADD", "ATT_CD", "SCH_NM",                                   
																         "SCH_FR",   "SCH_TO",  "ORD_NM" , "RETGB",  "BLCHK"   
				                                }; 

				int[] intArrCN = new int[] {  	10,	30, 1, 2, 8,
																			 	 3,	10, 5, 5, 5,
																			   5,	 3, 3, 3, 3, 8,
					                               8,  8,20, 8, 1,
					                              10, 30, 3,20,20,
					                              30, 30, 4, 4, 3,
					                               3,  3, 3, 5, 30,
					                              20, 20,50, 2, 30,
					                               6,  6,30, 2, 1
					                               
															     }; 
			
				int[] intArrCN2 = new int[]{ 		-1,	-1,	-1,	 0,	-1,
																				-1,	 0,	-1,	-1, -1,
																				-1,	-1,	-1,	-1,	-1, -1,
					                              -1,	-1,	-1,	-1,	-1,
					                               0,	-1,	-1,	-1,	-1,
					                              -1,	-1,	 1,  0,	-1,
                                        -1,	 0,	 0, -1,	-1, 
					                              -1,	-1,	-1, -1,	-1, 
					                              -1,	-1,	-1, -1, -1
															     };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "SELECT A.EMPNO,    A.EMPNMK,   A.USESTS,    A.CON_YEAR,  A.CHGYMD,                                          \n");
						sql.append( "       A.ORD_CD,   A.VEND_CD,  A.DEPT_CD,   A.TEAM_CD,   A.WORK_CD,                                         \n");
						sql.append( "       A.JOB_CD,   A.SKILL_CD, A.AGENCY_CD, B.COUNTRY_CD,A.NATION_CD, C.START_DT AS CSTART_DT,              \n");
						sql.append( "       C.END_DT AS CEND_DT, A.START_DT AS ASTART_DT,                  \n");
					    sql.append( "       CASE WHEN (B.PASS_NO IS NULL OR RTRIM(B.PASS_NO)='' )THEN A.PASS_NO ELSE B.PASS_NO END PASS_NO,                  \n");
					    sql.append( "       B.PASS_EXPIRE_DATE, B.SEX,                   \n");  
						sql.append( "       A.C_VEND_CD,A.REM_ACC, A.REM_BNK, A.SAV_NM, A.SAV_TEL,                                               \n");
						sql.append( "       A.HOBBY,    A.SPC_NM,  A.HEIGHT,  A.WEIGHT, A.SIZE_UP,                                               \n");
						sql.append( "       A.SIZE_DN,  A.SIZE_FT, A.SIZE_WT, A.BLOOD,  A.CHI_NM,                                                \n");
						sql.append( "       A.CHI_RNM,  A.CHI_TEL, A.CHI_ADD, A.ATT_CD, A.SCH_NM,                                                \n");
						sql.append( "       A.SCH_FR,   A.SCH_TO,  RTRIM(E.DETAIL_NM)ORD_NM , A.RETGB, A.BLCHK                                   \n");
						sql.append( "  FROM SALES.TCM300 A                                                                                       \n");
						sql.append( "  LEFT JOIN SALES.TCU010 B ON A.CUST_SID = B.CUST_SID                                                       \n");
						sql.append( "  LEFT JOIN SALES.TCM345 C ON A.EMPNO = C.EMPNO                                                             \n");
						sql.append( "                          AND C.SEQ = (SELECT MAX(SEQ) FROM SALES.TCM345                                    \n");
						sql.append( "                                        WHERE A.EMPNO =EMPNO)                                               \n");
						sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.ORD_CD) AND E.HEAD='CM012' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( " WHERE 1=1                                                  \n");
						if (!str[0].equals(""))sql.append( "AND A.VEND_CD = '"+str[0]+"'                                    \n");
						if (!str[1].equals(""))sql.append( "AND A.JOB_CD = '"+str[1]+"'                                     \n");
						if (!str[2].equals(""))sql.append( "AND C.START_DT BETWEEN '"+str[2]+"' AND '"+str[3]+"'            \n");
						if (!str[4].equals(""))sql.append( "AND A.DEPT_CD = '"+str[4]+"'                                    \n");
						if (!str[5].equals(""))sql.append( "AND A.AGENCY_CD = '"+str[5]+"'                                  \n");
						if (!str[6].equals(""))sql.append( "AND A.START_DT BETWEEN '"+str[6]+"' AND '"+str[7]+"'            \n");
						if (!str[8].equals(""))sql.append( "AND A.TEAM_CD = '"+str[8]+"'                                    \n");
						if (!str[9].equals(""))sql.append( "AND B.COUNTRY_CD = '"+str[9]+"'                                 \n");
						if (!str[10].equals(""))sql.append( "AND B.PASS_EXPIRE_DATE BETWEEN '"+str[10]+"' AND '"+str[11]+"' \n");
						if (!str[12].equals(""))sql.append( "AND A.WORK_CD = '"+str[12]+"'                                  \n");
						if (!str[13].equals(""))sql.append( "AND A.NATION_CD = '"+str[13]+"'                                \n");
						if (!str[14].equals(""))sql.append( "AND B.SEX = '"+str[14]+"'                                      \n");
						if (!str[15].equals(""))sql.append( "AND A.USESTS = '"+str[15]+"'                                   \n");
						if (!str[16].equals(""))sql.append( "AND A.CON_YEAR = "+str[16]+"                                   \n");
						if (!str[17].equals(""))sql.append( "AND A.ATT_CD = '"+str[17]+"'                                   \n");
						if (!str[18].equals(""))sql.append( "AND A.REM_BNK = '"+str[18]+"'                                  \n");
						if (!str[19].equals(""))sql.append( "AND A.RETGB = '"+str[19]+"'                                  \n");
						if (!str[20].equals(""))sql.append( "AND A.BLCHK = '"+str[20]+"'                                  \n");
						sql.append( "ORDER BY A.START_DT, A.EMPNMK 	\n");
			
						logger.dbg.println(this,"Em013_S"+sql.toString());
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