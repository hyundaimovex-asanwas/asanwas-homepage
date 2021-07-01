package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class p020007_s18 extends HttpServlet {

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
	실제 업무에서 적용하실 부분 - 급여지급현황 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급구분
				str[2]	= req.getParameter("v_str3");		//이전월
				str[3]	= req.getParameter("v_str4");		//발령구분
				
				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);                                
				
				String[] strArrCN = new String[]{
																				"ORDCD",  "ORDNM",    "DEPTCD",  "DEPTNMK",  "ORDDT", 
																				"CHAGDT", "TREECD",   "DEPTCD2", "DEPTNMK2", "TREECD2", 
																				"PAYGRD", "PAYGRDNM", "PAYSEQ",  "EMPNO",    "EMPNMK", 
																				"BSDAY",  "HJDAY",    "FSDAY",   "DAY_SUM",  
																				"P10000", "P11000",   "P12000",  "P21000",   "P22000",
																				"P23000", "P28000",   "P29000",  "P37000",   "P36000","ETC_SUM","COM_SUM", 
																				"P24000", "P32000",   "P35000",  "P31000",   "P39000",
																				"CHG_SUM","TOT_SUM",  "S91000",  "ORDCD2", "ORDNM2"
				};

				int[] intArrCN = new int[]{  
					  4, 30,  4, 20,  8,
						8,  8,  4, 20,  8,
            4, 30,  4,  7, 20,
						2,  2,  2,  2,
            9,  9,  9,  9,  9,
            9,  9,  9,  9,  9, 9, 9,
            9,  9,  9,  9,  9,
						9,  9,  9,   4,  30
          }; 

				int[] intArrCN2 = new int[]{
					 -1, -1, -1, -1, -1,
					 -1, -1, -1, -1, -1,
           -1, -1, -1, -1, -1,
					  0,  0,  0,  0,  
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0, 0, 0,
					  0,  0,  0,  -1, -1 
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					//일반
					sql.append( " SELECT C.ORDCD, D.ORDNM, X.DEPTCD, RTRIM(E.DEPTNMK)DEPTNMK, C.ORDDT,                                                       	\n");
					sql.append( "        RTRIM(IFNULL(X.CHAGDT,''))CHAGDT,E.TREECD,L.DEPTCD DEPTCD2, RTRIM(L.DEPTNMK)DEPTNMK2, SUBSTR(E.TREECD,1,6)||'00' AS TREECD2,                 \n");
					sql.append( "        X.PAYGRD,F.MINORNM||'('||RTRIM(X.PAYSEQ)||')' AS PAYGRDNM,X.PAYSEQ,  X.EMPNO, H.EMPNMK,                                                       	\n");
					sql.append( "        X.BSDAY,X.HJDAY, X.FSDAY, X.BSDAY+X.HJDAY+X.FSDAY AS DAY_SUM,                                                       	\n");
					sql.append( "        X.P10000,X.P11000,X.P12000,X.P21000,X.P22000,                                                                        \n");
					sql.append( "        X.P23000,X.P28000,X.P29000,X.P37000,X.P36000,X.ETC_SUM,X.COM_SUM,                                                                      	\n");
					sql.append( "        X.P24000,X.P32000,X.P35000,X.P31000,X.P39000,                                                                        \n");
					sql.append( "        X.CHG_SUM, X.COM_SUM+X.CHG_SUM AS TOT_SUM,                                                                          	\n");
					sql.append( "        X.S91000,                                                                                                            	\n");
					sql.append( "        CASE WHEN (C.ORDCD='A1'OR C.ORDCD='A2' OR C.ORDCD='A3' OR C.ORDCD='A4' OR C.ORDCD='A9' OR          \n");
					sql.append( "        					 C.ORDCD='C4'OR C.ORDCD='C8' OR C.ORDCD='C9' OR C.ORDCD='F1' OR C.ORDCD='F2')THEN 'A1'   \n");
					sql.append( "        		 WHEN C.ORDCD='C5' THEN 'A2'                                                                   \n");
					sql.append( "        		 WHEN C.ORDCD='C1' THEN 'A3'                                                                   \n");
					sql.append( "        		 WHEN C.ORDCD='C3' THEN 'A4'                                                                   \n");
					sql.append( "        		 WHEN C.ORDCD='A6' THEN C.ORDCD                                                                    \n");
					sql.append( "        		 WHEN C.ORDCD='C7' THEN C.ORDCD                                                                    \n");
					sql.append( "        		 ELSE 'ZZ' END ORDCD2,                                                                         \n");
					sql.append( "        CASE WHEN (C.ORDCD='A1'OR C.ORDCD='A2' OR C.ORDCD='A3' OR C.ORDCD='A4' OR C.ORDCD='A9' OR          \n");
					sql.append( "        					 C.ORDCD='C4'OR C.ORDCD='C8' OR C.ORDCD='C9' OR C.ORDCD='F1' OR C.ORDCD='F2')THEN '입사' \n");
					sql.append( "        		 WHEN C.ORDCD='C5' THEN '퇴사'                                                                 \n");
					sql.append( "        		 WHEN C.ORDCD='C1' THEN '부임'                                                                 \n");
					sql.append( "        		 WHEN C.ORDCD='C3' THEN '복귀'                                                                 \n");
					sql.append( "        		 WHEN C.ORDCD='A6' THEN '대기'                                                                  \n");
					sql.append( "        		 WHEN C.ORDCD='C7' THEN '출산'                                                                  \n");
					sql.append( "        		 ELSE '' END ORDNM2, F.SEQ                                                                     \n");
					sql.append( "   FROM ( SELECT EMPNO,P10000,P11000,P12000,P21000,                                                      	\n");
					sql.append( "                 P22000,P23000,P28000,P29000,P37000,                                                      \n");
					sql.append( "                 P36000,(PX0020+PX0030+PX0040+P25000+P26000+P27000+P30000) AS ETC_SUM, \n");
					sql.append( "                 (P10000+P11000+P12000+P21000+P22000                                                     	\n");
					sql.append( "                 +P23000+P28000+P29000+P37000+P36000+PX0020+PX0030+PX0040+P25000+P26000+P27000+P30000) AS COM_SUM,                   \n");
					sql.append( "                 P24000,P32000,P35000,P31000,P39000,                                                                         \n");
					sql.append( "                 (P24000+P32000+P35000+P31000+P39000) AS CHG_SUM,                                                            \n");
					sql.append( "                 S91000,DEPTCD, PAYGRD, BSDAY, HJDAY,                                                                       	\n");
					sql.append( "                 FSDAY,PAYSEQ,CHAGDT                                                                                        	\n");
					sql.append( "            FROM PAYROLL.PBPAY                                                                                              	\n");
					sql.append( "           WHERE APPDT = '" +str[0]+"'                                                                                     	\n");
					sql.append( "             AND PAYDIV='" +str[1]+"'                                                                                        \n");
					if(str[1].equals("4")){ //휴직급여일경우 대기도 포함 
          sql.append( "          UNION ALL                                                    	\n");
					sql.append( "          SELECT EMPNO,P10000,P11000,P12000,P21000,                                                      	\n");
					sql.append( "                 P22000,P23000,P28000,P29000,P37000,                                                      \n");
					sql.append( "                 P36000,(PX0020+PX0030+PX0040+P25000+P26000+P27000+P30000) AS ETC_SUM, \n");
					sql.append( "                 (P10000+P11000+P12000+P21000+P22000                                                     	\n");
					sql.append( "                 +P23000+P28000+P29000+P37000+P36000+PX0020+PX0030+PX0040+P25000+P26000+P27000+P30000) AS COM_SUM,                   \n");
					sql.append( "                 P24000,P32000,P35000,P31000,P39000,                                                                         \n");
					sql.append( "                 (P24000+P32000+P35000+P31000+P39000) AS CHG_SUM,                                                            \n");
					sql.append( "                 S91000,DEPTCD, PAYGRD, BSDAY, HJDAY,                                                                       	\n");
					sql.append( "                 FSDAY,PAYSEQ,CHAGDT                                                                                        	\n");
					sql.append( "            FROM PAYROLL.PBPAY                                                                                              	\n");
					sql.append( "           WHERE APPDT = '" +str[0]+"'                                                                                     	\n");
					sql.append( "             AND PAYDIV='1'                                                                                        \n");
          sql.append( "             AND DEPTCD='CA00'        \n");
					}
					
					sql.append( "        )X                                                                                                                 \n");
					sql.append( "   LEFT JOIN PAYROLL.HOORDER C ON X.EMPNO = C.EMPNO                                                                          \n");
					sql.append( "                              AND C.ORDDT = ( SELECT MAX(ORDDT)ORDDT FROM PAYROLL.HOORDER                                     \n");
					sql.append( "                                                                    WHERE ORDDT<='" +str[0]+"15'  \n");
					sql.append( "                                                                      AND EMPNO =X.EMPNO )                                    \n");
					sql.append( "   LEFT JOIN PAYROLL.HCORDCOD D ON C.ORDCD = D.ORDCD                                                                          \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON X.DEPTCD = E.DEPTCD                                                                          \n");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON X.PAYGRD = F.MINORCD AND MAJORCD='2002'                                                     \n");
					sql.append( "   LEFT JOIN PAYROLL.HIPERSON H ON X.EMPNO = H.EMPNO                                                                          \n");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT L ON L.TREECD = SUBSTR(E.TREECD,1,6)||'00'                                                        \n");
					sql.append( " ORDER BY ORDCD2,F.SEQ,EMPNO                                                                                                \n");
				
				  logger.dbg.println(this,""+sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
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