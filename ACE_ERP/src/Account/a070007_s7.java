package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a070007_s7 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");    //�����ڵ�  
				String  str2	= req.getParameter("v_str2");	 //�ǻ�����

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CDREMARK", "CDCODE", "CDNAM" ,"QUANTY", "UNIT", "ACAMT"   };

				int[] intArrCN = new int[]{11, 4,  7, 6, 3, 15 };
			
				int[] intArrCN2 = new int[]{ -1, -1,  0, 0, -1, 0 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();            
					sql.append( " SELECT DECODE(GROUPING_ID(A.CDREMARK, A.CDCODE),'1','��', A.CDREMARK) CDREMARK,   	   \n");
					sql.append( "        A.CDCODE,  \n");
					sql.append( "        DECODE(GROUPING_ID(A.CDREMARK, A.CDCODE),'1','', SUM(TO_NUMBER(A.CDNAM))) AS CDNAM,     \n");
					sql.append( "        DECODE(GROUPING_ID(A.CDREMARK, A.CDCODE),'1','', nvl(SUM(B.QUANTY),0)) AS QUANTY,       \n");
					
					sql.append( "        CASE WHEN GROUPING_ID(A.CDREMARK, A.CDCODE)='1' AND A.CDREMARK='��ȭ(WON)' THEN '1'      \n");
					sql.append( "             WHEN GROUPING_ID(A.CDREMARK, A.CDCODE)='1' AND A.CDREMARK='��ȭ(CNY)' THEN '2'      \n");
					sql.append( "             WHEN GROUPING_ID(A.CDREMARK, A.CDCODE)='1' AND A.CDREMARK='��ȭ(EUR)' THEN '3'      \n");
					sql.append( "             WHEN GROUPING_ID(A.CDREMARK, A.CDCODE)='1' AND A.CDREMARK='��ȭ(USD)' THEN '4'      \n");
					sql.append( "             WHEN GROUPING_ID(A.CDREMARK, A.CDCODE)='1' AND A.CDREMARK='��ȭ(JPY)' THEN '5'      \n");
					sql.append( "             WHEN A.CDREMARK='��ȭ(WON)' THEN '099' \n");
					sql.append( "             WHEN A.CDREMARK='��ȭ(CNY)' THEN '199' \n");
					sql.append( "             WHEN A.CDREMARK='��ȭ(EUR)' THEN '299' \n");
					sql.append( "             WHEN A.CDREMARK='��ȭ(USD)' THEN '399' \n");
					sql.append( "             WHEN A.CDREMARK='��ȭ(JPY)' THEN '499' \n");
					sql.append( "        ELSE '' END UNIT,                                     \n");
					sql.append( "        nvl(SUM(B.ACAMT),0) AS ACAMT                          \n");
					sql.append( "   FROM ACCOUNT.ACASHSUR B                                    \n");
					sql.append( "   LEFT OUTER JOIN ACCOUNT.COMMDTIL A ON CDCODE=CASHUNIT      \n");
					sql.append( "  WHERE CMTYPE='0055' 									       \n");
					sql.append( "    AND A.DSUDT IS NULL							           \n");
					sql.append( "    AND FDCODE = '"+str1+"' 		                           \n");
					sql.append( "    AND ACDATE = '"+str2+"'		                           \n");
					sql.append( "  GROUP BY ROLLUP ( A.CDREMARK, A.CDCODE )                    \n");
					sql.append( "  HAVING GROUPING_ID(A.CDREMARK, A.CDCODE) <> '3'             \n");
					sql.append( "  ORDER BY UNIT, A.CDCODE                                     \n");
					
					/*
					sql.append( "   FROM ACCOUNT.ACASHSUR B                                                                \n");
					sql.append( "   LEFT OUTER JOIN ACCOUNT.COMMDTIL A ON CDCODE=CASHUNIT   							   \n");
					sql.append( " WHERE CMTYPE='0055' 																	   \n");
					sql.append( "   AND A.DSUDT IS NULL											                           \n");	
					if (!str1.equals("")) sql.append( " AND FDCODE = '" + str1 + "' 									   \n");
					if (!str2.equals("")) sql.append( " AND ACDATE = '" + str2 + "'										   \n" );
					sql.append( " ORDER BY TO_NUMBER(A.PSEQ)                    									       \n");
				    */
					//logger.dbg.println(this,sql.toString());
					
                   // System.out.println("a070007_s7::"+sql.toString());
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