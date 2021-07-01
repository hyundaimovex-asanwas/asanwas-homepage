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
public class a070022_s1 extends HttpServlet {

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

				String  str1 = req.getParameter("v_str1");    //����
				String  str2 = req.getParameter("v_str2");    //ȸ����
				String  str3 = req.getParameter("v_str3");    //��������FR
				String  str4 = req.getParameter("v_str4");    //��������TO
				String  str5 = req.getParameter("v_str5");    //���ޱ���  1 ����,  2 ���� 
				String  str6 = req.getParameter("v_str6");    //ȸ���� to

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
		
				GauceRes.enableFirstRow(dSet);				

				String[] strArrCN = new String[]{"FDCODE",      "TSDAT",    "TSNBR",        "TSSEQ",   
                                             	"GUBUN",        "ATCODE",  "ATKORNAM",     "VENDCD",   "VENDNM1",
                                                "JANAMT",       "ACTDAT",   "PAYDAT",      "FULDAT", 
                                                "REMARK",      "FSDAT",      "FSNBR" ,       "FSSTAT",   "DGB", "GB", 
                                                "ACTDAT2",      "VENDNM",  "FULDAT2",      "TAXDAT",    "TAXDAT2"
                                                }; 

				int[] intArrCN = new int[]{ 2 ,  9,   6,   5,  
	                                        5 ,  7, 66, 13, 32, 
	                                       15,  8,   8,   8,
	                                     132,  9,   6,   1,  20,  1, 
	                                        6,  32, 6,   8 , 6
	                                     }; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,
											 -1,-1,-1,-1,-1,
											  0 ,-1,-1,-1,
	                                        -1,-1,-1, -1, -1, -1,
	                                        -1, -1, -1, -1, -1
                                           };  				                                           

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					 
					sql.append( " SELECT A.FDCODE, A.TSDAT, A.TSNBR, A.TSSEQ,                               		\n");
					sql.append( "        CASE WHEN A.CHKCASH='T' THEN '����'                                    \n");
					sql.append( "             WHEN A.CHKBILL='T'  THEN '����' END GUBUN,                 	\n");
					sql.append( "        A.ATCODE, B.ATKORNAM,  A.VENDCD, C.VEND_NM AS VENDNM1,	\n");
					sql.append( "        A.JANAMT, A.ACTDAT, A.PAYDAT, RTRIM(A.FULDAT)FULDAT,                   	\n");
					sql.append( "        A.REMARK, A.FSDAT, A.FSNBR, A.FSSTAT, C.VEND_NM||'3' AS DGB , '3'GB  ,           \n");
					sql.append( "        SUBSTR(A.ACTDAT,3,6) ACTDAT2, C.VEND_NM AS VENDNM ,SUBSTR(A.FULDAT,3,6) FULDAT2,         \n");
					sql.append( "        CASE WHEN  L.TAXDAT IS NULL THEN TO_CHAR(LAST_DAY(TO_DATE('"+str2+"','YYYYMM')),'YYYYMMDD') ELSE  L.TAXDAT END AS TAXDAT, \n");
					sql.append( "        CASE WHEN  L.TAXDAT IS NULL THEN SUBSTR(TO_CHAR(LAST_DAY(TO_DATE('"+str2+"','YYYYMM')),'YYYYMMDD'),3,6) ELSE SUBSTR(L.TAXDAT,3,6) END AS TAXDAT2  \n");
					sql.append( "   FROM ACCOUNT.ACUSTPAY A                     										\n");
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE 				\n");
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VENDCD = C.VEND_CD 		\n");
					sql.append( "   LEFT JOIN ACCOUNT.FSLIPDTL N ON A.FDCODE  = N.FDCODE AND A.TSDAT = N.FSDAT AND A.TSNBR =N.FSNBR AND A.TSSEQ = N.FSSEQ AND N.DOCUVAL IS NOT NULL  		\n");
					sql.append( "   LEFT JOIN ACCOUNT.ATTAXMST L ON N.DOCUVAL = L.TAXNBR 		\n");
					sql.append( "  WHERE 1 = 1                                                            							\n");
					if (str5.equals("1"))sql.append( " AND A.CHKCASH ='T'                                                	\n");
					if (str5.equals("2"))sql.append( " AND A.CHKBILL ='T'                                                  	\n");	
					sql.append( "    AND A.FDCODE ='"+str1+"'                                                                   \n");
					sql.append( "    AND (A.ACTDAT LIKE '"+str2+"%' OR A.ACTDAT LIKE '"+str6+"%' )                  \n");
					sql.append( "    AND A.PAYDAT BETWEEN'"+str3+"' AND '"+str4+"'                                	\n");
					
					//�ŷ�ó �Ұ�
					sql.append( "    UNION ALL              																			\n");
					sql.append( "  SELECT '' FDCODE, '' TSDAT,'' TSNBR, '' TSSEQ,                              		\n");
					sql.append( "         CASE WHEN A.CHKCASH='T' THEN '����'                              	\n");
					sql.append( "              WHEN A.CHKBILL='T' THEN '����' END GUBUN,            	\n");
					sql.append( "         '' ATCODE, '' ATKORNAM,  A.VENDCD,C.VEND_NM AS  VENDNM1, \n");
					sql.append( "         SUM(A.JANAMT) JANAMT, '' ACTDAT, '' PAYDAT, '' FULDAT,    		\n");
					sql.append( "         '' REMARK, '' FSDAT, '' FSNBR, '' FSSTAT , C.VEND_NM ||'2' AS DGB, '2'GB,         \n");
					//sql.append( "         '' ACTDAT2,   '               ��     ��' AS VENDNM, '' FULDAT2 , ''TAXDAT, ''TAXDAT2      	\n");
					sql.append( "         '' ACTDAT2,   C.VEND_NM||' �� ��' AS VENDNM, '' FULDAT2 , ''TAXDAT, ''TAXDAT2      	\n");
					sql.append( "    FROM ACCOUNT.ACUSTPAY A                       										\n");
					sql.append( "    LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE  					\n");
					sql.append( "    LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VENDCD = C.VEND_CD  			\n");
					sql.append( "  WHERE 1 = 1                                                 										\n");
					if (str5.equals("1"))sql.append( " AND A.CHKCASH ='T'                                                	\n");
					if (str5.equals("2"))sql.append( " AND A.CHKBILL ='T'                                                  	\n");	
					sql.append( "    AND A.FDCODE ='"+str1+"'                                                                   \n");
					sql.append( "    AND (A.ACTDAT LIKE '"+str2+"%' OR A.ACTDAT LIKE '"+str6+"%' )                  \n");
					sql.append( "    AND A.PAYDAT BETWEEN'"+str3+"' AND '"+str4+"'                                	\n");
					sql.append( "  GROUP BY A.VENDCD, C.VEND_NM, A.CHKCASH,A.CHKBILL    					\n");
					sql.append( "  HAVING COUNT(*)>=2                                                        					\n");

					//��ü��
					sql.append( "    UNION ALL              																			\n");
					sql.append( " SELECT '' FDCODE, '' TSDAT,'' TSNBR, '' TSSEQ,                                  	\n");
					sql.append( "        CASE WHEN A.CHKCASH='T' THEN '����'                                  	\n");
					sql.append( "             WHEN A.CHKBILL='T' THEN '����' END GUBUN,               	\n");
					sql.append( "        '' ATCODE, '' ATKORNAM,  '' VENDCD, '��������' VENDNM1,  		\n");
					sql.append( "        SUM(A.JANAMT) JANAMT, '' ACTDAT, '' PAYDAT, '' FULDAT,      		\n");
					sql.append( "        '' REMARK, '' FSDAT, '' FSNBR, '' FSSTAT , '��������'||'4' AS DGB,'4'GB ,                  \n");
					sql.append( "        '' ACTDAT2  , '            ��   ü    ��' VENDNM, '' FULDAT2, ''TAXDAT, ''TAXDAT2               \n");
					sql.append( "   FROM ACCOUNT.ACUSTPAY A                        										\n");
					sql.append( "   LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE   				\n");
					sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER C ON A.VENDCD = C.VEND_CD   		\n");
					sql.append( "  WHERE 1 = 1                                                            							\n");
					if (str5.equals("1"))sql.append( " AND A.CHKCASH ='T'                                                	\n");
					if (str5.equals("2"))sql.append( " AND A.CHKBILL ='T'                                                  	\n");	
					sql.append( "    AND A.FDCODE ='"+str1+"'                                                                   \n");
					sql.append( "    AND (A.ACTDAT LIKE '"+str2+"%' OR A.ACTDAT LIKE '"+str6+"%' )                  \n");
					sql.append( "    AND A.PAYDAT BETWEEN'"+str3+"' AND '"+str4+"'                                	\n");
					sql.append( "  GROUP BY A.CHKCASH,A.CHKBILL                                                       	\n");
					sql.append( "  ORDER BY DGB                                                               					\n");
					
					//System.out.println("# Query : \n" + sql);
					//logger.dbg.println(this,"sql.toString()::"+sql.toString());
					
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