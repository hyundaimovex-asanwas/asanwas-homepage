package sales.menu.rm;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

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


public class Rm210B_BACK20090513 extends HttpServlet {
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
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		//System.out.printlnprintMsg("############################################## ","Command",this);
		
		// �׻� �� 
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {
			init(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// ����, ����, ���� 
			if (dsNum == 1) {
				apply1(req, res);
			} else if (dsNum == 2) {
			}
		} 
	}
	
	/*****************************************************************************
	 * Gauce Object ����
	 * Select �� �� Project Name , Project Id�� ��ȸ�Ѵ�
	 * ������ �ε��ÿ� �ʱ�ȭ �۾��̴� 
	 *****************************************************************************/
	public void init(HttpServletRequest req, HttpServletResponse res)  throws ServletException {

		//StringUtil.printMsg("# Command","����ȸ",this);
		
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
		GauceDataSet ds2 = null;
		GauceDataSet ds3 = null;		
		
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
			ds2 = new GauceDataSet(); 
			ds3 = new GauceDataSet(); 			
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));		// ������ڵ�			
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds2);
					
					// ������Ʈ���� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	saup_sid, " 
							+ "\n\t" + "	saup_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY200 " 
							+ "\n\t" + "ORDER BY saup_sid ";
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("saup_sid", GauceDataColumn.TB_STRING, 10));
					ds2.addDataColumn(new GauceDataColumn("saup_nm", GauceDataColumn.TB_STRING, 20));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
				
					stmt.executeQuery(ds2); // DataSet set
					
					//StringUtil.printMsg("# Query",query,this);
					//StringUtil.printMsg("# ResultSet Total Count",ds2.getDataRowCnt(),this);					
			
					stmt.close();
					break;
					
				case 2 :
					int sCnt2 = 1;					
					gceRes.enableFirstRow(ds3);
					
					// ������Ʈ���� ���� 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	upjang_sid, " 
							+ "\n\t" + "	upjang_nm " 
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TRM010 " 
							+ "\n\t" + "WHERE upjang_type='10' "; 
				
					if (!"".equals(sSaupSid)) {
						whereQuery += ""
								   + "\n\t" + " AND saup_sid =? ";
						}
					query += whereQuery;
					query += "\n\t" + " ORDER BY  upjang_sid ";	
					
		
					 /**********************************************************************************
					 * DataSet �ʱ�ȭ 
					 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
					 **********************************************************************************/					
					ds3.addDataColumn(new GauceDataColumn("upjang_sid", GauceDataColumn.TB_STRING, 10));
					ds3.addDataColumn(new GauceDataColumn("upjang_nm", GauceDataColumn.TB_STRING, 30));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
				
					if (!"".equals(sSaupSid)) {
						stmt.setString(sCnt2++, sSaupSid);
					}
					
					stmt.executeQuery(ds3); // DataSet set
					
					//StringUtil.printMsg("# Query",query,this);
					//StringUtil.printMsg("# ResultSet Total Count",ds3.getDataRowCnt(),this);	
				
					stmt.close();
					break;					
			
			}
			 ds2.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�.			
			 ds3.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�. 
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
		
		//StringUtil.printMsg("# Command","��ȸ",this);
		
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
			ds1 = new GauceDataSet(); // Dataset TSY410
		
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// �˻��� ����
			String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));		// �����
			String sUpjangSid	 = HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));		// ������
//			 dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			//System.out.println("# DsType : " + dsType);
			
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
 					query   += "" 		
						+ "\n\t" + "SELECT " 	
						+ "\n\t" + sSaupSid + "   saup_sid, "						
						+ "\n\t" + "  R1.upjang_sid, "                                                               
						+ "\n\t" + "  R1.upjang_nm, "                                                                
						+ "\n\t" + "  'F' AS USE_YN, "    
						+ "\n\t" + "  REPLACE(CHAR(SALES.FN_DATE(MAX(use_date)) + 1   DAY, ISO), '-', '') AS BGN_DATE, "  
						+ "\n\t" + "  REPLACE(CHAR(SALES.FN_DATE(MAX(use_date)) + 365 DAY, ISO), '-', '') AS END_DATE  " 
						+ "\n\t" + "FROM SALES.TRM010 R1 LEFT OUTER JOIN    "
						+ "\n\t" + "   SALES.TRM100 R2  "
						+ "\n\t" + "	ON R2.upjang_sid   =  R1.upjang_sid "
						+ "\n\t" + "WHERE R1.use_yn='Y' "
						+ "\n\t" + "AND R1.upjang_type  =  '10' ";
								
					if (!"".equals(sSaupSid)) {
					whereQuery += ""
							   + "\n\t" + " AND R1.saup_sid =  " + sSaupSid;
					}
					
					if (!"".equals(sUpjangSid)) {
						whereQuery += ""
								   + "\n\t" + " AND R1.upjang_sid =  " + sUpjangSid;
						}					
					
					query += whereQuery;
					query += 	   "\n\t" + "GROUP BY R1.upjang_sid, R1.upjang_nm "
									+ "\n\t" + "ORDER BY R1.upjang_sid";

//					���̺� ���� init
//					������ �� ���̺��� �÷� ���¸� �ʱ�ȭ �Ѵ� 
					ds1.addDataColumn(new GauceDataColumn("saup_sid", 		GauceDataColumn.TB_STRING, 10));					
					ds1.addDataColumn(new GauceDataColumn("upjang_sid", 		GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("upjang_nm", 		GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("use_yn", 		GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("bgn_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("end_date", 		GauceDataColumn.TB_STRING, 26));
					
//					 ���� ����
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					//StringUtil.printMsg("# Query",query,this);
					//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);					
				
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

	// ������ �Է�, ����, ����
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
			
			GauceDataSet codeDs = gceReq.getGauceDataSet("INPUT_DATA");  
		
			/*
			 * Request Parameter
			 */
			
			String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));		// �����
			String sUpjangSid = HDUtil.nullCheckStr(req.getParameter("sUpjangSid"));		// ������		
			int colNm_UpjangSid 	= codeDs.indexOfColumn("upjang_sid");
			int colNm_UseYn 	= codeDs.indexOfColumn("use_yn");			
			int colNm_BgnDate 	= codeDs.indexOfColumn("bgn_date");	
			int colNm_EndDate 	= codeDs.indexOfColumn("end_date");	
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			deleteQuery += "\n" 		
				+ "\n\t" + "DELETE FROM SALES.TRM100 "
				+ "\n\t" + "WHERE saup_sid    =  ? "
				+ "\n\t" + "AND upjang_sid  =  ? "
				+ "\n\t" + "AND use_date   >=  ? "
				+ "\n\t" + "AND use_date   <=  ? "
				+ "\n";			
						
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				if ( rows[i].getString(3).equals("T") ) {		// ���� üũ��		
					// ����
					int dCnt = 1;
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						stmt = conn.getGauceStatement(deleteQuery);
						
						stmt.setGauceDataRow(rows[i]);
					
						stmt.setString(dCnt++, sSaupSid);
						stmt.bindColumn(dCnt++, colNm_UpjangSid);
						stmt.bindColumn(dCnt++, colNm_BgnDate);
						stmt.bindColumn(dCnt++, colNm_EndDate);				
						
						stmt.executeUpdate();
						stmt.close();
					}
					// �Է� 
					int iCnt = 1;
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						insertQuery = "";
						insertQuery += "\n" 		
							+ "\n\t" + "INSERT INTO SALES.TRM100		\n"
							+ "\n\t" + "(USE_DATE, SAUP_SID, UPJANG_SID, SEASON_CD, WEEK_YN, U_EMPNO, U_DATE, U_IP)		\n"
							+ "\n\t" + "SELECT S1.CALN_DATE                                                                       AS USE_DATE,    		\n"
							+ "\n\t" + rows[i].getString(0)	+"                                                                         AS SAUP_SID,    		\n"
							+ "\n\t" + rows[i].getString(1)	+"                                                                       AS UPJANG_SID,  		\n"
							+ "\n\t" + "(		\n"
							//+ "\n\t" + "SELECT (CASE WHEN DAYOFWEEK(SALES.FN_DATE(S1.CALN_DATE)) IN (6, 7) THEN		\n"
							+ "\n\t" + "SELECT S2.ITEM1  									   								\n"
							+ "\n\t" + "FROM SALES.TSY010 S2		\n"
							+ "\n\t" + "WHERE S1.CALN_DATE >= S2.DETAIL		\n"
							+ "\n\t" + "AND S1.CALN_DATE <= S2.DETAIL_NM		\n"
							+ "\n\t" + "AND S2.HEAD = 'RM007'		\n"							
							+ "\n\t" + ")                                                                                 AS SEASON_CD,		\n"   
							+ "\n\t" + "CASE WHEN DAYOFWEEK(SALES.FN_DATE(S1.CALN_DATE)) IN (6, 7) THEN 'Y' ELSE 'N' END   AS WEEK_YN,		\n"     
							+ "\n\t" + "'1'               AS U_EMPNO,		\n"
							+ "\n\t" + "CURRENT TIMESTAMP AS U_DATE,		\n"
							+ "\n\t" + "'1'               AS U_IP		\n"
							+ "\n\t" + "FROM SALES.TSY100 S1		\n"
							+ "\n\t" + "WHERE CALN_DATE  >=  ?		\n"
							+ "\n\t" + "AND CALN_DATE  <=  ?				\n";
						//�ָ���������� �������� 
						// �ָ����� ������ ���߽������� ����
						stmt = conn.getGauceStatement(insertQuery);
						
						stmt.setGauceDataRow(rows[i]);
						
						stmt.bindColumn(iCnt++, colNm_BgnDate);
						stmt.bindColumn(iCnt++, colNm_EndDate);					
						
						stmt.executeUpdate();
						stmt.close();
					}
				}
			}
			gceRes.flush();
			gceRes.commit();
			gceRes.close();			
		} catch (Exception e) {
			gceRes.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					stmt.close();
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			loader.restoreService(service);
		}
		
	}

}
