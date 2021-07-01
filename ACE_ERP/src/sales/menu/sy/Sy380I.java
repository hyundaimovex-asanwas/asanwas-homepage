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
 * 변경사항
 * 2006-05-15 테이블명 변경
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
		try {
			service = loader.newService();
			context = service.getContext();
			log = context.getLogger();
			
			gceReq = service.getGauceRequest();
			gceRes = service.getGauceResponse();
			
			// Database Connection
			conn = service.getDBConnection();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset 프로그램 전체 목록
			ds2 = new GauceDataSet(); // Dataset 사용자 사용가능한 프로그램 목록
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					
					// 프로그램 목록을 구함  
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("colors",			GauceDataColumn.TB_STRING, 10));			
//					 쿼리 실행
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
	
					// 사용자가 사용하는 프로그램 목록을 구함
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
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds2.addDataColumn(new GauceDataColumn("program_id", 	GauceDataColumn.TB_STRING, 6));
					ds2.addDataColumn(new GauceDataColumn("program_nm", 	GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("colors",			GauceDataColumn.TB_STRING, 10));	
					
//					 쿼리 실행
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
	 * TSY380 모두 지우기 
	 */
	// 삭제
	public void apply1(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("삭제");
		
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
			
			// 검색시 조건
			String 	sProjectId	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE  FROM SALES.TSY380 WHERE login_sid=?";
			
			// Database Connection
			conn = service.getDBConnection();
			
			// Grid 첫번째 
			int dCnt = 1;
			stmt = conn.getGauceStatement(deleteQuery);
		
			stmt.setString(dCnt++, sProjectId);		// 프로젝트 Id 
			
			stmt.executeUpdate();
			stmt.close();
			
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
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 전체 프로그램 
	 */
	// 입력 Black 값만 상태 N로 
	public void apply2(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("DS1 입력");
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
				String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
				
				/*
				 * Desc 	 : 메뉴 등록 
				 * Parameter : project_id = 프로젝트 ID, menu_nm = 메뉴명, menu_id = 메뉴 ID
				 * 			 : 사원번호, IP는 쿠키 사용, 수정일은 Current Timestamp로 처리
				 */ 
				int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// 프로그래ID
				int colNm_Color 		= inputDs1.indexOfColumn("colors");	// 상태값 색 
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
				
				// Grid 첫번째 
				for(int i = 0; i < rows.length; i++) {
					// 입력 
					int iCnt = 1;
					
					String yn = "" + rows[i].getColumnValue(colNm_Color);

					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT ) {
						if (yn.equals("BLACK") || yn.equals("BLUE")) {
							System.out.println("# Command : 저장");
							System.out.println("# Query : " + insertQuery);
							
							stmt = conn.getGauceStatement(insertQuery);
							
							stmt.setGauceDataRow(rows[i]);
							
							stmt.setString(iCnt++, sLoginSid);			// 사용자 SID
							stmt.bindColumn(iCnt++, colNm_ProgramId);	// 프로그램 ID
							stmt.setString(iCnt++, "N"); 				// 
							// **** 쿠키 ***** //
							stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
							stmt.setString(iCnt++, iParamIp);			// 수정자 ip
						
							stmt.executeUpdate();
							
							stmt.close();
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
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
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 사용자 사용 가능 프로그램 
	 */
	// 입력 yellow 값만 상태 Y로 
	public void apply3(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("DS2 입력");
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
				 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
				 **/
				String iParamEmpno = "tGeryon";
				String iParamIp = "100.200.1.130(Geryon)".substring(0,13);
				
				// 검색시 조건
				String 	sLoginSid	= HDUtil.nullCheckStr(req.getParameter("sLoginSid"));
				
				/*
				 * Desc 	 : 메뉴 등록 
				 * Parameter : project_id = 프로젝트 ID, menu_nm = 메뉴명, menu_id = 메뉴 ID
				 * 			 : 사원번호, IP는 쿠키 사용, 수정일은 Current Timestamp로 처리
				 */ 
				int colNm_ProgramId		= inputDs1.indexOfColumn("program_id");		// 프로그래명 명
				int colNm_Color 		= inputDs1.indexOfColumn("colors");	// 상태값 색 
				
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
				
				// Grid 첫번째 
				for(int i = 0; i < rows.length; i++) {
					// 입력 
					int iCnt = 1;
					
					String yn = "" + rows[i].getColumnValue(colNm_Color);

					if (yn.equals("YELLOW")  || yn.equals("RED") ) {
						System.out.println("# Command : 저장");
						System.out.println("# Query : " + insertQuery);
						
						stmt = conn.getGauceStatement(insertQuery);
						
						stmt.setGauceDataRow(rows[i]);
						
						stmt.setString(iCnt++, sLoginSid);			// 사용자 SID
						stmt.bindColumn(iCnt++, colNm_ProgramId);	// 프로그램 ID
						stmt.setString(iCnt++, "Y"); 				// 
						// **** 쿠키 ***** //
						stmt.setString(iCnt++, iParamEmpno);		// 수정자 사번 
						stmt.setString(iCnt++, iParamIp);			// 수정자 ip
					
						stmt.executeUpdate();
						
						stmt.close();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
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
