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

public class Sy020H extends HttpServlet {
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
		//System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
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
			ds1 = new GauceDataSet(); // Dataset(TSY010) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			// �˻��� ����
			String  sEmpno		= HDUtil.nullCheckStr(req.getParameter("sEmpno"));			
//			String  sEmpnmk		= HDUtil.nullCheckStr(req.getParameter("sEmpnmk"));
			
			//System.out.println("1111"+s_Item1);
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			//ù��°,�ι�° �׸���
			//detail�� ������ �ƴ� ��� dsType=1, ������ ��� dsType=2

			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// ��� ������� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t"+      "T1.empno,"
							+ "\n\t"+      "T1.empnmk,"
							+ "\n\t"+      "T1.deptcd,"
							+ "\n\t"+      "T2.deptnm,"
							+ "\n\t"+      "T1.regdiv "	
							+ "\n\t" + "FROM "
							+ "\n\t" + "PAYROLL.HIPERSON T1 LEFT OUTER JOIN  PAYROLL.HCDEPT   T2 "
							+ "\n\t" + "ON T1.DEPTCD = T2.DEPTCD "
							+ "\n\t" + "WHERE T1.empno LIKE '%"+sEmpno.trim()+"%' "
							+ "\n\t" + "OR T1.empnmk LIKE '%"+sEmpno.trim()+"%' "
							+ "\n\t" + "ORDER BY T1.empno ASC ";					

					query += whereQuery;
					//System.out.println("# Command4 : ��ȸ");
					//System.out.println(query);

					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("empno",  GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("empnmk",         GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("deptcd",         GauceDataColumn.TB_STRING, 4));
					ds1.addDataColumn(new GauceDataColumn("deptnm",         GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("regdiv",         GauceDataColumn.TB_STRING, 4));					
					
					// ���� ����
					stmt = conn.getGauceStatement(query); 
					
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
