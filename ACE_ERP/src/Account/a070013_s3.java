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
public class a070013_s3 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //�����ڵ�  
				String  str2	= req.getParameter("v_str2"); //�μ��ڵ�   
				String  str3	= req.getParameter("v_str3"); //�׸�
				String  str4	= req.getParameter("v_str4"); //��û���fr
				String  str5	= req.getParameter("v_str5"); //��û���to

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ACYYMM","DEPTCD","REMCODE","AMTDIV",
					"PLAMT","EXAMT","REMARK","EXDATE","STATDIV",
					"ATKORNAM"
				};

				int[] intArrCN = new int[]{
					2,   6,   4,  7,  1,
					15,  15, 132,  8, 1,
					66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, -1,
					 0,  0, -1, -1, -1,
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
					sql.append( " SELECT																		\n");
					sql.append( " RTRIM(A.FDCODE)   FDCODE,   /*����*/			\n");
					sql.append( " RTRIM(A.ACYYMM)   ACYYMM,   /*��û���*/	\n");
					sql.append( " RTRIM(A.DEPTCD)   DEPTCD,   /*�μ�*/			\n");
					sql.append( " RTRIM(A.REMCODE)  REMCODE,  /*��������*/	\n");
					sql.append( " RTRIM(A.AMTDIV)   AMTDIV,   /*���ޱ���*/		\n");
					sql.append( " nvl(A.PLAMT,0) PLAMT,    /*��û�ݾ�*/			\n");
					sql.append( " nvl(A.EXAMT,0) EXAMT,    /*�����ݾ�*/			\n");
					sql.append( " RTRIM(A.REMARK)   REMARK,   /*����*/			\n");
					sql.append( " RTRIM(A.EXDATE)   EXDATE,   /*��������*/		\n");
					sql.append( " RTRIM(A.STATDIV)  STATDIV,  /*ó������*/		\n");
					sql.append( " RTRIM(F.ATKORNAM) ATKORNAM  /*������*/				\n");
					sql.append( " FROM ACCOUNT.AFUNDMON A,ACCOUNT.ACTCODE F	\n");
					sql.append( " WHERE A.REMCODE=F.ATCODE									\n");
 					if (!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' ");
 					if (!str2.equals("")) sql.append( " AND A.DEPTCD = '" + str2 + "' ");
 					if (!str3.equals("")) sql.append( " AND A.REMCODE = '" + str3 + "' ");
 					if (!str4.equals("")) sql.append( " AND A.ACYYMM BETWEEN '"+str4+"' AND '"+str5+"'");

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