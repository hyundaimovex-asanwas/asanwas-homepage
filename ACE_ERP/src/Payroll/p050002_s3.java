package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p050002_s3 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601 ");
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
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//���س��
				str[1]	= req.getParameter("v_str2");		//�μ�
				str[2]	= req.getParameter("v_str3");		//����
				str[3]	= req.getParameter("v_str4");		//������
				str[4]	= req.getParameter("v_str5");		//LEVEL
				str[5]	= req.getParameter("v_str6");		//TREECD

				for (int s=0;s<6;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"APPYM", "GROUPID","MEDSNO","EMPNO","EMPNMK","DEPTCD",
					"PAYGRD","SEQ","PRE_STDAMT","PRE_INSAMT","STDAMT",
					"INSAMT","ADDAMT","REMARK","SEQ2","PAYSEQ",
					"GROUPNM"
				};

				int[] intArrCN = new int[]{ 
					6,  2, 20, 7,  30, 4,
          4,  3, 9,   9, 9,
          9,  9, 100, 3, 4,
					50
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, -1, -1, -1, -1,
					-1,  0,  0,  0,  0,
					 0,  0, -1,  0, -1,
					-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " /*�ǰ������ ������ȸ*/                                                                        \n ");
					sql.append( " SELECT '"+str[0]+"' APPYM, IFNULL(Y.GROUPID,'') GROUPID ,X.MEDSNO, X.EMPNO,                          \n ");
					sql.append( "        MAX(CASE WHEN (M.EMPNMK=''OR M.EMPNMK IS NULL) THEN N.EMPNMK ELSE M.EMPNMK END) EMPNMK, \n ");
					sql.append( "        MAX(CASE WHEN (M.EMPNMK=''OR M.EMPNMK IS NULL) THEN N.DEPTCD ELSE M.DEPTCD END) DEPTCD, \n ");
					sql.append( "        MAX(CASE WHEN (M.EMPNMK=''OR M.EMPNMK IS NULL) THEN N.PAYGRD ELSE M.PAYGRD END) PAYGRD, \n ");
					sql.append( "        I.SEQ,   \n ");
					sql.append( "        IFNULL(SUM(X.PRE_STDAMT),0)PRE_STDAMT, IFNULL(SUM(X.PRE_INSAMT),0) PRE_INSAMT,          \n ");
					sql.append( "        IFNULL(SUM(X.STDAMT),0) STDAMT, IFNULL(SUM(X.INSAMT),0) INSAMT,                         \n ");
					sql.append( "        IFNULL(SUM(X.INSAMT),0) - IFNULL(SUM(X.PRE_INSAMT),0) AS ADDAMT,                        \n ");
					sql.append( "        MAX(RTRIM(X.REMARK))REMARK, D.SEQ AS SEQ2, MAX(X.PAYSEQ)PAYSEQ,MAX(RTRIM(I.MINORNM)) GROUPNM   \n ");
					sql.append( "   FROM                                                                                         \n ");
					sql.append( " (                                                                                              \n ");
					sql.append( " /*������*/                                                                                     \n ");
					sql.append( "   SELECT A.APPYM, A.MEDSNO, A.EMPNO,                                                           \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.EMPNMK ELSE C.EMPNMK END EMPNMK,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.DEPTCD ELSE C.DEPTCD END DEPTCD,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.PAYGRD ELSE C.PAYGRD END PAYGRD,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.PAYSEQ ELSE C.PAYSEQ END PAYSEQ,    \n ");
					sql.append( "          A.STDAMT AS PRE_STDAMT, A.INSAMT AS PRE_INSAMT, 0 STDAMT,  0 INSAMT,                  \n ");
					sql.append( "          '' REMARK                                                                             \n ");
					sql.append( "     FROM PAYROLL.PWINDIPN A                                                                    \n ");
					sql.append( "     LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO                                          \n ");
					sql.append( "     LEFT JOIN PAYROLL.T_HIPERSON D ON A.EMPNO = D.EMPNO                                        \n ");
					sql.append( "    WHERE APPYM= '"+str[3]+"'                                                                   \n ");
					sql.append( "    UNION ALL                                                                                   \n ");
					sql.append( " /*�����*/                                                                                     \n ");
          sql.append( "   SELECT A.APPYM, A.MEDSNO, A.EMPNO,                                                           \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.EMPNMK ELSE C.EMPNMK END EMPNMK,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.DEPTCD ELSE C.DEPTCD END DEPTCD,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.PAYGRD ELSE C.PAYGRD END PAYGRD,    \n ");
					sql.append( "          CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) AND (B.PAYSEQ=''OR B.PAYSEQ IS NULL) THEN D.PAYSEQ ELSE C.PAYSEQ END PAYSEQ, \n ");
					sql.append( "          0 PRE_STDAMT, 0 PRE_INSAMT, 0 STDAMT,  0 AS INSAMT, '' REMARK                  \n ");
					sql.append( "     FROM PAYROLL.PWINDIPN_H A                                                                  \n ");
					sql.append( "     LEFT JOIN PAYROLL.PBPAY B ON A.EMPNO = B.EMPNO AND B.APPDT = '"+str[0]+"'  AND B.PAYDIV IN ('1','T') \n ");
					sql.append( "     LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO                                          \n ");
					sql.append( "     LEFT JOIN PAYROLL.T_HIPERSON D ON A.EMPNO = D.EMPNO                                        \n ");
					sql.append( "    WHERE APPYM=(SELECT MAX(APPYM) FROM PAYROLL.PWINDIPN_H                                      \n ");
					sql.append( "                  WHERE APPYM <'"+str[0]+"')                                                    \n ");
          sql.append( "    UNION ALL                                                                                                                      \n ");
					sql.append( "     SELECT A.APPYM, A.MEDSNO, A.EMPNO,                                                                                            \n ");
					sql.append( "            CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.EMPNMK ELSE C.EMPNMK END EMPNMK,                                     \n ");
					sql.append( "            CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.DEPTCD ELSE C.DEPTCD END DEPTCD,                                     \n ");
					sql.append( "            CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) THEN D.PAYGRD ELSE C.PAYGRD END PAYGRD,                                     \n ");
					sql.append( "            CASE WHEN (C.EMPNMK=''OR C.EMPNMK IS NULL) AND (B.PAYSEQ=''OR B.PAYSEQ IS NULL) THEN D.PAYSEQ ELSE C.PAYSEQ END PAYSEQ,\n ");
					sql.append( "            0 PRE_STDAMT, 0 PRE_INSAMT, A.STDAMT,  B.B11000 AS INSAMT, '' REMARK                                     \n ");
					sql.append( "       FROM PAYROLL.PWINDIPN_H A                                                                                                   \n ");
					sql.append( "       LEFT JOIN PAYROLL.PBPAY B ON A.EMPNO = B.EMPNO AND B.APPDT = '"+str[0]+"' AND B.PAYDIV IN('1','T')                              \n ");
					sql.append( "       LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO                                                                           \n ");
					sql.append( "       LEFT JOIN PAYROLL.T_HIPERSON D ON A.EMPNO = D.EMPNO                                                                         \n ");
					sql.append( "      WHERE A.APPYM=(SELECT MAX(APPYM) FROM PAYROLL.PWINDIPN_H                                                                     \n ");
					sql.append( "                      WHERE APPYM <='"+str[0]+"')                                                                                      \n ");
					sql.append( "    \n ");
					
					sql.append( " ) X                                                                                            \n ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT Y ON Y.DEPTCD = X.DEPTCD                                              \n ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON X.PAYGRD = D.MINORCD AND D.MAJORCD = '2002'                     \n ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE I ON Y.GROUPID = I.MINORCD AND I.MAJORCD = '2051'                    \n ");
					sql.append( " LEFT JOIN PAYROLL.HIPERSON M ON X.EMPNO = M.EMPNO                                              \n ");
					sql.append( " LEFT JOIN PAYROLL.T_HIPERSON N ON X.EMPNO = N.EMPNO                                            \n ");
					sql.append( " GROUP BY X.MEDSNO,X.EMPNO, D.MINORNM, I.SEQ ,Y.GROUPID , D.SEQ                                 \n ");
					sql.append( " ORDER BY I.SEQ, D.SEQ, MAX(X.PAYSEQ) DESC, X.EMPNO                                             \n ");
 
				
				  // logger.dbg.println(this,sql.toString());
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