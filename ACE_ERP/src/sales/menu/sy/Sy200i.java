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


public class Sy200i extends HttpServlet {
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
							+ "\n\t" + "	saup_sid, saup_cd, saup_nm, saup_eng_nm, saup_no,"
							+ "\n\t" + "  	ceo_nm, ceo_eng_nm, zip_cd, address1, address2, " 
							+ "\n\t" + "	address_eng,tel_no1, tel_no2, tel_no3, fax_no1, " 
							+ "\n\t" + "	fax_no2, fax_no3, uptae, jongmok, homepage, "
							+ "\n\t" + "	e_mail, u_empno, u_date, u_ip,use_yn, display_seq"
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n";
				
					whereQuery +=  "";
					
					if (!searchKey1.equals("")) {
						query += whereQuery;
					}
					
//					���̺� ���� init
//					������ �� ���̺��� �÷� ���¸� �ʱ�ȭ �Ѵ� 
					ds1.addDataColumn(new GauceDataColumn("saup_sid",	 	GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("saup_cd", 		GauceDataColumn.TB_STRING, 5));
					ds1.addDataColumn(new GauceDataColumn("saup_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("saup_eng_nm", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("saup_no", 		GauceDataColumn.TB_STRING, 12));
					ds1.addDataColumn(new GauceDataColumn("ceo_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("ceo_eng_nm", 	GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("zip_cd", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("address1", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address2", 		GauceDataColumn.TB_STRING, 60));
					ds1.addDataColumn(new GauceDataColumn("address_eng", 	GauceDataColumn.TB_STRING, 80));
					ds1.addDataColumn(new GauceDataColumn("tel_no1", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("tel_no2", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("tel_no3", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no1", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no2", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("fax_no3", 		GauceDataColumn.TB_STRING, 15));
					ds1.addDataColumn(new GauceDataColumn("uptae", 			GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("jongmok", 		GauceDataColumn.TB_STRING, 50));
					ds1.addDataColumn(new GauceDataColumn("homepage", 		GauceDataColumn.TB_STRING, 25));
					ds1.addDataColumn(new GauceDataColumn("e_mail", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("use_yn", 		GauceDataColumn.TB_STRING, 5));
					ds1.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_NUMBER, 5));
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
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
		String deleteQuery2 = "";
		String deleteQuery3 = "";
		
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
			
			int colNm_Saup_Sid	 		= inputDs1.indexOfColumn("saup_sid");			// �����SID
			int colNm_Saup_Cd	 		= inputDs1.indexOfColumn("saup_cd");			// ������ڵ� 
			int colNm_Saup_Nm 			= inputDs1.indexOfColumn("saup_nm");			// ����Ҹ�
			int colNm_Use_Yn			= inputDs1.indexOfColumn("use_yn");				// ��뿩��
			int colNm_Display_Seq		= inputDs1.indexOfColumn("display_seq");		// ����
			int colNm_Saup_Eng_Nm	 	= inputDs1.indexOfColumn("saup_eng_nm"); 		// ����Ҹ�(����)
			int colNm_Saup_No 			= inputDs1.indexOfColumn("saup_no");			// ����ڹ�ȣ 
			int colNm_Ceo_Nm 			= inputDs1.indexOfColumn("ceo_nm");			// ��ǥ�̻�
			int colNm_Ceo_Eng_Nm 		= inputDs1.indexOfColumn("ceo_eng_nm");		// ��ǥ�̻�(����)
			int colNm_Zip_Cd 			= inputDs1.indexOfColumn("zip_cd");			// �����ȣ
			int colNm_Address1 			= inputDs1.indexOfColumn("address1");			// �ּ�1
			int colNm_Address2			= inputDs1.indexOfColumn("address2");			// �ּ�2
			int colNm_Address_Eng 		= inputDs1.indexOfColumn("address_eng");		// �ּ�(����)
			int colNm_Tel_No1 			= inputDs1.indexOfColumn("tel_no1");			// ��ǥ��ȭ
			int colNm_Tel_No2 			= inputDs1.indexOfColumn("tel_no2");			// ��ȭ2
			int colNm_Tel_No3 			= inputDs1.indexOfColumn("tel_no3");			// ��ȭ3
			int colNm_Fax_No1 			= inputDs1.indexOfColumn("fax_no1");			// ��ǥ�ѽ�
			int colNm_Fax_No2 			= inputDs1.indexOfColumn("fax_no2");			// �ѽ�2
			int colNm_Fax_No3 			= inputDs1.indexOfColumn("fax_no3");			// �ѽ�3
			int colNm_Uptae 			= inputDs1.indexOfColumn("uptae");			// ����
			int colNm_Jongmok 			= inputDs1.indexOfColumn("jongmok");			// ����
			int colNm_Homepage 			= inputDs1.indexOfColumn("homepage");			// Ȩ������
			int colNm_E_mail 			= inputDs1.indexOfColumn("e_mail");			// E-Mail
			
			GauceDataRow[] rows = inputDs1.getDataRows();

			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY200 "
						+ "\n\t" + "	("
						+ "\n\t" + "		saup_cd, " +
											"saup_nm, " 
						+ "\n\t" + "		saup_no," +

											"ceo_nm, " +
											"zip_cd, " +
											"address1, "
						+ "\n\t" + "		address2,"+
						
											"tel_no1, " +
											"fax_no1, "	+
											
											"uptae, " +
											"jongmok, " +
											"homepage, "

						+ "\n\t" + "		e_mail, " +
											"u_empno, " +
											"u_date, " +
											"u_ip, " +
											"display_seq, " +
											"use_yn " 
						+ "\n\t" + "	) "
						+ "\n\t" + " VALUES ("
						+ "\n\t" + "    		?, ?, ?, ?, " 
						+ "\n\t" + "			?, ?, ?, ?, ?, " 
						+ "\n\t" + "			?, ?, ?, ?,  " 
						+ "\n\t" + "			?, CURRENT TIMESTAMP, ? ,?, ?" 
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY200"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		saup_cd = ?,"
						+ "\n\t" + "		saup_nm = ?,"
						+ "\n\t" + "		saup_no = ?, "
						+ "\n\t" + "		ceo_nm = ?, "
						+ "\n\t" + "		zip_cd = ?, "
						+ "\n\t" + "		address1 = ?, "
						+ "\n\t" + "		address2 = ?, "
						+ "\n\t" + "		tel_no1 = ?, "
						+ "\n\t" + "		fax_no1 = ?, "
						+ "\n\t" + "		uptae = ?, "
						+ "\n\t" + "		jongmok = ?, "
						+ "\n\t" + "		homepage = ?, "
						+ "\n\t" + "		e_mail = ?, "
						+ "\n\t" + "		u_empno = ?, "
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP, "
						+ "\n\t" + "		u_ip = ?, "
						+ "\n\t" + "		display_seq = ?, "
						+ "\n\t" + "		use_yn = ? "
			
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			updateQuery += "\n\t" + "	AND saup_sid=?";	
			
			
			deleteQuery1 += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY200 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n"		
						+ "\n\t" + "	AND saup_sid=?";	
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
					
					stmt.bindColumn(iCnt++, colNm_Saup_Cd);
					stmt.bindColumn(iCnt++, colNm_Saup_Nm);
					stmt.bindColumn(iCnt++, colNm_Saup_No);
					
					stmt.bindColumn(iCnt++, colNm_Ceo_Nm);
					stmt.bindColumn(iCnt++, colNm_Zip_Cd);
					stmt.bindColumn(iCnt++, colNm_Address1);
					stmt.bindColumn(iCnt++, colNm_Address2);
					
					stmt.bindColumn(iCnt++, colNm_Tel_No1);
					stmt.bindColumn(iCnt++, colNm_Fax_No1);
					
					stmt.bindColumn(iCnt++, colNm_Uptae);
					stmt.bindColumn(iCnt++, colNm_Jongmok);
					stmt.bindColumn(iCnt++, colNm_Homepage);
					stmt.bindColumn(iCnt++, colNm_E_mail);
					
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);
					stmt.bindColumn(iCnt++, colNm_Display_Seq);
					stmt.bindColumn(iCnt++, colNm_Use_Yn);
					
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
					
					stmt.bindColumn(uCnt++, colNm_Saup_Cd);
					stmt.bindColumn(uCnt++, colNm_Saup_Nm);
					stmt.bindColumn(uCnt++, colNm_Saup_No);
					stmt.bindColumn(uCnt++, colNm_Ceo_Nm);
					
					stmt.bindColumn(uCnt++, colNm_Zip_Cd);
					stmt.bindColumn(uCnt++, colNm_Address1);
					stmt.bindColumn(uCnt++, colNm_Address2);
					stmt.bindColumn(uCnt++, colNm_Tel_No1);

					stmt.bindColumn(uCnt++, colNm_Fax_No1);

					stmt.bindColumn(uCnt++, colNm_Uptae);
					stmt.bindColumn(uCnt++, colNm_Jongmok);
					stmt.bindColumn(uCnt++, colNm_Homepage);
					stmt.bindColumn(uCnt++, colNm_E_mail);
					stmt.setString(uCnt++, iParamEmpno);
					
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_Display_Seq);
					stmt.bindColumn(uCnt++, colNm_Use_Yn);
					
					stmt.bindColumn(uCnt++, colNm_Saup_Sid);

					stmt.executeUpdate();
					stmt.close();
				}
				
				// ����
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : ���� TSY200");
					System.out.println("# Query : " + deleteQuery1);
					
					stmt = conn.getGauceStatement(deleteQuery1);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(dCnt, colNm_Saup_Sid);
					
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
