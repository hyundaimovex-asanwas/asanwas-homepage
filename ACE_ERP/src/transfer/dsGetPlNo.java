package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class dsGetPlNo extends HttpServlet {
 
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
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				 
				 
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PL_NO" }; 

				int[] intArrCN = new int[] {20 }; 
			
				int[] intArrCN2 = new int[]{-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( "  SELECT ") ; 
						sql.append( "  SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT  ") ; 
						sql.append( "  SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT  ") ; 
						sql.append( "  SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT ") ; 
						sql.append( "  CASE WHEN MAX(PL_NO) IS NULL THEN  '0001' ") ; 
						sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 1  ") ; 
						sql.append( "  THEN '000' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 2  ") ;  
						sql.append( "  THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 3  ") ; 
						sql.append( "  THEN  '0' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 4  ") ; 
						sql.append( "  THEN CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						sql.append( "  END AS PL_NO ") ; 
						sql.append( "  FROM TRANSFER.LTPCKLSCI WHERE PL_NO LIKE SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT ") ; 
						sql.append( "  SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT ") ; 
						sql.append( "  SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT '%' ") ; 





if (isDebug) {	
 GauceRes.writeException("Sql",":",sql.toString()); }
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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