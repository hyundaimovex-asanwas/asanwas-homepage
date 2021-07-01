package sales.menu.help;

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

public class Sy007H extends HttpServlet {
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
		/*
		 * Parameter : proType (���� ���� �Ķ����)
		 */
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		
		/*
		 * DESC :  �������� 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// �ʱ�ȭ
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// ���� (����, ����, ����) 
			//apply(req, res);
		} 
	}

	// ��ȸ method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//System.out.println("# Command : ��ȸ");
		
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
			ds1 = new GauceDataSet(); // Dataset(TRM030) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************/
			 
			// �˻��� ����
			String	s_empnm = HDUtil.nullCheckStr(req.getParameter("s_empnm"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			//ù��° �׸���
			//System.out.println("s_SalDamCd" + s_SalDamCd);		
			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					//System.out.println("s_SalDamCd" + s_SalDamCd);
					query   += "" 		
							+ "\n\t" + "SELECT "
							+ "\n\t" + "    uID, "
							+ "\n\t" + "	uName " 
							+ "\n\t" + "  FROM SALES.VUSER"
							+ "\n\t" + " WHERE 1=1 " ;

					if (!"".equals(s_empnm)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND uName LIKE ? ";
					}
						whereQuery 	+= " GROUP BY uID, uName";
					query += whereQuery;
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("uID",		GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("uName", 	GauceDataColumn.TB_STRING, 22));
				
					// ���� ����
					stmt = conn.getGauceStatement(query); 
							
					if (!"".equals(s_empnm)) {	
						stmt.setString(sCnt1++, "%" + s_empnm + "%");
					}

					stmt.executeQuery(ds1); // DataSet set
					
					//System.out.println("# Query : " + query);
					//System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
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
					//stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					loader.restoreService(service);
				}
			}
		}
	}
	
}
