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
public class a090004_s7 extends HttpServlet {
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
				String  str2	= req.getParameter("v_str2");    //��������
				String  str3	= req.getParameter("v_str3");    //�ڻ��ߺз�
				String  str4	= req.getParameter("v_str4");    //�ڻ�Һз�
				String  str5	= req.getParameter("v_str5");    //��������from
				String  str6	= req.getParameter("v_str6");    //��������to
				String  str7	= req.getParameter("v_str7");    //����

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASETNO", "ASTNAME", "MORTDATE", "MORTJDGDT", "CLOSEORNOT", "CLOSEDATE", "BOOKAMT", "MORTSIZE","MORTBANK","JUDGAMT","MORTAMT","MORTDTL", "CDNAM" };  

				int[] intArrCN = new int[]{ 11, 30, 8, 8, 1, 8, 13, 20, 6, 13, 13, 20, 30}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, 0, -1, -1, 0, 0, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S' " );
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END|| ");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S' ");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E' ");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C' ");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F' ");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASETNO, COALESCE(B.ASTNAME,'') as ASTNAME, ");
					sql.append( " COALESCE(A.MORTDATE,'') AS MORTDATE, COALESCE(A.MORTJDGDT,'') AS MORTJDGDT, ");
					sql.append( " COALESCE(A.CLOSEORNOT,'') AS CLOSEORNOT,COALESCE(A.CLOSEDATE,'') AS CLOSEDATE, "); 
					sql.append( " COALESCE(A.BOOKAMT,0) AS BOOKAMT, COALESCE(A.MORTSIZE,'') AS MORTSIZE, ");
					sql.append( " COALESCE(A.MORTBANK,'') AS MORTBANK, COALESCE(A.JUDGAMT,0) AS JUDGAMT, ");
					sql.append( " COALESCE(A.MORTAMT,0) AS MORTAMT , COALESCE(A.MORTDTL,'') AS MORTDTL, X.CDNAM ");
					sql.append( " FROM ACCOUNT.ASTMORT A LEFT OUTER JOIN ACCOUNT.ASTMST B ON ");
					sql.append( " A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST ");
					sql.append( " AND A.AST2ND=B.AST2ND AND A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ ");
					sql.append( " LEFT JOIN ACCOUNT.COMMDTIL X ON B.ASTNAME=X.CDCODE AND X.CMTYPE='2161' \n");
					if (!str5.equals("")) sql.append( " WHERE A.MORTDATE BETWEEN '" + str5 + "' " );
					if (!str6.equals("")) sql.append( " AND '" + str6 + "' " );
					if (!str1.equals("")) sql.append( " AND B.AST1ST = '" + str1 + "' " );
					if (!str2.equals("")) sql.append( " AND A.ATCODE = '" + str2 + "' " );
					if (!str3.equals("")) sql.append( " AND A.AST2ND = '" + str3 + "' " );
					if (!str4.equals("")) sql.append( " AND A.AST3RD = '" + str4 + "' " );
					if (!str7.equals("")) sql.append( " AND A.MORTBANK = '" + str7 + "' " );					
			
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