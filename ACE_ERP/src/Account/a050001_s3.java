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
public class a050001_s3 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//����
				String  str2 = req.getParameter("v_str2");	//�⵵
				String  str3 = req.getParameter("v_str3");	//����Ⱓfrom
				String  str4 = req.getParameter("v_str4");	//����Ⱓfrom
				String  str5 = req.getParameter("v_str5");	//����/���� ����  A- ����, B- ���� 
				String  str6 = req.getParameter("v_str6");	//���ڹ��� ���� 1- ���ڼ��ݰ�꼭 ����/����  , 2-���ڼ��ݰ�꼭 �̿� ����/����
				String  str7 = req.getParameter("v_str7");	//���

				String  str8 = "" ;	//�ڷᱸ��
				String  str9 = "";	//����ڵ�Ϲ�ȣ


				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";
				if(str6 == null) str5 = "";

        
				if(str5.equals("A")&&str6.equals("2")){
					str8="4";
		        }else if(str5.equals("A")&&str6.equals("1")){
		          str8="6"; 
		        }else if(str5.equals("B")&&str6.equals("2")){
		          str8="3"; 
				}else if(str5.equals("B")&&str6.equals("1")){
					str8="5";
				}
			

				if(str1.equals("01")){ //��
					str9="2218113834";
				}else if(str1.equals("02")){//����
					str9="2218113834";
				}
				
  
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE",  "ACCYY",   "ACCYYQT",  "DATADIV",  "VENDID",
					"VENDCNT", "SHTCNT",  "REQAMT",   "VATAMT",
		          "VENDCNT1","SHTCNT1", "REQAMT1",  "VATAMT1",					
		          "VENDCNT2","SHTCNT2", "REQAMT2",  "VATAMT2",					
					"FILLER"
				}; 

				int[] intArrCN = new int[]{
					 2,  4,  1,  1,  10,
					 7,  7, 15, 14, 
					 7,  7, 15, 14, 
					 7,  7, 15, 14, 
					30
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1, 
					 0,  0,  0,  0, 
				   0,  0,  0,  0, 
					 0,  0,  0,  0, 
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
					sql.append( " SELECT Y.FDCODE , Y.ACCYY, '"+str7+"' AS ACCYYQT, '"+str8+"' AS DATADIV,'"+str9+"' AS VENDID,  \n");
					sql.append( "        SUM(Y.VENDCNT)VENDCNT, SUM(Y.SHTCNT)SHTCNT, SUM(Y.REQAMT)REQAMT, SUM(Y.VATAMT)VATAMT,            \n");
					sql.append( "        SUM(Y.VENDCNT1)VENDCNT1, SUM(Y.SHTCNT1)SHTCNT1, SUM(Y.REQAMT1)REQAMT1, SUM(Y.VATAMT1)VATAMT1,    \n");
					sql.append( "        SUM(Y.VENDCNT2)VENDCNT2, SUM(Y.SHTCNT2)SHTCNT2, SUM(Y.REQAMT2)REQAMT2, SUM(Y.VATAMT2)VATAMT2,    \n");
					sql.append( "        '' AS FILLER    \n");
					sql.append( "   FROM (                                                                                                \n");
					//sql.append( "         SELECT MAX(A.COCODE) AS FDCODE ,  SUBSTR(A.TAXDAT,1,4) ACCYY,                                        \n");
					sql.append( "         SELECT MAX('02') AS FDCODE ,  SUBSTR(A.TAXDAT,1,4) ACCYY,                                        \n");
					sql.append( "                0 VENDCNT, COUNT(B.VEND_ID) SHTCNT, SUM(A.TAXSUM) REQAMT, SUM(A.TAXVATAMT) VATAMT        \n");
					sql.append( "                , 0 VENDCNT1                                                                             \n");
					sql.append( "                , COUNT(CASE WHEN LENGTH(TRIM(B.VEND_ID))=10 THEN B.VEND_ID END) SHTCNT1                 \n");
					sql.append( "                , SUM(CASE WHEN LENGTH(TRIM(B.VEND_ID))=10 THEN A.TAXSUM ELSE 0 END) REQAMT1             \n");
					sql.append( "                , SUM(CASE WHEN LENGTH(TRIM(B.VEND_ID))=10 THEN A.TAXVATAMT ELSE 0 END) VATAMT1          \n");
					sql.append( "                , 0 VENDCNT2                                                                             \n");
					sql.append( "                , COUNT(CASE WHEN LENGTH(TRIM(B.VEND_ID))=13 THEN B.VEND_ID END) SHTCNT2                 \n");
					sql.append( "                , SUM(CASE WHEN LENGTH(TRIM(B.VEND_ID))=13 THEN A.TAXSUM ELSE 0 END) REQAMT2             \n");
					sql.append( "                , SUM(CASE WHEN LENGTH(TRIM(B.VEND_ID))=13 THEN A.TAXVATAMT ELSE 0 END) VATAMT2          \n");
					sql.append( "           FROM ACCOUNT.ATTAXMST A                                                                       \n");
					sql.append( "           LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD                                      \n");
					sql.append( "          WHERE 1=1                            \n");
					if(!str5.equals(""))sql.append( "AND A.TAXIODIV ='"+str5+"' \n");
					if(!str1.equals(""))sql.append( "AND A.COCODE IN ('01','02','04')    \n");
					if(!str3.equals(""))sql.append( "AND A.TAXDAT BETWEEN '"+str3+"' AND '"+str4+"'                                       \n");
					if(str5.equals("A"))sql.append( "AND A.TAXKND IN ('1','2','4')	\n");    //���� �������� 2007.12.27 ������ ���ݿ����� 7 �߰� ==> ���ݿ�����,ī��� ���� �Ű��ϱ� ������ ������.
					if(str5.equals("B"))sql.append( "AND A.TAXKND IN ('1','2')			\n");    //���� �������� (����, ����)
					if(!str6.equals(""))sql.append( "AND A.GUBUN ='"+str6+"'        \n");
					sql.append( "          GROUP BY SUBSTR(A.TAXDAT,1,4)                                                                  \n");
					sql.append( "          UNION ALL                                                                                      \n");
					//sql.append( "         SELECT MAX(X.COCODE) AS FDCODE, X.ACCYY,                                                        \n");
					sql.append( "         SELECT MAX('02') AS FDCODE, X.ACCYY,                                                        \n");
					sql.append( "                COUNT(X.VEND_ID) AS VENDCNT, 0 SHTCNT, 0 REQAMT, 0 VATAMT                                \n");
					sql.append( "               ,COUNT(CASE WHEN LENGTH(TRIM(X.VEND_ID))=10 THEN X.VEND_ID END) AS VENDCNT1               \n");
					sql.append( " 			        , 0 SHTCNT1, 0 REQAMT1, 0 VATAMT1                                                     \n");
					sql.append( "               ,COUNT(CASE WHEN LENGTH(TRIM(X.VEND_ID))=13 THEN X.VEND_ID END) AS VENDCNT2               \n");
					sql.append( " 			        , 0 SHTCNT2, 0 REQAMT2, 0 VATAMT2                                                     \n");
					sql.append( "           FROM (                                                                                        \n");
					sql.append( "                 SELECT A.COCODE,  SUBSTR(A.TAXDAT,1,4)ACCYY, B.VEND_ID                                  \n");
					sql.append( "                   FROM ACCOUNT.ATTAXMST A                                                               \n");
					sql.append( "                   LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD = B.VEND_CD                              \n");
					sql.append( "                  WHERE 1=1                            \n");
					if(!str5.equals(""))sql.append( "AND A.TAXIODIV ='"+str5+"' \n");
					if(!str1.equals(""))sql.append( "AND A.COCODE IN ('01','02','04')   \n");
					if(!str3.equals(""))sql.append( "AND A.TAXDAT BETWEEN '"+str3+"' AND '"+str4+"'                                       \n");
					if(str5.equals("A"))sql.append( "AND A.TAXKND IN ('1','2','4')	\n");    //���� �������� 2007.12.27 ������ ���ݿ����� 7 �߰� ==> ���ݿ�����,ī��� ���� �Ű��ϱ� ������ ������.
					if(str5.equals("B"))sql.append( "AND A.TAXKND IN ('1','2')			\n");    //���� �������� (����, ����)
					if(!str6.equals(""))sql.append( "AND A.GUBUN ='"+str6+"'        \n");
					sql.append( "                  GROUP BY A.COCODE,  SUBSTR(A.TAXDAT,1,4), B.VEND_ID                                    \n");
					sql.append( "                )X                                                                                       \n");
					sql.append( "           GROUP BY  X.ACCYY                                                                             \n");
					sql.append( "        )Y                                                                                               \n");
					sql.append( "  GROUP BY Y.FDCODE, Y.ACCYY                                                                             \n");
		
					//System.out.println("a050001_s3: " + sql.toString());	
					//logger.dbg.println(this, sql.toString());
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