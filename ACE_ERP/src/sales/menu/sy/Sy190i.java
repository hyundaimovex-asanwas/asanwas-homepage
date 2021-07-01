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


public class Sy190i extends HttpServlet {
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
	
	public void command(HttpServletRequest req, HttpServletResponse res) {
		// 업무 구분 파라미터
		String proType = HDUtil.nullCheckStr(req.getParameter("proType"));
		
		System.out.println("############################################## " + this.getClass() + " Message ##############################################\n");
		
		if (proType.equals(HDConstant.PROCESS_TYPE_SEARCH)) {			// 조회
			select(req, res);
		} else if (proType.equals(HDConstant.PROCESS_TYPE_APPLY)) {	// 저장, 삭제, 수정 
			modify(req, res);
			}
		}
	// 입력 , 수정 , 삭제 method
	
	// 조회 method
	public void select(HttpServletRequest req, HttpServletResponse res) {
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
			
			/**********************************************************************************
			 * Command
			 **********************************************************************************/
			// 검색시 조건
			String sKeyWord = HDUtil.nullCheckStr(req.getParameter("sKeyWord"));
//			 dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			
			switch(dsType) {
				case 1 :
					gceRes.enableFirstRow(ds1);

					query   += "" 		
							+ "\n\t" + "SELECT " 									
							+ "\n\t" + "	envicd, envidesc, envivalu, envibigo "
							+ "\n\t" + "FROM "
							+ "\n\t" + "	SALES.TSY190 " 
							+ "\n\t" + "WHERE 1=1 "
							+ "\n";
					whereQuery =  "";
					
					if (!sKeyWord.equals("")) {
						query += whereQuery;
					}
					
//					테이블 정보 init
//					가지고 올 테이블의 컬럼 상태를 초기화 한다 
					ds1.addDataColumn(new GauceDataColumn("envicd", 		GauceDataColumn.TB_STRING, 3));
					ds1.addDataColumn(new GauceDataColumn("envidesc",	 	GauceDataColumn.TB_STRING, 200));
					ds1.addDataColumn(new GauceDataColumn("envivalu",	 	GauceDataColumn.TB_STRING, 5));
					ds1.addDataColumn(new GauceDataColumn("envibigo", 		GauceDataColumn.TB_STRING, 100));
					
//					 쿼리 실행
					stmt = conn.getGauceStatement(query); 
					
					stmt.executeQuery(ds1); // DataSet set
					
					System.out.println("# Query : " + query);
					System.out.println("# ResultSet Total Count : " + ds1.getDataRowCnt());
				
					break;
				case 2:
					query = "";
					break;
			}
			

			 ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다. 
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
			
			int colNm_EnviCd 	= inputDs1.indexOfColumn("envicd");		// 환경변수코드
			int colNm_EnviDesc 	= inputDs1.indexOfColumn("envidesc");		// 환경설명
			int colNm_EvinValu 	= inputDs1.indexOfColumn("envivalu"); 	// 환경값
			int colNm_EnviBigo 	= inputDs1.indexOfColumn("envibigo");		// 환경비고사항 

			GauceDataRow[] rows = inputDs1.getDataRows();
			
			insertQuery += "\n" 		
						+ "\n\t" + "INSERT INTO SALES.TSY190 "
						+ "\n\t" + "	("
						+ "\n\t" + "		envicd, envidesc, envivalu, envibigo "
						+ "\n\t" + "	)"
						+ "\n\t" + "VALUES ("
						+ "\n\t" + "    		 ?, ?, ? ,? "
						+ "\n\t" + "       )"
						+ "\n";
			
			updateQuery += "\n" 		
						+ "\n\t" + "UPDATE SALES.TSY190"
						+ "\n\t" + "	SET"
						+ "\n\t" + "		envicd = ?,"
						+ "\n\t" + "		envidesc = ?,"
						+ "\n\t" + "		envivalu = ?,"
						+ "\n\t" + "		envibigo = ? "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			updateQuery += "\n\t" + "	AND envicd=?";	
			
			
			deleteQuery += "\n" 		
						+ "\n\t" + "DELETE FROM SALES.TSY190 "
						+ "\n\t" + "WHERE 1=1 "
						+ "\n";			
			deleteQuery += "\n\t" + "	AND envicd=?";	
			
			
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
					
					stmt.bindColumn(iCnt++, colNm_EnviCd);
					stmt.bindColumn(iCnt++, colNm_EnviDesc);
					stmt.bindColumn(iCnt++, colNm_EvinValu);
					stmt.bindColumn(iCnt++, colNm_EnviBigo);
				
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
					
					stmt.bindColumn(uCnt++, colNm_EnviCd);
					stmt.bindColumn(uCnt++, colNm_EnviDesc);
					stmt.bindColumn(uCnt++, colNm_EvinValu);
					stmt.bindColumn(uCnt++, colNm_EnviBigo);
					stmt.bindColumn(uCnt++, colNm_EnviCd);
					
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
					
					stmt.bindColumn(dCnt++, colNm_EnviCd);
					
					stmt.executeUpdate();
					stmt.close();					
				}
			}
		} catch (Exception e) {
			gceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try{
					gceRes.flush();
					gceRes.commit();
					gceRes.close();
				try {
					conn.close(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			loader.restoreService(service);
			}catch(Exception e){
				e.printStackTrace();
				}
			}
		}
	}
}