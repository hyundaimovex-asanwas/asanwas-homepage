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
public class asetdep_popup_s3 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //�Ҽ�
				String  str2	= req.getParameter("v_str2");    //�ڻ�з�
				String  str3	= req.getParameter("v_str3");    //�󰢳��
				String  str4	= req.getParameter("v_str4");   //1����
				String  str5	= req.getParameter("v_str5");	//2����
				String  str6	= req.getParameter("v_str6");	//3����
				String  str7	= req.getParameter("v_str7");	//�ø���

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				if (str7 == null) str7 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ASTYM", "ASETNO", "ASTNAME", "QAMT","YUSE", "STYMD", "STAMT","WRKDAT"};  

				int[] intArrCN = new int[]{ 6, 11, 30, 13, 3, 8, 13, 8}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, 0, 0, -1, 0, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.ASTYM, ");
					sql.append( " (CASE A.AST1ST WHEN '01' THEN 'S' WHEN '02' THEN 'S'  ");
					sql.append( " WHEN '03' THEN 'K' WHEN '04' THEN 'G' END||  ");
					sql.append( " CASE A.AST2ND WHEN '11' THEN 'L'  WHEN '12' THEN 'B'  WHEN '13' THEN 'S'  ");
					sql.append( " WHEN '14' THEN 'V' WHEN '15' THEN 'I' WHEN '16' THEN 'F' WHEN '17' THEN 'E'  ");
					sql.append( " END||CASE A.AST3RD WHEN '01' THEN 'H' WHEN '02' THEN 'B' WHEN '03' THEN 'C'  ");
					sql.append( " WHEN '04' THEN 'O'  WHEN '05' THEN 'T' WHEN '06' THEN 'F'  ");
					sql.append( " WHEN '07' THEN 'E' WHEN '00' THEN '0' END||A.ASTSEQ) as ASETNO, ");
					sql.append( " B.ASTNAME, COALESCE(C.ASTAQAMT,0) as QAMT, COALESCE(C.ASTYUSE,0) AS YUSE, ");
					sql.append("  COALESCE(A.ASTDAT,0) AS STYMD, COALESCE(A.ASTAMT,0) AS STAMT, ");
					sql.append("  COALESCE(A.ASTDAT,0) AS WRKDAT FROM ACCOUNT.ASTYEPR A, ");
					sql.append( " ACCOUNT.ASTMST B,ACCOUNT.ASTBASIC C WHERE A.FDCODE=B.FDCODE AND ");		    
					sql.append( " A.ATCODE=B.ATCODE AND A.AST1ST=B.AST1ST AND A.AST2ND=B.AST2ND AND ");
					sql.append( " A.AST3RD=B.AST3RD AND A.ASTSEQ=B.ASTSEQ AND A.FDCODE=C.FDCODE AND ");
					sql.append( " A.ATCODE=C.ATCODE AND A.AST1ST=C.AST1ST AND A.AST2ND=C.AST2ND AND ");
					sql.append( " A.AST3RD=C.AST3RD AND A.ASTSEQ=C.ASTSEQ AND ");
					sql.append( " A.AST2ND<>'11' ");
				
					if (!str1.equals("")) sql.append( " AND A.AST1ST = '" + str1 + "' " );    //����
					if (!str2.equals("")) sql.append( " AND A.AST2ND = '" + str2 + "' " );    //�ڻ�з�
					if (!str3.equals("")) sql.append( " AND A.ASTYM  <= '" + str3 + "' " );    //���
					if (!str4.equals("")) sql.append( " AND A.AST1ST  = '" + str4 + "' " );
					if (!str5.equals("")) sql.append( " AND A.AST2ND  = '" + str5 + "' " );
					if (!str6.equals("")) sql.append( " AND A.AST3RD  = '" + str6 + "' " );
					if (!str7.equals("")) sql.append( " AND A.ASTSEQ  = '" + str7 + "' " );
			
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