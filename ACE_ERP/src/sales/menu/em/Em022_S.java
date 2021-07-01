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
public class Em022_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}
				String  str2	= req.getParameter("v_str2"); if (str2==null) {str2="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																					"EMPNO", "YYYYMM", "CUST_SID", "VEND_CD","DEPT_CD",
																					"TEAM_CD","WORK_CD","TELUBO_PAY","TELSAVE_PAY","REMARK",
																					"I_EMPNO","U_EMPNO","I_DATE", "U_DATE","EMPNMK",
                                          "JOB_CD","DEPT_NM","TEAM_NM"
																			}; 


				int[] intArrCN = new int[] { 
                                          10,6, 10,10,5,
                                          5, 5, 10,10, 40,
                                          10,10,10,10,40,
                                          5, 40,40
																			}; 
			
				int[] intArrCN2 = new int[]{
                                          -1,-1, 0, 0,-1,
                                          -1,-1, 0, 0,-1,
                                          -1,-1,-1,-1,-1,
                                          -1,-1,-1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT                    \n");
						sql.append( "	A.EMPNO,                  \n");
						sql.append( "	A.YYYYMM,                 \n");
						sql.append( "	A.CUST_SID,               \n");
						sql.append( "	A.VEND_CD,                \n");
						sql.append( "	A.DEPT_CD,                \n");
						sql.append( "	A.TEAM_CD,                \n");
						sql.append( "	A.WORK_CD,                \n");
						sql.append( "	A.TELUBO_PAY,             \n");
						sql.append( "	A.TELSAVE_PAY,            \n");
						sql.append( "	A.REMARK,                 \n");
						sql.append( "	A.I_EMPNO,                \n");
						sql.append( "	A.U_EMPNO,                \n");
						sql.append( "	A.I_DATE,                 \n");
						sql.append( "	A.U_DATE,                 \n");
						sql.append( "	B.EMPNMK,                 \n");
						sql.append( "	B.JOB_CD,                 \n");
						sql.append( "	C.DETAIL_NM AS DEPT_NM,   \n");
						sql.append( "	D.DETAIL_NM AS TEAM_NM    \n");
						sql.append( "	FROM SALES.TCM430 A       \n");
						sql.append( "	LEFT OUTER JOIN SALES.TCM300 B ON A.EMPNO=B.EMPNO  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 C ON TRIM(C.DETAIL)=TRIM(A.DEPT_CD) AND C.HEAD='CM006' AND TRIM(C.DETAIL)<>''  \n");
						sql.append( "	LEFT OUTER JOIN SALES.TSY010 D ON TRIM(D.DETAIL)=TRIM(A.TEAM_CD) AND D.HEAD='CM003' AND TRIM(D.DETAIL)<>''  \n");
						sql.append( "	WHERE 1=1                 \n");
						if(!str1.equals(""))sql.append( "	AND A.YYYYMM = '"+str1+"' \n");
						if(!str2.equals(""))sql.append( "	AND A.EMPNO = '"+str2+"'  \n");
            sql.append( "	ORDER BY A.EMPNO DESC     \n");
					  
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);

					}
				
/*********************************************************************************************/

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