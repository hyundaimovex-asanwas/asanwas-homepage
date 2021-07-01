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
 * �������
 * 2006-05-15 ���̺�� ����
 * TCU050 -> TSY350
 * TCU110 -> TSY360
 * TCU120 -> TSY370
 */
public class Sy380I extends HttpServlet {
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
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	
			
			if (dsNum == 1) {
				apply1(req, res);
			} else if (dsNum == 2) {
				apply2(req, res);
			} else if (dsNum == 3) {
				apply3(req, res);
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
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet ���� 			
			ds1 = new GauceDataSet(); // Dataset ���α׷� ��ü ���
			ds2 = new GauceDataSet(); // Dataset ����� ��밡���� ���α׷� ���
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter ����
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/

			// �˻��� ����
			String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					
					// ���α׷� ����� ����  
					query   += "" 		
							+"\n\t" + "SELECT "
							+"\n\t" + "		C5.PROGRAM_ID, "
							+"\n\t" + "   	C5.PROGRAM_NM, "
							+"\n\t" + "   	C4.COLORS "
							+"\n\t" + "FROM ( "
							+"\n\t" + "	SELECT C3.PROGRAM_ID, "
							+"\n\t" + "           'YELLOW' AS COLORS "
							+"\n\t" + "	FROM ( "
							+"\n\t" + "            SELECT PROGRAM_ID "
							+"\n\t" + "              FROM SALES.TSY350 "
							+"\n\t" + "            EXCEPT "
							+"\n\t" + "            SELECT DISTINCT "
							+"\n\t" + "                   C2.PROGRAM_ID "
							+"\n\t" + "              FROM SALES.TSY360 C1, "
							+"\n\t" + "                   SALES.TSY370 C2 "
							+"\n\t" + "             WHERE C1.LOGIN_SID     = ? "
							+"\n\t" + "               AND C2.PROJECT_LEVEL = C1.PROJECT_LEVEL "
							+"\n\t" + "            EXCEPT "
							+"\n\t" + "            SELECT PROGRAM_ID "
							+"\n\t" + "              FROM SALES.TSY380 "
							+"\n\t" + "             WHERE LOGIN_SID        =  ? "
							+"\n\t" + "               AND ADD_YN           = 'N' "
							+"\n\t" + "            EXCEPT "
							+"\n\t" + "            SELECT PROGRAM_ID "
							+"\n\t" + "              FROM SALES.TSY380 "
							+"\n\t" + "             WHERE LOGIN_SID        =  ? "
							+"\n\t" + "               AND ADD_YN           = 'Y' "
							+"\n\t" + "         ) C3 "
							+"\n\t" + "	UNION "
							+"\n\t" + "	SELECT  "
							+"\n\t" + "		PROGRAM_ID, "
							+"\n\t" + "       'RED' AS COLORS "
							+"\n\t" + "	FROM SALES.TSY380 "
							+"\n\t" + "    WHERE LOGIN_SID  =   ? "
							+"\n\t" + "		AND ADD_YN     =  'N' "
							+"\n\t" + "    ) C4, "
							+"\n\t" + "    SALES.TSY350 C5 "
							+"\n\t" + "WHERE C5.PROGRAM_ID = C4.PROGRAM_ID ";
				
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("colors",			GauceDataColumn.TB_STRING, 10));			
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.setString(sCnt1++, sLoginSid);
					stmt.setString(sCnt1++, sLoginSid);
					stmt.setString(sCnt1++, sLoginSid);
					stmt.setString(sCnt1++, sLoginSid);
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2 :
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
	
					// ����ڰ� ����ϴ� ���α׷� ����� ����
					query   += "" 		
							+ "\n\t" + "SELECT "
							+ "\n\t" + "		C4.PROGRAM_ID, "
							+ "\n\t" + "		C5.PROGRAM_NM, "
							+ "\n\t" + "		C4.COLORS "
							+ "\n\t" + "  FROM ( "
							+ "\n\t" + "        SELECT C3.PROGRAM_ID, "
							+ "\n\t" + "               'BLACK' AS COLORS "
							+ "\n\t" + "          FROM ( "
							+ "\n\t" + "                SELECT DISTINCT "
							+ "\n\t" + "                       C2.PROGRAM_ID "
							+ "\n\t" + "                  FROM SALES.TSY360 C1, "
							+ "\n\t" + "                       SALES.TSY370 C2 "
							+ "\n\t" + "                 WHERE C1.LOGIN_SID     = ? "
							+ "\n\t" + "                   AND C2.PROJECT_LEVEL = C1.PROJECT_LEVEL "
							+ "\n\t" + "                EXCEPT "
							+ "\n\t" + "                SELECT PROGRAM_ID "
							+ "\n\t" + "                  FROM SALES.TSY380 "
							+ "\n\t" + "                 WHERE LOGIN_SID        =  ? "
							+ "\n\t" + "                   AND ADD_YN           = 'N' "
							+ "\n\t" + "               ) C3 "
							+ "\n\t" + "        UNION "
							+ "\n\t" + "       SELECT PROGRAM_ID, "
							+ "\n\t" + "               'BLUE' AS COLORS "
							+ "\n\t" + "          FROM SALES.TSY380 "
							+ "\n\t" + "         WHERE LOGIN_SID =  ? "
							+ "\n\t" + "           AND ADD_YN    = 'Y' "
							+ "\n\t" + "       ) C4, "
							+ "\n\t" + "       SALES.TSY350 C5 "
							+ "\n\t" + " WHERE C5.PROGRAM_ID = C4.PROGRAM_ID";
					
					
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("colors",			GauceDataColumn.TB_STRING, 10));	
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.setString(sCnt2++, sLoginSid);
					stmt.setString(sCnt2++, sLoginSid);
					stmt.setString(sCnt2++, sLoginSid);
					
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
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * TSY380 ��� ����� 
	 */
	// ����
	public void apply1(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("����");
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		
		String deleteQuery = "";
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// �˻��� ����
			String 	sProjectId	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE  FROM SALES.TSY380 WHERE login_sid=?";
			
			// Database Connection
			conn = service.getDBConnection();
			
			// Grid ù��° 
			int dCnt = 1;
			stmt = conn.getGauceStatement(deleteQuery);
		
			stmt.setString(dCnt++, sProjectId);		// ������Ʈ Id 
			
			stmt.executeUpdate();
			stmt.close();
			
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
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * ��ü ���α׷� 
	 */
	// �Է� Black ���� ���� N�� 
	public void apply2(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("DS1 �Է�");
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
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			GauceDataSet inputDs1 = gceReq.getGauceDataSet("INPUT_DATA");
			
			if (inputDs1 != null) {
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
				String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
				
				/*
				 * Desc 	 : �޴� ��� 
				 * Parameter : project_id = ������Ʈ ID, menu_nm = �޴���, menu_id = �޴� ID
				 * 			 : �����ȣ, IP�� ��Ű ���, �������� Current Timestamp�� ó��
				 */ 
				int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// ���α׷�ID
				int colNm_Color 		= inputDs1.indexOfColumn("colors");	// ���°� �� 
				GauceDataRow[] rows 	= inputDs1.getDataRows();
				
				insertQuery += "\n" 		
							+ "\n\t" + "INSERT INTO SALES.TSY380 "
							+ "\n\t" + "	("
							+ "\n\t" + "		login_sid, "
							+ "\n\t" + "		program_id, " 
							+ "\n\t" + "		add_yn, "
							+ "\n\t" + "		u_empno, "
							+ "\n\t" + "		u_date,  "
	
							+ "\n\t" + "		u_ip  "
							+ "\n\t" + "	)"
							+ "\n\t" + "VALUES ("
							+ "\n\t" + "    		?, ?, ?, ?, CURRENT TIMESTAMP, "
							+ "\n\t" + "    		? "
							+ "\n\t" + "       )"
							+ "\n";
				
				// Database Connection
				conn = service.getDBConnection();
				
				// Grid ù��° 
				for(int i = 0; i < rows.length; i++) {
					// �Է� 
					int iCnt = 1;
					
					String yn = "" + rows[i].getColumnValue(colNm_Color);

					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT ) {
						if (yn.equals("BLACK") || yn.equals("BLUE")) {
							System.out.println("# Command : ����");
							System.out.println("# Query : " + insertQuery);
							
							stmt = conn.getGauceStatement(insertQuery);
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.setString(iCnt++, sLoginSid);			// ����� SID
							stmt.bindColumn(iCnt++, colNm_ProgramId);	// ���α׷� ID
							stmt.setString(iCnt++, "N"); 				// 
							// **** ��Ű ***** //
							stmt.setString(iCnt++, iParamEmpno);		// ������ ��� 
							stmt.setString(iCnt++, iParamIp);			// ������ ip
						
							stmt.executeUpdate();
							
							stmt.close();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	
	/**
	 * ��� : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * ����� ��� ���� ���α׷� 
	 */
	// �Է� yellow ���� ���� Y�� 
	public void apply3(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("DS2 �Է�");
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
		
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			GauceDataSet inputDs1 = gceReq.getGauceDataSet("INPUT_DATA");
			
			if (inputDs1 != null) {
				/** 
				 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
				 **/
				String iParamEmpno = "tGeryon";
				String iParamIp = "100.200.1.130(Geryon)".substring(0,13);
				
				// �˻��� ����
				String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
				
				/*
				 * Desc 	 : �޴� ��� 
				 * Parameter : project_id = ������Ʈ ID, menu_nm = �޴���, menu_id = �޴� ID
				 * 			 : �����ȣ, IP�� ��Ű ���, �������� Current Timestamp�� ó��
				 */ 
				int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// ���α׷��� ��
				int colNm_Color 		= inputDs1.indexOfColumn("colors");	// ���°� �� 
				
				GauceDataRow[] rows 	= inputDs1.getDataRows();
				
				insertQuery += "\n" 		
							+ "\n\t" + "INSERT INTO SALES.TSY380 "
							+ "\n\t" + "	("
							+ "\n\t" + "		login_sid, "
							+ "\n\t" + "		program_id, " 
							+ "\n\t" + "		add_yn, "
							+ "\n\t" + "		u_empno, "
							+ "\n\t" + "		u_date,  "
	
							+ "\n\t" + "		u_ip  "
							+ "\n\t" + "	)"
							+ "\n\t" + "VALUES ("
							+ "\n\t" + "    		?, ?, ?, ?, CURRENT TIMESTAMP, "
							+ "\n\t" + "    		? "
							+ "\n\t" + "       )"
							+ "\n";
				
				// Database Connection
				conn = service.getDBConnection();
				
				// Grid ù��° 
				for(int i = 0; i < rows.length; i++) {
					// �Է� 
					int iCnt = 1;
					
					String yn = "" + rows[i].getColumnValue(colNm_Color);

					if (yn.equals("YELLOW")  || yn.equals("RED") ) {
						System.out.println("# Command : ����");
						System.out.println("# Query : " + insertQuery);
						
						stmt = conn.getGauceStatement(insertQuery);
						
						stmt.setGauceDataRow(rows[i]);
						
						stmt.setString(iCnt++, sLoginSid);			// ����� SID
						stmt.bindColumn(iCnt++, colNm_ProgramId);	// ���α׷� ID
						stmt.setString(iCnt++, "Y"); 				// 
						// **** ��Ű ***** //
						stmt.setString(iCnt++, iParamEmpno);		// ������ ��� 
						stmt.setString(iCnt++, iParamIp);			// ������ ip
					
						stmt.executeUpdate();
						
						stmt.close();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
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
