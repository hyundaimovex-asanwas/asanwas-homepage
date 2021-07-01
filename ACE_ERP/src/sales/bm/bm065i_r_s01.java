// * ������������ : ���¾�ü���� �˾�(��ȸ)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm065i_r_s01 extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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

				String  str1	= GauceReq.getParameter("v_str1"); //�ŷ�ó�ڵ�
				String  str2	= GauceReq.getParameter("v_str2"); //�����

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					                                "VEND_CD",		"VEND_ID",			"CLIENT_NM",		"CLIENT_DAM_NM",	"BSNS_CND" ,
					                                "BSNS_KND",		"VD_TELNO",			"VD_FAXNO",			"POSTNO",			"ADDRESS1" ,
					                                "ADDRESS2",		"LOCAL_GU_NM",	"VEND_ID_YN",		"COOP_SID" , 
													"LOCAL_MGR",	"LOCAL_STAFF",	"LOCAL_GU",			"LOCAL_TEL"  , "LOCAL_FAX",
													"CLIENT_SID"
															}; 

				int[] intArrCN = new int[] {		
					                              13, 15, 62, 62, 62,
					                              62, 32, 32, 20, 132,
					                              72, 40, 40, 10,
												  15, 15, 1, 15, 15,
												  10
																		}; 
			
				int[] intArrCN2 = new int[]{ 
					                             -1, -1, -1, -1, -1,
					                             -1, -1, -1, -1, -1,
					                             -1, -1, -1, 0,//<==0 ������ ���
												 -1, -1, -1, -1, -1,
											      0
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( "      SELECT                                                                                                  \n" );
				sql.append( "             T1.VEND_CD              -- �ŷ�ó�ڵ�                                                            \n" );
				sql.append( "            ,COALESCE(T1.VEND_ID,'') VEND_ID              -- ����ڹ�ȣ VARCHAR(15)                                                \n" );
				sql.append( "            ,T1.CLIENT_NM CLIENT_NM              -- �ŷ�ó��                                                              \n" );
				sql.append( "            ,T1.VD_DIRECT CLIENT_DAM_NM            -- ��ǥ�ڸ�   VARCHAR(62)                                                \n" );
				sql.append( "            ,T1.BSNS_CND             -- ����       VARCHAR(62)                                                \n" );
				sql.append( "            ,T1.BSNS_KND             -- ����       VARCHAR(62)                                                \n" );
				sql.append( "            ,T1.VD_TELNO             -- ��ȭ��ȣ   VARCHAR(32)                                                \n" );
				sql.append( "            ,T1.VD_FAXNO             -- �ѽ���ȣ   VARCHAR(32)                                                \n" );
				sql.append( "            ,TRIM(T1.POST_NO1) || '-' || TRIM(T1.POST_NO2)   POSTNO  -- �����ȣ VARCHAR(10) || VARCHAR(10)   \n" );
				sql.append( "            ,T1.ADDRESS1             -- �ּ�1      VARCHAR(132)                                               \n" );
				sql.append( "            ,T1.ADDRESS2             -- �ּ�2      VARCHAR(72)                                                \n" );
				sql.append( "            ,CASE WHEN T2.LOCAL_GU = 'K' THEN '�ݰ���'                                                        \n" );
				sql.append( "                  WHEN T2.LOCAL_GU = 'G' THEN '����'                                                          \n" );
				sql.append( "                  WHEN T2.LOCAL_GU = 'B' THEN '��λ�'                                                        \n" );
				sql.append( "                  WHEN T2.LOCAL_GU = 'P' THEN '���'                                                          \n" );
				sql.append( "                  ELSE '����'                                                                                 \n" );
				sql.append( "              END AS LOCAL_GU_NM                                                                              \n" );
				sql.append( "            ,CASE WHEN T2.CLIENT_SID IS NULL THEN '�̵��'                                                       \n" );
				sql.append( "                  ELSE '���'                                                                                 \n" );
				sql.append( "             END AS  VEND_ID_YN                                                                               \n" );
				sql.append( "            , COALESCE(T2.COOP_SID, 0) COOP_SID            --  NUMERIC(10,0)                                                        \n" );
				sql.append( "            ,T2.LOCAL_MGR            -- ����å���� VARCHAR(15)                                                \n" );
				sql.append( "            ,T2.LOCAL_STAFF          -- ��������� VARCHAR(15)                                                \n" );
				sql.append( "            ,T2.LOCAL_GU             -- ��������(K:�ݰ���,G:����,B:��λ�,P:��� CHAR(1)                      \n" );
				sql.append( "            ,T2.LOCAL_TEL            -- ������ȭ��ȣ VARCHAR(15)                                              \n" );
				sql.append( "            ,T2.LOCAL_FAX            -- �����ѽ� VARCHAR(15)                                                  \n" );
				sql.append( "            ,T1.CLIENT_SID											                                                            \n" );
				sql.append( "      FROM ACCOUNT.GCZM_VENDER T1                                                                             \n" );
				sql.append( "             LEFT JOIN SALES.TCM030 T2													\n" );
				sql.append( "							ON T1.CLIENT_SID = T2.CLIENT_SID                               \n" );

				sql.append( "      WHERE 1 = 1                                                                           \n" );

				if (!str1.equals("")) sql.append( " AND T1.CLIENT_NM LIKE '"+str1+"%'    \n");
				if (!str2.equals("")) sql.append( " AND T1.VEND_ID = '"+str2+"'        \n");
//				if (!str3.equals("")) sql.append( " AND T2.LOCAL_GU = '"+str3+"'       ");

				sql.append( "  ORDER BY T1.CLIENT_SID DESC ");

        //logger.dbg.println("=============���¾�ü����(�˾�)=============>",sql.toString());
        //logger.dbg.println(this,sql.toString());

				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

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