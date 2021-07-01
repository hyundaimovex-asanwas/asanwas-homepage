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
public class Em025_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";} //급여년월 
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";} //지급구분 
				String  str3	= req.getParameter("v_str3"); if (str3==null) {str3="";} //소속     
				String  str4	= req.getParameter("v_str4"); if (str4==null) {str4="";} //부서     
				String  str5	= req.getParameter("v_str5"); if (str5==null) {str5="";} //사번     
				String  str6	= req.getParameter("v_str6"); if (str6==null) {str6="";} //대리점   
				String  str7	= req.getParameter("v_str7"); if (str7==null) {str7="";} //구분 0.총계, 1,직영계, 2,면회소, 3.협력업체계, 9. 상세   

				String strPreyymm="";
				String strPreyymmdd="";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "C_PAY_YM",    "C_GROUP",     "C_GROUPNM",   "C_CNT",       "C_BASIC_TOT",
                                          "C_O_TIME_TOT","C_RET_PAY",   "C_REWARD_PAY","C_BON_PAY",   "C_LST_PAY",
					                                "C_PAY_SUM",   "C_TEL_PAY",   "C_ADV_PAY",   "C_TELUBO_PAY","C_TELSAVE_PAY",
					                                "C_ETC_PAY",   "C_DEDUCT_SUM","C_REAL_PAY_SUM", "C_SEQ",
					                                "P_PAY_YM",    "P_GROUP",     "P_GROUPNM",   "P_CNT",       "P_BASIC_TOT",
					                                "P_O_TIME_TOT","P_RET_PAY",   "P_REWARD_PAY","P_BON_PAY",   "P_LST_PAY",
					                                "P_PAY_SUM",   "P_TEL_PAY",   "P_ADV_PAY",   "P_TELUBO_PAY","P_TELSAVE_PAY",
					                                "P_ETC_PAY",   "P_DEDUCT_SUM","P_REAL_PAY_SUM", "P_SEQ"
																			  };

				int[] intArrCN = new int[] {  6,  3, 50,  4, 10,
					                           10, 10, 10, 10, 10,
					                           10, 10, 10, 10, 10,
					                           10, 10, 10,  3,
                                      6,  3, 50,  4, 10,
					                           10, 10, 10, 10, 10,
					                           10, 10, 10, 10, 10,
					                           10, 10, 10,  3
																	 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0, 2,
					                            2,  2,  2, 2, 2,
					                            2,  2,  2, 2, 2,
					                            2,  2,  2, 0,
					                           -1, -1, -1, 0, 2,
					                            2,  2,  2, 2, 2,
					                            2,  2,  2, 2, 2,
					                            2,  2,  2, 0 
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {		

            //급여지급년월 - 1 개월
						StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;

            strPreyymmdd =  str1.substring(0,4)+"-"+str1.substring(4,6)+"-"+"01";
						sql0.append( " SELECT SUBSTR(REPLACE(CAST((CAST('"+strPreyymmdd+"' AS DATE) - 1 MONTH ) AS VARCHAR(10)),'-',''),1,6)   \n" )
							  .append( "   FROM SYSIBM.SYSDUMMY1    \n" );					  
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						while (rs0.next())	{
								strPreyymm=rs0.getString(1);
						}
						rs0.close();
						stmt0.close(); 

						if(str7.equals("0")){
							StringBuffer sql = new StringBuffer();
							/*금강산 근로자관리 급여지급현황*/
							/*총계*/
							sql.append( "	SELECT  \n");
							sql.append( "		X.C_PAY_YM,      X.C_GROUP,   X.C_GROUPNM,   IFNULL(X.C_CNT,0)C_CNT,                                                              \n");
							sql.append( "		IFNULL(X.C_BASIC_TOT,0)C_BASIC_TOT,     IFNULL(X.C_O_TIME_TOT,0)C_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(X.C_RET_PAY,0)C_RET_PAY,         IFNULL(X.C_REWARD_PAY,0)C_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(X.C_BON_PAY,0)C_BON_PAY,         IFNULL(X.C_LST_PAY,0)C_LST_PAY, IFNULL(X.C_PAY_SUM,0)C_PAY_SUM,                           \n");
							sql.append( "		IFNULL(X.C_TEL_PAY,0)C_TEL_PAY,         IFNULL(X.C_ADV_PAY,0)C_ADV_PAY, IFNULL(X.C_TELUBO_PAY,0)C_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(X.C_TELSAVE_PAY,0)C_TELSAVE_PAY, IFNULL(X.C_ETC_PAY,0)C_ETC_PAY, IFNULL(X.C_DEDUCT_SUM,0)C_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(X.C_REAL_PAY_SUM,0)C_REAL_PAY_SUM,  0 AS C_SEQ,                                                                            \n");
							sql.append( "		IFNULL(Y.P_PAY_YM,'')P_PAY_YM,          IFNULL(Y.P_GROUP,'')P_GROUP,    IFNULL(Y.P_GROUPNM,'')P_GROUPNM,  IFNULL(Y.P_CNT,0)P_CNT, \n");
							sql.append( "		IFNULL(Y.P_BASIC_TOT,0)P_BASIC_TOT,     IFNULL(Y.P_O_TIME_TOT,0)P_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(Y.P_RET_PAY,0)P_RET_PAY,         IFNULL(Y.P_REWARD_PAY,0)P_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(Y.P_BON_PAY,0)P_BON_PAY,         IFNULL(Y.P_LST_PAY,0)P_LST_PAY, IFNULL(Y.P_PAY_SUM,0)P_PAY_SUM,                           \n");
							sql.append( "		IFNULL(Y.P_TEL_PAY,0)P_TEL_PAY,         IFNULL(Y.P_ADV_PAY,0)P_ADV_PAY, IFNULL(Y.P_TELUBO_PAY,0)P_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(Y.P_TELSAVE_PAY,0)P_TELSAVE_PAY, IFNULL(Y.P_ETC_PAY,0)P_ETC_PAY, IFNULL(Y.P_DEDUCT_SUM,0)P_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(Y.P_REAL_PAY_SUM,0)P_REAL_PAY_SUM , 0 AS P_SEQ                                                                             \n");
							sql.append( "	  FROM ( SELECT A.PAY_YM AS C_PAY_YM, '000' AS C_GROUP, '총계' AS C_GROUPNM, COUNT(A.EMPNO)C_CNT,     \n");
							/*지급*/
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))C_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))C_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))C_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))C_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))C_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))C_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))C_PAY_SUM,                         \n");
							/*공제*/
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))C_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))C_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))C_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))C_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))C_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))C_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))C_REAL_PAY_SUM                                                  \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.WORK_CD AND B.HEAD='CM007'                                 \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'                                   \n");
							sql.append( "	          WHERE A.PAY_YM='"+str1+"'                                                                          \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM                                                            \n");
							sql.append( "	       ) X                                                                                                   \n");
							sql.append( "	  LEFT JOIN (                                                                                                \n");
							sql.append( "	        SELECT  A.PAY_YM AS P_PAY_YM, '000'  AS P_GROUP, '총계' AS P_GROUPNM, COUNT(A.EMPNO)P_CNT,     \n");
							/*이전월지급*/
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))P_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))P_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))P_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))P_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))P_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))P_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))P_PAY_SUM,                         \n");
							/*이전월공제*/
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))P_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))P_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))P_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))P_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))P_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))P_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))P_REAL_PAY_SUM                                                  \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.WORK_CD AND B.HEAD='CM007'                                 \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'                                   \n");
							sql.append( "	          WHERE A.PAY_YM='"+strPreyymm+"'                                                                    \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM                                                            \n");
							sql.append( "	       ) Y ON Y.P_PAY_YM='"+strPreyymm+"'    AND X.C_GROUP  = Y.P_GROUP                                      \n");

							//logger.dbg.println(this,"총계"+sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
							stmt.executeQuery(dSet);
						}else if(str7.equals("1")||str7.equals("2")||str7.equals("3")){
							StringBuffer sql = new StringBuffer();
							/*금강산 근로자관리 급여지급현황*/
							/*직영계-1, 면회소-2, 협력업체계-3 */

              sql.append( "	SELECT                                                                                                                                    \n");
							sql.append( "	        MAX(X.C_PAY_YM)C_PAY_YM, MAX(X.C_GROUP)C_GROUP,   MIN(X.C_GROUPNM)C_GROUPNM,   IFNULL(SUM(X.C_CNT),0)C_CNT,                       \n");
							sql.append( "	        IFNULL(SUM(X.C_BASIC_TOT),0)C_BASIC_TOT,     IFNULL(SUM(X.C_O_TIME_TOT),0)C_O_TIME_TOT,                                           \n");
							sql.append( "	        IFNULL(SUM(X.C_RET_PAY),0)C_RET_PAY,         IFNULL(SUM(X.C_REWARD_PAY),0)C_REWARD_PAY,                                           \n");
							sql.append( "	        IFNULL(SUM(X.C_BON_PAY),0)C_BON_PAY,         IFNULL(SUM(X.C_LST_PAY),0)C_LST_PAY, IFNULL(SUM(X.C_PAY_SUM),0)C_PAY_SUM,            \n");
							sql.append( "	        IFNULL(SUM(X.C_TEL_PAY),0)C_TEL_PAY,         IFNULL(SUM(X.C_ADV_PAY),0)C_ADV_PAY, IFNULL(SUM(X.C_TELUBO_PAY),0)C_TELUBO_PAY,      \n");
							sql.append( "	        IFNULL(SUM(X.C_TELSAVE_PAY),0)C_TELSAVE_PAY, IFNULL(SUM(X.C_ETC_PAY),0)C_ETC_PAY, IFNULL(SUM(X.C_DEDUCT_SUM),0)C_DEDUCT_SUM,      \n");
							sql.append( "	        IFNULL(SUM(X.C_REAL_PAY_SUM),0)C_REAL_PAY_SUM, 0 AS C_SEQ,                                                                        \n");
							sql.append( "	        IFNULL(MAX(X.P_PAY_YM),'')P_PAY_YM,          IFNULL(MAX(X.P_GROUP),'')P_GROUP,    IFNULL(MIN(X.P_GROUPNM),'')P_GROUPNM,           \n");
							sql.append( "	        IFNULL(SUM(X.P_CNT),0)P_CNT,                                                                                                      \n");
							sql.append( "	        IFNULL(SUM(X.P_BASIC_TOT),0)P_BASIC_TOT,     IFNULL(SUM(X.P_O_TIME_TOT),0)P_O_TIME_TOT,                                           \n");
							sql.append( "	        IFNULL(SUM(X.P_RET_PAY),0)P_RET_PAY,         IFNULL(SUM(X.P_REWARD_PAY),0)P_REWARD_PAY,                                           \n");
							sql.append( "	        IFNULL(SUM(X.P_BON_PAY),0)P_BON_PAY,         IFNULL(SUM(X.P_LST_PAY),0)P_LST_PAY, IFNULL(SUM(X.P_PAY_SUM),0)P_PAY_SUM,            \n");
							sql.append( "	        IFNULL(SUM(X.P_TEL_PAY),0)P_TEL_PAY,         IFNULL(SUM(X.P_ADV_PAY),0)P_ADV_PAY, IFNULL(SUM(X.P_TELUBO_PAY),0)P_TELUBO_PAY,      \n");
							sql.append( "	        IFNULL(SUM(X.P_TELSAVE_PAY),0)P_TELSAVE_PAY, IFNULL(SUM(X.P_ETC_PAY),0)P_ETC_PAY, IFNULL(SUM(X.P_DEDUCT_SUM),0)P_DEDUCT_SUM,      \n");
							sql.append( "	        IFNULL(SUM(X.P_REAL_PAY_SUM),0)P_REAL_PAY_SUM, 0 AS P_SEQ                                                                         \n");
							sql.append( "	      FROM (                                                                                                                              \n");
							sql.append( "	                                                                                                                                          \n");
							sql.append( "	             SELECT A.PAY_YM AS C_PAY_YM,  B.DETAIL AS C_GROUP, B.DETAIL_NM AS C_GROUPNM, COUNT(A.EMPNO)C_CNT,                            \n");
							sql.append( "	                    SUM(IFNULL(A.BASIC_TOT,0))C_BASIC_TOT,  /*지급*/                                                                      \n");
							sql.append( "	                    SUM(IFNULL(A.O_TIME_TOT,0))C_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))C_RET_PAY,                                            \n");
							sql.append( "	                    SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))C_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))C_BON_PAY,      \n");
							sql.append( "	                    SUM(IFNULL(A.LST_PAY,0))C_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))C_PAY_SUM,                                                  \n");
							sql.append( "	                    SUM(IFNULL(A.TEL_PAY,0))C_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))C_ADV_PAY,                                                  \n");
							sql.append( "	                    SUM(IFNULL(A.TELUBO_PAY,0))C_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))C_TELSAVE_PAY,                                    \n");
							sql.append( "	                    SUM(IFNULL(A.ETC_PAY,0))C_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))C_DEDUCT_SUM,                                            \n");
							sql.append( "	                    SUM(IFNULL(A.REAL_PAY_SUM,0))C_REAL_PAY_SUM,                                                                          \n");
							sql.append( "	                    '' P_PAY_YM ,   ''P_GROUP,      ''P_GROUPNM,  0 P_CNT, /*공제*/                                                       \n");
							sql.append( "	                    0 P_BASIC_TOT,   0 P_O_TIME_TOT, 0 P_RET_PAY, 0 P_REWARD_PAY,0 P_BON_PAY,                                             \n");
							sql.append( "	                    0 P_LST_PAY,     0 P_PAY_SUM,    0 P_TEL_PAY, 0 P_ADV_PAY,   0 P_TELUBO_PAY,                                          \n");
							sql.append( "	                    0 P_TELSAVE_PAY, 0 P_ETC_PAY,    0 P_DEDUCT_SUM, 0 P_REAL_PAY_SUM                                                     \n");
							sql.append( "	               FROM SALES.TCM400 A                                                                                                        \n");
							sql.append( "	               LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.VEND_CD AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''                                  \n");
							sql.append( "	              WHERE A.PAY_YM='"+str1+"'                                                                                                   \n");
							sql.append( "	                AND A.PAY_DIV='1'                                                                                                         \n");
							sql.append( "	                AND A.VEND_CD="+str7+"                                                                                                    \n");
							sql.append( "	              GROUP BY A.PAY_YM, B.DETAIL, B.DETAIL_NM                                                                                    \n");
							sql.append( "	              UNION ALL                                                                                                                   \n");
							sql.append( "	             SELECT  '' C_PAY_YM ,   '' C_GROUP,      ''C_GROUPNM,  0 C_CNT,           /*이전월지급*/                                     \n");
							sql.append( "	                     0 C_BASIC_TOT,   0 C_O_TIME_TOT, 0 C_RET_PAY, 0 C_REWARD_PAY,0 C_BON_PAY,                                            \n");
							sql.append( "	                     0 C_LST_PAY,     0 C_PAY_SUM,    0 C_TEL_PAY, 0 C_ADV_PAY,   0 C_TELUBO_PAY,                                         \n");
							sql.append( "	                     0 C_TELSAVE_PAY, 0 C_ETC_PAY,    0 C_DEDUCT_SUM, 0 C_REAL_PAY_SUM,                                                   \n");
							sql.append( "	                     A.PAY_YM AS P_PAY_YM, B.DETAIL AS P_GROUP, B.DETAIL_NM AS P_GROUPNM, COUNT(A.EMPNO)P_CNT,  /*이전월공제*/            \n");
							sql.append( "	                    SUM(IFNULL(A.BASIC_TOT,0))P_BASIC_TOT,                                                                                \n");
							sql.append( "	                    SUM(IFNULL(A.O_TIME_TOT,0))P_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))P_RET_PAY,                                            \n");
							sql.append( "	                    SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))P_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))P_BON_PAY,      \n");
							sql.append( "	                    SUM(IFNULL(A.LST_PAY,0))P_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))P_PAY_SUM,                                                  \n");
							sql.append( "	                    SUM(IFNULL(A.TEL_PAY,0))P_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))P_ADV_PAY,                                                  \n");
							sql.append( "	                    SUM(IFNULL(A.TELUBO_PAY,0))P_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))P_TELSAVE_PAY,                                    \n");
							sql.append( "	                    SUM(IFNULL(A.ETC_PAY,0))P_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))P_DEDUCT_SUM,                                            \n");
							sql.append( "	                    SUM(IFNULL(A.REAL_PAY_SUM,0))P_REAL_PAY_SUM                                                                           \n");
							sql.append( "	               FROM SALES.TCM400 A                                                                                                        \n");
							sql.append( "	               LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.VEND_CD AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''                                  \n");
							sql.append( "	              WHERE A.PAY_YM='"+strPreyymm+"'                                                                                             \n");
							sql.append( "	                AND A.PAY_DIV='1'                                                                                                         \n");
							sql.append( "	                AND A.VEND_CD="+str7+"                                                                                                    \n");
							sql.append( "	              GROUP BY A.PAY_YM, B.DETAIL, B.DETAIL_NM                                                                                    \n");
							sql.append( "	           ) X                                                                                                                            \n");
							
              /*
							sql.append( "	SELECT  \n");
							sql.append( "		X.C_PAY_YM,      X.C_GROUP,   X.C_GROUPNM,   IFNULL(X.C_CNT,0)C_CNT,                                                              \n");
							sql.append( "		IFNULL(X.C_BASIC_TOT,0)C_BASIC_TOT,     IFNULL(X.C_O_TIME_TOT,0)C_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(X.C_RET_PAY,0)C_RET_PAY,         IFNULL(X.C_REWARD_PAY,0)C_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(X.C_BON_PAY,0)C_BON_PAY,         IFNULL(X.C_LST_PAY,0)C_LST_PAY, IFNULL(X.C_PAY_SUM,0)C_PAY_SUM,                           \n");
							sql.append( "		IFNULL(X.C_TEL_PAY,0)C_TEL_PAY,         IFNULL(X.C_ADV_PAY,0)C_ADV_PAY, IFNULL(X.C_TELUBO_PAY,0)C_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(X.C_TELSAVE_PAY,0)C_TELSAVE_PAY, IFNULL(X.C_ETC_PAY,0)C_ETC_PAY, IFNULL(X.C_DEDUCT_SUM,0)C_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(X.C_REAL_PAY_SUM,0)C_REAL_PAY_SUM, 0 AS C_SEQ,                                                                             \n");
							sql.append( "		IFNULL(Y.P_PAY_YM,'')P_PAY_YM,          IFNULL(Y.P_GROUP,'')P_GROUP,    IFNULL(Y.P_GROUPNM,'')P_GROUPNM,  IFNULL(Y.P_CNT,0)P_CNT, \n");
							sql.append( "		IFNULL(Y.P_BASIC_TOT,0)P_BASIC_TOT,     IFNULL(Y.P_O_TIME_TOT,0)P_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(Y.P_RET_PAY,0)P_RET_PAY,         IFNULL(Y.P_REWARD_PAY,0)P_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(Y.P_BON_PAY,0)P_BON_PAY,         IFNULL(Y.P_LST_PAY,0)P_LST_PAY, IFNULL(Y.P_PAY_SUM,0)P_PAY_SUM,                           \n");
							sql.append( "		IFNULL(Y.P_TEL_PAY,0)P_TEL_PAY,         IFNULL(Y.P_ADV_PAY,0)P_ADV_PAY, IFNULL(Y.P_TELUBO_PAY,0)P_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(Y.P_TELSAVE_PAY,0)P_TELSAVE_PAY, IFNULL(Y.P_ETC_PAY,0)P_ETC_PAY, IFNULL(Y.P_DEDUCT_SUM,0)P_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(Y.P_REAL_PAY_SUM,0)P_REAL_PAY_SUM, 0 AS P_SEQ                                                                              \n");
							sql.append( "	  FROM ( SELECT A.PAY_YM AS C_PAY_YM,  B.DETAIL AS C_GROUP, B.DETAIL_NM AS C_GROUPNM, COUNT(A.EMPNO)C_CNT,     \n");
						
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))C_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))C_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))C_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))C_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))C_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))C_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))C_PAY_SUM,                         \n");
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))C_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))C_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))C_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))C_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))C_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))C_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))C_REAL_PAY_SUM                                                  \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.VEND_CD AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''         \n");
							sql.append( "	          WHERE A.PAY_YM='"+str1+"'                                                                          \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	            AND A.VEND_CD='"+str7+"'                                                                         \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.DETAIL,  B.DETAIL_NM                                                          \n");
							sql.append( "	       ) X                                                                                                   \n");
							sql.append( "	  LEFT JOIN (                                                                                                \n");
							sql.append( "	        SELECT  A.PAY_YM AS P_PAY_YM, B.DETAIL AS P_GROUP, B.DETAIL_NM AS P_GROUPNM, COUNT(A.EMPNO)P_CNT,    \n");
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))P_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))P_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))P_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))P_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))P_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))P_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))P_PAY_SUM,                         \n");
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))P_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))P_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))P_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))P_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))P_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))P_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))P_REAL_PAY_SUM                                                  \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.VEND_CD AND B.HEAD='CM019' AND RTRIM(B.DETAIL)<>''         \n");
							sql.append( "	          WHERE A.PAY_YM='"+strPreyymm+"'                                                                    \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	            AND A.VEND_CD='"+str7+"'                                                                         \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.DETAIL,  B.DETAIL_NM                                                          \n");
							sql.append( "	       ) Y ON Y.P_PAY_YM='"+strPreyymm+"'   AND X.C_GROUP  = Y.P_GROUP                                       \n");
							*/

							//logger.dbg.println(this,str7+"::직영,면회소,협력업체::"+sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
							stmt.executeQuery(dSet);
						}else if(str7.equals("9")){
							StringBuffer sql = new StringBuffer();
							/*금강산 근로자관리 급여지급현황*/
							/*직영계 상세*/
              sql.append( "	 SELECT                                                                                                                                    \n");
							sql.append( "	         X.C_PAY_YM,X.C_GROUP,X.C_GROUPNM,   IFNULL(SUM(X.C_CNT),0)C_CNT,                                                                  \n");
							sql.append( "	         IFNULL(SUM(X.C_BASIC_TOT),0)C_BASIC_TOT,     IFNULL(SUM(X.C_O_TIME_TOT),0)C_O_TIME_TOT,                                           \n");
							sql.append( "	         IFNULL(SUM(X.C_RET_PAY),0)C_RET_PAY,         IFNULL(SUM(X.C_REWARD_PAY),0)C_REWARD_PAY,                                           \n");
							sql.append( "	         IFNULL(SUM(X.C_BON_PAY),0)C_BON_PAY,         IFNULL(SUM(X.C_LST_PAY),0)C_LST_PAY, IFNULL(SUM(X.C_PAY_SUM),0)C_PAY_SUM,            \n");
							sql.append( "	         IFNULL(SUM(X.C_TEL_PAY),0)C_TEL_PAY,         IFNULL(SUM(X.C_ADV_PAY),0)C_ADV_PAY, IFNULL(SUM(X.C_TELUBO_PAY),0)C_TELUBO_PAY,      \n");
							sql.append( "	         IFNULL(SUM(X.C_TELSAVE_PAY),0)C_TELSAVE_PAY, IFNULL(SUM(X.C_ETC_PAY),0)C_ETC_PAY, IFNULL(SUM(X.C_DEDUCT_SUM),0)C_DEDUCT_SUM,      \n");
							sql.append( "	         IFNULL(SUM(X.C_REAL_PAY_SUM),0)C_REAL_PAY_SUM, X.C_SEQ,                                                                           \n");
							sql.append( "	         IFNULL(MAX(X.P_PAY_YM),'')P_PAY_YM,          IFNULL(MAX(X.P_GROUP),'')P_GROUP,    IFNULL(MIN(X.P_GROUPNM),'')P_GROUPNM,           \n");
							sql.append( "	         IFNULL(SUM(X.P_CNT),0)P_CNT,                                                                                                      \n");
							sql.append( "	         IFNULL(SUM(X.P_BASIC_TOT),0)P_BASIC_TOT,     IFNULL(SUM(X.P_O_TIME_TOT),0)P_O_TIME_TOT,                                           \n");
							sql.append( "	         IFNULL(SUM(X.P_RET_PAY),0)P_RET_PAY,         IFNULL(SUM(X.P_REWARD_PAY),0)P_REWARD_PAY,                                           \n");
							sql.append( "	         IFNULL(SUM(X.P_BON_PAY),0)P_BON_PAY,         IFNULL(SUM(X.P_LST_PAY),0)P_LST_PAY, IFNULL(SUM(X.P_PAY_SUM),0)P_PAY_SUM,            \n");
							sql.append( "	         IFNULL(SUM(X.P_TEL_PAY),0)P_TEL_PAY,         IFNULL(SUM(X.P_ADV_PAY),0)P_ADV_PAY, IFNULL(SUM(X.P_TELUBO_PAY),0)P_TELUBO_PAY,      \n");
							sql.append( "	         IFNULL(SUM(X.P_TELSAVE_PAY),0)P_TELSAVE_PAY, IFNULL(SUM(X.P_ETC_PAY),0)P_ETC_PAY, IFNULL(SUM(X.P_DEDUCT_SUM),0)P_DEDUCT_SUM,      \n");
							sql.append( "	         IFNULL(SUM(X.P_REAL_PAY_SUM),0)P_REAL_PAY_SUM, X.P_SEQ                                                                            \n");
							sql.append( "	       FROM (                                                                                                                              \n");
							sql.append( "	              SELECT A.PAY_YM AS C_PAY_YM,  B.ITEM2 AS C_GROUP, C.DETAIL_NM AS C_GROUPNM, COUNT(A.EMPNO)C_CNT,  /*지급*/                   \n");
							sql.append( "	                     SUM(IFNULL(A.BASIC_TOT,0))C_BASIC_TOT,                                                                                \n");
							sql.append( "	                     SUM(IFNULL(A.O_TIME_TOT,0))C_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))C_RET_PAY,                                            \n");
							sql.append( "	                     SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))C_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))C_BON_PAY,      \n");
							sql.append( "	                     SUM(IFNULL(A.LST_PAY,0))C_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))C_PAY_SUM,                                                  \n");
							sql.append( "	                     SUM(IFNULL(A.TEL_PAY,0))C_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))C_ADV_PAY,                                                  \n");
							sql.append( "	                     SUM(IFNULL(A.TELUBO_PAY,0))C_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))C_TELSAVE_PAY,                                    \n");
							sql.append( "	                     SUM(IFNULL(A.ETC_PAY,0))C_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))C_DEDUCT_SUM,                                            \n");
							sql.append( "	                     SUM(IFNULL(A.REAL_PAY_SUM,0))C_REAL_PAY_SUM,  C.ITEM2 AS C_SEQ,                    /*공제*/                           \n");
							sql.append( "	                     '' P_PAY_YM ,   ''P_GROUP,      ''P_GROUPNM,  0 P_CNT,                                                                \n");
							sql.append( "	                     0 P_BASIC_TOT,   0 P_O_TIME_TOT, 0 P_RET_PAY, 0 P_REWARD_PAY,0 P_BON_PAY,                                             \n");
							sql.append( "	                     0 P_LST_PAY,     0 P_PAY_SUM,    0 P_TEL_PAY, 0 P_ADV_PAY,   0 P_TELUBO_PAY,                                          \n");
							sql.append( "	                     0 P_TELSAVE_PAY, 0 P_ETC_PAY,    0 P_DEDUCT_SUM, 0 P_REAL_PAY_SUM, 0 AS P_SEQ                                         \n");
							sql.append( "	                FROM SALES.TCM400 A                                                                                                        \n");
							sql.append( "	                LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.TEAM_CD AND B.HEAD='CM003'  AND RTRIM(B.DETAIL_NM)<>''                              \n");
							sql.append( "	                LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'   AND RTRIM(B.ITEM2)<>''                                   \n");
							sql.append( "	               WHERE A.PAY_YM='"+str1+"'                                                                                                   \n");
							sql.append( "	                 AND A.PAY_DIV='1'                                                                                                         \n");
							sql.append( "	                 AND A.VEND_CD=1                                                                                                           \n");
							sql.append( "	               GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM ,C.ITEM2                                                                            \n");
							sql.append( "	               UNION ALL                                                                                                                   \n");
							sql.append( "	              SELECT  '"+str1+"' C_PAY_YM ,   B.ITEM2 AS C_GROUP, C.DETAIL_NM AS C_GROUPNM, 0 C_CNT,        /*이전월지급*/                 \n");
							sql.append( "	                      0 C_BASIC_TOT,   0 C_O_TIME_TOT, 0 C_RET_PAY, 0 C_REWARD_PAY,0 C_BON_PAY,                                            \n");
							sql.append( "	                      0 C_LST_PAY,     0 C_PAY_SUM,    0 C_TEL_PAY, 0 C_ADV_PAY,   0 C_TELUBO_PAY,                                         \n");
							sql.append( "	                      0 C_TELSAVE_PAY, 0 C_ETC_PAY,    0 C_DEDUCT_SUM, 0 C_REAL_PAY_SUM, 0 C_SEQ,                                          \n");
							sql.append( "	                      A.PAY_YM AS P_PAY_YM, B.ITEM2 AS P_GROUP, C.DETAIL_NM AS P_GROUPNM, COUNT(A.EMPNO)P_CNT,                             \n");
							sql.append( "	                     SUM(IFNULL(A.BASIC_TOT,0))P_BASIC_TOT,                                                /*이전월공제*/                  \n");
							sql.append( "	                     SUM(IFNULL(A.O_TIME_TOT,0))P_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))P_RET_PAY,                                            \n");
							sql.append( "	                     SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))P_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))P_BON_PAY,      \n");
							sql.append( "	                     SUM(IFNULL(A.LST_PAY,0))P_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))P_PAY_SUM,                                                  \n");
							sql.append( "	                     SUM(IFNULL(A.TEL_PAY,0))P_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))P_ADV_PAY,                                                  \n");
							sql.append( "	                     SUM(IFNULL(A.TELUBO_PAY,0))P_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))P_TELSAVE_PAY,                                    \n");
							sql.append( "	                     SUM(IFNULL(A.ETC_PAY,0))P_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))P_DEDUCT_SUM,                                            \n");
							sql.append( "	                     SUM(IFNULL(A.REAL_PAY_SUM,0))P_REAL_PAY_SUM,C.ITEM2 AS P_SEQ                                                          \n");
							sql.append( "	                FROM SALES.TCM400 A                                                                                                        \n");
							sql.append( "	                LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.TEAM_CD AND B.HEAD='CM003'  AND RTRIM(B.DETAIL_NM)<>''                              \n");
							sql.append( "	                LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'  AND RTRIM(B.ITEM2)<>''                                    \n");
							sql.append( "	               WHERE A.PAY_YM='"+strPreyymm+"'                                                                                             \n");
							sql.append( "	                 AND A.PAY_DIV='1'                                                                                                         \n");
							sql.append( "	                 AND A.VEND_CD=1                                                                                                           \n");
							sql.append( "	               GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM,C.ITEM2       \n");
							sql.append( "	            ) X                                                                                                                            \n");
							sql.append( "	       GROUP BY X.C_PAY_YM,X.C_GROUP,X.C_GROUPNM, X.C_SEQ, X.P_SEQ \n"); 
							sql.append( "	       ORDER BY X.C_SEQ, X.P_SEQ \n"); 
						
              /*
							sql.append( "	SELECT  \n");
							sql.append( "		X.C_PAY_YM,      X.C_GROUP,   X.C_GROUPNM,   IFNULL(X.C_CNT,0)C_CNT,                                                              \n");
							sql.append( "		IFNULL(X.C_BASIC_TOT,0)C_BASIC_TOT,     IFNULL(X.C_O_TIME_TOT,0)C_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(X.C_RET_PAY,0)C_RET_PAY,         IFNULL(X.C_REWARD_PAY,0)C_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(X.C_BON_PAY,0)C_BON_PAY,         IFNULL(X.C_LST_PAY,0)C_LST_PAY, IFNULL(X.C_PAY_SUM,0)C_PAY_SUM,                           \n");
							sql.append( "		IFNULL(X.C_TEL_PAY,0)C_TEL_PAY,         IFNULL(X.C_ADV_PAY,0)C_ADV_PAY, IFNULL(X.C_TELUBO_PAY,0)C_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(X.C_TELSAVE_PAY,0)C_TELSAVE_PAY, IFNULL(X.C_ETC_PAY,0)C_ETC_PAY, IFNULL(X.C_DEDUCT_SUM,0)C_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(X.C_REAL_PAY_SUM,0)C_REAL_PAY_SUM,  C_SEQ,                                                                                 \n");
							sql.append( "		IFNULL(Y.P_PAY_YM,'')P_PAY_YM,          IFNULL(Y.P_GROUP,'')P_GROUP,    IFNULL(Y.P_GROUPNM,'')P_GROUPNM,  IFNULL(Y.P_CNT,0)P_CNT, \n");
							sql.append( "		IFNULL(Y.P_BASIC_TOT,0)P_BASIC_TOT,     IFNULL(Y.P_O_TIME_TOT,0)P_O_TIME_TOT,                                                     \n");
							sql.append( "		IFNULL(Y.P_RET_PAY,0)P_RET_PAY,         IFNULL(Y.P_REWARD_PAY,0)P_REWARD_PAY,                                                     \n");
							sql.append( "		IFNULL(Y.P_BON_PAY,0)P_BON_PAY,         IFNULL(Y.P_LST_PAY,0)P_LST_PAY, IFNULL(Y.P_PAY_SUM,0)P_PAY_SUM,                           \n");
							sql.append( "		IFNULL(Y.P_TEL_PAY,0)P_TEL_PAY,         IFNULL(Y.P_ADV_PAY,0)P_ADV_PAY, IFNULL(Y.P_TELUBO_PAY,0)P_TELUBO_PAY,                     \n");
							sql.append( "		IFNULL(Y.P_TELSAVE_PAY,0)P_TELSAVE_PAY, IFNULL(Y.P_ETC_PAY,0)P_ETC_PAY, IFNULL(Y.P_DEDUCT_SUM,0)P_DEDUCT_SUM,                     \n");
							sql.append( "		IFNULL(Y.P_REAL_PAY_SUM,0)P_REAL_PAY_SUM,  IFNULL(P_SEQ,0) P_SEQ                                           \n");
							sql.append( "	  FROM ( SELECT A.PAY_YM AS C_PAY_YM, B.ITEM2 AS C_GROUP, C.DETAIL_NM AS C_GROUPNM, COUNT(A.EMPNO)C_CNT,     \n");
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))C_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))C_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))C_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))C_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))C_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))C_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))C_PAY_SUM,                         \n");
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))C_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))C_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))C_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))C_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))C_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))C_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))C_REAL_PAY_SUM ,C.ITEM2 AS C_SEQ                                \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.TEAM_CD AND B.HEAD='CM003'                                 \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'                                   \n");
							sql.append( "	          WHERE A.PAY_YM='"+str1+"'                                                                          \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	            AND A.VEND_CD=1                                                                                  \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM ,C.ITEM2                                                   \n");
							sql.append( "	       ) X                                                                                                   \n");
							sql.append( "	  LEFT JOIN (                                                                                                \n");
							sql.append( "	        SELECT  A.PAY_YM AS P_PAY_YM, B.ITEM2 AS P_GROUP, C.DETAIL_NM AS P_GROUPNM, COUNT(A.EMPNO)P_CNT,     \n");
							sql.append( "	                SUM(IFNULL(A.BASIC_TOT,0))P_BASIC_TOT,                                                       \n");
							sql.append( "	                SUM(IFNULL(A.O_TIME_TOT,0))P_O_TIME_TOT,SUM(IFNULL(A.RET_PAY,0))P_RET_PAY,                   \n");
							sql.append( "	                SUM(IFNULL(A.SEN_PAY,0)+IFNULL(A.AIR_PAY,0)+IFNULL(A.B20_PAY,0))P_REWARD_PAY, SUM(IFNULL(A.BON_PAY,0))P_BON_PAY, \n");
							sql.append( "	                SUM(IFNULL(A.LST_PAY,0))P_LST_PAY,SUM(IFNULL(A.PAY_SUM,0))P_PAY_SUM,                         \n");
							sql.append( "	                SUM(IFNULL(A.TEL_PAY,0))P_TEL_PAY,SUM(IFNULL(A.ADV_PAY,0))P_ADV_PAY,                         \n");
							sql.append( "	                SUM(IFNULL(A.TELUBO_PAY,0))P_TELUBO_PAY,SUM(IFNULL(A.TELSAVE_PAY,0))P_TELSAVE_PAY,           \n");
							sql.append( "	                SUM(IFNULL(A.ETC_PAY,0))P_ETC_PAY,SUM(IFNULL(A.DEDUCT_SUM,0))P_DEDUCT_SUM,                   \n");
							sql.append( "	                SUM(IFNULL(A.REAL_PAY_SUM,0))P_REAL_PAY_SUM, C.ITEM2 AS P_SEQ                      \n");
							sql.append( "	           FROM SALES.TCM400 A                                                                               \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 B ON B.DETAIL=A.TEAM_CD AND B.HEAD='CM003'                                 \n");
							sql.append( "	           LEFT JOIN SALES.TSY010 C ON C.DETAIL=B.ITEM2 AND C.HEAD='CM022'                                   \n");
							sql.append( "	          WHERE A.PAY_YM='"+strPreyymm+"'                                                                    \n");
							sql.append( "	            AND A.PAY_DIV='1'                                                                                \n");
							sql.append( "	            AND A.VEND_CD=1                                                                                  \n");
							sql.append( "	          GROUP BY A.PAY_YM, B.ITEM2, C.DETAIL_NM,C.ITEM2                                                    \n");
							sql.append( "	       ) Y ON Y.P_PAY_YM='"+strPreyymm+"'    AND X.C_GROUP  = Y.P_GROUP                                      \n");
							sql.append( "	  ORDER BY INTEGER(C_SEQ)                                                                                    \n");
							*/

							logger.dbg.println(this,"직영상세::"+sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
							stmt.executeQuery(dSet);
						}
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