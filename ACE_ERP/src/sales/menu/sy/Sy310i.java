package sales.menu.sy;

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


public class Sy310i extends HttpServlet {
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
		// ���� ���� �Ķ����
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {			// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// ����, ����, ���� 
			modify(req, res);
		} 
	}

	// ��ȸ method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		
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
			String searchKey1 = HDUtil.nullCheckStr(req.getParameter("searchKey1"));
//			 dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);

					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	login_sid, "
							+ "\n\t" + "	login_id, "
							+ "\n\t" + "	login_nm, "
							+ "\n\t" + "	client_sid, "
							+ "\n\t" + "	branch_cd, "
							+ "\n\t" + "	pwd_cd, "
							+ "\n\t" + "	multi_login_yn,"
							+ "\n\t" + "	use_yn, "
							+ "\n\t" + "	u_empno, "
							+ "\n\t" + "	u_date, "
							+ "\n\t" + "	u_ip"
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY310 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n";
					
								
					
					
					whereQuery +=  "";
					
					if (!searchKey1.equals("")) {
						query += whereQuery;
					}
					
//					���̺� ���� init
//					������ �� ���̺��� �÷� ���¸� �ʱ�ȭ �Ѵ� 
					ds1.addDataColumn(new GauceDataColumn("login_sid",	 	GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("login_id", 		GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("login_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("client_sid", 	GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("branch_cd", 		GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("pwd_cd", 		GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("multi_login_yn", GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("use_yn",	 		GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					stmt.executeQuery(ds1);	//DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
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
	
	// �Է�, ����, ����
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
		String deleteQuery1 = "";
		
//		String sParamPwd1 = HDUtil.nullCheckStr(req.getParameter("searchKeyPwd1"));		//��й�ȣ Ȯ��
//		String sParamPwd2 = HDUtil.nullCheckStr(req.getParameter("searchKeyPwd2"));
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			GauceDataSet inputDs1 = gceReq.getGauceDataSet("INPUT_DATA");  
			
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
			
			int colNm_Login_Sid			= inputDs1.indexOfColumn("login_sid");		// �α��� SID
			int colNm_Login_Id	 		= inputDs1.indexOfColumn("login_id");			// ����� ��ȣ 
			int colNm_Login_Nm			= inputDs1.indexOfColumn("login_nm");
			int colNm_Client_Sid		= inputDs1.indexOfColumn("client_sid");
			int colNm_Branch_Cd			= inputDs1.indexOfColumn("branch_cd");
			int colNm_Pwd_Cd	 		= inputDs1.indexOfColumn("pwd_cd");			// ��й�ȣ 
			int colNm_Multi_Login_Yn	= inputDs1.indexOfColumn("multi_login_yn");	// MULTI LOGIN ����
			int colNm_Use_Yn			= inputDs1.indexOfColumn("use_yn");			// ��뿩��
			
			GauceDataRow[] rows = inputDs1.getDataRows();

			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY310 "
						+ "\n\t" + "	("
						+ "\n\t" + "		login_id, " +
											"login_nm, " +
											"client_sid, " +
											"branch_cd, " +
											"pwd_cd, " +
											"multi_login_yn, " +
											"use_yn, " +
											"u_empno, " +
											"u_date, " +
											"u_ip"
						+ "\n\t" + "	) "
						+ "\n\t" + " VALUES ("
						+ "\n\t" + "			?, ?, ?, ?, ?, ?, ?, ?, CURRENT TIMESTAMP,? " 
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY310"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		login_id = ?,"
						+ "\n\t" + "		login_nm = ?,"
						+ "\n\t" + "		branch_cd = ?,"
						+ "\n\t" + "		pwd_cd = ?,"
						+ "\n\t" + "		multi_login_yn = ?,"
						+ "\n\t" + "		use_yn = ?,"
						+ "\n\t" + "		u_empno = ?, "
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP, "
						+ "\n\t" + "		u_ip = ? "
						
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			updateQuery += "\n\t" + "	AND login_sid=?";	
			
			
			deleteQuery1 += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY310 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n"		
						+ "\n\t" + "	AND login_sid=?";	
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
					
					stmt.bindColumn(iCnt++, colNm_Login_Id);
					stmt.bindColumn(iCnt++, colNm_Login_Nm);
					stmt.bindColumn(iCnt++, colNm_Client_Sid);
					stmt.bindColumn(iCnt++, colNm_Branch_Cd);
					stmt.bindColumn(iCnt++, colNm_Pwd_Cd);
					stmt.bindColumn(iCnt++, colNm_Multi_Login_Yn);
					stmt.bindColumn(iCnt++, colNm_Use_Yn);
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);
					
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
					
					stmt.bindColumn(uCnt++, colNm_Login_Id);
					stmt.bindColumn(uCnt++, colNm_Login_Nm);
					stmt.bindColumn(uCnt++, colNm_Branch_Cd);
					stmt.bindColumn(uCnt++, colNm_Pwd_Cd);
					stmt.bindColumn(uCnt++, colNm_Multi_Login_Yn);
					stmt.bindColumn(uCnt++, colNm_Use_Yn);
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					
					stmt.bindColumn(uCnt++, colNm_Login_Sid);

					stmt.executeUpdate();
					stmt.close();
				}
				
				// ����
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : ���� TSY310");
					System.out.println("# Query : " + deleteQuery1);
					
					stmt = conn.getGauceStatement(deleteQuery1);
					
					stmt.setGauceDataRow(rows[i]);
/*					System.out.println("# Value : cntcd " + rows[i].getColumnValue(colNm_CntCd));*/
					stmt.bindColumn(dCnt, colNm_Login_Sid);
					
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
