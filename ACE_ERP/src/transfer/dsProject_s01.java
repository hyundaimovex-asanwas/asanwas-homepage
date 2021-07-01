package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class dsProject_s01 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //������Ʈ
				if (str1==null || str1.equals("")) str1 = "";
				String  str2	= req.getParameter("v_str2");    //������Ʈ��
				if (str2==null || str2.equals("")) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "LINE_PART","PROJECT","TR_PROJECT","PROJECT_NM","DETAIL_NM",
													"CONT_NM","CONT_DT","CONT_OWN","CONT_AMT","CONT_PED",
													"CONT_DESC","STAY_DIV","FOOD_DIV","TRANS_DIV","USE_STS",
													"REMARK", "CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR",
													"USE_PROJNM"
												}; 
				int[] intArrCN	= new int[]{   4, 10, 10, 100, 200,
												 100,  8, 50,  13,  16,
												 100,  1,  1,   1,   1,
												 100, 10, 10,  10,  10,
												 200
											 }; 
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
												  -1, -1, -1,  2, -1,
												  -1, -1, -1, -1, -1,
												  -1, -1, -1, -1, -1,
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

		
					sql.append( " SELECT LINE_PART, RTRIM(PROJECT) PROJECT, RTRIM(TR_PROJECT) TR_PROJECT, PROJECT_NM, RTRIM(DETAIL_NM) DETAIL_NM,   \n" )
					   .append( "		 RTRIM(CONT_NM) CONT_NM, CONT_DT, RTRIM(CONT_OWN) CONT_OWN, COALESCE(CONT_AMT,0) CONT_AMT, RTRIM(CONT_PED) CONT_PED,\n")
					   .append( "		 CONT_DESC, STAY_DIV, FOOD_DIV, TRANS_DIV, USE_STS, \n" )
					   .append( "		 REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR, CASE WHEN DETAIL_NM='' THEN PROJECT_NM WHEN DETAIL_NM IS NULL THEN PROJECT_NM ELSE DETAIL_NM END  USE_PROJNM \n" )
					   .append( "	FROM TRANSFER.LTUNTCOD \n" )
					   .append( "  WHERE LINE_PART IS NOT NULL  \n");

					if (!str1.equals("")) sql.append( " AND LINE_PART = '" + str1 + "' \n" );
					if (!str2.equals("")) sql.append( " AND (PROJECT_NM LIKE '" + str2 + "%' OR DETAIL_NM LIKE '" + str2 + "%') \n" );
				
					sql.append( "	AND USE_STS = 'Y' \n")
					   .append( " ORDER BY DSP_SORT ");


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