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
public class a400040_s3 extends HttpServlet {
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
				String []  str	= new String [4];
				str[0] = req.getParameter("v_str1");	//�����ڵ�
				str[1] = req.getParameter("v_str2");	//���¹�ȣ
				str[2] = req.getParameter("v_str3");	//�ŷ�����
				str[3] = req.getParameter("v_str4");	//����
				
				
				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHKBOX",   "ACCTNO",    "REPTDT",   "DEDATE",   "INOUTGB",    "REMARK2",
					"PLAMT",    "REAMT",     "CUAMT",    "RESULT",   "REMARK",     "RSTSEQ",  "WRID"
					 }; 

				int[] intArrCN = new int[] { 
					  1,  30,  8,   8,	10,  100,
				     15,  15, 15,  10,  60,    3,  10
				}; 
			
				int[] intArrCN2 = new int[]{ 
				    -1,  -1,  -1,  -1, 	-1,  -1,	
					 0,   0,   0,  -1,  -1,   0,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
					
						
					
						sql.append( " SELECT ''CHKBOX, X.ACCTNO, X.REPTDT, X.DEDATE, X.INOUTGB, X.REMARK2, X.PLAMT, X.REAMT, X.CUAMT, \n");
						sql.append( "        X.RESULT, X.REMARK, X.RSTSEQ, ROWNUM AS SEQ , '' WRID \n");
						sql.append( "   FROM ( \n");
						
						sql.append( "  --�����̿�                                                                                             \n");
						sql.append( "  SELECT '' ACCTNO,                                                                                       \n");
						sql.append( "         '20161004' AS REPTDT ,                                                                           \n");
						sql.append( "         '20161001' DEDATE ,                                                                              \n");
						sql.append( "         '�����̿�' AS INOUTGB,                                                                             \n");
						sql.append( "         ''REMARK2 ,                                                                                        \n");
						sql.append( "         0 PLAMT, --ACREPLAN�� CUAMT �ݾ�                                                               \n");
						sql.append( "         SUM(CASE WHEN DEDATE='20160000' THEN BALAMT ELSE 0 END) + SUM(INAMT)-SUM(OUTAMT) AS REAMT,     \n");
						sql.append( "         0 CUAMT,  -- �����Է���.                                                                         \n");
						sql.append( "        ''RESULT,'' REMARK,1 RSTSEQ                                                                     \n");
						sql.append( "    FROM ACCOUNT.ACDEPOSIT                                                                                \n");
						sql.append( "   WHERE DEDATE <'20161001'                                                                               \n");
						sql.append( "   GROUP BY DEDATE                                                                                        \n");
						sql.append( "                                                                                                          \n");
			        	sql.append( "  )X \n");
					
						
						
						
						System.out.println("# a400040_s3 Query : \n" + sql);
						
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}