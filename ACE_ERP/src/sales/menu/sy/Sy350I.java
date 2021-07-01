package sales.menu.sy;

import java.io.IOException;


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
/**
 * 
 * @author �̺���
 * ������� 	: 2005-05-15 
 *       	: 1. ���ϸ� ���� Cu050I.java �� Sy350I.java���� 
 *	
 */
public class Sy350I extends HttpServlet {
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
			apply(req, res);
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
		GauceDataSet ds2 = null;
		
		String query = "";			// SELECT��  ���� 
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
			ds2 = new GauceDataSet(); // Dataset TCU040
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			String sProjectID = HDUtil.nullCheckStr(req.getParameter("sProjectId"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);
					
					// ��� ������Ʈ ���� ����
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	project_id, " 
							+ "\n\t" + "	project_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY320 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n\t" + "	AND project_id IN ( "
							+ "\n\t" + "		SELECT project_id FROM sales.tsy340)";
					
		//select * from sales.TSY320 where project_id in (select project_id from sales.tcu040)
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
				case 2 :
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
					
					// ��� ������Ʈ ���� ����
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	menu_id, " 
							+ "\n\t" + "	menu_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY340 " 
							+ "\n\t" + "WHERE 1=1 ";
					
					if (!"".equals(sProjectID)) {
						query += "\n\t" + "AND project_id=?";
					}
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("menu_id", GauceDataColumn.TB_STRING, 3));
					ds2.addDataColumn(new GauceDataColumn("menu_nm", GauceDataColumn.TB_STRING, 30));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(sProjectID)) {
						stmt.setString(sCnt2++, sProjectID);
					}
					
					stmt.executeQuery(ds2); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
				
					stmt.close();					
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
		
		String query = "";			// SELECT��  ���� 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset TCU050
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String 	sProjectId	= HDUtil.nullCheckStr(req.getParameter("sProjectId"));
			String  sMenuId		= HDUtil.nullCheckStr(req.getParameter("sMenuId"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					
					// ���α׷� ����� ����  
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	a.project_id, " 
							+ "\n\t" + "	a.menu_id, " 
							+ "\n\t" + "	b.menu_nm, "
							+ "\n\t" + "	a.program_id, " 
							+ "\n\t" + "	a.program_nm, " 
							
							+ "\n\t" + "	a.display_seq, "
							+ "\n\t" + "	a.u_empno, "
							+ "\n\t" + "	a.u_date, "
							+ "\n\t" + "	a.u_ip "
							
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY350 AS A, SALES.TSY340 AS B" 
							+ "\n\t" + "WHERE 1=1 "
						    + "\n\t" + " 	AND a.project_id = ? "
						    + "\n\t" + " 	AND a.project_id = b.project_id "
						    + "\n\t" + " 	AND a.menu_id = b.menu_id ";
						    
					


					
					if (!"".equals(sMenuId)) {
						query +=  "\n\t" + "	AND a.menu_id=?"; 
					}
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("menu_id", 		GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("menu_nm", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					
					
					
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.setString(sCnt1++, sProjectId);
					
					if (!"".equals(sMenuId)) {
						stmt.setString(sCnt1++, sMenuId);
					}
					
					System.out.println("Project ID -> " + sProjectId);
					System.out.println("Menu ID -> " + sMenuId);
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
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// �Է�, ����, ����
	public void apply(HttpServletRequest req, HttpServletResponse res) {
		
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
			
			// �˻��� ����
		
			
			/*
			 * Desc 	 : �޴� ��� 
			 * Parameter : project_id = ������Ʈ ID, menu_nm = �޴���, menu_id = �޴� ID
			 * 			 : �����ȣ, IP�� ��Ű ���, �������� Current Timestamp�� ó��
			 */ 
			int colNm_ProjectId		= inputDs1.indexOfColumn("project_id");		//������Ʈ ID
			int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// ���α׷��� ��
			int colNm_ProgramName	= inputDs1.indexOfColumn("program_nm");		// ���α׷��� ��
			int colNm_DisplaySeq 	= inputDs1.indexOfColumn("display_seq");	// ȭ��ǥ�ü���
			int colNm_MenuId 		= inputDs1.indexOfColumn("menu_id");		// �޴�ID
			
			GauceDataRow[] rows 	= inputDs1.getDataRows();
			
		
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY350 "
						+ "\n\t" + "	("
						+ "\n\t" + "		project_id, "
						+ "\n\t" + "		menu_id, " 
						+ "\n\t" + "		program_id, "
						+ "\n\t" + "		program_nm, "
						+ "\n\t" + "		display_seq, "
						
						+ "\n\t" + "		u_empno, "
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ?, ?, ?, "
						+ "\n\t" + "    		?,CURRENT TIMESTAMP, ? "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY350"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		program_nm = ?,"
						+ "\n\t" + "		display_seq = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=? AND menu_id=? AND program_id=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY350 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=? AND menu_id=? AND program_id=?";	
			
			
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
					stmt.bindColumn(iCnt++, colNm_ProgramId);	// ���α׷� ID
					stmt.bindColumn(iCnt++, colNm_ProgramName); // ���α׷� �� 
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
					
					stmt.bindColumn(uCnt++, colNm_ProgramName);	// ���α׷� ��
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);	// ȭ��ǥ�ü��� 
					stmt.setString(uCnt++, iParamEmpno);		// ������ �����ȣ
					stmt.setString(uCnt++, iParamIp);			// ������ IP
					
					stmt.bindColumn(uCnt++, colNm_ProjectId);	// ������Ʈ Id
					stmt.bindColumn(uCnt++, colNm_MenuId);		// �޴� ID
					stmt.bindColumn(uCnt++, colNm_ProgramId);	// ���α׷� ID
					
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
					stmt.bindColumn(dCnt++, colNm_ProgramId);	// ���α׷� ID
					
				
					System.out.println("Val => " + rows[i].getColumnValue(colNm_ProgramId));
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
			
			gceRes.flush();
			gceRes.commit();
			gceRes.close();
		} catch (Exception e) {
			try {
				gceRes.write("javascript:alert('�����߻�')");
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
