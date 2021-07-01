package sales.sample;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class CodeGe extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
//		 ���� ���� �Ķ����
		
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
			select(req, res);
	}

	// ��ȸ method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		System.out.println("# Command : ��ȸ");
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/* DataBase */
		GauceDBConnection conn = null; 							// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		ResultSet rs = null;
		ResultSetMetaData rsm = null;
		String query = "";			// SELECT��  ���� 
		String whereQuery =  "";	// WHERE��  ���� 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// Table
			String tableName = (String)req.getParameter("tableName");
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT * FROM " + tableName + " WHERE 1=1 "; 								
					
					query += whereQuery;
				
					// ���� ����
					stmt = conn.getGauceStatement(query); 
					rs = stmt.executeQuery(); 
					rsm = rs.getMetaData();
					
					int columnCount = rsm.getColumnCount(); // �÷� ī��Ʈ 
				
					for (int i = 1; i <= columnCount ; i++ ) {
						System.out.println("�÷��� : ==> " + rsm.getColumnName(i)); // �÷��� 
						System.out.println("Ÿ�� : ==> " + rsm.getColumnTypeName(i)); // Ÿ�� �̸�
						System.out.println("������ : ==> " + rsm.getColumnDisplaySize(i)); // �÷� ������ 
						
						// HEADER ����
						if (rsm.getColumnTypeName(i).equals("VARCHAR")) {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_STRING, rsm.getColumnDisplaySize(i)));
							
						//	"	<C> name='�з��ڵ�' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
							
							
						} else if (rsm.getColumnTypeName(i).equals("NUMERIC")) {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_NUMBER, rsm.getColumnDisplaySize(i)));
							
						//	"	<C> name='�з��ڵ�' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
						} else {
							ds1.addDataColumn(new GauceDataColumn(rsm.getColumnName(i), GauceDataColumn.TB_STRING, rsm.getColumnDisplaySize(i)));
							
							//"	<C> name='�з��ڵ�' 	ID='head' 			HeadAlign=Center HeadBgColor=#b8d2ed Width=100  align=left editlimit=5</C>" +
						}
						
						// JSP ���� �ʿ��� �׸��� �ʱ�ȭ
						
							
					}
					stmt.close();
					
					
					stmt.executeQuery(ds1); // DataSet set

					stmt.close();
					break;
					
				
					
			}
			 ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�. 
			 gceRes.commit();
			 gceRes.close();
		
		}catch (Exception e) {
			e.printStackTrace();
			// Error Log ó�� ��� (log4j ��뿩��)
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
		}
	}
	


}
