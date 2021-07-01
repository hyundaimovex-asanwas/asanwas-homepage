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
public class h060012_s12 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1"); //부서
				String  str2= req.getParameter("v_str2"); //사번FR,
				String  str3= req.getParameter("v_str3"); //사번TO 
				String  str4= req.getParameter("v_str4"); //그룹입사일자  
				String  str5= req.getParameter("v_str5"); //생성년월  
				String  str6= req.getParameter("v_str6"); //level
				String  str7= req.getParameter("v_str7"); //treecd
				String  str8= req.getParameter("v_str8"); //고과기준일(format: yyyymmdd)
				String  str9= req.getParameter("v_str9"); //고과기준일(format: yyyy-mm-dd)
                String  str10 = str8.substring(4,8);

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
        if (str7==null ) {str7 ="";}
				if (str8==null ) {str8 ="";}
				if (str9==null ) {str9 ="";}
              
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO",	 "DEPTCD",  "PAYGRD" , "GRSTRTDT",
					                                "STRTDT",	 "WRDT",   "LAMDT",   "RECDIV",  "JOBKIND",
					                                "DEPREF",  "GRSREF", "JOBREF"}; 
					                                             
				int[] intArrCN = new int[]{   6,  7,  4,  4,  8, 
					                            8,  8,  8,  4,  4,
					                            1,  1,  2}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
					                           -1, -1, -1,  -1,  -1,
					                           -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
                    sql.append( " SELECT '"+str5+"' EVAYM,    A.EMPNO,    A.DEPTCD,   A.PAYGRD, A.GRSTRTDT,   \n" );
                    sql.append( "         A.STRTDT,    ' '  WRDT, A.LAMDT, A.RECDIV, A.JOBKIND,  \n");
                    sql.append( " CASE WHEN B.DEPTGB ='1' THEN '1' ELSE '2' END DEPREF, \n");
                    sql.append( " '1' GRSREF, \n");
		  			sql.append( " A.JOBKIND JOBREF \n");
					sql.append( "  FROM PAYROLL.HIPERSON A                                                                                      \n");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                                                            \n");
					sql.append( "  LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                                     \n");
					sql.append( "  WHERE A.USESTS='1'                                                                                           \n");
					sql.append( "    AND A.GRSTRTDT  < '"+str8+"'                                                                               \n");
				//	sql.append( "    AND C.MEMO IN ('20','22')   임원제외부분 풀어 놓음 상향식고과                                               \n");                               \n");
					sql.append( "    AND A.PAYGRD IN ( '000','010','020','030','870','999','880','060','080','120','850','140','150','160','170','180', \n");
					sql.append( "                      '190','830','400','910','070','100','101','050','840','820')                               \n");
					sql.append( "    --신규입사자(그룹입사일 1년 미만 제외)                                                                     \n");
					sql.append( "    AND NOT EXISTS ( SELECT B.EMPNO,B.EMPNMK,B.GRSTRTDT FROM PAYROLL.HIPERSON B                                \n");
					sql.append( "                      WHERE B.GRSTRTDT >( SELECT DISTINCT ((year('"+str9+"')-1)||'"+str10+"')                 \n");
					sql.append( "                                             FROM PAYROLL.HIPERSON C)                                          \n");
					sql.append( "                                                                                                               \n");
                    sql.append( "                        AND B.USESTS='1'                                                                       \n");
					sql.append( "                        AND B.EMPDIV ='1'                                                                      \n");
					sql.append( "                        AND B.RECDIV IN('1','2')                                                               \n");
					sql.append( "                        AND A.EMPNO = B.EMPNO                                                                  \n");
					sql.append( "                   )                                                                                           \n");
					sql.append( "                                                                                                               \n");
					sql.append( "    --경력입사자 (그룹입사일 6개월 미만 제외)                                                                  \n");
					sql.append( "    AND NOT EXISTS ( SELECT D.EMPNO,D.EMPNMK,D.GRSTRTDT FROM PAYROLL.HIPERSON D                                \n");
					sql.append( "                      WHERE (SUBSTR(D.GRSTRTDT,1,4)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(D.GRSTRTDT,5,2)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(D.GRSTRTDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 6 MONTHS)   \n");
					sql.append( "                                                         FROM PAYROLL.HIPERSON E)                              \n");
					sql.append( "                       AND D.USESTS='1'                                                                        \n");
					sql.append( "                       AND D.EMPDIV ='1'                                                                       \n");
					sql.append( "                       AND D.RECDIV IN('3','4')                                                                \n");
					sql.append( "                       AND A.EMPNO = D.EMPNO                                                                   \n");
					sql.append( "                     )                                                                                         \n");
					sql.append( "                                                                                                               \n");
					sql.append( "    --별정직 (그룹입사일 3개월 미만 제외)                                                                      \n");
					sql.append( "    AND NOT EXISTS ( SELECT F.EMPNO,F.EMPNMK,F.GRSTRTDT FROM PAYROLL.HIPERSON F                                \n");
					sql.append( "                      WHERE (SUBSTR(F.GRSTRTDT,1,4)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(F.GRSTRTDT,5,2)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(F.GRSTRTDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 3 MONTHS)   \n");
					sql.append( "                                                         FROM PAYROLL.HIPERSON G)                              \n");
					sql.append( "                       AND F.USESTS='1'                                                                        \n");
					sql.append( "                       AND F.EMPDIV ='2'                                                                       \n");
					sql.append( "                       AND A.EMPNO =F.EMPNO                                                                    \n");
					sql.append( "                     )                                                                                         \n");
					sql.append( "                                                                                                               \n");
					sql.append( "    --계열사 전입자 (그룹입사일 2개월 미만 제외)                                                               \n");
					sql.append( "    AND NOT EXISTS ( SELECT H.EMPNO,MAX(H.APPDT)APPDT FROM PAYROLL.HOORDER H                                   \n");
					sql.append( "                      WHERE (SUBSTR(H.APPDT,1,4)||'-'||                                                        \n");
					sql.append( "                             SUBSTR(H.APPDT,5,2)||'-'||                                                        \n");
					sql.append( "                             SUBSTR(H.APPDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 2 MONTHS)     \n");
					sql.append( "                                                       FROM PAYROLL.HIPERSON J)                                \n");
					sql.append( "                       AND H.ORDCD ='C4'                                                                       \n");
					sql.append( "                       AND A.USESTS='1'                                                                        \n");
					sql.append( "                       AND A.EMPDIV ='1'                                                                       \n");
					sql.append( "                       AND A.EMPNO = H.EMPNO                                                                   \n");
					sql.append( "                       GROUP BY H.EMPNO                                                                        \n");
					sql.append( "                     )                                                                                         \n");
					sql.append( "                                                                                                               \n");
					sql.append( "   --복직(그룹입사일 2개월 미만 제외)                                                                          \n");
					sql.append( "    AND NOT EXISTS ( SELECT K.EMPNO,MAX(K.APPDT)APPDT FROM PAYROLL.HOORDER K                                   \n");
					sql.append( "                      WHERE (SUBSTR(K.APPDT,1,4)||'-'||                                                        \n");
					sql.append( "                             SUBSTR(K.APPDT,5,2)||'-'||                                                        \n");
					sql.append( "                             SUBSTR(K.APPDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 2 MONTHS)     \n");
					sql.append( "                                                       FROM PAYROLL.HIPERSON L)                                \n");
					sql.append( "                       AND K.ORDCD ='C9'                                                                       \n");
					sql.append( "                       AND A.USESTS='1'                                                                        \n");
					sql.append( "                       AND A.EMPDIV ='1'                                                                       \n");
					sql.append( "                       AND A.EMPNO = K.EMPNO                                                                   \n");
          sql.append( "                       GROUP BY K.EMPNO                                                                        \n");
					sql.append( "                     )                                                                                         \n");
                                                                                                                           				
					if (!str2.equals("")&&!str3.equals(""))sql.append( " AND (A.EMPNO >= '" + str2 +"' AND A.EMPNO <= '" + str3 +"') \n");
					if (str6.equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str7 + "' \n");
					if (str6.equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str7 + "'     \n");

					sql.append( " UNION ALL  \n");
          sql.append( "  SELECT '"+str5+"' EVAYM,    P.EMPNO,    P.DEPTCD,   P.PAYGRD,  P.GRSTRTDT,                                         \n");
					sql.append( "         P.STRTDT,    ' '  WRDT, P.LAMDT, P.RECDIV, P.REGDIV AS JOBKIND,                                           \n");
          sql.append( "         CASE WHEN Q.DEPTGB ='1' THEN '1' ELSE '2' END DEPREF,                                                     \n");
					sql.append( "         '2' GRSREF,                                                                                               \n"); 
					sql.append( "         P.REGDIV JOBREF --JOBKIND필드를 다른 용도로 사용해서 REGDIV를 대신 사용함.                    \n"); 
					sql.append( "    FROM PAYROLL.T_HIPERSON P                                                                                      \n"); 
					sql.append( "    LEFT JOIN PAYROLL.HCDEPT Q ON P.DEPTCD = Q.DEPTCD                                                              \n"); 
					sql.append( "    WHERE P.USESTS='1'                                                                                             \n"); 
					sql.append( "      AND P.STRTDT < '"+str8+"'                                                                                    \n"); 
                    sql.append( "      AND P.EMPDIV IN('3','4','6')                                                                                     \n"); 
			    	sql.append( "      AND p.PAYGRD IN ( '000','010','020','030','870','999','880','060','080','120','850','140','150','160','170','180', \n");
					sql.append( "                      '190','830','400','910','070','100','101','050','840','820')                               \n");
					sql.append( "                                                                                                                   \n"); 
					sql.append( "      --파견계약직(입사일 3개월 미만 제외)                                                                         \n"); 
					sql.append( "      AND NOT EXISTS ( SELECT S.EMPNO,S.EMPNMK,S.STRTDT FROM PAYROLL.T_HIPERSON S                                  \n"); 
					sql.append( "                        WHERE (SUBSTR(S.STRTDT,1,4)||'-'||                                                         \n"); 
					sql.append( "                               SUBSTR(S.STRTDT,5,2)||'-'||                                                         \n"); 
					sql.append( "                               SUBSTR(S.STRTDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 3 MONTHS)      \n"); 
					sql.append( "                                                           FROM PAYROLL.T_HIPERSON T)                              \n"); 
					sql.append( "                         AND S.USESTS='1'                                                                          \n"); 
					sql.append( "                         AND S.EMPDIV ='4'                                                                         \n"); 
          sql.append( "                         AND P.EMPNO = S.EMPNO                                                                     \n"); 
          sql.append( "                       )                                                                                           \n"); 
					sql.append( "                                                                                                                   \n"); 
					sql.append( "       --한국인계약직(입사일 3개월 미만 제외)                                                                      \n"); 
          sql.append( "       AND NOT EXISTS ( SELECT U.EMPNO,U.EMPNMK,U.STRTDT FROM PAYROLL.T_HIPERSON U                                 \n");
					sql.append( "                        WHERE (SUBSTR(U.STRTDT,1,4)||'-'||                                                         \n");
					sql.append( "                               SUBSTR(U.STRTDT,5,2)||'-'||                                                         \n");
					sql.append( "                               SUBSTR(U.STRTDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 3 MONTHS)      \n");
					sql.append( "                                                           FROM PAYROLL.T_HIPERSON V)                              \n");
					sql.append( "                         AND U.USESTS='1'                                                                          \n");
					sql.append( "                         AND U.EMPDIV ='3'                                                                         \n");
					sql.append( "                         AND P.EMPNO = U.EMPNO                                                                     \n");
					sql.append( "                       )                                                                                           \n");
          sql.append( "	                                                                                                                \n");   
          sql.append( "    --UNI 신규입사자(그룹입사일 1년 미만 제외)                                                                     \n");
					sql.append( "    AND NOT EXISTS ( SELECT W.EMPNO,W.EMPNMK,W.STRTDT FROM PAYROLL.T_HIPERSON W                                \n");
					sql.append( "                      WHERE W.STRTDT >( SELECT DISTINCT ((year('"+str9+"')-1)||'"+str10+"')                 \n");
					sql.append( "                                             FROM PAYROLL.T_HIPERSON x)                                          \n");
					sql.append( "                                                                                                               \n");
          sql.append( "                        AND W.USESTS='1'                                                                       \n");
					sql.append( "                        AND W.EMPDIV ='6'                                                                      \n");
					sql.append( "                        AND W.RECDIV ='11'                                                               \n");
					sql.append( "                        AND P.EMPNO = W.EMPNO                                                                  \n");
					sql.append( "                   )                                                                                           \n");
					sql.append( "                                                                                                               \n");
					sql.append( "    --UNI 경력입사자 (그룹입사일 6개월 미만 제외)                                                                  \n");
					sql.append( "    AND NOT EXISTS ( SELECT Y.EMPNO,Y.EMPNMK,Y.STRTDT FROM PAYROLL.T_HIPERSON Y                                \n");
					sql.append( "                      WHERE (SUBSTR(Y.STRTDT,1,4)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(Y.STRTDT,5,2)||'-'||                                                     \n");
					sql.append( "                             SUBSTR(Y.STRTDT,7,2))>(SELECT DISTINCT (CAST(('"+str9+"')AS DATE)- 6 MONTHS)   \n");
					sql.append( "                                                         FROM PAYROLL.T_HIPERSON Z)                              \n");
					sql.append( "                       AND Y.USESTS='1'                                                                        \n");
					sql.append( "                       AND Y.EMPDIV ='6'                                                                       \n");
					sql.append( "                       AND Y.RECDIV ='7'                                                                \n");
					sql.append( "                       AND P.EMPNO = Y.EMPNO                                                                   \n");
					sql.append( "                     )                                                                                         \n");
					sql.append( "                                                                                                               \n");
	         					
					if (!str2.equals("")&&!str3.equals(""))sql.append( " AND (P.EMPNO >= '" + str2 +"' AND P.EMPNO <= '" + str3 +"') \n");
					if (str6.equals("1")) sql.append( " AND SUBSTR(Q.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("2")) sql.append( " AND SUBSTR(Q.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("3")) sql.append( " AND SUBSTR(Q.TREECD,1,6) = '"+ str7 + "' \n");
					if (str6.equals("4")) sql.append( " AND RTRIM(Q.TREECD) = '" + str7 + "'     \n");

				  //logger.dbg.println(this, sql.toString());		 

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