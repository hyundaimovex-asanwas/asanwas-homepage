package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class a090032_s2 extends HttpServlet {
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
				// ������ �Ѱ�ǥ ��ȸ

				String  str1 = req.getParameter("v_str1");    //����
				String  str2 = req.getParameter("v_str2");    //TO���
				String  str3 = req.getParameter("v_str3");    //���⵵
				String  str4 = req.getParameter("v_str4");    //����⵵
				

				String  strcstddt ="" ;    //���01��01
				String  strcenddt ="" ;    //��� �˻� TO��� ������ 31��
				String  strcyymm ="" ;     //���⵵�� 01��
				String  strbstddt ="" ;    //����01��01
				String  strbenddt ="" ;    //����12��31��
	
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";

				strcstddt = str3 + "0101";
				strcenddt = str2 + "31";
				strcyymm  = str3 + "01";
				strbstddt = str4 + "0101";
				strbenddt = str4 + "1231";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",   "AST2ND",   "AST2NDNM",  "ASTYUSE",
					                                "BEFAQAMT", "CURAQAMT", "CLSAQAMT",  "MOVAQAMT", "AQAMTSUM",
					                                "ABDEPRAMT","ACDEPRAMT","ACDEPRSUM", "REDUAMT",  "DEAMTSUM",  "JAAMTSUM"
					                              }; 

				int[] intArrCN = new int[]{ 2,  2,  60,  5, 
					                         13, 13 , 13,  13, 13,
				                           13, 13 , 13,  13, 13, 13
				 }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1,  2, 
					                           0,  0,  0,  0, 0,
					                           0,  0,  0,  0, 0, 13
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT Q.FDCODE, Q.AST2ND, CASE WHEN Q.AST2ND='99' THEN '�Ǽ������ڻ�' ELSE G.CDNAM END  AS AST2NDNM, Q.ASTYUSE,                                                 \n");
					sql.append( "        SUM(Q.BEFAQAMT)BEFAQAMT,   SUM(Q.CURAQAMT)CURAQAMT,   SUM(Q.CLSAQAMT)CLSAQAMT,   SUM(Q.MOVAQAMT)MOVAQAMT,                                                 \n");
					sql.append( "        SUM(Q.BEFAQAMT)+SUM(Q.CURAQAMT)-SUM(Q.CLSAQAMT)-SUM(Q.MOVAQAMT) AS AQAMTSUM,                                                                              \n");
					sql.append( "        SUM(Q.ABDEPRAMT)ABDEPRAMT, SUM(Q.ACDEPRAMT)ACDEPRAMT, SUM(Q.ACDEPRSUM)ACDEPRSUM, SUM(Q.REDUAMT)REDUAMT,                                                   \n");  
					sql.append( "        0 AS DEAMTSUM,  0 AS JAAMTSUM                                                                                                                             \n");  
					sql.append( "   FROM (                                                                                                                                                         \n");
					sql.append( " 	SELECT X.FDCODE, X.AST2ND, X.ASTYUSE,                                                                                                                          \n");  
					sql.append( " 		   (SUM(X.BEFAQAMT)-SUM(X.NEWAQAMT)) AS BEFAQAMT, (SUM(X.CURAQAMT)+SUM(X.NEWAQAMT)) AS CURAQAMT, SUM(X.CLSAQAMT)CLSAQAMT,                                    \n");
					sql.append( " 			SUM(X.MOVAQAMT)MOVAQAMT,                                                                                                                                   \n");
					sql.append( " 			0 AS ABDEPRAMT, 0 AS ACDEPRAMT, 0  AS ACDEPRSUM, 0 AS REDUAMT                                                                                              \n");  
					sql.append( " 	  FROM (                                                                                                                                                       \n");
					sql.append( " 			-- ����, ��� �ű� ���(���⿡�� ����� �ں��� ����ݾ��� �����ؾ���.)                                                                                     \n");
					sql.append( " 		SELECT A.FDCODE, A.AST2ND, B.ASTYUSE,                                                                                                                        \n");  
					sql.append( " 			   SUM(CASE WHEN A.ASAQSDAT <= '"+strbenddt+"' THEN (B.ASTAQAMT) ELSE 0 END)  BEFAQAMT,                                                                      \n");
					sql.append( " 			   SUM(CASE WHEN A.ASAQSDAT >= '"+strcstddt+"' AND A.ASAQSDAT<='"+strcenddt+"' THEN (B.ASTAQAMT) ELSE 0 END)  CURAQAMT,                                      \n");
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                            \n");  
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                            \n");
					sql.append( " 			   0 AS MOVAQAMT                                                                                                                                             \n");
					sql.append( " 		  FROM ACCOUNT.ASTMSTN A, ACCOUNT.ASTBASICN B                                                                                                                  \n");  
					sql.append( " 		 WHERE A.FDCODE = B.FDCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.ATCODE = B.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.AST1ST = B.AST1ST                                                                                                                                     \n");  
					sql.append( " 		   AND A.AST2ND = B.AST2ND                                                                                                                                     \n");
					sql.append( " 		   AND A.AST3RD = B.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND A.ASTSEQ = B.ASTSEQ                                                                                                                                     \n");  
					sql.append( " 		   AND A.FDCODE = '"+str1+"'                                                                                                                                   \n");  
					sql.append( " 		   AND A.ASAQSDAT <= '"+strcenddt+"'                                                                                                                           \n");
					sql.append( " 		 GROUP BY A.FDCODE, A.AST2ND,B.ASTYUSE                                                                                                                         \n");  
					sql.append( " 		UNION ALL                                                                                                                                                      \n");
					sql.append( " 		--�ں������� ( �ű���濡 ���Ե� )                                                                                                                             \n");  
					sql.append( " 		SELECT A.FDCODE, A.AST2ND, B.ASTYUSE,                                                                                                                          \n");
					sql.append( " 			   0 AS BEFAQAMT,                                                                                                                                            \n");
					sql.append( " 			   0 AS CURAQAMT,                                                                                                                                            \n");  
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                            \n");
					sql.append( " 			   SUM(CASE WHEN A.CHGDATE >='"+strcstddt+"' AND A.CHGDATE<='"+strcenddt+"' THEN (A.CHGAMT) ELSE 0 END)  NEWAQAMT,                                           \n");
					sql.append( " 			   0 AS MOVAQAMT                                                                                                                                             \n");  
					sql.append( " 		  FROM ACCOUNT.ASTCHG A, ACCOUNT.ASTBASICN B                                                                                                                   \n");
					sql.append( " 		 WHERE A.FDCODE = B.FDCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.ATCODE = B.ATCODE                                                                                                                                     \n");  
					sql.append( " 		   AND A.AST1ST = B.AST1ST                                                                                                                                     \n");
					sql.append( " 		   AND A.AST2ND = B.AST2ND                                                                                                                                     \n");
					sql.append( " 		   AND A.AST3RD = B.AST3RD                                                                                                                                     \n");  
					sql.append( " 		   AND A.ASTSEQ = B.ASTSEQ                                                                                                                                     \n");
					sql.append( " 		   AND A.FDCODE = '"+str1+"'                                                                                                                                   \n");  
					sql.append( " 		   AND A.CHGTYPE IN ('3')                                                                                                                                      \n");
					sql.append( " 		   AND A.CHGDATE LIKE '"+str3+"%'                                                                                                                              \n");  
					sql.append( " 		GROUP BY A.FDCODE, A.AST2ND, B.ASTYUSE                                                                                                                         \n");
					sql.append( " 		UNION ALL                                                                                                                                                      \n");
                    sql.append( " 		--�Ű�, ���                                                                                                                                                   \n");
					sql.append( " 		SELECT A.FDCODE, A.AST2ND, B.ASTYUSE,                                                                                                                          \n");
					sql.append( " 			   0 AS BEFAQAMT,                                                                                                                                            \n");  
					sql.append( " 			   0 AS CURAQAMT,                                                                                                                                            \n");
					sql.append( " 			   SUM(CASE WHEN A.CHGDATE >='"+strcstddt+"' AND A.CHGDATE<='"+strcenddt+"' THEN (B.ASTAQAMT) ELSE 0 END)  CLSAQAMT,                                         \n");
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                            \n");  
					sql.append( " 			   0 AS MOVAQAMT                                                                                                                                             \n");
					sql.append( " 		  FROM ACCOUNT.ASTCHG A, ACCOUNT.ASTBASICN B                                                                                                                   \n");
					sql.append( " 		 WHERE A.FDCODE = B.FDCODE                                                                                                                                     \n");  
					sql.append( " 		   AND A.ATCODE = B.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.AST1ST = B.AST1ST                                                                                                                                     \n");
					sql.append( " 		   AND A.AST2ND = B.AST2ND                                                                                                                                     \n");  
					sql.append( " 		   AND A.AST3RD = B.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND A.ASTSEQ = B.ASTSEQ                                                                                                                                     \n");
					sql.append( " 		   AND A.FDCODE = '"+str1+"'                                                                                                                                   \n");  
					sql.append( " 		   AND A.CHGTYPE IN ('1','2')                                                                                                                                  \n");  
					sql.append( " 		   AND A.CHGDATE LIKE '"+str3+"%'                                                                                                                              \n");
					sql.append( " 		GROUP BY A.FDCODE, A.AST2ND, B.ASTYUSE                                                                                                                         \n");
					sql.append( " 		UNION ALL                                                                                                                                                      \n");
					sql.append( " 		--�����ü����  ���ݾ� ( ����==>���� ��ü ��ϰ� ������� ���� ) ASTMSTN,ASTBASICN ����                                                                      \n");
					sql.append( " 		SELECT M.FDCODE, M.AST2ND, C.ASTYUSE,                                                                                                                          \n");  
					sql.append( " 			   0 AS BEFAQAMT,                                                                                                                                            \n");
					sql.append( " 			   0 AS CURAQAMT,                                                                                                                                            \n");
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                            \n");  
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                            \n");
					sql.append( " 			   COALESCE(SUM(C.ASTAQAMT),0) MOVAQAMT                                                                                                                      \n");
					sql.append( " 		  FROM (                                                                                                                                                       \n");  
					sql.append( " 			   SELECT A.FDCODE, A.ATCODE, A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ                                                                                           \n");
					sql.append( " 				 FROM ACCOUNT.ASTYEPR A                                                                                                                                      \n");
					sql.append( " 				WHERE A.FDCODE ='"+str1+"'                                                                                                                                   \n");  
					sql.append( " 				  AND A.REGIGB ='2'                                                                                                                                          \n");
					//sql.append( " 				  AND REPLACE(CAST((DATE(SUBSTR(A.ASTYM,1,4)||'-'||SUBSTR(A.ASTYM,5,2)||'-01')+ 1 MONTH) AS VARCHAR(10)),'-','') BETWEEN '"+strcstddt+"' AND '"+strcenddt+"' \n");
					sql.append( " 				  AND TO_CHAR(ADD_MONTHS(SUBSTR(A.ASTYM,1,4)||SUBSTR(A.ASTYM,5,2)||'01',1),'YYYYMMDD')    BETWEEN '"+strcstddt+"' AND '"+strcenddt+"' \n");     
					sql.append( " 				  AND SUBSTR(A.ASTYM,5,2) <>'00'                                                                                                                           \n");  
					sql.append( " 				GROUP BY A.FDCODE, A.ATCODE, A.AST1ST, A.AST2ND, A.AST3RD, A.ASTSEQ                                                                                        \n");
					sql.append( " 			   )M, ACCOUNT.ASTMSTN B, ACCOUNT.ASTBASICN C                                                                                                                \n");
					sql.append( " 		 WHERE M.FDCODE = B.FDCODE                                                                                                                                     \n");  
					sql.append( " 		   AND M.ATCODE = B.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND M.AST1ST = B.AST1ST                                                                                                                                     \n");
					sql.append( " 		   AND M.AST2ND = B.AST2ND                                                                                                                                     \n");  
					sql.append( " 		   AND M.AST3RD = B.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND M.ASTSEQ = B.ASTSEQ                                                                                                                                     \n");
					sql.append( " 		   AND M.FDCODE = C.FDCODE                                                                                                                                     \n");  
					sql.append( " 		   AND M.ATCODE = C.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND M.AST1ST = C.AST1ST                                                                                                                                     \n");
					sql.append( " 		   AND M.AST2ND = C.AST2ND                                                                                                                                     \n");  
					sql.append( " 		   AND M.AST3RD = C.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND M.ASTSEQ = C.ASTSEQ                                                                                                                                     \n");
					sql.append( " 		   AND M.FDCODE ='"+str1+"'                                                                                                                                    \n");  
					sql.append( " 		   AND B.ASAQSDAT <='"+strcenddt+"'                                                                                                                                  \n");
					sql.append( " 		GROUP BY M.FDCODE, M.AST2ND, C.ASTYUSE                                                                                                                         \n");
					sql.append( " 		UNION ALL                                                                                                                                                      \n");
					sql.append( " 		--�����ü��Ų  ���ݾ� ( ����==>���� ��ü ��ϰ� ������� ���� )                                                                                             \n");
					sql.append( " 		SELECT A.FDCODE, A.AST2ND, C.ASTYUSE,                                                                                                                          \n");  
					sql.append( " 			   0 AS BEFAQAMT,                                                                                                                                          \n");
					sql.append( " 			   0 AS CURAQAMT,                                                                                                                                          \n");
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                          \n");  
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                          \n");
					sql.append( " 			   COALESCE(SUM(CASE WHEN A.MOVDATE >='"+strcstddt+"' AND A.MOVDATE<='"+strcenddt+"' THEN -(C.ASTAQAMT) ELSE 0 END),0) MOVAQAMT                                     \n");
					sql.append( " 		  FROM ACCOUNT.ASTMOVINGN A, ACCOUNT.ASTMSTN B, ACCOUNT.ASTBASICN C                                                                                            \n");  
					sql.append( " 		 WHERE A.FDCODE = B.FDCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.ATCODE = B.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.AST1ST = B.AST1ST                                                                                                                                     \n");  
					sql.append( " 		   AND A.AST2ND = B.AST2ND                                                                                                                                     \n");
					sql.append( " 		   AND A.AST3RD = B.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND A.ASTSEQ = B.ASTSEQ                                                                                                                                     \n");  
					sql.append( " 		   AND A.FDCODE = C.FDCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.ATCODE = C.ATCODE                                                                                                                                     \n");
					sql.append( " 		   AND A.AST1ST = C.AST1ST                                                                                                                                     \n");  
					sql.append( " 		   AND A.AST2ND = C.AST2ND                                                                                                                                     \n");
					sql.append( " 		   AND A.AST3RD = C.AST3RD                                                                                                                                     \n");
					sql.append( " 		   AND A.ASTSEQ = C.ASTSEQ                                                                                                                                     \n");  
                    sql.append( " 		   AND A.FDCODE ='"+str1+"'                                                                                                                                         \n");
					sql.append( " 		   AND A.ASTGUBUN ='9'                                                                                                                                         \n");
					sql.append( " 		   AND A.MOVDATE BETWEEN '"+strcstddt+"' AND '"+strcenddt+"'                                                                                                             \n");  
					sql.append( " 		GROUP BY A.FDCODE, A.AST2ND, C.ASTYUSE                                                                                                                         \n");
					sql.append( " 		UNION ALL                                                                                                                                                      \n");  
					sql.append( " 		--�Ǽ����� �ڻ� ���                                                                                                                                           \n");
					sql.append( " 		SELECT A.FDCODE, '99'AST2ND, 99.00 AS ASTYUSE,                                                                                                                 \n");
					sql.append( " 			   COALESCE(SUM(CASE WHEN A.ASAQSDAT <='"+strbenddt+"' THEN (A.ASTAQAMT) ELSE 0 END),0)  BEFAQAMT,                                                             \n");  
					sql.append( " 			   COALESCE(SUM(CASE WHEN A.ASAQSDAT >='"+strcstddt+"' AND A.ASAQSDAT<='"+strcenddt+"' THEN (A.ASTAQAMT) ELSE 0 END),0) CURAQAMT,                                   \n");
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                          \n");
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                          \n");  
					sql.append( " 			   0 AS MOVAQAMT                                                                                                                                           \n");
					sql.append( " 		 FROM ACCOUNT.ASTCIP A                                                                                                                                         \n");
  			    	sql.append( " 		WHERE A.FDCODE = '"+str1+"'                                                                                                                                          \n");
					sql.append( " 		GROUP BY A.FDCODE                                                                                                                                              \n");  
					sql.append( " 		UNION ALL                                                                                                                                                      \n");
					sql.append( " 		--�Ǽ����� �ڻ� ��ü                                                                                                                                           \n");  
					sql.append( " 		SELECT A.FDCODE, '99' AST2ND, 99.00 AS ASTYUSE,                                                                                                                 \n");
					sql.append( " 			   0 AS BEFAQAMT,                                                                                                                                          \n");
					sql.append( " 			   0 AS CURAQAMT,                                                                                                                                          \n");  
					sql.append( " 			   0 AS CLSAQAMT,                                                                                                                                          \n");
					sql.append( " 			   0 AS NEWAQAMT,                                                                                                                                          \n");
					sql.append( " 			   COALESCE(SUM(CASE WHEN A.ASAQSDAT >='"+strcstddt+"' AND A.ASAQSDAT<='"+strcenddt+"' THEN (A.ASTRAMT) ELSE 0 END),0) AS MOVAQAMT                                  \n");  
                    sql.append( " 		 FROM ACCOUNT.ASTCIPR A                                                                                                                                        \n");
  			    	sql.append( " 		WHERE A.FDCODE = '"+str1+"'                                                                                                                                          \n");
					sql.append( " 		GROUP BY A.FDCODE                                                                                                                                              \n");
					sql.append( " 	)X                                                                                                                                                                 \n");
					sql.append( " 	GROUP BY X.FDCODE, X.AST2ND, X.ASTYUSE                                                                                                                             \n");  					
					sql.append( " )Q                                                                                                                                                                     \n");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL G ON G.CDCODE = Q.AST2ND   AND G.CMTYPE ='2101'  \n");
					sql.append( " WHERE Q.FDCODE ='"+str1+"'                                                                                                                                                  \n");
					sql.append( " GROUP BY Q.FDCODE, Q.AST2ND , G.CDNAM,  Q.ASTYUSE                                                                                                                            \n");
					sql.append( " ORDER BY Q.FDCODE, Q.AST2ND , G.CDNAM,  Q.ASTYUSE                                                                                                                            \n");

					//System.out.println("# Query : \n" + sql);
					//logger.dbg.println( this, sql.toString() );
					
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