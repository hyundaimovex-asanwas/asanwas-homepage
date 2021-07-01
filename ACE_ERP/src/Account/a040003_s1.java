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
public class a040003_s1 extends HttpServlet {
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
				//String []  str	= new String [10];
				String str1 = req.getParameter("v_str1");	//����,����
				String str2 = req.getParameter("v_str2");	//�����
				String str3 = req.getParameter("v_str3");	//������ó �ڵ�
				String str4 = req.getParameter("v_str4");	//��꼭�Ⱓ from
				String str5 = req.getParameter("v_str5");	//��꼭�Ⱓ to

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CCCODE","VENDNM","COCODE","TAXIODIV","TAXDAT",
					"TAXSUM","TAXVATAMT","BSNSKND","BSNSCND","COCODENM","TAXIODIVNM"
				}; 

				int[] intArrCN = new int[] { 
					13,  32,   2,   1,   8,
					15,  13,  22,  22, 10, 10
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					 0,   0,  -1,  -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT  ");	
						sql.append( " A.CCCODE CCCODE, B.VEND_NM VENDNM, A.COCODE COCODE, A.TAXIODIV TAXIODIV, A.TAXDAT TAXDAT,      ");
						sql.append( " nvl(A.TAXSUM,0) TAXSUM, nvl(A.TAXVATAMT,0) TAXVATAMT, B.BSNS_KND BSNSKND, B.BSNS_CND BSNSCND,       ");
						sql.append( " CASE WHEN A.COCODE = '01' THEN '��' WHEN A.COCODE = '02' THEN '����'  END AS COCODENM,    ");
						sql.append( " CASE WHEN A.TAXIODIV = '1' THEN '����' WHEN A.TAXIODIV = '2' THEN '����' END AS TAXIODIVNM  ");
						sql.append( " FROM ACCOUNT.ATTAXMST A, ACCOUNT.GCZM_VENDER B                                                                                   ");
						sql.append( " WHERE A.CCCODE = B.VEND_CD  ");
						sql.append( " AND A.TAXKND = '1'    ");
						sql.append( " AND A.FDCODE = '01'  ");
						if(!str1.equals("")) sql.append(" AND A.TAXIODIV = '"+str1+"' " );
						if(!str2.equals("")) sql.append(" AND A.COCODE = '"+str2+"' " );
						if(!str3.equals("")) sql.append(" AND A.CCCODE = '"+str3+"' " );					
						if(!str4.equals("") && !str5.equals("")) sql.append( " AND A.TAXDAT BETWEEN '" + str4 + "' AND '" + str5 + "'" );
						

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