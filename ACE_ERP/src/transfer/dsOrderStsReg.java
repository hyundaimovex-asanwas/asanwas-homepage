 package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsOrderStsReg extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		//System.out.println("dsOrderStsReg :시작");
		ServiceLoader loader = new ServiceLoader(req, res);
		//com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		try {
			//System.out.println("dsOrderStsReg :1");
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();
			try {
			
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"RST"}; 

				int[] intArrCN = new int[] { 1}; 
			
				int[] intArrCN2 = new int[]{-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				
				StringBuffer Sql = new StringBuffer();
								
				Sql.append("SELECT TO_CHAR(SYSDATE,'YYMMDD')||                                                                                       \n");
				Sql.append("       CASE WHEN MAX(AUTH_NO) IS NULL THEN '01'                                                                          \n");
				Sql.append("            WHEN LENGTH(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+1)= 1 THEN LPAD(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+1,2,'0') \n");
				Sql.append("            WHEN LENGTH(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+1)= 2 THEN LPAD(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+1,2,'0') \n");
				Sql.append("        ELSE '01' END AS AUTH_NO                                                                                         \n");
				Sql.append("  FROM TRANSFER.LTORDERDTL                                                                                               \n");
				Sql.append(" WHERE AUTH_NO LIKE TO_CHAR(SYSDATE,'YYMMDD')                                                                            \n");
				
				/**
				Sql.append(" SELECT SUBSTR(CHAR(CURRENT DATE),3,2) || SUBSTR(CHAR(CURRENT DATE),6,2) \n")
					 .append("				|| SUBSTR(CHAR(CURRENT DATE),9,2) || \n")
					 .append("				CASE WHEN MAX(AUTH_NO) IS NULL then  '01' \n")
					 .append("				WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1)) = 1 \n")
					 .append("				THEN '0' || TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1) \n")
					 .append("				WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1)) = 2 \n")
					 .append("				THEN  TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1) \n")
					 .append("				ELSE '01' END AS AUTH_NO \n")
					 .append("	 FROM TRANSFER.LTORDERDTL \n")
					 .append("	WHERE SUBSTR(AUTH_NO,1,6) = SUBSTR(CHAR(CURRENT DATE),3,2) \n")
					 .append("				|| SUBSTR(CHAR(CURRENT DATE),6,2) || SUBSTR(CHAR(CURRENT DATE),9,2) ");
				*/
				
				Statement stmt = null;
				ResultSet rs = null;
				String sno = "";
				//System.out.println("Sql.toString()"+Sql.toString());

				stmt = conn.createStatement();
				rs = stmt.executeQuery(Sql.toString());
								
				while (rs.next()){
					sno = rs.getString(1);
				}
				
				rs.close();
				stmt.close();
				Sql = null;
				
				//System.out.println("dsOrderStsReg :sno::" +sno);

				Sql = new StringBuffer();
				Sql.append( " UPDATE TRANSFER.LTORDERDTL \n" )
				   .append( "		 SET AUTH_NO = '" + sno + "', \n ")
				   .append( "        ORDER_STS = '0002' \n ")
				   .append( "  WHERE ORDER_NO = '" + str1 + "'");

				gstmt = conn.getGauceStatement(Sql.toString()); 
				gstmt.executeUpdate(); 
				gstmt = null;
				Sql = null;

				Sql = new StringBuffer();
				Sql.append(" UPDATE TRANSFER.LTORDERMST \n") 
				   .append("		SET ORDER_STS = '0002' \n")
				   .append("  WHERE ORDER_NO = '" + str1 + "' ") ; 

				gstmt = conn.getGauceStatement(Sql.toString()); 
				gstmt.executeUpdate(); 
				gstmt.close();

	    	    GauceDataRow row = null;
	    	    row = dSet.newDataRow();

				row.addColumnValue("Y");
				dSet.addDataRow(row);
			
/*********************************************************************************************/

			} catch(Exception e) {
			GauceRes.writeException("Sql",":",e.toString());	
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
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