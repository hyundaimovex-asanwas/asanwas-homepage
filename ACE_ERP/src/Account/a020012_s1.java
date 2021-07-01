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
public class a020012_s1 extends HttpServlet {
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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//ó���Ⱓfr                     
				str[1]	= req.getParameter("v_str2");		//ó���Ⱓto             
				str[2]	= req.getParameter("v_str3");		//��ǥ����            
				str[3]	= req.getParameter("v_str4");		//����              
				str[4]	= req.getParameter("v_str5");		//ȸ����/�繫�� ���� "A" ==>�ǹ̾���.
				str[5]	= req.getParameter("v_str6");		//����FR              
				str[6]	= req.getParameter("v_str7");		//����TO   
				str[7]	= req.getParameter("v_str8");		//�μ� ==>>�ǹ̾���.              
				str[8]	= req.getParameter("v_str9");		//����  
				str[9]	= req.getParameter("v_str10");	//empno(ȸ���� �繫���� �ƴ� ��� �ڽ��� ��ǥ�� ��ȸ��)   
			
				for (int s=0;s<=9;s++) {
					if (str[s]==null) str[s] = "";
				}

				if (str[3]=="C110") str[3]="";
		
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",   "FSNBR",    "FSSEQ",    "ATCODE",
                                          "ATDECR",  "FSAMT",   "ACNNBR",   "BANJAEYN", "PRIMCOST",
                                          "DOCUMCD", "DOCUVAL", "FSWRKDIV", "REMARK",   "FSNUM",
                                          "DIVCD",   "BGTDIV",  "SSDAT",    "SSNBR",    "EMPNO",
                                          "EMPNMK",  "DEAMT",   "CRAMT",    "FSDTNB",   "SSDTNB",
                                          "VEND_CD", "VEND_NM", "ATKORNAM","FSSTAT",  "WRDT",     "WRID",     "UPDT",     "UPID",
				                          "FSREFCD", "FSREFVAL", "CDNAM"
				}; 

				int[] intArrCN = new int[]{  2,  9, 6,  5, 7, 
					                           1, 15, 9,  1, 5,
																	   3, 20, 2,132, 3,  	
 					                           4,  4, 9,  6, 7,
					                          20, 15,15, 16,16,
					                          10,  50, 66,  1, 8, 7,  8, 7,
					                           4,  30, 30
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1,  0, -1, -1, -1,
				                             -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1,
					                           -1,  0,  0, -1, -1,
					                           -1, -1, -1, -1, -1, -1, -1, -1,
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
					sql.append( "  SELECT B.FDCODE,  B.FSDAT,   B.FSNBR,     B.FSSEQ,    B.ATCODE,                                     \n " );
					sql.append( "         B.ATDECR,  B.FSAMT,   B.ACNNBR,    B.BANJAEYN, B.PRIMCOST,                                   \n " );
					sql.append( "         B.DOCUMCD, B.DOCUVAL, B.FSWRKDIV,  B.REMARK,   B.FSNUM,                                      \n " );
					sql.append( "         B.DIVCD,   B.BGTDIV,  B.SSDAT,     B.SSNBR,    A.EMPNO,                                      \n " );
					sql.append( "         C.ENO_NM AS EMPNMK,   																						\n " );
					sql.append( "         CASE WHEN B.ATDECR ='1' THEN B.FSAMT ELSE 0 END DEAMT,                                       \n " );
					sql.append( "         CASE WHEN B.ATDECR ='2' THEN B.FSAMT ELSE 0 END CRAMT,                                       \n " );
					sql.append( "         CASE  WHEN (A.FSDAT=''OR A.FSDAT IS NULL) THEN '' ELSE A.FSDAT||'-'||A.FSNBR END  FSDTNB,    \n " );
					sql.append( "         CASE  WHEN (A.SSDAT=''OR A.SSDAT IS NULL) THEN '' ELSE A.SSDAT||'-'||A.SSNBR END  SSDTNB,    \n " );
					sql.append( "         D.FSREFVAL AS VEND_CD, F.VEND_NM AS VEND_NM, E.ATKORNAM, A.FSSTAT,  B.WRDT,    B.WRID,    B.UPDT,      B.UPID,                            \n " );
					sql.append( "         ''FSREFCD, ''FSREFVAL,''CDNAM                                                                				\n " );
					sql.append( "   FROM ACCOUNT.FSLIPMST A , ACCOUNT.FSLIPDTL B, ACCOUNT.FSLIPREF D, ACCOUNT.ACTCODE E,   ACCOUNT.GCZM_VENDER F,   \n " );
					sql.append( "   	 ASNHR.T_CM_PERSON C                                                 												\n " );
					sql.append( "  WHERE A.FDCODE = B.FDCODE                                                                           					\n " );
					sql.append( "    AND A.FSDAT = B.FSDAT                                                                             						\n " );
					sql.append( "    AND A.FSNBR = B.FSNBR                                                                             						\n " );
					sql.append( "    AND B.ATCODE = E.ATCODE                                                                         						\n " );
					sql.append( "    AND A.EMPNO = C.ENO_NO                                                                          						\n " );
					
					sql.append( "    AND A.FDCODE = D.FDCODE                                                                             					\n " );
					sql.append( "    AND A.FSDAT = D.FSDAT                                                                             						\n " );
					sql.append( "    AND A.FSNBR = D.FSNBR                                                                         							\n " );
					sql.append( "    AND B.FDCODE = D.FDCODE                                                                          					\n " );					
					sql.append( "    AND B.FSDAT = D.FSDAT                                                                              					\n " );
					sql.append( "    AND B.FSNBR = D.FSNBR                                                                             						\n " );
					sql.append( "    AND B.FSSEQ = D.FSSEQ AND D.FSREFCD = '0020' AND D.FSREFVAL = F.VEND_CD						\n " );				
					
					if (!str[0].equals("")&&!str[1].equals("")) sql.append( "  AND A.ACTDAT BETWEEN '"+str[0]+"'  AND '"+str[1]+"'     	\n" );
					if (!str[2].equals("A")) sql.append( "  AND A.FSSTAT='" +str[2]+"'  																	\n" );
                    if (!str[3].equals(""))sql.append( "    AND A.FDCODE ='"+str[3]+"'  																	\n" );
					if (!str[5].equals("")&&!str[6].equals("")) sql.append( "  AND B.ATCODE BETWEEN '"+str[5]+"'  AND '"+str[6]+"'     	\n" );
					if (!str[8].equals(""))sql.append( "    AND B.REMARK LIKE '%"+str[8]+"%'   														\n" );
					//2010.02.03 �� JYS : ��ǥ��ȸ�� Ÿ�μ� �� ����� ���� ���� �߰�,,,,,�ڽ��� �μ��� �ڵ� ��ȸ ����.    
					if (!str[4].equals("A")&&!str[9].equals("")&&str[7].equals("")) sql.append( "  AND A.EMPNO IN ("+str[9]+") 				\n" );
					if (!str[4].equals("A")&&!str[9].equals("")&&!str[7].equals("")) sql.append( "  AND ( A.EMPNO IN ("+str[9]+") OR A.DEPTCD IN ("+str[7]+")) \n" );
					if (str[2].equals("Y"))sql.append( "  ORDER BY B.FDCODE, B.SSDAT ASC, B.SSNBR ASC, B.FSNUM                                              \n " );
					else sql.append( "  ORDER BY B.FDCODE, B.FSDAT ASC, B.FSNBR ASC, B.FSNUM                                              \n " );

					
					//System.out.println("a020012_s1 : " + sql.toString());	
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