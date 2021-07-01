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

public class Sy370I extends HttpServlet {
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
		 * Parameter : proType (업무 구분 파라미터)
		 */
		String proType = HDUtil.nullCheckStr(req.getParameter("proType")); //조회, 저장
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum")); //그리드 갯수
		System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  업무구분 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// 초기화
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// 적용 (저장, 삭제, 수정) 
			apply(req, res);
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
		GauceDataSet ds1 = null;//데이터셋1
		GauceDataSet ds2 = null;//데이터셋2
		GauceDataSet ds3 = null;//데이터셋3
		
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
			ds1 = new GauceDataSet(); // Dataset TCU030 
			ds2 = new GauceDataSet(); // Dataset TCU050
			ds3 = new GauceDataSet(); // Dataset TCU050+TCU120
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String  s_ProjectLevel	= HDUtil.nullCheckStr(req.getParameter("s_ProjectLevel"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));//읽기 데이터셋 갯수
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// 레벨 얻어옴 
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_level", 	GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("project_level_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					
					//쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
				break;
				case 2:
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
					
					// 모든 프로그램 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	s3.project_id project_id, " 
							+ "\n\t" + "	s3.menu_id menu_id, "
							+ "\n\t" + "	s3.program_id program_id, " 
							+ "\n\t" + "	s3.program_nm program_nm, " 
							+ "\n\t" + "	s3.display_seq display_seq, "
							+ "\n\t" + "	s3.u_empno u_empno, " 
							+ "\n\t" + "	char(s3.u_date) u_date, "
							+ "\n\t" + "	s3.u_ip u_ip " 
							+ "\n\t" + "FROM ( "
							+ "\n\t" + "	SELECT s1.program_id "
							+ "\n\t" + "	FROM ( "
							+ "\n\t" + "		SELECT program_id "	
							+ "\n\t" + "			FROM SALES.TSY350 "
							+ "\n\t" + "		EXCEPT "
							+ "\n\t" + "		SELECT program_id "
							+ "\n\t" + "			FROM SALES.TSY370 "
							+ "\n\t" + "		WHERE project_level = ? "
							+ "\n\t" + "	) s1 "
							+ "\n\t" + ") s2, "
							+ "\n\t" + "SALES.TSY350 s3 "
							+ "\n\t" + "WHERE s3.program_id = s2.program_id "
							+ "\n\t" + "ORDER BY s3.program_id ";							

					whereQuery += "";
		
					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("menu_id", 	GauceDataColumn.TB_STRING, 2));
					ds2.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("display_seq", 	GauceDataColumn.TB_DECIMAL, 3,0));
					ds2.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds2.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds2.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					
					//쿼리 실행
					stmt = conn.getGauceStatement(query); 

					stmt.setString(sCnt2++, s_ProjectLevel);
					
					stmt.executeQuery(ds2); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
				
					stmt.close();
				break;
				case 3 :
					int sCnt3 = 1;
					gceRes.enableFirstRow(ds3);
					
					// 현재 사용가능한 프로그램 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 
							+ "\n\t" + "    s1.project_level project_level, "
							+ "\n\t" + "    s2.project_id project_id, "
							+ "\n\t" + "    s2.menu_id menu_id, "
							+ "\n\t" + "    s2.program_id program_id, "
							+ "\n\t" + "	s2.program_nm program_nm, "
							+ "\n\t" + "    s2.display_seq display_seq, "
							+ "\n\t" + "    s2.u_empno u_empno, "
							+ "\n\t" + "    char(s2.u_date) u_date, "
							+ "\n\t" + "    s2.u_ip u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY370 s1, "
							+ "\n\t" + "	SALES.TSY350 s2 "
							+ "\n\t" + "WHERE s1.project_level = ? "
							+ "\n\t" + "AND s2.program_id = s1.program_id "
							+ "\n\t" + "ORDER BY s2.program_id ";

						whereQuery += "";

					query += whereQuery;

					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
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

					//쿼리 실행
					stmt = conn.getGauceStatement(query); 

					//if (!"".equals(s_ProjectLevel)) {	
						stmt.setString(sCnt3++, s_ProjectLevel);
					//}					
					
					stmt.executeQuery(ds3); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds3.getDataRowCnt());
				
					stmt.close();
				break;	
			}
			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 ds2.flush();
			 ds3.flush();
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
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
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
			
			// Grid 첫번째 
			///////////////////////////////////////////////////////////////////////

			int colNm_ProjectLevel = inputDs1.indexOfColumn("project_level");	//프로젝트레벨		
			int colNm_ProgramId = inputDs1.indexOfColumn("program_id");	//프로그램ID

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
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY370 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_level=?"
						+ "\n\t" + "	AND program_id=?";

			// Database Connection
			conn = service.getDBConnection();
			
			// Grid 첫번째 
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;

				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					System.out.println("# Value Head =");
					System.out.println("# Value HeadName =");
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_ProjectLevel);	//
					stmt.bindColumn(iCnt++, colNm_ProgramId);	//					
					// **** 쿠키 ***** //
					stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
					stmt.setString(iCnt++, iParamIp);			// 수정자 ip
			
					stmt.executeUpdate();
					
					stmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
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
