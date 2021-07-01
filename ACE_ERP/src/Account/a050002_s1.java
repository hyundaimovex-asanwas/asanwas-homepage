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
public class a050002_s1 extends HttpServlet {
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
				String  str5 = req.getParameter("v_str5");	//����/���� ����

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ACCYY","ACCYYQT","TAXIODIV","TAXDIV",
					"TAXKND","TAXDAT","VEND_CD","VEND_ID","VEND_NM",
					"VD_DIRECT","ADDRESS1","BSNS_CND","BSNS_KND","WRDT",
					"TAXTERMFR","TAXTERMTO","SHTCNT","BLKCNT","REQAMT",
					"VATAMT","VENDCNT4","SHTCNT4","REQAMT4","VATAMT4",
					"FILLER4"
				}; 

				int[] intArrCN = new int[]{
					 2,  4,  1,  1,  2,
					 1,  8, 13, 10,	62, 
					62,132, 62, 62,  8,
					 8,  8,  7,  2, 14,
					13,  7,  7, 15, 14,
				 116
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1, 
					-1, -1, -1, -1, -1, 
				  -1, -1, -1, -1, -1, 
					-1, -1,  0,  0,  0, 
					 0,  0,  0,  0,  0,
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
					sql.append( " SELECT																					\n");
					sql.append( " RTRIM(A.FDCODE)    FDCODE,    --����						\n");
					sql.append( " RTRIM(A.ACCYY)     ACCYY,     --�⵵						\n");
					sql.append( " RTRIM(A.ACCYYQT)   ACCYYQT,   --���						\n");
					sql.append( " RTRIM(D.TAXIODIV)  TAXIODIV,  --��꼭����			\n");
					sql.append( " RTRIM(D.TAXDIV)    TAXDIV,    --�ͼӱ���				\n");
					sql.append( " RTRIM(D.TAXKND)    TAXKND,    --��꼭����			\n");
					sql.append( " RTRIM(D.TAXDAT)    TAXDAT,    --��꼭����			\n");
					sql.append( " RTRIM(D.VEND_CD)   VEND_CD,   --�ŷ�ó�ڵ�			\n");
					sql.append( " RTRIM(B.VEND_ID)   VEND_ID,   --��Ϲ�ȣ				\n");
					sql.append( " RTRIM(B.VEND_NM)   VEND_NM,   --��ȣ						\n");
					sql.append( " RTRIM(B.VD_DIRECT) VD_DIRECT, --��ǥ�ڸ�				\n");
					sql.append( " RTRIM(B.ADDRESS1)  ADDRESS1,  --������ּ�			\n");
					sql.append( " RTRIM(B.BSNS_CND)  BSNS_CND,  --����						\n");
					sql.append( " RTRIM(B.BSNS_KND)  BSNS_KND,  --����						\n");
					sql.append( " RTRIM(D.WRDT)      WRDT,      --�ۼ�����				\n");
					sql.append( " CASE WHEN A.ACCYYQT='1' THEN '20060101'					\n");
					sql.append( "         WHEN A.ACCYYQT='2' THEN '20060401'			\n");
					sql.append( "         WHEN A.ACCYYQT='3' THEN '20060701'			\n");
					sql.append( "         WHEN A.ACCYYQT='4' THEN '20061001' END AS TAXTERMFR, --�ŷ��ⰣFR	\n");
					sql.append( " CASE WHEN A.ACCYYQT='1' THEN '20060331'					\n");
					sql.append( "         WHEN A.ACCYYQT='2' THEN '20060630'			\n");
					sql.append( "         WHEN A.ACCYYQT='3' THEN '20060930'			\n");
					sql.append( "         WHEN A.ACCYYQT='4' THEN '20061231' END AS TAXTERMTO, --�ŷ��ⰣTO	\n");
					sql.append( " COUNT(B.VEND_ID)  AS SHTCNT,   --�ż�						\n");
					sql.append( " 14-LENGTH(VARCHAR(A.REQAMT)) AS BLKCNT,--������	\n");
					sql.append( " nvl(A.REQAMT,0)  REQAMT,    --���ް���				\n");
					sql.append( " nvl(A.VATAMT,0)  VATAMT,    --����						\n");
					sql.append( " nvl(C.VENDCNT,0) VENDCNT4,  --����ó��(�հ�)	\n");
					sql.append( " nvl(C.SHTCNT,0)  SHTCNT4,   --�ż�(�հ�)			\n");
					sql.append( " nvl(C.REQAMT,0)  REQAMT4,   --���ް���(�հ�)	\n");
					sql.append( " nvl(C.VATAMT,0)  VATAMT4,   --����(�հ�)			\n");
					sql.append( " RTRIM(C.FILLER)     FILLER4    --���(�հ�)			\n");
					sql.append( " FROM ACCOUNT.AVATRPT2 A													\n");
					sql.append( " LEFT JOIN ACCOUNT.AVATRPT4 C ON A.FDCODE=C.FDCODE AND A.ACCYY=C.ACCYY AND A.ACCYYQT=C.ACCYYQT								\n");
					sql.append( " LEFT JOIN ACCOUNT.ATTAXMST D ON A.FDCODE=D.FDCODE AND A.ACCYY=SUBSTR(D.TAXDAT,1,4) AND A.ACCYYQT=D.TAXKIDIV	\n");
					sql.append( " LEFT JOIN ACCOUNT.GCZM_VENDER B ON D.VEND_CD=B.VEND_CD	\n");
					sql.append( " WHERE B.VEND_ID IS NOT NULL	AND A.VENDIDVS=B.VEND_ID		\n");
					if(!str1.equals(""))  sql.append( " AND A.FDCODE = '"+str1+"'					\n");
					if(!str2.equals(""))  sql.append( " AND SUBSTR(D.TAXDAT,1,4) ='"+str2+"'					\n");
					if(!str3.equals(""))  sql.append( " AND D.WRDT BETWEEN '"+str3+"' AND '"+str4+"'	\n");
					if(!str5.equals(""))  sql.append( " AND D.TAXNBR LIKE '"+str5+"%'									\n");
					if(str5.equals("A")) sql.append( " AND D.TAXKND IN ('1','2','4')	\n");//���� ��������
					if(str5.equals("B")) sql.append( " AND D.TAXKND IN ('1','2')			\n");//���� ��������
					sql.append( " GROUP BY A.FDCODE,A.ACCYY,A.ACCYYQT,D.TAXIODIV,D.TAXDIV,D.TAXKND,D.TAXDAT,D.VEND_CD,	\n");
					sql.append( "					 B.VEND_ID,B.VEND_NM,B.VD_DIRECT,B.ADDRESS1,B.BSNS_CND,B.BSNS_KND,D.WRDT,			\n");
					sql.append( "					 A.REQAMT,A.VATAMT,C.VENDCNT,C.SHTCNT,C.REQAMT,C.VATAMT,C.FILLER							\n");
					sql.append( " ORDER BY VEND_ID																		\n");

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