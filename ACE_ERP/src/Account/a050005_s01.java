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
public class a050005_s01 extends HttpServlet {
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

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		          "DATADIV"  , "VEND_ID"  , "VEND_NM" , "VD_DIRECT" , "ADDRS",
		          "BSNS_CND" , "BSNS_KND" , "TAXTERM" , "WRDT"      , "FILLER"
		        }; 

				int[] intArrCN  = new int[]{
		          1   , 10  , 30  , 15  ,  45  , 
		          17  , 25  , 12   , 6   ,  9
		        }; 
			
				int[] intArrCN2 = new int[]{
		          -1 , -1 , -1 , -1 , -1 ,
		          -1 , -1 , -1 , -1 , -1
		        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

			          sql.append("\n SELECT TRIM(DATADIV) DATADIV , TRIM(VEND_ID) VEND_ID , TRIM(VEND_NM) VEND_NM , TRIM(VD_DIRECT) VD_DIRECT , TRIM(ADDRS) ADDRS, ");
			          sql.append("\n        TRIM(BSNS_CND) BSNS_CND , TRIM(BSNS_KND) BSNS_KND , TRIM(TAXTERM) TAXTERM , TRIM(WRDT) WRDT , TRIM(FILLER) FILLER    ");
			          sql.append("\n   FROM ACCOUNT.AVATRPT7                                  ");
			          sql.append("\n WHERE FDCODE IS NOT NULL																														");
			          if(!str1.equals(""))  sql.append( "\n AND FDCODE = '"+str1+"'															");
			          if(!str2.equals(""))  sql.append( "\n AND ACCYY	 = '"+str2+"'															");
			          if(!str3.equals(""))  sql.append( "\n AND ACCYYQT = '"+str3+"'														");

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