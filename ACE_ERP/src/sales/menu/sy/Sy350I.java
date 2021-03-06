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
 * @author 이병욱
 * 변경사항 	: 2005-05-15 
 *       	: 1. 파일명 변경 Cu050I.java → Sy350I.java변경 
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
		 * Parameter : proType (업무 구분 파라미터)
		 */
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		System.out.println("#################################### " + this.getClass() + " Message ####################################\n");
		
		/*
		 * DESC :  업무구분 
		 */
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {				// 초기화
			init(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {		// 적용 (저장, 삭제, 수정) 
			apply(req, res);
		} 
	}
	
	/*****************************************************************************
	 * Gauce Object 설정
	 * Select 에 들어갈 Project Name , Project Id를 조회한다
	 * 페이지 로딩시에 초기화 작업이다 
	 *****************************************************************************/
	public void init(HttpServletRequest req, HttpServletResponse res)  throws ServletException {

		System.out.println("# Command : 선조회");
		
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
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TCU020
			ds2 = new GauceDataSet(); // Dataset TCU040
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			String sProjectID = HDUtil.nullCheckStr(req.getParameter("sProjectId"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);
					
					// 모든 프로젝트 명을 얻어옴
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_id", GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("project_nm", GauceDataColumn.TB_STRING, 30));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
				
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2 :
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
					
					// 모든 프로젝트 명을 얻어옴
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("menu_id", GauceDataColumn.TB_STRING, 3));
					ds2.addDataColumn(new GauceDataColumn("menu_nm", GauceDataColumn.TB_STRING, 30));
					
//					 쿼리 실행
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
		
		String query = "";			// SELECT절  변수 
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset TCU050
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String 	sProjectId	= HDUtil.nullCheckStr(req.getParameter("sProjectId"));
			String  sMenuId		= HDUtil.nullCheckStr(req.getParameter("sMenuId"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					
					// 프로그램 목록을 구함  
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
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
					
					
					
					
//					 쿼리 실행
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
			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
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
			
			// 검색시 조건
		
			
			/*
			 * Desc 	 : 메뉴 등록 
			 * Parameter : project_id = 프로젝트 ID, menu_nm = 메뉴명, menu_id = 메뉴 ID
			 * 			 : 사원번호, IP는 쿠키 사용, 수정일은 Current Timestamp로 처리
			 */ 
			int colNm_ProjectId		= inputDs1.indexOfColumn("project_id");		//프로젝트 ID
			int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// 프로그래명 명
			int colNm_ProgramName	= inputDs1.indexOfColumn("program_nm");		// 프로그래명 명
			int colNm_DisplaySeq 	= inputDs1.indexOfColumn("display_seq");	// 화면표시순서
			int colNm_MenuId 		= inputDs1.indexOfColumn("menu_id");		// 메뉴ID
			
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
			
			// Grid 첫번째 
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_ProjectId);	// 프로젝트 Id
					stmt.bindColumn(iCnt++, colNm_MenuId);		// 메뉴 ID
					stmt.bindColumn(iCnt++, colNm_ProgramId);	// 프로그램 ID
					stmt.bindColumn(iCnt++, colNm_ProgramName); // 프로그램 명 
					stmt.bindColumn(iCnt++, colNm_DisplaySeq); // 화면표시순서
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
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_ProgramName);	// 프로그램 명
					stmt.bindColumn(uCnt++, colNm_DisplaySeq);	// 화면표시순서 
					stmt.setString(uCnt++, iParamEmpno);		// 수정자 사원번호
					stmt.setString(uCnt++, iParamIp);			// 수정자 IP
					
					stmt.bindColumn(uCnt++, colNm_ProjectId);	// 프로젝트 Id
					stmt.bindColumn(uCnt++, colNm_MenuId);		// 메뉴 ID
					stmt.bindColumn(uCnt++, colNm_ProgramId);	// 프로그램 ID
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_ProjectId);	// 프로젝트 Id
					stmt.bindColumn(dCnt++, colNm_MenuId);		// 메뉴 ID
					stmt.bindColumn(dCnt++, colNm_ProgramId);	// 프로그램 ID
					
				
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
				gceRes.write("javascript:alert('에러발생')");
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
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
