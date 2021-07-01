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
public class a400045_s1 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//����
				str[1] = req.getParameter("v_str2");	//�ŷ�����
				
				
			
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"INOUTGB",   "RSTREMARK",    "COSTCD",  "COSTNM",  "PLANAMT",
					"REALAMT",   "CUAMT",    "RSTSEQ" }; 

				int[] intArrCN = new int[] { 
				    10,  30,  10,  100,  15, 
				    15,  15,  5
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  0, 
					 0,   0,   0  
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT X.INOUTGB, X.RSTREMARK,X.COSTCD,                                                                                              \n");
						sql.append( "        CASE WHEN X.COSTCD ='�����̿�' THEN '�����̿�'                                                                                \n");
						sql.append( "             WHEN X.COSTCD ='1.����'   THEN '1.����'                                                                                  \n");
						sql.append( "             WHEN X.COSTCD ='�����̿�' THEN '�����̿�'                                                                                \n");
						sql.append( "             ELSE Y.CDNAM END AS COSTNM,                                                                                              \n");
						sql.append( "        X.PLANAMT, X.REALAMT, X.CUAMT, X.RSTSEQ                                                                                       \n");
						sql.append( " FROM (                                                                                                                               \n");
						sql.append( " 	--�����̿�                                                                                                                   \n");
						sql.append( " 	SELECT '' ACCTNO,             -- ����                                                                                        \n");
						sql.append( " 	       '20161004' AS REPTDT , -- ��������                                                                                    \n");
						sql.append( " 	       DEDATE ,               -- �ŷ�����                                                                                    \n");
						sql.append( " 	       '�����̿�' AS INOUTGB,  --                                                                                            \n");
						sql.append( " 	       '�����̿�' AS RSTREMARK,                                                                                              \n");
						sql.append( " 	       '�����̿�' AS COSTCD,                                                                                                 \n");
						sql.append( " 	       ''REMARK,                                                                                                             \n");
						sql.append( " 	       0 PLANAMT,             --ACREPLAN�� CUAMT �ݾ�                                                                        \n");
						sql.append( " 	       SUM(CASE WHEN DEDATE='20160000' THEN BALAMT ELSE 0 END) + SUM(INAMT)-SUM(OUTAMT) AS REALAMT, --ACDEPOSIT���� ������   \n");
						sql.append( " 	       0 CUAMT,               --�����Է���.                                                                                  \n");
						sql.append( " 	      '0'RESULT,                                                                                                             \n");
						sql.append( " 	      1 RSTSEQ                                                                                                               \n");
						sql.append( " 	  FROM ACCOUNT.ACDEPOSIT                                                                                                     \n");
						sql.append( " 	 WHERE DEDATE <'20161001'                                                                                                    \n");
						sql.append( " 	 GROUP BY DEDATE                                                                                                             \n");
						sql.append( "                                                                                                                                      \n");
						sql.append( " 	UNION ALL                                                                                                                    \n");
						sql.append( " 	--�Ա�                                                                                                                       \n");
						sql.append( " 	SELECT A.ACCTNO,                                                                                                             \n");
						sql.append( " 	       '20161004' AS REPTDT,                                                                                                 \n");
						sql.append( " 	       A.DEDATE,                                                                                                             \n");
						sql.append( " 	       '�Ա�'INOUTGB,                                                                                                        \n");
						sql.append( " 	       A.RSTREMARK,                                                                                                          \n");
						sql.append( " 	       A.COSTCD,                                                                                                             \n");
						sql.append( " 	       ''REMARK,                                                                                                             \n");
						sql.append( " 	       0 PLANAMT, --ACREPLAN�� CUAMT �ݾ�                                                                                    \n");
						sql.append( " 	       SUM(INAMT)AS REALAMT, --ACDEPOSIT���� ������                                                                          \n");
						sql.append( " 	       0 CUAMT    --�����Է���.                                                                                              \n");
						sql.append( " 	       , B.RESULT,  B.RSTSEQ                                                                                                 \n");
						sql.append( " 	  FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B                                                                               \n");
						sql.append( " 	 WHERE A.ACCTNO = B.ACCTNO(+)                                                                                                \n");
						sql.append( " 	   AND A.RESULT ='1'  -- �Ա�                                                                                                \n");
						sql.append( " 	   AND A.DEDATE ='20161001' -- �ŷ�����                                                                                      \n");
						sql.append( " 	GROUP BY A.ACCTNO, A.DEDATE, B.RESULT, A.RSTREMARK, A.COSTCD, B.RSTSEQ                                                       \n");
						sql.append( "                                                                                                                                      \n");
						sql.append( " 	UNION ALL                                                                                                                    \n");
						sql.append( " 	--���                                                                                                                       \n");
						sql.append( " 	SELECT A.ACCTNO,                                                                                                             \n");
						sql.append( " 	       '20161004' AS REPTDT ,                                                                                                \n");
						sql.append( " 	       A.DEDATE AS DEALDT,                                                                                                   \n");
						sql.append( " 	       '���'INOUTGB,                                                                                                        \n");
						sql.append( " 	       B.RSTREMARK,                                                                                                          \n");
						sql.append( " 	       A.COSTCD,                                                                                                             \n");
						sql.append( " 	       ''REMARK,                                                                                                             \n");
						sql.append( " 	       0 PLANAMT,               --ACREPLAN�� CUAMT �ݾ�                                                                      \n");
						sql.append( " 		SUM(OUTAMT)AS REALAMT,  --ACDEPOSIT���� ������                                                                       \n");
						sql.append( " 	       0 CUAMT                  --�����Է���.                                                                                \n");
						sql.append( " 	       , B.RESULT, B.RSTSEQ                                                                                                  \n");
						sql.append( " 	  FROM ACCOUNT.ACDEPOSIT A, ACCOUNT.ACCTINFO B                                                                               \n");
						sql.append( " 	 WHERE A.ACCTNO = B.ACCTNO(+)                                                                                                \n");
						sql.append( " 	   AND A.RESULT ='2'        --���                                                                                           \n");
						sql.append( " 	   AND A.DEDATE ='20161001' --�ŷ�����                                                                                       \n");
						sql.append( " 	 GROUP BY A.ACCTNO, A.DEDATE, B.RESULT, B.RSTREMARK, A.COSTCD, B.RSTSEQ                                                      \n");
						sql.append( "                                                                                                                                      \n");
						sql.append( " 	UNION ALL                                                                                                                    \n");
						sql.append( " 	--�ڱݰ����� =  SUM(�Ա�) - SUM(���)                                                                                        \n");
						sql.append( " 	SELECT '' ACCTNO,             -- ����                                                                                        \n");
						sql.append( " 	       '20161004' AS REPTDT , -- ��������                                                                                    \n");
						sql.append( " 	       '20161001' ,               -- �ŷ�����                                                                                \n");
						sql.append( " 	       '�ڱݰ�����' AS INOUTGB,  --                                                                                          \n");
						sql.append( " 	       '1.������ ����' AS RSTREMARK,                                                                                         \n");
						sql.append( " 	       '1.����' AS COSTCD,                                                                                                   \n");
						sql.append( " 	       ''REMARK,                                                                                                             \n");
						sql.append( " 	       0 PLANAMT,             --ACREPLAN�� CUAMT �ݾ�                                                                        \n");
						sql.append( " 	       SUM(INAMT)-SUM(OUTAMT) AS REALAMT, --ACDEPOSIT���� ������                                                             \n");
						sql.append( " 	       0 CUAMT,               --�����Է���.                                                                                  \n");
						sql.append( " 	      '0'RESULT,                                                                                                             \n");
						sql.append( " 	      600 RSTSEQ                                                                                                             \n");
						sql.append( " 	  FROM ACCOUNT.ACDEPOSIT                                                                                                     \n");
						sql.append( " 	 WHERE DEDATE <='20161001'                                                                                                   \n");
						sql.append( " 	   AND RESULT IN ('1','2' )         --�Ա�                                                                                   \n");
						sql.append( "                                                                                                                                      \n");
						sql.append( "                                                                                                                                      \n");
						sql.append( " 	UNION ALL                                                                                                                    \n");
						sql.append( " 	--�����̿� = �����̿� + SUM(�Ա�) - SUM(���)                                                                                \n");
						sql.append( " 	SELECT '' ACCTNO,             -- ����                                                                                        \n");
						sql.append( " 	       '20161004' AS REPTDT , -- ��������                                                                                    \n");
						sql.append( " 	       '20161001' ,               -- �ŷ�����                                                                                \n");
						sql.append( " 	       '�����̿�' AS INOUTGB,  --                                                                                            \n");
						sql.append( " 	       '�����̿�' AS RSTREMARK,                                                                                              \n");
						sql.append( " 	       '�����̿�' AS COSTCD,                                                                                                 \n");
						sql.append( " 	       ''REMARK,                                                                                                             \n");
						sql.append( " 	       0 PLANAMT,             --ACREPLAN�� CUAMT �ݾ�                                                                        \n");
						sql.append( " 	       SUM(CASE WHEN DEDATE='20160000' THEN BALAMT ELSE 0 END) + SUM(INAMT)-SUM(OUTAMT) AS REALAMT, --ACDEPOSIT���� ������   \n");
						sql.append( " 	       0 CUAMT,               --�����Է���.                                                                                  \n");
						sql.append( " 	      '0'RESULT,                                                                                                             \n");
						sql.append( " 	      9999 RSTSEQ                                                                                                            \n");
						sql.append( " 	  FROM ACCOUNT.ACDEPOSIT                                                                                                     \n");
						sql.append( " 	 WHERE DEDATE <='20161001'                                                                                                   \n");
						sql.append( " 	   AND RESULT IN ('1','2' )         --�Ա�                                                                                   \n");
						sql.append( " ) X, ACCOUNT.COMMDTIL Y                                                                                                              \n");
						sql.append( " WHERE X.COSTCD = Y.CDCODE(+) AND Y.CMTYPE(+)='0030'                                                                                  \n");
						sql.append( " ORDER BY X.RSTSEQ                                                                                                                    \n");
						sql.append( "                                                                                                                                      \n");
						
						/*
						if(!str[0].equals("")) sql.append( " AND A.ACCTCD = '"+str[0]+"'\n");
						if(!str[1].equals("")) sql.append( " AND A.ACCTNO = '"+str[1]+"'\n");
						if(!str[2].equals("")&&!str[3].equals("")) sql.append( " AND A.DEDATE BETWEEN '"+str[2]+"' AND '"+str[3]+"'\n");
						if(!str[4].equals("")) sql.append( " AND A.REMARK = '"+str[4]+"'	\n");
						*/
					

						System.out.println("# a400020_s1 Query : \n" + sql);
						
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