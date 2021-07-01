package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class Em026_S1 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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

				String [] str = new String [3];

				str[0]	= req.getParameter("v_str1");    //�޿���� 
				str[1]	= req.getParameter("v_str2");    //���ޱ��� 
				str[2]	= req.getParameter("v_str3");    //�������� 

				for (int s=0;s<3;s++) {
					if (str[s].equals("")) str[s] = "";
				}
				
				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{ "APPDT", "PAYDIV",  "PAYDT",  "PBDIV",   "PAYCD", "PAY_NM", 
					                                "FRDT",  "FRTM",    "TODT",   "TOTM",    "WRKSTS",
					                                "MEMO",  "I_EMPNO", "I_DATE", "U_EMPNO", "U_DATE"
				};  

				int[] intArrCN = new int[]{ 6, 1, 8, 1, 8, 50,
					                          8, 6, 8, 6, 1,
					                        100,10,10,10,10
				}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
				                             -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1 
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
			

				if (!GauceReq.isBuilderRequest()) {	
					StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT A.APPDT,   A.PAYDIV,  A.PAYDT,   A.PBDIV,   A.PAYCD,  RTRIM(B.DETAIL_NM) AS PAY_NM,                  \n");
						sql.append( "	       A.FRDT,    A.FRTM,    A.TODT,    A.TOTM,    A.WRKSTS,                                                \n");
						sql.append( "	       A.MEMO,    A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE                                                 \n");
						sql.append( "	  FROM SALES.TCM499 A                                                                                       \n");
						sql.append( "	  LEFT JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.PAYCD) AND B.HEAD='CM021' AND RTRIM(B.DETAIL)<>''   \n");
						sql.append( "	 WHERE 1=1                                                                                                  \n");
				    if(!str[0].equals(""))sql.append( "	  AND A.APPDT = '"+str[0]+"'    \n");
						if(!str[1].equals(""))sql.append( "	  AND A.PAYDIV = '"+str[1]+"' \n");
						if(!str[2].equals(""))sql.append( "	  AND A.PAYDT = '"+str[2]+"' \n");
					
	
						logger.dbg.println(this,sql.toString());
						stmt = conn.getGauceStatement(sql.toString());

  	 				stmt.executeQuery(dSet);
/*********************************************************************************************/
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