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
public class h060015BA_s1 extends HttpServlet {

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
				
				String [] str = new String[15];
				str[0]	= req.getParameter("v_str1");  //고과년월
				str[1]	= req.getParameter("v_str2");  //고과자사번
				str[2]	= req.getParameter("v_str3");  //부서코드
				str[3]	= req.getParameter("v_str4");  //level
				str[4]	= req.getParameter("v_str5");  //treecd
				str[5]	= req.getParameter("v_str6");  //직위 FROM     
				str[6]	= req.getParameter("v_str7");  //직위 TO
				str[7]	= req.getParameter("v_str8");  //직종    
				str[8]	= req.getParameter("v_str9");  //고과평정
				str[9]	= req.getParameter("v_str10"); //구분
				str[10] = req.getParameter("v_str11"); //조회[A],실행['']
				
				for(int i=0;i<=10;i++) {
					if(str[i] == null) str[i] = "";
				}
                 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ 
					"EVAYM"			,"GRPNM"			,"EMPNO"		,"EMPNMK",
					"DEPTCD"		,"DEPTNM"			,"PAYGRD"		,"PAYGRDNM",
					"EMPNOH_1"	,"EMPNMH_1"		,"SCR1"			,"AVG1",
					"EMPNOH_2"	,"EMPNMH_2"		,"SCR2"			,"AVG2",
					"EMPNOH_3"	,"EMPNMH_3"		,"SCR3"			,"AVG3",
					"EMPNOH_4"	,"EMPNMH_4"		,"SCR4"			,"AVG4",
					"GOGAGB"		,"SCRAVG"    ,"CORAVG"		,"TOTAVG"
					
				}; 
					                                             
				int[] intArrCN = new int[]{   
					8,  30,  7,  20, 
					4,  50,  4,  30, 
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
					7,  20,  5,  5,
				 20,   5,  5,  5 
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, 
					-1, -1, -1, -1, 
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1, -1,  2,  2,
					-1,  2,  2,  2
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          if (str[9].equals("1")){ //정규직

            sql.append( "  SELECT RTRIM(A.EVAYM) EVAYM,  RTRIM(D.MINORNM) GRPNM, A.EMPNO, RTRIM(E.EMPNMK) EMPNMK,                                                                                         \n");
						sql.append( "          A.DEPTCD, RTRIM(B.DEPTNM) DEPTNM, A.PAYGRD PAYGRD, RTRIM(C.MINORNM) PAYGRDNM,                                                                                          \n");
						sql.append( "          RTRIM(F.EMPNOH) EMPNOH_1    ,RTRIM(J.EMPNMK) EMPNMH_1, COALESCE(A.SCR1,0) SCR1, COALESCE(A.AVG1,0) AVG1,                                                               \n");
						sql.append( "          RTRIM(G.EMPNOH) EMPNOH_2    ,RTRIM(K.EMPNMK) EMPNMH_2, COALESCE(A.SCR2,0) SCR2, COALESCE(A.AVG2,0) AVG2,                                                               \n");
						sql.append( "          RTRIM(H.EMPNOH) EMPNOH_3    ,RTRIM(L.EMPNMK) EMPNMH_3, COALESCE(A.SCR3,0) SCR3, COALESCE(A.AVG3,0) AVG3,                                                               \n");
						sql.append( "          RTRIM(I.EMPNOH) EMPNOH_4    ,RTRIM(M.EMPNMK) EMPNMH_4, COALESCE(A.SCR4,0) SCR4, COALESCE(A.AVG4,0) AVG4,                                                               \n");
						sql.append( "          CASE WHEN A.TOTAVG >= '85' THEN '상'                                                                                                                                   \n");
						sql.append( "          WHEN A.TOTAVG < '85' AND A.TOTAVG >= '75' THEN '중상'                                                                                                                  \n");
						sql.append( "          WHEN A.TOTAVG < '75' AND A.TOTAVG >= '65' THEN '중'                                                                                                                    \n");
						sql.append( "          WHEN A.TOTAVG < '65' AND A.TOTAVG >= '55' THEN '중하'                                                                                                                  \n");
						sql.append( "          WHEN A.TOTAVG < '55' THEN '하' END AS GOGAGB,                                                                                                                          \n");
						sql.append( "          CASE WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'') THEN (A.SCR1+A.SCR2+A.SCR3)/3                                                          \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/2                               \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/1     \n");
						sql.append( "               ELSE 0 END AS SCRAVG ,  \n");
						sql.append( "          CASE WHEN RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'' THEN (A.AVG1+A.AVG2+A.AVG3)/3                                                            \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN  (A.AVG1+A.AVG2+A.AVG3)/2                               \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN (A.AVG1+A.AVG2+A.AVG3)/1      \n");
						sql.append( "               ELSE 0 END AS CORAVG, \n");
						sql.append( "          COALESCE(A.TOTAVG,0) TOTAVG, E.PAYSEQ PAYSEQ, A.STRTDT STRTDT                                                                                                          \n");
						sql.append( "   FROM PAYROLL.HVEMPS A ,PAYROLL.HIPERSON E                                                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT   B ON A.DEPTCD = B.DEPTCD  AND B.CHGYM =  (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                                                                                                                          \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON C.MEMO      =   D.MEMO      AND D.MAJORCD='2014'                                                                                               \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE O ON E.JOBKIND= O.MINORCD AND D.MAJORCD='2034'                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS F ON A.EVAYM = F.EVAYM AND A.EMPNO=F.EMPNO AND F.EVASEQ=1                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS G ON A.EVAYM = G.EVAYM AND A.EMPNO=G.EMPNO AND G.EVASEQ=2                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS H ON A.EVAYM = H.EVAYM AND A.EMPNO=H.EMPNO AND H.EVASEQ=3                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS I ON A.EVAYM = I.EVAYM AND A.EMPNO=I.EMPNO AND I.EVASEQ=4                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON J ON F.EMPNOH=J.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON K ON G.EMPNOH=K.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON L ON H.EMPNOH=L.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON M ON I.EMPNOH=M.EMPNO                                                                                                                              \n");
						sql.append( "   WHERE RTRIM(A.EMPNO) <> ''                                                                                                                                                    \n");
						sql.append( "   AND A.EMPNO=E.EMPNO                                                                                                                                                           \n");
						sql.append( "   AND (A.EMPNO=F.EMPNO OR A.EMPNO=G.EMPNO OR A.EMPNO=H.EMPNO OR A.EMPNO=I.EMPNO)                                                                                                \n");
						if (str[10].equals("A")) {
							sql.append( " AND (E.ENDDT='' OR SUBSTR(E.ENDDT,1,6)>'" + str[0] +"')															\n");
							if (!str[0].equals(""))	sql.append( " AND A.EVAYM = '" + str[0] +"'				/*고과년월*/						\n");
							if (!str[1].equals(""))	{
								sql.append( " AND (F.EMPNOH='"+str[1]+"' OR G.EMPNOH='"+str[1]+"' OR H.EMPNOH='"+str[1]+"' OR I.EMPNOH='"+str[1]+"') ");
							}
							//sql.append( " AND B.DEPTCD LIKE '" + str[2] +"%'																								\n");
							if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[4] + "'									\n");
							if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[4] + "'											\n");
							
							if (!str[5].equals("")&&!str[6].equals(""))	sql.append( " AND C.SEQ	BETWEEN  " + str[5] +"	AND " + str[6] +"	\n");/*직위*/
							//if (!str[7].equals(""))	sql.append( " AND E.JOBKIND	= '" + str[7] +"'			/*직종*/								\n");
							if (str[8].equals("T")) sql.append( " AND ABS(AVG1-AVG2) > 5.00						/*고과평정*/						\n");
							if (!str[9].equals("")) sql.append( " AND A.GRSREF = '"+ str[9] + "' \n");  
						}
						sql.append( "   UNION ALL                                                                                                                                                                     \n");
						sql.append( "   SELECT RTRIM(A.EVAYM) EVAYM,  RTRIM(D.MINORNM) GRPNM, A.EMPNO, RTRIM(E.EMPNMK) EMPNMK,                                                                                        \n");
						sql.append( "          A.DEPTCD, RTRIM(B.DEPTNM) DEPTNM, A.PAYGRD PAYGRD, RTRIM(C.MINORNM) PAYGRDNM,                                                                                          \n");
						sql.append( "          RTRIM(F.EMPNOH) EMPNOH_1    ,COALESCE(J.EMPNMK,RTRIM(P.EMPNMK)) EMPNMH_1, COALESCE(A.SCR1,0) SCR1, COALESCE(A.AVG1,0) AVG1,                                            \n");
						sql.append( "          RTRIM(G.EMPNOH) EMPNOH_2    ,COALESCE(K.EMPNMK,RTRIM(Q.EMPNMK)) EMPNMH_2, COALESCE(A.SCR2,0) SCR2, COALESCE(A.AVG2,0) AVG2,                                            \n");
						sql.append( "          RTRIM(H.EMPNOH) EMPNOH_3    ,COALESCE(L.EMPNMK,RTRIM(R.EMPNMK)) EMPNMH_3, COALESCE(A.SCR3,0) SCR3, COALESCE(A.AVG3,0) AVG3,                                            \n");
						sql.append( "          RTRIM(I.EMPNOH) EMPNOH_4    ,COALESCE(M.EMPNMK,RTRIM(S.EMPNMK)) EMPNMH_4, COALESCE(A.SCR4,0) SCR4, COALESCE(A.AVG4,0) AVG4,                                            \n");
						sql.append( "          CASE WHEN A.TOTAVG >= '85' THEN '상'                                                                                                                                   \n");
						sql.append( "          WHEN A.TOTAVG < '85' AND A.TOTAVG >= '75' THEN '중상'                                                                                                                  \n");
						sql.append( "          WHEN A.TOTAVG < '75' AND A.TOTAVG >= '65' THEN '중'                                                                                                                    \n");
						sql.append( "          WHEN A.TOTAVG < '65' AND A.TOTAVG >= '55' THEN '중하'                                                                                                                  \n");
						sql.append( "          WHEN A.TOTAVG < '55' THEN '하' END AS GOGAGB,                                                                                                                          \n");
						sql.append( "          CASE WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'') THEN (A.SCR1+A.SCR2+A.SCR3)/3                                                          \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/2                               \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/1     \n");
						sql.append( "               ELSE 0 END AS SCRAVG ,  \n");
						sql.append( "          CASE WHEN RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'' THEN (A.AVG1+A.AVG2+A.AVG3)/3                                                            \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN  (A.AVG1+A.AVG2+A.AVG3)/2                               \n");
						sql.append( "               WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN (A.AVG1+A.AVG2+A.AVG3)/1      \n");
						sql.append( "               ELSE 0 END AS CORAVG, \n");
						sql.append( "          COALESCE(A.TOTAVG,0) TOTAVG, E.PAYSEQ PAYSEQ ,A.STRTDT STRTDT                                                                                                          \n");
						sql.append( "   FROM PAYROLL.HVEMPS A ,PAYROLL.T_HIPERSON E                                                                                                                                    \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT   B ON A.DEPTCD = B.DEPTCD  AND B.CHGYM =  (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                                                                   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON C.MEMO   = D.MEMO    AND D.MAJORCD='2014'                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE O ON E.JOBKIND= O.MINORCD AND D.MAJORCD='2034'                                                                                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS F ON A.EVAYM = F.EVAYM AND A.EMPNO=F.EMPNO AND F.EVASEQ=1                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS G ON A.EVAYM = G.EVAYM AND A.EMPNO=G.EMPNO AND G.EVASEQ=2                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS H ON A.EVAYM = H.EVAYM AND A.EMPNO=H.EMPNO AND H.EVASEQ=3                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HVHEMPS I ON A.EVAYM = I.EVAYM AND A.EMPNO=I.EMPNO AND I.EVASEQ=4                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON J ON F.EMPNOH=J.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON K ON G.EMPNOH=K.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON L ON H.EMPNOH=L.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON M ON I.EMPNOH=M.EMPNO                                                                                                                              \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON P ON F.EMPNOH=P.EMPNO                                                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON Q ON G.EMPNOH=Q.EMPNO                                                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON R ON H.EMPNOH=R.EMPNO                                                                                                                            \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON S ON I.EMPNOH=S.EMPNO                                                                                                                            \n");
						sql.append( "   WHERE RTRIM(A.EMPNO) <> ''                                                                                                                                                    \n");
						sql.append( "   AND A.EMPNO=E.EMPNO                                                                                                                                                           \n");
						sql.append( "   AND (A.EMPNO=F.EMPNO OR A.EMPNO=G.EMPNO OR A.EMPNO=H.EMPNO OR A.EMPNO=I.EMPNO)                                                                                                \n");
						if (str[10].equals("A")) {
							sql.append( " AND (E.ENDDT='' OR SUBSTR(E.ENDDT,1,6)>'" + str[0] +"')															\n");
		
							if (!str[0].equals(""))	sql.append( " AND A.EVAYM = '" + str[0] +"'				/*고과년월*/						\n");
							if (!str[1].equals(""))	{
								sql.append( " AND (F.EMPNOH='"+str[1]+"' OR G.EMPNOH='"+str[1]+"' OR H.EMPNOH='"+str[1]+"' OR I.EMPNOH='"+str[1]+"') ");
							}
							//sql.append( " AND B.DEPTCD LIKE '" + str[2] +"%'																								\n");
							if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[4] + "'									\n");
							if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[4] + "'											\n");
							
							if (!str[5].equals("")&&!str[6].equals(""))	sql.append( " AND C.SEQ	BETWEEN  " + str[5] +"	AND " + str[6] +"	\n");/*직위*/
							if (!str[7].equals(""))	sql.append( " AND E.JOBKIND	= '" + str[7] +"'			/*직종*/								\n");
							if (str[8].equals("T")) sql.append( " AND ABS(AVG1-AVG2) > 5.00						/*고과평정*/						\n");
						}
						sql.append( "   AND A.EMPNO IN ('6050004','6050005','6050006','6050007')                                                                                                                      \n");
						sql.append( "   ORDER BY PAYGRD, PAYSEQ DESC,STRTDT                                                                                                                                           \n");
					}else{ //계약직
           
			            sql.append( " SELECT RTRIM(A.EVAYM) EVAYM,  RTRIM(D.MINORNM) GRPNM, A.EMPNO, RTRIM(E.EMPNMK) EMPNMK,                                                                                                                     \n");
						sql.append( "         A.DEPTCD, RTRIM(B.DEPTNM) DEPTNM, A.PAYGRD PAYGRD, RTRIM(C.MINORNM) PAYGRDNM,                                                                                                                      \n");
						sql.append( "         RTRIM(F.EMPNOH) EMPNOH_1    ,RTRIM(J.EMPNMK) EMPNMH_1, COALESCE(A.SCR1,0) SCR1, COALESCE(A.AVG1,0) AVG1,                                                                                           \n");
						sql.append( "         RTRIM(G.EMPNOH) EMPNOH_2    ,RTRIM(K.EMPNMK) EMPNMH_2, COALESCE(A.SCR2,0) SCR2, COALESCE(A.AVG2,0) AVG2,                                                                                           \n");
						sql.append( "         RTRIM(H.EMPNOH) EMPNOH_3    ,RTRIM(L.EMPNMK) EMPNMH_3, COALESCE(A.SCR3,0) SCR3, COALESCE(A.AVG3,0) AVG3,                                                                                           \n");
						sql.append( "         RTRIM(I.EMPNOH) EMPNOH_4    ,RTRIM(M.EMPNMK) EMPNMH_4, COALESCE(A.SCR4,0) SCR4, COALESCE(A.AVG4,0) AVG4,                                                                                           \n");
						sql.append( "         CASE WHEN A.TOTAVG >= '85' THEN '상'                                                                                                                                                               \n");
						sql.append( "         WHEN A.TOTAVG < '85' AND A.TOTAVG >= '75' THEN '중상'                                                                                                                                              \n");
						sql.append( "         WHEN A.TOTAVG < '75' AND A.TOTAVG >= '65' THEN '중'                                                                                                                                                \n");
						sql.append( "         WHEN A.TOTAVG < '65' AND A.TOTAVG >= '55' THEN '중하'                                                                                                                                               \n");
						sql.append( "         WHEN A.TOTAVG < '55' THEN '하' END AS GOGAGB,                                                                                                                                                       \n");
						sql.append( "         CASE WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'') THEN (A.SCR1+A.SCR2+A.SCR3)/3                                                                                       \n");
						sql.append( "              WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/2                                                            \n");
						sql.append( "              WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)=''))  THEN (A.SCR1+A.SCR2+A.SCR3)/1         ELSE 0 END AS SCRAVG,    \n");
						sql.append( "         CASE WHEN RTRIM(F.EMPNOH)<>''  AND RTRIM(G.EMPNOH)<>'' AND RTRIM(H.EMPNOH)<>'' THEN (A.AVG1+A.AVG2+A.AVG3)/3                                                                                        \n");
						sql.append( "              WHEN (RTRIM(F.EMPNOH)<>'' AND RTRIM(G.EMPNOH)<>'' AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN  (A.AVG1+A.AVG2+A.AVG3)/2                                                            \n");
						sql.append( "              WHEN (RTRIM(F.EMPNOH)<>'' AND (RTRIM(G.EMPNOH)IS NULL OR RTRIM(G.EMPNOH)='')AND(RTRIM(H.EMPNOH)IS NULL OR RTRIM(H.EMPNOH)='')) THEN (A.AVG1+A.AVG2+A.AVG3)/1          ELSE 0 END AS CORAVG,    \n");
						sql.append( "         COALESCE(A.TOTAVG,0) TOTAVG, E.PAYSEQ PAYSEQ, A.STRTDT STRTDT                                                                                                                                       \n");
						sql.append( "  FROM PAYROLL.HVEMPS A ,PAYROLL.T_HIPERSON E                                                                                                                                                                 \n");
						sql.append( "  LEFT JOIN PAYROLL.HCDEPT   B ON A.DEPTCD = B.DEPTCD AND B.CHGYM =  (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                                                                                             \n");
						sql.append( "  LEFT JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                                                                                                                                   \n");
						sql.append( "  LEFT JOIN PAYROLL.HCLCODE D ON C.MEMO      =   D.MEMO      AND D.MAJORCD='2014'                                                                                                                            \n");
						sql.append( "  LEFT JOIN PAYROLL.HCLCODE O ON E.JOBKIND= O.MINORCD AND D.MAJORCD='2034'                                                                                                                                   \n");
						sql.append( "  LEFT JOIN PAYROLL.HVHEMPS F ON A.EVAYM = F.EVAYM AND A.EMPNO=F.EMPNO AND F.EVASEQ=1                                                                                                                         \n");
						sql.append( "  LEFT JOIN PAYROLL.HVHEMPS G ON A.EVAYM = G.EVAYM AND A.EMPNO=G.EMPNO AND G.EVASEQ=2                                                                                                                         \n");
						sql.append( "  LEFT JOIN PAYROLL.HVHEMPS H ON A.EVAYM = H.EVAYM AND A.EMPNO=H.EMPNO AND H.EVASEQ=3                                                                                                                         \n");
						sql.append( "  LEFT JOIN PAYROLL.HVHEMPS I ON A.EVAYM = I.EVAYM AND A.EMPNO=I.EMPNO AND I.EVASEQ=4                                                                                                                         \n");
						sql.append( "  LEFT JOIN PAYROLL.HIPERSON J ON F.EMPNOH=J.EMPNO                                                                                                                                                           \n");
						sql.append( "  LEFT JOIN PAYROLL.HIPERSON K ON G.EMPNOH=K.EMPNO                                                                                                                                                           \n");
						sql.append( "  LEFT JOIN PAYROLL.HIPERSON L ON H.EMPNOH=L.EMPNO                                                                                                                                                           \n");
						sql.append( "  LEFT JOIN PAYROLL.HIPERSON M ON I.EMPNOH=M.EMPNO                                                                                                                                                           \n");
						sql.append( "  WHERE RTRIM(A.EMPNO) <> ''                                                                                                                                                                                 \n");
						sql.append( "  AND A.EMPNO=E.EMPNO                                                                                                                                                                                        \n");
						sql.append( "  AND (A.EMPNO=F.EMPNO OR A.EMPNO=G.EMPNO OR A.EMPNO=H.EMPNO OR A.EMPNO=I.EMPNO)                                                                                                                             \n");
						if (str[10].equals("A")) {
							sql.append( " AND (E.ENDDT='' OR SUBSTR(E.ENDDT,1,6)>'" + str[0] +"')															\n");
		
							if (!str[0].equals(""))	sql.append( " AND A.EVAYM = '" + str[0] +"'				/*고과년월*/						\n");
							if (!str[1].equals(""))	{
								sql.append( " AND (F.EMPNOH='"+str[1]+"' OR G.EMPNOH='"+str[1]+"' OR H.EMPNOH='"+str[1]+"' OR I.EMPNOH='"+str[1]+"') ");
							}
							//sql.append( " AND B.DEPTCD LIKE '" + str[2] +"%'																								\n");
							if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[4] + "'									\n");
							if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[4] + "'									\n");
							if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[4] + "'											\n");
							
							if (!str[5].equals("")&&!str[6].equals(""))	sql.append( " AND C.SEQ	BETWEEN  " + str[5] +"	AND " + str[6] +"	\n");/*직위*/
							if (!str[7].equals(""))	sql.append( " AND E.JOBKIND	= '" + str[7] +"'			/*직종*/								\n");
							if (str[8].equals("T")) sql.append( " AND ABS(AVG1-AVG2) > 5.00						/*고과평정*/						\n");
						}
						sql.append( "  AND A.EMPNO NOT IN ('6050004','6050005','6050006','6050007')                                                                                                                                               \n");
					  sql.append( " ORDER BY A.PAYGRD, E.PAYSEQ DESC,A.STRTDT  ");	
				 }
       
					logger.dbg.println(this,sql.toString());

/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				} //IF !GauceReq
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