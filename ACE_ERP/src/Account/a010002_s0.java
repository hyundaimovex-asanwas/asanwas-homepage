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
public class a010002_s0 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");  
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");
				String  str4	= req.getParameter("v_str4"); //����
				String  str5	= req.getParameter("v_str5"); //��������
				String  str6	= req.getParameter("v_str6"); //�������

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",  "ATKORNAM", "ATDIV", "ATDIVNM", "ATDECR", 
																					"ATDECRNM","ATUPCODE", "FSREFCD","TYPE"
																				 }; 

				int[] intArrCN = new int[] {  7, 66,  4, 40,  1,  4,  7,  4,  1	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																				\n");
					sql.append( " A.ATCODE,	A.ATKORNAM,	 A.ATDIV,	(B.CDNAM)ATDIVNM , A.ATDECR,						\n");;
					sql.append( " CASE WHEN A.ATDECR='1' THEN '����'														\n");
					sql.append( "      WHEN A.ATDECR='2' THEN '�뺯' END  ATDECRNM,	   								    \n");
					sql.append( " A.ATUPCODE	, A.FSREFCD																\n");
					if (!str6.equals("")) sql.append( " ,C.TYPE															\n");
					else	sql.append( " ,'' AS TYPE																	\n");
					sql.append( " FROM ACCOUNT.ACTCODE A															    \n");
					sql.append( " LEFT JOIN  ACCOUNT.COMMDTIL B ON B.CDCODE=A.ATDIV AND B.CMTYPE='0033' 		        \n");
					if (!str6.equals("")) sql.append( " LEFT JOIN  ACCOUNT.ACTREFCODE C ON A.ATCODE=C.ATCODE 		    \n");	//�������
					sql.append( " WHERE A.ATCODE LIKE '" + str1 + "%'												    \n");
					if (!str3.equals("")) sql.append( "   AND A.ATDIV  = '" + str3 + "'									\n");
					if (!str2.equals("")) sql.append( "   AND A.ATKORNAM  LIKE '%" + str2 + "%'							\n");
					if (!str4.equals("")&&str4.equals("ATUSEYN")) sql.append( "   AND A.ATUSEYN='Y'			    		\n");
					if (!str5.equals("")&&str5.equals("ATDEBTYN")) sql.append( "  AND A.ATDEBTYN='Y'					\n");
					if (!str6.equals("")) sql.append( " AND C.TYPE='B'                                  				\n");					
					sql.append( " ORDER BY A.ATCODE \n");

					//System.out.println("a010002_s0::"+sql.toString()); 
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