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
public class asetdep_popup_s1 extends HttpServlet {
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

				String  str1 = req.getParameter("v_str1");    //�Ҽ�
				String  str2 = req.getParameter("v_str2");    //�ڻ�з�
				String  str3 = req.getParameter("v_str3");    //�󰢳��

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"ASNBR", "ASNAM", "ASAQSDAT", "ASLIFYER", "QSAMT", "DSANGAMT", "JANAMT" , "LASTYM", "GAMAMT" };  

				int[] intArrCN = new int[]{11, 30, 8, 3, 13, 13, 13 ,6, 13}; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, 0, 0, 0, 0,-1, 0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S' ");
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END|| ");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S' ");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E' ");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C' ");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F' ");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASNBR, ");
					sql.append( " A.ASTNAME AS ASNAM, ASAQSDAT, COALESCE(C.ACDEPRAMT,0) AS DSANGAMT, ");
					sql.append( " COALESCE(B.ASTAQAMT,0) AS QSAMT, COALESCE(B.ASTYUSE,0) AS ASLIFYER, ");
					sql.append( " (COALESCE(B.ASTAQAMT,0) - COALESCE(C.ABDEPRAMT,0) - COALESCE(C.ACDEPRAMT,0)) AS JANAMT, ");
					sql.append( " COALESCE(SUBSTR(C.DEPRENDDT,1,6),'') AS LASTYM, ");
					sql.append( " COALESCE(D.ASTAMT,0) AS GAMAMT ");
					sql.append( " FROM ((account.astmst A left outer join account.astbasic B on  ");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST AND ");
					sql.append( " A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ ) left outer join account.astdepr C on ");
					sql.append( " A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE AND A.AST1ST=C.AST1ST AND ");
					sql.append( " A.AST2ND=C.AST2ND AND A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ) left outer join account.astyepr D on ");
					sql.append( " A.FDCODE=D.FDCODE AND A.ATCODE=D.ATCODE AND A.AST1ST=D.AST1ST AND ");
					sql.append( " A.AST2ND=D.AST2ND AND A.AST3RD=D.AST3RD AND A.ASTSEQ=D.ASTSEQ ");
		
					if (!str3.equals("")) sql.append( " AND D.ASTYM = '" + str3 + "' " );

					sql.append( " WHERE A.AST2ND>'11' ");
					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' " );
					
					System.out.println("asetdep_popup_s1 \n"+sql.toString() );
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