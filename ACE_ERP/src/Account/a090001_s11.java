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
public class a090001_s11 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //�����ڵ�
				String  str3	= req.getParameter("v_str3");    //1����
				String  str4	= req.getParameter("v_str4");    //�ڻ��ߺз�
				String  str5	= req.getParameter("v_str5");    //�ڻ�Һз�
				String  str6	= req.getParameter("v_str6");    //�Ϸù�ȣ 

				if (str1 == null) str1 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";

				
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{ "FDCODE","ATCODE","AST1ST","AST2ND","AST3RD",
																														"ASTSEQ","ACARTYPE","ACARNO","ACARBEGI","ACARFUEL",
																														"ACARUSE","ACARINSDT","ACARDRVID","AINSDT1","AINSDT2"}; 

				int[] intArrCN = new int[]{2,7,2,2,2,
																								5,2,20,10,10,
																								20,20,10,20,20	}; 
					
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
																									-1,-1,-1,-1,-1,
																									-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();


					sql.append( " SELECT           ");
					sql.append( " FDCODE,           ");
					sql.append( " ATCODE,         ");   
					sql.append( " AST1ST,          ");    
					sql.append( " AST2ND,          ");   
					sql.append( " AST3RD,         ");    
					sql.append( " ASTSEQ,         ");    
 					sql.append( " ACARTYPE,        "); 
 					sql.append( " ACARNO,          ");  
 					sql.append( " ACARBEGI,         ");
 					sql.append( " ACARFUEL,        "); 
 					sql.append( " ACARUSE,           ");
 					sql.append( " ACARINSDT,       ");
 					sql.append( " ACARDRVID,       ");
 					sql.append( " AINSDT1,            ");
					sql.append( " AINSDT2            ");
					sql.append( " FROM   ACCOUNT.ASTADINFO2      ");
					sql.append( " WHERE  FDCODE IS NOT NULL    ");
 					if (!str1.equals(""))  sql.append( "   AND  FDCODE = '"+str1+"'  ");
 					if (!str3.equals(""))  sql.append( "   AND   AST1ST  = '"+str3+"'  ");
 					if (!str4.equals(""))   sql.append( "  AND  AST2ND  = '"+str4+"' ");
 					if (!str5.equals(""))   sql.append( "  AND  AST3RD  = '"+str5+"'  ");
 					if (!str6.equals(""))   sql.append( "  AND	ASTSEQ  = '"+str6+"'  ");

					//logger.dbg.println( this, sql.toString() );
 					
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