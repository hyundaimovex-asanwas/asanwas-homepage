package sales.menu.cu;


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

public class Cu140I extends HttpServlet {
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
		String proType = HDUtil.nullCheckStr(req.getParameter("proType")); //��ȸ, ����
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum")); //�׸��� ����
		System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  �������� 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// �ʱ�ȭ
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// ���� (����, ����, ����) 
			apply(req, res);
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
		GauceDataSet ds1 = null;//�����ͼ�1
		GauceDataSet ds2 = null;//�����ͼ�2
		GauceDataSet ds3 = null;//�����ͼ�3
		
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
			ds1 = new GauceDataSet(); // Dataset TCU030 
			ds2 = new GauceDataSet(); // Dataset TCU050
			ds3 = new GauceDataSet(); // Dataset TCU050+TCU120
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String  s_ProjectLevel	= HDUtil.nullCheckStr(req.getParameter("s_ProjectLevel"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));//�б� �����ͼ� ����
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	project_level, " 
							+ "\n\t" + "	project_level_nm, " 
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	char(u_date) u_date, "
							+ "\n\t" + "	u_ip " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY330 " 
							+ "\n\t" + "WHERE 1=1 ";

					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_level", 	GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("project_level_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					
					//���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
				break;
				case 2:
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	project_id, " 
							+ "\n\t" + "	menu_id, "
							+ "\n\t" + "	program_id, " 
							+ "\n\t" + "	program_nm, " 
							+ "\n\t" + "	display_seq, "
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	char(u_date) u_date, "
							+ "\n\t" + "	u_ip " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY350 " 
							+ "\n\t" + "WHERE 1=1 ";

					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("menu_id", 	GauceDataColumn.TB_STRING, 2));
					ds2.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_DECIMAL, 3,0));
					ds2.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds2.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds2.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					
					//���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds2); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
				
					stmt.close();
				break;
				case 3 :
					int sCnt3 = 1;
					gceRes.enableFirstRow(ds3);
					
					// ��� ����� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 
							+ "\n\t" + "    B.project_level project_level, "
							+ "\n\t" + "    A.project_id project_id, "
							+ "\n\t" + "    A.menu_id menu_id, "
							+ "\n\t" + "    A.program_id program_id, "
							+ "\n\t" + "	A.program_nm program_nm, "
							+ "\n\t" + "    A.display_seq display_seq, "
							+ "\n\t" + "    A.u_empno u_empno, "
							+ "\n\t" + "    char(A.u_date) u_date, "
							+ "\n\t" + "    A.u_ip u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY350 A "
							+ "\n\t" + "LEFT JOIN SALES.TSY370 B "
							+ "\n\t" + "ON A.program_id=B.program_id "
							+ "\n\t" + "WHERE 1=1 ";

					if (!"".equals(s_ProjectLevel)) {
						whereQuery += ""
								   + "\n\t" + " AND B.project_level=? ";
					}	
					
					query += whereQuery;

					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds3.addDataColumn(new GauceDataColumn("project_level", 	GauceDataColumn.TB_STRING, 3));
					ds3.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds3.addDataColumn(new GauceDataColumn("menu_id", 		GauceDataColumn.TB_STRING, 2));
					ds3.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds3.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds3.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_DECIMAL, 2,0));
					ds3.addDataColumn(new GauceDataColumn("u_empno",	 	GauceDataColumn.TB_STRING, 7));
					ds3.addDataColumn(new GauceDataColumn("u_date",		 	GauceDataColumn.TB_STRING, 26));
					ds3.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));

					//���� ����
					stmt = conn.getGauceStatement(query); 

					if (!"".equals(s_ProjectLevel)) {	
						stmt.setString(sCnt3++, s_ProjectLevel);
					}					
					
					stmt.executeQuery(ds3); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds3.getDataRowCnt());
				
					stmt.close();
				break;	
			}
			 ds1.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�. 
			 ds2.flush();
			 ds3.flush();
			 gceRes.commit();
			 gceRes.close();
			  
		
		}catch (Exception e) {
			e.printStackTrace();
			// Error Log ó�� ��� (log4j ��뿩��)
			System.out.println("Cu140I:select exception:"+e.getMessage());
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("Cu140I:close exception");
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
			/*
			 * Request Parameter
			 */
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
			
			// Grid ù��° 
			///////////////////////////////////////////////////////////////////////

			int colNm_ProjectLevel = inputDs1.indexOfColumn("project_level");	//������Ʈ����		
			int colNm_ProgramId = inputDs1.indexOfColumn("program_id");	//���α׷�ID

			GauceDataRow[] rows = inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY370 "
						+ "\n\t" + "	("
						+ "\n\t" + "		project_level, "
						+ "\n\t" + "		program_id, "
						+ "\n\t" + "		u_empno, " 
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?,?,?,CURRENT TIMESTAMP,? "
						+ "\n\t" + "       )"
						+ "\n";
		
			updateQuery += ""; 		
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY370 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_level=?"
						+ "\n\t" + "	AND program_id=?";

			// Database Connection
			conn = service.getDBConnection();
			
			// Grid ù��° 
			for(int i = 0; i < rows.length; i++) {
				// �Է� 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + insertQuery);
					
					System.out.println("# Value Head =");
					System.out.println("# Value HeadName =");
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_ProjectLevel);	//
					stmt.bindColumn(iCnt++, colNm_ProgramId);	//					
					// **** ��Ű ***** //
					stmt.setString(iCnt++, iParamEmpno);		// ������ ��� 
					stmt.setString(iCnt++, iParamIp);			// ������ ip
				
					stmt.executeUpdate();
					
					stmt.close();
				}
				// ����
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

				}
				
				// ����
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : ����");
					System.out.println("# Query : " + deleteQuery);
					System.out.println("# Value : head ");
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_ProjectLevel);	// 
					stmt.bindColumn(dCnt++, colNm_ProgramId);	//	
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
		} catch (Exception e) {
			gceRes.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			System.out.println("Cu140I:apply exception");
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("Cu140I:close exception");
				}
			}
			loader.restoreService(service);
		}
		
		System.out.println("\n\n"); 
	}

}
