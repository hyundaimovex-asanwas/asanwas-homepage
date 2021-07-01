package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050004_s1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		Statement stmt =null;
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
				String [][] idxVal = new String [100][6];
				String str1	= req.getParameter("v_str1");		//기준월
				String str2	= req.getParameter("v_str2");		//부서코드

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTNM","PAYGNM","EMPNMK","EMPNO",
                                          "TEMP1","TEMP2","TEMP3","TEMP4","TEMP5",
                                          "TEMP6","TEMP7","TEMP8","TEMP9","TEMP10",
                                          "TEMP11","TEMP12","TEMP13","TEMP14","TEMP15",
                                          "TEMP16","TEMP17","TEMP18","TEMP19","TEMP20",
                                          "TEMP21","TEMP22","TEMP23","TEMP24","TEMP25",
                                          "TEMP26","TEMP27","TEMP28","TEMP29","TEMP30",
                                          "TEMP31",
                                           "AMT1","AMT2","AMT3","AMT4","AMT5",
                                           "AMT6","AMT7","AMT8","AMT9","AMT10",
                                           "AMT11","AMT12","AMT13","AMT14","AMT15",
                                           "AMT16","AMT17","AMT18","AMT19","AMT20",
                                           "AMT21","AMT22","AMT23","AMT24","AMT25",
                                           "AMT26","AMT27","AMT28","AMT29","AMT30",
                                           "AMT31",
																					"TCNT1","TCNT2","TAMT",
																					"HCNT1","HCNT2","HAMT","ODAY","OAMT" /*,
					                                "OTLAZCD1","OTLAZCD2","OTLAZCD3","OTLAZCD4","OTLAZCD5",
					                                "OTLAZCD6","OTLAZCD7","OTLAZCD8","OTLAZCD9","OTLAZCD10",
					                                "OTLAZCD11","OTLAZCD12","OTLAZCD13","OTLAZCD14","OTLAZCD15",
                                          "OTLAZCD16","OTLAZCD17","OTLAZCD18","OTLAZCD19","OTLAZCD20",
					                                "OTLAZCD21","OTLAZCD22","OTLAZCD23","OTLAZCD24","OTLAZCD25",
					                                "OTLAZCD26","OTLAZCD27","OTLAZCD28","OTLAZCD29","OTLAZCD30",
					                                "OTLAZCD31"
																					*/
																					

																				};

				int[] intArrCN = new int[]{   30, 30, 20,  7,            
                                       1,  1,  1,  1,  1,
                                       1,  1,  1,  1,  1,
                                       1,  1,  1,  1,  1,
                                       1,  1,  1,  1,  1,
                                       1,  1,  1,  1,  1,
                                       1,  1,  1,  1,  1,
                                       1,	
																			7,  7,  7,  7,  7,
																			7,  7,  7,  7,  7,
																			7,  7,  7,  7,  7,
																			7,  7,  7,  7,  7,
																			7,  7,  7,  7,  7,
																			7,  7,  7,  7,  7,
																			7,	
																			 2,  2,  7,
																			 2,  2,  7,  2,  7/*,
					                            4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4,
					                            4, 4, 4, 4, 4,
					                            4
																			*/
																			
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,
					                            0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,
																		  0,  0,  0,
																		  0,  0,  0,  0,  0/*,
					                           -1,  -1 , -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1
																		 */
																		

					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT S.DEPTNM, S.PAYGNM, S.EMPNMK, S.EMPNO, \n") ;
					sql.append( "        SUM(INTEGER(T1))  AS TEMP1, SUM(INTEGER(T2)) AS TEMP2, SUM(INTEGER(T3)) AS TEMP3, SUM(INTEGER(T4)) AS TEMP4, SUM(INTEGER(T5)) AS TEMP5, \n");
					sql.append( "        SUM(INTEGER(T6))  AS TEMP6, SUM(INTEGER(T7)) AS TEMP7, SUM(INTEGER(T8)) AS TEMP8, SUM(INTEGER(T9)) AS TEMP9, SUM(INTEGER(T10)) AS TEMP10, \n");
					sql.append( "        SUM(INTEGER(T11)) AS TEMP11, SUM(INTEGER(T12)) AS TEMP12, SUM(INTEGER(T13)) AS TEMP13, SUM(INTEGER(T14)) AS TEMP14, SUM(INTEGER(T15)) AS TEMP15, \n");
					sql.append( "        SUM(INTEGER(T16)) AS TEMP16, SUM(INTEGER(T17)) AS TEMP17, SUM(INTEGER(T18)) AS TEMP18, SUM(INTEGER(T19)) AS TEMP19, SUM(INTEGER(T20)) AS TEMP20, \n");
					sql.append( "        SUM(INTEGER(T21)) AS TEMP21, SUM(INTEGER(T22)) AS TEMP22, SUM(INTEGER(T23)) AS TEMP23, SUM(INTEGER(T24)) AS TEMP24, SUM(INTEGER(T25)) AS TEMP25, \n");
					sql.append( "        SUM(INTEGER(T26)) AS TEMP26, SUM(INTEGER(T27)) AS TEMP27, SUM(INTEGER(T28)) AS TEMP28, SUM(INTEGER(T29)) AS TEMP29, SUM(INTEGER(T30)) AS TEMP30, \n");
					sql.append( "        SUM(INTEGER(T31)) AS TEMP31, \n");
          sql.append( "	     SUM(INTEGER(AMT1))AS AMT1,  SUM(INTEGER(AMT2))AS AMT2, SUM(INTEGER(AMT3))AS AMT3,               \n");
          sql.append( "	     SUM(INTEGER(AMT4))AS AMT4,  SUM(INTEGER(AMT5))AS AMT5, SUM(INTEGER(AMT6))AS AMT6,               \n");
					sql.append( "      SUM(INTEGER(AMT7))AS AMT7,  SUM(INTEGER(AMT8))AS AMT8, SUM(INTEGER(AMT9))AS AMT9,              \n");
					sql.append( "	     SUM(INTEGER(AMT10))AS AMT10,  SUM(INTEGER(AMT11))AS AMT11, SUM(INTEGER(AMT12))AS AMT12,   \n");
					sql.append( "	     SUM(INTEGER(AMT13))AS AMT13,  SUM(INTEGER(AMT14))AS AMT14, SUM(INTEGER(AMT15))AS AMT15,   \n");
					sql.append( "	     SUM(INTEGER(AMT16))AS AMT16,  SUM(INTEGER(AMT17))AS AMT17, SUM(INTEGER(AMT18))AS AMT18,   \n");
					sql.append( "	     SUM(INTEGER(AMT19))AS AMT19,  SUM(INTEGER(AMT20))AS AMT20, SUM(INTEGER(AMT21))AS AMT21,   \n");
          sql.append( "	     SUM(INTEGER(AMT22))AS AMT22,  SUM(INTEGER(AMT23))AS AMT23, SUM(INTEGER(AMT24))AS AMT24,   \n");
					sql.append( "	     SUM(INTEGER(AMT25))AS AMT25,  SUM(INTEGER(AMT26))AS AMT26, SUM(INTEGER(AMT27))AS AMT27,   \n");
					sql.append( "	     SUM(INTEGER(AMT28))AS AMT28,  SUM(INTEGER(AMT29))AS AMT29, SUM(INTEGER(AMT30))AS AMT30,   \n");
          sql.append( "	     SUM(INTEGER(AMT31))AS AMT31,                                                                                                         \n");
					sql.append( "				 0 AS TCNT1, 0 AS TCNT2, 0 AS TAMT,\n");
					sql.append( "				 0 AS HCNT1, 0 AS HCNT2, 0 AS HAMT,\n");
					sql.append( "				 0 AS ODAY, 0 AS OAMT, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD1),'Z')OTLAZCD1, IFNULL(MAX(OTLAZCD2),'Z')OTLAZCD2,IFNULL(MAX(OTLAZCD3),'Z')OTLAZCD3, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD4),'Z')OTLAZCD4, IFNULL(MAX(OTLAZCD5),'Z')OTLAZCD5,IFNULL(MAX(OTLAZCD6),'Z')OTLAZCD6, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD7),'')OTLAZCD7, IFNULL(MAX(OTLAZCD8),'')OTLAZCD8,IFNULL(MAX(OTLAZCD9),'')OTLAZCD9, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD10),'')OTLAZCD10, IFNULL(MAX(OTLAZCD11),'')OTLAZCD11,IFNULL(MAX(OTLAZCD12),'')OTLAZCD12, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD13),'')OTLAZCD13, IFNULL(MAX(OTLAZCD14),'')OTLAZCD14,IFNULL(MAX(OTLAZCD15),'')OTLAZCD15, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD16),'')OTLAZCD16, IFNULL(MAX(OTLAZCD17),'')OTLAZCD17,IFNULL(MAX(OTLAZCD18),'')OTLAZCD18, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD19),'')OTLAZCD19, IFNULL(MAX(OTLAZCD20),'')OTLAZCD20,IFNULL(MAX(OTLAZCD21),'')OTLAZCD21,  \n");	
					sql.append( "				IFNULL(MAX(OTLAZCD22),'')OTLAZCD22, IFNULL(MAX(OTLAZCD23),'')OTLAZCD23,IFNULL(MAX(OTLAZCD24),'')OTLAZCD24, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD25),'')OTLAZCD25, IFNULL(MAX(OTLAZCD26),'')OTLAZCD26,IFNULL(MAX(OTLAZCD27),'')OTLAZCD27, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD28),'')OTLAZCD28, IFNULL(MAX(OTLAZCD29),'')OTLAZCD29,IFNULL(MAX(OTLAZCD30),'')OTLAZCD30, \n");
					sql.append( "				IFNULL(MAX(OTLAZCD31),'')OTLAZCD31	\n");	
					sql.append( "   FROM ( \n");
					sql.append( " SELECT T.DEPTNM, T.PAYGNM, T.EMPNMK, T.EMPNO, T.APPDT, \n");
					sql.append( "				 CASE T.APPDT WHEN '01' THEN INTEGER('1') END AS T1, \n");
					sql.append( "				 CASE T.APPDT WHEN '02' THEN INTEGER('1') END AS T2, \n");
					sql.append( "				 CASE T.APPDT WHEN '03' THEN INTEGER('1') END AS T3, \n");
					sql.append( "				 CASE T.APPDT WHEN '04' THEN INTEGER('1') END AS T4, \n");
					sql.append( "				 CASE T.APPDT WHEN '05' THEN INTEGER('1') END AS T5, \n");
					sql.append( "				 CASE T.APPDT WHEN '06' THEN INTEGER('1') END AS T6, \n");
					sql.append( "				 CASE T.APPDT WHEN '07' THEN INTEGER('1') END AS T7, \n");
					sql.append( "				 CASE T.APPDT WHEN '08' THEN INTEGER('1') END AS T8, \n");
					sql.append( "				 CASE T.APPDT WHEN '09' THEN INTEGER('1') END AS T9, \n");
					sql.append( "				 CASE T.APPDT WHEN '10' THEN INTEGER('1') END AS T10, \n");
					sql.append( "				 CASE T.APPDT WHEN '11' THEN INTEGER('1') END AS T11, \n");
					sql.append( "				 CASE T.APPDT WHEN '12' THEN INTEGER('1') END AS T12, \n");
					sql.append( "				 CASE T.APPDT WHEN '13' THEN INTEGER('1') END AS T13, \n");
					sql.append( "				 CASE T.APPDT WHEN '14' THEN INTEGER('1') END AS T14, \n");
					sql.append( "				 CASE T.APPDT WHEN '15' THEN INTEGER('1') END AS T15, \n");
					sql.append( "				 CASE T.APPDT WHEN '16' THEN INTEGER('1') END AS T16, \n");
					sql.append( "				 CASE T.APPDT WHEN '17' THEN INTEGER('1') END AS T17, \n");
					sql.append( "				 CASE T.APPDT WHEN '18' THEN INTEGER('1') END AS T18, \n");
					sql.append( "				 CASE T.APPDT WHEN '19' THEN INTEGER('1') END AS T19, \n");
					sql.append( "				 CASE T.APPDT WHEN '20' THEN INTEGER('1') END AS T20, \n");
					sql.append( "				 CASE T.APPDT WHEN '21' THEN INTEGER('1') END AS T21, \n");
					sql.append( "				 CASE T.APPDT WHEN '22' THEN INTEGER('1') END AS T22, \n");
					sql.append( "				 CASE T.APPDT WHEN '23' THEN INTEGER('1') END AS T23, \n");
					sql.append( "				 CASE T.APPDT WHEN '24' THEN INTEGER('1') END AS T24, \n");
					sql.append( "				 CASE T.APPDT WHEN '25' THEN INTEGER('1') END AS T25, \n");
					sql.append( "				 CASE T.APPDT WHEN '26' THEN INTEGER('1') END AS T26, \n");
					sql.append( "				 CASE T.APPDT WHEN '27' THEN INTEGER('1') END AS T27, \n");
					sql.append( "				 CASE T.APPDT WHEN '28' THEN INTEGER('1') END AS T28, \n");
					sql.append( "				 CASE T.APPDT WHEN '29' THEN INTEGER('1') END AS T29, \n");
					sql.append( "				 CASE T.APPDT WHEN '30' THEN INTEGER('1') END AS T30, \n");
					sql.append( "				 CASE T.APPDT WHEN '31' THEN INTEGER('1') END AS T31, \n");
          sql.append( "        CASE T.APPDT WHEN '01' THEN T.AMT END AS AMT1,      \n");
          sql.append( "        CASE T.APPDT WHEN '02' THEN T.AMT END AS AMT2,      \n");
					sql.append( "        CASE T.APPDT WHEN '03' THEN T.AMT END AS AMT3,      \n");
					sql.append( "        CASE T.APPDT WHEN '04' THEN T.AMT END AS AMT4,      \n");
					sql.append( "        CASE T.APPDT WHEN '05' THEN T.AMT END AS AMT5,      \n");
					sql.append( "        CASE T.APPDT WHEN '06' THEN T.AMT END AS AMT6,      \n");
					sql.append( "        CASE T.APPDT WHEN '07' THEN T.AMT END AS AMT7,      \n");
          sql.append( "        CASE T.APPDT WHEN '08' THEN T.AMT END AS AMT8,      \n");
					sql.append( "        CASE T.APPDT WHEN '09' THEN T.AMT END AS AMT9,      \n");
					sql.append( "        CASE T.APPDT WHEN '10' THEN T.AMT END AS AMT10,     \n");
          sql.append( "        CASE T.APPDT WHEN '11' THEN T.AMT END AS AMT11,     \n");
          sql.append( "        CASE T.APPDT WHEN '12' THEN T.AMT END AS AMT12,     \n");
					sql.append( "        CASE T.APPDT WHEN '13' THEN T.AMT END AS AMT13,     \n");
					sql.append( "        CASE T.APPDT WHEN '14' THEN T.AMT END AS AMT14,     \n");
					sql.append( "        CASE T.APPDT WHEN '15' THEN T.AMT END AS AMT15,     \n");
					sql.append( "        CASE T.APPDT WHEN '16' THEN T.AMT END AS AMT16,     \n");
					sql.append( "        CASE T.APPDT WHEN '17' THEN T.AMT END AS AMT17,     \n");
					sql.append( "        CASE T.APPDT WHEN '18' THEN T.AMT END AS AMT18,     \n");
          sql.append( "        CASE T.APPDT WHEN '19' THEN T.AMT END AS AMT19,     \n");
					sql.append( "        CASE T.APPDT WHEN '20' THEN T.AMT END AS AMT20,     \n");
					sql.append( "        CASE T.APPDT WHEN '21' THEN T.AMT END AS AMT21,     \n");
					sql.append( "        CASE T.APPDT WHEN '22' THEN T.AMT END AS AMT22,     \n");
					sql.append( "        CASE T.APPDT WHEN '23' THEN T.AMT END AS AMT23,     \n");
					sql.append( "        CASE T.APPDT WHEN '24' THEN T.AMT END AS AMT24,     \n");
          sql.append( "        CASE T.APPDT WHEN '25' THEN T.AMT END AS AMT25,     \n");
					sql.append( "        CASE T.APPDT WHEN '26' THEN T.AMT END AS AMT26,     \n");
					sql.append( "        CASE T.APPDT WHEN '27' THEN T.AMT END AS AMT27,     \n");
          sql.append( "        CASE T.APPDT WHEN '28' THEN T.AMT END AS AMT28,     \n");
          sql.append( "        CASE T.APPDT WHEN '29' THEN T.AMT END AS AMT29,     \n");
					sql.append( "        CASE T.APPDT WHEN '30' THEN T.AMT END AS AMT30,     \n");
					sql.append( "        CASE T.APPDT WHEN '31' THEN T.AMT END AS AMT31,      \n");
          
					sql.append( "        CASE T.APPDT WHEN '01' THEN IFNULL(T.OTLAZCD,'') ELSE 'C' END AS OTLAZCD1, \n");
					sql.append( "        CASE T.APPDT WHEN '02' THEN IFNULL(RTRIM(T.OTLAZCD),'') ELSE 'C' END AS OTLAZCD2, \n");
					sql.append( "        CASE T.APPDT WHEN '03' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD3, \n");
          sql.append( "        CASE T.APPDT WHEN '04' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD4, \n");
					sql.append( "        CASE T.APPDT WHEN '05' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD5, \n");
					sql.append( "        CASE T.APPDT WHEN '06' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD6, \n");
					sql.append( "        CASE T.APPDT WHEN '07' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD7, \n");
					sql.append( "        CASE T.APPDT WHEN '08' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD8, \n");
          sql.append( "        CASE T.APPDT WHEN '09' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD9, \n");
					sql.append( "        CASE T.APPDT WHEN '10' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD10,\n");
					sql.append( "        CASE T.APPDT WHEN '11' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD11,\n");
					sql.append( "        CASE T.APPDT WHEN '12' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD12,\n");
					sql.append( "        CASE T.APPDT WHEN '13' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD13,\n");
          sql.append( "        CASE T.APPDT WHEN '14' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD14,\n");
					sql.append( "        CASE T.APPDT WHEN '15' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD15,\n");
					sql.append( "        CASE T.APPDT WHEN '16' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD16,\n");
					sql.append( "        CASE T.APPDT WHEN '17' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD17,\n");
					sql.append( "        CASE T.APPDT WHEN '18' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD18,\n");
          sql.append( "        CASE T.APPDT WHEN '19' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD19,\n");
					sql.append( "        CASE T.APPDT WHEN '20' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD20,\n");
					sql.append( "        CASE T.APPDT WHEN '21' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD21,\n");
					sql.append( "        CASE T.APPDT WHEN '22' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD22,\n");
					sql.append( "        CASE T.APPDT WHEN '23' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD23,\n");
          sql.append( "        CASE T.APPDT WHEN '24' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD24,\n");
					sql.append( "        CASE T.APPDT WHEN '25' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD25,\n");
					sql.append( "        CASE T.APPDT WHEN '26' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD26,\n");
					sql.append( "        CASE T.APPDT WHEN '27' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD27,\n");
					sql.append( "        CASE T.APPDT WHEN '28' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD28,\n");
          sql.append( "        CASE T.APPDT WHEN '29' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD29,\n");
					sql.append( "        CASE T.APPDT WHEN '30' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD30,\n");
					sql.append( "        CASE T.APPDT WHEN '31' THEN IFNULL(T.OTLAZCD,'')  END AS OTLAZCD31 \n");
					
					sql.append( "   FROM ( \n");
					sql.append( "     SELECT G.DEPTNM, C.MINORNM PAYGNM,   \n");
          sql.append( "            CASE WHEN A.EMPNMK ='' OR A.EMPNMK IS NULL THEN E.EMPNMK ELSE A.EMPNMK END AS EMPNMK, \n");
					 sql.append( "           D.EMPNO, SUBSTR(D.FRDT,7,2) AS APPDT, \n");
					sql.append( "						 COUNT(D.LAZCD) AS TCNT , IFNULL(SUM(D.AMT),0) AMT, MAX(IFNULL(D.OTLAZCD,'A'))OTLAZCD \n");
					sql.append( "       FROM PAYROLL.HLDUTY D \n");
					sql.append( "       LEFT JOIN PAYROLL.HIPERSON A ON D.EMPNO = A.EMPNO \n");
					sql.append( "       LEFT JOIN PAYROLL.T_HIPERSON E ON D.EMPNO = E.EMPNO \n");
					sql.append( "       LEFT JOIN PAYROLL.HCDEPT B ON D.DEPTCD = B.DEPTCD AND B.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "       LEFT JOIN PAYROLL.HCLCODE C ON D.PAYSEQ = C.MINORCD AND C.MAJORCD='2002' \n");
					sql.append( "       LEFT JOIN PAYROLL.HCDEPT G ON SUBSTR(B.TREECD,1,6)||'00' = G.TREECD                \n");
					sql.append( "                                     AND G.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
					sql.append( "      WHERE SUBSTRING(D.LAZCD,1,1) = 'S'  \n");
					sql.append( "        AND SUBSTR(D.FRDT,1,6) = '" + str1 + "' \n");
					sql.append( "     GROUP BY G.DEPTNM, C.MINORNM, CASE WHEN A.EMPNMK ='' OR A.EMPNMK IS NULL THEN E.EMPNMK ELSE A.EMPNMK END, D.EMPNO, SUBSTR(D.FRDT,7,2) \n");
					sql.append( "     ORDER BY CASE WHEN A.EMPNMK ='' OR A.EMPNMK IS NULL THEN E.EMPNMK ELSE A.EMPNMK END, D.EMPNO ) T \n");
					sql.append( " ) S GROUP BY S.DEPTNM, S.PAYGNM, S.EMPNMK, S.EMPNO \n");

					
          

//					if (!str1.equals("")) sql.append( " AND A.USESTS = '" + str1 + "' ");
//					if (!str2.equals("")) sql.append( " AND A.DEPTCD = '" + str2 + "' ");
         
				 	logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());

					int icnt = 0;
					while(rs.next()){
						GauceDataRow row = dSet.newDataRow();
		   	 		row = dSet.newDataRow();
						for (int k=1;k<strArrCN.length ;k++ ) {
							if (k<5) {
								//logger.dbg.println(this,k+"::"+rs.getString(k));
								row.addColumnValue(rs.getString(k));
								//row.addColumnValue(new String(rs.getString(k).getBytes("KSC5601"),"8859_1"));
							}else{
								row.addColumnValue(rs.getDouble(k));
								//logger.dbg.println(this,k+"::"+rs.getDouble(k));
							}
						}
 		  			dSet.addDataRow(row);
					}

					if (rs!=null) rs.close();
				}
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