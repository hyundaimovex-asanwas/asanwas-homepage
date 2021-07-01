/* ��ü ��ȸ */
package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class h050009_s2 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String stryymm="";
        String [] str = new String[10];
        str[0] =  req.getParameter("v_str1"); // from ���� 
				str[1] =  req.getParameter("v_str2"); // to ����   
				str[2] =  req.getParameter("v_str3"); // from ��� 
				str[3] =  req.getParameter("v_str4");	// to ���   
				str[4] =  req.getParameter("v_str5");	// ����      
				str[5] =  req.getParameter("v_str6"); // ���±���  
				str[6] =  req.getParameter("v_str7"); // �μ�  //�μ��� �������� ������ ��    
				str[7] =  req.getParameter("v_str8"); // ����
				str[8] =  req.getParameter("v_str9"); // �������		
				str[9] =  req.getParameter("v_str10"); //  ����(""��ü, R-������, T-�����	)		

        for(int i=0;i<=9;i++){
					if(str[i]==null) str[i]="";
				}

				stryymm =str[1].substring(0,6);

			//	logger.dbg.println(this,"stryymm::"+stryymm);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"LAZCD",		"DEPTCD",		"PAYSEQ",
																					"FRDT",			"TODT",			"DTYREM",   "CLOSYN",		"SGDT",	
																					"SGNID",		"AGRDT",		"AGRID",    "PAYDT",		"AMT",	
																					"DEPTNM",		"PAYGRDNM",	"EMPNMK",   "LAZFEENM", "BEFYEAR",
																				  "CURYEAR",	"USEYEAR",	"PAYYEAR",  "SGNM",     "AGNM",  "DIVNM", "CHK", "HLNO"   
																					}; 

				int[] intArrCN = new int[]{ 8,  7,  4,  4,  4,
																		8,  8, 200, 1,  8,
																		7,  8,  7,  8,  7,
																		50, 30, 20, 20, 3,
																		3,  3,  3,  20, 20, 50, 1, 14
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,  0,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1, -1, -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT D.APPDT, D.EMPNO, RTRIM(D.LAZCD)LAZCD,  D.DEPTCD, D.PAYSEQ, \n");
					sql.append( "         RTRIM(D.FRDT)FRDT,  RTRIM(D.TODT)TODT,  D.DTYREM, D.CLOSYN, D.SGDT,  \n");
					sql.append( "         D.SGNID, RTRIM(D.AGRDT)AGRDT, D.AGRID,  D.PAYDT,  IFNULL(D.AMT,0) AMT,  \n");
					sql.append( "         RTRIM(C.DEPTNM)AS DEPTNM ,B.MINORNM AS PAYGRDNM,            \n");
					sql.append( "         CASE WHEN RTRIM(A.EMPNMK)='' OR A.EMPNMK IS NULL THEN K.EMPNMK ELSE A.EMPNMK END EMPNMK, \n");
					sql.append( "         E.MINORNM AS LAZFEENM,                 \n");
					sql.append( "         COALESCE(F.BEFYEAR,0) AS BEFYEAR,  COALESCE(F.CURYEAR,0) AS CURYEAR,  \n");
					sql.append( "         COALESCE(F.USEYEAR,0) AS USEYEAR,  COALESCE(F.PAYYEAR,0) AS PAYYEAR,  \n");
					sql.append( "         '' AS SGNM, '' AS AGNM, RTRIM(L.DEPTNM) AS DIVNM, ''CHK, D.HLNO          \n");
					sql.append( "    FROM PAYROLL.HLDUTY D                                                      \n");
					sql.append( "    LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO  = D.EMPNO                         \n");
					sql.append( "    LEFT JOIN PAYROLL.HCLCODE  B ON B.MINORCD =D.PAYSEQ AND B.MAJORCD='2002'   \n");
					sql.append( "    LEFT JOIN PAYROLL.HCDEPT   C ON C.DEPTCD = D.DEPTCD \n");
					sql.append( "                                AND C.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT \n");
					sql.append( "                                               WHERE CHGYM <=D.FRDT) \n");
					sql.append( "    LEFT JOIN PAYROLL.HCLCODE  E ON E.MINORCD =D.LAZCD AND E.MAJORCD='1124'   \n");
					sql.append( "    LEFT JOIN PAYROLL.PCMONPAY F ON D.EMPNO = F.EMPNO                         \n");
					sql.append( "                                 AND F.STRDT = '"+stryymm+"'                        \n");
					sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON K ON K.EMPNO  = D.EMPNO                       \n");
					sql.append( "    LEFT JOIN PAYROLL.HCDEPT L ON SUBSTR(C.TREECD,1,6)||'00' = L.TREECD        \n");
					sql.append( "                         AND L.CHGYM= (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT   \n");
					sql.append( "                                        WHERE CHGYM <= D.FRDT ) \n");
					sql.append( "   WHERE ((D.FRDT >='"+str[0]+"' AND D.FRDT <='"+str[1]+"')                    \n");
					sql.append( "      OR  (D.TODT >='"+str[0]+"' AND D.TODT <='"+str[1]+"'))                   \n");
					if(!str[2].equals("")&&!str[3].equals(""))sql.append( " AND D.EMPNO BETWEEN '"+str[2]+"' AND '"+str[3]+"' \n");
					if(!str[4].equals(""))sql.append( " AND (A.EMPNMK LIKE '"+str[4]+"%' OR K.EMPNMK LIKE '"+str[4]+"%') \n");
					if(!str[5].equals(""))sql.append( " AND D.LAZCD ='"+str[5]+"'                               \n");
					else sql.append( " AND (D.LAZCD LIKE 'C%' OR D.LAZCD LIKE 'G%' OR D.LAZCD LIKE 'H%')        \n");
					if(!str[6].equals(""))sql.append( " AND D.DEPTCD IN "+str[6]+"                              \n");
					if(!str[7].equals(""))sql.append( " AND D.PAYSEQ ='"+str[7]+"'                              \n");
					if(!str[8].equals(""))sql.append( " AND D.CLOSYN ='"+str[8]+"'                              \n");
					if(str[9].equals("R"))sql.append( " AND (RTRIM(K.EMPNMK)='' OR RTRIM(K.EMPNMK)IS NULL) \n");
					else if(str[9].equals("T"))sql.append( " AND (RTRIM(A.EMPNMK)='' OR RTRIM(A.EMPNMK)IS NULL) \n");
					sql.append( "   ORDER BY D.APPDT, D.EMPNO \n");

				//	logger.dbg.println(this, sql.toString());
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