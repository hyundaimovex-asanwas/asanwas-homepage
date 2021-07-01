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

public class Sy320I extends HttpServlet {
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
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum")); //첫번째 그리드
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
		GauceDataSet ds1 = null;
		
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
			ds1 = new GauceDataSet(); // Dataset TCU020 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/

			// 검색시 조건
			String  s_ProjectId	= HDUtil.nullCheckStr(req.getParameter("s_ProjectId"));
			String	s_ProjectNm	= HDUtil.nullCheckStr(req.getParameter("s_ProjectNm"));
			String  s_TeamRole	= HDUtil.nullCheckStr(req.getParameter("s_TeamRole"));
			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					// 모든 사업장 얻어옴 
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	A.project_id project_id, " 
							+ "\n\t" + "	A.project_nm project_nm, " 
							+ "\n\t" + "	A.team_role team_role, " 
							+ "\n\t" + "	A.u_empno u_empno, "
							+ "\n\t" + "	char(A.u_date) u_date, " 
							+ "\n\t" + "	A.u_ip u_ip, "
							+ "\n\t" + "    B.detail_nm detail_nm "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY320 A " 
							+ "\n\t" + "LEFT JOIN SALES.TSY010 B "
							+ "\n\t" + "ON A.team_role=B.detail "
							+ "\n\t" + "WHERE 1=1 "
							+ "\n\t" + " AND B.head='SY001' ";

					if (!"".equals(s_ProjectId)) {
						whereQuery += ""
								   + "\n\t" + " AND A.project_id=? ";
					}					
					if (!"".equals(s_ProjectNm)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND A.project_nm LIKE ?";
					}
					if (!"".equals(s_TeamRole)) {
						whereQuery 	+= ""
									+ "\n\t" + " AND A.team_role=?";
					}

					query += whereQuery;
		
					 /**********************************************************************************
					 * DataSet 초기화 
					 * DataSet에 추가될 DB의 필드를 초기화 시킨다  
					 **********************************************************************************/					
					ds1.addDataColumn(new GauceDataColumn("project_id", 	GauceDataColumn.TB_STRING, 6));
					ds1.addDataColumn(new GauceDataColumn("project_nm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("team_role", 		GauceDataColumn.TB_STRING, 1));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 		GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 		GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 			GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("detail_nm", 		GauceDataColumn.TB_STRING, 50));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					if (!"".equals(s_ProjectId)) {	
						stmt.setString(sCnt1++, s_ProjectId);
					}					
					if (!"".equals(s_ProjectNm)) {
						stmt.setString(sCnt1++,  "%"+s_ProjectNm+"%");
					}
					if (!"".equals(s_TeamRole)) {	
						stmt.setString(sCnt1++, s_TeamRole);
					}					
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2:
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
			int colNm_ProjectId = inputDs1.indexOfColumn("project_id");	//
			int colNm_ProjectNm	= inputDs1.indexOfColumn("project_nm");	//
			int colNm_TeamRole  = inputDs1.indexOfColumn("team_role");	//
			GauceDataRow[] rows = inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY320 "
						+ "\n\t" + "	("
						+ "\n\t" + "		project_id, "
						+ "\n\t" + "		project_nm, "
						+ "\n\t" + "		team_role, "
						+ "\n\t" + "		u_empno, " 
						+ "\n\t" + "		u_date,  "
						+ "\n\t" + "		u_ip  "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?,?,?,?,CURRENT TIMESTAMP,? "
						+ "\n\t" + "       )"
						+ "\n";
		
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY320"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		project_nm = ?,"
						+ "\n\t" + "        team_role = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY320 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND project_id=?";	
			
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
					
					stmt.bindColumn(iCnt++, colNm_ProjectId);	// 
					stmt.bindColumn(iCnt++, colNm_ProjectNm);	// 
					stmt.bindColumn(iCnt++, colNm_TeamRole);	//
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
					System.out.println("# Value atname 	=");
					System.out.println("# Value atcode 	=");
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_ProjectNm);
					stmt.bindColumn(uCnt++, colNm_TeamRole);
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_ProjectId);	// 
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					System.out.println("# Value : head ");
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_ProjectId);
					
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
