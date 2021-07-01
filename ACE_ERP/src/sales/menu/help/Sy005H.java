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

public class Sy005H extends HttpServlet {
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
			ds1 = new GauceDataSet(); // Dataset(TRM030) 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String	s_SalDamCd	= HDUtil.nullCheckStr(req.getParameter("s_SalDamCd"));
			
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
							+ "\n\t" + "    sal_dam_sid, "
							+ "\n\t" + "	sal_dam_cd, " 
							+ "\n\t" + "	sal_dam_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	sales.tsy410 " 
							+ "\n\t" + "WHERE 1=1 " ;

					if (!"".equals(s_SalDamCd)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND sal_dam_cd LIKE ? OR sal_dam_nm LIKE ? ";
									
					}
						whereQuery += "order by sal_dam_nm asc";
	//				if (!"".equals(s_SalDamNm)) {
	//					whereQuery 	+= ""
	//								+ "\n\t" + " AND sal_dam_nm LIKE ? ";
	//				}
				
					query += whereQuery;
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("sal_dam_sid",	GauceDataColumn.TB_DECIMAL, 10,0));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_cd",		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("sal_dam_nm", 	GauceDataColumn.TB_STRING, 22));
				
					// ���� ����
					stmt = conn.getGauceStatement(query); 
							
					if (!"".equals(s_SalDamCd)) {	
						stmt.setString(sCnt1++, "%" + s_SalDamCd + "%");
						stmt.setString(sCnt1++, "%" + s_SalDamCd + "%");
					}
	//				if (!"".equals(s_SalDamNm)) {	
	//					stmt.setString(sCnt1++, "%" + s_SalDamNm + "%");
	//				}

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
