package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p020010_s1 extends HttpServlet {

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
				String [] str = new String [2];
				str[0]	= req.getParameter("v_str1");		//현재년월
				str[1]	= req.getParameter("v_str2");		//지급구분

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]	{ 
					 "GUBUN","DEPTNM2","SEQ1","SEQ2","CNT",  "S91AMT",
	  		};	       

				int[] intArrCN = new int[]{  
					20, 20, 3, 3, 3, 11
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, 0, -1, 0, 0 
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT Z.GUBUN,Z.DEPTNM2,1 SEQ1, Z.SEQ2,COUNT(Z.EMPNO) CNT,               \n");
					sql.append( "       SUM(Z.S91000)S91AMT                \n");	
				  sql.append( " FROM                                                                      \n");
					sql.append( " (                                                                         \n");	
					sql.append( " SELECT                                                                    \n");
					sql.append( "        CASE WHEN X.DEPTCD='A050'  THEN '이사회회장실'                     \n");	
					sql.append( "             WHEN X.DEPTCD='A100'  THEN '부회장'                           \n");
					sql.append( "             WHEN X.DEPTCD='A200'  THEN '대표이사'                         \n");
					sql.append( "             WHEN X.DEPTCD='A300'  THEN '상근'                             \n");
					sql.append( "             WHEN X.DEPTCD='A400'  THEN '비상근'                           \n");
					sql.append( "             WHEN X.DEPTCD='A999'  THEN '고문'                             \n");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='C'  THEN '관리지원본부'            \n");	
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='D'  THEN '관광사업본부'            \n");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='B'  THEN '기획본부'                \n");	
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='G'  THEN '건설본부'                \n");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='H'  THEN '개성사업본부'            \n");	
					sql.append( "        ELSE '기타본부' END GUBUN,                                        \n");
					sql.append( "        CASE WHEN X.DEPTCD='A050'  THEN '이사회회장실'                    \n");
					sql.append( "            WHEN X.DEPTCD='A100'  THEN '부회장'                           \n");	
					sql.append( "            WHEN X.DEPTCD='A200'  THEN '대표이사'                         \n");
          sql.append( "            WHEN X.DEPTCD='A300'  THEN '상근'                             \n");
				  sql.append( "            WHEN X.DEPTCD='A400'  THEN '비상근'                           \n");
					sql.append( "            WHEN X.DEPTCD='A999'  THEN '고문'                             \n");	
					sql.append( "            WHEN X.DEPTCD='C000'  THEN '임원'                             \n");
					sql.append( "            WHEN X.DEPTCD='C100'  THEN '총무'                             \n");	
					sql.append( "            WHEN X.DEPTCD='C200'  THEN '경리'                             \n");
					sql.append( "            WHEN X.DEPTCD='D000'  THEN '임원'                             \n");	
					sql.append( "            WHEN X.DEPTCD='D100'  THEN '관광영업부'                       \n");
					sql.append( "            WHEN X.DEPTCD='D200'  THEN '관광개발부'                       \n");	
					sql.append( "            WHEN X.DEPTCD='B000'  THEN '임원'                             \n");
					sql.append( "            WHEN X.DEPTCD='B100'  THEN '기획/해외투자'                    \n");	
					sql.append( "            WHEN X.DEPTCD='B200'  THEN '계약/홍보'                        \n");
					sql.append( "            WHEN X.DEPTCD='G000'  THEN '임원'                             \n");	
					sql.append( "            WHEN X.DEPTCD='G100'  THEN '토목/건축팀'                      \n");
					sql.append( "            WHEN X.DEPTCD='G200'  THEN '기전/견적팀'                      \n");	
					sql.append( "            WHEN (X.DEPTCD='H000' AND X.MEMO='0')  THEN '임원'            \n");
					sql.append( "            WHEN X.DEPTCD='H100'  THEN '사업개발부'                       \n");	
					sql.append( "            WHEN X.DEPTCD='H110'  THEN '총괄기획팀'                       \n");
					sql.append( "            WHEN X.DEPTCD='H120'  THEN '공단지원팀'                       \n");	
          sql.append( "            WHEN (X.DEPTCD='H000' AND X.MEMO<>'0') THEN '개성사업본부'    \n");	
					sql.append( "        ELSE '기타' END DEPTNM2,                                          \n");
					sql.append( "       CASE WHEN X.DEPTCD='A000'  THEN '01'                               \n");	
          sql.append( "            WHEN X.DEPTCD='A050'  THEN '011'                              \n");	
					sql.append( "            WHEN X.DEPTCD='A300'  THEN '012'                              \n");	
					sql.append( "            WHEN X.DEPTCD='A400'  THEN '013'                              \n");	
					sql.append( "            WHEN X.DEPTCD='A100'  THEN '02'                               \n");
					sql.append( "            WHEN X.DEPTCD='A200'  THEN '03'                               \n");	
					sql.append( "            WHEN X.DEPTCD='A999'  THEN '04'                               \n");
					sql.append( "            WHEN X.DEPTCD='C000'  THEN '10'                               \n");	
					sql.append( "            WHEN X.DEPTCD='C100'  THEN '11'                               \n");
					sql.append( "            WHEN X.DEPTCD='C200'  THEN '12'                               \n");	
					sql.append( "            WHEN X.DEPTCD='D000'  THEN '20'                               \n");
					sql.append( "            WHEN X.DEPTCD='D100'  THEN '21'                               \n");	
					sql.append( "            WHEN X.DEPTCD='D200'  THEN '22'                               \n");
					sql.append( "            WHEN X.DEPTCD='B000'  THEN '30'                               \n");	
					sql.append( "            WHEN X.DEPTCD='B100'  THEN '31'                               \n");
					sql.append( "            WHEN X.DEPTCD='B200'  THEN '32'                               \n");	
					sql.append( "            WHEN X.DEPTCD='G000'  THEN '40'                               \n");
					sql.append( "            WHEN X.DEPTCD='G100'  THEN '41'                               \n");	
					sql.append( "            WHEN X.DEPTCD='G200'  THEN '42'                               \n");
					sql.append( "            WHEN(X.DEPTCD='H000' AND X.MEMO='0')   THEN '50'              \n");	
					sql.append( "            WHEN X.DEPTCD='H100'  THEN '51'                               \n");
					sql.append( "            WHEN X.DEPTCD='H110'  THEN '52'                               \n");	
					sql.append( "            WHEN X.DEPTCD='H120'  THEN '53'                               \n");
					sql.append( "            WHEN(X.DEPTCD='H000' AND X.MEMO<>'0') THEN '54'               \n");
					sql.append( "        ELSE '기타' END SEQ2,                                             \n");	
					sql.append( "        X.EMPNO, X.S91000                                                 \n");	
					sql.append( " FROM (                                                                    \n");
					sql.append( "       SELECT '' GUBUN,                                                         \n");	
					sql.append( "             CASE WHEN A.DEPTCD='A000' AND PAYGRD<>'000' THEN 'A999'            \n");
					sql.append( "                  WHEN A.DEPTCD>='C100' AND A.DEPTCD <='C140' THEN 'C100'       \n");	
					sql.append( "                  WHEN A.DEPTCD>='C200' AND A.DEPTCD <='C240' THEN 'C200'       \n");
					sql.append( "                  WHEN A.DEPTCD>='D200' AND A.DEPTCD <='D220' THEN 'D100'       \n");	
          sql.append( "                  WHEN A.DEPTCD>='D100' AND A.DEPTCD <='D130' THEN 'D200'       \n");  
					sql.append( "                  WHEN A.DEPTCD>='B010' AND A.DEPTCD <='B020' THEN 'B100'       \n");	 
					sql.append( "                  WHEN A.DEPTCD>='B030' AND A.DEPTCD <='B040' THEN 'B200'       \n");  
					sql.append( "                  WHEN A.DEPTCD>='G010' AND A.DEPTCD <='G020' THEN 'G100'       \n");	 
					sql.append( "                  WHEN A.DEPTCD>='G030' AND A.DEPTCD <='G041' THEN 'G200'       \n");  
					sql.append( "             ELSE A.DEPTCD END DEPTCD,                                         \n");	 
					sql.append( "             B.DEPTNM, A.PAYGRD,  C.SEQ AS SEQ1, A.EMPNO, A.S91000,D.MEMO      \n");  
					sql.append( "        FROM PAYROLL.PBPAY A                                                      \n");	 
					sql.append( "        LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         \n");  
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' \n");	
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002' \n");				 
					sql.append( "       WHERE A.APPDT='" +str[0]+"'                                                \n");  
					sql.append( "         AND B.GROUPID IN ('01','13','15','16','17','18')                                                       \n");	 
          if (str[1].equals("1")) 
					sql.append( " AND A.PAYDIV IN ( '1','3','4') \n");   //지급구분
					if (str[1].equals("5")) 
					sql.append( " AND A.PAYDIV IN ( '5') \n");   //지급구분

					sql.append( "      )X                                                                        \n");  
					sql.append( " )Z                                                                        \n");	 
					sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                       \n");	 
					sql.append( " UNION ALL                                                                 \n");  
					sql.append( " SELECT C.MINORNM GUBUN, C.MINORNM AS DEPTNM, C.SEQ AS SEQ1, '99' SEQ2,    \n");	 
					sql.append( "        COUNT(A.EMPNO)CNT, SUM(A.S91000) S91AMT      \n");  
					sql.append( "   FROM PAYROLL.PBPAY A                                                      \n");	 
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         \n");  
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' \n");	 
					sql.append( "  WHERE A.APPDT='" +str[0]+"'                                                \n"); 
					sql.append( "    AND B.GROUPID NOT IN ('01','13','15','16','17','18')                                                       \n");	 
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') \n");   //지급구분
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') \n");   //지급구분
					
					sql.append( "  GROUP BY B.GROUPID, C.MINORNM, C.SEQ                                      \n");  
					sql.append( " UNION ALL                                                                 \n");  
					sql.append( " SELECT GUBUN,DEPTNM2,1 SEQ1, SEQ2,                                        \n");  
					sql.append( "        COUNT(EMPNO) CNT , SUM(S91000) S91AMT         \n");	 
					sql.append( " FROM                                                                      \n");  
					sql.append( " (                                                                         \n");	 
					sql.append( " SELECT '' GUBUN ,'소계'DEPTNM2,1 SEQ1,                                    \n");  
					sql.append( "       CASE WHEN SUBSTR(X.DEPTCD,1,1)='C'THEN '13'                        \n");	 
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='D'THEN '23'                        \n");  
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='B'THEN '33'                        \n");	 
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='G'THEN '43'                        \n");  
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='H'THEN '54'                        \n");	 
					sql.append( "        ELSE '기타소계' END SEQ2,                                         \n");  
					sql.append( "        X.EMPNO, X.S91000                                                 \n");	 
					sql.append( "  FROM (                                                                    \n");  
					sql.append( "       SELECT '' GUBUN, A.DEPTCD, B.DEPTNM, C.SEQ AS SEQ1, A.EMPNO, A.S91000     \n");	 
					sql.append( "         FROM PAYROLL.PBPAY A                                                      \n");  
					sql.append( "         LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         \n");	 
					sql.append( "         LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' \n");  
					sql.append( "        WHERE A.APPDT='" +str[0]+"'                                              \n");	 
					sql.append( "          AND B.GROUPID IN ('01','13','15','16','17','18')                                                        \n");  
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') \n");   //지급구분
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') \n");   //지급구분
					
					sql.append( "          AND SUBSTR(A.DEPTCD,1,1) IN ('B','C','D','G','H')                       \n");	 
					sql.append( "      )X                                                                        \n");  
					sql.append( " )Z                                                                        \n");	 
					sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                              \n");
					sql.append( " UNION ALL                                                                  \n");
					sql.append( " SELECT GUBUN,DEPTNM2,1 SEQ1, SEQ2,                                        \n");
					sql.append( "        COUNT(EMPNO) CNT , SUM(S91000) S91AMT                              \n");
					sql.append( " FROM                                                                      \n");
					sql.append( " (                                                                         \n");
					sql.append( "   SELECT '본사총계' GUBUN ,'본사총계'DEPTNM2,1 SEQ1,                        \n");
					sql.append( "        '60' SEQ2,                                                         \n");
					sql.append( "         X.EMPNO, X.S91000                                                 \n");
					sql.append( "    FROM (                                                                    \n");
					sql.append( "          SELECT '' GUBUN, A.DEPTCD, B.DEPTNM, C.SEQ AS SEQ1, A.EMPNO, A.S91000     \n");
          sql.append( "            FROM PAYROLL.PBPAY A                                                      \n");
					sql.append( "            LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         \n");
          sql.append( "            LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' \n");
					sql.append( "           WHERE A.APPDT='" +str[0]+"'                                                     \n");
					sql.append( "             AND B.GROUPID IN ('01','13','15','16','17','18')                                                      \n");
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') \n");   //지급구분
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') \n");   //지급구분
					
					sql.append( "     )X                                                                        \n");
					sql.append( "  )Z                                                                        \n");
          sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                              \n");
					sql.append( " UNION ALL                                                                 \n");  
					sql.append( " SELECT '총계' GUBUN, '총계' MINORNM, 100 AS SEQ1, '99' SEQ2,              \n");  
					sql.append( "         COUNT(A.EMPNO)CNT, SUM(A.S91000) S91AMT                          \n");	 
					sql.append( " FROM PAYROLL.PBPAY A                                                      \n");	 
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         \n");  
					sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' \n");	 
					sql.append( " WHERE A.APPDT='"+str[0]+"'                                               \n");  					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') \n");   //지급구분
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') \n");   //지급구분
					
					sql.append( " ORDER BY SEQ1, SEQ2                                                       \n");  

					//logger.dbg.println(this,sql.toString());

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