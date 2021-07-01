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


public class Sy240I extends HttpServlet {
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
		int dsNum = HDUtil.nullCheckNum(req.getParameter("dsNum"));
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		// 항상 콜 
		if (proType.equals(HDConstant.PROCESS_TYPE_INIT)) {
			
		} else if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {	// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			if (dsNum == 1) {
				apply1(req, res);
			} else if (dsNum == 2) {
				apply2(req, res);
			}
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
		GauceDataSet ds3 = null;
		
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
			ds1 = new GauceDataSet(); // Dataset TSY240 
			ds2 = new GauceDataSet(); // Dataset TSY241
			ds3 = new GauceDataSet(); // Dataset ACTCODE	
			
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sAtclsCd = HDUtil.nullCheckStr(req.getParameter("sAtclsCd"));		// 분류코드
			String sAtCode	 = HDUtil.nullCheckStr(req.getParameter("sAtCode"));
			System.out.println("# Search Key ATCLSCD : " + sAtclsCd);
			System.out.println("# Search Key ATCODE : " + sAtCode);
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			System.out.println("# DsType : " + dsType);
			
			
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					gceRes.enableFirstRow(ds1);
					
					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	atclscd, " 
							+ "\n\t" + "	atclsnm, " 
							+ "\n\t" + "	desc, " 
							+ "\n\t" + "	u_empno, " 
							+ "\n\t" + "	u_date, " 
							
							+ "\n\t" + "	u_ip "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY240 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n";
					
					if (!"".equals(sAtclsCd)) {
					whereQuery += ""
							   + "\n\t" + " AND atclscd=?";
					}
					
					query += whereQuery;

//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("atclscd", 	GauceDataColumn.TB_STRING, 2 ));
					ds1.addDataColumn(new GauceDataColumn("atclsnm", 	GauceDataColumn.TB_STRING, 30));
					ds1.addDataColumn(new GauceDataColumn("desc", 		GauceDataColumn.TB_STRING, 200));
					ds1.addDataColumn(new GauceDataColumn("u_empno", 	GauceDataColumn.TB_STRING, 7));
					ds1.addDataColumn(new GauceDataColumn("u_date", 	GauceDataColumn.TB_STRING, 26));
					ds1.addDataColumn(new GauceDataColumn("u_ip", 		GauceDataColumn.TB_STRING, 30));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					if (!"".equals(sAtclsCd)) {	
						stmt.setString(sCnt1++, sAtclsCd);		// 사업자 SID
					}

					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					stmt.close();
					break;
				case 2:
					int sCnt2 = 1;
					gceRes.enableFirstRow(ds2);

					query += ""
						+ "\n\t" + "SELECT 	A.atclscd, "
						+ "\n\t" + "		A.atclsno, "
						+ "\n\t" + "		A.atname, "
						+ "\n\t" + "		A.atcode, "
						+ "\n\t" + "		(SELECT B.atkornam FROM sales.actcode AS B WHERE 1=1 AND B.atcode = A.atcode) AS atkornam, "
						
						+ "\n\t" + "		A.atdecr, " 
						+ "\n\t" + "		A.desc, "
						+ "\n\t" + "		A.u_empno, "
						+ "\n\t" + "		A.u_date, "
						+ "\n\t" + "		A.u_ip "
						+ "\n\t" + "FROM"
						+ "\n\t" + "	sales.tsy241 as A "
						+ "\n\t" + "WHERE " 
						+ "\n\t" + "	A.ATCLSCD = ?" ;					
					
				
					// 테이블 정보 init
					ds2.addDataColumn(new GauceDataColumn("atclscd", 		GauceDataColumn.TB_STRING, 2));
					ds2.addDataColumn(new GauceDataColumn("atclsno",	 	GauceDataColumn.TB_STRING));
					ds2.addDataColumn(new GauceDataColumn("atname", 		GauceDataColumn.TB_STRING, 66));
					ds2.addDataColumn(new GauceDataColumn("atcode", 		GauceDataColumn.TB_STRING, 7));
					ds2.addDataColumn(new GauceDataColumn("atkornam", 		GauceDataColumn.TB_STRING, 66));
					ds2.addDataColumn(new GauceDataColumn("atdecr", 		GauceDataColumn.TB_STRING, 1));
					ds2.addDataColumn(new GauceDataColumn("desc", 			GauceDataColumn.TB_STRING, 100));
					ds2.addDataColumn(new GauceDataColumn("u_empno",		GauceDataColumn.TB_STRING, 7));
					ds2.addDataColumn(new GauceDataColumn("u_date",			GauceDataColumn.TB_STRING, 26));
					ds2.addDataColumn(new GauceDataColumn("u_ip",			GauceDataColumn.TB_STRING, 30));
					
					stmt = conn.getGauceStatement(query); // 쿼리 실행
					
					stmt.setString(sCnt2++, sAtclsCd);
					
					System.out.println("# Query : " + query);
					
					stmt.executeQuery(ds2); // DataSet set	
					System.out.println("# ResultSet Total Count : " + ds2.getDataRowCnt());
					
					break;
					
				case 3 :
					int pCnt1 = 1;
					gceRes.enableFirstRow(ds3);
					
					query   += "" 		
						+ "\n\t" + "SELECT " 									
						+ "\n\t" + "	atcode, " 
						+ "\n\t" + "	atkornam, "
						+ "\n\t" + "	atdiv "
						+ "\n\t" + "FROM "
						+ "\n\t" + "	SALES.ACTCODE " 
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";
					
					
					if (!"".equals(sAtCode)) {
						whereQuery += ""
								   + "\n\t" + " AND atcode LIKE ? OR atkornam LIKE ?";
						}
					
					query += whereQuery;
					
					System.out.println("# Query : " + query);
					ds3.addDataColumn(new GauceDataColumn("atcode", 	GauceDataColumn.TB_STRING, 7 ));
					ds3.addDataColumn(new GauceDataColumn("atkornam", 	GauceDataColumn.TB_STRING, 66));
					ds3.addDataColumn(new GauceDataColumn("atdiv", 		GauceDataColumn.TB_STRING, 10));
					
					stmt = conn.getGauceStatement(query);
					
					if (!"".equals(sAtCode)) {
						stmt.setString(pCnt1++, "%" + sAtCode + "%");
						stmt.setString(pCnt1++, "%" + sAtCode + "%");
					}
				
					stmt.executeQuery(ds3); // DataSet set	

					System.out.println("# ResultSet Total Count : " + ds3.getDataRowCnt());
					
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

	// 마트터 입력, 수정, 삭제
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
			
//			int iParamSaupSid = HDUtil.convertNum(req.getParameter("saup_sid"));		// 사업소 SID
//			int iParamUpjangSid = HDUtil.convertNum(req.getParameter("upjang_sid"));	// 영업장 SID
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
			
			int colNm_AtclsCd 	= codeDs.indexOfColumn("atclscd");	// 세부
			int colNm_AtclsNm 	= codeDs.indexOfColumn("atclsnm");	// 분류일년번호 
			int colNm_Desc 	= codeDs.indexOfColumn("desc");		// 세부적요명 
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY240 "
						+ "\n\t" + "	("
						+ "\n\t" + "		atclscd, "
						+ "\n\t" + "		atclsnm, "
						+ "\n\t" + "		desc, "
						+ "\n\t" + "		u_empno, "
						+ "\n\t" + "		u_date, "
						
						+ "\n\t" + "		u_ip " 
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ? ,?,CURRENT TIMESTAMP, "
						+ "\n\t" + "    		? "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY240"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		atclsnm = ?,"
						+ "\n\t" + "		desc = ?,"
						+ "\n\t" + "		u_empno = ?,"
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ?"
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND atclscd=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY240 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND atclscd=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(iCnt++, colNm_AtclsCd);	// 세부
					stmt.bindColumn(iCnt++, colNm_AtclsNm);	// 세부적요 명
					stmt.bindColumn(iCnt++, colNm_Desc); 	// 비고 
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);
				
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
					
					stmt.bindColumn(uCnt++, colNm_AtclsNm);
					stmt.bindColumn(uCnt++, colNm_Desc);
					stmt.setString(uCnt++, iParamEmpno);
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_AtclsCd);
					
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
				
					stmt.bindColumn(dCnt++, colNm_AtclsCd);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				gceRes.flush();
				gceRes.commit();
				gceRes.close();
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
	// 입력, 수정, 삭제
	public void apply2(HttpServletRequest req, HttpServletResponse res) {
		
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
			
//			int iParamSaupSid = HDUtil.convertNum(req.getParameter("saup_sid"));		// 사업소 SID
//			int iParamUpjangSid = HDUtil.convertNum(req.getParameter("upjang_sid"));	// 영업장 SID
			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			String iParamEmpno = "tGeryon";
			String iParamIp = "ComNm : geryon 100.200.1.130";
			
			int colNm_AtclsCd 	= codeDs.indexOfColumn("atclscd");	// 세부
			int colNm_AtclsNo 	= codeDs.indexOfColumn("atclsno");	// 분류일년번호 
			int colNm_AtName 	= codeDs.indexOfColumn("atname");	// 세부적요명 
			int colNm_AtCode 	= codeDs.indexOfColumn("atcode");	// 계정코드
			int colNm_AtDecr 	= codeDs.indexOfColumn("atdecr");	// 차/대
			int colNm_Desc 		= codeDs.indexOfColumn("desc"); 	// 비고
			
			GauceDataRow[] rows = codeDs.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY241 "
						+ "\n\t" + "	("
						+ "\n\t" + "		atclscd, atclsno, atname, atcode,  atdecr,  "
						+ "\n\t" + "		desc, u_empno, u_date, u_ip " 
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		?, ?, ? ,?,?, "
						+ "\n\t" + "    		?, ?, CURRENT TIMESTAMP, ? "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY241"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		atname = ?,"
						+ "\n\t" + "		atcode = ?,"
						+ "\n\t" + "		atdecr = ?,"
						+ "\n\t" + "		desc = ?, "
						+ "\n\t" + "		u_empno = ?,"
						
						+ "\n\t" + "		u_date = CURRENT TIMESTAMP,"
						+ "\n\t" + "		u_ip = ?"
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND atclsno=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY241 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n\t" + "	AND atclsno=?";	
			
			
			// Database Connection
			conn = service.getDBConnection();
			
			for(int i = 0; i < rows.length; i++) {
				// 입력 
				int iCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					System.out.println("# Command : 저장");
					System.out.println("# Query : " + insertQuery);
					
					System.out.println("# Value atclscd =" + rows[i].getColumnValue(colNm_AtclsCd));
					System.out.println("# Value atclsno =" + rows[i].getColumnValue(colNm_AtclsNo));
					System.out.println("# Value atname 	=" + rows[i].getColumnValue(colNm_AtName));
					System.out.println("# Value atcode 	=" + rows[i].getColumnValue(colNm_AtCode));
					System.out.println("# Value atdecr 	=" + rows[i].getColumnValue(colNm_AtDecr));
					System.out.println("# Value desc 	=" + rows[i].getColumnValue(colNm_Desc));
					
					stmt = conn.getGauceStatement(insertQuery);
					
					stmt.setGauceDataRow(rows[i]);
					stmt.bindColumn(iCnt++, colNm_AtclsCd);	// 분류코드
					stmt.bindColumn(iCnt++, colNm_AtclsNo);	// 분류일련번호
					stmt.bindColumn(iCnt++, colNm_AtName);	// 세부적요 명
					stmt.bindColumn(iCnt++, colNm_AtCode);	// 계정코드
					stmt.bindColumn(iCnt++, colNm_AtDecr); 	// 차대
					
					stmt.bindColumn(iCnt++, colNm_Desc); 	// 비고 
					stmt.setString(iCnt++, iParamEmpno);
					stmt.setString(iCnt++, iParamIp);
				
					stmt.executeUpdate();
					stmt.close();
				}
				// 수정
				int uCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					System.out.println("# Command : 수정");
					System.out.println("# Query : " + updateQuery);
					System.out.println("# Value atname 	="	 + rows[i].getColumnValue(colNm_AtName));
					System.out.println("# Value atcode 	="	 + rows[i].getColumnValue(colNm_AtCode));
					System.out.println("# Value atdecr 	="	 + rows[i].getColumnValue(colNm_AtDecr));
					System.out.println("# Value desc 	="	 + rows[i].getColumnValue(colNm_Desc));
					System.out.println("# Value atclsno	="	 + rows[i].getColumnValue(colNm_AtclsNo));
					
					stmt = conn.getGauceStatement(updateQuery);

					stmt.setGauceDataRow(rows[i]);
					
					stmt.bindColumn(uCnt++, colNm_AtName);
					stmt.bindColumn(uCnt++, colNm_AtCode);
					stmt.bindColumn(uCnt++, colNm_AtDecr);
					stmt.bindColumn(uCnt++, colNm_Desc);
					stmt.setString(uCnt++, iParamEmpno);
					
					stmt.setString(uCnt++, iParamIp);
					stmt.bindColumn(uCnt++, colNm_AtclsNo);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				// 삭제
				int dCnt = 1;
				if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					System.out.println("# Command : 삭제");
					System.out.println("# Query : " + deleteQuery);
					System.out.println("# Value : atclsno " + rows[i].getColumnValue(colNm_AtclsNo));
					stmt = conn.getGauceStatement(deleteQuery);
					
					stmt.setGauceDataRow(rows[i]);
				
					stmt.bindColumn(dCnt++, colNm_AtclsNo);
					
					stmt.executeUpdate();
					stmt.close();
				}
				
				gceRes.flush();
				gceRes.commit();
				gceRes.close();
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
