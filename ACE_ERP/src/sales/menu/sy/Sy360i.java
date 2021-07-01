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


public class Sy360i extends HttpServlet {
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
		// 업무 구분 파라미터
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {			// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			modify(req, res);
		} 
	}

	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res)  throws ServletException {
		
		System.out.println("# Command : 조회");
		
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
		GauceDataSet ds2 = null;
		
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
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); // Dataset 1번 
			ds2 = new GauceDataSet(); // Dataset 2번
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
//			 검색시 조건
			String s_Client_Nm		= HDUtil.nullCheckStr(req.getParameter("s_Client_Nm"));		// 분류코드
			String s_Login_Nm  		= HDUtil.nullCheckStr(req.getParameter("s_Login_Nm"));
			
			System.out.println("# Search Key CLIENT_NM : " + s_Client_Nm);
			System.out.println("# Search Key LOGIN_NM : " + s_Login_Nm);
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);

					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	c1.client_cd, "							
							+ "\n\t" + "	c1.client_nm, "
							+ "\n\t" + "	c2.branch_nm, "
							+ "\n\t" + "	s1.login_sid, "
							+ "\n\t" + "	s1.login_id, "
							+ "\n\t" + "	s1.login_nm "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY310 s1 JOIN"
							+ "\n\t" + "	SALES.TCU030 c1 JOIN"
							+ "\n\t" + "	SALES.TCU032 c2 "
							+ "\n\t" + "ON   c1.client_sid = s1.client_sid"
							+ "\n\t" + "ON   c2.client_sid = c1.client_sid"
							+ "\n\t" + "AND  c2.branch_cd  = s1.branch_cd"
							+ "\n\t" + "WHERE 1=1 "
							+ "\n";
					
					if (!s_Client_Nm.equals("")) {
						whereQuery += ""
								   + "\n\t" + " AND client_nm LIKE ?";
					}
					if (!s_Login_Nm.equals("")) {
						whereQuery += ""
								   + "\n\t" + " AND login_nm LIKE ?";
					}
						whereQuery	+= "";
						query += whereQuery;
//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("client_cd",	 	GauceDataColumn.TB_STRING, 5));
					ds1.addDataColumn(new GauceDataColumn("client_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("branch_nm", 		GauceDataColumn.TB_STRING, 20));
					ds1.addDataColumn(new GauceDataColumn("login_sid",	 	GauceDataColumn.TB_NUMBER, 10));
					ds1.addDataColumn(new GauceDataColumn("login_id", 		GauceDataColumn.TB_STRING, 10));
					ds1.addDataColumn(new GauceDataColumn("login_nm", 		GauceDataColumn.TB_STRING, 20));
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					if(!"".equals(s_Client_Nm)){
						stmt.setString(sCnt1++, "%" + s_Client_Nm + "%");
					}
					if(!"".equals(s_Login_Nm)){
						stmt.setString(sCnt1++, "%" + s_Login_Nm + "%");
					}
					stmt.executeQuery(ds1);	//DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
					
					stmt.close();
					break;

				case 2 :
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	s1.login_sid, "
							+ "\n\t" + "	s2.project_level, "
							+ "\n\t" + "	s2.project_level_nm, "
							+ "\n\t" + "	(CASE WHEN s1.project_level <> '' THEN 'T' "
							+ "\n\t" + " 		ELSE 'F' "
							+ "\n\t" + "	END) AS level_yn "
							+ "\n\t" + "FROM  SALES.TSY360 s1 RIGHT OUTER JOIN SALES.TSY330 s2"
							+ "\n\t" + "	ON s1.project_level = s2.project_level"
							+ "\n\t" + "WHERE 1=1";
					whereQuery += "\n\t" + " AND s1.login_sid = ?";
					
//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds2.addDataColumn(new GauceDataColumn("login_sid",	 			GauceDataColumn.TB_NUMBER, 10));
					ds2.addDataColumn(new GauceDataColumn("project_level", 			GauceDataColumn.TB_STRING, 3));
					ds2.addDataColumn(new GauceDataColumn("project_level_nm", 		GauceDataColumn.TB_STRING, 30));
					ds2.addDataColumn(new GauceDataColumn("level_yn", 				GauceDataColumn.TB_STRING, 1));
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
//					stmt.setString(sCnt2++, sParamProLe);
					stmt.executeQuery(ds2);	//DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
				
					break;
			}
			

			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
			 ds2.flush();
			 gceRes.commit();
			 gceRes.close();
			  
			 
		} catch (Exception e) {
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
	
	// 입력, 수정, 삭제
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
		
		String updateQuery1 = "";
		String updateQuery2 = "";
				
//		String sParamPwd1 = HDUtil.nullCheckStr(req.getParameter("searchKeyPwd1"));		//비밀번호 확인
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
			
			int colNm_Login_Sid			= inputDs1.indexOfColumn("login_sid");		// 로그인 SID
			int colNm_Project_Level		= inputDs1.indexOfColumn("project_level");			// 사용자 번호 
			GauceDataRow[] rows = inputDs1.getDataRows();

			updateQuery1+= "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY360 "
						+ "\n\t" + "	("
						+ "\n\t" + "		login_sid, " +
											"project_level, " +
											"u_empno, " +
											"u_date, " +
											"u_ip"
						+ "\n\t" + "	) "
						+ "\n\t" + " VALUES ("
						+ "\n\t" + "			?, ?, ?, CURRENT TIMESTAMP,? " 
						+ "\n\t" + "       )"
						+ "\n";

			System.out.println("# Query : " + updateQuery1);
			
			updateQuery2 += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY360 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n"		
						+ "\n\t" + "	AND login_sid=?";	
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + updateQuery1);

					stmt = conn.getGauceStatement(updateQuery1);
					
					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(iCnt++, colNm_Login_Sid);
					stmt.bindColumn(iCnt++, colNm_Project_Level);
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);
					
					stmt.executeUpdate();
					stmt.close();
				}
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제 TSY360");
					System.out.println("# Query : " + updateQuery2);
					
					stmt = conn.getGauceStatement(updateQuery2);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(dCnt, colNm_Login_Sid);
					
					stmt.executeUpdate();
					stmt.close();
				}
			}
			gceRes.flush();
			gceRes.commit();
			gceRes.close();

		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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

