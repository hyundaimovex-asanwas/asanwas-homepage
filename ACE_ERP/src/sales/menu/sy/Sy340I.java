package sales.menu.sy;

import java.io.IOException;
/**
 * �� �� �� 	: �̺���
 * ��	�� 	: 2006-05-15
 * �������� 	: 1. ���ϸ� �� ���̺�� ����
 *         	: Cu040I �� Sy340I
 */

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDCookieManager;
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

 
public class Sy340I extends HttpServlet {
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
		System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  �������� 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// �ʱ�ȭ
			init(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// ���� (����, ����, ����) 
			apply1(req, res);
		} 
	}
	
	/*****************************************************************************
	 * Gauce Object ����
	 * Select �� �� Project Name , Project Id�� ��ȸ�Ѵ�
	 * ������ �ε��ÿ� �ʱ�ȭ �۾��̴� 
	 *****************************************************************************/
	public void init(HttpServletRequest req, HttpServletResponse res)  throws ServletException {

		System.out.println("# Command : ����ȸ");
		
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
			ds1 = new GauceDataSet(); // Dataset TCU020
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);
					
					// ������Ʈ���� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	project_id, " 
							+ "\n\t" + "	project_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY320 " 
							+ "\n\t" + "WHERE 1=1 ";
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_id", GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("project_nm", GauceDataColumn.TB_STRING, 30));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
				
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
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
		GauceDataSet ds2 = null;
		
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
			ds1 = new GauceDataSet(); // Dataset TSY240 
			ds2 = new GauceDataSet(); // Dataset TRM010
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String  sProjectId		= HDUtil.nullCheckStr(req.getParameter("sProjectId"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	A.project_id, "
							+ "\n\t" + "	B.project_nm, "
							+ "\n\t" + "	A.menu_id, " 
							+ "\n\t" + "	A.menu_nm, " 
							+ "\n\t" + "	A.display_seq " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY340 AS A, SALES.TSY320 AS B" 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n\t" + "	AND A.project_id = B.project_id";
							
					if (!"".equals(sProjectId)) {
						whereQuery += ""
								   + "\n\t" + " AND A.project_id=? ";
					}
							
					query += whereQuery;
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("project_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("menu_id", 		GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("menu_nm", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_STRING, 2));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(sProjectId)) {
						stmt.setString(sCnt1++, sProjectId);
					}
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2:

					break;
	
			}
			 ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�. 
			 ds2.flush();
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
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// �Է�, ����, ����
	public void apply1(HttpServletRequest req, HttpServletResponse res) {
		
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
			
			GauceDataSet inputDs1 = gceReq.getGauceDataSet("INPUT_DATA");  
			/*
			 * Request Parameter
			 */
//			int iParamSaupSid = HDUtil.convertNum(req.getParameter("saup_sid"));		// ����� SID
//			int iParamUpjangSid = HDUtil.convertNum(req.getParameter("upjang_sid"));	// ������ SID
			/** 
			 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
			 **/
			HDCookieManager hdCookie = new HDCookieManager(req, res);
			String vusrid = hdCookie.getCookieValue("vusrid",req); // empno
			
			String fParamEmpno = "";
			String fParamIp = "";
			if (vusrid != null || !vusrid.equals("") ||  vusrid.length() > 0) {
				fParamEmpno = vusrid;
			} else {
				fParamEmpno = "tester";
			}

			 fParamIp = req.getRemoteAddr();
			
			 String iParamEmpno = fParamEmpno;
			 String iParamIp = fParamIp;
			
			/*
			 * Desc 	 : �޴� ��� 
			 * Parameter : project_id = ������Ʈ ID, menu_nm = �޴���, menu_id = �޴� ID
			 * 			 : �����ȣ, IP�� ��Ű ���, �������� Current Timestamp�� ó��
			 */ 
			int colNm_ProjectId 	= inputDs1.indexOfColumn("project_id");		// ������Ʈ ID
			int colNm_MenuId 		= inputDs1.indexOfColumn("menu_id");		// �޴� ID
			int colNm_MenuName		= inputDs1.indexOfColumn("menu_nm");		// �޴� ��
			int colNm_DisplaySeq 	= inputDs1.indexOfColumn("display_seq");	// ȭ��ǥ�ü��� 
			GauceDataRow[] rows 	= inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY340 "
						+ "\n\t" + "	("
						+ "\n\t" + "		project_id, "
						+ "\n\t" + "		menu_id, " 
						+ "\n\t" + "		menu_nm, "
						+ "\n\t" + "		display_seq, "
						+ "\n\t" + "		u_empno, "
						
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ?, ?, ?, "
						+ "\n\t" + "    		CURRENT TIMESTAMP, ? "
						+ "\n\t" + "       )"
						+ "\n";
		
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY340"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		menu_nm = ?,"
						+ "\n\t" + "		display_seq = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=? AND menu_id=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY340 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=? AND menu_id=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			// Grid ù��° 
			for(int i = 0; i < rows.length; i++) {
				// �Է� 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + insertQuery);
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(iCnt++, colNm_ProjectId);	// ������Ʈ Id
					stmt.bindColumn(iCnt++, colNm_MenuId);		// �޴� ID
					stmt.bindColumn(iCnt++, colNm_MenuName);	// �޴���
					stmt.bindColumn(iCnt++, colNm_DisplaySeq); // ȭ��ǥ�ü��� 
					// **** ��Ű ***** //
					stmt.setString(iCnt++, iParamEmpno);		// ������ ��� 
					stmt.setString(iCnt++, iParamIp);			// ������ ip
				
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
					
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_MenuName));
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_DisplaySeq));
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_ProjectId));
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_MenuId));
					
					stmt.bindColumn(uCnt++, colNm_MenuName);	// �޴���
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);	// ȭ��ǥ�ü��� 
					stmt.setString(uCnt++, iParamEmpno);		// ������ �����ȣ
					stmt.setString(uCnt++, iParamIp);			// ������ IP
					
					stmt.bindColumn(uCnt++, colNm_ProjectId);	// ������Ʈ Id 
					stmt.bindColumn(uCnt++, colNm_MenuId);		// �޴� ID
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
				
					stmt.bindColumn(dCnt++, colNm_ProjectId);	// ������Ʈ Id 
					stmt.bindColumn(dCnt++, colNm_MenuId);		// �޴� ID
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
			
			gceRes.flush();
			gceRes.commit();
			gceRes.close();
		} catch (Exception e) {
			try {
				gceRes.write("javascript:alert('test')");
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
			gceRes.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			loader.restoreService(service);
		}
		
		System.out.println("\n\n");
	}
	

}
