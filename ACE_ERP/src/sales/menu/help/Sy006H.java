package sales.menu.help;

import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

 
public class Sy006H extends HttpServlet {
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
	
	public void command(HttpServletRequest req, HttpServletResponse res) {
		// ���� ���� �Ķ����
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
	
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {			// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// ����, ����, ���� 
			modify(req, res);
		} 
	}
	
	// �Է� , ���� , ���� method
	
	// ��ȸ method
	public void select(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("# Command : ��ȸ");
		
		res.setContentType("text/html;charset=ksc5601");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		String query = "";
		String whereQuery =  "";
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset 1�� 
			
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// �˻��� ����
			String sKeyWord = HDUtil.nullCheckStr(req.getParameter("sKeyWord"));
			
//			 dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);

					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	ZIP_SID, ZIP_CD, (ADDRESS1 || ' ' || ADDRESS2 || ' ' || ADDRESS3) AS ADDRESS , POST_BOX "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY110 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n" ;
					
					if (!"".equals(sKeyWord)) {
						whereQuery +=  " 		AND (ZIP_CD LIKE ?) ";
					}
						whereQuery += " order by address";
					query += whereQuery;
					
//					���̺� ���� init
//					������ �� ���̺��� �÷� ���¸� �ʱ�ȭ �Ѵ� 
					ds1.addDataColumn(new GauceDataColumn("zip_sid", 		GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("ADDRESS",	 	GauceDataColumn.TB_STRING, 90));
					ds1.addDataColumn(new GauceDataColumn("POST_BOX",	 	GauceDataColumn.TB_STRING, 20));
					
//					 ���� ����
					  
					stmt = conn.getGauceStatement(query); 
					System.out.println("==================>"+sKeyWord);
					if (!"".equals(sKeyWord)) {
						
						stmt.setString(sCnt1++,  sKeyWord+"%");
					}
					stmt.executeQuery(ds1); // DataSet set
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
					stmt.close();
					
					break;
			}
			

			 ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�. 
			 gceRes.commit();
			 gceRes.close();
			  
			 
		} catch (Exception e) {
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
	
	
	public void modify(HttpServletRequest req, HttpServletResponse res) {
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
	}
	
}