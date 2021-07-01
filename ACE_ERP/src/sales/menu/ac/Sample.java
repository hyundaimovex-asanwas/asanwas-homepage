package sales.menu.ac;


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

public class Sample extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		command(req, res);
	}
	
	public void command(HttpServletRequest req, HttpServletResponse res) throws ServletException {
		/*
		 * Parameter : proType (업무 구분 파라미터)
		 */
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  업무구분 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// 초기화
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// 적용 (저장, 삭제, 수정) 
			if (dsNum == 1) {				// 그리드 첫번째
				apply1(req, res);
			} else if (dsNum == 2) {		// 그리드 두번째
				apply2(req, res);
			}
		} 
	}

	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		System.out.println("# Command : 조회");
		
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
		
		String query = "";			// SELECT절  변수 
		String whereQuery =  "";	// WHERE절  변수 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TSY240 
			ds2 = new GauceDataSet(); // Dataset TRM010
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String  s_Head		= HDUtil.nullCheckStr(req.getParameter("s_Head"));
			String	s_HeadName 	= HDUtil.nullCheckStr(req.getParameter("s_HeadName"));
			String  s_Detail	= HDUtil.nullCheckStr(req.getParameter("s_Detail"));
			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	head, " 
							+ "\n\t" + "	head_name, " 
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	u_date, " 
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY160 " 
							+ "\n\t" + "WHERE 1=1 ";

					if (!"".equals(s_Head)) {
						whereQuery += ""
								   + "\n\t" + " AND head=? ";
								 
					}
					
					if (!"".equals(s_HeadName)) {
					whereQuery 	+= ""
								+ "\n\t" + " LIKE ?";
					}
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("head", 			GauceDataColumn.TB_STRING, 16));
					ds1.addDataColumn(new GauceDataColumn("head_name", 		GauceDataColumn.TB_STRING, 16));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 8));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 15));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(s_Head)) {	
						stmt.setString(sCnt1++, s_Head);
					}
					
					if (!"".equals(s_HeadName)) {
						stmt.setString(sCnt1++, " %" + s_HeadName + "% ");
					}
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2:
					int sCnt2 = 1;
					
					System.out.println("----------------------->> " + HDUtil.nullCheckStr(req.getParameter("s_Head")));
					
					gceRes.enableFirstRow(ds2);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	head, " 
							+ "\n\t" + "	detail, " 
							+ "\n\t" + "	detail_name, " 
							+ "\n\t" + "	item1, " 
							+ "\n\t" + "	item2, "
							
							+ "\n\t" + "	item3, "
							+ "\n\t" + "	item4, "
							+ "\n\t" + "	item5, "
							+ "\n\t" + "	item6, "
							+ "\n\t" + "	item7, "
							
							+ "\n\t" + "	item8, "
							+ "\n\t" + "	item9, "
							+ "\n\t" + "	item10, "
							+ "\n\t" + "	item11, "
							+ "\n\t" + "	item12, "
							
							+ "\n\t" + "	item13, "
							+ "\n\t" + "	item14, "
							+ "\n\t" + "	item15, "
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	u_date, " 
							
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY161 " 
							+ "\n\t" + "WHERE 1=1 ";

					if (!"".equals(s_Head)) {
						whereQuery += ""
								   + "\n\t" + " AND head=?";
					}
					
					if (!"".equals(s_Detail)) {
					whereQuery += ""
							   + "\n\t" + " AND detail=?";
					}
					
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("head", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("detail", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("detail_name", 	GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item1", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item2", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item3", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item4", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item5", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item6", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item7", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item8", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item9", 			GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item10", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item11", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item12", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item13", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item14", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("item15", 		GauceDataColumn.TB_STRING, 16));
					ds2.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 8));
					ds2.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds2.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 15));
					
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(s_Head)) {	
						stmt.setString(sCnt2++, s_Head);
					}
					if (!"".equals(s_Detail)) {	
						stmt.setString(sCnt2++, s_Detail);		
					}

					

					stmt.executeQuery(ds2); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
				
					stmt.close();
					
					break;
	
			}
			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 ds2.flush();
			 gceRes.commit();
			 gceRes.close();
			  
		
		}catch (Exception e) {
			e.printStackTrace();
			// Error Log 처리 요망 (log4j 사용여부)
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
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// 입력, 수정, 삭제
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
//			int iParamSaupSid = HDUtil.convertNum(req.getParameter("saup_sid"));		// 사업소 SID
//			int iParamUpjangSid = HDUtil.convertNum(req.getParameter("upjang_sid"));	// 영업장 SID
			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			String iParamEmpno = "tGeryon";
			String iParamIp = "100.200.1.130(Geryon)".substring(0,13);
			
			// Grid 첫번째 
			int colNm_Head 		= inputDs1.indexOfColumn("head");			// 분류
			int colNm_HeadName 	= inputDs1.indexOfColumn("head_name");	// 분류코드 
			GauceDataRow[] rows = inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY160 "
						+ "\n\t" + "	("
						+ "\n\t" + "		head, "
						+ "\n\t" + "		head_name, " 
						+ "\n\t" + "		u_empno, " 
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?,?,CURRENT TIMESTAMP,? "
						+ "\n\t" + "       )"
						+ "\n";
		
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY160"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		head_name = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND head=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY160 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND head=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			// Grid 첫번째 
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					System.out.println("# Value Head =" + rows[i].getColumnValue(colNm_Head));
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_HeadName));
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_Head);		// 주석 xxxx
					stmt.bindColumn(iCnt++, colNm_HeadName);	// 
					// **** 쿠키 ***** //
					stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
					stmt.setString(iCnt++, iParamIp);			// 수정자 ip
				
					stmt.executeUpdate();
					
					stmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					System.out.println("# Command : 수정");
					System.out.println("# Query : " + updateQuery);
					System.out.println("# Value atname 	="	 + rows[i].getColumnValue(colNm_Head));
					System.out.println("# Value atcode 	="	 + rows[i].getColumnValue(colNm_HeadName));
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_Head);
					stmt.bindColumn(uCnt++, colNm_HeadName);
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					System.out.println("# Value : head " + rows[i].getColumnValue(colNm_Head));
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_Head);
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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
		
		String ttttdd[] = new String[]{"일","월","화","수","목","금","토"};
		
		System.out.println("\n\n");
	}
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 2
	 * 
	 */	
	public void apply2(HttpServletRequest req, HttpServletResponse res) {
		
		ServiceLoader loader = new ServiceLoader(req, res); 	// Service Loader
		GauceService service = null;
		GauceContext context = null;
		Logger log = null; 										// Log 

		GauceRequest gceReq = null; 							// Request
		GauceResponse gceRes = null; 							// Response

		/*  
		 * DataBase
		 */
		GauceDBConnection conn = null; 						// Database Connection
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
			
//			int iParamSaupSid = HDUtil.convertNum(req.getParameter("saup_sid"));		// 사업소 SID
//			int iParamUpjangSid = HDUtil.convertNum(req.getParameter("upjang_sid"));	// 영업장 SID
			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			String iParamEmpno = "tGeryon";
			String iParamIp = "100.200.1.130(Geryon)".substring(0,13);
			
			// Grid 첫번째 
			int colNm_Head 			= inputDs1.indexOfColumn("head");			//  
			int colNm_Detail 		= inputDs1.indexOfColumn("detail");			//   
			int colNm_DetailName 	= inputDs1.indexOfColumn("detail_name");	//   
			int colNm_Item1 		= inputDs1.indexOfColumn("item1");			//  
			int colNm_Item2 		= inputDs1.indexOfColumn("item2");			//  
			int colNm_Item3 		= inputDs1.indexOfColumn("item3");			//   
			int colNm_Item4 		= inputDs1.indexOfColumn("item4");			//   
			int colNm_Item5 		= inputDs1.indexOfColumn("item5");			//   
			int colNm_Item6			= inputDs1.indexOfColumn("item6");			//   
			int colNm_Item7 		= inputDs1.indexOfColumn("item7");			//   
			int colNm_Item8 		= inputDs1.indexOfColumn("item8");			//   
			int colNm_Item9 		= inputDs1.indexOfColumn("item9");			//   
			int colNm_Item10 		= inputDs1.indexOfColumn("item10");			//   
			int colNm_Item11		= inputDs1.indexOfColumn("item11");			//   
			int colNm_Item12 		= inputDs1.indexOfColumn("item12");			//   
			int colNm_Item13 		= inputDs1.indexOfColumn("item13");			//   
			int colNm_Item14 		= inputDs1.indexOfColumn("item14");			//   
			int colNm_Item15 		= inputDs1.indexOfColumn("item15");			//   
			
			GauceDataRow[] rows = inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY161 "
						+ "\n\t" + "	("
						+ "\n\t" + "		head, "
						+ "\n\t" + "		detail, " 
						+ "\n\t" + "		detail_name, " 
						+ "\n\t" + "		item1,  "
						+ "\n\t" + "		item2,  "

						+ "\n\t" + "		item3, "
						+ "\n\t" + "		item4, " 
						+ "\n\t" + "		item5, " 
						+ "\n\t" + "		item6,  "
						+ "\n\t" + "		item7,  "
						
						+ "\n\t" + "		item8, "
						+ "\n\t" + "		item9, " 
						+ "\n\t" + "		item10, " 
						+ "\n\t" + "		item11,  "
						+ "\n\t" + "		item12,  "
						
						+ "\n\t" + "		item13, "
						+ "\n\t" + "		item14, " 
						+ "\n\t" + "		item15, "
						+ "\n\t" + "		u_empno, "
						+ "\n\t" + "		u_date,  "
						
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ?, ?, ?, "
						+ "\n\t" + "    		?, ?, ?, ?, ?, "
						+ "\n\t" + "    		?, ?, ?, ?, ?, "
						+ "\n\t" + "    		?, ?, ?, ?, CURRENT TIMESTAMP, "
						+ "\n\t" + "    		? "
						+ "\n\t" + "       )"
						+ "\n";
			
		
						 
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY161"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		detail_name = ?,"
						+ "\n\t" + "		item1 = ?,"
						+ "\n\t" + "		item2 = ?,"
						+ "\n\t" + "		item3 = ?,"
						
						+ "\n\t" + "		item4 = ?,"
						+ "\n\t" + "		item5 = ?,"
						+ "\n\t" + "		item6 = ?,"
						+ "\n\t" + "		item7 = ?,"
						+ "\n\t" + "		item8 = ?,"
						
						+ "\n\t" + "		item9 = ?,"
						+ "\n\t" + "		item10 = ?,"
						+ "\n\t" + "		item11 = ?,"
						+ "\n\t" + "		item12 = ?,"
						+ "\n\t" + "		item13 = ?,"
						
						+ "\n\t" + "		item14 = ?,"
						+ "\n\t" + "		item15 = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND head=? AND detail=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY161 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND head=? AND detail=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			// Grid 두번째
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					System.out.println("# Value Head =" + rows[i].getColumnValue(colNm_Head));
					System.out.println("# Value HeadName =" + rows[i].getColumnValue(colNm_Detail));
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_Head);		// HEAD
					stmt.bindColumn(iCnt++, colNm_Detail);		// DEATIL
					stmt.bindColumn(iCnt++, colNm_DetailName);	// DETAIL NAME
					stmt.bindColumn(iCnt++, colNm_Item1);		//
					stmt.bindColumn(iCnt++, colNm_Item2);		//
					
					stmt.bindColumn(iCnt++, colNm_Item3);		//
					stmt.bindColumn(iCnt++, colNm_Item4);		//
					stmt.bindColumn(iCnt++, colNm_Item5);		//
					stmt.bindColumn(iCnt++, colNm_Item6);		//
					stmt.bindColumn(iCnt++, colNm_Item7);		//
					
					stmt.bindColumn(iCnt++, colNm_Item8);		//
					stmt.bindColumn(iCnt++, colNm_Item9);		//
					stmt.bindColumn(iCnt++, colNm_Item10);		//
					stmt.bindColumn(iCnt++, colNm_Item11);		//
					stmt.bindColumn(iCnt++, colNm_Item12);		//

					stmt.bindColumn(iCnt++, colNm_Item13);		//
					stmt.bindColumn(iCnt++, colNm_Item14);		//
					stmt.bindColumn(iCnt++, colNm_Item15);		//
					
					// **** 쿠키 ***** //
					stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
					stmt.setString(iCnt++, iParamIp);			// 수정자 ip
				
					stmt.executeUpdate();
					
					stmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					System.out.println("# Command : 수정");
					System.out.println("# Query : " + updateQuery);
					System.out.println("# Value head 	="	 + rows[i].getColumnValue(colNm_Head));
					System.out.println("# Value detail 	="	 + rows[i].getColumnValue(colNm_Detail));
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_DetailName);	//
					stmt.bindColumn(uCnt++, colNm_Item1);		//
					stmt.bindColumn(uCnt++, colNm_Item2);		//
					stmt.bindColumn(uCnt++, colNm_Item3);		//
					stmt.bindColumn(uCnt++, colNm_Item4);		//
					
					stmt.bindColumn(uCnt++, colNm_Item5);		//
					stmt.bindColumn(uCnt++, colNm_Item6);		//
					stmt.bindColumn(uCnt++, colNm_Item7);		//
					stmt.bindColumn(uCnt++, colNm_Item8);		//
					stmt.bindColumn(uCnt++, colNm_Item9);		//

					stmt.bindColumn(uCnt++, colNm_Item10);		//
					stmt.bindColumn(uCnt++, colNm_Item11);		//
					stmt.bindColumn(uCnt++, colNm_Item12);		//
					stmt.bindColumn(uCnt++, colNm_Item13);		//
					stmt.bindColumn(uCnt++, colNm_Item14);		//

					stmt.bindColumn(uCnt++, colNm_Item15);		//
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_Head);		// 주석 xxxx
					stmt.bindColumn(uCnt++, colNm_Detail);		
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					System.out.println("# Value : head " + rows[i].getColumnValue(colNm_Head));
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_Head);
					stmt.bindColumn(dCnt++, colNm_Detail);
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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
