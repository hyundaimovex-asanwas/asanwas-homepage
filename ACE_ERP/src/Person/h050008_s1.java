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
public class h050008_s1 extends HttpServlet {

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

				String [] str = new String[10];
        str[0] =  req.getParameter("v_str1"); // from 일자 
				str[1] =  req.getParameter("v_str2"); // to 일자   
				str[2] =  req.getParameter("v_str3"); // from 사번 
				str[3] =  req.getParameter("v_str4");	// to 사번   
				str[4] =  req.getParameter("v_str5");	// 성명      
				str[5] =  req.getParameter("v_str6"); // 근태구분  
				str[6] =  req.getParameter("v_str7"); // 부서      
				str[7] =  req.getParameter("v_str8"); // 직위			
				str[8] =  req.getParameter("v_str9"); // 결재상태			
				str[9] =  req.getParameter("v_str10"); // 구분(""전체, R-정규직, T-계약직	)		

        for(int i=0;i<=9;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"LAZCD",		"DEPTCD",		"PAYSEQ",
																					"FRDT",			"TODT",			"FRTIME",		"TOTIME",		"DTYREM",
																					"CLOSYN",		"SGDT",			"SGNID",		"AGRDT",		"AGRID",
																					"PAYDT",		"AMT",			"DEPTNM",		"MINORNM",	"EMPNMK",
																					"LAZFEENM", 
																					"MINORCD",	"ATTTIME",  "CLOTIME",  "CHK",      "OTLAZCD",
					                                "DIVCD",    "DIVNM",    "HLNO"
																			  }; 

				int[] intArrCN = new int[]{ 8,  7,  4,  4,  4,
																		8,  8,  6,  6, 40,
																		1,  8,  7,  8,  7,
																		8,  7, 50, 30, 20,
																		20,  
																		4,  6,  6,  1,  4,
					                          4,  50, 14
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0, -1, -1, -1,
																		 -1, 
																		 -1, -1, -1, -1, -1,
					                           -1, -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					if(str[9].equals("")||str[9].equals("R")){
						sql.append( " SELECT D.APPDT ,RTRIM(D.EMPNO) AS EMPNO, RTRIM(D.LAZCD)AS LAZCD,                              \n");
						sql.append( " 			 D.DEPTCD, RTRIM(D.PAYSEQ) AS PAYSEQ,                                                    \n");
						sql.append( " 			 D.FRDT, D.TODT, RTRIM(D.FRTIME) AS FRTIME,                                              \n");
						sql.append( " 			 RTRIM(D.TOTIME) AS TOTIME, RTRIM(D.DTYREM) AS DTYREM,                                   \n");
						sql.append( " 			 D.CLOSYN, D.SGDT, D.SGNID, D.AGRDT, D.AGRID,                                            \n");
						sql.append( " 			 D.PAYDT, COALESCE(D.AMT,0) AS AMT, RTRIM(C.DEPTNM) DEPTNM, RTRIM(B.MINORNM) AS MINORNM, \n");
						sql.append( " 			 RTRIM(A.EMPNMK) AS EMPNMK, RTRIM(E.LAZFEENM) AS LAZFEENM,                               \n");
						sql.append( " 			 RTRIM(B.MINORCD) AS MINORCD,          \n");
						sql.append( " 			 H.ATTTIME, H.CLOTIME , ''CHK,  RTRIM(D.OTLAZCD) AS OTLAZCD, I.DEPTCD AS DIVCD,RTRIM(I.DEPTNMK) AS DIVNM , D.HLNO \n");
						sql.append( "   FROM PAYROLL.HLDUTY D                                   \n");
						sql.append( "   LEFT JOIN PAYROLL.HIPERSON A ON D.EMPNO = A.EMPNO       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE  B ON B.MINORCD = A.PAYGRD AND B.MAJORCD='2002'                  \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT   C ON D.DEPTCD  = C.DEPTCD \n");
						sql.append( "                               AND C.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT  \n");
						sql.append( "                                              WHERE CHGYM <=D.FRDT ) \n");
						sql.append( "   LEFT JOIN PAYROLL.HCHOLFEE E ON D.LAZCD   = E.LAZCD                                        \n");
						sql.append( "   LEFT JOIN PAYROLL.HLATTEND H ON D.EMPNO = H.EMPNO AND H.ATTDAY = D.FRDT                    \n");
            sql.append( "   LEFT JOIN PAYROLL.HCDEPT   I ON SUBSTR(C.TREECD,1,6)||'00'  = I.TREECD           \n");
						sql.append( "                               AND I.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT \n");
						sql.append( "                                              WHERE CHGYM <= D.FRDT) \n");
						sql.append( "  WHERE D.LAZCD LIKE 'S%' AND A.USESTS = '1' \n");  
						sql.append( "    AND SUBSTR(A.EMPNO,1,1) IN ('1','2') \n");    
						sql.append( "    AND ((D.FRDT >='"+str[0]+"' AND D.FRDT <='"+str[1]+"')                    \n");
						sql.append( "     OR  (D.TODT >='"+str[0]+"' AND D.TODT <='"+str[1]+"'))                   \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( " AND D.EMPNO BETWEEN '"+str[2]+"' AND '"+str[3]+"' \n");
						if(!str[4].equals(""))sql.append( " AND (A.EMPNMK LIKE '"+str[4]+"%' OR A.EMPNMK LIKE '"+str[4]+"%') \n");
						if(!str[5].equals(""))sql.append( " AND D.LAZCD ='"+str[5]+"'                               \n");
						if(!str[6].equals(""))sql.append( " AND D.DEPTCD ='"+str[6]+"'                              \n");
						if(!str[7].equals(""))sql.append( " AND D.PAYSEQ ='"+str[7]+"'                              \n");
						if(!str[8].equals(""))sql.append( " AND D.CLOSYN ='"+str[8]+"'                              \n");
					}

					if(str[9].equals("")){
						sql.append( " UNION ALL --계약직                              \n");
					}

          if(str[9].equals("")||str[9].equals("T")){
						sql.append( " SELECT D.APPDT ,RTRIM(D.EMPNO) AS EMPNO, RTRIM(D.LAZCD) AS LAZCD,                              \n");
						sql.append( " 			 D.DEPTCD, RTRIM(D.PAYSEQ) AS PAYSEQ,                                                    \n");
						sql.append( " 			 D.FRDT, D.TODT, RTRIM(D.FRTIME) AS FRTIME,                                              \n");
						sql.append( " 			 RTRIM(D.TOTIME) AS TOTIME, RTRIM(D.DTYREM) AS DTYREM,                                   \n");
						sql.append( " 			 D.CLOSYN, D.SGDT, D.SGNID, D.AGRDT, D.AGRID,                                            \n");
						sql.append( " 			 D.PAYDT, COALESCE(D.AMT,0) AS AMT, RTRIM(C.DEPTNM) DEPTNM, RTRIM(B.MINORNM) AS MINORNM, \n");
						sql.append( " 			 RTRIM(A.EMPNMK) AS EMPNMK, RTRIM(E.LAZFEENM) AS LAZFEENM,                               \n");
						sql.append( " 			 RTRIM(B.MINORCD) AS MINORCD,          \n");
						sql.append( " 			 H.ATTTIME, H.CLOTIME , ''CHK,  RTRIM(D.OTLAZCD) AS OTLAZCD,I.DEPTCD AS DIVCD,I.DEPTNMK AS DIVNM, D.HLNO  \n");
						sql.append( "   FROM PAYROLL.HLDUTY D                                   \n");
						sql.append( "   LEFT JOIN PAYROLL.T_HIPERSON A ON D.EMPNO = A.EMPNO     \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE    B ON B.MINORCD = A.PAYGRD AND B.MAJORCD='2002'      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT   C ON D.DEPTCD    = C.DEPTCD  \n");
						sql.append( "                               AND C.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT  \n");
						sql.append( "                                              WHERE CHGYM <= D.FRDT ) \n");
						sql.append( "   LEFT JOIN PAYROLL.HCHOLFEE E ON D.LAZCD     = E.LAZCD                    \n");
						sql.append( "   LEFT JOIN PAYROLL.HLATTEND H ON D.EMPNO = H.EMPNO AND H.ATTDAY = D.FRDT  \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT   I ON SUBSTR(C.TREECD,1,6)||'00'  = I.TREECD           \n");
						sql.append( "                               AND I.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT  \n");
						sql.append( "                                              WHERE CHGYM <= D.FRDT ) \n");
						sql.append( "  WHERE D.LAZCD LIKE 'S%' AND A.USESTS = '1' \n");  
						sql.append( "    AND SUBSTR(A.EMPNO,1,1) NOT IN ('1','2') \n");    
						sql.append( "    AND ((D.FRDT >='"+str[0]+"' AND D.FRDT <='"+str[1]+"')                    \n");
						sql.append( "     OR  (D.TODT >='"+str[0]+"' AND D.TODT <='"+str[1]+"'))                   \n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( " AND D.EMPNO BETWEEN '"+str[2]+"' AND '"+str[3]+"' \n");
						if(!str[4].equals(""))sql.append( " AND (A.EMPNMK LIKE '"+str[4]+"%' OR A.EMPNMK LIKE '"+str[4]+"%') \n");
						if(!str[5].equals(""))sql.append( " AND D.LAZCD  ='"+str[5]+"' \n");
						if(!str[6].equals(""))sql.append( " AND D.DEPTCD ='"+str[6]+"' \n");
						if(!str[7].equals(""))sql.append( " AND D.PAYSEQ ='"+str[7]+"' \n");
						if(!str[8].equals(""))sql.append( " AND D.CLOSYN ='"+str[8]+"' \n");
					}
						
						sql.append( "   ORDER BY APPDT, EMPNO \n");

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