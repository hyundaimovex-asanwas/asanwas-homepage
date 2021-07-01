package sales.menu.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm011i_s01 extends HttpServlet {

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

				String  ptype	= req.getParameter("v_ptype");
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");

				if (ptype == null) { ptype = ""; } //�Ķ���� Ÿ�Կ� ���� ���� ����
				if (str1 == null) { str1 = ""; } //������ȣ
				if (str2 == null) { str2 = ""; } //�����ȣ

				GauceRes.enableFirstRow(dSet);

				if (ptype.equals("t1"))
				{	//�⺻��ȸ

						String[] strArrCN = new String[]{
															"CAR_SID",	"CAR_NO",	 "CAR_DNO"
															};
						//�Ķ���� �ǹ� : �ڸ���
						int[] intArrCN = new int[] {
													10,	30,	10
													};
						//�Ķ���� �ǹ�( -1:string, 0 : ����, 1 : �Ҽ��� 1�ڸ�, 2: �Ҽ��� 2�ڸ�....
						int[] intArrCN2 = new int[]{
														0,		-1,	-1
														};

						for (int i=0; i<strArrCN.length; i++) { // set column column
							switch ( intArrCN2[i] ) {
								case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
								default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
							}
						}

						if (!GauceReq.isBuilderRequest()) {					
								StringBuffer sql = new StringBuffer();

								sql.append( "	SELECT CAR_SID, CAR_NO, CAR_DNO							\n");
								sql.append( "	FROM SALES.TCU050													\n");
								sql.append( "	WHERE 1 = 1																\n");
								if(!str1.equals(""))sql.append( "	  AND CAR_NO LIKE '%"+str1+"%'	\n");
								if(!str2.equals(""))sql.append( "	  AND CAR_DNO LIKE '%"+str2+"%'	\n");

								stmt = conn.getGauceStatement(sql.toString());

							stmt.executeQuery(dSet);
						}


				}

				if (ptype.equals("t2"))
				{	//�׸��� Ŭ���� ����ȸ

						String[] strArrCN = new String[]{
															"CARNO_SID",	"CAR_SID",		"CAR_NO",		"CAR_DNO",	"CAR_RNO",
															"USE_SDATE",	"USE_EDATE",	"CLIENT_NM"
															};
						//�Ķ���� �ǹ� : �ڸ���
						int[] intArrCN = new int[] {
														20,	20,	20,	20,	20,	15,
														15,	30 
														};
						//�Ķ���� �ǹ�( -1:string, 0 : ����, 1 : �Ҽ��� 1�ڸ�, 2: �Ҽ��� 2�ڸ�....
						int[] intArrCN2 = new int[]{
														0,		0,		-1,	-1,	-1,	-1,
														-1,	-1
														};

						for (int i=0; i<strArrCN.length; i++) { // set column column
							switch ( intArrCN2[i] ) {
								case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
								default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
							}
						}

						if (!GauceReq.isBuilderRequest()) {					
								StringBuffer sql = new StringBuffer();

								sql.append( "	SELECT															\n");
								sql.append( "			T1.CARNO_SID										\n");
								sql.append( "			,T1.CAR_SID											\n");
								sql.append( "			, T3.CAR_NO											\n");
								sql.append( "			, T1.CAR_DNO										\n");
								sql.append( "			, T1.CAR_RNO										\n");
								sql.append( "			, T1.USE_SDATE									\n");
								sql.append( "			, T1.USE_EDATE										\n");
								sql.append( "			, V1.CLIENT_NM										\n");
								sql.append( "		FROM SALES.TCM150 T1							\n");
								sql.append( "			LEFT JOIN SALES.TCM140 T2					\n");
								sql.append( "			ON T1.CAR_SID = T2.CAR_SID				\n");
								sql.append( "			LEFT JOIN SALES.TCU030 V1					\n");
								sql.append( "				ON T2.CLIENT_SID = V1.CLIENT_SID	\n");
								sql.append( "			INNER JOIN SALES.TCU050 T3					\n");
								sql.append( "			ON T1.CAR_SID = T3.CAR_SID				\n");
								sql.append( "		WHERE T1.CAR_SID = "+str1+"					\n");
								sql.append( "		ORDER BY T1.CARNO_SID DESC					\n");

								stmt = conn.getGauceStatement(sql.toString());
								//logger.dbg.println(this,sql.toString());
							stmt.executeQuery(dSet);
						}

				}


				if (ptype.equals("t3"))
				{	//������ȸ

						String[] strArrCN = new String[]{
															"CARNO_SID",	"CAR_SID",		"CAR_NO",		"CAR_DNO",	"CAR_RNO",
															"USE_SDATE",	"USE_EDATE",	"CLIENT_NM"
															};
						//�Ķ���� �ǹ� : �ڸ���
						int[] intArrCN = new int[] {
														20,	20,	20,	20,	20,
														15,	15,	30
														};
						//�Ķ���� �ǹ�( -1:string, 0 : ����, 1 : �Ҽ��� 1�ڸ�, 2: �Ҽ��� 2�ڸ�....
						int[] intArrCN2 = new int[]{
														0,		0,		-1,	-1,	-1,	
														-1,	-1,	-1
														};

						for (int i=0; i<strArrCN.length; i++) { // set column column
							switch ( intArrCN2[i] ) {
								case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
								default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
							}
						}

						if (!GauceReq.isBuilderRequest()) {					
								StringBuffer sql = new StringBuffer();

								sql.append( "	SELECT																\n");
								sql.append( "			T1.CARNO_SID											\n");
								sql.append( "			,T1.CAR_SID												\n");
								sql.append( "			, T3.CAR_NO												\n");
								sql.append( "			, T1.CAR_DNO											\n");
								sql.append( "			, T1.CAR_RNO											\n");
								sql.append( "			, T1.USE_SDATE										\n");
								sql.append( "			, T1.USE_EDATE											\n");
								sql.append( "			, V1.CLIENT_NM											\n");
								sql.append( "		FROM SALES.TCM150 T1								\n");
								sql.append( "			LEFT JOIN SALES.TCM140 T2						\n");
								sql.append( "			ON T1.CAR_SID = T2.CAR_SID					\n");
								sql.append( "			LEFT JOIN SALES.TCU030 V1						\n");
								sql.append( "				ON T2.CLIENT_SID = V1.CLIENT_SID		\n");
								sql.append( "			INNER JOIN SALES.TCU050 T3						\n");
								sql.append( "			ON T1.CAR_SID = T3.CAR_SID					\n");
//								sql.append( "		WHERE T1.CAR_SID = '"+str1+"'                       \n");
								sql.append( "		ORDER BY T1.CARNO_SID DESC						\n");

								stmt = conn.getGauceStatement(sql.toString());
								//logger.dbg.println(this,sql.toString());
							stmt.executeQuery(dSet);
						}

				}
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