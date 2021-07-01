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
public class a050015_s2 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//FROM�ŷ��Ⱓ         
				String  str2 = req.getParameter("v_str2");	//TO�ŷ��Ⱓ    

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"FDCODE",	  "FRYMD",	  "TOYMD",	"RCDGB",	  "TAXOFF",	
					"SEQ",	   	"VENDID",	  "VENDNM",	"VDDIRECT", "POSTNO",
					"VDADDR",  	"FILLER"	
				}; 

				int[] intArrCN = new int[]{
		   2,  8,  8,  1,  3,
		   6, 10, 40, 30, 10,
		  70, 60
				}; 
			
				int[] intArrCN2 = new int[]{     
					-1, -1, -1, -1, -1,
					 0, -1, -1, -1, -1,
					-1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append(" SELECT                                        \n");
					sql.append(" FDCODE,	FRYMD,	  TOYMD,	RCDGB,	  TAXOFF,  \n");
					sql.append(" SEQ,	    VENDID,	  VENDNM, VDDIRECT, POSTNO,  \n");
					sql.append(" VDADDR,	FILLER	                             \n");
					sql.append("   FROM  ACCOUNT.AVATRPT12                     \n");
					sql.append("  WHERE  1=1 \n");
					if(!str1.equals("")) sql.append(" AND FRYMD = '"+str1+"' "); //FROM�ŷ��Ⱓ        
					if(!str2.equals("")) sql.append(" AND TOYMD = '"+str2+"'  ");//TO�ŷ��Ⱓ
				
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