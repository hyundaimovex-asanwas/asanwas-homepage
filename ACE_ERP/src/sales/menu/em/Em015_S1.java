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
public class Em015_S1 extends HttpServlet {

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
				String [] str = new String[7];
        str[0] =  req.getParameter("v_str1"); // �μ� 
				str[1] =  req.getParameter("v_str2"); // �Ҽ�   
				str[2] =  req.getParameter("v_str3"); // ���
				str[3] =  req.getParameter("v_str4");	// ����
				str[4] =  req.getParameter("v_str5");	// �ް�����FR     
				str[5] =  req.getParameter("v_str6"); // �ް�����TO
				str[6] =  req.getParameter("v_str7");	// �ް�����      
				
        for(int i=0;i<7;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO",   "EMPNMK",  "YYYY",   "SEQ",    "CUST_SID",
                                           "VEND_CD", "DEPT_CD", "DEPT_NM","TEAM_CD","TEAM_NM",
					                                 "WORK_CD", "START_DT","END_DT", "H_DAY",  "H_RES",
                                           "H_YN",    "SEQ2",    "CHK",    "REWARD_YM",
					                                 "I_EMPNO", "I_DATE",  "U_EMPNO","U_DATE"                                
																		  	}; //

				int[] intArrCN = new int[] { 10, 30,  4, 2, 10,
					                           10,  5, 50, 5, 50,
																		  5,  8,  8, 3, 40,
					                            1,  2,  1, 6, 
					                           10, 10, 10, 10
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1, 0, 0,
					                            0,-1,-1,-1,-1,
					                           -1,-1,-1,-1,-1,
					                           -1, 0,-1,-1,
					                           -1,-1,-1,-1
					                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	 SELECT A.EMPNO,   B.EMPNMK,   A.YYYY,    A.SEQ,     A.CUST_SID,                              \n");
						sql.append( "	        A.VEND_CD, A.DEPT_CD,  C.DETAIL_NM AS DEPT_NM,   A.TEAM_CD, D.DETAIL_NM AS TEAM_NM,   \n");
						sql.append( "	        A.WORK_CD, A.START_DT, A.END_DT,  IFNULL(A.H_DAY,0)H_DAY,   A.H_RES,                  \n");
						sql.append( "	        A.H_YN,    IFNULL(A.SEQ2,0) SEQ2, '' CHK,    A.REWARD_YM,                             \n");
						sql.append( "	        A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE                                             \n");
						sql.append( "	   FROM SALES.TCM355 A                                                                        \n");
						sql.append( "	   LEFT JOIN SALES.TCM300 B ON B.EMPNO = A.EMPNO                                              \n");
						sql.append( "	   LEFT JOIN SALES.TSY010 C ON C.DETAIL =A.DEPT_CD AND C.HEAD = 'CM006' AND TRIM(C.DETAIL)<>''\n");
						sql.append( "	   LEFT JOIN SALES.TSY010 D ON D.DETAIL =A.TEAM_CD AND D.HEAD = 'CM003' AND TRIM(D.DETAIL)<>''\n");
						sql.append( "	  WHERE 1=1  \n");
						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'    \n");
						if(!str[1].equals(""))sql.append( "	  AND A.TEAM_CD = '"+str[1]+"' \n");
						if(!str[2].equals(""))sql.append( "	  AND A.EMPNO = '"+str[2]+"' \n");
						if(!str[3].equals(""))sql.append( "	  AND B.EMPNMK LIKE '"+str[3]+"%' \n");
						if(!str[4].equals("")&&!str[5].equals(""))sql.append( "	  AND ((A.START_DT >='"+str[4]+"' AND A.START_DT<='"+str[5]+"') OR (A.END_DT >='"+str[4]+"' AND A.END_DT<='"+str[5]+"'))   \n");
						if(!str[6].equals(""))sql.append( "	  AND A.H_YN = '"+str[6]+"' \n");			
						
						//logger.dbg.println(this,sql.toString());
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