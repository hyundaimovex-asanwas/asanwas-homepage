package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h060013_s2 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");  //������
				String  str2	= req.getParameter("v_str2");  //�μ�
				String  str3	= req.getParameter("v_str3");  //����
				String  str4	= req.getParameter("v_str4");  //����
				String  str5	= req.getParameter("v_str5");  //�����
				String  str6	= req.getParameter("v_str6");  //����
				String  str7	= req.getParameter("v_str7");  //�����
				String  str8	= req.getParameter("v_str8");  //����

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
        if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
				if (str7==null ) {str7 ="";}
				if (str8==null ) {str8 ="";}

				if (str2.equals("A000")){str2 ="";}  //����ƻ� ���ý� ��ü�μ���ȸ��.
				if (str3.equals("0")){str3 ="";}  //����ƻ� ���ý� ��ü�μ���ȸ��.


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHKOUT","EVAYM","EMPNOH",  "EMPNMKH", "EMPNO" ,
					                               "EMPNMK","EVASEQ","DEPTCD", "DEPTNM",  "STRTDT",
					                               "PAYGRD" , "PAYGRDNM","OLDEMPNOH" , "OLDEVASEQ" }; 

				int[] intArrCN = new int[]{  1,  6, 7, 20,  7,
					                           20, 1, 4, 50,  8,
					                            4, 30,7, 4 }; 
					                                    
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,
					                           -1, 0,-1,-1,-1,
					                           -1,-1, -1, 0}; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT X.CHKOUT, X.EVAYM, X.EMPNOH,X.EMPNMKH, X.EMPNO, X.EMPNMK,  \n" );
					sql.append( "        X.EVASEQ,X.DEPTCD, SUBSTR(X.DEPTNM,1,20)DEPTNM, X.STRTDT, \n" );
					sql.append( "        X.PAYGRD,X.PAYGRDNM,X.OLDEMPNOH,X.OLDEVASEQ \n" );
					sql.append( "   FROM ( \n" );
					sql.append( "         SELECT '' CHKOUT, A.EVAYM, A.EMPNOH, CASE WHEN SUBSTR(A.EMPNOH,1,1) IN ('1','2') THEN B.EMPNMK ELSE U.EMPNMK END EMPNMKH, A.EMPNO , \n" );
					
					sql.append( "                CASE WHEN SUBSTR(A.EMPNO,1,1) IN ('1','2') THEN C.EMPNMK ELSE T.EMPNMK END EMPNMK,  \n" );
					sql.append( "                A.EVASEQ,A.DEPTCD, RTRIM(A.DEPTNM) DEPTNM, RTRIM(B.STRTDT) STRTDT, \n" );
					sql.append( "                A.PAYGRD, RTRIM(D.MINORNM) AS PAYGRDNM,A.EMPNOH AS OLDEMPNOH,A.EVASEQ AS OLDEVASEQ \n");
					sql.append( "           FROM PAYROLL.HVHEMPS A \n" );
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNOH = B.EMPNO \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO  \n");
					sql.append( "           LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002'  \n");
					sql.append( "           LEFT JOIN PAYROLL.HCDEPT E  ON A.DEPTCD = E.DEPTCD \n");
					sql.append( "           LEFT JOIN PAYROLL.T_HIPERSON T ON A.EMPNO = T.EMPNO  \n");
					sql.append( "           LEFT JOIN PAYROLL.T_HIPERSON U ON A.EMPNOH = U.EMPNO  \n");
					sql.append( "          WHERE  A.EVAYM  = '" + str1 + "'   \n");
					if (!str3.equals("")) sql.append( "  AND A.PAYGRD='"+str3+"'  \n");
					if (!str5.equals("")) sql.append( "  AND A.EMPNOH  LIKE '" + str5 + "%'  \n");
					if (!str6.equals("")) sql.append( " AND CAST(A.EVASEQ  AS CHAR(2))= '" + str6 + "'  \n");
					if (str7.equals("1")) sql.append( " AND SUBSTR(E.TREECD,1,4) = '"+ str8 + "' \n");
					if (str7.equals("2")) sql.append( " AND SUBSTR(E.TREECD,1,4) = '"+ str8 + "' \n");
					if (str7.equals("3")) sql.append( " AND SUBSTR(E.TREECD,1,6) = '"+ str8 + "' \n");
					if (str7.equals("4")) sql.append( " AND RTRIM(E.TREECD) = '" + str8 + "'     \n");
			     sql.append( "  ) X \n" );
                 sql.append( "  WHERE  X.EVAYM<>''" );
				 if (!str4.equals(""))sql.append( "  AND X.EMPNMK  LIKE '" + str4 + "%'  \n");
					
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