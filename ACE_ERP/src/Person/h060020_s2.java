package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h060020_s2 extends HttpServlet {

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

				String [] str = new String[1];
        str[0] =  req.getParameter("v_str1"); // ������  
				
        for(int i=0;i<=0;i++){
					if(str[i]==null) str[i]="";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",	 "EMPNMK",	  "DEPTCD",	  "DEPTNMK",	
																					"DIVCD",	 "DIVNM",		  "HEADCD",		"HEADNM",  "PAYGRD",		"PAYGRDNM"
																			  }; 

				int[] intArrCN = new int[]{ 7, 30,  4,  50,
																		4, 50,  4, 50,  4, 50 
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
																		 -1, -1, -1, -1,  -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
						sql.append( " SELECT B.EMPNO, B.EMPNMK,                                      \n");
						sql.append( "        C.DEPTCD, RTRIM(C.DEPTNMK)DEPTNMK,                      \n");
						sql.append( "        D.DEPTCD AS DIVCD, RTRIM(D.DEPTNM) AS DIVNM,            \n");
						sql.append( "        E.DEPTCD AS HEADCD, RTRIM(E.DEPTNM) AS HEADNM,          \n");
						sql.append( "        B.PAYGRD, RTRIM(F.MINORNM)PAYGRDNM         \n");
						sql.append( "   FROM PAYROLL.HIPERSON B                                      \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON D.TREECD = SUBSTR(C.TREECD,1,6)||'00' AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )     \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON E.TREECD = SUBSTR(C.TREECD,1,4)||'0000' AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON F.MINORCD = B.PAYGRD AND F.MAJORCD='2002'   \n");
						sql.append( "  WHERE B.USESTS IN ('1','2')                                   \n");
						if(!str[0].equals(""))sql.append( " AND  B.EMPNO ='"+str[0]+"'             \n");
						sql.append( "  UNION ALL                                                     \n");
						sql.append( "  SELECT B.EMPNO, B.EMPNMK,                                     \n");
						sql.append( "        C.DEPTCD, RTRIM(C.DEPTNMK)DEPTNMK,                      \n");
						sql.append( "        D.DEPTCD AS DIVCD, RTRIM(D.DEPTNM) AS DIVNM,            \n");
						sql.append( "        E.DEPTCD AS HEADCD, RTRIM(E.DEPTNM) AS HEADNM,           \n");
						sql.append( "        B.PAYGRD, RTRIM(F.MINORNM)PAYGRDNM          \n");
						sql.append( "   FROM PAYROLL.T_HIPERSON B                                    \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )                       \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT D ON D.TREECD = SUBSTR(C.TREECD,1,6)||'00' AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )     \n");
						sql.append( "   LEFT JOIN PAYROLL.HCDEPT E ON E.TREECD = SUBSTR(C.TREECD,1,4)||'0000' AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )   \n");
						sql.append( "   LEFT JOIN PAYROLL.HCLCODE F ON F.MINORCD = B.PAYGRD AND F.MAJORCD='2002'   \n");
						sql.append( "  WHERE B.USESTS IN ('1','2')                                                                                                     \n");
						if(!str[0].equals(""))sql.append( "  AND  B.EMPNO ='"+str[0]+"'                     \n");
					
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