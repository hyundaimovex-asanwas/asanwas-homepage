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
public class a030008_s2 extends HttpServlet {
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
				// ��ü��ȸ
				String  str1	= req.getParameter("v_str1");
				String  str2  = req.getParameter("v_str2");
				String  str3  = req.getParameter("v_str3");
				String  str4  = "";
				String  str5  = req.getParameter("v_str5");

				if(str1 == null) str1 = ""; //�����ڵ�
				if(str2 == null) str2 = ""; //��꼭�Ⱓ ���
				if(str3 == null) str3 = ""; 
				if(str4 == null) str4 = ""; 
				if(str5 == null) str5 = ""; 
        
				str4 = str2.substring(0,4);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "ATCODE", "ATKORNAM", "ATPRTSEQ","ATUSEYN", "DEVAL", "DETOT",
																						"CRTOT", "CRVAL"
				}; 

				int[] intArrCN = new int[]{ 7, 66, 7, 1, 15, 15, 15,	15
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1,-1, 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					
					if(str5.equals("A")){ //��ü
						
						sql.append(" SELECT C.ATCODE ATCODE, C.ATKORNAM ATKORNAM, C.ATPRTSEQ, ATUSEYN ATUSEYN,                   ");
						sql.append("        CASE WHEN C.ATDECR='1' THEN  nvl(B.DETOT - B.CRTOT,0) ELSE 0 END DEVAL,    	");
						sql.append("        B.DETOT DETOT,                                                                       							");
						sql.append("        B.CRTOT CRTOT,                                                                      	 						");
						sql.append("        CASE WHEN C.ATDECR='2' THEN  nvl(B.CRTOT - B.DETOT,0) ELSE 0 END CRVAL      	");
						sql.append("  FROM(                                                                                      								");
						sql.append("        SELECT Y.ATCODE, SUM(DETOT) DETOT, SUM(CRTOT)CRTOT                                   ");
						sql.append("        FROM (                                                                               						");
						sql.append(" 				 SELECT A.ATCODE ATCODE,                                                            	");
						sql.append(" 								SUM(A.DETOT) DETOT,                                                         ");
						sql.append(" 								SUM(A.CRTOT) CRTOT                                                          ");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                         ");
						sql.append(" 					WHERE A.FDCODE IN ('01','02','04')                                                ");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')                     ");
						sql.append(" 					GROUP BY A.ATCODE                                                                 ");
						sql.append(" 					UNION ALL                                                                         ");
						sql.append(" 					SELECT A.ATCODE ATCODE,                                                           ");
						sql.append(" 								SUM(A.FODETOT) DETOT,                                                       ");
						sql.append(" 								SUM(A.FOCRTOT) CRTOT                                                        ");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                         ");
						sql.append(" 					WHERE A.FDCODE IN ('03')                                                          ");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')                     ");
						sql.append(" 					GROUP BY A.ATCODE                                                              ");
						sql.append(" 					)Y                                                                                			");
						sql.append(" 				GROUP BY ATCODE                                                                     ");
						sql.append(" 			)B                                                                                    				");
						sql.append("  LEFT JOIN ACCOUNT.ACTCODE C  ON B.ATCODE = C.ATCODE                        ");
						if(str3.equals("Y"))sql.append(" WHERE C.ATUSEYN = 'Y' \n												");
						if(str3.equals("N"))sql.append(" WHERE C.ATUSEYN!= 'Y' \n												");
						sql.append("  ORDER BY C.ATPRTSEQ                                                                       		");
					
					}else if(str5.equals("K")){ //�ݰ���
												
						sql.append(" SELECT C.ATCODE ATCODE, C.ATKORNAM ATKORNAM, C.ATPRTSEQ, ATUSEYN ATUSEYN,                   ");
						sql.append("        CASE WHEN C.ATDECR='1'  THEN  nvl(B.DETOT - B.CRTOT,0) ELSE 0 END DEVAL,    	");
						sql.append("        B.DETOT DETOT,                                                                       							");
						sql.append("        B.CRTOT CRTOT,                                                                       							");
						sql.append("        CASE WHEN C.ATDECR='2'  THEN  nvl(B.CRTOT - B.DETOT,0) ELSE 0 END CRVAL      ");
						sql.append("  FROM(                                                                                      							");
						sql.append(" 					SELECT A.ATCODE ATCODE,                                                           		");
						sql.append(" 								SUM(A.FODETOT) DETOT,                                                       ");
						sql.append(" 								SUM(A.FOCRTOT) CRTOT                                                        ");
						sql.append(" 					 FROM ACCOUNT.MTOTALBAL A                                                         	");
						sql.append(" 					WHERE A.FDCODE IN ('03')                                                          		");
						sql.append(" 						AND (A.ACTYYMM >= '"+str4+"00' AND A.ACTYYMM <= '"+str2+"')             ");
						sql.append(" 					GROUP BY A.ATCODE                                                                 			");
						sql.append(" 			)B                                                                                    							");
						sql.append("  LEFT JOIN ACCOUNT.ACTCODE C  ON B.ATCODE = C.ATCODE                                    ");
						if(str3.equals("Y"))sql.append(" WHERE C.ATUSEYN = 'Y' \n															");
						if(str3.equals("N"))sql.append(" WHERE C.ATUSEYN!= 'Y' \n															");
						sql.append("  ORDER BY C.ATPRTSEQ                                                                       					");
					}
					
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