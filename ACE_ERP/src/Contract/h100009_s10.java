package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h100009_s10 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//������
				str[1]	= req.getParameter("v_str2");		//���ޱ���

				for (int s=0;s<2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]	{ 
					 "GUBUN","DEPTNM2","SEQ1","SEQ2","CNT",  "S91AMT",
	  		};	       

				int[] intArrCN = new int[]{  
					20, 20, 3, 3, 3, 11
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, 0, -1, 0, 0 
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT Z.GUBUN,Z.DEPTNM2,1 SEQ1, Z.SEQ2,COUNT(Z.EMPNO) CNT,               ");
					sql.append( "       SUM(Z.S91000)S91AMT                ");	
				  sql.append( " FROM                                                                      ");
					sql.append( " (                                                                         ");	
					sql.append( " SELECT                                                                    ");
					sql.append( "        CASE WHEN X.DEPTCD='A000'  THEN '�̻�ȸȸ��'                       ");	
					sql.append( "             WHEN X.DEPTCD='A100'  THEN '��ȸ��'                           ");
					sql.append( "             WHEN X.DEPTCD='A200'  THEN '��ǥ�̻�'                         ");	
					sql.append( "             WHEN X.DEPTCD='A999'  THEN '��'                             ");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='C'  THEN '������������'            ");	
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='D'  THEN '�����������'            ");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='B'  THEN '��ȹ����'                ");	
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='G'  THEN '�Ǽ�����'                ");
					sql.append( "             WHEN SUBSTR(X.DEPTCD,1,1)='H'  THEN '�����������'            ");	
					sql.append( "        ELSE '��Ÿ����' END GUBUN,                                        ");
					sql.append( "        CASE WHEN X.DEPTCD='A000'  THEN '�̻�ȸȸ��'                      ");
					sql.append( "            WHEN X.DEPTCD='A100'  THEN '��ȸ��'                           ");	
					sql.append( "            WHEN X.DEPTCD='A200'  THEN '��ǥ�̻�'                         ");
					sql.append( "            WHEN X.DEPTCD='A999'  THEN '��'                             ");	
					sql.append( "            WHEN X.DEPTCD='C000'  THEN '�ӿ�'                             ");
					sql.append( "            WHEN X.DEPTCD='C100'  THEN '�ѹ�'                             ");	
					sql.append( "            WHEN X.DEPTCD='C200'  THEN '�渮'                             ");
					sql.append( "            WHEN X.DEPTCD='D000'  THEN '�ӿ�'                             ");	
					sql.append( "            WHEN X.DEPTCD='D100'  THEN '����������'                       ");
					sql.append( "            WHEN X.DEPTCD='D200'  THEN '�������ߺ�'                       ");	
					sql.append( "            WHEN X.DEPTCD='B000'  THEN '�ӿ�'                             ");
					sql.append( "            WHEN X.DEPTCD='B100'  THEN '��ȹ/�ؿ�����'                    ");	
					sql.append( "            WHEN X.DEPTCD='B200'  THEN '���/ȫ��'                        ");
					sql.append( "            WHEN X.DEPTCD='G000'  THEN '�ӿ�'                             ");	
					sql.append( "            WHEN X.DEPTCD='G100'  THEN '���/������'                      ");
					sql.append( "            WHEN X.DEPTCD='G200'  THEN '����/������'                      ");	
					sql.append( "            WHEN (X.DEPTCD='H000' AND X.MEMO='0')  THEN '�ӿ�'            ");
					sql.append( "            WHEN X.DEPTCD='H100'  THEN '������ߺ�'                       ");	
					sql.append( "            WHEN X.DEPTCD='H110'  THEN '�Ѱ���ȹ��'                       ");
					sql.append( "            WHEN X.DEPTCD='H120'  THEN '����������'                       ");	
          sql.append( "            WHEN (X.DEPTCD='H000' AND X.MEMO<>'0') THEN '�����������'    ");	
					sql.append( "        ELSE '��Ÿ' END DEPTNM2,                                          ");
					sql.append( "       CASE WHEN X.DEPTCD='A000'  THEN '01'                               ");	
					sql.append( "            WHEN X.DEPTCD='A100'  THEN '02'                               ");
					sql.append( "            WHEN X.DEPTCD='A200'  THEN '03'                               ");	
					sql.append( "            WHEN X.DEPTCD='A999'  THEN '04'                               ");
					sql.append( "            WHEN X.DEPTCD='C000'  THEN '10'                               ");	
					sql.append( "            WHEN X.DEPTCD='C100'  THEN '11'                               ");
					sql.append( "            WHEN X.DEPTCD='C200'  THEN '12'                               ");	
					sql.append( "            WHEN X.DEPTCD='D000'  THEN '20'                               ");
					sql.append( "            WHEN X.DEPTCD='D100'  THEN '21'                               ");	
					sql.append( "            WHEN X.DEPTCD='D200'  THEN '22'                               ");
					sql.append( "            WHEN X.DEPTCD='B000'  THEN '30'                               ");	
					sql.append( "            WHEN X.DEPTCD='B100'  THEN '31'                               ");
					sql.append( "            WHEN X.DEPTCD='B200'  THEN '32'                               ");	
					sql.append( "            WHEN X.DEPTCD='G000'  THEN '40'                               ");
					sql.append( "            WHEN X.DEPTCD='G100'  THEN '41'                               ");	
					sql.append( "            WHEN X.DEPTCD='G200'  THEN '42'                               ");
					sql.append( "            WHEN(X.DEPTCD='H000' AND X.MEMO='0')   THEN '50'              ");	
					sql.append( "            WHEN X.DEPTCD='H100'  THEN '51'                               ");
					sql.append( "            WHEN X.DEPTCD='H110'  THEN '52'                               ");	
					sql.append( "            WHEN X.DEPTCD='H120'  THEN '53'                               ");
					sql.append( "            WHEN(X.DEPTCD='H000' AND X.MEMO<>'0') THEN '54'               ");
					sql.append( "        ELSE '��Ÿ' END SEQ2,                                             ");	
					sql.append( "        X.EMPNO, X.S91000                                               ");	
					sql.append( " FROM (                                                                    ");
					sql.append( "       SELECT '' GUBUN,                                                          ");	
					sql.append( "             CASE WHEN A.DEPTCD='A000' AND PAYGRD<>'000' THEN 'A999'            ");
					sql.append( "                  WHEN A.DEPTCD>='C100' AND A.DEPTCD <='C140' THEN 'C100'       ");	
					sql.append( "                  WHEN A.DEPTCD>='C200' AND A.DEPTCD <='C240' THEN 'C200'       ");
					sql.append( "                  WHEN A.DEPTCD>='D200' AND A.DEPTCD <='D220' THEN 'D100'       ");	
          sql.append( "                  WHEN A.DEPTCD>='D100' AND A.DEPTCD <='D130' THEN 'D200'       ");  
					sql.append( "                  WHEN A.DEPTCD>='B010' AND A.DEPTCD <='B020' THEN 'B100'       ");	 
					sql.append( "                  WHEN A.DEPTCD>='B030' AND A.DEPTCD <='B040' THEN 'B200'       ");  
					sql.append( "                  WHEN A.DEPTCD>='G010' AND A.DEPTCD <='G020' THEN 'G100'       ");	 
					sql.append( "                  WHEN A.DEPTCD>='G030' AND A.DEPTCD <='G041' THEN 'G200'       ");  
					sql.append( "             ELSE A.DEPTCD END DEPTCD,                                         ");	 
					sql.append( "             B.DEPTNM, A.PAYGRD,  C.SEQ AS SEQ1, A.EMPNO, A.S91000,D.MEMO      ");  
					sql.append( "        FROM PAYROLL.PBPAY A                                                      ");	 
					sql.append( "        LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         ");  
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' ");	
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002' ");				 
					sql.append( "       WHERE A.APPDT='" +str[0]+"'                                                ");  
					sql.append( "         AND B.GROUPID='01'                                                      ");	 
                   if (str[1].equals("1")) 
					sql.append( " AND A.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[1].equals("5")) 
					sql.append( " AND A.PAYDIV IN ( '5') ");   //���ޱ���
                    if (str[1].equals("T")) 
					sql.append( " AND A.PAYDIV IN ('T') \n ");   //���ޱ���	



					sql.append( "      )X                                                                        ");  
					sql.append( " )Z                                                                        ");	 
					sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                       ");	 
					sql.append( " UNION ALL                                                                 ");  
					sql.append( " SELECT C.MINORNM GUBUN, C.MINORNM AS DEPTNM, C.SEQ AS SEQ1, '99' SEQ2,    ");	 
					sql.append( "        COUNT(A.EMPNO)CNT, SUM(A.S91000) S91AMT      ");  
					sql.append( "   FROM PAYROLL.PBPAY A                                                      ");	 
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         ");  
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' ");	 
					sql.append( "  WHERE A.APPDT='" +str[0]+"'                                                "); 
					sql.append( "    AND B.GROUPID<>'01'                                                     ");	 
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') ");   //���ޱ���
                    if (str[1].equals("T")) 
					sql.append( " AND A.PAYDIV IN ('T') \n ");   //���ޱ���		
					
					sql.append( "  GROUP BY B.GROUPID, C.MINORNM, C.SEQ                                      ");  
					sql.append( " UNION ALL                                                                 ");  
					sql.append( " SELECT GUBUN,DEPTNM2,1 SEQ1, SEQ2,                                        ");  
					sql.append( "        COUNT(EMPNO) CNT , SUM(S91000) S91AMT         ");	 
					sql.append( " FROM                                                                      ");  
					sql.append( " (                                                                         ");	 
					sql.append( " SELECT '' GUBUN ,'�Ұ�'DEPTNM2,1 SEQ1,                                    ");  
					sql.append( "       CASE WHEN SUBSTR(X.DEPTCD,1,1)='C'THEN '13'                        ");	 
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='D'THEN '23'                        ");  
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='B'THEN '33'                        ");	 
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='G'THEN '43'                        ");  
					sql.append( "            WHEN SUBSTR(X.DEPTCD,1,1)='H'THEN '54'                        ");	 
					sql.append( "        ELSE '��Ÿ�Ұ�' END SEQ2,                                         ");  
					sql.append( "        X.EMPNO, X.S91000                                                 ");	 
					sql.append( "  FROM (                                                                    ");  
					sql.append( "       SELECT '' GUBUN, A.DEPTCD, B.DEPTNM, C.SEQ AS SEQ1, A.EMPNO, A.S91000     ");	 
					sql.append( "         FROM PAYROLL.PBPAY A                                                      ");  
					sql.append( "         LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         ");	 
					sql.append( "         LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' ");  
					sql.append( "        WHERE A.APPDT='" +str[0]+"'                                              ");	 
					sql.append( "          AND B.GROUPID='01'                                                      ");  
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') ");   //���ޱ���
                    if (str[1].equals("T")) 
					sql.append( " AND A.PAYDIV IN ('T') \n ");   //���ޱ���	
					

					sql.append( "          AND SUBSTR(A.DEPTCD,1,1) IN ('B','C','D','G','H')                       ");	 
					sql.append( "      )X                                                                        ");  
					sql.append( " )Z                                                                        ");	 
					sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                              ");
					sql.append( " UNION ALL                                                                  ");
					sql.append( " SELECT GUBUN,DEPTNM2,1 SEQ1, SEQ2,                                        ");
					sql.append( "        COUNT(EMPNO) CNT , SUM(S91000) S91AMT                              ");
					sql.append( " FROM                                                                      ");
					sql.append( " (                                                                         ");
					sql.append( "   SELECT '�����Ѱ�' GUBUN ,'�����Ѱ�'DEPTNM2,1 SEQ1,                        ");
					sql.append( "        '60' SEQ2,                                                         ");
					sql.append( "         X.EMPNO, X.S91000                                                 ");
					sql.append( "    FROM (                                                                    ");
					sql.append( "          SELECT '' GUBUN, A.DEPTCD, B.DEPTNM, C.SEQ AS SEQ1, A.EMPNO, A.S91000     ");
          sql.append( "            FROM PAYROLL.PBPAY A                                                      ");
					sql.append( "            LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         ");
          sql.append( "            LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' ");
					sql.append( "           WHERE A.APPDT='" +str[0]+"'                                                     ");
					sql.append( "             AND B.GROUPID='01'                                                      ");
					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') ");   //���ޱ���
                    if (str[1].equals("T")) 
					sql.append( " AND A.PAYDIV IN ('T') \n ");   //���ޱ���	
					
					sql.append( "     )X                                                                        ");
					sql.append( "  )Z                                                                        ");
          sql.append( " GROUP BY GUBUN, DEPTNM2,SEQ2                                              ");
					sql.append( " UNION ALL                                                                 ");  
					sql.append( " SELECT '�Ѱ�' GUBUN, '�Ѱ�' MINORNM, 100 AS SEQ1, '99' SEQ2,              ");  
					sql.append( "         COUNT(A.EMPNO)CNT, SUM(A.S91000) S91AMT                          ");	 
					sql.append( " FROM PAYROLL.PBPAY A                                                      ");	 
					sql.append( " LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                         ");  
					sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON B.GROUPID = C.MINORCD AND C.MAJORCD='2051' ");	 
					sql.append( " WHERE A.APPDT='"+str[0]+"'                                               ");  					
					if (str[1].equals("1")) 
					   sql.append( " AND A.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[1].equals("5")) 
					   sql.append( " AND A.PAYDIV IN ( '5') ");   //���ޱ���
                    if (str[1].equals("T")) 
					sql.append( " AND A.PAYDIV IN ('T') \n ");   //���ޱ���						

					sql.append( " ORDER BY SEQ1, SEQ2                                                       ");  

					logger.dbg.println(this,sql.toString());

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