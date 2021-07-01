package sales.menu.rm;

import sales.common.SuperServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDCookieManager;
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


public class Rm410I_BACK20140106 extends HttpServlet {
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
		//StringUtil.printMsg("##############################################","RM410I",this);
		
		// �׻� �� 
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {
			init(req, res);			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// ��ȸ
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// ����, ����, ���� 
			if (dsNum == 1) {
				apply(req, res);
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
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP���� ������ �ʿ��� Request�� �ִ� �Ķ���͸� �����Ѵ�  
			 **********************************************************************************/
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			String sSaupSid = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));		// ������ڵ�
			String sHead = HDUtil.nullCheckStr(req.getParameter("sHead"));		// Head			
			String sDetail = HDUtil.nullCheckStr(req.getParameter("sDetail"));		// Detail	
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;					
					gceRes.enableFirstRow(ds2);
					
					query   += "" 		
						+ "\n\t" + "SELECT 0 saup_sid, '' saup_nm FROM SYSIBM.SYSDUMMY1 	"
						+ "\n\t" + "UNION ALL	"
						+ "\n\t" + "SELECT " 									
						+ "\n\t" + "	saup_sid, " 
						+ "\n\t" + "	saup_nm " 
						+ "\n\t" + "FROM "
						+ "\n\t" + "	SALES.TSY200 "; 
				
				 /**********************************************************************************
				 * DataSet �ʱ�ȭ 
				 * DataSet�� �߰��� DB�� �ʵ带 �ʱ�ȭ ��Ų��  
				 **********************************************************************************/					
				ds2.addDataColumn(new GauceDataColumn("saup_sid",		GauceDataColumn.TB_INT, 10));
				ds2.addDataColumn(new GauceDataColumn("saup_nm",		GauceDataColumn.TB_STRING, 20));

				// ���� ����
				stmt = conn.getGauceStatement(query); 
				
				if (!"".equals(sDetail)) {	
					stmt.setString(sCnt1++, sDetail);
				}	
				stmt.executeQuery(ds2); // DataSet set

				//StringUtil.printMsg("# Query",query,this);
				//StringUtil.printMsg("# ResultSet Total Count ",ds2.getDataRowCnt(),this);				
		
				stmt.close();
				break;
				
			}
			 ds2.flush(); // ���� GauceDataSet�� ����Ǿ� ������ ���� Component�� �۽ŵ��� ���� GauceDataRow�� Component�� �����Ѵ�.
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
			ds1 = new GauceDataSet(); 
		
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// �˻��� ����
			String sGoodsSid = HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));				// �����
			String sGoodsCd	 = HDUtil.nullCheckStr(req.getParameter("sGoodsCd"));				// ������
			String sGoodsNm	 = HDUtil.nullCheckStr(req.getParameter("sGoodsNm"));				// ��������
			String sUseYn	 = HDUtil.nullCheckStr(req.getParameter("sUseYn"));					// �������
			String sSaupSid	 = HDUtil.nullCheckStr(req.getParameter("sSaupSid"));					// �������
//			 dataset ���� param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
 					query   += ""  					
 						+ "\n\t" + "SELECT "
 						+ "\n\t" + "			goods_sid, " 
 						+ "\n\t" + "			goods_cd, "
 						+ "\n\t" + "			goods_nm, "
 						+ "\n\t" + "			eng_nm, "
 						+ "\n\t" + "			short_nm, " 						
 						+ "\n\t" + "			course, "     
 						+ "\n\t" + "			nights, "
 						+ "\n\t" + "			days, "
 						+ "\n\t" + "			saup_sid, " 						
 						+ "\n\t" + "			theme_cd, "
 						+ "\n\t" + "			display_seq, "
 						+ "\n\t" + "			(CASE WHEN use_yn = 'Y' THEN 'T' ELSE 'F' END) AS use_yn "
 						+ "\n\t" + "FROM SALES.TRM200 A "
 						+ "\n\t" + "WHERE 1=1";
								
					if (!"".equals(sGoodsSid)) {
						whereQuery += ""
							   + "\n\t" + " AND goods_sid = '" + sGoodsSid + "'";
					}
					if (!"".equals(sSaupSid)) {
										whereQuery += ""
											   + "\n\t" + " AND saup_sid = '" + sSaupSid + "'";
									}
					
					if (!"".equals(sUseYn)) {
						whereQuery += ""
							   + "\n\t" + " AND use_yn = '" + sUseYn + "'";
					}
 					
					query += whereQuery
									+ "\n\t" + "ORDER BY goods_cd "; 

//					���̺� ���� init
//					������ �� ���̺��� �÷� ���¸� �ʱ�ȭ �Ѵ� 
					ds1.addDataColumn(new GauceDataColumn("goods_sid",      GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("goods_cd",       GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("goods_nm",       GauceDataColumn.TB_STRING, 40));
					ds1.addDataColumn(new GauceDataColumn("eng_nm",         GauceDataColumn.TB_STRING, 40));
					ds1.addDataColumn(new GauceDataColumn("short_nm",       GauceDataColumn.TB_STRING, 12));
					ds1.addDataColumn(new GauceDataColumn("course",         GauceDataColumn.TB_STRING, 300));
					ds1.addDataColumn(new GauceDataColumn("nights",         GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("days",   		GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("saup_sid",       GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("theme_cd",       GauceDataColumn.TB_STRING, 2));
					ds1.addDataColumn(new GauceDataColumn("display_seq",    GauceDataColumn.TB_NUMBER));
					ds1.addDataColumn(new GauceDataColumn("use_yn",         GauceDataColumn.TB_STRING, 1));

					//StringUtil.printMsg("query",query,this);
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
	public void apply(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 				// Log 

		GauceRequest gceReq = null; 	// Request
		GauceResponse gceRes = null; 	// Response

		/* DataBase */
		GauceDBConnection conn = null; 	// Database Connection
		GauceStatement stmt = null;
		

		HDCookieManager  hdCookie = new HDCookieManager(req, res);
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
			int colNm_GoodsSid 	= codeDs.indexOfColumn("goods_sid");	
			int colNm_GoodsCd 	= codeDs.indexOfColumn("goods_cd");	
			int colNm_GoodsNm 	= codeDs.indexOfColumn("goods_nm");
			int colNm_EngNm 	= codeDs.indexOfColumn("eng_nm");
			int colNm_ShortNm 	= codeDs.indexOfColumn("short_nm");			
			int colNm_Course 	= codeDs.indexOfColumn("course");
			int colNm_Nights 	= codeDs.indexOfColumn("nights");
			int colNm_Days 		= codeDs.indexOfColumn("days");
			int colNm_SaupSid 	= codeDs.indexOfColumn("saup_sid");			
			int colNm_ThemeCd 	= codeDs.indexOfColumn("theme_cd");
			int colNm_DisplaySeq = codeDs.indexOfColumn("display_seq");
			int colNm_UseYn 	 = codeDs.indexOfColumn("use_yn");
			int colNm_UEmpno 	 = codeDs.indexOfColumn("u_empno");
			int colNm_UIp 		 = codeDs.indexOfColumn("u_ip");			
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			insertQuery += "\n" 		
				+ "\n\t" + "INSERT INTO SALES.TRM200 "
				+ "\n\t" + "	("
				+ "\n\t" + "		goods_cd, " 
				+ "\n\t" + "		goods_nm, "
				+ "\n\t" + "		eng_nm,  "
				+ "\n\t" + "		short_nm,  "				
				+ "\n\t" + "		course,  "
				+ "\n\t" + "		nights,  "
				+ "\n\t" + "		days,  "
				+ "\n\t" + "		saup_sid,  "
				+ "\n\t" + "		theme_cd,  "
				+ "\n\t" + "		display_seq,  "
				+ "\n\t" + "		use_yn, "
				+ "\n\t" + "		u_empno, "
				+ "\n\t" + "		u_ip "				
				+ "\n\t" + "	)"
				+ "\n\t" + "VALUES ("
				+ "\n\t" + "    		?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? "
				+ "\n\t" + "       )"
				+ "\n";

			updateQuery += "\n" 		
				+ "\n\t" + "UPDATE SALES.TRM200"
				+ "\n\t" + "	SET"
				+ "\n\t" + "		goods_cd = ?, "
				+ "\n\t" + "		goods_nm = ?, "
				+ "\n\t" + "		eng_nm = ?, "
				+ "\n\t" + "		short_nm = ?, "				
				+ "\n\t" + "		course = ?, "
				+ "\n\t" + "		nights = ?, "
				+ "\n\t" + "		days = ?, "
				+ "\n\t" + "		saup_sid = ?, "	
				+ "\n\t" + "		theme_cd = ?, "				
				+ "\n\t" + "		display_seq = ?, "
				+ "\n\t" + "		use_yn = ?, "
				+ "\n\t" + "		u_empno = ?, "
				+ "\n\t" + "		u_date = current timestamp, "
				+ "\n\t" + "		u_ip = ? "				
				+ "\n\t" + "WHERE 1=1 "
				+ "\n\t" + "	AND goods_sid=?";
			
			deleteQuery += "\n" 		
				+ "\n\t" + "DELETE FROM SALES.TRM200 "
				+ "\n\t" + "WHERE goods_sid    =  ? "
				+ "\n";			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// �Է�
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					//StringUtil.printMsg("# Command","����",this);
					//StringUtil.printMsg("# Query",deleteQuery,this);					
					stmt = conn.getGauceStatement(insertQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_GoodsCd);
					stmt.bindColumn(iCnt++, colNm_GoodsNm);
					stmt.bindColumn(iCnt++, colNm_EngNm);
					stmt.bindColumn(iCnt++, colNm_ShortNm);					
					stmt.bindColumn(iCnt++, colNm_Course);
					stmt.bindColumn(iCnt++, colNm_Nights);
					stmt.bindColumn(iCnt++, colNm_Days);
					stmt.bindColumn(iCnt++, colNm_SaupSid);
					stmt.bindColumn(iCnt++, colNm_ThemeCd);
					stmt.bindColumn(iCnt++, colNm_DisplaySeq);
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						stmt.setString(iCnt++, "Y");
					else
						stmt.setString(iCnt++, "N");				
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);					

					stmt.executeUpdate();
					stmt.close();
				}
				// ����
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//StringUtil.printMsg("# Command","����",this);
					//StringUtil.printMsg("# Query",updateQuery,this);					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_GoodsCd);	
					stmt.bindColumn(uCnt++, colNm_GoodsNm);	
					stmt.bindColumn(uCnt++, colNm_EngNm);
					stmt.bindColumn(uCnt++, colNm_ShortNm);					
					stmt.bindColumn(uCnt++, colNm_Course);	
					stmt.bindColumn(uCnt++, colNm_Nights);
					stmt.bindColumn(uCnt++, colNm_Days);
					stmt.bindColumn(uCnt++, colNm_SaupSid);	
					stmt.bindColumn(uCnt++, colNm_ThemeCd);
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);
					//StringUtil.printMsg("��� ��??????",rows[i].getString(colNm_UseYn),this);	
					if ( rows[i].getString(colNm_UseYn).equals("T") ) 
						stmt.setString(uCnt++, "Y");
					else
						stmt.setString(uCnt++, "N");
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);							
					stmt.bindColumn(uCnt++, colNm_GoodsSid);					
					
					stmt.executeUpdate();
					stmt.close();
				}
				// ����
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					//StringUtil.printMsg("# Command","����",this);
					//StringUtil.printMsg("# Query",deleteQuery,this);
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(dCnt++, colNm_GoodsSid);	
					
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
