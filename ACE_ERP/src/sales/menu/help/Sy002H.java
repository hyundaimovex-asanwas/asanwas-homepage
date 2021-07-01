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
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;


public class Sy002H extends HttpServlet {
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
						whereQuery +=  " 		AND (address2 LIKE ? OR address3 LIKE ?)";
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
					
					if (!"".equals(sKeyWord)) {
						
						stmt.setString(sCnt1++, "%"+ sKeyWord+"%");
						stmt.setString(sCnt1++, "%"+ sKeyWord+"%");
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
		
		String insertQuery = "";
		String updateQuery = "";
		String deleteQuery = "";
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			GauceDataSet inputDs = gceReq.getGauceDataSet("INPUT_DATA");  
			
			int colNm_Zip_Sid	= inputDs.indexOfColumn("zip_sid");
			int colNm_Zip_Cd 	= inputDs.indexOfColumn("zip_cd");		// ȯ�溯���ڵ�
			int colNm_Address1 	= inputDs.indexOfColumn("address1");		// ȯ�漳��
			int colNm_Address2 	= inputDs.indexOfColumn("address2"); 	// ȯ�氪
			int colNm_Address3 	= inputDs.indexOfColumn("address3");		// ȯ������� 
			int colNm_Post_Box 	= inputDs.indexOfColumn("post_box");	
			GauceDataRow[] rows = inputDs.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY110 "
						+ "\n\t" + "	("
						+ "\n\t" + "		 zip_cd, address1, address2, address3, post_box "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ? ,? ,?  "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY110"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		zip_cd	 = ?,"
						+ "\n\t" + "		address1 = ?,"
						+ "\n\t" + "		address2 = ?,"
						+ "\n\t" + "		address3 = ?,"
						+ "\n\t" + "		post_box = ?"
						+ "\n\t" + " WHERE 1=1 "
						+ "\n";		
			updateQuery +="\n\t" + "	AND zip_sid=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY110 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			deleteQuery += "\n\t" + "	AND zip_sid=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// �Է� 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + insertQuery);
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_Zip_Cd);
					stmt.bindColumn(iCnt++, colNm_Address1);
					stmt.bindColumn(iCnt++, colNm_Address2);
					stmt.bindColumn(iCnt++, colNm_Address3);
					stmt.bindColumn(iCnt++, colNm_Post_Box);
				
					stmt.executeUpdate();
					stmt.close();
				}
				// ����
				
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + updateQuery);
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_Zip_Cd);
					stmt.bindColumn(uCnt++, colNm_Address1);
					stmt.bindColumn(uCnt++, colNm_Address2);
					stmt.bindColumn(uCnt++, colNm_Address3);
					stmt.bindColumn(uCnt++, colNm_Post_Box);
					stmt.bindColumn(uCnt++, colNm_Zip_Sid);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// ����
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + deleteQuery);
					
					stmt = conn.getGauceStatement(deleteQuery);
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(dCnt++, colNm_Zip_Sid);
					
					stmt.executeUpdate();
					stmt.close();					
				}
			}
			gceRes.flush();
			gceRes.commit();
			gceRes.close();

		} catch (Exception e) {
			gceRes.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					try {
						conn.close(true);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				loader.restoreService(service);
				
			////
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("\n\n");
	}	
}