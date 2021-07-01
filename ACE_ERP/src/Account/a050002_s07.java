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
public class a050002_s07 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//����
				String  str2 = req.getParameter("v_str2");	//�⵵
				String  str3 = req.getParameter("v_str3");	//����Ⱓfrom
				String  str4 = req.getParameter("v_str4");	//����Ⱓfrom
				String  str5 = req.getParameter("v_str5");	//����/���� ����
		        String  str6 = req.getParameter("v_str6");	//���
		        String  whereStr = "WHERE";
				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";
				if(str5 == null) str5 = "";
				if(str6 == null) str6 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
          "VENDCNT1"  , "SHTCNT1" , "REQAMT1" , "VATAMT1",
          "VENDCNT2"  , "SHTCNT2" , "REQAMT2" , "VATAMT2",
					"VENDCNT"   , "SHTCNT"  , "REQAMT"  , "VATAMT"
				}; 

				int[] intArrCN = new int[]{
          7 , 7 , 15 , 14,
          7 , 7 , 15 , 14,
          7 , 7 , 15 , 14
				}; 
			
				int[] intArrCN2 = new int[]{     
					0, 0, 0, 0,
          0, 0, 0, 0,
          0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			          sql.append("\n SELECT VENDCNT1,SHTCNT1,REQAMT1,VATAMT1, ");
			          sql.append("\n        VENDCNT2,SHTCNT2,REQAMT2,VATAMT2, ");
			          sql.append("\n        VENDCNT,SHTCNT,REQAMT,VATAMT ");
			          sql.append("\n   FROM ACCOUNT.AVATRPT6                                  ");
			
			          if(!str1.equals("")){
			          sql.append("\n  "+whereStr+" FDCODE = '"+str1+"'                                     ");//����
			          whereStr = "AND";
			          }
			          if(!str2.equals("")){
			          sql.append("\n    "+whereStr+" ACCYY = '"+str2+"'                                    ");//�⵵
			          whereStr = "AND";
			          }
			          if(!str6.equals("")){
			          sql.append("\n    "+whereStr+" ACCYYQT = '"+str6+"'                                     ");//���
			          whereStr = "AND";
			          }
			          
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