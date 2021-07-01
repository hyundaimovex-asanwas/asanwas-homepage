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
public class h050004_s88 extends HttpServlet {

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
				String [] str = new String [2]; 
				str[0]	= req.getParameter("v_str1");		//FROM DT
				str[1]	= req.getParameter("v_str2");		//TO DT 

				for (int s=0;s<=1;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",  "EMPNMK", "DEPTCD", "DEPTNMK", "CLODAY",
				                                  "CLOTIME","ATTDAY", "ATTTIME","ETC"	};

				int[] intArrCN = new int[]{  7, 20, 4, 30, 8,
					                           6,  8, 6, 30 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
       
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.EMPNO,                                                                                                  \n ");
					sql.append( "         RTRIM(MAX(CASE WHEN RTRIM(B.EMPNMK)=''OR B.EMPNMK IS NULL THEN C.EMPNMK ELSE B.EMPNMK END)) EMPNMK,       \n ");
					sql.append( "         MAX(CASE WHEN RTRIM(B.DEPTCD)=''OR B.DEPTCD IS NULL THEN C.DEPTCD ELSE B.DEPTCD END) DEPTCD,              \n ");
					sql.append( "         RTRIM(MAX(CASE WHEN RTRIM(D.DEPTNMK)=''OR D.DEPTNMK IS NULL THEN E.DEPTNMK ELSE D.DEPTNMK END)) DEPTNMK,  \n ");
					sql.append( "         MAX(X.CLODAY)CLODAY, MAX(X.CLOTIME)CLOTIME, MAX(X.ATTDAY)ATTDAY, MAX(X.ATTTIME)ATTTIME,                   \n ");
					sql.append( "         MIN(CASE WHEN RTRIM(G.MINORNM)=''OR G.MINORNM IS NULL THEN X.ETC ELSE G.MINORNM END) ETC                  \n ");
					sql.append( "  FROM(                                                                                                            \n ");
					sql.append( "      /*���*/                                                                                                     \n ");
					sql.append( "      SELECT EMPNO, '' ATTDAY, '' ATTTIME, CLODAY, CLOTIME, ''ETC                                                  \n ");
					sql.append( "        FROM PAYROLL.HLATTEND                                                                                      \n ");
					sql.append( "       WHERE ATTDAY ='"+str[0]+"'                                                                                  \n ");
					sql.append( "       UNION ALL                                                                                                   \n ");
					sql.append( "      /*���*/                                                                                                     \n ");
					sql.append( "      SELECT EMPNO, ATTDAY,  ATTTIME, '' CLODAY, '' CLOTIME, ETC                                                   \n ");
					sql.append( "        FROM PAYROLL.HLATTEND                                                                                      \n ");
					sql.append( "       WHERE ATTDAY ='"+str[1]+"'                                                                                  \n ");
					sql.append( "  )X                                                                                                               \n ");
					sql.append( "                                                                                                                   \n ");
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON X.EMPNO = B.EMPNO                                                                \n ");
					sql.append( "  LEFT JOIN PAYROLL.T_HIPERSON C ON X.EMPNO = C.EMPNO                                                              \n ");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT   D ON B.DEPTCD = D.DEPTCD AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)        \n ");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT   E ON C.DEPTCD = E.DEPTCD AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)        \n ");
					sql.append( "  LEFT JOIN PAYROLL.HLDUTYC07 H ON X.EMPNO = H.EMPNO  AND X.ATTDAY = H.USEDT                                       \n ");
					sql.append( "  LEFT JOIN PAYROLL.HCLCODE   G ON H.CODE  = G.MINORCD AND G.MAJORCD ='1124'                                       \n ");
					sql.append( "  GROUP BY X.EMPNO                                                                                                 \n ");
					sql.append( "  ORDER BY X.EMPNO                                                                                                 \n ");
					
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